Return-Path: <linux-kernel+bounces-447336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054999F30BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2360166AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2A204F9F;
	Mon, 16 Dec 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJWmWmDd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5248204F87
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352923; cv=none; b=SKBRsLKy+mkn3+PNj3sIcdXSB7i+JPQrwqGRd7J81aDcfK38wEZpcqVAwR7fPMmFu/35MyYjhh7KnOb2ik1BhCLSJzNdeuQnTuskEaZCxdEpWlOGo5VWP4t+ua0FRUTfing2Y+IfSU6kx3eklWtXXtJhrXmwlBEQVMarsPucBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352923; c=relaxed/simple;
	bh=v6bL/smeZNF++oogcyHNFgbpXP30gkHynV4auvO0VeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8QIZ/rs+Zlbkl7Cd+BylTk5EILVBD6PrYICQ4omCDkjfVz4iyxdZAVv8HhQfbGs93du/W5oqyvnFAYCAOvYQssRT3uFfP5Fhi4fSHK6oVdtbR6dItVKtVoddim5bBr17qWPTRTbyZ/DbrsTPHSF4nFedz4s2sXE8XxL3SxFwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJWmWmDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE179C4CEE0;
	Mon, 16 Dec 2024 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734352922;
	bh=v6bL/smeZNF++oogcyHNFgbpXP30gkHynV4auvO0VeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJWmWmDdDfMI2GOaNXhSzIY33H+b6BHPsMyLEFeqHMuN4/I7EohkIuGs2lSBc+aXM
	 3R/qkicWrfFuGyZ+7sonLtz3Zg8h06/Zad1QPoh1JsZel7jFkU6JAPp3Q4hB71lDEy
	 C0AtZRZriKH7uK8zw9Zf4pahGco4GwcaPMZ6rDlfeb/Q8YoriaMh7jWFxL/NhKmFEZ
	 SoRj/g99ZFCX7PeQUJfAE6yUwXb2J9mjtDF7RDfQjySrzUowWDCJN5qYwzi4cTFj+c
	 WIIRB1OXGT34BY/JumKoCaIz3qANKkWlO5Vt5ayG46UJ2HwIcum4wD61yINg3VtiCM
	 ifB5FEqVBnBjA==
Date: Mon, 16 Dec 2024 13:41:56 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] drm/nouveau: remove drm_encoder_slave interface
Message-ID: <Z2AgFHV2BaaZYGTx@cassiopeiae>
References: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
 <Z2ASy3TQ4suupdvd@cassiopeiae>
 <fw7i3kusogrrsslb5sjdid27uqnwey5qa5yhyrfa677n4iqqhq@tfh5s6bmqgna>
 <20241216121651.GP32204@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216121651.GP32204@pendragon.ideasonboard.com>

On Mon, Dec 16, 2024 at 02:16:51PM +0200, Laurent Pinchart wrote:
> On Mon, Dec 16, 2024 at 02:11:41PM +0200, Dmitry Baryshkov wrote:
> > On Mon, Dec 16, 2024 at 12:45:15PM +0100, Danilo Krummrich wrote:
> > > On Sun, Dec 15, 2024 at 12:19:22PM +0200, Dmitry Baryshkov wrote:
> > > > The nouveau driver is the only user of the drm_encoder_slave interface.
> > > > Demote it from KMS helpers module to the nouveau driver itself, moving
> > > > corresponding I2C encoders to be handled by nouveau driver too.
> > > 
> > > I understand nouveau is the only driver using this interface (and the
> > > corresponding i2c encoders).
> > > 
> > > However, I'm not quite seeing the advantage of folding the interface (including
> > > the two i2c drivers) into nouveau. I don't think this legacy interface does harm
> > > the subsystem in any way / does prevent the subsystem from moving forward.
> > > 
> > > Can't we just keep it as it is?
> > 
> > Well, drm_encoder_slave is a part of the DRM KMS helpers module, so it
> > take (a little bit) of space on every system. The nouveau situation
> > isn't unique, other drivers (i915, ast) also incorporate the code for
> > I2C backends. For the further discussion see the thread starting from
> > Laurent's email ([1]).
> > 
> > [1] https://lore.kernel.org/all/20241117205426.GE12409@pendragon.ideasonboard.com/

The drm_encoder_slave code it's rather small, but I guess this can be used as
argument for both, keeping it where it is and moving it.

If you want to move it to nouveau, I'm not going to object. But please fold the
helper code, such that we aren't left with unused functions and unnecessary
function pointer indirections through struct drm_encoder_slave_funcs.

> 
> It's also a question of whether maintenance of this code based used by
> the nouveau driver only should be the responsibility of the drm-misc
> community or the nouveau driver maintainers.

Good question. It's common infrastructure; do we expect / require the last user
of such infrastructure to take ownership?

> 
> > > > Ideally those two drivers should be converted to the drm_bridge
> > > > interface, but it's unclear if it's worth spending time on that.
> > > 
> > > Probably not.
> > > 
> > > > 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > > Changes in v2:
> > > > - Renamed symbols in defconfig (Laurent)
> > > > - Added missing Kbuild file (Laurent, LKP)
> > > > - Renamed guarding defines in include files.
> > > > - Dropped mentions of two removed functions.
> > > > - Link to v1: https://lore.kernel.org/r/20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org
> > > > 
> > > > ---
> > > > Dmitry Baryshkov (2):
> > > >       drm/nouveau: incorporate I2C TV encoder drivers
> > > >       drm/nouveau: vendor in drm_encoder_slave API
> > > > 
> > > >  arch/arm/configs/multi_v7_defconfig                |   4 +-
> > > >  arch/parisc/configs/generic-32bit_defconfig        |   4 +-
> > > >  arch/parisc/configs/generic-64bit_defconfig        |   4 +-
> > > >  drivers/gpu/drm/Makefile                           |   1 -
> > > >  drivers/gpu/drm/i2c/Kconfig                        |  18 ----
> > > >  drivers/gpu/drm/i2c/Makefile                       |   6 --
> > > >  drivers/gpu/drm/nouveau/Kconfig                    |  20 ++++
> > > >  drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   3 +
> > > >  drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  12 +--
> > > >  drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild        |   5 +
> > > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c    |  30 +++---
> > > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c   |   8 +-
> > > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h   |  11 ++-
> > > >  .../drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c    |  33 ++++---
> > > >  .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
> > > >  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  20 ++--
> > > >  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
> > > >  .../gpu/drm/nouveau/include}/i2c/ch7006.h          |   4 +-
> > > >  .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 109 ++++++++-------------
> > > >  .../gpu/drm/nouveau/include}/i2c/sil164.h          |   4 +-
> > > >  drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
> > > >  drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
> > > >  22 files changed, 172 insertions(+), 232 deletions(-)
> > > > ---
> > > > base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
> > > > change-id: 20241214-nouveau-encoder-slave-a6dd422fa4a9
> 
> -- 
> Regards,
> 
> Laurent Pinchart

