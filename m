Return-Path: <linux-kernel+bounces-407285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2D9C6B53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C51283FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E41F77A6;
	Wed, 13 Nov 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGW30aaU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147916DEB4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489594; cv=none; b=Q/EDzYW0arQve+C4UxiHB0rBXxgBFriz6ARjhCA7RBd5s1ASud2bnK/17EZuHDoXATe0S7jim0S75pYozVSI2UiEYlZ3fvvC9BnmTEWSFaprnvTjEMCkmt9E6OBBIpS8Muu3h7MU1uH06g5i+nUGnLr6PKxMxvHuSQFSgb2OhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489594; c=relaxed/simple;
	bh=RywXthOwFpE1A24DQnCms05kD5aHruUT0XtDivdxmhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uiYUjIhLqrji4Hg7yJGFJpvBBPCmOEiKRjCt+vN5U9K0zMUZQHlt1OMve04EUL6Hhes+2RNEoj+djE2pkfLoXGp+r+2XVuGOAfKyh7teZSwI8AqbhFgNMswU/fI+0GpELAyNJlb0T8w/lKFwc4SFQUX2U+ekJiEPaCjeY3gERA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGW30aaU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731489592; x=1763025592;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RywXthOwFpE1A24DQnCms05kD5aHruUT0XtDivdxmhY=;
  b=QGW30aaUCIlZredW3Upy6iXaE2mh4ENk5oo6OrOr1aT9Ej5IJjPCqpVG
   +ZZZRiSILLGwxWvvGldy39qQA03HfBqDqk/zmMaPJy+82+1r+OPjgsyGr
   Qew7nD217RPyfvNKtJ6VOSa9f6SmucJRBNDuvURgAOlUKLEPzgXWusZ/F
   IkS9g5Cvt9t4fPeUHJVXRGedAuSkrpAk+lrtjZ5Qr2ufwoZXJHtaShfdL
   gnLpNeN9c+kKrB3I3xmHl5h/BnKwxo+YpU8Q/szc6TShniDO2MFIjw9Gb
   tKunZS+OTER2iX+BWnqahTaeuUnE2224EjDGUGe4k2IQgBBYGCOTTeOlJ
   Q==;
X-CSE-ConnectionGUID: 8NtTh/3dTSGxfbRcWNIfug==
X-CSE-MsgGUID: i4cV4QizSguzHtwnn6VLOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35162616"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="35162616"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 01:19:51 -0800
X-CSE-ConnectionGUID: 8UyDTvZeTLOn8OBChabZ2A==
X-CSE-MsgGUID: HvPx21msSdWgFnCUhilnFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92585896"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.186])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 01:19:47 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ville.syrjala@linux.intel.com
Subject: Re: [RFC][PATCH] drm: i915: do not NULL deref hdmi attached_connector
In-Reply-To: <20241113083920.GH1458936@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241031105145.2140590-1-senozhatsky@chromium.org>
 <20241113083920.GH1458936@google.com>
Date: Wed, 13 Nov 2024 11:19:44 +0200
Message-ID: <87msi3bidr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 13 Nov 2024, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (24/10/31 19:51), Sergey Senozhatsky wrote:
>> intel_ddi_init() may skip connector initialization, for instance,
>> both intel_ddi_init_dp_connector() and intel_ddi_init_hdmi_connector()
>> are optional.  This leads to situation that ->attached_connector may
>> be NULL for some connectors.  For instance, on my setup 'DDI A/PHY A'
>> and 'DDI TC1/PHY TC1' are not initialized.
>> 
>> However, functions like intel_dp_dual_mode_set_tmds_output() and
>> friends don't take this into consideration.  This leads to NULL
>> ptr-derefs:
>> 
>> KASAN: null-ptr-deref in range [0x0000000000000848-0x000000000000084f]
>> RIP: 0010:intel_hdmi_encoder_shutdown+0x105/0x230
>> Call Trace:
>> <TASK>
>> i915_driver_shutdown+0x2d8/0x490
>> pci_device_shutdown+0x83/0x150
>> device_shutdown+0x4ad/0x660
>> __se_sys_reboot+0x29c/0x4d0
>> do_syscall_64+0x60/0x90
>> 
>> Add a new helper to avoid NULL ->attached_connector derefs and
>> switch some intel_hdmi function to it.  I'm not sure if we need
>> to switch all or just intel_dp_dual_mode_set_tmds_output() (I
>> have only seen this one doing NULL derefs so far).
>
> Folks, any more comments / opinions on this?
> What should be the way forward?

Ville, we handle intel_ddi_init_dp_connector() failures but not
intel_ddi_init_hdmi_connector() failures. Do you recall if there's a
reason for that? Something like a dual-mode port where DP works but HDMI
gets rejected because of bogus VBT info?

My gut feeling is to propagate errors from intel_hdmi_init_connector()
and handle them properly in g4x_hdmi_init() and
intel_ddi_init_hdmi_connector().

Of course, we have cases where hdmi is just not initialized on DDI, and
those should be handled. But I don't think hdmi->attached_connector !=
NULL is really the right check for that.


BR,
Jani.


-- 
Jani Nikula, Intel

