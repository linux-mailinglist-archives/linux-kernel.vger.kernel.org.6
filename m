Return-Path: <linux-kernel+bounces-294038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6848B958818
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FAB1F231E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B5190485;
	Tue, 20 Aug 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXLCgIz9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52118C91C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161309; cv=none; b=KbVEWsD5WlO6taQTIQDpZMB06NGmNxO1vK3RT0zf9trqEneTLPwTdRu0riY3267n+KbgGEloQj8RK2Dv9WM2m+UQGJ1UKJXZxBb6sKeLQwid1lqqIWXHjerd0K2weFQFayXqLQOR9usiLn1pnTEuo4760ZtXZLfSyNU1FzkA6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161309; c=relaxed/simple;
	bh=opLrROuD54WPY7U6CTrjM/ZqQ/yWDmuZgoY7rYtgdX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB0Ygzt1aq8HTf/zeuQBb50oYzP1z1dCnl1K84T9QvD1bF9tagN3w2prV6owhBzv5tgZdRB/gA5N9tYm13gePrqxBgTCW1kDgMIm+hsJrh0fU6we0prU28EjzFUc5OJWACfUZ0A+bmy7HBza6RTsX1i0dvPll8ktlW25ARwkJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXLCgIz9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724161308; x=1755697308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opLrROuD54WPY7U6CTrjM/ZqQ/yWDmuZgoY7rYtgdX0=;
  b=YXLCgIz9JGiGXdQwgSzp/yz8aL9CVxB1AgPu4+mxZovFu9iWHcbuC6aQ
   ++t0BC+Asc9xu/yIiEvSdmeHM4f9Q6bi3F/xvnZoiAok/wlQlJEW/1jjq
   mbVJu2P9jpdfr4aj6FVl5cOA0uorp026drtIDqETvP18od1+Nu2s0Q0P3
   VCYKfWycIoLlijYxRbrPpxMqS7TP80g0UnR85TLN2DBmPurWwE50LeA+/
   rMHP6q3NfaiF3Ty5eP4bqxAnoFhoFZkHFD9iImlFa+Nl59QqQAhVbvTNU
   GliNXfqS0pPWy1MZUCrljEdwXnsfgZo0CqYpX+yJZhaCgpICx/QeA/0Nx
   A==;
X-CSE-ConnectionGUID: aNnH8/48TfGVzZvsm0qbyw==
X-CSE-MsgGUID: 9NEhSnINRQOCwhachcVgcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26331032"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="26331032"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:41:47 -0700
X-CSE-ConnectionGUID: aFf1F+rXTfGlvlVvX2STjg==
X-CSE-MsgGUID: fwxoflidSHyyNvmP3E+2yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60698260"
Received: from slindbla-desk.ger.corp.intel.com (HELO intel.com) ([10.245.246.197])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:41:39 -0700
Date: Tue, 20 Aug 2024 15:41:36 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yu Jiaoliang <yujiaoliang@vivo.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2] drm/i915/gt: Use kmemdup_array instead of kmemdup for
 multiple allocation
Message-ID: <ZsSdEHxsmkb2B2WS@ashyti-mobl2.lan>
References: <20240820095304.2746102-1-yujiaoliang@vivo.com>
 <ngzckr4tdknp73oki6ig7drg6vx5hapqz3226ejfuhah5khefh@6gwnuk4q2nlx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ngzckr4tdknp73oki6ig7drg6vx5hapqz3226ejfuhah5khefh@6gwnuk4q2nlx>

Hi Lucas,

On Tue, Aug 20, 2024 at 07:53:10AM -0500, Lucas De Marchi wrote:
> On Tue, Aug 20, 2024 at 05:53:02PM GMT, Yu Jiaoliang wrote:
> > Let the kememdup_array() take care about multiplication and possible
> > overflows.
> > 
> > v2:
> > - Change subject
> > - Leave one blank line between the commit log and the tag section
> > - Fix code alignment issue
> > 
> > Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > ---
> > drivers/gpu/drm/i915/gt/intel_workarounds.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> > index d90348c56765..0fcfd55c62b4 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> > @@ -111,9 +111,8 @@ static void wa_init_finish(struct i915_wa_list *wal)
> > {
> > 	/* Trim unused entries. */
> > 	if (!IS_ALIGNED(wal->count, WA_LIST_CHUNK)) {
> > -		struct i915_wa *list = kmemdup_array(wal->list,
> 
> 					^
> 
> it was already kmemdup_array, not kmemdup. Am I missing anything?

I see kmemdup() in drm-tip.

What Yu has done here is to change kmemdup to kmemdup_array and
send the patch. Received the reviews and made a new commit on top
of the previous one; then he sent only this second commit.

Yu needs to make sure that:

 1. the patch applies correctly on a clean drm-tip
 2. drm-tip + patch compiles
 3. there are no checkpatch and sparse new errors

We missed point 1 here :-)

Andi

