Return-Path: <linux-kernel+bounces-533828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7CA45F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809FD1884D82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067121884A;
	Wed, 26 Feb 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAl43xnE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCD15C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572782; cv=none; b=jcE8E/7DnsMYYuGaQEFhnWK3zUmaFPaYq7I8UXs6Auc8vC0hyZG+1uCeEKg6bkdDVpLqlLDm6lIRCUJNUHGm1OCXhqouKPd/2rD0RMjZk8BMNxigvT7yCama3SbB9ybqOA+aBmSIRCms0mxSCpoJaYxToJ8bXYixvdRX8P/Y16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572782; c=relaxed/simple;
	bh=nHWvsrHzl0E3PKpKoxyFzPuy69gPj6TL5GxMEdtgmYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cb2aPUcC5KrxR2Ijud23s8zqdxEw8bpVDgDU7vsE1NGo6BrH7sCBEGjJRD3jQob6Jw6qKZzlpv6igHSfy9VisSri7CzqZOqqwC7TYQRe7QflcGnI+3My0kLCUdl7xiLAIYRMci1SFUO4SxtgG1sC32+qTbzsIzJi9IzMs06RqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAl43xnE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740572781; x=1772108781;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nHWvsrHzl0E3PKpKoxyFzPuy69gPj6TL5GxMEdtgmYE=;
  b=cAl43xnEIoiDdXkGwSorZD2LgDPLuw73FZZt/90vW9/o/qF16WzmIVhP
   CZpuygTcQdL0JsABECjlhluxwww1WmTHXJAg4tkOE17PwqFcAMytlWSxL
   F0zMit+3JOuS8LVR18Petw15aWKV9g8g49AFYAPuu3zE3DMH/fcipdKtd
   d9w1S0NfHE6t/XuLkPTx/sFkpahoQpGxJrr2vJ4uR4xS8mXgLFpVz5rR+
   9Yq++R0MzAsLteuEZSgrf3wuwOwYuV3gK/g7wImgAJ0AQY62WykfUIk91
   POluhas2DjErFd/4AuF4MkedVxmfawtOCxKpUirvthkaFyFHxNIL+zcxb
   A==;
X-CSE-ConnectionGUID: v5aHbC7mQH28j+8i6NazPQ==
X-CSE-MsgGUID: 8UUYF0fxQOOAvlb+mmynQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="29007918"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="29007918"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:26:20 -0800
X-CSE-ConnectionGUID: yDO3I0TZTc+YJydC1eF25A==
X-CSE-MsgGUID: oz93/ECPRmWpqDFJr7jZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="147507690"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.123])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:26:12 -0800
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
In-Reply-To: <20250226123208.272e7766@booty>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
 <20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
 <878qpu56cm.fsf@intel.com> <20250225183621.6b33684b@booty>
 <871pvl6g1t.fsf@intel.com> <20250226123208.272e7766@booty>
Date: Wed, 26 Feb 2025 14:26:09 +0200
Message-ID: <87mse851um.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 26 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Hello Jani,
>
> On Tue, 25 Feb 2025 20:21:50 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
>> On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>> > Hello Jani,
>> >
>> > On Tue, 25 Feb 2025 18:36:41 +0200
>> > Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> >  
>> >> On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:  
>> >> > In preparation to expose more info about bridges in debugfs, which will
>> >> > require more insight into drm_bridge data structures, move the bridges_show
>> >> > code to drm_bridge.c.
>> >> >
>> >> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> >> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>    
>> >> 
>> >> I hate myself for doing this on a patch that's at v7... but here goes.  
>> >
>> > Please don't! :-) This patch is new in v7, and a different (and
>> > definitely worse) approach was present in v6, but there was nothing
>> > before.
>> >  
>> >> Perhaps consider moving the bridges debugfs creation and fops to
>> >> drm_bridge.c instead of just adding
>> >> drm_bridge_debugfs_show_encoder_bridges().
>> >> 
>> >> For example, add drm_bridge_debugfs_add(struct drm_encoder *encoder),
>> >> which then contains the debugfs_create_file() call.  
>> >
>> > I think it should go in drm_encoder.c, not drm_bridge.c, right? Here we
>> > are showing the bridges attached to an encoder, so the entry point is
>> > each encoder.  
>> 
>> I'm still thinking drm_bridge.c, because it's about bridges and their
>> details. The encoder shouldn't care about bridge implementation details.
>
> Ah, I think I now get what you mean.
>
> Current code is:
>
> drm_encoder_register_all()                             [drm_encoder.c]
>  -> drm_debugfs_encoder_add                            [drm_debugfs.c]
>    -> debugfs_create_file("bridges"...  &bridges_fops) [drm_debugfs.c]
>                                     [bridges_fops is in drm_debugfs.c]
>
> Moving the last 2 lines to drm_bridge.c and into a new function we'd
> have:
>
> drm_encoder_register_all()                             [drm_encoder.c]
>  -> drm_debugfs_encoder_add [*]                        [drm_debugfs.c]
>   -> drm_bridge_debugfs_add_encoder_bridges_file (NEW) [drm_bridge.c]
>    -> debugfs_create_file("bridges"...  &bridges_fops) [drm_bridge.c]
>                                     [bridges_fops is in drm_bridge.c]
>
> Potentially [*] could be moved to drm_encoder.c, but that is not bridge
> related and can be done as a future step.
>
> Is this what you had in mind?

Yes!

(Though I'd give drm_bridge_debugfs_add_encoder_bridges_file() a shorter
and more generic name.)

BR,
Jani.


>
>> > On the other hand in patch 2 we should move the
>> > drm_debugfs_global_add() code to drm_bridge.c, as it's showing bridges
>> > ina encoder-independent way.  
>> 
>> Agreed on that.
>> 
>> > And finally drm_bridge should export the common
>> > drm_bridge_debugfs_show_bridge() function to drm_encoder.c.  
>> 
>> Disagree. That will still require the EXPORT and #ifdefs around
>> CONFIG_DEBUG_FS.
>
> With the above-sketched idea I agree we wouldn't need to export
> drm_bridge_debugfs_show_bridge().
>
> Luca

-- 
Jani Nikula, Intel

