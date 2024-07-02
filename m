Return-Path: <linux-kernel+bounces-237999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E019241EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C26B27024
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF81BB6AA;
	Tue,  2 Jul 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1MgkRna"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407D1DFFC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932923; cv=none; b=UC/JtA16ZPRWqj+FdVkmQxZrGYCeknzDYZn2Ch6ZtxyMPjKR7AB+smylOQxebwzTLFZRwxQdRtiVku03r0ndmUe5psICz4v7zetL5QYAax5DrAROW3oscAVA1WJjBpIE5NentIVj92btEr56yjAbS5bpH9dLKA0wrEsaw5Xl0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932923; c=relaxed/simple;
	bh=jH+Lkew5T74jtahE7F5PBiqrk/aGUdkPBbT0nuPKoj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrcA9WM27Wc7+CR63v7e2ZAaBqgWSbZ34u4US/ouEDM4ygirFDjSdV80Iij6ORYTXd1bYRvH6yI3DK2bt4QlpkadIHQ1zjjVRL1o2MdTPmAHyuCsCgm+adJB1M/L3PNczXd7L990CSfSsMziGFbXoR+D7K2MpmTx+Q77tOiuVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1MgkRna; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so26414385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932920; x=1720537720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3fdPNVgQgZKaJpq3dIGlColijB/tubuUQxMWr4wkDU=;
        b=J1MgkRnaml70Q3XJHV4fGT9G5w+qG+bBlBpS9lU5elOFAcPbpnqXwRn1JP37Ty2sCK
         9TR5ioauZG4b9E/8jcdXhpeEwG/UOLfjxm1dg8s+qWUeA9TaJA/e0FlIQ++EAACiL0sl
         4UNPHNh0w0dznEAEhf0iyvD4EGqKFKdO5yYovVrHuWMr4A3Qn6HGifzEq1A01Pv4LN1c
         nLUDosMLBtpTUslTH549UR79rBR/rf/i3vRIGDUPknd0J6CJ/stoWq00Go6yZLrcOJm2
         J1o6eTZ6Y17COtZOxXFhWlVt9IlganVRsnW/jHXg2SmoKDf1lazT0wi3By5PyPnmmxua
         xFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932920; x=1720537720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3fdPNVgQgZKaJpq3dIGlColijB/tubuUQxMWr4wkDU=;
        b=Qu/16/pcDGV6mLmKK7lPg8XJXPfPB8EIvuiG+iSzQiJcWj4YvUWxSJhP0hl6jAYUtw
         z5w/jJsh8eBKg/TrvGTtpky7IZHysItG84pXOE+ees5dyi98KGsivQLg64Tz/Dn3Mw/9
         Ly3SEnFRfvKUvRmKFIQlCmfdd5AagiLWn/fsjjOHnctQL5X/SMYRKCmu+Ku8N1PxhBir
         R68XxF2tw7U5jLhC0voaGYhv4kWaGSj4NiZS6jsiA1GlEkVC6Kz1cARo80xSy2MoOVRW
         zjDM9urZpkVpB8nU2+DJ7nszzUm31t39AKF1kJsHvEh3rMLLMR5xeuDgG3cdJ1lgRS/p
         BlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCjBjy2sXFD25uyZZU7WOHG75+VtoTD+KsyoXlsv29Gh0/p5VfrQMKyhnxtsaa9ud9SnQyrv3xVeodlUw/hNzMIslg/9cHNLBZTrwZ
X-Gm-Message-State: AOJu0YzaNB873yml9kFzq1k4CHH5hSVHJOwE6Xug+B11V4ByTUANEFAJ
	5EUjuZEi7uhTlBzn3KhWB9t42j7rh9Nu/qSSrrVELROCo8qhNS35
X-Google-Smtp-Source: AGHT+IEEc+o+yax4KgqPy6+aEAG5lUW7O4Rfq7d891iyb9LsSMrtwrUsX04P4jtPpPwhNv+S8YJcjA==
X-Received: by 2002:a05:600c:41c6:b0:424:7895:dd45 with SMTP id 5b1f17b1804b1-425798ad8bemr77214565e9.17.1719932920360;
        Tue, 02 Jul 2024 08:08:40 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e12fcsm13456402f8f.48.2024.07.02.08.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:08:39 -0700 (PDT)
Message-ID: <ba408a65-9179-4868-a1ac-44b936ee778f@gmail.com>
Date: Tue, 2 Jul 2024 17:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: ipu-v3: Removal of of_node_put with __free for auto
 cleanup
To: Abhinav Jain <jain.abhinav177@gmail.com>, p.zabel@pengutronix.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org
References: <20240702144836.1001916-1-jain.abhinav177@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240702144836.1001916-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 16:48, Abhinav Jain wrote:
> Remove of_node_put from device node of_node.
> Move declaration to initialization for ensuring scope sanity.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/gpu/ipu-v3/ipu-common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
> index 71ec1e7f657a..f8cc3f721d2a 100644
> --- a/drivers/gpu/ipu-v3/ipu-common.c
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
> @@ -1150,10 +1150,10 @@ static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
>  	for (i = 0; i < ARRAY_SIZE(client_reg); i++) {
>  		struct ipu_platform_reg *reg = &client_reg[i];
>  		struct platform_device *pdev;
> -		struct device_node *of_node;
> -
>  		/* Associate subdevice with the corresponding port node */
> -		of_node = of_graph_get_port_by_id(dev->of_node, i);
> +		struct device_node *of_node __free(device_node) =
> +			of_graph_get_port_by_id(dev->of_node, i);
> +
>  		if (!of_node) {
>  			dev_info(dev,
>  				 "no port@%d node in %pOF, not using %s%d\n",


Hi Abhinav,

1. You sent this patch twice.
2. The __free() macro removes the need for of_node_put(), but you kept
the calls to that function.
3. If you are aiming for a code refactoring, do not apply the __free()
macro to a single device_node, leaving the rest untouched.

Best regards,
Javier Carrasco

