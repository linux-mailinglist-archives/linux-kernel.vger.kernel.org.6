Return-Path: <linux-kernel+bounces-172910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF128BF87F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9273B210C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303047A5C;
	Wed,  8 May 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2DrG6QJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72031A28B;
	Wed,  8 May 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156903; cv=none; b=PL910Dcei9HY702ohLzjEkRUukWGmBkdZecUDFxCDEsBAoAS7+OPikkXUjL9cJhy4T7YYn1eL6kZTq6SLCtAp5ZQVrMBgIPx40WLacEYfPPLi9gNLgB1eXNUTXQocLToSY1W7p31u4YpzoEjwvn934kSiCsrJM2lr9hOoTokg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156903; c=relaxed/simple;
	bh=L1Lspn0M8w8szRsrIq5g4DMduLChT+SxYoYpT6S+K4I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BGhfiC2FH/iQdV/T7784B+bfY/Z7exVZwRjyVZZyz+BGSL+ZSRiLiTPnSorkVcl6idaCksjNYxH/AAcn1wtzT1zznKrlDGdKiitNwNhdeH1Ah567d2mMGQwH0SrlpfDEJJ0A9Bb4u2t0GfhEAX9N8o32cDn6kP+0IFxsJlzKwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2DrG6QJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715156903; x=1746692903;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L1Lspn0M8w8szRsrIq5g4DMduLChT+SxYoYpT6S+K4I=;
  b=d2DrG6QJYWIAup9z6Y0G/zbkCBikUx6V41LU3lZ+FRZ6xVWkn8eL07dP
   7i4NGWSM2r37wwtTqG+lii3tlG1Z4I7sz7KJLKxhf/TbgTwkXRRkM82oe
   NwNF9SwizR6csQb3q7Hq56TsTzcdWeXXXtaPvl0gA/mQH5xKMtOY3M020
   NCbANzXz8+P/Qv3ZC5u6jp6nYbamsyGNu2oS/bIqqFAzHAnkUI/0o6XeF
   i2ctnVf1dy8TI/JN5cZSwY8Mb2QhYEIRNVANROUeMJwpHM2dG/3rYnSH+
   KVOErW+xqNgISYyLeP/Pm2bRENZaXngxGqLWhhGhGZYVHcyjiMktNaUE6
   g==;
X-CSE-ConnectionGUID: vUeseLJmRQSPLM/G1CYrBw==
X-CSE-MsgGUID: dkmBrYyvT1yaZq5O4X/l5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21563903"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="21563903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:28:21 -0700
X-CSE-ConnectionGUID: cg70KTtxQXKU9tWoogn3Zw==
X-CSE-MsgGUID: siTQPQqARdu8IGyJ0ibx9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28680769"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:28:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 May 2024 11:28:10 +0300 (EEST)
To: "Chang S. Bae" <chang.seok.bae@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
    platform-driver-x86@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, tony.luck@intel.com, 
    ashok.raj@intel.com, jithu.joseph@intel.com
Subject: Re: [PATCH v2 0/2] x86/fpu: Extend kernel_fpu_begin_mask() for the
 In-Field Scan driver
In-Reply-To: <20240507235344.249103-1-chang.seok.bae@intel.com>
Message-ID: <80023e25-e582-e0aa-7428-ee17fecdbcef@linux.intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com> <20240507235344.249103-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1145016416-1715156890=:3164"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1145016416-1715156890=:3164
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 May 2024, Chang S. Bae wrote:

> Following feedback from the previous posting [1], this revision comes
> with the changelog updates for more clarity:
>=20
> * The recent change in the SDM alone does not fully explain the
>   underlying reasons. Provide a clearer explanation rather than simply
>   echoing the SDM text.
>=20
> * While it is feasible for administrators to isolate CPUs running the
>   In-Field Scan tests from those running AMX workloads, this approach is
>   considerably disruptive and conflicts with the goal of its live
>   testing. Add this point to the changelog as well.
>=20
> Thanks to Dave for highlighting these aspects [2]. Additionally, it is
> worth noting that the IFS Technical Paper [3] was recently published,
> which may offer further context on the IFS testing.
>=20
> Thanks,
> Chang
>=20
> [1] V1: https://lore.kernel.org/lkml/20240430212508.105117-1-chang.seok.b=
ae@intel.com/
> [2] Feedback: https://lore.kernel.org/lkml/a41d7012-2eea-436e-9f7e-6a7702=
f7e2c2@intel.com/
> [3] IFS Paper: https://www.intel.com/content/www/us/en/content-details/82=
2279/finding-faulty-components-in-a-live-fleet-environment.html
>=20
> Chang S. Bae (2):
>   x86/fpu: Extend kernel_fpu_begin_mask() to initialize AMX state
>   platform/x86/intel/ifs: Initialize AMX state for the scan test

For both patches:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1145016416-1715156890=:3164--

