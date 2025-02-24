Return-Path: <linux-kernel+bounces-528458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB2A417DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9779718874CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14327242908;
	Mon, 24 Feb 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V23NIVsx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12E23CEFF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387223; cv=none; b=Doq5mvENRzR450Bqxgbf/1eTsE2k4HGaBMoJuYg2TYjN54IMWml7gkpoy96ItZ/ZWiuqJWFHYtVqZLvxSDB1TNksslRm14COFQmyVdjAhb1DOGpwkxp9ZdsjEvdHa0zY09NhQMf5+KHly0wc9a3SWfdL31GdfWeEI3+J1gUv4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387223; c=relaxed/simple;
	bh=B4rW0LmFwuWgrhKJdc74RygXbfuQEX7ztHygHDec2X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbgSMKnrK2ZiVMh9gEXVMbY4z7LGPtylZdVjwRS48fR+jQ+U8VmbFw/Ss0uj0AziIa8gMfEHKTPE+/dwkLiKLozWrqiuWXIk+qk7H1yu6smIyo6RNW/XofEBZFXUjg519tKfJikZ3uT3RyDqM9LYB+QyZbTZpFFHhKKeXnk+3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V23NIVsx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740387220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orFTzaaO5QTd6KFFusMvxg8e2uUesycrLGa/PjbseoU=;
	b=V23NIVsxhpUD0gnY0mC8rHdU+7avalZhwxWCPzuloyAjP7TDucmiMPgSpUlTYDXk+FWZ+c
	3lR9WPdgrC34z29gq7kSGyuwu0/FcbfiBw9K2jIjq3JvwmEKe0DD5pfS18YQRJRpwn3iYH
	ss89fvcNTladtgp4NwafRKi+N9ESapE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-oHITUcnNNi6A3OgLPRDhug-1; Mon, 24 Feb 2025 03:53:38 -0500
X-MC-Unique: oHITUcnNNi6A3OgLPRDhug-1
X-Mimecast-MFC-AGG-ID: oHITUcnNNi6A3OgLPRDhug_1740387217
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abbc0572fc9so253754666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387217; x=1740992017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orFTzaaO5QTd6KFFusMvxg8e2uUesycrLGa/PjbseoU=;
        b=FQsvwLmo8d96HhDCjP3lWv8Y0qpyQYYO9e/V/KNaMJ98KXis7BiK+9d2XMfyWtMH15
         ZNd6ofjzjF/Gf3SS2CduM37zan7VUOQ919JJY5gVTybTeCh+mpTtdab/cYUcBVJ80j0t
         woCo19dRr1VF+lRzd+FlCrDOJnD+F9oxrVhR/uI/edjtrWSVugPHsvdRlS6l2hDpA8ej
         Mp5vtav7+BP5m93Rx1JXNlc6Tf9s9bgP5kwJAxiI3HOt8o/PDit85/PWHZFsJb3muNf9
         fJwkd+FPhvM5vIAjzvFbBnmh833I9YbD526uUo4fcmoF5eVO5I2bMUt5AF/h6Bk3FTLD
         i3JA==
X-Forwarded-Encrypted: i=1; AJvYcCUS4v7f/nt1uoKcc/JSx15hK+PqX1uv7rLmlXSqLqaY+0Ut5/AScg+rkAYUR7qDOmLxylYittYyX/QXEkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYX55Cg/qZh/hF78mUUHoX+NHejAoHOSw0GA/wDZDNigFwYrN
	aOJo4fhhGBxelyC8hn2ALlBqbMnWDPlDAcu2DDIZcEceWmkkw5ZmnK3WFDnhTAB/V0WlB4pBbsY
	9upksdqr6DA7Wr6n68X2Ba6B3cOrinudshtqzImNWIQqtOJdGD5obvZNIdB2wMg==
X-Gm-Gg: ASbGnctBn6w4GYc7o/kQeerFtaWriPo3ispO+QkXvoLn29YZPKThqIxHe1odeK7t58t
	Qtfd35ubI8Ezg0r5r0qjT72MirX2OwaIX+fWdz4dCSgCM4VPTMhGeyZ0yjNiLjf0ZKWe5ekC94y
	g0/UTekyz/NtvjIhy12kfoxkCnBoNifeaEJP1Er3uKHEwkcpPXTpjkiapxLU1kKoM2ceOmOMhYi
	J7fotdS+tppCXlrZXotcS2fp3vz26jkQ4Ga/G4SI8sgtNCdgDIbqaFcOpTRWlyAEtimwhzgpQR6
	+a2c5tQyeSTXC59/J07Dqh5AgfNDWoCzpboEDjdZsg48kvB2gKhdpwdo6OzsjxOlshvMkOpOATp
	gfbUo5EMY20Pq7sIbAqjk4cnI8yYhyae3gxODUx9KminxTzC+ftlJREdfUcdHO98X6w==
X-Received: by 2002:a17:907:7296:b0:abb:eaf5:2121 with SMTP id a640c23a62f3a-abc09c1a0f8mr1295282666b.40.1740387217356;
        Mon, 24 Feb 2025 00:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh2r4tYTvO+Dz6YnMnrVD9mue97RhYFkOOKaPOtyAmd11YBgRQpHNLCYitN+B/kdYu5u46gg==
X-Received: by 2002:a17:907:7296:b0:abb:eaf5:2121 with SMTP id a640c23a62f3a-abc09c1a0f8mr1295279766b.40.1740387216954;
        Mon, 24 Feb 2025 00:53:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbd6b57314sm1074242466b.93.2025.02.24.00.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:53:36 -0800 (PST)
Message-ID: <494bfb9c-0000-44fb-b33a-e42422488c95@redhat.com>
Date: Mon, 24 Feb 2025 09:53:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: select CONFIG_CRYPTO_LIB_AES
To: Yeking@Red54.com, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Robinson <pbrobinson@gmail.com>, Fabio Aiuto <fabioaiuto83@gmail.com>,
 linux-staging@lists.linux.dev
References: <tencent_0BDDF3A721708D16A2E7C3DAFF0FEC79A105@qq.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <tencent_0BDDF3A721708D16A2E7C3DAFF0FEC79A105@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 22-Feb-25 8:36 PM, Yeking@Red54.com wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> This fixes the following issue:
> ERROR: modpost: "aes_expandkey" [drivers/staging/rtl8723bs/r8723bs.ko]
> undefined!
> ERROR: modpost: "aes_encrypt" [drivers/staging/rtl8723bs/r8723bs.ko]
> undefined!
> 
> Fixes: 7d40753d8820 ("staging: rtl8723bs: use in-kernel aes encryption in OMAC1 routines")
> Fixes: 3d3a170f6d80 ("staging: rtl8723bs: use in-kernel aes encryption")
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/rtl8723bs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
> index 8d48c61961a6..353e6ee2c145 100644
> --- a/drivers/staging/rtl8723bs/Kconfig
> +++ b/drivers/staging/rtl8723bs/Kconfig
> @@ -4,6 +4,7 @@ config RTL8723BS
>  	depends on WLAN && MMC && CFG80211
>  	depends on m
>  	select CRYPTO
> +	select CRYPTO_LIB_AES
>  	select CRYPTO_LIB_ARC4
>  	help
>  	This option enables support for RTL8723BS SDIO drivers, such as


