Return-Path: <linux-kernel+bounces-364366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCCE99D3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A296C1F24C71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344349659;
	Mon, 14 Oct 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAbhWzFy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DB1C2DB0;
	Mon, 14 Oct 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920555; cv=none; b=qHC6Q9gJa2wxDgR1YHRrPLAK+459BNKbYdwH90yKIdwMq09L0iZU1wDmnHDNJQzl7kMbEhr1kSKp41dhWsn2pt8veFGxPZQzAqwEwAzsWjN2MFzAOAlDwVP5w8+pgFODjjmHTnS5oIE7DC4ZFDljLUoZHCuqRPsKVQ/9/vewcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920555; c=relaxed/simple;
	bh=/nUP2mlzqCX5i75tNPKT7S87hxQ1aNqDDh79E8+6s/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ygl+IQ3N6vSMTjwRBLocQtaS7KQilFqM+MBFPZwCcv8Y3hBq8vABzXgi/h4qzsRUwtMPVKwbkA4n3NQWeLq7rxzem5KEAfAUBIxwp9h53Of1nwCJ8DRtYuDbZg3+K7Vdlhbtkg3fRnhPSAmrTEbBtrUfWH6rZglz6gyZcqJnf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAbhWzFy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728920554; x=1760456554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/nUP2mlzqCX5i75tNPKT7S87hxQ1aNqDDh79E8+6s/8=;
  b=KAbhWzFyMAs4w0lpviQhclX0UjMgMCdtUCxddoOwJ7bg4gVL5GSUzVB7
   Afi+K5e4pB9FzGWNl/i7nJ7kzumL7dDVitwhwRdAZjteBrtrLrAFvv9qV
   ufSvPZmp8Lg31YZ1zRv3y2MpFbVoXT+VN08mxezcNvMR4PhCYHSCVYOXM
   zyGhVpbyio/opEoEQUaeqoUISZ9PuftT9zMBeb8FcBLeeB/Uecu05Rtxv
   v81U9BmNAex1J6qlRhG8AZIKmCCWgFCZhpb6wUp3pdG/YQOQCbIJ8r/dw
   tm2XkPAvALgzugsMMGyElmcGJvuP4vIpQ5plvHxsk2Yf+XxuJ7h9/p9oD
   w==;
X-CSE-ConnectionGUID: qMqVKo2gQfm3dZN+Yy7HHQ==
X-CSE-MsgGUID: iIr0WDJdR0K72nKhPF+S2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="39654079"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="39654079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:42:33 -0700
X-CSE-ConnectionGUID: 7HePNSvNQm2WACOayQ4v2Q==
X-CSE-MsgGUID: N5ywXJcjSkCviPaBerwuFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82367621"
Received: from bpdinse-mobl.amr.corp.intel.com (HELO [10.125.96.75]) ([10.125.96.75])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:42:31 -0700
Message-ID: <88baaae8-d9fe-4c8a-a5e2-383d6b641e2c@linux.intel.com>
Date: Mon, 14 Oct 2024 08:42:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
To: Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241010045219.vgpcl7nfqaimqrne@treble.attlocal.net>
 <20241010145737.GOZwfrYaGxCOOlaVhy@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241010145737.GOZwfrYaGxCOOlaVhy@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 07:57, Borislav Petkov wrote:
> On Wed, Oct 09, 2024 at 09:52:19PM -0700, Josh Poimboeuf wrote:
>> Is this a realistic use case?  Are people really going to want to
>> enable/disable VERW mitigations as a group?

They have to. The way you do it today is by setting four different options. If
you miss one and your system has the bug you missed, too bad, you're getting the
mitigation enabled. Since we have four bugs but only one mitigation, I thought
it made more sense to just have 1 knob to control it rather than 4. However,
since we'd need to keep those old knobs around anyway it turns out we'd just
have 5. :( <insert XKCD comic here>

> 
> +1.
> 
> David's per-attack-vector stuff will simplify the user side of this
> considerably so I'm trying real-hard to find the point for a new option.
> 
> IOW, the reason I requested this cleanup is to have proper sync between the
> different mitigations all using VERW behind the scenes. But there's no need to
> change the user interface, is it?
> 

The reason I did the patches this way wasn't so much "need" as it just seemed a
simpler way to do it. Why have 4 knobs when there is really only 1 mitigation
under the hood? My question for you then is what you mean by "proper sync"? I'm
guessing you mean that if any one of those 4 mitigations is set to off then
assume all are off? No one should want to set say, MMIO to =off but RFDS to =on,
so the only real issue is if I set some to =off, but leave others unset, the
unspecified options will default to on, which means all are on. If the desire is
to reverse that so any one of the 4 being disabled is enough to disable all VERW
mitigations, I can make that change. I just want to make sure I know what the
desired path is.

Thanks,
Dan

> Thx.
> 

