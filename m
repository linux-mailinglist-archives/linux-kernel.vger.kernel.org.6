Return-Path: <linux-kernel+bounces-414645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA509D2B86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2091F21B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7301D8A14;
	Tue, 19 Nov 2024 16:41:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D51D89E5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034493; cv=none; b=EWSzzdbxE/b97x74QwNfCJ31/ja51zDU1XFmK4O/NWBI4i0VcWMJzH57qzi4J4hE36CHrA0nAbi166cbz277GhbheC2heVEylDexb1BFknYFbu757/2t6d6UYD1RfblOqA+mlRQtcMmuKvU/65YWkR2GGjhy52l6JMDL545848c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034493; c=relaxed/simple;
	bh=pQ0QfkVirz8NWdVBD99P4R5RATrKDOkYGfi8YZcD5PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy4ZvG8p2t9Q3Oas8trCcam+Zu0MPDoybv0tla6tS186nEFe3r5AwaDAAkpIWOyje22j5pSMnaZxaBTMEbKR93jMA4CRouJI0PrCHl+vvSyT7LNvnF69H/yjzpaYe/7+UGWJGblvdod+qn/FdjbJTI0OKZRlghwc/z+UnRpNuH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59621007
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:41:59 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 669A03F85E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:41:29 -0800 (PST)
Date: Tue, 19 Nov 2024 16:41:14 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Karunika Choo <karunika.choo@arm.com>, nd@arm.com,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Simplify FW fast reset path
Message-ID: <Zzy_qhXTZZrPwhHk@e110455-lin.cambridge.arm.com>
References: <20241119135030.3352939-1-karunika.choo@arm.com>
 <20241119152525.6579b438@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119152525.6579b438@collabora.com>

On Tue, Nov 19, 2024 at 03:25:25PM +0100, Boris Brezillon wrote:
> On Tue, 19 Nov 2024 13:50:29 +0000
> Karunika Choo <karunika.choo@arm.com> wrote:
> 
> > Stop checking the FW halt_status as MCU_STATUS should be sufficient.
> > This should make the check for successful FW halt and subsequently
> > setting fast_reset to true more robust.
> > 
> > We should also clear GLB_REQ.GLB_HALT bit only on post-reset prior
> > to starting the FW and only if we're doing a fast reset, because
> > the slow reset will re-initialize all FW sections, including the
> > global interface.
> > 
> > Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> and I think you forgot to add Liviu's R-b

I've fixed the commit and pushed it without compile testing it because I did
it for the patch before it. Obviously it doesn't compile because glb_iface is
not defined :(

Adding a new patch, can you guys R-b this?

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4bc52b1b1a286..c807b6ce71bd4 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1133,6 +1133,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
                 * This is not needed on a slow reset because FW sections are
                 * re-initialized.
                 */
+               struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
                panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
 
                ret = panthor_fw_start(ptdev);


Best regards,
Liviu

> 
> > ---
> > v2:
> > - clarify comments and commit message with regards to when to clear the
> >   GLB_HALT flag.
> > 
> >  drivers/gpu/drm/panthor/panthor_fw.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index ecca5565ce41..4bc52b1b1a28 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -1098,17 +1098,11 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
> >  		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
> >  		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> >  		if (!readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
> > -					status == MCU_STATUS_HALT, 10, 100000) &&
> > -		    glb_iface->output->halt_status == PANTHOR_FW_HALT_OK) {
> > +					status == MCU_STATUS_HALT, 10, 100000)) {
> >  			ptdev->fw->fast_reset = true;
> >  		} else {
> >  			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
> >  		}
> > -
> > -		/* The FW detects 0 -> 1 transitions. Make sure we reset
> > -		 * the HALT bit before the FW is rebooted.
> > -		 */
> > -		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> >  	}
> >  
> >  	panthor_job_irq_suspend(&ptdev->fw->irq);
> > @@ -1134,6 +1128,13 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
> >  	 * the FW sections. If it fails, go for a full reset.
> >  	 */
> >  	if (ptdev->fw->fast_reset) {
> > +		/* The FW detects 0 -> 1 transitions. Make sure we reset
> > +		 * the HALT bit before the FW is rebooted.
> > +		 * This is not needed on a slow reset because FW sections are
> > +		 * re-initialized.
> > +		 */
> > +		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> > +
> >  		ret = panthor_fw_start(ptdev);
> >  		if (!ret)
> >  			goto out;
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

