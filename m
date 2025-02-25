Return-Path: <linux-kernel+bounces-532218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C1A44A34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9DF16753A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C91A00E7;
	Tue, 25 Feb 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IF2l1iyR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559119F471
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507722; cv=none; b=C7Ug9VjfsoZlovtuV7R0pTpiPyWSOMFOUsMsRHnGmqB6iwL6D5PFF2FFksWeH3E4sGsNG8ObvjKrMfhb4F0EMazIGKTLxkyWIwcMyRqDfTrYtlxFA/fdil8vgL/ki+XW7sY89f6iAPuMCQztTWNASWbQV/jDQDQXqxxOLEbtBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507722; c=relaxed/simple;
	bh=vYdkX9GxcFnfRU02AZWzqGQOqGZSkjK3KMEH4qzF4tE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5E549wjjkQ5aoLw3U/VXklKvE5DgZ0Oy2xSwU+WEF9wX6WGqo4mOBCZBssGwD8lDpmN+Tv/IbCovqRkVrT04Cp6Pm3CA2YNByoOJC4znOKGcEnpunT8jgp68JKMqQrsxb1Y2YN1IoupaLk4rzuYGP3lYiFsBUkRex1Hfij5Xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IF2l1iyR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740507721; x=1772043721;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vYdkX9GxcFnfRU02AZWzqGQOqGZSkjK3KMEH4qzF4tE=;
  b=IF2l1iyRwfKEkbBugAJ0EUhYEajaJCrJ9aJ2DC99G4NejcZZpmXVT+WI
   0DVz3qw/AtFd0loK/grgyWe4yY0SPwCCcs155Agvp9sWYstIdKtHIF5EH
   kZXHitZy+6n0eMQrHJ9jyBykltvN8JKi9Vt2QkUuRWKNseyGkCJ29izH7
   vtNyuuBxeXP4xY8GKcLvg/MusT4s5gkhdoP7DyhHvQicjePijSpSAoxB2
   bZlD1/ZRRK7ZmIWI+1s9DGYNAAmehNk99vnBis8Fo64oWIZ5DLWvm4/Ax
   q7IJROxR8eub/oqx2Pcd0BAjGyg3+pFj7UXSl9NGlP9slsLVpy0wcwfbI
   g==;
X-CSE-ConnectionGUID: 3kKkLTd0RZKoFJr/THDmtA==
X-CSE-MsgGUID: 0G74O67cQ7OgWOXmlieKQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41210432"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41210432"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 10:22:00 -0800
X-CSE-ConnectionGUID: SN88Ybl6SQqNfCnQ57GTEQ==
X-CSE-MsgGUID: DOD2JSqtSUC+4u8c4m5SNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116958861"
Received: from monicael-mobl3 (HELO localhost) ([10.245.246.246])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 10:21:54 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
In-Reply-To: <20250225183621.6b33684b@booty>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
 <20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
 <878qpu56cm.fsf@intel.com> <20250225183621.6b33684b@booty>
Date: Tue, 25 Feb 2025 20:21:50 +0200
Message-ID: <871pvl6g1t.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Hello Jani,
>
> On Tue, 25 Feb 2025 18:36:41 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
>> On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>> > In preparation to expose more info about bridges in debugfs, which will
>> > require more insight into drm_bridge data structures, move the bridges_show
>> > code to drm_bridge.c.
>> >
>> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
>> 
>> I hate myself for doing this on a patch that's at v7... but here goes.
>
> Please don't! :-) This patch is new in v7, and a different (and
> definitely worse) approach was present in v6, but there was nothing
> before.
>
>> Perhaps consider moving the bridges debugfs creation and fops to
>> drm_bridge.c instead of just adding
>> drm_bridge_debugfs_show_encoder_bridges().
>> 
>> For example, add drm_bridge_debugfs_add(struct drm_encoder *encoder),
>> which then contains the debugfs_create_file() call.
>
> I think it should go in drm_encoder.c, not drm_bridge.c, right? Here we
> are showing the bridges attached to an encoder, so the entry point is
> each encoder.

I'm still thinking drm_bridge.c, because it's about bridges and their
details. The encoder shouldn't care about bridge implementation details.

> On the other hand in patch 2 we should move the
> drm_debugfs_global_add() code to drm_bridge.c, as it's showing bridges
> ina encoder-independent way.

Agreed on that.

> And finally drm_bridge should export the common
> drm_bridge_debugfs_show_bridge() function to drm_encoder.c.

Disagree. That will still require the EXPORT and #ifdefs around
CONFIG_DEBUG_FS.

> Do you think this is correct?
>
>> Interestingly, this lets you drop a lot of #ifdef CONFIG_DEBUG_FS. The
>> compiler optimizes the fops struct and the functions away when
>> debugfs_create_file() becomes a stub for CONFIG_DEBUG_FS=n. It becomes
>> all around cleaner.
>
> This surely makes the idea interesting. Cleaner code is always welcome.

You might find drivers/gpu/drm/i915/display/intel_display_debugfs.c
helpful (and/or confusing...). It's in a long-term flux towards the
approach of having the debugfs stuff next to the implementation.

You have intel_display_debugfs_register() for global stuff, which then
does the same for various functional blocks.

Similarly intel_connector_debugfs_add() and intel_crtc_debugfs_add() for
connector and crtc specific debugfs files.

The individual functionality specific *_register() and *_add() functions
don't have conditional compilation. But they become empty functions as
the debugfs functions become empty stubs with CONFIG_DEBUG_FS=n, and
lots of stuff just gets optimized away.

Moreover, having the debugfs next to the implementation has helped us
abstract implementation details better, and reduce exposed functions
from compilation units.

In this case, you'd be able to add more bridge specific debugfs files
later on without touching anything else than drm_bridge.c.


BR,
Jani.



-- 
Jani Nikula, Intel

