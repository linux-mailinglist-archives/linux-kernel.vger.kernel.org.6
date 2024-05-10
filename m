Return-Path: <linux-kernel+bounces-175937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE68C2781
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7FE1F22933
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641017164E;
	Fri, 10 May 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nXNRXI+/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B412C490;
	Fri, 10 May 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354216; cv=none; b=ushablJTeE/JULvfpkwBIPmSttvubtyEqkLLip5O0L9b+9heAKWuLgmh/4T5WoHRom/JqDmraAVcZcIs+LPUNyNYlKwNwZqsY0rpd0+BE3fQXsNQ7iOQwNkPQuo0hTCXiMfmrDoPhA9auuzQ3wEqi9tQOKBjKPu/qECdbnfnhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354216; c=relaxed/simple;
	bh=j5U02hjASsINAaYItIarcZkmxJVACMCoVQyAxb1d4YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atLC8A75npo45Z+ECZ3sFRBStOgCWDwK1RM9to4+74Y6oJfqJkz+Lu1wAmVlEELbV8HvUViijiVxpVg69PtGFjbq3Zfv1crbev0M4R9WdtOpiIYbnH/B33NVr9BkmyQ8JtZmb85dYfRHGZDMGgddUNKtRqw8e1kIb2aPHKfKemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nXNRXI+/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E8083D5;
	Fri, 10 May 2024 17:16:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715354206;
	bh=j5U02hjASsINAaYItIarcZkmxJVACMCoVQyAxb1d4YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXNRXI+/cEEbdhU/LxaMwVEoVFGICuenZ9oKzJ4Pvw+4Rn9vTPy48wsxJX5oaXsZo
	 w5eqhuDoHDehHp7iDKWM5Xjv15q+WA2DDWr95lpQMzWXyKfTxEAm+oCmYQq3FBVXGM
	 i+p2lMs53bhqlhIXnc56sLbqmR8fTqZDnSq2b9yI=
Date: Fri, 10 May 2024 18:16:42 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@collabora.com,
	sebastian.fricke@collabora.com, p.zabel@pengutronix.de,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
	j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
	p-mantena@ti.com, vijayp@ti.com, andrzej.p@collabora.com,
	nicolas@ndufresne.ca, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, adobriyan@gmail.com,
	jani.nikula@intel.com
Subject: Re: [PATCH v7 8/8] gpu: ipu-v3: Use generic macro for rounding to
 nearest multiple
Message-ID: <20240510151642.GA17158@pendragon.ideasonboard.com>
References: <20240509184010.4065359-1-devarsht@ti.com>
 <Zj43WDlT1aFpgdVv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj43WDlT1aFpgdVv@smile.fi.intel.com>

On Fri, May 10, 2024 at 06:03:52PM +0300, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 12:10:10AM +0530, Devarsh Thakkar wrote:
> > Use generic macro round_closest_up for rounding to nearest multiple instead
> 
> round_closest_up()
> 
> We refer to the functions as func().
> 
> > of using local function.
> 
> ...
> 
> > @@ -565,7 +563,7 @@ static void find_best_seam(struct ipu_image_convert_ctx *ctx,
> >  		 * The closest input sample position that we could actually
> >  		 * start the input tile at, 19.13 fixed point.
> >  		 */
> > -		in_pos_aligned = round_closest(in_pos, 8192U * in_align);
> > +		in_pos_aligned = round_closest_up(in_pos, 8192U * in_align);
> >  		/* Convert 19.13 fixed point to integer */
> >  		in_pos_rounded = in_pos_aligned / 8192U;
> 
> Oh, these seems to be better to use either ALIGN*(), or PFN_*() / PAGE_*()
> families of macros. What the semantic of 8192 is?

The comment mentions 19.13 fixed point, so I assume that's the
fractional part of the integer. It doesn't seem related to pages.

-- 
Regards,

Laurent Pinchart

