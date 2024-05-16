Return-Path: <linux-kernel+bounces-180917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECE8C74CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28FE1C23EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E31459E8;
	Thu, 16 May 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EIG5CWO8"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F242145349
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856257; cv=none; b=l7Ivs+LJ5OLJrApSqZHJtPeOa4OYft+y1EHotmwBtS34fvngioCaxdbN4karHVFNbIWZ9ezyxHn7bKRVOkQHBlbPoHy4oq+JpDOPxfu1KPo5L2+jHfMDZgN1Szh1Bpunr3pum9IymnqmTfKQ59wxE4Gm+8wxVzsgklF0rv+YGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856257; c=relaxed/simple;
	bh=elcuRzbPwhsrH1xyXyzntGnfl1nBBo4p+zDIv+CsHfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEAYT3MCkIdSZudaRSQhtWZkrcynsryBPh2VMw20x+Bx9zbgDbQRuYueKv7ZyY5m7ZZVMspvVoV7tKe2NAhhRetLOxd089LtIJGaE7m6hUM79HPktt3uAbCW2PP+MciM1pzmCixg3E4subk5SDUdRvyHac4bJxHcxJav6/l9mnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EIG5CWO8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WsXuer6vlmF2frs6M0mRkWJUMiqFR4wogoKodqEE79Y=; b=EIG5CWO8wgD7/+bOl3BMH8D2LX
	jO9nWRjwkP+C5b2iszk5UomkWkA5PoAGZDt7TAHq7bs098DJPX+60JC9mlRZ029AfSNXgsooNw7ME
	/21Kw7T+gj2yAzzAgoeU7HanLtKHb61VeXEen3i1E1Fr6YPjq6Lq3wyAdcOVbKXxgIakvuze/tmgk
	QaKhxYfauSL/YJBEU62jbuUo/pfvMYxJMhgNrsMMGikV7pLioj2DFBJcp1/uaCeN27UiyBUJnTjTQ
	K1vcigcvoEx+yfcnvoCHWkxLy4PM1CSJHU16rgC/PWsXMlE8hRjlNJTtDkCkF3p7yt8DR9YWP68Kp
	sN/vloFg==;
Received: from [179.234.232.152] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s7YaC-008mbj-VF; Thu, 16 May 2024 12:43:33 +0200
Message-ID: <c83255f4-745e-43e6-98e0-2e89c31d569a@igalia.com>
Date: Thu, 16 May 2024 07:43:21 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/17] drm/vkms: Remove useless drm_rotation_simplify
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
References: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
 <20240513-yuv-v7-11-380e9ffec502@bootlin.com>
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
In-Reply-To: <20240513-yuv-v7-11-380e9ffec502@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 5/13/24 04:50, Louis Chauvet wrote:
> As all the rotation are now supported by VKMS, this simplification does
> not make sense anymore, so remove it.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

I'd like to push all commits up to this point to drm-misc-next. Do you
see a problem with it? Reason: I'd like Melissa to take a look at the
YUV patches and patches 1 to 11 fix several composition errors.

Let me know your thoughts about it.

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 8875bed76410..5a028ee96c91 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   	frame_info->fb = fb;
>   	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
>   	drm_framebuffer_get(frame_info->fb);
> -	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
> -									  DRM_MODE_ROTATE_90 |
> -									  DRM_MODE_ROTATE_270 |
> -									  DRM_MODE_REFLECT_X |
> -									  DRM_MODE_REFLECT_Y);
> -
> +	frame_info->rotation = new_state->rotation;
>   
>   	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
>   }
> 

