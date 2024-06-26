Return-Path: <linux-kernel+bounces-230920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340B9183CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54D01C2150F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D6185E44;
	Wed, 26 Jun 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRpt5OwN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADA1836F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411654; cv=none; b=apd31coHY8p9rJ9pdMlfj2gAmWZyFpm08jeUNlDLY5k9EeTpG3DTP28xLiUrfZpxfnZ0ti0yrKtBPgpsLKyga4MnHvp/8lTGERpx96YdFTESFDtqyvatMSGi7aUnjqdupGeXsieFZ9aa/3EOjPRdYYEFirIsE2mXc4loUg0JNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411654; c=relaxed/simple;
	bh=Dl7FPtMqzbg7UbKHGbkPFwvho70oz1JBNlyPqhAKb8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8YAsB2LEBuF2QPf4ZeEayMxoJ2ixUisZ4NfTIy/AuOjM2MdXK6onsn3CW/seAtP2gyFNRnL3Xz0CxWHGmTwM1vvA76O0zuf1esjS1b6yvQdBMMqR44OhPsdkgFy9kRkCip1PrZWXVbn0ERonqyxayMBKD28TrLD8MhIFboeSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRpt5OwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719411651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dkiH8oB1Lq06BrQXA4EiojnJ36I3m0baKMRCHVxUGM=;
	b=VRpt5OwNQNPjnmwI0ulJFEFZCDvleV5WnCpHZRwWjPaYM76OFi1U/7NPeHdd37Q04AQKDQ
	Vou9KB89WbGfItjXEvUbQA37FiHUu5+4hZrYiSl8oHs9hiN2GYksC7K7OCRCL1LS7YoPnC
	jLWT1svPHPSqwx37CqdW1CAhcqgToW8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-X5Zc3iMHNceL2NChN99wdw-1; Wed, 26 Jun 2024 10:20:50 -0400
X-MC-Unique: X5Zc3iMHNceL2NChN99wdw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec5a297b48so32629261fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411649; x=1720016449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dkiH8oB1Lq06BrQXA4EiojnJ36I3m0baKMRCHVxUGM=;
        b=KPpFQC6OpavpbOrhJt7aqxi6CmcpIc6exNdL8WXDsoBjMg7fLm6lG6QOikxNdNMCWq
         e5loZFm/76VliEUfefFVzHxo1NPMTyBSh2Bl8LyxmY00JiDpkkUdl4MwxWPYpGTUX4eW
         CD7FHtyfloVwuVD2oPR2p8nK2VZZg31QMMzpFdZUnpVkdxbjXCN4cQmx5JUwiwfttZUD
         lb1isEo4+CaCyhLFMHrUr9OAm0yh9b9Ih0Mk+b9c7Le/7+8zd2ut1U9upd5HGBgkeYT2
         6bzvODo495sD02Z3KCNpJw1H4AUB/ucTknWCScsm9uhQXV/9Pitrg7aAZsNtnGdsKlo0
         dJOg==
X-Forwarded-Encrypted: i=1; AJvYcCVMR9M0yA/tadcETr8S17H71admTBS/Tozr9FMV92E61syh2fTBrFL/pJ77oYHJpbBjLbEopEoUtGzUF3/kt525qObuC5LQC6g4qH+E
X-Gm-Message-State: AOJu0YyT1siFV6JMxY8V8x7Kgj80t1c5owhlaEphITL727KeUz2abQJJ
	KBoHh3bI8/NhEXTPM01k5N5DfTxQH/usVSjCY9QYD8I29V8HZWFR2hDVVk2FbFnNnOx0nU6SIUM
	ikXktnqdGvmOHoBekVC0ImGK+HVa3tDPofXQoM3kJoxAC2k8MJlt7B2shmYe3iw==
X-Received: by 2002:a2e:8297:0:b0:2ec:174b:75bb with SMTP id 38308e7fff4ca-2ec5b38ad36mr60758581fa.28.1719411648857;
        Wed, 26 Jun 2024 07:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJrtCfsDdRjevLVF2jDTZKd/+U7FelbsHUMDDFMFSBrVQopsqeDt+kK0Oh5JvZq3Uufc/4g==
X-Received: by 2002:a2e:8297:0:b0:2ec:174b:75bb with SMTP id 38308e7fff4ca-2ec5b38ad36mr60758471fa.28.1719411648462;
        Wed, 26 Jun 2024 07:20:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8285f5csm26987465e9.25.2024.06.26.07.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:20:48 -0700 (PDT)
Message-ID: <70f5f582-f20d-4102-a6e6-7d5927edbb56@redhat.com>
Date: Wed, 26 Jun 2024 16:20:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panic: Restrict graphical logo handling to
 built-in
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <cover.1719391132.git.geert+renesas@glider.be>
 <4009fca99a7c05f617cc9899c6d0a5748415595d.1719391132.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <4009fca99a7c05f617cc9899c6d0a5748415595d.1719391132.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/06/2024 10:41, Geert Uytterhoeven wrote:
> When CONFIG_DRM_PANIC=y, but CONFIG_DRM=m:
> 
>      ld: drivers/gpu/drm/drm_panic.o: in function `drm_panic_setup_logo':
>      drivers/gpu/drm/drm_panic.c:99: multiple definition of `init_module'; drivers/gpu/drm/drm_drv.o:drivers/gpu/drm/drm_drv.c:1079: first defined here
> 
> Fix this by restricting the graphical logo handling and its
> device_initcall() to the built-in case.  Logos are freed during late
> kernel initialization, so they are no longer available at module load
> time anyway.

Thanks a lot for this fix.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Fixes: 294bbd1f2697ff28 ("drm/panic: Add support for drawing a monochrome graphical logo")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406261341.GYsbLpN1-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 67f78b5a76b61e3d..948aed00595eb6dd 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -91,7 +91,7 @@ static const struct drm_panic_line logo_ascii[] = {
>   	PANIC_LINE(" \\___)=(___/"),
>   };
>   
> -#ifdef CONFIG_LOGO
> +#if defined(CONFIG_LOGO) && !defined(MODULE)
>   static const struct linux_logo *logo_mono;
>   
>   static int drm_panic_setup_logo(void)


