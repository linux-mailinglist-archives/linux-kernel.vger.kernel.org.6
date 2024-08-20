Return-Path: <linux-kernel+bounces-293587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30F9581AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4009F1C23D41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179918B463;
	Tue, 20 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHEvmiQJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5D1494DF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144977; cv=none; b=HEAZdInGHurJ0COtv1JXj5Ml0mKPSxJxRgY98aVGixVwMOSBHyKxtlTMGTugay+6SKPFideN4VbbMXMczGkkBzsfzJa7hVfq1h1EidN0umU9wNZGEPuIkhZ++ZPWl5Mbgik/4FSw0gOGKjckGwaJkoUZOr/ZiInbSmTfkzKUFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144977; c=relaxed/simple;
	bh=RzkLK2hYLPH6njdsvoeQYXdvnDp31t+YCNi0d69E7Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWGxG06hrtXsWTpT04KQAp1WjAyShj76+PtiQ5WVsY8Lvu1BiUqrh5uAGaXC4RyBcevxpUXLQ68yw0xtXPjaHdrnhcNg9Q6EveAgBoAHQiw7mZMQJ446tbulb/IYJwnF3VI0YAEiy8x2J97wZkNJMlxbEuxlK06n1j3yaqcp9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHEvmiQJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371afae614aso1773708f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724144974; x=1724749774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krCYSxdDpTQrVUrzWiIkCh5CYHoHUCK7xs+My+FCoPs=;
        b=hHEvmiQJskuIgrtQNo5MyZlyW/51s5cIv7VTLNHW1XUfqw+O5XxFaU5u2mr2+3QFp2
         +yf2TZ/Fibl8c8QWd1pAyao1/3hbhXuSWo4MjHIK0pDkSioj++i5zDBENJJrvoI1/Hmf
         fGDSRzCL/bodWVyQ164gepohQRslPBstznVIVesDT0HBNIDfpJWvKbyI6ctlOA83yu3y
         8vcW4b4jeBK+gdu2ORlDdH9qYjJBu3NAkWzes+PNsYvpA6CaarCQLmnNi23LSpy+q2tn
         nUcyczMLg953/GAGoQSgeXhNqi2noWvBaszPCWvSKJFzZmHneGLpxYyBT42r1D2XYoO+
         WYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144974; x=1724749774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krCYSxdDpTQrVUrzWiIkCh5CYHoHUCK7xs+My+FCoPs=;
        b=WdAGgX0SP2r2Mh4UTp9zrrKqWgb3dJg6TQ76rsCr93s4UsWmvkDXHku2FY8oNexT0Z
         hrdWNpnDuoUYWukeAW5pBXOUaB9mrBvLbR3HUIy/sdoFFyAAbZRctuoWU8pEGi5xCn54
         yuwUxDXzhRWI5HB4FC1aFBY3ueGb7xzOzTrPI221sp9vw21fwb/BIlLHOrunnWo+GSO0
         vzh77OyQI0mxMFcMlfCEgCy+66Vo0PKZU6NvZLznM81l5YeLF+aC4biLoFw3Cr8Jr01y
         9xFo+IUWj/uY8vY/yyFl4xSA2iNwZrWISR2hy+L9oulwgNg3Mg3F0FQbFVL6t593pIIi
         hQCg==
X-Forwarded-Encrypted: i=1; AJvYcCX6XMCha2+c1OrxsRQGX7WJJKF5NhmM4Gwfe5fIHZ2WpAcZyCbrps5XUPV6cHhniF4W5naYBnKIIO1E69A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZY7YiAzAFjbTmXhY7vxFiSAeA66n4/LpOyIGX0YqgB/p8q9km
	xm72ZFWN6sLRzmSOcMWrM/DWBWLWLalYa946XYa4/SA3qolzs2X7
X-Google-Smtp-Source: AGHT+IGSlYSQWy5PrGTd8Jc5PKw3jaHd5f4fetH8Kiozuh65q2Zh7ztB+yLnmScukC/b+W02t6l4kw==
X-Received: by 2002:adf:e78d:0:b0:368:460d:d942 with SMTP id ffacd0b85a97d-37194646be4mr7681089f8f.24.1724144973344;
        Tue, 20 Aug 2024 02:09:33 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac074sm12557067f8f.106.2024.08.20.02.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:09:33 -0700 (PDT)
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
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RFC 2/4] drm/vkms: Switch to managed for encoder
Date: Tue, 20 Aug 2024 11:09:27 +0200
Message-ID: <20240820090930.2869-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-vkms-managed-v1-2-7ab8b8921103@bootlin.com>
References: <20240814-google-vkms-managed-v1-2-7ab8b8921103@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The current VKMS driver uses non-managed function to create encoders. It
> is not an issue yet, but in order to support multiple devices easly,

s/easly/easily

> convert this code to use drm and device managed helpers.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
>  drivers/gpu/drm/vkms/vkms_output.c | 21 +++++++++------------
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index cea7b2640c5d..2c9d1f20ce84 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -42,7 +42,6 @@
>   */
>  struct vkms_output {
>  	struct drm_crtc crtc;
> -	struct drm_encoder encoder;
>  	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
>  	ktime_t period_ns;
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 4767838c3a73..cb8507917b5f 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -16,9 +16,7 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> -static const struct drm_encoder_funcs vkms_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> +static const struct drm_encoder_funcs vkms_encoder_funcs = {};

This struct is not required, drmm_encoder_init() can take a NULL value.

>  
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
> @@ -55,7 +53,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector;
> -	struct drm_encoder *encoder = &output->encoder;
> +	struct drm_encoder *encoder;
>  	struct drm_crtc *crtc = &output->crtc;
>  	struct vkms_plane *primary, *cursor = NULL;
>  	int ret;
> @@ -103,8 +101,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
>  
> -	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> -			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	encoder = drmm_kzalloc(&vkmsdev->drm, sizeof(*encoder), GFP_KERNEL);

&vkmsdev->drm => dev

> +	if (!encoder)

The same here, we could log this error:
		DRM_ERROR("Failed to allocate encoder\n");

> +		return -ENOMEM;
> +
> +	ret = drmm_encoder_init(dev, encoder, &vkms_encoder_funcs,

vkms_encoder_funcs can be NULL.

> +				DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init encoder\n");
>  		return ret;
> @@ -118,7 +120,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  	ret = drm_connector_attach_encoder(connector, encoder);
>  	if (ret) {
>  		DRM_ERROR("Failed to attach connector to encoder\n");
> -		goto err_attach;
> +		return ret;
>  	}
>  
>  	if (vkmsdev->config->writeback) {
> @@ -130,9 +132,4 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> -
> -err_attach:
> -	drm_encoder_cleanup(encoder);
> -
> -	return ret;
>  }

