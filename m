Return-Path: <linux-kernel+bounces-447759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F019F36BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13796161D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0497C207A19;
	Mon, 16 Dec 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MSLioiM6"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77324207A0A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367855; cv=none; b=Je9Ya5rpau9gQ3sZRaehAHKo7Hvk9ZooowK0sXgpyEz7X+fUjNOrwCMKVdI87+Fo14u9SmffbWfvrGVjKUUGd3C08t3I5jkloWFlR8IIZsEWxcflwssJ0GfeFajijWLee+w3MAjGzOawPWSjhe7MQETc+iwht3qgjURRp6KR5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367855; c=relaxed/simple;
	bh=98Lk/9s3CHx7uR0XFhLogMFYoSPvduqG9YmtOH8E0k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDktDBCtwGObZl7VN9AYPbQKHGdMxjmku42h0y2IDP8tAXvDcAijpx80JwajCkVsZCza7noG9KiVqQEG22zJbsJOhK5C1GW9H/v6HGjcy05rL2xqXB/y5lLc+uKdc64hzXQzrcOTws6LlIlDD+m/120ox7seyMIKzrCPmxEtW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MSLioiM6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D55840004;
	Mon, 16 Dec 2024 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTytGv3WQcBnidhebGgtCZuLrG7i4GACKz2UZcaQGQ0=;
	b=MSLioiM6Hdj5HCpPeZdFR6vg+rQWmvXd8ekLs8bYjyds4PiIgkoznw45E7m9SZHCpH09ev
	bc8ByB+Jc374cf9141dHB8zcnBdY44cf3bll/AG5A9bIudKjQVCcnctTTPbBHWVEXW9N2P
	cpimBYGo2kfdQx1mD6Jasgf2KKbNCCfjlAzlMJ4DZNhVD3IzP7P5satP9U5oBtBILgZb7e
	/AP7tyCLNuyHV7/Kb2nQ/VfoOnc2qwPz1Sjh/TaZv8Mldfny8a/gl3HxgGtH1RK89V5Le+
	38RkYE7tXFxpwU+y2RQzblDAFcIzx8/QVygDLyEug/HbxfoMK6VqPsqrw5Eh2Q==
Date: Mon, 16 Dec 2024 17:50:44 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 4/4] drm/connector: warn when cleaning up a
 refcounted connector
Message-ID: <Z2BaZDDwnQo4ppS0@louis-chauvet-laptop>
Mail-Followup-To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
 <20241216-drm-small-improvements-v3-4-78bbc95ac776@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-drm-small-improvements-v3-4-78bbc95ac776@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 16/12/24 - 17:40, Luca Ceresoli wrote:
> Calling drm_connector_cleanup() should only be done via the free_cb =>
> .destroy path, which cleans up the struct drm_connector only when the
> refcount drops to zero.
> 
> A cleanup done with a refcount higher than 0 can result from buggy code,
> e.g. by doing cleanup directly in the drivers teardown code. Serious
> trouble can happen if this happens, so warn about it.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>  drivers/gpu/drm/drm_connector.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index fc35f47e2849ed6786d6223ac9c69e1c359fc648..e0bf9c490af43055de4caaee1580a4befbd608c5 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -624,6 +624,12 @@ void drm_connector_cleanup(struct drm_connector *connector)
>  	struct drm_device *dev = connector->dev;
>  	struct drm_display_mode *mode, *t;
>  
> +	/*
> +	 * Cleanup must happen when the last ref is put, via the
> +	 * drm_connector_free() callback.
> +	 */
> +	WARN_ON(drm_mode_object_read_refcount(&connector->base) != 0);
> +
>  	/* The connector should have been removed from userspace long before
>  	 * it is finally destroyed.
>  	 */
> 
> -- 
> 2.34.1
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

