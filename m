Return-Path: <linux-kernel+bounces-521854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB423A3C330
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBC8189B7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097B1F3FDC;
	Wed, 19 Feb 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PCBXk/A3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CF1F3D5D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977739; cv=none; b=szV7HHxEvbyrJ0mtd3epGXTNLHLiA3QX3UgevJBufxBL/R4XN5CqE/6L3pj+UqwZ6fy9PTDRhVJUDK/YdAVAZHeiqgC5ss5ZUdKtRnq4NhyXu8t0xhcDdbFCP9m3WvG7pOh2ez7+P4Iu3rYWaGAPT8b9JUk+JlqXl0GTVmIWpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977739; c=relaxed/simple;
	bh=4hH0ogfs3FxS01zx8vZqEEqA9ajbUWe7JPdrJDjl/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0rTAjH5qtHI43ol05iDF18X2w3iHovAgXIPcgfeGVapPZIuZBDXfzeQdZfBTy7X2Bu5tWbKwfH790DohDHKQewV9EruUvLphDhE4jbDSPRBmTsYqWKvRW1IlOiZcCz+v/w0b5RNBQ1CqZzylegMgeXrwhxJLIEb9NGyYkz2D50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PCBXk/A3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 008C8169;
	Wed, 19 Feb 2025 16:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739977653;
	bh=4hH0ogfs3FxS01zx8vZqEEqA9ajbUWe7JPdrJDjl/cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCBXk/A361zRuHfO14ueJVpPe1SKovsqAJpph7O9XWBCj4scQ/ibc7GwSrNakXkvR
	 GFt+BfI+1exlxpJM2rSY/78i5jt8skVIJNKf2sASzuQ9uFDT3HDLReLnSEJMQkCYRy
	 B+Wh05X/wsGSzqzT1mqV2Oah+pQciYQPHoxZ/A3A=
Date: Wed, 19 Feb 2025 17:08:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vishal Sagar <vishal.sagar@amd.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Message-ID: <20250219150840.GA31825@pendragon.ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-6-90d0fe106995@ideasonboard.com>
 <bdpw2g65uor77tijlhpabodog7haqvdcemnr3wzqkooerzuib5@hfdn5zsrbkgg>
 <7674314f-d95a-433a-81d2-ca78bc199359@ideasonboard.com>
 <naw67daoyb2lfmq4jovlwanz5niaolptwnug3c3kkrtlfoh6dd@trkctqyzvtb5>
 <23e71045-1ae2-4e02-9780-aa11a338d481@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23e71045-1ae2-4e02-9780-aa11a338d481@ideasonboard.com>

On Wed, Feb 19, 2025 at 04:47:26PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 18/02/2025 05:26, Dmitry Baryshkov wrote:
> > On Mon, Feb 17, 2025 at 10:27:56PM +0200, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> On 17/02/2025 22:15, Dmitry Baryshkov wrote:
> >>> On Wed, Feb 12, 2025 at 04:56:10PM +0200, Tomi Valkeinen wrote:
> >>>> Add XVUY2101010, a 10 bits per component YCbCr format in a 32 bit
> >>>> container.
> >>>
> >>> Is there a more common name for this format? Otherwise googling for it
> >>> reveals only your series.
> >>
> >> In the cover letter I mention the gstreamer names where available (this
> >> particular format is not in gstreamer). AMD has these in their zynqmp
> >> documentation (https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/Video-Packer-Format).
> >>
> >> XVUY2101010 is YUV444_10BPC in AMD docs.
> >>
> >> X403 is Y444_10LE32 in gstreamer, and YV24_10BPC in AMD docs.
> >>
> >> I'm not sure you'll have much more luck googling with those names, though
> >> =).
> > 
> > I'm asking, because include/uapi/drm/drm_fourcc.h has a pretty explicit
> > waiver: GL, Vulkan or other open standards. Otherwise normal
> > requirements apply and it's required to have an open-source usespace
> > implementation, etc.
> 
> I can drop DRM_FORMAT_XVUY2101010 until we get it to gstreamer. I just 
> had it ready, so I thought it's better to include it than leave out.
> 
> Is the current gstreamer support enough for the other formats to fulfill 
> the userspace requirement?

We've received a green light in the past to add formats to drm_fourcc.h
that would be used by cameras only. There's no open formal standard there, but
we have libcamera as a de-facto standard. I would assume GStreamer to be
enough for a scanout format.

-- 
Regards,

Laurent Pinchart

