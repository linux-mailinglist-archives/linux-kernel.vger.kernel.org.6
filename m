Return-Path: <linux-kernel+bounces-216942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541590A8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6651286A42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F4190679;
	Mon, 17 Jun 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bubVsi3c"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122E171B0;
	Mon, 17 Jun 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614799; cv=none; b=CxmTmGbYX5N+vI56ah4VvDXLaXqZmTNcopshw9+Wy5JiCakDMIB30CUZygKOup21QKluDZCNNcjUQ5M0YsWilTq8soqMYSbSBU4K1M/IPQ6msjh0294YIUCjOPbtbCtuUm8614nK6dq+uxp7zCFY68ocGEPDfvKeqHETjCz25t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614799; c=relaxed/simple;
	bh=Glz+Xgpaku4DZHOwAqdMTYptGC/CqsWlvIDpZMM2rwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7zDpM8KpdYYhwjVdH2AG9xbW6iMzaaerfxmCk/TBfrc8FXYR3dAzgW5X0G81TmKkvejgTJ+4leMpX6EEwzv9UfawGv1815Qwwv2oOvv2UMI8b3l+Xxk0NfU0lE42vUn2/WT42yDNi46ZI1uIrZAWvn7+ZhG5Le7VAEHBXjlMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bubVsi3c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C65CE2D5;
	Mon, 17 Jun 2024 10:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718614779;
	bh=Glz+Xgpaku4DZHOwAqdMTYptGC/CqsWlvIDpZMM2rwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bubVsi3cVQbGZ9ffNBbQNIK48dnxJxtbHHmPD8+WIWUj2OaZKiT06RL2Re8E7Qyig
	 DwO3N7wEJRRL5m6oC9aEaMOhzrxTPyC2BkSPEkoXpwMpYorFMHMV+u8Is9cUyrZDu0
	 FVW4l8EvXp+j7Xhdr2nf7KtirJZdMd9ed8YddQVM=
Date: Mon, 17 Jun 2024 11:59:34 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm: zynqmp_dpsub: Fix an error handling path in
 zynqmp_dpsub_probe()
Message-ID: <20240617085934.GF30324@pendragon.ideasonboard.com>
References: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
 <5288867f-ee45-4930-bde0-14b24b878181@linux.dev>
 <120ffe3c-0240-4f93-a220-e0df565bcdbf@linux.dev>
 <20240616184326.GC7378@pendragon.ideasonboard.com>
 <88cbb88a-34de-4f97-9035-b3ef630580ed@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88cbb88a-34de-4f97-9035-b3ef630580ed@ideasonboard.com>

On Mon, Jun 17, 2024 at 10:43:44AM +0300, Tomi Valkeinen wrote:
> On 16/06/2024 21:43, Laurent Pinchart wrote:
> > On Thu, Jun 13, 2024 at 11:05:01AM -0400, Sean Anderson wrote:
> >> On 5/20/24 11:05, Sean Anderson wrote:
> >>> On 5/20/24 05:40, Christophe JAILLET wrote:
> >>>> If zynqmp_dpsub_drm_init() fails, we must undo the previous
> >>>> drm_bridge_add() call.
> >>>>
> >>>> Fixes: be3f3042391d ("drm: zynqmp_dpsub: Always register bridge")
> >>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >>>> ---
> >>>> Compile tested only
> >>>> ---
> >>>>   drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 1 +
> >>>>   1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> >>>> index face8d6b2a6f..f5781939de9c 100644
> >>>> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> >>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> >>>> @@ -269,6 +269,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
> >>>>   	return 0;
> >>>>   
> >>>>   err_disp:
> >>>> +	drm_bridge_remove(dpsub->bridge);
> >>>>   	zynqmp_disp_remove(dpsub);
> >>>>   err_dp:
> >>>>   	zynqmp_dp_remove(dpsub);
> >>>
> >>> Reviewed-by: Sean Anderson <sean.anderso@linux.dev>
> >>
> >> Will this be applied soon? The patch it fixes has made its way into
> >> the stable tree already.
> > 
> > If someone can merge it in drm-misc that would be the fastest way.
> > Otherwise I'll send a pull request at some point, but I'm overworked at
> > the moment.
> 
> Thanks, I have pushed this to drm-misc-next.

Thank you Tomi, much appreciated.

-- 
Regards,

Laurent Pinchart

