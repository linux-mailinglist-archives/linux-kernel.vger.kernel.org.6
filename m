Return-Path: <linux-kernel+bounces-216437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F78909F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DAAB22660
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C346481D7;
	Sun, 16 Jun 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Kg9coJpW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270231CA85;
	Sun, 16 Jun 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563432; cv=none; b=UIk1nncz952PLEa+GgcJl/oJOKcZmB8FTKd9ypttv/oxeFw4PvUaDfs4fR5GOJA8ZxpSVFPkvcTohqwJgeYTgzG8YYYNqp4yaZW7oQbNfpdDivEPLHJfFb9gtpMWgS/RyQ2Ju1jSGNXrqhsUhhTq6SNSPgfHsbV4kZXLZ1kZu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563432; c=relaxed/simple;
	bh=TWBxG3KAFkYqCXEnV2s67ZEnGQPNxe89WFXEwY7DKAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=New7WtUo04LjtvHhUZgiVm9QjivKhmEck7oYIeIU8pdDkZtq+dgzPOEGCea1qoBEqdkz7adjwMbK52Q6XFhMZSP4DkIyNym/5+ciRCA4KbUTuJNTMVLu5gMXx0DHQdrn6SFOmWu6TwrCq3BhdA6QJoHmq6LHkx76WnehF21e3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Kg9coJpW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EBFB1581;
	Sun, 16 Jun 2024 20:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718563411;
	bh=TWBxG3KAFkYqCXEnV2s67ZEnGQPNxe89WFXEwY7DKAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kg9coJpWTq8YBlLSPw9hcqo5W4UHRpwF9TauQ88F6VGFJmUgLwYJzhEOy7YcXL4bs
	 tNi0AJV1aSzEdQqNE4eN/XJBO6FO0BsI5Azlxe1mFPZYXwwebf6PeuSNeOUGtUqsbO
	 DRSOHn5PNgLiC7vH3z6zcIq/9z5m15vkAG4ZSGCQ=
Date: Sun, 16 Jun 2024 21:43:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm: zynqmp_dpsub: Fix an error handling path in
 zynqmp_dpsub_probe()
Message-ID: <20240616184326.GC7378@pendragon.ideasonboard.com>
References: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
 <5288867f-ee45-4930-bde0-14b24b878181@linux.dev>
 <120ffe3c-0240-4f93-a220-e0df565bcdbf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <120ffe3c-0240-4f93-a220-e0df565bcdbf@linux.dev>

On Thu, Jun 13, 2024 at 11:05:01AM -0400, Sean Anderson wrote:
> On 5/20/24 11:05, Sean Anderson wrote:
> > On 5/20/24 05:40, Christophe JAILLET wrote:
> >> If zynqmp_dpsub_drm_init() fails, we must undo the previous
> >> drm_bridge_add() call.
> >> 
> >> Fixes: be3f3042391d ("drm: zynqmp_dpsub: Always register bridge")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> Compile tested only
> >> ---
> >>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> >> index face8d6b2a6f..f5781939de9c 100644
> >> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> >> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> >> @@ -269,6 +269,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
> >>  	return 0;
> >>  
> >>  err_disp:
> >> +	drm_bridge_remove(dpsub->bridge);
> >>  	zynqmp_disp_remove(dpsub);
> >>  err_dp:
> >>  	zynqmp_dp_remove(dpsub);
> > 
> > Reviewed-by: Sean Anderson <sean.anderso@linux.dev>
> 
> Will this be applied soon? The patch it fixes has made its way into
> the stable tree already.

If someone can merge it in drm-misc that would be the fastest way.
Otherwise I'll send a pull request at some point, but I'm overworked at
the moment.

-- 
Regards,

Laurent Pinchart

