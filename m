Return-Path: <linux-kernel+bounces-230918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4219183C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2A9B21ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5E185090;
	Wed, 26 Jun 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9ICocUw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0F1836F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411568; cv=none; b=DdfWg+Ai4qQEr0Orc4NDUJKhAehq5uVd/g9qHeVjwf7ELev/JekXbTKhdtbUXtS0YSC+hz57g+utkJuZ3YSTV2J7wUXrla9xXoPA8uy3p9hM5GSztbA8mhzz7dAG1O6DPjgmf4tyMiP2ml7uiKc1000uPOJoM75LXmJQKo9zViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411568; c=relaxed/simple;
	bh=5K51asI2OsXHPnp6ePSF4qdpZPMhk1zVXsrs1a71z1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D69RrN0GDHmlA2izwESoTcOiUpHnaNWw0Eq5dt1l81z2rvBbGz/ZdDn5DlyORTfEI3yOOE2n3GQekndXjRQb3goo5Gs4e1L8Sl7DTzBZFM1drXUFvHThST5VnpRVsddgBtXeBm1X6MWRnxwHCKz/XmwDAzNhFC0BBmVWrBJ7N5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9ICocUw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719411566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3+6+X1eVY0Jkg6cNgj0EcYrMDIo+k7L8u8CKTnBBMg=;
	b=N9ICocUwwCNA1j1Mn1AoQD77lDLW+FV9EFLhrMOi9gax/feBwAuu0dnTOUwac+55NtXDVj
	ZfsfNuATig0iR++6Yzcvb9jffQyYTaXBzKb1xgGVeZESmVyKhkaXRGX26VqkrJA0Yefq0z
	RftteS7FNi4VsHggEl/WTs/p6yMQ+zk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-4GOkTNwYPtysqmh1nF3nug-1; Wed, 26 Jun 2024 10:19:23 -0400
X-MC-Unique: 4GOkTNwYPtysqmh1nF3nug-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421739476b3so58332355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411562; x=1720016362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3+6+X1eVY0Jkg6cNgj0EcYrMDIo+k7L8u8CKTnBBMg=;
        b=leHyB0lQk0t3kauc9AcCCyWukraoBwCY1FzcMwPuougnCOxOCSzk+GCNxuBI4zw3LU
         PdBPoNYDgZeLdzIn8bt0Bm3Fw/nKL2gX1OGnIBMRVIR3bwGQfll3X2HIDnJGDGqor34B
         6KUQilRQjPw45NRi4LNDNSmCuK819CQ54xMwoW0o5MriIlvv5itTfiRlAmhyHlt5bztI
         J9NbPMFsIL/6J462sakD4+Mv1odlYQoVFgVarDU0YaQYxR84qOt+LBv1EDgIPGgGpFq9
         vfRH9xn3IYaR+h4CMk+YgiDEEUbqQ+MgtKIcJFd0Qu/IK3wmIlMtLUcpOFF7L1aoQHZN
         YxnA==
X-Forwarded-Encrypted: i=1; AJvYcCWzBJw0NymjUFwLTucYzD8OydTdqFjzaFBELKAM6xQotIu3A7X5AX4aEOfFwsbL4Bbitgs0dGr4Sm1J3r5wqL9zHcuDsgf1dxXh9u9X
X-Gm-Message-State: AOJu0Yym8Qc5q/sGn9zpao1IBM/kiD3AvM2lAIfchid0Qu0xLVehoC0x
	RfJTVS+vPnnc23XAOCYz5/4Wc9PfyMOr1eTIyYcVWSdZL8Zfv+44nnAndl8ZS0JsDQrV4Wn+PE+
	Fq8zJaJ0M8dh4iOABN432uoX2JVgfzA0Q/8HsXUVJFvyeoTDFlI0XccnhSNRKOQ==
X-Received: by 2002:a05:600c:4790:b0:425:5f12:1cf9 with SMTP id 5b1f17b1804b1-4255f1238aemr13234825e9.27.1719411562301;
        Wed, 26 Jun 2024 07:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGax9kaCNhOUBP+phnm1HFeZemuLngNNz4bs/QuG7DeUYhJ/v9FE8YtoxfaDOcJ9+RPmKYo0A==
X-Received: by 2002:a05:600c:4790:b0:425:5f12:1cf9 with SMTP id 5b1f17b1804b1-4255f1238aemr13234675e9.27.1719411561967;
        Wed, 26 Jun 2024 07:19:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9b8a8sm15874592f8f.50.2024.06.26.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:19:21 -0700 (PDT)
Message-ID: <f647756a-fa9b-4a97-8c33-826f7496821f@redhat.com>
Date: Wed, 26 Jun 2024 16:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panic: Do not select DRM_KMS_HELPER
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1719391132.git.geert+renesas@glider.be>
 <60155f8c939ed286e324a7c12a1daa69fe49fcf6.1719391132.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <60155f8c939ed286e324a7c12a1daa69fe49fcf6.1719391132.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/06/2024 10:41, Geert Uytterhoeven wrote:
> DRM core code cannot call into DRM helper code, as this would lead to
> circular references in the modular case.  Hence drop the selection of
> DRM_KMS_HELPER.  It was unused anyway, as v10 switched from using
> the DRM format helpers to its own color format conversion, cfr. commit
> 9544309775c334c9 ("drm/panic: Add support for color format
> conversion")).

Thanks a lot for this cleanup,

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Remove the unneeded include of <drm/drm_format_helper.h>.
> 
> Fixes: bf9fb17c6672868d ("drm/panic: Add a drm panic handler")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/gpu/drm/Kconfig     | 1 -
>   drivers/gpu/drm/drm_panic.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index b903a2c0b5e8f95c..ce9bf2b6e9d332d4 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -108,7 +108,6 @@ config DRM_KMS_HELPER
>   config DRM_PANIC
>   	bool "Display a user-friendly message when a kernel panic occurs"
>   	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
> -	select DRM_KMS_HELPER
>   	select FONT_SUPPORT
>   	help
>   	  Enable a drm panic handler, which will display a user-friendly message
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 8d2eded1fd19ff6c..67f78b5a76b61e3d 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -20,7 +20,6 @@
>   #include <linux/types.h>
>   
>   #include <drm/drm_drv.h>
> -#include <drm/drm_format_helper.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_modeset_helper_vtables.h>


