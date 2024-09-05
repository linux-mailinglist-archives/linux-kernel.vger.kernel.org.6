Return-Path: <linux-kernel+bounces-317053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F596D8A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D602856AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E434198E74;
	Thu,  5 Sep 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDDXkmkE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232219B3E1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539632; cv=none; b=cllHMUAHOUn/cWNl/QvffuzZSTBgaAMi+S9umOzCxuUABg0BHl9eu/Qkh2l6BOEBFI7bq+m1R6yeRp5C7IoUqKdC8POxISHc7poAVhdVovmqeQmV139hyT5xDLwAgQJKK4E3fPV/F26Twot2Y+USYSF8sQF4vbgkxvGUscT7XaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539632; c=relaxed/simple;
	bh=jiVdZGCaBqbVJBAywINeIrU+EjM4F/0hbXqnmjjaO0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7lk2AvB+hTfy1eQ8E+dQLpPHLHiEZ0hkTMrxXDtyFYQMD2V9KzL7tZNPLU51flQmUmeLzbDTpa5ARJ3lG2N717z68/7KDq/193JxcXZk1lj//qEAdh43d8lCqWObNi8IjLfjCzDPr3ZOSi6kMOlxbkgMhsnT8sBWw0+or76pBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDDXkmkE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so6041235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539629; x=1726144429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwuyy1ZNTgxFINfUg5AqR7+zgE8pTpBHNg7t5awDUAo=;
        b=SDDXkmkE92/nlJI2+vLRp86kZIsCMQUsoUEZ1T6fDAqtScZL7SMI0ptugm4eMS+UKF
         L8X/5rJq/ahzchEqZQ8td7OYwB3sD8bQzy2etfIvbKNqFCSnCcZc4N4naWWfp25INbhR
         MywFkKnr3IphCSSmyft/DFepGdJvOMNCqwgzuGr0qZ46hLP3dtw9f2imdBiQw9nDSgKR
         S9UNj2Yr1fKoM9ztA4DFEHZRSIZSpfoWYfRGWXevOkidaV3/BTEMx68Kf9PxzjrQj5r1
         Iwd4o4fBfd0ZPWFFzzCivvK+7feUWZ04Pj1Qum8Xg93JKxTtwFLk8WOsMkKq0dvZ+UPT
         oouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539629; x=1726144429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwuyy1ZNTgxFINfUg5AqR7+zgE8pTpBHNg7t5awDUAo=;
        b=DIV9+eKYeI5W0Zq6V5VS4JF9BuVLV1/k4N49KaYnb7ZPZ4KgOhikD5nrpMFG5So/L2
         Ec7RHRFuyji66XQYoZRjnFKQAKJNF1iYgCs2wa6SLccG1PjPUC0kyBGrNogrYHzO0jeU
         a04VVJMlmwJWtwx5kfy5KKcSoj0sE32Ar3vDC/b+Wxio218s8zkDgwL3jaAKgMqsO51J
         flhgNyb7PlCqljyoVhup0RMvba3m+DqR/l/t1Nn5LdepZVYorvuCdQzcvtl17POMHwkI
         6i1ssXeITE++sIXoHPJavJVno3AKiGHRjyWoivxuEgVrwiP/YHfV+DSdVVgxySjDSDyj
         ItvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1SwODFS2774LfK4AwE9iDn9m50Dre5cSNkhcfb/NcODrb0bKfGkRj83CgoDo/0fCL2sAM/BFas+gH/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wRLM3bOWZIusJZ8MYLeQ7/DkuYBEpE5wucc4cyySc2j2rBW3
	Pgw2Ae5T1Zqz5aiT7NY8EDl6+SEz9lWeeenhTI2CvWJKW3leIWOD
X-Google-Smtp-Source: AGHT+IGrgigEpAIROvdA9Bok6YQnXL840jLtlYO2J4UtOSMk3zjwzp97SOCB6TgiRknRHwViOo3xbA==
X-Received: by 2002:a05:600c:a06:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-42bb01c0f9fmr178461415e9.21.1725539629190;
        Thu, 05 Sep 2024 05:33:49 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c17fed40csm185844995e9.0.2024.09.05.05.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:33:48 -0700 (PDT)
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
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH RFC 04/15] drm/vkms: Add a validation function for vkms configuration
Date: Thu,  5 Sep 2024 14:33:48 +0200
Message-ID: <20240905123348.3077-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-4-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-4-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As the configuration will be used by userspace, add a validator to avoid
> creating a broken DRM device

This is something I considered to include in my configfs series, however,
I'm not sure if the set of rules used to validate a device configuration
are already implemented somewhere in the DRM core and we could try to
expose them to avoid duplicating them.

I'd be nice if someone with a better understanding of the DRM core code
could give us some pointers about the best way to implemet these validation
rules.

Also, if we end up implemeting the rules in VKMS, it'd be nice to print
to dmesg some information so the user can figure out what and why failed.

> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c |  5 +++++
>  drivers/gpu/drm/vkms/vkms_config.h | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index ad5d814e6e83..d8348af9587e 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -21,6 +21,11 @@ void vkms_config_destroy(struct vkms_config *config)
>  	kfree(config);
>  }
>  
> +bool vkms_config_is_valid(struct vkms_config *config)
> +{
> +	return true;
> +}
> +
>  static int vkms_config_show(struct seq_file *m, void *data)
>  {
>  	struct drm_debugfs_entry *entry = m->private;
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index b28483173874..363f5bc8f64b 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -29,4 +29,18 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device);
>  struct vkms_config *vkms_config_create(void);
>  void vkms_config_destroy(struct vkms_config *config);
>  
> +/**
> + * vkms_config_is_valid() - Validate a configuration
> + *
> + * Check if all the property defined in the configuration are valids. This will return false for
> + * example if:
> + * - no or many primary planes are present;
> + * - the default rotation of a plane is not in its supported rotation;
> + * - a CRTC don't have any encoder...
> + *
> + * @vkms_config: Configuration to validate
> + */
> +bool vkms_config_is_valid(struct vkms_config *vkms_config);
> +
> +
>  #endif //_VKMS_CONFIG_H
> 

