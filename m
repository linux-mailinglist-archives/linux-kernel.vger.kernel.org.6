Return-Path: <linux-kernel+bounces-445261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389599F1379
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EFE281026
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8491E412A;
	Fri, 13 Dec 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+0U4aqQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36051E2843
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110355; cv=none; b=Kngxhs5XO1gSODGNjcpdl8tvQfEeJVWc9AH4HmILH75zY8xZPpYVGl+eelFWoxb7n5sTpi+5FXbMOY7UQ+kJKD6pUoRNwsFcyv8U6T3uJQYsKfwqZZoUJuwMlIGCg94Qy8XRt0vn4BTNvS4zf1kFVq5Xqk0uofHBd9Xm/5cMENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110355; c=relaxed/simple;
	bh=r5J8uukViOh/oelgqrLm7boz1x5Cerv0RML0YrI4xxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KcJZVfLMHakgZdS7XPWGpyqq54GLTvhv4WmGmRqWCpsTkDy2pzv4u/+Lo3dDii6jGNXHLSge61ZPBA3QJ6udDoOe7qS5oX5yWzI17YDXYItok4pEWLSfvHw+o6A5sjz6XMur2PkKqYLvh9XInsqucKQ41up2XM7ZQrt6D+qzrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+0U4aqQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734110355; x=1765646355;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r5J8uukViOh/oelgqrLm7boz1x5Cerv0RML0YrI4xxs=;
  b=N+0U4aqQOQl6JYtr+D0RnYz5UyXGGJcVrLXi/lQpEuBVon8Vfe+1JS8U
   YEz3QXI3QuIZW3IOmU7T4FIgCy6tTIDo9rgV8+npU++gel88p1US85lc5
   vDvGGmHuaCAVd3uWUFeBzAM362gL5gYlMEe/lbWU+hVOao8vHgMyCjegM
   HNwZFDntXic1IK/C4L8flANevtYxUewPOhvVY3ni6HDK+u20FG9wohk1H
   zsMabq3uyLB8k/WbP4TCAVKg1lC21EiaFQwQ7+34n96f+OOF/8NsrNuVV
   S3eDj+R+b+0ImzkGYKp4rh42FWXgfoW13F1DD1VF10UStPAsErrC/eW2w
   A==;
X-CSE-ConnectionGUID: L1vYJAuIS0ecgnD3kuwRdg==
X-CSE-MsgGUID: LDKiXv8kTCGKCFqXfUy+Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="57041121"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="57041121"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:19:14 -0800
X-CSE-ConnectionGUID: F6hrSyKOQpKrulRsK7O4zg==
X-CSE-MsgGUID: ppWZ6/qZTe+LUVkZ5vv+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101168449"
Received: from ibganev-mobl.amr.corp.intel.com (HELO [10.125.110.228]) ([10.125.110.228])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:19:12 -0800
Message-ID: <c805040fa2300a186cb8b0e9650543c529bd82ab.camel@linux.intel.com>
Subject: Re: [PATCH 3/8] x86/itmt: Move the "sched_itmt_enabled" sysctl to
 debugfs
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
Date: Fri, 13 Dec 2024 09:19:11 -0800
In-Reply-To: <926692eb-8982-475f-b3ef-4409251623f4@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
	 <20241211185552.4553-4-kprateek.nayak@amd.com>
	 <527d53cded892aea8f36b498ccd42f1bed0a347b.camel@linux.intel.com>
	 <926692eb-8982-475f-b3ef-4409251623f4@amd.com>
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

On Fri, 2024-12-13 at 09:31 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> Thank you for reviewing the series.
>=20
> On 12/13/2024 12:45 AM, Tim Chen wrote:
> > On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
> > > "sched_itmt_enabled" was only introduced as a debug toggle for any fu=
nky
> > > ITMT behavior. Move the sysctl controlled from
> > > "/proc/sys/kernel/sched_itmt_enabled" to debugfs at
> > > "/sys/kernel/debug/x86/sched_itmt_enabled" with a notable change that=
 a
> > > cat on the file will return "Y" or "N" instead of "1" or "0" to
> > > indicate that feature is enabled or disabled respectively.
> > >=20
> >=20
> > Valid values of setting "sched_itmt_enabled" likewise change from "1" o=
r "0"
> > to "Y" or "N".
>=20
> Turns out you can still use "1" and "0". Running:
>=20
>      echo Y > /sys/kernel/debug/sched/verbose
>      echo "sched_itmt_enabled: $(cat /sys/kernel/debug/x86/sched_itmt_ena=
bled)";
>      for i in 0 1 N Y;
>      do
>          echo "Writing $i to /sys/kernel/debug/x86/sched_itmt_enabled";
>          echo $i > /sys/kernel/debug/x86/sched_itmt_enabled;
>          echo "sched_itmt_enabled: $(cat /sys/kernel/debug/x86/sched_itmt=
_enabled)";
>          echo "sched domain flags:";
>          cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags;
>          echo;
>      done
>=20
> Yields the following output on my system:
>=20
>      sched_itmt_enabled: Y
>=20
>      Writing 0 to /sys/kernel/debug/x86/sched_itmt_enabled
>      sched_itmt_enabled: N
>      sched domain flags:
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_PREFER_SIBLING
>=20
>      Writing 1 to /sys/kernel/debug/x86/sched_itmt_enabled
>      sched_itmt_enabled: Y
>      sched domain flags:
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_ASYM_PACKING SD_PREFER_SIBLING
>=20
>      Writing N to /sys/kernel/debug/x86/sched_itmt_enabled
>      sched_itmt_enabled: N
>      sched domain flags:
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_PREFER_SIBLING
>=20
>      Writing Y to /sys/kernel/debug/x86/sched_itmt_enabled
>      sched_itmt_enabled: Y
>      sched domain flags:
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD=
_ASYM_PACKING SD_PREFER_SIBLING
>=20
> Would you like me to extend that note as:
>=20
>      ... with a notable change that a
>      cat on the file will return "Y" or "N" instead of "1" or "0" to
>      indicate that feature is enabled or disabled respectively. User can
>      either write "0" or "1" to toggle the feature off when enabled, or
>      "1" or "Y" to toggle the feature on when disabled.
>=20
> for the record?
>=20
>=20
Sure.  Thanks.

Tim

