Return-Path: <linux-kernel+bounces-323101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C39737EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64E41C24666
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDF192D7F;
	Tue, 10 Sep 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUEi1fxA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A9192B96
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972581; cv=none; b=FjbuhhzyTX7LxTHVLVtNF7kQEfnMoqO0ZPdiXVQoQogpuKcgS+/Uv7wtwsii6Dr+fmJ+aMRUjRSOubFV8RSGizTM/ScMtsRUAUL30I+PWGBoEVYg0gMUJtjs1HB2Lz5plf2uYPSde9vrrcObnb3p1UeF32kqbvXs8BXkApzIxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972581; c=relaxed/simple;
	bh=mgfcX2uQtqJW+4vxPdt0csDUudu1Fc2mT+vh+uOSnds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q8toS98ay0Ly0tp9M2Lp6FT3QhFCqFcrzEE9IW6GJ+6jRQic/Dqp1pTcKtXQtBgnsdAkQjlQ+RcI7K2tbsQ3CXkU3TPpfKnpUbotkIkk2xZW76R42l3382gBKPQ17qDE1CyuwsV2jg0CUPuuH+axOr9MyHdTzO+UHj8zAcHtDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUEi1fxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725972577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6nd62AWkPIK5gIXPiUm1JLX0Wy6uPdrxO6zecHjvld0=;
	b=ZUEi1fxAStn1fwPuDmBH6pWhIqphxwJZbSMylVl025zK5/UxkVAksNzElR/Ef7NX44ld3Q
	JHYJN9hVaYIhwId5TJZXS9CH68yvmyvgzLO9UTS2Loqlzm65v13nmcenVmdUOOjtLaSFEm
	neaCZYg/rvDpxtYVIHHW/zIHK7m5RPE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-vYNPLcTaOru6jaR4Pf54_w-1; Tue, 10 Sep 2024 08:49:36 -0400
X-MC-Unique: vYNPLcTaOru6jaR4Pf54_w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c32158d0so440708f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972575; x=1726577375;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nd62AWkPIK5gIXPiUm1JLX0Wy6uPdrxO6zecHjvld0=;
        b=oCAotOQU9UVdGHqAl1YR6jV8LEecTj59ns1jLdbDJLFdi54A6FevqEmJ8Ac8r8L2k0
         TXfumuXwYeZcUPzBju+/z0QXGUmBDVZJItyE6az6n6rBwZDwJgghPe1ZRTEgtp2IP6Nn
         8ML/JHV3UEgTPKmEBdzWt70yOG2EnVNwjQDsI2ZE0qrIRqczLCF2yONdOEe8eoO/eOPC
         GX17IgOG3Vvu8ob4IclhlLn194W52MY6jH5sJvagID5g/DSMY3M8DFLg8iBvdkX+lh8p
         hUeHZkLjudE3Jlox38yD+J+hPwDp4B9z2Ou+tmie0s5fjQiM+VY0D8O0IcxwY4asHmRD
         ir1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXrGSKoecZWlcy2uD48sCDpbXIFyXfXwRuZFQjK3YAzGY+o0J2d3j5iWHwQdH3HtwCrxEqM+kxN4AB9K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrgCg7L/QeDpEef7UdN6ktFyy4WMWSHVb+P0B53Ftt5Sm+eh9
	xE83yp9WnA+JVyvkLo6vyLS+ZCFFDi+V608z2off+k0fEvH8JxLn8YKs0V6qbuUVl7L1HRk6oXT
	0StzrwixSBYtcGNGEv/PdLDDhpdKiSsOssgtkPAOIy9b/+GI2laAYRmof26km04biJcqG997bYt
	JuKAPLHb3faXoH+3J9hSwfkBmEGRgxSoWk1+uvqL3D8KmlKA==
