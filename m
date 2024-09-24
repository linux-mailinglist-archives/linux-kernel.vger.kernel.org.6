Return-Path: <linux-kernel+bounces-337803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F019F984F29
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D61C230C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371B818953F;
	Tue, 24 Sep 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sDwmszgT"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DB80C04
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222116; cv=none; b=kuSDvTZ45+pOVPFsS7SLxFO+FG9ay3X/Zq2ggYQ/OrRHD2hKKygTkX7A7Nd/AiaDogMaf3fsxZG2C9qTOZvFUTnUBHyZYyok9czmnddY8XDPTHf6PAWOQfXyTyPxxRuDDhwpspKLdzV90EosSLp1Ek8GuqEEHrgQhQAHyawZ2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222116; c=relaxed/simple;
	bh=GJtnJzORqAh6/E7jfXQMZl0jxCwqSXhHzjjLqk8cQLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDFjJ8psAFbQ6aJOJGsJEyGGjU1fv57gFEBCPac9AZtMCx/RFPZMF7qXi6lAlVBVWzP4Vd/zZFVocKcCIPd1K2CGhE2rOpq/3m18jHPyr/4sF1YB8myxjmN6fTp5J8ega1v+m+2s5SZP9+B7lRHb22UxB3fDXrjmA9qT2ZFB924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sDwmszgT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gAdoxsJnaX+NHAHvP7D1xgUfSXboS41UK2Hpt4Od49M=; b=sDwmszgTsnKZQOCZQKL0QrqgR5
	P4aAWM/2d5i+ERVcssvTmKMVnFlr6WEWxiZFjG0Y6cg+Q73Kly3D5LjOai+xltBSfbDDz2oaFVSlO
	z8rKJCdPvZtvH47b62NjpVRDJDXujewt9sdZgpPwb+nnmLD8MwYUM+zGDBj2MUfhOhOgGNEYJnPC7
	axvzxH2pXch1g4RumqPADlCcmqQmxrbOLnOMh1idGtOaNIZ+ydwrCLYMazYu6+7Xo2dzqgMXmrd8G
	XF6/+LBdsTFn9Ft1nz4SedL8L8QDsa0VaEf0AJXAtpVvqdSx9OuI7b4/hM5O3SxbiBGoG4wro75Nb
	YegaYfnw==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1stFN2-000euF-VI; Wed, 25 Sep 2024 01:55:05 +0200
Message-ID: <55fa8756-1082-45b9-8edb-5b3fd6722e08@igalia.com>
Date: Tue, 24 Sep 2024 20:54:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as VKMS Maintainer
To: Louis Chauvet <louis.chauvet@bootlin.com>, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, sean@poorly.run
Cc: thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
 seanpaul@google.com
References: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
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
In-Reply-To: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 9/10/24 12:10, Louis Chauvet wrote:
> I've been actively working on VKMS to provide new features and
> participated in reviews and testing. To help Maìra with her work, add
> myself as co-maintainer of VKMS.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

I see that you're now a developer in the drm/misc repo. Therefore, I
applied this patch to misc/kernel.git (drm-misc-next).

Thanks for volunteering!

Best Regards,
- Maíra

> ---
> Hi everyone,
> 
> This series [1] has been waiting for a while now, it was proposed first in
> February. The first iterations had few reactions (thanks to Arthur, Pekka,
> Maìra, ...), but since v8 (in May) no major issues were reported, Maìra
> seemed satisfied, and only minor cosmetic changes were reported. Two other
> series ([2] and [3]), that I submitted first in May, did not have receive
> any reactions.
> 
> In addition, there is also some significant addition to VKMS being
> proposed, such as ConfigFS support, and without a clear maintainer having
> the time to review and approve these changes, these changes have very
> little changes to get in.
> 
> VKMS is not a fundamental driver for "normal" Linux users, but I had some
> feedback from userspace developpers that VKMS could be a very good testing
> tool if only it had more features (I think P0xx formats were asked to
> test HDR for example). This could also help to detect issues in DRM core
> by emulating a wide range of configurations.
> 
> I believe the only active maintainer is Maìra, but as she's mentioned before,
> she doesn't have much time to work on VKMS. So, I'd like to volunteer as a
> maintainer. I have plenty of time to dedicate to VKMS.
> 
> I hope I've gained enough understanding of VKMS to be helful with this role.
> I am eager to move forward and improve this subsystem. I've also talked to Sean
> about this, and he agrees that it would be good if I could commit code to
> drm-misc.
> 
> [1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/
> [2]: https://lore.kernel.org/all/20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com/
> [3]: https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10430778c998b57944c1a6c5f07d676127e47faa..62f10356e11ab7fa9c8f79ba63b335eb6580d0a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7340,6 +7340,7 @@ DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
>   M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>   M:	Melissa Wen <melissa.srw@gmail.com>
>   M:	Maíra Canal <mairacanal@riseup.net>
> +M:	Louis Chauvet <louis.chauvet@bootlin.com>
>   R:	Haneen Mohammed <hamohammed.sa@gmail.com>
>   R:	Daniel Vetter <daniel@ffwll.ch>
>   L:	dri-devel@lists.freedesktop.org
> 
> ---
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> change-id: 20240910-vkms-maintainer-7b3d2210cc1b
> 
> Best regards,

