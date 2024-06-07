Return-Path: <linux-kernel+bounces-205981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC89002F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA19285C09
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7318F2C9;
	Fri,  7 Jun 2024 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="s/GLjwNj"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342F15A4A2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761790; cv=none; b=gbDkFs8VEpE3obc5sI06+9UcU2lcqRuWZWt4RapXcqTCbFZvyBEK3dUhSAmGSGXCU7z7F8tSH9PEPR6MeF4zQOrGuvF9UEEAcsv/rsVa04mpNfSwi+7m7/C/LeTqLlyQYYJjoJHJM/ug8uyOV80jpMVaZspKdpaa6IvX/A4sFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761790; c=relaxed/simple;
	bh=KmeA7Hp+ectQHT1nWYvVe5FCdGO/t++fiRlpFmSeqG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KttSvrQnAybbB7iVbSQEY0mQjptoFlGViXy0Dq91rfDpclTj1FNN4B7pLtRz+ob2mKlbOW3tak4w+IEqVA+zXf0gChNWB+U6RjYao0sDKF2jYwrVYQHrNMXedRaKik72CGxsddWThHnrbGDiV366nFwMbRr88ddyh8DpL3rbYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=s/GLjwNj; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1717761248; bh=KmeA7Hp+ectQHT1nWYvVe5FCdGO/t++fiRlpFmSeqG4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=s/GLjwNjTMvYUbTNV1Pq5ffs6tfHij1lsbCAVnymUN+S0JREZJT3PZjykzKAg4MDk
	 9+JxVBOVTgofYptMakEJ3+Bq+yLU8RVxQpk5+P5gPUTiPVs4A2REIzPZjBeOZ800v3
	 sZrYGgO4Jx3JADgNKZEd6wYnCQseima4IlfNj28c=
Date: Fri, 7 Jun 2024 13:54:08 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/3] Move blender setup from individual planes to crtc
 commit in sun4i-drm
Message-ID: <fpkbzbcuzwl5nqixhffzf3jjjungym3xba3xtpxqxnzza447dd@izuewtsaprsp>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240224150604.3855534-1-megi@xff.cz>
 <wynuwtyn2skchb7gc5qixql2pxnb2nqvbmrda6s53u7nt5ki7n@hqb46kttkhee>
 <2725781.mvXUDI8C0e@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2725781.mvXUDI8C0e@jernej-laptop>

Hi Maxime,

On Sun, Apr 21, 2024 at 09:52:58PM GMT, Jernej Škrabec wrote:
> Dne petek, 19. april 2024 ob 15:36:17 GMT +2 je Ondřej Jirman napisal(a):
> > Hi,
> > 
> > On Sat, Feb 24, 2024 at 04:05:57PM GMT, megi xff wrote:
> > > From: Ondrej Jirman <megi@xff.cz>
> > > 
> > > This series refactors blender setup from individual planes to a common
> > > place where it can be performed at once and is easier to reason about.
> > > 
> > > In the process this fixes a few bugs that allowed blender pipes to be
> > > disabled while corresponding DRM planes were requested to be enabled.
> > > 
> > > Please take a look. :)
> > > 
> > > v2:
> > > - use regmap_write where possible
> > > - add review tags
> > 
> > It would be nice to have this applied.
> 
> Maxime,
> 
> do you mind applying?

Pretty please :) It would be nice if this did not miss another merge cycle.

Maxime, this is the solution you hinted at back in 2019:

https://lore.kernel.org/all/20191003113802.tyecgkb6r3piin35@gilmour/

Let's get this fixed. Or anyone else who can pull this to DRM tree.

Thanks and kind regards,
	o.

> Best regards,
> Jernej
> 
> > 
> > Kind regards,
> > 	o.
> > 
> > > Thank you very much,
> > > 	Ondřej Jirman
> > > 
> > > Ondrej Jirman (3):
> > >   drm/sun4i: Unify sun8i_*_layer structs
> > >   drm/sun4i: Add more parameters to sunxi_engine commit callback
> > >   drm/sun4i: Fix layer zpos change/atomic modesetting
> > > 
> > >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  4 +-
> > >  drivers/gpu/drm/sun4i/sun4i_crtc.c     |  2 +-
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 70 ++++++++++++++++++++-
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.h    | 20 ++++++
> > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 85 +++----------------------
> > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 20 ++----
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 86 +++-----------------------
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 20 ++----
> > >  drivers/gpu/drm/sun4i/sunxi_engine.h   | 13 +++-
> > >  9 files changed, 125 insertions(+), 195 deletions(-)
> > > 
> > 
> 
> 
> 
> 

