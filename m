Return-Path: <linux-kernel+bounces-197892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 668328D706E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB2B1F223F7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A985152197;
	Sat,  1 Jun 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIf4uzBz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD5A94C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717252052; cv=none; b=aN/eLwBfoTw+VjgI5aPoUcjqcvVhYIdMOXzYOSzgDyuBL8dpmuaMxKsnDi8D40m+XlDkznI35Oyx+UR0E5rHQXt8PSRSEx6ePEl52bPh2OJabIEYyUvwDMPmSD7Zo/cnJ7ga8g0MorDX2ivDZFeTGq9VRJqVHT+xstYUgoHztNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717252052; c=relaxed/simple;
	bh=xTU0e5/IlLVMuoj82/8I3hETYtxgCRl8P/CVmfvLsAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6zgoMjmf/uFsGi65k/KzvA3LTTmFQS51gvtwoSngOsbK0PnWIufOBUE7aA32keVarpnwno430GmNciuhlC/wx6rWN+t2DqEBgpn0kYZK/QjclA8IgttGID2fznIugPEDVUmUwcLMwVG+ue/2xj48djdPi9DTV6rZ+plwtZI/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIf4uzBz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-579dd99a4acso173763a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717252049; x=1717856849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKjdNbaQgpEtIGRdS/gMdImnNGt/YsqABekgtyYfmkQ=;
        b=TIf4uzBzNMeNsftERCeQ3WDaJ2S0LpfyFRxh+qhV5X4Nu9lgpX0SbJpgXC9aSPWkjn
         WjT50LYLGopu4KpTJOrsJ8JDvDNcUlhznChneNy9edT77TwH9aPH+Tw60F3ORl7vSUMT
         NK3JZivs38bo3YDWn4IXbUcooZOr1pV/R/lIiLC4JZjIddRe3QhAijz99ZmZwib3vRjQ
         NaSG1eHPyW9zzMmk5O30ljsbBkKX7lYVPb8pAdElXOx0j/co36tOWNvp5PmJLirfx4AP
         avIxdzUezpy6NfId4cUiu2Z5SUKZBSYpWht0k4SW9+d2nPR9QE5G+a+jfeSdOGmuxn7G
         Q7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717252049; x=1717856849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKjdNbaQgpEtIGRdS/gMdImnNGt/YsqABekgtyYfmkQ=;
        b=ECCOAliXDNEbbkSh/rQiLqoVVj2phMDU+pwv6sleWMrNLKaRYAuF6wiRUaR4cYhJ/R
         VIaIABfnzjaw4oE98bq8/p7Rh5M1O/9UR7YClt5gzwLQ99NY4veZ5uXv7ZaVKafJZ6h5
         fry6X49GJnc/h/N6mjaTZZVdqJ9PBm7Hrr9UjlG+nLVRm10UnHUEWGGrEPTJZqhjHsJD
         z9tIphW/kkqH0B1M8VDrhPHE6zr6XF1yFYh0wXGr72sklEQQglZeccg5oTlNjLxA8TLm
         FIHRiM9uFTgxNQOX6YdIYUwrFtrMU0qlxQPvcw4KMg3X9LKZI0oW7ukhJv8BVGitB8XC
         IHSw==
X-Forwarded-Encrypted: i=1; AJvYcCXG8m7GHwFGD5yW0k8vwETXY8cRgAWZyU1LfMGps1SmlsJzTWbr2gGdZHp5oOJhnA0pLclblf/+W2oRReOOtKeqO/qNV964XQc6wjW/
X-Gm-Message-State: AOJu0YxwZGCzzqK2sBaAk+bmjL6iilpoW+f8objmzhWXsvVnao7L+QrD
	QW2h4XkS/vIarSgxOZ7kjYPXs9f7P/faMkt0mj0raTcO37yxcAMG48UHgg==
X-Google-Smtp-Source: AGHT+IHB34M0BPvyG83Fnaa1gsOsFkNvB5GBcGcQKjWrzvhJhz/T0z3hba6+r/N1lagsaauyNMNvuA==
X-Received: by 2002:a50:8e59:0:b0:57a:2547:836f with SMTP id 4fb4d7f45d1cf-57a3643a410mr2882497a12.2.1717252049162;
        Sat, 01 Jun 2024 07:27:29 -0700 (PDT)
Received: from [192.168.0.102] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb4a4esm2266967a12.21.2024.06.01.07.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 07:27:28 -0700 (PDT)
Message-ID: <4a442f07-7718-40d6-b98c-256a5e550aa1@gmail.com>
Date: Sat, 1 Jun 2024 16:27:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: r8712u: remove unused struct
 'zero_bulkout_context'
To: linux@treblig.org, Larry.Finger@lwfinger.net,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240601131611.52441-1-linux@treblig.org>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240601131611.52441-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/24 15:16, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove struct zero_bulkout_context as it is unused.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
> V1 -> V2: Reword as per review
>    
>   drivers/staging/rtl8712/usb_ops_linux.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> index b2181e1e2d38..0a3451cdc8a1 100644
> --- a/drivers/staging/rtl8712/usb_ops_linux.c
> +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> @@ -26,13 +26,6 @@
>   #define	RTL871X_VENQT_READ	0xc0
>   #define	RTL871X_VENQT_WRITE	0x40
>   
> -struct zero_bulkout_context {
> -	void *pbuf;
> -	void *purb;
> -	void *pirp;
> -	void *padapter;
> -};
> -
>   uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
>   {
>   	pintfpriv->piorw_urb = usb_alloc_urb(0, GFP_ATOMIC);


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120

