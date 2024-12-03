Return-Path: <linux-kernel+bounces-429313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20349E1A58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAE4285068
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843541E3787;
	Tue,  3 Dec 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipohdJ6/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7D1E32C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224009; cv=none; b=br/3+NU9nmgZzRM6Eru1Bxcm4UZk0Zk40pLeHz9eTTcWqk8TXP1YqZs9YhFjc96E+Da7EQAb3vmaPrb5VTNqivo64F5XTpolVT6FMJ1Lg+23i0Nc19G2GKvWkecmazXUVN/jTj6OzK7l4o2yXa/dzkNoLpW+Ypg2B0TLCchxaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224009; c=relaxed/simple;
	bh=hjW3UCXqD1FmULpVvmR64Z1CjnUFV+STroncPx1uBpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NxCmOcmKLrrLdJ8WFySNqIaVbgcTwwwIM/3ira59kSL1nawbEWCOpCJg+82wzze6qXcCgZc0KEezvZj1IrZo7phP2jIF0sA6S1iqslFEDSXmuCBNnru8ysEBqI+YOI8Kk9RSU1qy7XMhBbjQgqAQdZ2oFD301Gv8Kj+bGFbpZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipohdJ6/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733224008; x=1764760008;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hjW3UCXqD1FmULpVvmR64Z1CjnUFV+STroncPx1uBpI=;
  b=ipohdJ6/7mlT+T1Gd737PtEs5kamomUzLz0voenqjgzgsakIfZ6INMvf
   G1URmg4L6J57wgHERNdQtQ+SYFwGWqxnPx1tQIEsyebiPRWKD4X1AO5WE
   KB9F7qvXOvBA87mLIv6HWXjiHL1UK3ub25dcCL97bT35MtnujSG7vpTXK
   tliFQAj9IAT8SFHkL2KgvhTxwThEaJGuJ71FvAW/eySBIZaJZjTe4RXB/
   +RgRWOdLQkLliKxI/kedqWZIjVRv+N2oYOJ9pU9l2gt/nNCNK5ss1XhKx
   NXQisrVCSusQbwJJreRNnS3tilz6tzQic8+Cw3yMwplqguMgIBN7e9YsE
   g==;
X-CSE-ConnectionGUID: hIs1GujkQ8idO0OAMCUoXw==
X-CSE-MsgGUID: 8uqvVu8SRpKh87AMotNg3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33580171"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33580171"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 03:06:47 -0800
X-CSE-ConnectionGUID: YfgNoayMQHKcDVkIFVY9kg==
X-CSE-MsgGUID: 0s0s+uOsQwKwhI+eoGJ7nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124231772"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.135])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 03:06:42 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v8 1/6] drm/panic: Move drawing functions to drm_draw
In-Reply-To: <20241115142950.1758007-2-jfalempe@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241115142950.1758007-1-jfalempe@redhat.com>
 <20241115142950.1758007-2-jfalempe@redhat.com>
Date: Tue, 03 Dec 2024 13:06:38 +0200
Message-ID: <87y10x3u0x.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 15 Nov 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> Move the color conversions, blit and fill functions to drm_draw.c,
> so that they can be re-used by drm_log.
> drm_draw is internal to the drm subsystem, and shouldn't be used by
> gpu drivers.

I started looking at this in patch 2:

> +#include "../drm_draw.h"

I think we should avoid #includes with ../ like this.

Either drm_draw.h belongs in include/drm, or maybe clients/Makefile
needs to add subdir-ccflags-y += -I$(src)/.. or something like that?

If it's supposed to be internal, I guess the latter, but then the
current convention is to have _internal.h suffix. All drm headers under
drivers/ have that.

Is this the first drm subsystem internal thing that's a separate module?
Should we use EXPORT_SYMBOL_NS() and MODULE_IMPORT_NS() to enforce it
being internal?


BR,
Jani.


-- 
Jani Nikula, Intel

