Return-Path: <linux-kernel+bounces-337827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87867984F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80CD1C21952
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19DC8FF;
	Wed, 25 Sep 2024 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b9dI6Exf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1404A18
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224646; cv=none; b=E3cl+9yLl5AZp6JtdOcKDu4GK9soTc+G0Hjfw9lfD7SEgJ14vG0ScOTpEn/Jbkwtf1DlGC2pdkp1zGBByGCzXKeyDj+tBCqKU90EEJMB9KjoC8WrO45PrT8EMP+6DyNdfTGlLB+AShC0xUOQ4dOPaoX6uh9WDKiHtifAjXRrOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224646; c=relaxed/simple;
	bh=Ne4vSr3cvYtPVxEhHNFux7VOXieBzrt1kuOruhtxSL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmFtf/B9PVPVw2x5P9L31wDCRzmE8sQ9j4fy2m+2ng1Pz5jz/0xDKy6qg7NCszfB/c8w+ihvF5XgXcE7cy2KCg5dgPgIXX+uRagCOCt7uFW/+SDq2g7prrvc+QjV1nBq5Ndg1WOlot/uZe1fTNuU4nrveHkE5susHvmrqlKYgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b9dI6Exf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e053f42932so1383809a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727224644; x=1727829444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qi+Ew/rpwQdNekWtvCMQfio8DRksEPNbxq/gVYTc9Bc=;
        b=b9dI6ExfYHghZcb+6aNMSYMdVeecGzHlQ7pF5VDSD4FfPpELvS2C/+XGVYPQbGijtM
         tORy73aiMoCF4X66byl96MkEzenZg/Pu3YCNZm6CgXFkjXzPL4ors4dXgQxC7gqkYY12
         SahDw2Gwx2h07VUSn3plqGYpJwTRw2mhTxDTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727224644; x=1727829444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi+Ew/rpwQdNekWtvCMQfio8DRksEPNbxq/gVYTc9Bc=;
        b=QK94IDyDFhfib0IGy5W19PrW/a2qJFgbCjNxw4B903hTKGffcdoyyxBddX6UgoUm5a
         eFjig21Fx+l3Z4KI4t8F7HMZxy+AkCTaBaOhse4I7DmmratoAOkwOkFhrfJrvu2D6q6y
         sfrh85ISy5TqSh7EbDulbplWk/2ShLCNvUpv84VIs7jomAD9vo1Ofzc1i0wXj4xDa1rI
         mKsn3wwLWew3EJhBpl4QRt41EWpMq8NTJZTrv0dq46edBdissC7Do+1iYt4E/XeLVhMo
         gO5ncpTT84js0OB/3DqL8gb3hEyNSIErDgj8EARblhyVxW3yRl5TgZjaiJ6fFrVcKhyE
         jFvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAFBt9gpRut91BgPwpB3qQSgP6jnFjqtAs+GuU/YG2h65Gsgi7YOLUIkC/Xrd08C2IFbpcFxywwwQJuKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzyN6VwJvtkwg75MVNE0xT4GWqh8Jh3dN/koCvJYjyu2oBgM9
	NCQF/Xu21XgEjboy7+KIjVUdiZXEz7w9eNXmWXpehJozcbDUsg7Dz0KWlw3IQQ==
X-Google-Smtp-Source: AGHT+IGHpbtyH6wG5q8wpr8glm0LmNDVojnlHAVCXzzabVBkw4UaRXRI6IpMn0gx/0I09JmQAN/eSw==
X-Received: by 2002:a17:90a:cb97:b0:2d3:d398:3c1e with SMTP id 98e67ed59e1d1-2e06afd7775mr1014848a91.36.1727224644075;
        Tue, 24 Sep 2024 17:37:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:234f:c061:7929:9747])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058a0899fsm1409293a91.0.2024.09.24.17.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:37:23 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:37:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chris Li <chrisl@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240925003718.GA11458@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com>
 <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
 <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
 <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>

On (24/09/24 11:29), Chris Li wrote:
> On Tue, Sep 24, 2024 at 8:56 AM Chris Li <chrisl@kernel.org> wrote:
[..]
> Given the merge window is closing. I suggest just reverting this
> change. As it is the fix also causing regression in the swap stress
> test for me. It is possible that is my test setup issue, but reverting
> sounds the safe bet.

The patch in question is just a kfree() call that is only executed
during zram reset and that fixes tiny memory leaks when zram is
configured with alternative (re-compression) streams.  I cannot
imagine how that can have any impact on runtime, that makes no
sense to me, I'm not sure that revert is justified here.

