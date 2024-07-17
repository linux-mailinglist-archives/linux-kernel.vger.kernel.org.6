Return-Path: <linux-kernel+bounces-255033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FC933AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4771F22F78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C617E908;
	Wed, 17 Jul 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJXu4GRj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9A157A5B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210749; cv=none; b=ZLrvm3NBnmIpTOSCqC/Qce4cSUsJRRyddvaA7+Ly14MqtOndxEGLOEJ5pnEuodiAORwoQ8Tvole2mvipIO2UGlxz15yj7a1Na7FVMbKCeYHac12wfaxHwD+lrWe15Uwrqz1K6+655pMUB6XU85YeYPJ9HLbxnm8qnsA38grI3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210749; c=relaxed/simple;
	bh=pzlczSgIwURpCz9vCGhpCop7+ZzG3dvlybeLgb8qzhQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XByakitSZM7O5160vmAEGlrOusou2NiHPTAAye14gh/rT4BESsYQob2wcM805hDmILB6DvwPOVse8bR8xX2hkrgCFN4dogylZArioDPg/gqGJk1D3JY5ivBYgFyOzxGjs+gnnQHWvYQcAHNFP0Ki/QtnKte16C2THWanrU3/LoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJXu4GRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XVOmJ5qZrjBzzyMjCpJUJSvkbzb7dNjfwAsLgNQSeI=;
	b=XJXu4GRjFMpicj9YFuDWop2HTBUs0rxxnGzqfrRPpNx2SRWr+dIFCdyFahTfo4Rl6P73tx
	LSi7dzo6qYyrtuZMbQRMn4PFOSKqpsmk6+8UWKboIFPLji+PwXoXEaawzwTy9gXMBKjiXg
	bnKJ+bBR6V4fM9q84G22PF0bjtFB/3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-FglidzerNDahSpqOZH1VlQ-1; Wed, 17 Jul 2024 06:05:45 -0400
X-MC-Unique: FglidzerNDahSpqOZH1VlQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3683165c576so489262f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210744; x=1721815544;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XVOmJ5qZrjBzzyMjCpJUJSvkbzb7dNjfwAsLgNQSeI=;
        b=gL6Jbgln/VbOasYbHhBqGU5/e/jRwZFbnqPbr2uduzmiVzVk4TWEPTetDlCbiZ9JF4
         TSDKGh3BrQYfGotz8T2CxmG2Yjk++XuZiSfbc5z6munEWdJsgUHJXRHkudmOxkilfeBE
         sBvFYeNx4ctQGvYYwEf/1zD+h6ufJshd5nNn6MSZhtO0FX9vtcztDnPEI5Lne/VIJPr3
         WZPQx6uLzbWUlefuYMDpvX380gRUko0yZU9XGz3bxxDlflySwpqZJhe+DCHrh8VI6bZI
         gi8FLfn7XeObZ4GUWvjPt2wQBp7CHy1TYAf1wkGR1JOYGsUTiYtXnloKbz9tmsVlHVTp
         yfOg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0U9nie3YzfHakLEPaZUyFSx/Fa6j3pyzKZRpbvBX7eGygHU+VtCzVMBO4UxqOktUtV0V1rVTNFwRsbXNQ2M/mWwmiccVwnsz3KSX
X-Gm-Message-State: AOJu0Yx+M2JUebn8sV1WFRZrsPG9xxvk1svtBK2cgKreJiM/ebTTNInm
	jdtA9vfeeCg7n8e0f3fs+ufoojmvWELASgiNZJ5CmCu3vFXWM9nmEHuNVhv+y/m7oAtR6kQ0ReB
	MWKys8nxQL8fFU/MneZyvecDgCwiEF56BOv0NJMWJ2EnpWfhj6xe0ZKdqBk3esw==
X-Received: by 2002:a05:6000:184a:b0:367:f054:620a with SMTP id ffacd0b85a97d-3683164e06bmr1376758f8f.30.1721210743902;
        Wed, 17 Jul 2024 03:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFyrK5oxCiDB6/FrZj9Bduj3f7Nd98eJNJ/eqEUmn3jqfve7vxK7uYWjf+/MzztI+lNDC9JQ==
X-Received: by 2002:a05:6000:184a:b0:367:f054:620a with SMTP id ffacd0b85a97d-3683164e06bmr1376729f8f.30.1721210743535;
        Wed, 17 Jul 2024 03:05:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbe7csm11270820f8f.83.2024.07.17.03.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:05:43 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>, "Jiri Slaby
 (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
In-Reply-To: <20240717090102.968152-2-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
Date: Wed, 17 Jul 2024 12:05:42 +0200
Message-ID: <8734o85o5l.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn,

> It allows to check if the drm device supports drm_panic.
> Prepare the work to have better integration with fbcon and vtconsole.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>  include/drm/drm_panic.h     |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 948aed00595e..d9a25c2d0a65 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>  static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>  #endif /* CONFIG_DRM_PANIC_DEBUG */
>  
> +/**
> + * drm_panic_is_enabled
> + * @dev: the drm device that may supports drm_panic
> + *
> + * returns true if the drm device supports drm_panic
> + */
> +bool drm_panic_is_enabled(struct drm_device *dev)
> +{
> +	struct drm_plane *plane;
> +
> +	if (!dev->mode_config.num_total_plane)
> +		return false;
> +
> +	drm_for_each_plane(plane, dev)
> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
> +			return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(drm_panic_is_enabled);
> +

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


