Return-Path: <linux-kernel+bounces-384586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E859B2BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5F11F22374
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE3F1CC8B2;
	Mon, 28 Oct 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bPcnx/7J"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605831D54C1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109050; cv=none; b=DbtqsCTeIEiKT1kJlSsf6tb1tGtp793DRmbwhR87utOAaCnHkIttBX/25S+9i/7OvSBZ3nYcnudZLC8YcXBqkRkcD/EF2rUrHZNXnK6qmptHRzt4oOISflcQY98OyDBtRHU2CUkrmghd65XfE9f1d4+Y40Clg2zD5MZdkyhvLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109050; c=relaxed/simple;
	bh=cBeN9+iVei1Go7bprgrVdyhCw+8zynSeC5uT6TRR3mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sjjx8O/jY5BK5FZpDuU9dGLwZIl/qyYc83FRB5MMVVmHHPAmIOndj8UmD9zU+JYLCnRDL5NRCGWpR0/FvaB4eZUVt1aLv2iJYCfACJHBqhrEgbEoQx0Hj5uZ23Xh1XX31QNuzimoiVOIO59FNOUBy1Rl02VY4xZMLA8YXPFkqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bPcnx/7J; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCE59240003;
	Mon, 28 Oct 2024 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iXNgFaNFtSns2DCVg0GSMcGToXEA5qFu8Wsybweyro=;
	b=bPcnx/7JOcyWD7HWhAGBfrhmrpaW51G1wRUxbp/+qUXDcu54ogUEnJgrm1ZpbRuMkFfNsM
	dqfrwIZfwZVlJ4JRrpvXPAEkXVBVVDcOAi9J40UpbDAteeQnr/VgT7UJvcg/9LOUZFvzi1
	UB6kZ559PR5xrlq8xw3qqV1NFL43FdFtVXDaCXdNRT2Xjwnj0fTDdzz0dbpbulrV3PbAdJ
	XBN3cFOKAltdbJ1PQTHodJc93etM2Mh8A6alYhij88QP3/At/+dWGufRln7fn2vRJtkJBh
	ZE9CL+txdXqmzg3UdupkC/ZOqDGqUwHwmHHBMb1/CAsuUMdZ9miGSsTpilxQ4Q==
Date: Mon, 28 Oct 2024 10:50:37 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
Subject: Re: [PATCH v4 0/5] drm/vkms: Switch all vkms object to DRM managed
 objects
Message-ID: <Zx9ebTnZSGNBeTi9@fedora>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
References: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
 <04289755-6794-4337-aa91-bf4a7754c090@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04289755-6794-4337-aa91-bf4a7754c090@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 12:33, Maíra Canal wrote:
> Hi Louis,
> 
> How do you feel about adding the patch [1] to this series? This will
> avoid issues when reviewing and pushing the series?

Ack!

Thanks,
Louis Chauvet
 
> [1] https://lore.kernel.org/all/20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com/
> 
> Best Regards,
> - Maíra
> 
> On 10/10/24 14:39, Louis Chauvet wrote:
> > To simplify the memory managment this series replace all manual drm
> > object managment by drm-managed one. This way the VKMS code don't have to
> > manage it directly and the DRM core will handle the object destruction.
> > 
> > No functional changes are intended in this series. This series depends on
> > [2] (for some code cleanup, which conflict with this series).
> > 
> > PATCH 1/5: Migrate connector managment to drmm
> > PATCH 2/5: Migrate encoder managment to drmm
> > PATCH 3/5: Migrate connector management to drm
> > PATCH 4/5: Introduce drmm_writeback helpers
> > PATCH 5/5: Migrate writeback connector management to drm
> > 
> > [2]:https://lore.kernel.org/all/20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com/
> > 
> > For the drmm_writeback helpers, you can find some discussions here [3].
> > 
> > [3]:https://lore.kernel.org/all/20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com/
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> > Changes in v4:
> > - No changes for the managed part
> > - Add the patch to introduce drmm_writeback helpers
> > - Link to v3: https://lore.kernel.org/r/20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com
> > 
> > Changes in v3:
> > - As suggested by Maxime, split the managed and the dynamic allocation
> >    parts in different series
> > - To reduce the diff in this series, extract the "remove crtc index" part,
> >    see https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
> > - Link to v2: https://lore.kernel.org/r/20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com
> > 
> > Changes in v2:
> > - Applied comments from José
> > - Extract the rename vkms_output -> vkms_crtc to avoid useless changes in
> >    the last commit
> > - Extract the rename to_vkms_crtc_state to
> >    drm_crtc_state_to_vkms_crtc_state to avoid useless changes in last
> >    commit
> > - Extract the drm_mode_crtc_set_gamma_size result check in its own commit
> > - Rebased on drm-misc/drm-misc-next
> > - Link to v1: https://lore.kernel.org/r/20240814-google-vkms-managed-v1-0-7ab8b8921103@bootlin.com
> > 
> > ---
> > Louis Chauvet (5):
> >        drm/vkms: Switch to managed for connector
> >        drm/vkms: Switch to managed for encoder
> >        drm/vkms: Switch to managed for crtc
> >        drm: writeback: Introduce drm managed helpers
> >        drm/vkms: Switch to managed for writeback connector
> > 
> >   drivers/gpu/drm/drm_connector.c       |   4 +
> >   drivers/gpu/drm/drm_writeback.c       | 224 +++++++++++++++++++++++++++++-----
> >   drivers/gpu/drm/vkms/vkms_crtc.c      |  14 +++
> >   drivers/gpu/drm/vkms/vkms_drv.c       |   9 --
> >   drivers/gpu/drm/vkms/vkms_output.c    |  31 ++---
> >   drivers/gpu/drm/vkms/vkms_writeback.c |  13 +-
> >   include/drm/drm_writeback.h           |  10 ++
> >   7 files changed, 238 insertions(+), 67 deletions(-)
> > ---
> > base-commit: 33c255312660653cf54f8019896b5dca28e3c580
> > change-id: 20240521-google-vkms-managed-4aec99461a77
> > prerequisite-message-id: <20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com>
> > prerequisite-patch-id: 920c23497fc5bd2fdf1dded06ce198c227ea0ef9
> > 
> > Best regards,
> 

