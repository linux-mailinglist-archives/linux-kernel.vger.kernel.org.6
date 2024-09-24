Return-Path: <linux-kernel+bounces-337807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF5984F37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC2E284354
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610DD189B81;
	Tue, 24 Sep 2024 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TRHdvqKY"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C280C04
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222376; cv=none; b=fC4x8uW05h38tWVOtQe+puRsNlbrLImFZK/FKz+tYQSvKCRhgW3haZn8TgfGfyRPjQImbCymRh2qD6lPnPkKqyG4s1Luc7kRkgFCIQfJnoBVYSjfWBUL+gfZsw1cJbXLOQF+eN2q4o9lBFRxujkVwb30zAg9Tjq/YJgxqzCqaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222376; c=relaxed/simple;
	bh=80O5HoKlFOXLyt3+ci5WN+9I9yGxVQpDpPe4ZezkeSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwYIvxAmt2RpDP2shd2b7SRr7ySv8L7Bzmi5MEiGKA7Q/R70AmkKdqRgjCm2DA0G8oThcwe6+bJJDFP1vfpY3TfCC4IX5PYqEDmr+lJFfElwcrvbYFI+ups6PTZ/lxdtH8xc0WNhwqvWsV5uoEF9iNZMD8jpxMeWIEjDz7cItRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TRHdvqKY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KnkPkShAJnJABVLM8tVZtzLNR3Lj0DvaOqN+FYM6Vbo=; b=TRHdvqKYXB+j4l2H3rK0qWQ5gD
	p/se91807EjW7EMQGJs8IvFjOgBOxjylo1cSlHQMrlp6oOK/S+gDnA6ZszMyApgfmkLvjPmmh/JU0
	YGDU84P24tOqk10Eoy3AfjLij9n6uBs/B5qblVR5sQmJsi9FtUZZE/Hpdjpl+nDUSg3SVN8dgtrEr
	CB7mmb0195k4AAzlSJn8EuY64FF0hgqVrVDWadWIrPuqMa6aJFmQilyKZ5+d+K5V3XEj6ilxmJVZN
	RyzvB4bFQowHRdO7snqIO4S252Tk0Kv2AVCA6OaWLgzgYi8qRgrzTjPZezlqByCimgZoCWTcRk7Yg
	Bu4xkyFQ==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1stFRE-000eye-II; Wed, 25 Sep 2024 01:59:24 +0200
Message-ID: <70f98efb-728d-4a20-9b6d-04f0aff41cac@igalia.com>
Date: Tue, 24 Sep 2024 20:59:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Suppress context imbalance sparse warning
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240912-vkms-warnings-v1-1-59f3e13ea8e5@bootlin.com>
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
In-Reply-To: <20240912-vkms-warnings-v1-1-59f3e13ea8e5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 9/12/24 12:25, Louis Chauvet wrote:
> The functions `vkms_crtc_atomic_begin` and `vkms_crtc_atomic_flush` are
> responsible for locking and unlocking a mutex, respectively. Add the
> `__acquires` and `__releases` annotations to these functions to prevent
> the associated sparse warning about context imbalance.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

When I was applying this patch, I got the following warning:

137f51649b04 (HEAD -> drm-misc-next) drm/vkms: Suppress context 
imbalance sparse warning
-:4: WARNING:EMAIL_SUBJECT: A patch subject line should describe the 
change not the tool that found it
#4:
Subject: [PATCH] drm/vkms: Suppress context imbalance sparse warning

total: 0 errors, 1 warnings, 0 checks, 14 lines checked

Therefore, before pushing the patch, I changed the commit title to
"drm/vkms: Suppress context imbalance detected by sparse warning". Hope
you don't mind.

Applied to misc/kernel.git (drm-misc-next).

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 40b4d084e3ceef9e1e24b7338efdd9253afee8d6..2ad164b518fb93f5b6b86948116ff7ed97770b60 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -232,6 +232,7 @@ static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
>   				   struct drm_atomic_state *state)
> +	__acquires(&vkms_output->lock)
>   {
>   	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
>   
> @@ -243,6 +244,7 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
>   
>   static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
>   				   struct drm_atomic_state *state)
> +	__releases(&vkms_output->lock)
>   {
>   	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
>   
> 
> ---
> base-commit: d2194256049910d286cd6c308c2689df521d8842
> change-id: 20240912-vkms-warnings-e0e331bc5e6d
> 
> Best regards,

