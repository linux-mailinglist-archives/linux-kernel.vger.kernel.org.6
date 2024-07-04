Return-Path: <linux-kernel+bounces-241012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70479275BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5711C21B89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A81AE0A6;
	Thu,  4 Jul 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eIC8EBds"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453519409E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095034; cv=none; b=cZCnpuNHA/hNisYNO7qis35U0VL4bfVP3Xd5PRed/tHl2cnB1zUPngQeyeKyw3LRhdiOQt7tGuvlgjuhOswzzTRIF9tJ+MjkZZ/AQCpIzHXhXBkIDMeB8vbWZcOYt2jTT4LrFvsbXvYWJ37I14wdQMYqSGKf7hDMtzJl+x2eA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095034; c=relaxed/simple;
	bh=BAf5VAA3Uw6QdJNR9ZGFb03WBNfn2L5SWcXmeMhKAQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQrE1LuhoZxwRE3HRcm4CNIpVRCpMaigx0BKhPsHv2DKFtLHRUdnY/lF/LRK19wxR+9zgA/I+z41WMFGSubkLGsY7efRxTsxsN5ZT4Pup/lRysINvfVsjJNxjbRc27eTXMM+ajKf4ClZzPNLr89zaFCJUK4IWbkdj81JYm9NngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eIC8EBds; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wvGPA+uFp9q5GPv2Hy9Yn5IXdEOa9ACphERR99unxkQ=; b=eIC8EBds9Za8+6toLlsI+Gt55E
	APf4QxvuAmD3cMe+4yGrUMvrfgfahXE3mTCRdiXgpJ4Q6V9avv0SwxqS/Qs0zISIWNxUznJ/wXhgV
	AUQM8xayQYpRnoCncMkl8YSgzEMDIHZiGOyII3UWHt9pjG6yd+yvr84UxgIsnkE3B2CO/MFQaJc8b
	nmXoc993GOPfHGimBy94ff1q6xlSmE+VLiJ3bjs6RsvWa4kKl5GHCdf2WrgE16sqhx8xkQOF1Eatq
	BB8az0u3KNDNN6Mi5+aWZ9SfOXdhzvFvi55nBzIxCmt+v+kGYOmvZTEYrmIbh96TRcVOvhjhl4RjR
	04hECBjA==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sPLHv-00B5Zl-Si; Thu, 04 Jul 2024 14:10:12 +0200
Message-ID: <bdebd2b3-d1e3-4d01-b6da-ec369aa8b0b8@igalia.com>
Date: Thu, 4 Jul 2024 09:10:04 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Remove event from vkms_output
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, open list <linux-kernel@vger.kernel.org>
References: <20240703160458.1303872-1-lyude@redhat.com>
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
In-Reply-To: <20240703160458.1303872-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 13:04, Lyude Paul wrote:
> While working on rvkms, I noticed that there's no code that actually uses
> the drm_pending_vblank_event that's embedded in vkms_output. So, just drop
> the member from the struct.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Feel free to apply it to drm-misc/drm-misc-next! Otherwise, I'll apply
it over the weekend.

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_drv.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 8f5710debb1eb..5e46ea5b96dcc 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -103,7 +103,6 @@ struct vkms_output {
>   	struct drm_writeback_connector wb_connector;
>   	struct hrtimer vblank_hrtimer;
>   	ktime_t period_ns;
> -	struct drm_pending_vblank_event *event;
>   	/* ordered wq for composer_work */
>   	struct workqueue_struct *composer_workq;
>   	/* protects concurrent access to composer */