X-Received: by 2002:adf:f744:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-37889682e0fmr9248514f8f.46.1725972575142;
        Tue, 10 Sep 2024 05:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn1VOKKhA4WLT+ujhN0UWmvu2oY3V+R+ECDiuNE+P04fsSNUprDeK4EvgDC0oQ+l+wSJkUiA==
X-Received: by 2002:adf:f744:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-37889682e0fmr9248486f8f.46.1725972574606;
        Tue, 10 Sep 2024 05:49:34 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8afc9sm112219705e9.44.2024.09.10.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:49:34 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, Yan Zhao
 <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bochs: use devm_ioremap_wc() to map framebuffer
In-Reply-To: <20240909131643.28915-1-yan.y.zhao@intel.com>
References: <20240909131643.28915-1-yan.y.zhao@intel.com>
Date: Tue, 10 Sep 2024 14:49:33 +0200
Message-ID: <87a5gf4qsi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yan Zhao <yan.y.zhao@intel.com> writes:

> Opt for devm_ioremap_wc() over devm_ioremap() when mapping the framebuffer.
>
> Using devm_ioremap() results in the VA being mapped with PAT=UC-, which
> considerably slows down drm_fb_memcpy(). In contrast, devm_ioremap_wc()
> maps the VA with PAT set to WC, leading to better performance on platforms
> where access to UC memory is much slower than WC memory.
>
> Here's the performance data measured in a guest on the physical machine
> "Sapphire Rapids XCC".
> With host KVM honors guest PAT memory types, the effective memory type
> for this framebuffer range is
> - WC when devm_ioremap_wc() is used
> - UC- when devm_ioremap() is used.
>
> The data presented is an average from 10 execution runs.
>
> Cycles: Avg cycles of executed bochs_primary_plane_helper_atomic_update()
>         from VM boot to GDM show up
> Cnt:    Avg cnt of executed bochs_primary_plane_helper_atomic_update()
>         from VM boot to GDM show up
> T:      Avg time of each bochs_primary_plane_helper_atomic_update().
>
>  -------------------------------------------------
> |            | devm_ioremap() | devm_ioremap_wc() |
> |------------|----------------|-------------------|
> |  Cycles    |    211.545M    |   0.157M          |
> |------------|----------------|-------------------|
> |  Cnt       |     142        |   1917            |
> |------------|----------------|-------------------|
> |  T         |    0.1748s     |   0.0004s         |
>  -------------------------------------------------
>
> Note:
> Following the rebase to [3], the previously reported GDM failure on the
> VGA device [1] can no longer be reproduced, thanks to the memory management
> improvements made in [2]. Despite this, I have proceeded to submit this
> patch because of the noticeable performance improvements it provides.
>
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>

FWIW, this patch (alone) resolves the observed issue, thanks!

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I, however, share Paolo's concern around existing VMs which KVM's change
is effectively breaking.

> Closes: https://lore.kernel.org/all/87jzfutmfc.fsf@redhat.com/#t
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Link: https://lore.kernel.org/all/87jzfutmfc.fsf@redhat.com/#t [1]
> Link: https://patchwork.freedesktop.org/series/138086 [2]
> Link: https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-misc-next [3]
> ---
> v2:
> - Rebased to the latest drm-misc-next branch. [2]
> - Updated patch log to match the base code.
>
> v1: https://lore.kernel.org/all/20240909051529.26776-1-yan.y.zhao@intel.com
> ---
>  drivers/gpu/drm/tiny/bochs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 69c5f65e9853..9055b1dd66df 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -268,7 +268,7 @@ static int bochs_hw_init(struct bochs_device *bochs)
>  	if (!devm_request_mem_region(&pdev->dev, addr, size, "bochs-drm"))
>  		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
>  
> -	bochs->fb_map = devm_ioremap(&pdev->dev, addr, size);
> +	bochs->fb_map = devm_ioremap_wc(&pdev->dev, addr, size);
>  	if (bochs->fb_map == NULL) {
>  		DRM_ERROR("Cannot map framebuffer\n");
>  		return -ENOMEM;

-- 
Vitaly


