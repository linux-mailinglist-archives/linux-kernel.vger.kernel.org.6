Return-Path: <linux-kernel+bounces-303842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C9C9615D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9C91F25582
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2801CFEBC;
	Tue, 27 Aug 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb1LN7mE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D54126F1E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780948; cv=none; b=cR4z861k3cK1A0LpJnUbTXjT9+GATFpWsb4/cKjZMYMm+1MMWO94WdO1X8nt12pRiWuAJXMLcPpBg2DyAiameXTNLZVnxpZc7e42P9P+7BLrkMnDa3zhalOysNqVIUPYHjHQ7eIyXUsyiC3AHY+Kve/BsiPxIOtNZEiY1vm98/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780948; c=relaxed/simple;
	bh=gZVceoEGp8iEYfD0ejrhsDGGoyoTKHblzo115/cTkq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7JJ3gxWCfTrw3M+I20sVJXw0Gfe/4cWzuG59L7EJYqtX09gwGa8ZPFvTLcujRTegbnlt6QrCRV5HrNnbd0gShlyZLBVzz8gBlpKYfy4mvLgVbMDtnBFQmGIMYjXDLsPLY0umCjgitPT3kznpwBntfvzKmIfHoaCxRKeByn5oxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb1LN7mE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428163f7635so49828185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724780945; x=1725385745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMaQoEqyTq8ICLfDV3/CttbS78tV2teqYLFClZdvFXE=;
        b=Gb1LN7mEGmi82WJNYvoZcLFHhnFsRU+3+Ay3cI/dB6+99jMgaPvOX+XG7rF9VgDq8D
         2Fz8WJ9O9kdSz50Kj3fNy5b+m4t19VvsUmswk4BzdczM7Fr/rDeX/IbKqq30UOWtRaoq
         jarTdtTQhYds0YSx1E0lyCPfGTAuO3iZQxfVQrnrCr+m58fYuB2x74eqtlu1Ie//ap0Y
         nbVr0gxNJ6eYzbNqJ1KRrd4rVm413DMf5Wq2C/RtLhSKTNSrf8YDOrs5gF2HCkB/ZZqO
         tc5rSSgMhIydko4jeMnkeIQLq6TFUOmNu6wI7nXCfngL+Gdlweo4sApiY5LhZDDq0WUw
         tL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780945; x=1725385745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMaQoEqyTq8ICLfDV3/CttbS78tV2teqYLFClZdvFXE=;
        b=iWfBxDoKjYLOAWGUTvBitgZcyEBsTGpjnwcM2HSHzelUgbdKykMbDyxHdfE+9jOir/
         vxVD6crbD8s9mmHGXYSR6XPIcLlzg85ASrtz1V8oW+5mM2YQkLaxUUmGHtYIAmU420NK
         LWWUQ3dQryBbPTc4ZDidqvUL36u3plIqsmRZgm7z/vZu0B3d6AHneO65wiceYneN37yA
         X0tXnE4Fma2kVHei8h8w18oaIMHU0uhgsBwIXzpeDD1xdlFzLFvQilloOfRrYcoo6FEx
         PtPIhmHIg3Y8c78NDXtZJVDgSFWl0HFQYtaMuvyqhQon3Qkq1q/Iz9Fwm3KnbbLWL++t
         Ilww==
X-Forwarded-Encrypted: i=1; AJvYcCW8nRx610kHYqIJNDPAOHw+ajW20tRFgOlZecI5/hhV+m2RgY5xhY+eVwgTFi+FtDtschEHEgsMAWhlVOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLatpuVaRedlTD9wEGozpxR8y38E7PnNzIO7qbGcEr+MHMmhsF
	OlV87TpPr28Y5a8zuASmZqtAQSaKYwT4rT2j88iPp3EuG7qQ5cJK
X-Google-Smtp-Source: AGHT+IHLUv28+ks3sKzPLrvkaUWbGto0en/omvaTh9fdCAXnmQ9o1DbClT81RSWzYlaPalxlFz580g==
X-Received: by 2002:a05:6000:4012:b0:371:9362:c286 with SMTP id ffacd0b85a97d-37311840ffamr11892080f8f.4.1724780945066;
        Tue, 27 Aug 2024 10:49:05 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082657bdsm13759865f8f.107.2024.08.27.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:49:04 -0700 (PDT)
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
	tzimmermann@suse.de
