Return-Path: <linux-kernel+bounces-523184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C36A3D342
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7986189D033
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601411EA7EA;
	Thu, 20 Feb 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ur312CK6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A621A9B4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040305; cv=none; b=gnCdxMPEZ1G+pOfzbEKnatpl+DC5STBmiJ7Zq1l4S8uh03DQY26uUzO0+qQlVChH+E/9SqUjpy1lAZGVZ0KLeU7m+xjQG2Mc6i3c7DGcyM7DlV6JWi3LSUnZoP0LtGl/BVtCLtGw/jnyoq5N6+w93ylTRPt7GRhvIvHP9k0Daqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040305; c=relaxed/simple;
	bh=18G7Hj9q8cncfV3hH9722v8zJ7usf7Q8Ng96aoe59RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMTelpCjdvkuEEAXHu622prRhvE3NGiQ4c235PYGtmxnQpHkWCZoY4s5Thj90oTvKgWhIjja13z8S5X9/aAHCJozB1xw3rFOfr2iEPfCCR3GVNiZNFL2EI8e2V6zblYquPw5NdZtuTo3PYxOjXWQ197wRrIIVgN+h6h4JTksrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ur312CK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA79CC4CED1;
	Thu, 20 Feb 2025 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740040304;
	bh=18G7Hj9q8cncfV3hH9722v8zJ7usf7Q8Ng96aoe59RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ur312CK6OZntPrD/B/vpgyRBV0khNbq4RMObqL3AFcWJcZwgHMzR8fC01L9WuPOBA
	 QH7NCc8dpW0Dwo8Ea3vNgGXx7m5lVpAffwyRxxZf6jBNn0+O8o528POtH7Wxe/XphW
	 SgoVvAIMPjhmazLOAomPqJTTdUl/hqDpt7ezOIM4=
Date: Thu, 20 Feb 2025 09:31:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org, jbaron@akamai.com, ukaszb@chromium.org,
	intel-gfx-trybot@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 00/63] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Message-ID: <2025022012-viscous-cringing-bf88@gregkh>
References: <20250125064619.8305-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125064619.8305-1-jim.cromie@gmail.com>

On Fri, Jan 24, 2025 at 11:45:14PM -0700, Jim Cromie wrote:
> This series fixes dynamic-debug's support for DRM debug-categories.
> Classmaps-v1 evaded full review, and got committed in 2 chunks:
> 
>   b7b4eebdba7b..6ea3bf466ac6	# core dyndbg changes
>   0406faf25fb1..ee7d633f2dfb	# drm adoption
> 
> DRM-CI found a regression during init with drm.debug=<initval>; the
> static-keys under the drm-dbgs in drm.ko got enabled, but those in
> drivers & helpers did not.
> 
> Root Problem:
> 
> DECLARE_DYNDBG_CLASSMAP violated a K&R rule "define once, refer
> afterwards".  Replace it with DYNDBG_CLASSMAP_DEFINE (invoked once in
> drm-core) and DYNDBG_CLASSMAP_USE (invoked repeatedly, in drivers &
> helpers).
> 
> _DEFINE exports the classmap it creates (in drm.ko), other modules
> _USE the classmap.  The _USE adds a record ref'g the _DEFINEd (&
> exported) classmap, in a 2nd __dyndbg_class_users section.
> 
> So now at modprobe, dyndbg scans the new section after the 1st
> __dyndbg_class_maps section, follows the linkage to the _DEFINEr
> module, finds the (optional) kernel-param controlling the classmap,
> examines its drm.debug=<initval>, and applies it to the module being
> initialized.
> 
> To recapitulate the multi-module problem wo DRM involvement, Add:
> 
> A. tools/testing/selftests/dynamic_debug/*
> 
> This alters pr_debugs in the test-modules, counts the results and
> checks them against expectations.  It uses this formula to test most
> of the control grammar, including the new class keyword.
> 
> B. test_dynamic_debug_submod.ko
> 
> This alters the test-module to build both parent & _submod ko's, with
> _DEFINE and _USE inside #if/#else blocks.  This recap's DRM's 2 module
> failure scenario, allowing A to exersize several cases.
> 
> The #if/#else puts the 2 macro uses together for clarity, and gives
> the 2 modules identical sets of debugs.
> 
> Recent DRM-CI tests are here:
>   https://patchwork.freedesktop.org/series/139147/
> 
> Previous rev:
>   https://lore.kernel.org/lkml/20240716185806.1572048-1-jim.cromie@gmail.com/
> 
> Noteworthy Additions:
> 
> 1- drop class "protection" special case, per JBaron's preference.
>    only current use is marked BROKEN so nobody to affect.
>    now framed as policy-choice:
>    #define ddebug_client_module_protects_classes() false
>    subsystems wanting protection can change this.
> 
> 2- compile-time arg-tests in DYNDBG_CLASSMAP_DEFINE
>    implement several required constraints, and fail obviously.
> 
> 3- modprobe time check of conflicting class-id reservations
>    only affects 2+classmaps users.
>    compile-time solution not apparent.
> 
> 4- dyndbg can now cause modprobe to fail.
>    needed to catch 3.
>    maybe some loose ends here on failure.
> 
> 5- refactor & rename ddebug_attach_*module_classes
>    reduce repetetive boilerplate on 2 types: maps, users.
>    rework mostly brought forward in patchset to reduce churn
>    TBD: maybe squash more.
> 
> Several recent trybot submissions (against drm-tip) have been passing
> CI.BAT, and failing one or few CI.IGT tests randomly; re-tests do not
> reliably repeat the failures.
> 
> its also at github.com:jimc/linux.git
>   dd-fix-9[st]-ontip  &  dd-fix-9-13
> 
> Ive been running it on my desktop w/o issues.
> 
> The drivers/gpu/drm patches are RFC, I think there might be a single
> place to call DRM_CLASSMAP_USE(drm_dedbug_classes) to replace the
> sprinkling of _USEs in drivers and helpers.  IIRC, I tried adding a
> _DEFINE into drm_drv.c, that didn't do it, so I punted for now.
> 
> I think the dyndbg core additions are ready for review and merging
> into a (next-next) test/integration tree.

So whose tree should this go through?

And I think the last patch in this series isn't correct, it looks like a
000 email somehow.

thanks,

greg k-h

