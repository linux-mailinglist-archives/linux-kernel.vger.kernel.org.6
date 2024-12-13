Return-Path: <linux-kernel+bounces-445578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34C69F17D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EA1163821
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC07191F77;
	Fri, 13 Dec 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLAWrg+v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019E1917CD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124045; cv=none; b=MDBhNkdpeB2bULAcjnRKJJZNbvqntEjyJc30ie7eyoUq53vKJu1mQsJrC3K14sXyNB7jWbjcOGm3apNRldl9AjoPrmbEP+d6TUj1UJMqnV+7FoMrH2eVrgf5Hm1Ndaz4JYMIMSCm7wqiWouJ2C576Vfm3FkCCkzALP8MXTZbEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124045; c=relaxed/simple;
	bh=gOoZjuHFBtrn/dH11RsszhSAEjd96qL6wW4JewG7Aeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ic6jeYMPfyuhDlGPJgoXWZ/b33YPTBZ2PJhFov+ayA8uzsGyHq5YPRYa9w4Ay0w7L2TuKbj7tFDVAULmsDfxai6ZmMdnH84aicZdz8o3oTkmJvtbQ8EGSJ/hDiVyf40nCmUPPCZE6krbXhP7Xr7ZwmJwoX2Q6xCjXggwCSS4GUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLAWrg+v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734124044; x=1765660044;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gOoZjuHFBtrn/dH11RsszhSAEjd96qL6wW4JewG7Aeo=;
  b=LLAWrg+v2HmzQb2YuMMuYXeJEY57gdxiZjQDQi5bS4Fib4j78PgzGZpJ
   cgO+oW2UKkgJDBfq2Dm4G5JTbLC2hDdp+jMyX47R7lpoR9p04G0jWjQuG
   7qzCPnPOIVgpFT9ByiW01dI4Er4PbLuie8IwNj5MByUoc+rbEoRviZe+w
   DoqNvuPsRBsAYKEc+02BPSc9HIydGemb1nINh8Rml50u5S4dZaruYCdTw
   YCSM9VviXOkrUVWY9HaOit4HRGxYBGr/BT088zGtPa8FgQPeL382PADVi
   A6Vd+A5OhBylN/sbsGN6f9qc34P3xJCzifPU9jQTRNSuWIw1teEAIA3SM
   g==;
X-CSE-ConnectionGUID: 0iw8wtImTOqbSw+DTJbCJA==
X-CSE-MsgGUID: QH1R+e0eQMeT7ndG+2DjZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45997753"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45997753"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 13:07:23 -0800
X-CSE-ConnectionGUID: alWMe3g9TyybQ2Y6X9GnrA==
X-CSE-MsgGUID: l5XHgDTQReKmlvaTNvnBIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101213395"
Received: from ibganev-mobl.amr.corp.intel.com (HELO [10.125.110.228]) ([10.125.110.228])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 13:07:22 -0800
Message-ID: <9cb087c541607a89dd97791a0304887f7fd3a4ba.camel@linux.intel.com>
Subject: Re: [PATCH 5/8] x86/topology: Use x86_sched_itmt_flags for PKG
 domain unconditionally
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>,  Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>,  Meng Li <li.meng@amd.com>, Huang Rui
 <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Fri, 13 Dec 2024 13:07:21 -0800
In-Reply-To: <20241211185552.4553-6-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
	 <20241211185552.4553-6-kprateek.nayak@amd.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
> x86_sched_itmt_flags() returns SD_ASYM_PACKING if ITMT support is
> enabled by the system. Without ITMT support being enabled, it returns 0
> similar to current x86_die_flags() on non-Hybrid systems
> (!X86_HYBRID_CPU and !X86_FEATURE_AMD_HETEROGENEOUS_CORES)
>=20
> On Intel systems that enable ITMT support, either the MC domain
> coincides with the PKG domain, or in case of multiple MC groups
> within a PKG domain, either Sub-NUMA Cluster (SNC) is enabled or the
> processor features Hybrid core layout (X86_HYBRID_CPU) which leads to
> three distinct possibilities:
>=20
> o If PKG and MC domains coincide, PKG domain is degenerated by
>   sd_parent_degenerate() when building sched domain topology.
>=20
> o If SNC is enabled, PKG domain is never added since
>   "x86_has_numa_in_package" is set and the topology will instead contain
>   NODE and NUMA domains.
>=20
> o On X86_HYBRID_CPU which contains multiple MC groups within the PKG,
>   the PKG domain requires x86_sched_itmt_flags().
>=20
> Thus, on Intel systems that contains multiple MC groups within the PKG
> and enables ITMT support, the PKG domain requires
> x86_sched_itmt_flags(). In all other cases PKG domain is either never
> added or is degenerated. Thus, returning x86_sched_itmt_flags()
> unconditionally at PKG domain on Intel systems should not lead to any
> functional changes.
>=20
> On AMD systems with multiple LLCs (MC groups) within a PKG domain,
> enabling ITMT support requires setting SD_ASYM_PACKING to the PKG domain
> since the core rankings are assigned PKG-wide.
>=20
> Core rankings on AMD processors is currently set by the amd-pstate
> driver when Preferred Core feature is supported. A subset of systems that
> support Preferred Core feature can be detected using
> X86_FEATURE_AMD_HETEROGENEOUS_CORES however, this does not cover all the
> systems that support Preferred Core ranking.
>=20
> Detecting Preferred Core support on AMD systems requires inspecting CPPC
> Highest Perf on all present CPUs and checking if it differs on at least
> one CPU. Previous suggestion to use a synthetic feature to detect
> Preferred Core support [1] was found to be non-trivial to implement
> since BSP alone cannot detect if Preferred Core is supported and by the
> time AP comes up, alternatives are patched and setting a X86_FEATURE_*
> then is not possible.
>=20
> Since x86 processors enabling ITMT support that consists multiple
> non-NUMA MC groups within a PKG requires SD_ASYM_PACKING flag set at the
> PKG domain, return x86_sched_itmt_flags unconditionally for the PKG
> domain.
>=20
> Since x86_die_flags() would have just returned x86_sched_itmt_flags()
> after the change, remove the unnecessary wrapper and pass
> x86_sched_itmt_flags() directly as the flags function.
>=20
> Link: https://lore.kernel.org/lkml/20241203221746.GKZ0-Dii5rnZppkM_e@fat_=
crate.local/ [1]
> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred co=
re support")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim

