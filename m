Return-Path: <linux-kernel+bounces-337811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26091984F47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F165B228E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3EA927;
	Wed, 25 Sep 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gjGtXHew"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7B360
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222554; cv=none; b=ZGhotljdevrAmcAAQ3946OVfAAeGrxZmvCwYsAfogTm9C21o7CTwms3dp9CoDuzNIu3AyXbVHqEJtJbn70U7TbV18deIwvId/Jg5G2ZIxFm92oPeW+iEUGNXYVsImLlGlRO3+mYP66Tq6EgYTGMWUfbP8hLRIGJz+Xp69SovOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222554; c=relaxed/simple;
	bh=tXxbUDsZH+hWDNcWwWPa6+Q7aZx6qEyoh+5e4+aTNtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpRmtVdxIiniBF/VIUog7KcHS/4C/ObOL2hi5QXOU76FkO09mwoA5sE+omqrec21aic3kkZ9UgBAp1w8iG8gIycvEGMuAgPcTukfZSYZG/XSjkl46MJfRPmSqNhbGLSYjA1zaExLtqFvn+tQVQV7DUQAwV6Upkyqah9xANqiBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gjGtXHew; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0SnQ0AA3+TqSu/zwzB/OCIRlY7aAjCpZm794hil5pX0=; b=gjGtXHewnsAindT82Y8j38zsBA
	abKX8s35HB3+3TV1DbbXeg6NEz/4HU5TBTv4GNedDJ2vLMSH0mWAmMg9925pdibQ1pHv9EISyxXHX
	0RGhs6qMBqczGqOcnCCkoTfRQ7EisYspW93037oN2eKRZPu55FPILbxdhg3hh0o1KGrgdC9IqrpiK
	Bm2drqLhZ0reI2TnjoftPCPlHkqTZsbLJzjzVra0cBj0/RRon4IKZXReFbV3UztlsHTt8XTY9uM5y
	JIDeMMvec8ms++SomzoQmcXj0zAd4t33meCo4bcJg1/G/jAreq7E00GE9S3mXQA0w128ZWZjSqOIb
	wESZp8rg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1stFU7-000f2q-Ou; Wed, 25 Sep 2024 02:02:24 +0200
Message-ID: <7514151e-a8dc-4725-b05f-6ffe12ea3658@igalia.com>
Date: Tue, 24 Sep 2024 21:02:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Add missing check for CRTC initialization
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20240906-vkms-add-missing-check-v1-1-1afb3bf3d0a6@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240906-vkms-add-missing-check-v1-1-1afb3bf3d0a6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 9/6/24 13:15, Louis Chauvet wrote:
> CRTC initialization call drm_mode_crtc_set_gamma_size without the proper
> checks, introduce this check to avoid issues.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Applied to misc/kernel.git (drm-misc-next).

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_crtc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 40b4d084e3ce..e4f93dfbd071 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -287,7 +287,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>   
>   	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
>   
> -	drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> +	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> +	if (ret) {
> +		DRM_ERROR("Failed to set gamma size\n");
> +		return ret;
> +	}
> +
>   	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
>   
>   	spin_lock_init(&vkms_out->lock);
> 
> ---
> base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
> change-id: 20240906-vkms-add-missing-check-e1b6ee8d1b39
> 
> Best regards,

