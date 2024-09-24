Return-Path: <linux-kernel+bounces-336595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F8983CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34651C20B89
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42477104;
	Tue, 24 Sep 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J7doQmn6"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5073451
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158504; cv=none; b=FzntNY+T9dI2aO2L58YNjP2kphmBBtyQp/sjUbnU6CIXIO7SGZ+7FwJPxNtjJkbtk/6MkBglD0Ulh+npSAGMUyFaf4893hpJO8BtKpunmZ7f3vo4YgGHBk7KXv5EaDbHSrMs7FN/t59TRv650MEjC5wNL8nn/sE2w76SV9VVNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158504; c=relaxed/simple;
	bh=FNbNcB8f+tO5fv0FVbK78z3vxivw0a6jAiWoYpf/VjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIrvpKSCM5JJufKrXssaANPXOsmFWyTleUatxXi+I81iDBhGDWzST5jcyKjfbbWODg87rHgva9QptUCu/59EucyH48SlkjyVHNkzLXOTiEI9L7OC6F8akHid+1s0Mh4an8O4PYIwcLGMsvXXRMUBYnEwfbQHEU5ToGrmv92T2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J7doQmn6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso4049974a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727158502; x=1727763302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/cIbiowMQaZoW1B5fHApBkUYwv504pPWS+xmmpAlNg=;
        b=J7doQmn6/RwIwVS7kpifMIe+BcwVXoGvmi5XXNLOPDqcrv4T6WlVDhVk6MYToxa1TY
         WWDd+Vj6MUSWbMqYr6rnwZIG4Z7czEO0XesZcMECIyO1TljqXotB2ipJ0DXGTd+e05dH
         T3jzw9+4AAwnUExkde2590Gc/EQaH7X/pu75Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158502; x=1727763302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/cIbiowMQaZoW1B5fHApBkUYwv504pPWS+xmmpAlNg=;
        b=NBXTk7ooflP0saMcVz2/Snemf7cFkqOnVeRQrjLJGKN8I3FrHrVPa0VQcKOD92IxV8
         DgpvBJlVtulSehGR+fnOkUJHtETbSj3Iwv913onzneLYObcrq/X4IT6U/TNsaFE/uaFH
         LXu1m0M3BFfvK5YkCKCWOFKiUlRQnyQ003e71CuvvDRJk54i2Mxiqu+PxSjh7eL6W6Wv
         l/dMr2R746hpjPsd5233Dy0GZDdz1CuOxpL2ofBsw7XZauf4YGN44O5yU1H2Jk+q2C4E
         VuCqO5YXcOPuRQPslAyVa0avpS/2WJofE7fMoQdDkg8VvIzlcioZAChyKZgf9yzWS4eO
         NSCw==
X-Forwarded-Encrypted: i=1; AJvYcCX2P04/s8jk0Ivb0cTYc0C2uUEfKTM7iACEKk5pWFqT7UXT4Wkui9RknBWPkBZEcRAV5i8GmoFFGI07HbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DLoJkbzMUkWvw1atmgTA7fHdaM57Zd5JVZNDGfOUxR55PlTv
	HEdPDFQFy5wOCknZeytsysWyAM7t4vFAvRashlR4lrikPiXVLLucH7gEwHPlLA==
X-Google-Smtp-Source: AGHT+IG3Q2wXTPV4cxmrpOoEx3KVRKDe5Gw67YmcTI+UzH3u/ksEVTI+nitdbcgUd86AZw+SMUcTBg==
X-Received: by 2002:a17:90a:fa95:b0:2da:5863:6f88 with SMTP id 98e67ed59e1d1-2dd7f40efdbmr18430824a91.11.1727158502543;
        Mon, 23 Sep 2024 23:15:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058f782e2sm649000a91.32.2024.09.23.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:15:01 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:14:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2] mm: do not export const kfree and kstrdup variants
Message-ID: <20240924061457.GO38742@google.com>
References: <20240924050937.697118-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924050937.697118-1-senozhatsky@chromium.org>

On (24/09/24 14:08), Sergey Senozhatsky wrote:
> Both kfree_const() and kstrdup_const() use __start_rodata
> and __end_rodata, which do not work for modules.  This is
> especially important for kfree_const().  Stop exporting
> these functions, as they cannot be used in the modules.

Just for linux-mm visibility, consider this patch RFC,
more discussions on this at [1] and [2]

[1] https://lore.kernel.org/linux-kernel/20240924054151.GL38742@google.com
[2] https://lore.kernel.org/linux-kernel/20240924054951.GM38742@google.com

