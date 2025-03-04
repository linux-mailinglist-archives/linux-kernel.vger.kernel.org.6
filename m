Return-Path: <linux-kernel+bounces-545063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B88A4E897
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068C2178116
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04A27F4C5;
	Tue,  4 Mar 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuNCmdXk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920627EC71
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107438; cv=none; b=YmVmbE4ocYshefy5I02JbfVDvk5r/NZNXKS/Cht41wfLQfh1v0+qVVEAHOodljxWQTTFpBX5Ym7tpHF/Ht8nbN2a4JK4fNh/Jyl+Tci+hhoVz+o5Obox9HxUKsEZXd41pSq/csOOFo+glDBh9j0u05HDiaYswyXEHCAkMYJsxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107438; c=relaxed/simple;
	bh=0n1PIIDxuQDvV7ZsbxVTgwbqXjYd78S4fo1MllcLwfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPJ/rynxGtDdJbEoJZuTth8V17q+nohSN9GMb5Qp3R0kL1uufwEhmkd0WGTrPXr3EP64K24hjuVUeOoQux2fgasVB3R+ZZH1j2KQOi+wuqsZmF42xm/BpS97VZhrSXFzfb+UD7SLgSOyPdpMgcUZ0nxnnazMl5e5b92lBgonLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuNCmdXk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741107437; x=1772643437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0n1PIIDxuQDvV7ZsbxVTgwbqXjYd78S4fo1MllcLwfc=;
  b=YuNCmdXkBdLcGSs3lCkybpWVe9E/HuQYE0aM2OkLLKRuhivllkBFeSxm
   izhzbtkU6bWkJBLfjPnG15L/rkkPsKd8UNSitcChR/bVng/UnqvV2IhKJ
   bzM96MBCUKJcsXOk+fOM8l//v4dqPv9PA0FViS/2BvAg5/pcHpRIe4Snd
   tk0/uvT6pNjD7k2bPZTXHSUdNQo8gaTzOW2RCuq40aHkthQrXZrtX1Vt/
   r0TgfSPxq8S2o92KilPCDhoKQELVmG4jh0Kzuenv2MEnry1h3zjFibuXp
   DXWGCXa28mjJB3SKdOp7CmtKid7N0Rbi59tZmgqJY+5s3sCQLFJmd39P+
   w==;
X-CSE-ConnectionGUID: T5ulhf30TwGYY9sNpBAt6g==
X-CSE-MsgGUID: fJuP6OKLTLOvI2crYDtKWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45962711"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="45962711"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:57:12 -0800
X-CSE-ConnectionGUID: RGKbpq32R2ScmU9n2y4vMA==
X-CSE-MsgGUID: ptbVZF9XRwmAq7eIkhIatQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118426666"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.109.94]) ([10.125.109.94])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:57:11 -0800
Message-ID: <2efa96d5-b26a-4058-a353-5dd2180ed502@intel.com>
Date: Tue, 4 Mar 2025 08:57:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/13] x86/mm: add INVLPGB support code
To: Borislav Petkov <bp@alien8.de>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
 <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
 <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
 <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>
 <20250304110032.GEZ8bdUOg2WLUrhMcm@fat_crate.local>
 <ec7247d0-0379-487d-a2d7-21b81dcd0c38@intel.com>
 <20250304161901.GCZ8cn9d252LTzThpI@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250304161901.GCZ8cn9d252LTzThpI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 08:19, Borislav Petkov wrote:
> +static inline void __invlpgb_all(unsigned long asid, unsigned long pcid,
> +				 unsigned long addr, u16 nr_pages, u8 flags)
> +{
> +	__invlpgb(asid, pcid, addr, nr_pages, 0, flags);
> +}

Why would __invlpg_all() need an 'addr' or 'nr_pages'? Shouldn't those be 0?

It's _better_ of course when it happens at a single site and it's close
to a prototype for __invlpgb(). But it's still a magic '0' that it's
impossible to make sense of without looking at the prototype.

Looking at the APM again... there really are three possible values for
ECX[31]:

 0: increment by 4k
 1: increment by 2M
 X: Don't care, no increment is going to happen

What you wrote above could actually be written:

	__invlpgb(asid, pcid, addr, nr_pages, 1, flags);

so the 0/1 is _actually_ completely random and arbitrary as far as the
spec goes.

Why does it matter?

It enables you to do sanity checking. For example, we could actually
enforce a rule that "no stride" can't be paired with any of the
per-address invalidation characteristics:

	if (stride == NO_STRIDE) {
		WARN_ON(flags & INVLPGB_FLAG_VA);
		WARN_ON(addr);
		WARN_ON(nr_pages);
	}

That's impossible if you pass a 'bool' in.

But, honestly, I'm deep into nitpick mode here. I think differentiating
the three cases is worth it, but it's also not the hill I'm going to die
on. ;)

