Return-Path: <linux-kernel+bounces-265457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2093F18A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA511F236EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BDC13F42F;
	Mon, 29 Jul 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZ/iGgKS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BC13D255
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246474; cv=none; b=aMEU3eFMnxU1fJ8wlRFWr79th1jtKuzMImxIRK5EEg3K4BgWvTSVcuGmoy9MEYvZHqFDoT3rXQ1r1GcbkfMGjSG0/yHueCH9DJnGTikP779Za41c+Jljz5pRL2PZluZo33JBBAHAtSg69E+FsIFnHqSMKhTF/eW4hYipiI7VLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246474; c=relaxed/simple;
	bh=RsomBzoCT2Ys4129Ye8pTLrTKipGkhhvsMm7FxcIZXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qix95KPl6FMcWPh5cJmQyiZHj5VOUlC6zw1vH8vxkJdxIoHDsytgV1jXTyexpJBZEDmgQXQL93FVHnw1vtaydG8/uLoKxkbkJr3WX6B9ruYesodnLaw7dYWsgtaAtOhX0pRHbO87IQIN1sj78JnTcYOVXdmhXtlm9KcYa7f7hcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZ/iGgKS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722246473; x=1753782473;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RsomBzoCT2Ys4129Ye8pTLrTKipGkhhvsMm7FxcIZXM=;
  b=lZ/iGgKSb+RqpysLPiw8OsO+kmi7GVCmIYvEmYSPg6se1dIttXGURaEx
   NBeRmuzBkGXpqeCDI91GrVrD8kOI+d/JCUWISF0HYl0cagcxtMq992Hrf
   UT7Wr2/YL6PMcIyUlxVOAVoz4OLIDpYowz1iMGPCxWqLPozwR9PTDr9SJ
   Ck0KYeBTvVb7GGkthYJgpWdYQT8H0PT+YJA5gSrRIim6qpgIKP9jxK3wa
   qlcUPT1U+X+8xZnOHr78YKJOPb+K5o1uQqOPUuoKu3jcVo9BkVzsVQo/H
   qnEt8jopZj3ULCvQpuJPogRYlA1VjQBztwW3LrmyHeJhA+E0/CvOFlpOU
   A==;
X-CSE-ConnectionGUID: mIaZeYZ4Q86LCixONLXV8g==
X-CSE-MsgGUID: YV1gF8/TS3qmcDH1Vt7q9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23851498"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="23851498"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 02:47:52 -0700
X-CSE-ConnectionGUID: 2yMcJEKfRiiYRrkCukWK5w==
X-CSE-MsgGUID: V5lA0qVPRZ20S6Se2HssBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58062474"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 02:47:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Alex Deucher <alexdeucher@gmail.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6n?=
 =?utf-8?Q?ig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Xinhui Pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/radeon: convert bios_hardcoded_edid to drm_edid
In-Reply-To: <CADnq5_NwCJV0exdGJ+nCFKdSZ-D85LsLQqCucF54jxtSa=yvSA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240726-amdgpu-edid-bios-v2-0-8a0326654253@weissschuh.net>
 <20240726-amdgpu-edid-bios-v2-2-8a0326654253@weissschuh.net>
 <CADnq5_NwCJV0exdGJ+nCFKdSZ-D85LsLQqCucF54jxtSa=yvSA@mail.gmail.com>
Date: Mon, 29 Jul 2024 12:47:45 +0300
Message-ID: <874j88zfzy.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 26 Jul 2024, Alex Deucher <alexdeucher@gmail.com> wrote:
> Applied the series.  Thanks!

Ah, replied to patch 1 before noticing this. Never mind about the
bikeshedding. :)

BR,
Jani.

-- 
Jani Nikula, Intel

