Return-Path: <linux-kernel+bounces-294258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75790958B50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A52827CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6F193075;
	Tue, 20 Aug 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNjWa+Za"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438F192B9F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167767; cv=none; b=D4xTtccx77DIoHtQYBU3cHgqlS1mc0QvxwKDQQbZBVWSBxxjRnl7ufkup14yRiFUiSWSQ4RFlI4R6RiAJymVaNPp17QgmtS8Xw95joYX1snUt5BqMpB39cPLoLfoG3ozGUhBBLpIUZkcF/xWYEuTwWYUYOR0eqF2scUIkH1Oj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167767; c=relaxed/simple;
	bh=mcN9Di1D2BNreG9ZtP9n9ScR7P9ZdDUHmzrdp370c8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAqU+KB0xogm/YY17xW+QVAvr1cOiWhbY9EMx8kcyfv93Z+9vSpk9B00omPHL2Y0SA2tMFgp24R7V76FBPHJinBaXbevOJv6KIBCaLzml/9+OqVdCSL7dQiqjE8rNHdtkmivnH014eaYLNAJG1JurqhonG2voPCVYmxNvz35bE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNjWa+Za; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3718acbc87fso3020632f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167764; x=1724772564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkWOPQjGLs4dsHLfoUaXJd6WQ78zM6/OqatLTFO3uUs=;
        b=fNjWa+Za6ebGmQMJFejN5cRVF2MZnM1SSOSMzVk6N0sabm4u+WQACXbUQkhaWWuhpM
         VX0u0HUfde2ht4qnvKpHvOKFwzlH9q+N10WFQjryYhCAlDE5NewT6bILT/hFU/ZyCdmi
         AAtUPr5EryGG6tG9YBWFND+yVvVL9XZcskuBr5Hq1TT1MeV1ZSSXiPXOCmgT+Bbz4Uru
         aNvlRu4zqHHDVjxwpCd81puHqQn6W0eqom0EusskKSX4pyfSFHUr6DJKPk937/2E39DX
         LXmFROSIDoxwR9E2ifZoX7QuvZ+kQHgxkY0v+qW0zL0Q/hc5dz96UYMjICC/XpiaQtjE
         ln/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167764; x=1724772564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkWOPQjGLs4dsHLfoUaXJd6WQ78zM6/OqatLTFO3uUs=;
        b=Ty4UzX/zg9ce2C+IIb1K1rDjb4ziOC/lskhDJErqoOH0vHw2qAB+M5MvBhjXjUzId0
         PVfOT9xBAwMQ2ujp9VT1/Qtd9gcuekKH/L8kGfC87NBBnRQbt5XnBrk3zAkhM1gxw/xN
         Jp9NI899Oj3MoBbuBAO5Kh7wcEviJKPTumg22xIO6ExPVrulZaIRxliYJjwLC6loAzNy
         O3AqUfEM3kCjrkrGEkCvJ2bg5gtxQ3OEzlxslfU6Tf4uhFYzawVDhatIfL+cJIlpAr9Y
         pJZkoaES3TbT6PDs8hYuEP+3C+MgDf5Ks/TBHNyDes8rwSgG3SMWk9RMJ0IaM00Q4kDE
         IvpA==
X-Forwarded-Encrypted: i=1; AJvYcCXEtX/pgMYyRVDcCo2l9diJMkZ78Xo6a99TdV469epKXKnZXsagHmeLQFhl/DITnGln0v/dasdbTyn7n1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhxx5IoFCUWzrSk5DNF3tqtkuOjoKZ8Ks1LcBKMMqq5eWT8vuo
	Izl1wGgsSyJw9JX1F1zbZeWl8gwIi9XvTX0U8uCA/7ZwnhVIOaCG
X-Google-Smtp-Source: AGHT+IFwLSLU9/bU1XD6r/0OdInxoAHXW7lfcJ9bdS4tiehk8P2PZwDqsfO42Eup8Igg4DO+ShZbGA==
X-Received: by 2002:adf:f80e:0:b0:371:82ec:206e with SMTP id ffacd0b85a97d-37194314e2cmr8907152f8f.5.1724167763735;
        Tue, 20 Aug 2024 08:29:23 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849933sm13475108f8f.36.2024.08.20.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:29:22 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	marcheu@google.com,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RFC 4/6] drm/vkms: Rename to_vkms_plane_state to avoid confusion
Date: Tue, 20 Aug 2024 17:29:18 +0200
Message-ID: <20240820152919.2863-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-split-headers-v1-4-51712f088f5d@bootlin.com>
References: <20240814-google-split-headers-v1-4-51712f088f5d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The macro to_vkms_plane_state was not explicit about its expected content.
> Rename it to drm_plane_state_to_vkms_plane_state to avoid confusion and
> help the reader.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c  | 2 +-
>  drivers/gpu/drm/vkms/vkms_plane.c | 4 ++--
>  drivers/gpu/drm/vkms/vkms_plane.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 6a4de8f7a678..08e5db07aca6 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -212,7 +212,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
>  			continue;
>  
>  		vkms_state->active_planes[i++] =
> -			to_vkms_plane_state(plane_state);
> +			drm_plane_state_to_vkms_plane_state(plane_state);
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index de2c83e1b02c..e549c9523a34 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -80,7 +80,7 @@ vkms_plane_duplicate_state(struct drm_plane *plane)
>  static void vkms_plane_destroy_state(struct drm_plane *plane,
>  				     struct drm_plane_state *old_state)
>  {
> -	struct vkms_plane_state *vkms_state = to_vkms_plane_state(old_state);
> +	struct vkms_plane_state *vkms_state = drm_plane_state_to_vkms_plane_state(old_state);
>  	struct drm_crtc *crtc = vkms_state->base.base.crtc;
>  
>  	if (crtc && vkms_state->frame_info->fb) {
> @@ -139,7 +139,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>  		return;
>  
>  	fmt = fb->format->format;
> -	vkms_plane_state = to_vkms_plane_state(new_state);
> +	vkms_plane_state = drm_plane_state_to_vkms_plane_state(new_state);
>  	shadow_plane_state = &vkms_plane_state->base;
>  
>  	frame_info = vkms_plane_state->frame_info;
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.h b/drivers/gpu/drm/vkms/vkms_plane.h
> index 161b44da0240..68170a75e9c9 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.h
> +++ b/drivers/gpu/drm/vkms/vkms_plane.h
> @@ -59,7 +59,7 @@ struct vkms_frame_info {
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  				   enum drm_plane_type type, int possible_crtc_index);
>  
> -#define to_vkms_plane_state(target)\
> +#define drm_plane_state_to_vkms_plane_state(target) \
>  	container_of(target, struct vkms_plane_state, base.base)
>  
>  #endif //_VKMS_PLANE_H
> 

