Return-Path: <linux-kernel+bounces-327336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A2977458
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6528D1C212E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BAD1C2DC5;
	Thu, 12 Sep 2024 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZwGoyoAy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279802C80
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180253; cv=none; b=PCQYv47lbLgXLtapKr19yJHkp4CsYc+ojXJRUiRkp5GZjMBwC2XBsI8KWtS1TUiYbRFYSP0/ANlvq+B5BrmFeuMt9nycQguc1oveZY8hyTZqMvCtor3Q7XSw2Tx4ekqQtH0glQAcXXLwYzG9waPltvvSY6yTAyAJoKQL5rEeZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180253; c=relaxed/simple;
	bh=X/ACVZ2yMqEp+K0nA3WcyXwPm35BI17vNhlKzvwVbIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUCF0TpsuXUg81dH0xsVryZHoRY4Ufqr/BvRZKW8XBrMVRXrsLpJ0sWnl5ZNYynjwl2KJRRYluxPGjiNHTxu1IgzA+65wW3ZcG1X0vqDzCdRQk6L3wcrYuJ1G1aH+KFCVNgwvlFi9JdZvbkiPriMloaYmZx83n+facW11Hd6WhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZwGoyoAy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-229-8-243.static.upcbusiness.at [213.229.8.243])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8D104AD;
	Fri, 13 Sep 2024 00:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726180165;
	bh=X/ACVZ2yMqEp+K0nA3WcyXwPm35BI17vNhlKzvwVbIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwGoyoAyObEXRGPlAyDMyhN/oeNZ0NcQyaWj4EAhf9+vIzIwWN/dBisgAHZybjCiB
	 il9eGJb+YCPTFs+CnmrVPuOibFZ3lvdTq/VCZx9Bdgpc8pPy6FqO3oHxFYQQJY/ICb
	 XkvBs0JgPffoCsoCfd7rch8svHxwoFYm11NVydWI=
Date: Fri, 13 Sep 2024 01:30:07 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
	ahalaney@redhat.com, airlied@gmail.com, cai.huoqing@linux.dev,
	caihuoqing@baidu.com, colin.i.king@gmail.com, dakr@redhat.com,
	daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org, geert+renesas@glider.be,
	grandmaster@al2klimov.de, j-choudhary@ti.com, javierm@redhat.com,
	jyri.sarha@iki.fi, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, nm@ti.com, praneeth@ti.com,
	r-ravikumar@ti.com, robh@kernel.org, sam@ravnborg.org,
	simona.vetter@ffwll.ch, tzimmermann@suse.de,
	u.kleine-koenig@pengutronix.de, vigneshr@ti.com,
	ville.syrjala@linux.intel.com, wangxiaojun11@huawei.com,
	yuanjilin@cdjrlc.com, yuehaibing@huawei.com
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
Message-ID: <20240912223007.GA9669@pendragon.ideasonboard.com>
References: <20240912171142.3241719-1-devarsht@ti.com>
 <993bbe0a1b503505dd2e9b33b94e2b83@kernel.org>
 <20240912-unyielding-mottled-bumblebee-6bb69f@houat>
 <19f291d7-cb64-49b3-88e7-8541029cdf0d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19f291d7-cb64-49b3-88e7-8541029cdf0d@ideasonboard.com>

On Thu, Sep 12, 2024 at 09:21:19PM +0300, Tomi Valkeinen wrote:
> On 12/09/2024 21:08, Maxime Ripard wrote:
> > On Thu, Sep 12, 2024 at 06:04:11PM GMT, Maxime Ripard wrote:
> >> On Thu, 12 Sep 2024 22:41:42 +0530, Devarsh Thakkar wrote:
> >>> Modify license to include dual licensing as GPL-2.0-only OR MIT license for
> >>> tidss display driver. This allows other operating system ecosystems such as
> >>> Zephyr and also the commercial firmwares to refer and derive code from this
> >>> display driver in a more permissive manner.
> >>>
> >>>
> >>> [ ... ]
> >>
> >> Acked-by: Maxime Ripard <mripard@kernel.org>
> > 
> > Also, we need the ack of all contributors to that driver, so my ack
> > isn't enough to merge that patch.
> 
> IANAL, maybe a silly question: if someone from company XYZ has sent a 
> patch for tidss, don't we then need an ack from someone in XYZ who's 
> high enough in XYZ to allow changing the license for their code?

This patch needs to be acked by all copyright holders indeed. For
contributions whose copyright has been assigned to other entities (such
as work performed by employees for their employers), those other
entities have to ack the license change. What constitutes a substantial
enough contribution to be copyrightable is a question I won't attempt to
answer.

-- 
Regards,

Laurent Pinchart

