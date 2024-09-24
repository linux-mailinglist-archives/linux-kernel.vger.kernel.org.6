Return-Path: <linux-kernel+bounces-337805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05BC984F30
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6ED1F245F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DE1898F2;
	Tue, 24 Sep 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FLL/HYX+"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A780C04
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222154; cv=none; b=YNo+fMzMSzm9kVuiFYeg/H29ZoVFj6+6XGz+kJidnnTtjz52JxP2f8sNma4Hor5UX/Y3FVSQ9NkAUcnaXJVo7oy4DaJCUust4GUPifg9FbEiTTNxN1onb4WNLtEWre1dZ+QzKpFRnEQvgzx5bE4qRYQTTtSyOS7+bJz+X/MqObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222154; c=relaxed/simple;
	bh=Fbhw0FmbgXb3zUGasUw2MtRDANFWTbCt/XRq0WZhNDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYbnnICH9tFd9XYXyS3SMByZov/UkvQLUO/DpZo4ubv7FfdiG/iWDMcIwaNaBwtNbR6E9JS4RTlefIS6H/wxb7Fk8K1fxpLLqA1he8wMJgpxTw2Zm94dw9kQ5zve4v1BlfTZVg9fhFXxwvj/GB/B20hCyV2mBG/QHi5FzvdCc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FLL/HYX+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vMeg85SAmWjRatEDJOqhz6rV23+6rZWVMuFi4NmG6gM=; b=FLL/HYX+jWFvxaatQpRUrZsYP+
	sMd8s+VLiQB9X8UQc5wWBliXiPlUsGWpt9p+mmrMW8/IwdeuSIlqLZst7chPkIwrtTNoDr+WHbftG
	UDgzlTnuwk1eEU9iomiIbselEQIUBaAjv+z51gvntgd7qj2PZn4xuF/rhSqUFaMZM0OGljAIYEatW
	8Rh7i38ROtP/oFW7ueTXhApwqzt+rVYYHWWuxYKn3Jm2NtABBT2vM8Jnl8YLouyEO2NPqwSTnccKd
	vLnppGqDqzkbtH065BVzmZI4OyMJ3S/NMx6VdSLQvQt69jPP43ovJqYeIo4wYZRrP0c25/lF1ZHWw
	oz8omSgw==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1stFNf-000euy-PG; Wed, 25 Sep 2024 01:55:44 +0200
Message-ID: <7bef0a63-6634-422f-a2d1-c642b9226845@igalia.com>
Date: Tue, 24 Sep 2024 20:55:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove myself as a VKMS maintainer
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240911135051.44579-1-rodrigosiqueiramelo@gmail.com>
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
In-Reply-To: <20240911135051.44579-1-rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siqueira,

On 9/11/24 10:50, Rodrigo Siqueira wrote:
> I haven't been able to follow or review the work on the driver for a
> long time and I don't see the situation improving anytime soon. Hence,
> this commit removes me from the maintainers list.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Applied to misc/kernel.git (drm-misc-next).

Best Regards,
- Maíra

> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 333ed0718175..1e6356a1b6c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7346,7 +7346,6 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/udl/
>   
>   DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> -M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>   M:	Maíra Canal <mairacanal@riseup.net>
>   R:	Haneen Mohammed <hamohammed.sa@gmail.com>
>   R:	Simona Vetter <simona@ffwll.ch>

