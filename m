Return-Path: <linux-kernel+bounces-574737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4DA6E945
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F45B7A2DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B01A5BB3;
	Tue, 25 Mar 2025 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmpYi3TW"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74669149C6F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742880256; cv=none; b=NQrhCMXRpXON9mZFIc7z/cbca3qCC2A48ODlGWWvHVmOxChikX0WSjLJJY/HLa7p0KtVQ8MhXLIaDqGP4NHukfV7QfmbVxAUTOLGVe4faUplJn2GED/7dUNEYn0+/KJA/1CcZ1Nv9CpIQpRijiAVWwwzHNLJmv6c12QdVTmPhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742880256; c=relaxed/simple;
	bh=U1LL4WJAZIJ89vLdznrtpX+5KLf7e1GM2Xj1wXzCdtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8iyz8GDcaieT5XFWgwQm/vlyUssGyAaF6FoKL2hOBiDNZxrZpK8kcesfKh6HIyTaV8Y9wFxDLXCjkAjx2xHFV1S8HXGgNfAs0MYVlfwQaCkPoSw9hz+d5CX0nq3MfKm4pS5ZZA/u+iV5Y2efo/URHfZvurdfXhRCr8tqagpSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmpYi3TW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39727fe912cso1818221f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742880253; x=1743485053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRaX01rk00WPEakg96TUsbbt/xlfsHtpFaH1JzeU0zA=;
        b=VmpYi3TWk+jpM8Wi2NNDlpYiZDF0ezgW0tODCZIzk/fpHk8MCh0Jr/2rgWifZs0Wvv
         OuH4uBWv1lcfKbCSSLDjoZ/EXcgypivfx+Cc8KbmkHS5D+7QdhT2ZWMahDV3aQYP/kOy
         x8mImux50q1NoPC5Qbo2EcB05FCtoARJ9PBI7nNGWLHp7OA6VAumrx7uIS8DNtZtoAvO
         6C+0HGdprNsgKl1E/kccPjwUdLBbeevO1YjuQYAq8y6tISJyPnnmAjFy/mcKkOanLczT
         PXn77w7tgVGXaG3octvQFtJ3FKrzjdJp8UaIA1j0uWswPP08WQxc9aJUkwBNKs0nSzgc
         YSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742880253; x=1743485053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRaX01rk00WPEakg96TUsbbt/xlfsHtpFaH1JzeU0zA=;
        b=ZBQbdHvvsX091ehAAhN3HgAFN8jPHjg8M+e0O3fJqUJ/leG3oDvXbbkL0Z/dHrufDa
         XKcYVULYTxyO0OG2F8U1GQVSLs+zaOtmdkZTMltghZPXBUnrofhLH28UEOv/8RLSBWn1
         /O0JvsmpBINTbWalSF9brgyX8IbRx/mdsyDKO+ZbSIGgUMPGIlOtfgqbJ1TwylrSHT7w
         ntQzrmwyx4dQp2dZ4oxFo2ep9ALHaQWHdxA0T5w93JcqgDqdKtSJO3YWDo12jpy8a0ty
         ICSz1aTQokJnCEV+a88bxO1v0/+SkkcvWx0NhjoBsgqn/xIu3WRtpKcm8sQ/CyLkw2kE
         u6hg==
X-Forwarded-Encrypted: i=1; AJvYcCVj3SoIpO7hr2hzUadmtQKZNYgcyVV8BoBdGp5ixV75cQ5QqrAZNVM7RY1BdmdL+Ks03ixIiDQZEsM2PRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOaBTcnovRowtn5Z2XYe09vc+g7nCL08BIIfIDT3RpRZc9aRj
	EKJyTVgLyIHZbunBU8OYvUceKd2awbz1AiFONjk4W4uZ592fpamZh3Jh/XxCx7U=
X-Gm-Gg: ASbGncsxEbAQ+8ib7HVzeXb3obZ2CDyIrCwN+MW+VMgt735idVdo18znJMd5dI9srGg
	uCeXptdDYa04xav5AW9+wpXDcBR0qg72D/jnlJrsyqxX8IrxSHXMzxlkWZuXuW6u9eZP60ETOto
	moCaijFp/pBhFoU/TZb3fNS6OF0kAaVpXHqyftAmo5zpqpgp/HmCXmaCUtHAqrbxUEUO+cJr+7O
	butJNvUpR4E78qMCG6tOKfbKhyfD8z0TMYJ7L6iwQ8BfgVa3oM/POm0wzxSJns9pUPuD7PRvW2w
	p5xsbHL49+Ocogm/u2JVo77MXeIIJHus9sb+/ghfsSjV2C+R9g==
X-Google-Smtp-Source: AGHT+IGhJFT5J/KwH8YUA+D+cVvMIB7Ufysg2jrGmY/r3iS6hExYGRjjaTE9rL0aducAMyN8z8NLzA==
X-Received: by 2002:a05:6000:18ab:b0:399:737f:4df4 with SMTP id ffacd0b85a97d-3997f904f05mr15756662f8f.28.1742880252602;
        Mon, 24 Mar 2025 22:24:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fceb780sm143518775e9.4.2025.03.24.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 22:24:12 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:24:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>
Subject: Re: [PATCH] workqueue: Fix incorrect error return value in
 apply_workqueue_attrs_locked
Message-ID: <9fc752f5-239d-4734-a437-77a3bccf74ec@stanley.mountain>
References: <20250324090748.753195-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324090748.753195-1-ye.liu@linux.dev>

On Mon, Mar 24, 2025 at 05:07:48PM +0800, Ye Liu wrote:
v> From: Ye Liu <liuye@kylinos.cn>
> 
> Commit 84193c07105c ("workqueue: Generalize unbound CPU pods") introduced
> a change that caused apply_workqueue_attrs_locked() to return error
> pointers using PTR_ERR() on failure instead of a negative error code.

PTR_ERR() does return negative error codes.  Unless you pass it a NULL
pointer, then it returns success.  Or if you pass it a valid pointer it
returns garbage.

> This caused unexpected behavior in functions that rely on the return value
> of apply_workqueue_attrs_locked, such as alloc_and_link_pwqs().
> 
> Specifically, alloc_and_link_pwqs() expects apply_workqueue_attrs_locked()
> to return 0 on success and a negative error code on failure. However,
> returning PTR_ERR(ctx) instead of -ENOMEM led to incorrect error handling
> in __alloc_workqueue, potentially causing system instability or crashes.
> 
> This patch ensures apply_workqueue_attrs_locked() returns a proper negative
> error code (-ENOMEM) in case of failure, restoring expected behavior.
> 
> Fixes: 84193c07105c ("workqueue: Generalize unbound CPU pods")
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bfe030b443e2..8ba679d9b566 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5363,7 +5363,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
>  
>  	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
>  	if (IS_ERR(ctx))
> -		return PTR_ERR(ctx);
> +		return -ENOMEM;
>  

The original code was correct and the patch is wrong.

regards,
dan carpenter


