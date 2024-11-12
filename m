Return-Path: <linux-kernel+bounces-406339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DEA9C5DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D921B394F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B9206E63;
	Tue, 12 Nov 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qKIDCDSx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F772206963;
	Tue, 12 Nov 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429798; cv=none; b=mpsBEUsKW32a2FfjFdKyJesHmDzae2k/2fpCANtUEpbQMtVxad/gHuT44asK42jVXJlVrY3ghqxKxDntN0XYTXwCCmNmoYHx8xE0UKTPnh4k9+U+JqADpK8Bz+ejeL8xdlPY8zdpP2iEUcQ/HX5jHv2elNY1VuGHfzK9cFTpFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429798; c=relaxed/simple;
	bh=65VsRjVcEe9IvdBJ/DvvVbzX+0/6GvW4V9ctYpdSrKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZPxVWcvkrHqz+dGGxgP5Kl2sO83cPkPpOzBKUd/WEIPUozmz7GVYLrMA+6oTqefHAJoPdfpxjnzHAMDDQlqkYBSpYyeE582g/sPsotIPnHEJQxvmq/g6n7r6LHkFw3+KfESZrPPMOJqNhODltVIUQ/9DH/m3ZtUmIsyPoItuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qKIDCDSx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id ACEB6512;
	Tue, 12 Nov 2024 17:43:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731429780;
	bh=65VsRjVcEe9IvdBJ/DvvVbzX+0/6GvW4V9ctYpdSrKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKIDCDSxxKY37Yoayj++VojJCA882nVp1mOs+5bUrDgIxFyRNST6HrdXK87+y/UTW
	 LPJv/2w4C0hvOdZe5i47ERqp++oMfcyz1OTQZnxWnU8o1puJzQg3l+tXAyMr6p1LIG
	 cOMxU7Wl/UXEXtiHOCk7kjkKCQ9zHC8atICcOj8Y=
Date: Tue, 12 Nov 2024 18:43:05 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm: zynqmp_dp: Unlock on error in
 zynqmp_dp_bridge_atomic_enable()
Message-ID: <20241112164305.GA24067@pendragon.ideasonboard.com>
References: <b4042bd9-c943-4738-a2e1-8647259137c6@stanley.mountain>
 <20241112052754.GB21062@pendragon.ideasonboard.com>
 <37be000a-3ef8-4df4-aefa-b4d73487ad27@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37be000a-3ef8-4df4-aefa-b4d73487ad27@linux.dev>

On Tue, Nov 12, 2024 at 09:41:58AM -0500, Sean Anderson wrote:
> On 11/12/24 00:27, Laurent Pinchart wrote:
> > Hi Dan,
> > 
> > Thank you for the patch.
> > 
> > On Mon, Nov 11, 2024 at 12:06:10PM +0300, Dan Carpenter wrote:
> >> We added some locking to this function, but accidentally forgot to unlock
> >> if zynqmp_dp_mode_configure() failed.  Use a guard lock to fix it.
> >> 
> >> Fixes: a7d5eeaa57d7 ("drm: zynqmp_dp: Add locking")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Sean, how about replacing all the mutex_lock()/mutex_unlock() calls
> > you've added in a7d5eeaa57d7 with guards ?
> 
> I have no objection to that.

Would you send a patch ? Otherwise I can do it.

-- 
Regards,

Laurent Pinchart

