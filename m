Return-Path: <linux-kernel+bounces-302946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE5960562
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442A3281E26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E8198E83;
	Tue, 27 Aug 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDLjZyku"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B80194A4F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750407; cv=none; b=cw28Zze7GxIPyJQ6w3fC196DffiaTH1csZHEzHqnTIh5zK+ZVtkg0XWIin6Vb3dD/uZLWJFGoyC05T3RCndHTQJWB6AowHXtHsDNYcEA/Iln/g0RdTMLgkVEXOifeP2WTBXLeyTrAOnZk1PVX1VxCl6Bs+8pf2rqK5GRzViadKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750407; c=relaxed/simple;
	bh=cIQ5Lx8hu1UIWOCXbxQbBrh8ZnqEEBadqw0L0XigrBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KzoNSDZzFoKJ9sc2D1DzKd9Pa2iq8yanTbrTQ8OFm9l8jvd5b14Nwz6zze0HeXSlNyiQP9uj2QPrRtZhCmJfyv6HgdBPeKBBejQ4DlJx+xTyD/0bxqjleebovmQhV93kBcdCVTaY1c4VHAk8bV9lSAQbIh0DCqxG2F0AchbtkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDLjZyku; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724750405; x=1756286405;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cIQ5Lx8hu1UIWOCXbxQbBrh8ZnqEEBadqw0L0XigrBE=;
  b=nDLjZykuTtXTfnRU4Cj/C+I9PkQ7F9MDpgZYnqgYIS/sySunujnppSa/
   mXvNELKyLSs9YOwQMsn9VUdRSelhK88YkteClsTdA5u4JMUci5eAmg73E
   SwlQYBsEEr4VuqpYbAlJMyEcQskpcM3rXSKFkD2A1myZh4C7MnQgtUcLk
   qejTn9HpP/28Y6Y3DoKUIP65FoKo9Fwyl09TEAodiN1sk3S1eAk5HmIiQ
   dm2+RlZFvq/I8hO8r6UvOnOHptH0VfQEc4W0JtS6Xc2ScPiLoeryvDgk3
   M5n86ID5/kq3LNiuDOeMyrl1ebvr9V9ywrp1PqcPgzvtKbwlLcXSNLdb0
   A==;
X-CSE-ConnectionGUID: C3q93HOoTj68bSeF0o9EbQ==
X-CSE-MsgGUID: ExA0208eTIOoU6sQb72VDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26981146"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="26981146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:20:04 -0700
X-CSE-ConnectionGUID: nVbmHnI8QJKLEkpX+9k0lA==
X-CSE-MsgGUID: Sfkx1TgPQGuIlOReiqqttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67612392"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.226])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:19:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Andi Shyti
 <andi.shyti@linux.intel.com>, renjun wang <renjunw0@foxmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, lyude@redhat.com,
 imre.deak@intel.com, Wayne.Lin@amd.com, ville.syrjala@linux.intel.com,
 vidya.srinivas@intel.com, jouni.hogander@intel.com,
 janusz.krzysztofik@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix kerneldoc for "Returns" section
In-Reply-To: <c9c9e482-f80c-4158-8dc4-695f8e0c62cd@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <tencent_37A873672B5CD20DECAF99DEDAC5E45C3106@qq.com>
 <Zsz9pwQ3m9zHrjo-@ashyti-mobl2.lan>
 <c9c9e482-f80c-4158-8dc4-695f8e0c62cd@suse.de>
Date: Tue, 27 Aug 2024 12:19:54 +0300
Message-ID: <87y14iz5j9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 27 Aug 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> My fault. Apologies if I crossed a line by just merging it into 
> drm-misc. It's just doc syntax, so I didn't think it was a big deal.

No worries, retrospective ack.

BR,
Jani.

-- 
Jani Nikula, Intel

