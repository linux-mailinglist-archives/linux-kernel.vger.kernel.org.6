Return-Path: <linux-kernel+bounces-335235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7497E2EB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97111C20BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286154653A;
	Sun, 22 Sep 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+5CF22j"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9529406
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031489; cv=none; b=JaB+Uiq/XFhmKwE6fNs3oRw2rFgyWszGc4cf20vpo41eR/BQmA6sk8+5VGsTWl85529gdTvUjnW2F2f8Jt8u1poW39mPvdcyL2XMd8chOZzwxZdHHMVm2/6xNUYFhMO1uN+0uFz8aW+M1FdNo+pdA1qtD9O/P3FT4tI+Fp8D4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031489; c=relaxed/simple;
	bh=Yo1p9c3D7RZVeVPDG9rUuD/rLgihvhItphgmie2b8C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqPy5rgJPq1ruyNu5Cw0LI4aE0owGxBEl9diZ58RINqB0fpgQ/HljJYYcc+1798s8l8tei1sWJI+cGbM4NjrKRxt9LZaJYdt316jUpGCCxQ1ucp8Fz+GuUghsGFkNkmBy+FvozU8pVxW/z/E8ldoJngch+FRJaSgwuUCNnfyT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+5CF22j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso46707865e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727031486; x=1727636286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VtGjd1R3UG9yqI9eG9VC/AHCt3Lp0guUAhfU5piwLw=;
        b=W+5CF22jiiRwI8IQfBPurLkgStf+55S3usxMB1Ub0xW6V9Tg2pnoMfPz14zPNzVbN9
         83LmQMMdOcDfrPNxUKaMqjX2KCscd4O5kVKGpsHMEvwFXaysF5OPzoPDDi1sdfP+12CN
         HhD31ADZqUjcuF0bgKEtROyaZcbrnimyDpmuOgDvbmz0fBaYYfH9dGs30oCgKDQHBD+8
         VOVFHThLt7rZYDoaGIlQAvQkFcpueL/EHmRBt0QI7RFkjDH93w8ROk8c6aGL7OL0ILUG
         g+Zxd/whfZlDzF4bkU/kJKQ1in2F4/bCkOtnqqTxvqujMtuq8dy6UqsKBXlzX99CwU5b
         hiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727031486; x=1727636286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VtGjd1R3UG9yqI9eG9VC/AHCt3Lp0guUAhfU5piwLw=;
        b=i/nE+VCZwPdE2pT4fYt7PBNMB1LtDEpoRpm8MJI2uh+N3iSfz+hhpLTAX9plOKe/jV
         j+Kg9VDIhGUaqDY2l82zj2nna7USXibWhA3zjUDFFj01XZsk0POO1clGwkaIgCIX7dBF
         WN7WMXAU0Vu/yPEsyQxB1Es8tZ74MUNiT72GfQRwnaMManMJ6jber81y2wXxg++aHs+U
         8sZiofxCQVly+6u4+sOAi5BfpEvlRPRQPTOHQWeai820SsapB93Q4fREbkKYC1ApiIJv
         JWE52UY0DGmAgElpgH1RGtpyrnltNxp8rp30xqOyGWBQvx+fWBVBMCvHNkaYWwFGPB+f
         WKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVy3IQEwMDpPZRY0hU/F9WP4vK81IwTQ/Dqs9CCaX6S2AoWgszc6awPwPyjuQZtJEMHfmyQnKRblqPhgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dzA6FNvRNpvChux6a7UhasL/TyShaahDPz1DiBd27SQvGKoT
	6P/6gzlNExbM4w5cSC/rlIXlrbCULkx74Azcq1xB5j3iGFD/+iMW
X-Google-Smtp-Source: AGHT+IFOkUOXhu/KYBBc+5T7xNHZfam5jpYiqdzWrAJ5+ZIYsI04V+s8TZ69VXJOJUCBYHTGGUrPCQ==
X-Received: by 2002:a05:600c:1908:b0:42c:c8be:4215 with SMTP id 5b1f17b1804b1-42e7abe3ef3mr93411025e9.4.1727031485979;
        Sun, 22 Sep 2024 11:58:05 -0700 (PDT)
Received: from [10.188.212.131] (cust-west-par-46-193-35-178.cust.wifirst.net. [46.193.35.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0622sm22718510f8f.18.2024.09.22.11.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 11:58:05 -0700 (PDT)
Message-ID: <eb3000aa-6bfe-484b-8717-5d98681f6230@gmail.com>
Date: Sun, 22 Sep 2024 20:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: use kmalloc_array
To: Tudor Gheorghiu <tudor.reda@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Linux Driver Project Developer List
 <driverdev-devel@linuxdriverproject.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZvBX_mugFRQHMq1r@MacBook-Pro.local>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZvBX_mugFRQHMq1r@MacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/24 7:46 PM, Tudor Gheorghiu wrote:
> use kmalloc_array instead of kmalloc with multiply
> 
> Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> index 408616e9afcf..a0f29fab3dce 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -117,7 +117,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>   	/*init xmit_buf*/
>   	_init_queue(&pxmitpriv->free_xmitbuf_queue);
>   	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
> -	pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
> +	pxmitpriv->pxmitbuf = kmalloc_array(NR_XMITBUFF, sizeof(struct xmit_buf), GFP_ATOMIC);
>   	if (!pxmitpriv->pxmitbuf)
>   		goto clean_up_frame_buf;
>   	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;

Hi Tudor,

please improve your patch description. Better omit what you are changing 
as this can be seen in the change itself. Do focus on why this patch 
makes the code better. Please use a full sentence starting with an upper 
letter and ends with a ".".

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

