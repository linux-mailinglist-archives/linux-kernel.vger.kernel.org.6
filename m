Return-Path: <linux-kernel+bounces-337789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCF984EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A88AB20DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD4188586;
	Tue, 24 Sep 2024 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RZfbnLFF"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236518801A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220503; cv=none; b=gJ6NLbmX4MAxt3aeUFn2TuCuF0HZohHdlVZFrSEMIjCkpUKgGQPW7TvZyYtATXXHN1bssWXkHwocvoF6PosHBANrDaYWflzM8uarzKzu5fFZvRyWHORbFHcQE6L/rZrYk7xE8eczOOSPDHcTe316vgwvfD0Hum/Q0zD5BMDpA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220503; c=relaxed/simple;
	bh=ITsHAe3KdXUZvi7NiPJUIO+czz8G3BcOEG81FvbDwIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXmHrlqXB/i1lSAsApWuy4TRt77n0Mkj2jsZCUZZNBba+tE3VRzM7yUsgZtA/L6HjIiLLruXhBj4Y4vX6K61EKm2TxKkUIse/tSO7q6bvjd73BgySiVl6kRSTms1kRhUC/g9p3Fj8uXjhcja3kPnFf0ugCn5k+U/zEVUOIqLcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RZfbnLFF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lVGrogRJ5/ibcpWwrkJ/fDzsxfjOA/jAdbQFGrsRUhY=; b=RZfbnLFFxJseapl1lA5GOGuQeS
	4tCdJlwJj9QF4RA7OpSV4wQvP/Nz4ZhBAujIm6eEf4Ces5PlkFsVetY66Oz18Aj4CfI2lDY9vBTAb
	B7xo34nyZ65URY5P6pt4vjUiSpwJnBxR3oFd7S7H/o95+FCXEwx2BB97QPHndrmN0GKJhexBzrhg3
	PRgQ42zCNXknhCNvkaBqiBGvh0tUJDxq4tokkf9/fNSkUne5JSlIqzD7/vij5viULc81dvMUZu5W7
	pA8VXoxUvWz9SawJn9jvIRKnXzPs9E0xbMnhRajkqhGxczBD16eFN+x7HBTadF7eo/nfx7aFezBsL
	lJ0jzO5w==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1stEwt-000eWD-P6; Wed, 25 Sep 2024 01:28:04 +0200
Message-ID: <5fc3e586-cc8d-4ee5-ad1a-23740d1075a1@igalia.com>
Date: Tue, 24 Sep 2024 20:27:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Use v3d_perfmon_find(..)
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Christian Gmeiner <cgmeiner@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240923152000.185980-1-christian.gmeiner@gmail.com>
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
In-Reply-To: <20240923152000.185980-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 9/23/24 12:19, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Replace the open coded v3d_perfmon_find(..) with the real
> thing.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Thanks for your patch!

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Applied to misc/kernel.git (drm-misc-next).

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/v3d/v3d_perfmon.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index cd7f1eedf17f..54a486a9b74c 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -402,11 +402,7 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   	if (req->pad != 0)
>   		return -EINVAL;
>   
> -	mutex_lock(&v3d_priv->perfmon.lock);
> -	perfmon = idr_find(&v3d_priv->perfmon.idr, req->id);
> -	v3d_perfmon_get(perfmon);
> -	mutex_unlock(&v3d_priv->perfmon.lock);
> -
> +	perfmon = v3d_perfmon_find(v3d_priv, req->id);
>   	if (!perfmon)
>   		return -EINVAL;
>   

