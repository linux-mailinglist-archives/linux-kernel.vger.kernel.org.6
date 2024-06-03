Return-Path: <linux-kernel+bounces-198967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC458D7FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B6DB20D10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF7824B1;
	Mon,  3 Jun 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwSwei1s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAF7FBA3;
	Mon,  3 Jun 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409486; cv=none; b=Csw0LVM0R04wrk6f8X+wuHvYoUjp+X/2a2jglnv6w51wIBaMZVYOfF7pNWpQjdtfASlfpR5B1dPW5Ahv3EMirL7Eq5ZkD5jsBQNwXxmDGPO4IvPko/qu/C2NoCZKm0y/Noh5Pw4/KrWhsEwuaXjv9+Vt6GvKBxoYOuqvLTHt8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409486; c=relaxed/simple;
	bh=LXJ5YB9dO8bdDQzIQLLZk5NeS3HkpILHWFU/5/MlRzI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tsOO0iLk3wvBKgTD5q9dJU4AAGA32wW9XJTPQYGQ3XYsHO7+CM0L8hqrhlSl2FswotJpRR0DQ6I/AXmUCwHcGnWslIQhXteo/hRCgo/0hj6SkTl1uNMq0ftzooJGS/Nb2xLEeR8urptC9OogqjQBNcsOHe9hT144YmZeC4BnPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwSwei1s; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717409485; x=1748945485;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=LXJ5YB9dO8bdDQzIQLLZk5NeS3HkpILHWFU/5/MlRzI=;
  b=XwSwei1s/O8UgiK7HiYXa8OzmINZAv8oBKDcw2SJLFsHA0KBhVg+GVeR
   j9kcNPiGVYhSNvA1dnkDq2LFQyMCvIJhDv6Kpez5bWr6eetEK8xMS6rl1
   /CcYZor/EQgWmxuFndOFdb65fdLIYuLkxLuqDA8CNMryAUos6sM5i3LyL
   EDbUdI55K5O4FFDIUziN52EVOXxseM2JQCQVE7kRRImZsNqSysU+L3J4y
   gD2fhGtsCsUydCyPBBBlvT8i43gcbXWdS/RtCZGDFwL02VTcSmCyqTJ3F
   k/gbLHptIaVKjY/ZKvDaRY52XejVfXjO92l/O1mIflJuPR0fctR3VcflS
   Q==;
X-CSE-ConnectionGUID: ro3fiQByT4GrsZr3nnc5Cw==
X-CSE-MsgGUID: ZuWRFJn+SBqpQzIrSwFj0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="36417814"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36417814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:11:24 -0700
X-CSE-ConnectionGUID: UxAv791oS8mk3WmdWhwBxQ==
X-CSE-MsgGUID: B85axv69RP2GwBoopIV9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36915625"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.161])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:11:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Jun 2024 13:11:16 +0300 (EEST)
To: "Chang S. Bae" <chang.seok.bae@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
    platform-driver-x86@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, tony.luck@intel.com, 
    ashok.raj@intel.com, jithu.joseph@intel.com, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v3 0/3] x86/fpu: Allow the In-Field Scan driver to
 initialize FPU state
In-Reply-To: <20240530192739.172566-1-chang.seok.bae@intel.com>
Message-ID: <676bfc09-c1f4-9272-a198-3fb865868c10@linux.intel.com>
References: <20240530192739.172566-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-81316292-1717409305=:1529"
Content-ID: <afc06685-6e39-74d5-a470-df656471d706@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-81316292-1717409305=:1529
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0a16be6f-9c4b-800e-b144-cd96f45b85a3@linux.intel.com>

On Thu, 30 May 2024, Chang S. Bae wrote:

> This revision switches to a new approach by providing a helper to
> initialize user FPU states for the driver, which is considerably simpler.
> This approach could serve as an example for addressing similar situations
> from a non-critical path.
>=20
> I thought fpu_reset_fpregs() as the helper name. There is already one
> with this name. Then, I realized the existing one is a bit misaligned, so
> renamed it first here.
>=20
> Thanks to Dave for the reviews and the suggestion.
>=20
> Thanks,
> Chang
>=20
> The previous postings:
> V2: https://lore.kernel.org/all/20240507235344.249103-1-chang.seok.bae@in=
tel.com
> V1: https://lore.kernel.org/all/20240430212508.105117-1-chang.seok.bae@in=
tel.com
>=20
> Chang S. Bae (3):
>   x86/fpu: Rename fpu_reset_fpregs() to fpu_reset_fpstate_regs()
>   x86/fpu: Allow FPU users to initialize FPU state
>   platform/x86/intel/ifs: Initialize FPU states for the scan test
>=20
>  arch/x86/include/asm/fpu/api.h           |  2 ++
>  arch/x86/kernel/fpu/core.c               | 17 ++++++++++++++---
>  drivers/platform/x86/intel/ifs/ifs.h     |  1 +
>  drivers/platform/x86/intel/ifs/runtest.c |  7 +++++++
>  4 files changed, 24 insertions(+), 3 deletions(-)

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Do x86 maintainers plan to take these through their tree?

--=20
 i.
--8323328-81316292-1717409305=:1529--