Subject: [PATCH v2] drm/vkms: Add documentation
Date: Tue, 27 Aug 2024 19:49:01 +0200
Message-ID: <20240827174903.2774-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826-google-clarifications-v2-1-2574655b0b91@bootlin.com>
References: <20240826-google-clarifications-v2-1-2574655b0b91@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

> Add documentation around vkms_output and its initialization.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> This series does not introduce functionnal changes, only some
> documentation and renaming to clarify the code.
> ---
> Changes in v2:
> - Dropped already applied patches
> - Dropped useless patch as its content is deleted later
> - Remove dependency on previous series
> - Apply Maíra's comments
> - Link to v1: https://lore.kernel.org/r/20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com

I think you missed my email in the previous patch:
https://patchwork.kernel.org/project/dri-devel/patch/20240814-google-clarifications-v1-3-3ee76d7d0c28@bootlin.com/#25983103

Minor comments, but it'd be nice to get them fixed if possible.

Jose

> ---
>  drivers/gpu/drm/vkms/vkms_drv.h    | 86 ++++++++++++++++++++++++++++++++------
>  drivers/gpu/drm/vkms/vkms_output.c | 12 ++++++
>  2 files changed, 86 insertions(+), 12 deletions(-)
> 
> 
> ---
> base-commit: 22bc22ccf95bfa6eb6288ba4bc33d7fc0078381e
> change-id: 20240520-google-clarifications-dede8dcbe38a
> 
> Best regards,
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 5e46ea5b96dc..1fc068d4de4c 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -73,29 +73,56 @@ struct vkms_color_lut {
>  };
>  
>  /**
> - * vkms_crtc_state - Driver specific CRTC state
> + * struct vkms_crtc_state - Driver specific CRTC state
> + *
>   * @base: base CRTC state
>   * @composer_work: work struct to compose and add CRC entries
> - * @n_frame_start: start frame number for computed CRC
> - * @n_frame_end: end frame number for computed CRC
> + *
> + * @num_active_planes: Number of active planes
> + * @active_planes: List containing all the active planes (counted by
> + *  @num_active_planes). They should be stored in z-order.
> + * @active_writeback: Current active writeback job
> + * @gamma_lut: Look up table for gamma used in this CRTC
> + * @crc_pending: Protected by @vkms_output.composer_lock, true when the frame CRC is not computed
> + *		 yet. Used by vblank to detect if the composer is too slow.
> + * @wb_pending: Protected by @vkms_output.composer_lock, true when a writeback frame is requested.
> + * @frame_start: Protected by @vkms_output.composer_lock, saves the frame number before the start
> + *		 of the composition process.
> + * @frame_end: Protected by @vkms_output.composer_lock, saves the last requested frame number.
> + *	       This is used to generate enough CRC entries when the composition worker is too slow.
>   */
>  struct vkms_crtc_state {
>  	struct drm_crtc_state base;
>  	struct work_struct composer_work;
>  
>  	int num_active_planes;
> -	/* stack of active planes for crc computation, should be in z order */
>  	struct vkms_plane_state **active_planes;
>  	struct vkms_writeback_job *active_writeback;
>  	struct vkms_color_lut gamma_lut;
>  
> -	/* below four are protected by vkms_output.composer_lock */
>  	bool crc_pending;
>  	bool wb_pending;
>  	u64 frame_start;
>  	u64 frame_end;
>  };
>  
> +/**
> + * struct vkms_output - Internal representation of all output components in vkms
> + *
> + * @crtc: Base CRTC in DRM
> + * @encoder: DRM encoder used for this output
> + * @connector: DRM connector used for this output
> + * @wb_connecter: DRM writeback connector used for this output
> + * @vblank_hrtimer: Timer used to trigger the vblank
> + * @period_ns: Period of the vblank timer, used to configure @vblank_hrtimer and to compute
> + *	       vblank timestamps
> + * @composer_workq: Ordered workqueue for @composer_state.composer_work.
> + * @lock: Lock used to protect concurrent access to the composer
> + * @composer_enabled: Protected by @lock, true when the vkms composer is active (crc needed or
> + *		      writeback)
> + * @composer_state: Current state of this vkms output
> + * @composer_lock: Lock used internally to protect @composer_state members
> + */
>  struct vkms_output {
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
> @@ -103,28 +130,38 @@ struct vkms_output {
>  	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
>  	ktime_t period_ns;
> -	/* ordered wq for composer_work */
>  	struct workqueue_struct *composer_workq;
> -	/* protects concurrent access to composer */
>  	spinlock_t lock;
>  
> -	/* protected by @lock */
>  	bool composer_enabled;
>  	struct vkms_crtc_state *composer_state;
>  
>  	spinlock_t composer_lock;
>  };
>  
> -struct vkms_device;
> -
> +/**
> + * struct vkms_config - General configuration for VKMS driver
> + *
> + * @writeback: If true, a writeback buffer can be attached to the CRTC
> + * @cursor: If true, a cursor plane is created in the VKMS device
> + * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
> + * @dev: Used to store the current vkms device. Only set when the device is instantiated.
> + */
>  struct vkms_config {
>  	bool writeback;
>  	bool cursor;
>  	bool overlay;
> -	/* only set when instantiated */
>  	struct vkms_device *dev;
>  };
>  
> +/**
> + * struct vkms_device - Description of a vkms device
> + *
> + * @drm - Base device in DRM
> + * @platform - Associated platform device
> + * @output - Configuration and sub-components of the vkms device
> + * @config: Configuration used in this vkms device
> + */
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
> @@ -132,6 +169,10 @@ struct vkms_device {
>  	const struct vkms_config *config;
>  };
>  
> +/*
> + * The following helpers are used to convert a member of a struct into its parent.
> + */
> +
>  #define drm_crtc_to_vkms_output(target) \
>  	container_of(target, struct vkms_output, crtc)
>  
> @@ -144,12 +185,33 @@ struct vkms_device {
>  #define to_vkms_plane_state(target)\
>  	container_of(target, struct vkms_plane_state, base.base)
>  
> -/* CRTC */
> +/**
> + * vkms_crtc_init() - Initialize a CRTC for vkms
> + * @dev: DRM device associated with the vkms buffer
> + * @crtc: uninitialized CRTC device
> + * @primary: primary plane to attach to the CRTC
> + * @cursor plane to attach to the CRTC
> + */
>  int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>  		   struct drm_plane *primary, struct drm_plane *cursor);
>  
> +/**
> + * vkms_output_init() - Initialize all sub-components needed for a vkms device.
> + *
> + * @vkmsdev: vkms device to initialize
> + * @possible_crtc_index: CRTC which can be attached to the planes. The caller must ensure that
> + * possible_crtc_index is positive and less or equals to 31.
> + */
>  int vkms_output_init(struct vkms_device *vkmsdev, int index);
>  
> +/**
> + * vkms_plane_init() - Initialize a plane
> + *
> + * @vkmsdev: vkms device containing the plane
> + * @type: type of plane to initialize
> + * @possible_crtc_index: CRTC which can be attached to the plane. The caller must ensure that
> + * possible_crtc_index is positive and less or equals to 31.
> + */
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  				   enum drm_plane_type type, int index);
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 5ce70dd946aa..da69beb43ab0 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -21,6 +21,7 @@ static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
>  	int count;
>  
> +	/* Use the default modes list from DRM */
>  	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
>  	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
>  
> @@ -58,6 +59,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	int writeback;
>  	unsigned int n;
>  
> +	/*
> +	 * Initialize used plane. One primary plane is required to perform the composition.
> +	 *
> +	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
> +	 * composition.
> +	 */
>  	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
>  	if (IS_ERR(primary))
>  		return PTR_ERR(primary);
> @@ -76,6 +83,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  			return PTR_ERR(cursor);
>  	}
>  
> +	/* [1]: Allocation of a CRTC, its index will be 1 */
>  	ret = vkms_crtc_init(dev, crtc, &primary->base, &cursor->base);
>  	if (ret)
>  		return ret;
> @@ -95,6 +103,10 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  		DRM_ERROR("Failed to init encoder\n");
>  		goto err_encoder;
>  	}
> +	/*
> +	 * This is an hardcoded value to select crtc for the encoder.
> +	 * 1 here designate the first registered CRTC, the one allocated in [1]
> +	 */
>  	encoder->possible_crtcs = 1;
>  
>  	ret = drm_connector_attach_encoder(connector, encoder);


