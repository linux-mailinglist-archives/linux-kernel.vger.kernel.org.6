Return-Path: <linux-kernel+bounces-239399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE62925FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280F1B260E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9BB16EC0F;
	Wed,  3 Jul 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k++e98Sv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2213D61B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007577; cv=none; b=mKmhI6C5x0PW761QnpAybEE5DFzbwf+kx+qzsO5NWKKfK0v+kUgnttv+ER2AQ01q6xMpUwr9JxVPzXPbt23XSwi3MH7B0DU6+cYR9HAgPZID4I50PCyg0QOYegDK9baFIPX727KekRJN/xelNBStvsCjSvbp0QH5DkkIykmLZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007577; c=relaxed/simple;
	bh=EpdJkfBmRQKg1jeirUfiq32WPAAoiCKsPGk8hCr+s6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJpxwLypkSQwMhEe3qVGl6x77hleCbvFl8YdMvki9jYIGU9heepZpObK9MWpZ0P7/v/tuiT+lpDF8AXFWHOV1yirP9RYI+8PZ7MpapJlvRxiFNt1h1Zx9O/ukqhsTTaEFgatl2Qrnz2fed8fPw+eXKLngg+fFLrqQin4ZG7l3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k++e98Sv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720007576; x=1751543576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EpdJkfBmRQKg1jeirUfiq32WPAAoiCKsPGk8hCr+s6c=;
  b=k++e98Svz1pe27wKdkkCtLiGNH3zqKd/onHOJSs1ssdQ9VPvTdJPswHi
   YWlQAx5mmz0LrCZ5MkGx9Rk8hBSXlGGzPtfbDYAbHp+lyoMrfAuuoPTCr
   3MA+lHT1R++tb7tE6HYI3qcPnDirN+ft31QT5mb052lYw2K2qHuah0r/N
   VAmUVPpoSSxtYkGUVISv2vig5jibfgJJVs1BFLFNNrVKDkN9ux6XsPdTQ
   EsT5GcnxpUWHbJIvGop78fJPBcOG2bqO7gti57Pb5K4y3zLIp31xCY26K
   6QMjTONPDq7+HO9Y+0t46ooGaKSk1XOvw/i7ff50PqxKoDl9bUszyjGNa
   g==;
X-CSE-ConnectionGUID: ustaz7xlQs6XUkMjqSxftw==
X-CSE-MsgGUID: 2QwnNcR+SDOJyjyRC8+1Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17440569"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17440569"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:52:55 -0700
X-CSE-ConnectionGUID: RPKwiF2YT5uq5i+JYJQ79g==
X-CSE-MsgGUID: 3q321IkRR06QRpPPf4qnAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46205175"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 03 Jul 2024 04:52:50 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 03 Jul 2024 14:52:49 +0300
Date: Wed, 3 Jul 2024 14:52:49 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: jim.cromie@gmail.com
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com, jbaron@akamai.com,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
	joe@perches.com, mcgrof@kernel.org
Subject: Re: [PATCH v9 30/52] drm-dyndbg: adapt drm core to use dyndbg
 classmaps-v2
Message-ID: <ZoU7kR2aYwVDvd_G@intel.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-31-jim.cromie@gmail.com>
 <ZoSOMClB0MeWeokU@intel.com>
 <CAJfuBxzsZUpO-Q_uAfMhzXs0WHYMTnj1F8ju7af-kQZKQjLvNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxzsZUpO-Q_uAfMhzXs0WHYMTnj1F8ju7af-kQZKQjLvNQ@mail.gmail.com>
X-Patchwork-Hint: comment

On Tue, Jul 02, 2024 at 08:34:39PM -0600, jim.cromie@gmail.com wrote:
> On Tue, Jul 2, 2024 at 5:33 PM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Tue, Jul 02, 2024 at 03:57:20PM -0600, Jim Cromie wrote:
> > > dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried to
> > > do too much.  Its replaced by DRM_CLASSMAP_DEFINE, which creates &
> > > EXPORTs the classmap when CONFIG_DRM_USE_DYNAMIC_DEBUG=y, for direct
> > > reference by drivers.
> > >
> > > The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they still
> > > redundantly re-declare the classmap, but we can convert the drivers
> > > later to DYNDBG_CLASSMAP_USE
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
> > >  include/drm/drm_print.h     |  8 ++++++++
> > >  2 files changed, 21 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> > > index 699b7dbffd7b..4a5f2317229b 100644
> > > --- a/drivers/gpu/drm/drm_print.c
> > > +++ b/drivers/gpu/drm/drm_print.c
> > > @@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
> > >  #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> > >  module_param_named(debug, __drm_debug, ulong, 0600);
> > >  #else
> > > -/* classnames must match vals of enum drm_debug_category */
> > > -DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> > > -                     "DRM_UT_CORE",
> > > -                     "DRM_UT_DRIVER",
> > > -                     "DRM_UT_KMS",
> > > -                     "DRM_UT_PRIME",
> > > -                     "DRM_UT_ATOMIC",
> > > -                     "DRM_UT_VBL",
> > > -                     "DRM_UT_STATE",
> > > -                     "DRM_UT_LEASE",
> > > -                     "DRM_UT_DP",
> > > -                     "DRM_UT_DRMRES");
> > > +/* classnames must match value-symbols of enum drm_debug_category */
> > > +DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
> > > +                 DRM_UT_CORE,
> > > +                 "DRM_UT_CORE",
> > > +                 "DRM_UT_DRIVER",
> > > +                 "DRM_UT_KMS",
> > > +                 "DRM_UT_PRIME",
> > > +                 "DRM_UT_ATOMIC",
> > > +                 "DRM_UT_VBL",
> > > +                 "DRM_UT_STATE",
> > > +                 "DRM_UT_LEASE",
> > > +                 "DRM_UT_DP",
> > > +                 "DRM_UT_DRMRES");
> >
> > Looks like this stuff just ends up in an array, so presumably
> > it should be possible to use designated initializers to make this
> > less fragile?
> 
> Im not sure I got your whole point, but:

I mean using
 [DRM_UT_CORE] = "DRM_UT_CORE"
instead of
 "DRM_UT_CORE"
so there is no chance of screwing up the order.
Or maybe the order doesn't even matter here?

Could also stringify to avoid accidental of typos.

> 
> the fragility is the repetitive re-statement of the map,
> in those un-modified DECLARE_s,
> once replaced, the USEs just ref the struct built by the _DEFINE
> (once, and exported)
> 
> I dont really like the _DEFINEs restatement of the enum-values: DRM_UT_*
> especially as "strings".
> I can automate the stringification with an APPLY_FN_(__stringify, ...)
> but the enum-list DRM_UT_* (w.o quotes) is still needed as args.
> 
> unless there is something C can do thats like Enum.values() ?
> 
> 
> 
> >
> > --
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel

