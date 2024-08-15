Return-Path: <linux-kernel+bounces-288061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FD95329D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F0C288D48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4491AC426;
	Thu, 15 Aug 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U6Sj2ZbX"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49121AC8BB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730747; cv=none; b=TdHkRs3QaysbR+xFZoU8wetgZt9p5AUwig1qMq7Bf1XBe/76chDP2YeOSpF+UUcoPLI6OPsFQjI1OkCQwXjprguu8u7Vy0aQUsdn8gwlkhFtTALHVQOL10yIVB7kUAbCOs5r1qRUYExbsYTPsuLeUgCqIDYt2psNJ5y0apfF+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730747; c=relaxed/simple;
	bh=IeXKyqGQMb5eLYg+RF5dz1Kw4oFOc5afAjnmgUiU/OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQFIVg/HtdZNsOwNz3bApSi3+ouSX01+2mGK5hzLJMoAisT0OCuQyCRWFuQz0iphz7je/U/E5BagzAFL52L0DvTy5WRzax3H7Pui0A5yySZ3Q4Ken+rBSTNxooo4KT8Mzsizt1qHlJCIiOq1mAT4aF0LtawTPvKMKO9D0obp3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U6Sj2ZbX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WUfv7OJc/PU4NaEESy5pBsrSe8xHadm8pC7Og5dgBmo=; b=U6Sj2ZbXAH4RrhmNigHv+tLjxU
	ReYKQDr7bYwPIilHf4jPXPSRQl6QKQrgyzRi2MXawuJDLTXL4WOwyDu6SqnrQ4rORrWl56n5IeiIo
	uu/e1xwp68nMxgsxIxDGjHkSXtqrkRs9zYsX3K0zyx0q8ppJmQYaXPH0VeYQd0q0mu3B8c7wTFkVq
	6FD4KFbZhRw3czpSAVFLq6UpoEca+Gw2MO+pNBoKKwYY1icZMqdSOnVjgs79E6UEpitIuE2LLmfMQ
	UgU0EylDGRsEaXtiDvN6xNTevDbFIWwBa9m0mFWci1ZXO85YSH1clHWvz6Oh8Wse56LpB5wP7u+rx
	d6NfyMTg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1seb6e-000dqO-Ql; Thu, 15 Aug 2024 16:05:36 +0200
Message-ID: <24a660e1-0f59-4214-96c1-aab29b266be4@igalia.com>
Date: Thu, 15 Aug 2024 11:05:27 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/vkms: Formatting and typo fix
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
 <20240814-google-clarifications-v1-1-3ee76d7d0c28@bootlin.com>
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
In-Reply-To: <20240814-google-clarifications-v1-1-3ee76d7d0c28@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/24 05:46, Louis Chauvet wrote:
> Some newlines were missing around comments.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Applied to drm/misc/drm-misc-next!

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_drv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 6860bee8e981..5aeb43592960 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -163,9 +163,11 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>   	dev->mode_config.max_height = YRES_MAX;
>   	dev->mode_config.cursor_width = 512;
>   	dev->mode_config.cursor_height = 512;
> -	/* FIXME: There's a confusion between bpp and depth between this and
> +	/*
> +	 * FIXME: There's a confusion between bpp and depth between this and
>   	 * fbdev helpers. We have to go with 0, meaning "pick the default",
> -	 * which ix XRGB8888 in all cases. */
> +	 * which is XRGB8888 in all cases.
> +	 */
>   	dev->mode_config.preferred_depth = 0;
>   	dev->mode_config.helper_private = &vkms_mode_config_helpers;
>   
> 

