Return-Path: <linux-kernel+bounces-336549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B5983C30
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B4F283ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BC3B1A4;
	Tue, 24 Sep 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pyemogop"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF18C07
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727154513; cv=none; b=ZyUjkVdRKvS2MM7G/4t1obxFlnRS6Qg4kbxFi3SwmBgmWvV4EpsYM7X78lQdNgnLQ4oFMiBlhfmEjaMFE6+E64EL6ZkNteCR4CmPuEp5kLryXAsbkMoj2+7mOaKQnwMF1McQgNHdNu8zyXOkf6znRpIGXCsP6yMpy2SGdiLJU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727154513; c=relaxed/simple;
	bh=+Se0YmtpYkQffroe0sGCjg6snNfdsJk3rURHye4TQFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuxMgLYK74lOE0ytsYjINzXsPbo/Spu71X2HGLhmTmW5gm0kWT4foh2LwJRLr4wHwcruNgKD5fGOERnwOCvuEszqJSaT+FencmvLpvmTAo6jLGqA/3ReIPxw4P8fhTNX9faIL4R9qyZWM/M6H/IMmbVkCnpOvqPXBR9J9ICXdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pyemogop; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3255620a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727154511; x=1727759311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5MHNXC48yAvUD19hWxguon66WOWFP3QfJz/MDtRd9k=;
        b=Pyemogop4eFHXYhF7YSLaUDAGItBGUlmo6Xy72Iz1xGijDRbX2XhephfH22j6JMFqw
         fOb+w1E1EnFnzUMZDL0oQ62JBtQ1vGEs3F5tdQit/jEh0eJfdSBb9Fm4hJ45g2RzQcbD
         EMAuz4hKo8lG0GQvgkV7zVGeQoedy92RlBYiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727154511; x=1727759311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5MHNXC48yAvUD19hWxguon66WOWFP3QfJz/MDtRd9k=;
        b=Jcdn0U3XbVkUvhkpShsmG3GDQSaxef3oj7YoH2Iv8naqE5Xp9s3dgWsYd9R+rIrbez
         hLhv3K9PDNXrdWqXU2Wb937I4Ln3pbDpk/9FB2V9NmHdEgxDiSEqFOi9ZcSoHknt+90J
         6JgGGn6BhnIFEBG2QctgOIpeeEbEScFSYRx9DYtRr9do+NLLK0tlzNidS3E3IzZODeUM
         S1LeJ/jBE6Dt2clGBG0TtfDVdp5VcZZDSg1pRiZtvNFMjqJ/Bi4P3mApQwaSkubdCu3b
         gSA228M/Br6Jmt+EacKedD2ZSkbyEsEkY/+jNAfclTCy5zAJ8/cTnpFTFjvxvkHLiwNS
         3XZA==
X-Forwarded-Encrypted: i=1; AJvYcCXawfwKld8XJSlNuSjDJqI1twrBXbKh8M5HSN6MZ7NvG0unn++kzuaFhK9F+Df8ow2tw6lrW+lr+jHDA0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbtWtNJQ9x9Nvvm8/hqVhsr0Xc/sa0K0P5523pB27T/b5UGSK
	FN3TXLyAfE9Er29R7bzoLuBTD9aA9/+Z4/3dVJshYWDKwuYp+8YbLvNUld1g2w==
X-Google-Smtp-Source: AGHT+IEUQCKq2YvocXT3vjh1QvF28Z4378Dk8hrmVQ+3NgqUNYvbKV8EmP1Gm27lAJcZAGAzo5qtxw==
X-Received: by 2002:a17:90a:8401:b0:2c9:e24d:bbaa with SMTP id 98e67ed59e1d1-2dd80c960ddmr16672219a91.27.1727154511383;
        Mon, 23 Sep 2024 22:08:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef9354csm10297994a91.50.2024.09.23.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:08:31 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:08:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: do not export const kfree and kstrdup variants
Message-ID: <20240924050827.GA676153@google.com>
References: <20240924050351.675925-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924050351.675925-1-senozhatsky@chromium.org>

On (24/09/24 14:03), Sergey Senozhatsky wrote:
> Both kfree_const() and kstrdup_const() use __start_rodata
> and __end_rodata, which do not work for modules.  This is
> especially important for kfree_const().  Stop exporting
> these functions, as they cannot be used in the modules.

... and of course I forgot to commit the kstrdup_const() part.
Let me resend.

