Return-Path: <linux-kernel+bounces-390476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D119B7A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD252858BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34119C563;
	Thu, 31 Oct 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eefrCz6b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AE14E2C0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377276; cv=none; b=NuWoNaHFnvpoAZB0PV7yip3DgNH3js/KyT0Gyog0aDSdSVUO7ASV03mxSwd51de/Y5Ntw79hQpeMwj4SGBxdaw/uRXUuTVQ65R1c2gjc7LwOjgMAaogRUF7OtTR4dZ0XSDtFEBRUIpGOHzuLhrLz9ChS3OFGk7BCd4DxaPGP/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377276; c=relaxed/simple;
	bh=qodMBThkJ8Qg5NovyEpNiI2b3mZA8zAdhIhXFKEldZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2cyh/gyRrFavL/7kBp9SFFLLOlu+Ak3WfyOgren5QLD0MLSFL31VDcCcljmBHuYorGkbiCb5zT6FejwaLJNzY8Ytav812mVvuQ/50iAYML1rWZK3Wy0eTy00zi+s9CZQztP20YdV42qziW6lbNaZguwz1S5o7ct5UohLP73v6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eefrCz6b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730377275; x=1761913275;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qodMBThkJ8Qg5NovyEpNiI2b3mZA8zAdhIhXFKEldZo=;
  b=eefrCz6baMGdSxohkf7nUiciAOIg4dbThGt505brX8NiTQC/oxcKjHhI
   59AC/MZrdjWyKx+NZsPe2y9NUMjQLkiR/t/ucyOONJyDkWY9Rcpo5Gvpe
   7Ek7lv4rZrTEoiQ+t69k7EV7XhrAnyKcaEf5smL2LQTqVZLp5imI5NTW+
   uQRwH+b0q9MZgAKvS1IFxRLANtrJitbb1oIPYXCpp2ueDr0aUoR7UvgwY
   uoTKz740WUR/w/pLeMY46bZ1C7M1rEAFUj8rNXc5h/rFvRdm2Ca+P76N1
   NX3ixJaB2qq6uE/w4vBKEtTtpK1FWg8vS3bMoEvN6iXAzPsUtP/oHM0Ou
   w==;
X-CSE-ConnectionGUID: jDXJXaN5R5ea72RejbDQug==
X-CSE-MsgGUID: u5F63L+nSECrlc5CfuFkDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40657445"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40657445"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 05:21:14 -0700
X-CSE-ConnectionGUID: D0TlqUX3Qhanf7c9Kfr7RQ==
X-CSE-MsgGUID: UbvOLnNFQZ2MD8MAvtLQmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="86544152"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 05:21:06 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nam Cao <namcao@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg
 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Will Deacon <will@kernel.org>, Jon Mason
 <jdmason@kudzu.us>, Jaehoon Chung <jh80.chung@samsung.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Jassi Brar <jassisinghbrar@gmail.com>, Pavel
 Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alex Deucher
 <alexander.deucher@amd.com>, Rob Clark <robdclark@gmail.com>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Zack Rusin <zack.rusin@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Takashi Iwai
 <tiwai@suse.com>
Subject: Re: [PATCH 00/44] hrtimers: Switch to new hrtimer interface
 functions (4/5)
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1729865485.git.namcao@linutronix.de>
Date: Thu, 31 Oct 2024 14:21:03 +0200
Message-ID: <87v7x8jweo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 28 Oct 2024, Nam Cao <namcao@linutronix.de> wrote:
>   drm/i915/huc: Switch to use hrtimer_setup()
>   drm/i915/gvt: Switch to use hrtimer_setup()
>   drm/i915/perf: Switch to use hrtimer_setup()
>   drm/i915/pmu: Switch to use hrtimer_setup()
>   drm/i915/uncore: Switch to use hrtimer_setup()
>   drm/i915/request: Switch to use hrtimer_setup()

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging the above via whichever tree you find convenient.

-- 
Jani Nikula, Intel

