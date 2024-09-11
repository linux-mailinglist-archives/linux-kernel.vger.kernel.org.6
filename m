Return-Path: <linux-kernel+bounces-324859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DAC9751AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C921C227B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CE189BBD;
	Wed, 11 Sep 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rgnrr0z6"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B2187FE3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056919; cv=none; b=ByWauWxvLL5E388CA4uWmR1AvimqOtqQdTDZg5ABH4A3KR4qLlwdf3iPb0Lh65KiPEKBXc9i3R3L87IHSrIAc34O8YbzySe5SWp3+DSLPT4qhE7cmg2ArQTX17Frutfl2/skKivXM8x4Yhp1WOro0MOqj1ivzNUA1EHNc3+86DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056919; c=relaxed/simple;
	bh=0bDf8RZWSXS8lmxyCpGBe1Jk8Eaw6bPgGk3l0o6yPzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2oicgj41ygojbjYdBRe133m2DVSiLGcZ3hRTubdhPtRg7nJaGylo0QCmh4mKncngiDy3TMC+xpOTrXi4OwVH9ve/rEaIJjpa60N2U+vg94L2Ylx0cnruqkywZ8PeYqjVP0jm26j3c6KcWVeyPv9NOUJogCm0Q4jZvBEcUVb4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rgnrr0z6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34F7D4000C;
	Wed, 11 Sep 2024 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726056908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdhTEPQQk02wc+pOBZoyGtVA8GtF9vfPKRysImY6ZaU=;
	b=Rgnrr0z6fQ4IXXpeAwlVOJw9IQV5uo3s7kGx7MGqe0XxySTghtLtsUwwyffeG5+kAfPN1w
	XwYpwJ7F5C+qWnGh9gDEFQiNd+T3TGBQHG6uSThhdbgeZSwFbljyu8VylR9GhXVHHuurq/
	DNuHyzKtx7pdxEp7gm8FkHcBN8sIqYkedYiuDyAeVp/qqsBAbuDXyRvnFI/tRM0NwOigeW
	6K/BgHyLFKrBRuIXtOUCo28AMImZ+m022ddbE9jnnZspRRmyh8TwBWR+rBvFN9NBAx2vfU
	vtSndq4owKg6nn750jcrjJpOs//P0ZNWSfD5mO7Q7unTt5D4QMOGt3tGJC1lKw==
Date: Wed, 11 Sep 2024 14:15:05 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Maira Canal <mairacanal@riseup.net>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, sean@poorly.run,
	thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
	seanpaul@google.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as VKMS Maintainer
Message-ID: <ZuGJyfhkQe93jKlz@louis-chauvet-laptop>
Mail-Followup-To: Maira Canal <mairacanal@riseup.net>,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, sean@poorly.run,
	thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
	seanpaul@google.com
References: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
 <68da3932-10ab-4001-a978-f0f54034a64d@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68da3932-10ab-4001-a978-f0f54034a64d@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 10/09/24 - 15:57, Maira Canal a écrit :
> On 9/10/24 12:10, Louis Chauvet wrote:
> > I've been actively working on VKMS to provide new features and
> > participated in reviews and testing. To help Maìra with her work, add
> > myself as co-maintainer of VKMS.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> Acked-by: Maíra Canal <mairacanal@riseup.net>
> 
> Please, check the procedures to apply for commit rights in drm-misc and
> apply it. This way you will be able to commit your patches.

Thanks for your support!

I just checked the rules to become a commiter, and it requires at least 10 
non-trivial patches, so I can't apply right now.

Few months ago, you seemed interested in merging few patchs from [1] ([2] 
is the last iteration and can be applied on drm-misc/drm-misc-next, and 
I just ran few igt tests, they pass), can you do it so I can apply to be a 
commiter? Thanks a lot!

[1]: https://lore.kernel.org/all/c83255f4-745e-43e6-98e0-2e89c31d569a@igalia.com/
[2]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/ 

> Thanks for volunteering!
> 
> Best Regards,
> - Maíra
> 
> > ---
> > Hi everyone,
> > 
> > This series [1] has been waiting for a while now, it was proposed first in
> > February. The first iterations had few reactions (thanks to Arthur, Pekka,
> > Maìra, ...), but since v8 (in May) no major issues were reported, Maìra
> > seemed satisfied, and only minor cosmetic changes were reported. Two other
> > series ([2] and [3]), that I submitted first in May, did not have receive
> > any reactions.
> > 
> > In addition, there is also some significant addition to VKMS being
> > proposed, such as ConfigFS support, and without a clear maintainer having
> > the time to review and approve these changes, these changes have very
> > little changes to get in.
> > 
> > VKMS is not a fundamental driver for "normal" Linux users, but I had some
> > feedback from userspace developpers that VKMS could be a very good testing
> > tool if only it had more features (I think P0xx formats were asked to
> > test HDR for example). This could also help to detect issues in DRM core
> > by emulating a wide range of configurations.
> > 
> > I believe the only active maintainer is Maìra, but as she's mentioned before,
> > she doesn't have much time to work on VKMS. So, I'd like to volunteer as a
> > maintainer. I have plenty of time to dedicate to VKMS.
> > 
> > I hope I've gained enough understanding of VKMS to be helful with this role.
> > I am eager to move forward and improve this subsystem. I've also talked to Sean
> > about this, and he agrees that it would be good if I could commit code to
> > drm-misc.
> > 
> > [1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/
> > [2]: https://lore.kernel.org/all/20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com/
> > [3]: https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 10430778c998b57944c1a6c5f07d676127e47faa..62f10356e11ab7fa9c8f79ba63b335eb6580d0a8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7340,6 +7340,7 @@ DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> >   M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> >   M:	Melissa Wen <melissa.srw@gmail.com>
> >   M:	Maíra Canal <mairacanal@riseup.net>
> > +M:	Louis Chauvet <louis.chauvet@bootlin.com>
> >   R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> >   R:	Daniel Vetter <daniel@ffwll.ch>
> >   L:	dri-devel@lists.freedesktop.org
> > 
> > ---
> > base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> > change-id: 20240910-vkms-maintainer-7b3d2210cc1b
> > 
> > Best regards,

