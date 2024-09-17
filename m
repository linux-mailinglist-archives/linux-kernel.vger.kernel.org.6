Return-Path: <linux-kernel+bounces-331890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A532B97B280
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E1D1F236D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1017ADFC;
	Tue, 17 Sep 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx/NCXD5"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A1535DC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588934; cv=none; b=UxpV9gIkr9VKAG4nA6/lywMSkjFV2U25x52nHPBaire/fyLyjK08r6TbQnoitDTPlunTKy0fwwEPQiMKBv0NwqTJcll2nCLMLh3+9ARjuzRFhPfUSZwRaitR9cDYUtBfKoV7+PEi/a0r/kSMBD/9xc1z2Jlb3tKFIYgPK7gtNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588934; c=relaxed/simple;
	bh=a+ZtDv8d/uxaoD8zvaWZpMRDQw0xAPUyXBlwaDkgq4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeYLK7HPk4yJJovN1VeTpa9oqIOCNXmPTMFkAYodgfcVdiwFFqNgA+SCPyPMgiW/XonsgELBBoszNPPWxLGt/fQW0cf8K/eNKRdApi7HPOOrr1eU9FItk/XzS1XsJD1AiApIimp72NJ7sQGKK34ksUJkIzXA3mQ/odxcpfowvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx/NCXD5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c4d4f219so3795341f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726588932; x=1727193732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ2kpFeFLdbGF+A137Xx+ETnLLQvenh8K8lWZMBwrFQ=;
        b=Cx/NCXD5E84NQRA5ZhMGn1bdL+SRL+FciVzkjSCftXFPCEQrCLNpW1Z9DbHJbkcVWL
         xWW8UqNFthN2urcUAvyhMo0y12arhL8jnpRrYCAs8BcHwXZxkNgaO7tnhko506owXm1n
         1Vn6W8EboaahRzBCpuhcehCiEcdW04aEJpoWpu/2fptQTec6gUBroC21YOtQsLHP5F48
         ObyqP4Q3NywnMJ4QGu5wn8gYGcaDeiYQuKYQgiTNrWHfTUSLR66ly078i1Wy7uFHMFjB
         LVZaGOdUO7XOZ11NeKfZuDtX8Om9SNp7YH/PNid+9HStgOXZAubEZxklFIE3dnMAYkGQ
         2LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588932; x=1727193732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ2kpFeFLdbGF+A137Xx+ETnLLQvenh8K8lWZMBwrFQ=;
        b=QS2FGPGXHvXW25vaTVgfCatuKj8js3tLJewj8EG5G2xK3EDfQKhVb0OihyxnwP4AfT
         //wyf9Ll+WakG5+YpH+1NhuQfBWOxh1XUNUMGpvN14xjOGZOUyt4fryu4qK7GWGz+8vH
         Xt25GhG07EAscuviaaVjHwumNK0aRAkJ/kdquv03e8doD9IzLIOTFHh2N3iCPxGW5KZI
         CxNNP6o9jHP/3vOBWz5mMsfJfIhZ3oxas3XR+xHzoP3wtLFSNyR32WSbgDqbkbk+wbDW
         HL8I/aB05qiN6f8sfvh/xQd7ch534gbDLHIh+mNCn8AJBVP4XEchnarUCilwx3gcNdz8
         8whA==
X-Forwarded-Encrypted: i=1; AJvYcCWwf30v2enPScViKIhZoagPdOZwiMz1YJRcVvJ3oDT2Vxmi02TaCkh2sLpt7vf9/I/JX0Xy/F8ZRu9ZbNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NXTt1MRmU7dppuyHuwJh+AwLsGAZ/Fo9Zr4Kinw4DqjN5TRw
	PkmaRRd/5H0uxYUKuLjtefpadpn69lHpVOwUlQ1B+dwDE6b/zq0N
X-Google-Smtp-Source: AGHT+IHioo9a28Ru6/eF1RALT0ZFzsAo4lSr4L6cvJDWE0PXq4Pgw5lZOeUlpwrmDgrpqTHRxQD1oQ==
X-Received: by 2002:a5d:4b82:0:b0:374:babf:ac4f with SMTP id ffacd0b85a97d-378c2cfec6bmr11389925f8f.12.1726588931662;
        Tue, 17 Sep 2024 09:02:11 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4c5esm9976021f8f.2.2024.09.17.09.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:02:11 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vkms: Add missing check for CRTC initialization
Date: Tue, 17 Sep 2024 18:02:06 +0200
Message-ID: <20240917160208.2905-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906-vkms-add-missing-check-v1-1-1afb3bf3d0a6@bootlin.com>
References: <20240906-vkms-add-missing-check-v1-1-1afb3bf3d0a6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

> CRTC initialization call drm_mode_crtc_set_gamma_size without the proper
> checks, introduce this check to avoid issues.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> 
> ---
> base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
> change-id: 20240906-vkms-add-missing-check-e1b6ee8d1b39
> 
> Best regards,
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 40b4d084e3ce..e4f93dfbd071 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -287,7 +287,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>  
>  	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
>  
> -	drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> +	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> +	if (ret) {
> +		DRM_ERROR("Failed to set gamma size\n");

This will conflit with "drm/vkms: Switch to dynamic allocation
for CRTC" [1], where you switched to DRM_DEV_ERROR.

No proferences about the log function, just a heads up so when
you rebase one of the patches we keep logging consistent.

[1] https://patchwork.kernel.org/project/dri-devel/patch/20240912-b4-vkms-allocated-v1-3-29abbaa14af9@bootlin.com/

> +		return ret;
> +	}
> +
>  	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
>  
>  	spin_lock_init(&vkms_out->lock);
> 

