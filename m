Return-Path: <linux-kernel+bounces-360779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148A999F68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EEE1F21607
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D600520C46D;
	Fri, 11 Oct 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDrvYZEn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7320C461
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636937; cv=none; b=sytFNsWWK1XeGJuPU5LWWVLH/WNo126y+pzaKcC/WOnMbK9arfqtVjMGYHtXi4IKD13yrEolDQIplhNWVSFL1XSDMCVEEKV1umvO7rLygGQB/eqm61okTAJjlISIE9URzRlYCR2gV+53iTBc1TAYes8gt9aSC8uo42qwne/+LdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636937; c=relaxed/simple;
	bh=OXxFz4k46WgARgdzHOSZugPchaB1Wk40/hefIIy7htk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebKC4HCP4IxCW6Qf+QqeD/qVXQIgeV3w+CZev6urE3DmvTa2as0t1PwaQZTjoc2upYIWQvouLUNGjmjtWJ4susnXRVKDK7Cw/FBeBkxniK19qsTyGpEf4JgUSrOdgr/ZDp0Tp9gzcFjustbfpi6+D9hWljS+7Gvb1QLe3k3ONw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDrvYZEn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728636936; x=1760172936;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OXxFz4k46WgARgdzHOSZugPchaB1Wk40/hefIIy7htk=;
  b=TDrvYZEncb1yvPSnwdK+FvOD7Zo/deCp/pe01puseIb1vQv9+Cvw2Gbe
   hfyw1EgSjpcWWh8slTNruzuCjL24533CLCo0D8wrkp3qqH1aCH35GQUDd
   xma0i7n3dG0MNvL5e76B1p/FRSZaWMJH4bluKvBM3Fl+SuM42UOtx0k0y
   eQDVqEoNMlI36cNMCgC0UQD4jaWCCrUZOheoGMrsImpm6k6Z6cXZ9VgxF
   +hsdbEn75JT0z1bjUASZ+Ww9SUPnSO4IBetMB8FUBeFMXZ2Eidvq4J0AZ
   +Y+CsgOMpqpPGliGQGZDn090skBB3yb42IhP8EydsTTvAplhVLezg6Elw
   A==;
X-CSE-ConnectionGUID: JNjkASSARou+kkCzMK71Mg==
X-CSE-MsgGUID: okOTXHB5THmKrOABkur35A==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31730353"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31730353"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:55:36 -0700
X-CSE-ConnectionGUID: GKIzN5oeTv2hJyQFiCOPvQ==
X-CSE-MsgGUID: ZbYDYBjnRsCB03wIRpltyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76472740"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:55:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>,  x86@kernel.org,
  linux-coco@lists.linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dan Williams <dan.j.williams@intel.com>,
  Kai Huang <kai.huang@intel.com>,  "H. Peter Anvin" <hpa@zytor.com>,  Andy
 Lutomirski <luto@kernel.org>,  Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH -V2] tdx, memory hotplug: Check whole hot-adding memory
 range for TDX
In-Reply-To: <71dc3853-45a6-4fa5-b3c6-b165e0ab6a1b@redhat.com> (David
	Hildenbrand's message of "Fri, 11 Oct 2024 09:53:10 +0200")
References: <20241010074726.1397820-1-ying.huang@intel.com>
	<037801d9-8923-4d49-8423-072fd7c73069@redhat.com>
	<87o73ra0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<71dc3853-45a6-4fa5-b3c6-b165e0ab6a1b@redhat.com>
Date: Fri, 11 Oct 2024 16:51:59 +0800
Message-ID: <87v7xz81jk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 11.10.24 03:27, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>>>    extern u64 max_mem_size;
>>>>      extern int mhp_online_type_from_str(const char *str);
>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index 621ae1015106..c4769f24b1e2 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -1305,6 +1305,11 @@ int try_online_node(int nid)
>>>>    	return ret;
>>>>    }
>>>>    +int __weak arch_check_hotplug_memory_range(u64 start, u64 size)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>
>>> BTW, I remember that "__weak" doesn't always behave the way it would
>>> seem, which is the reason we're usually using
>>>
>>> #define arch_check_hotplug_memory_range arch_check_hotplug_memory_range
>>>
>>> #ifndef arch_check_hotplug_memory_range
>>> ...
>>> #endif
>>>
>>>
>>> Not that I remember the details, just that it can result in rather
>>> surprising outcomes (e.g., the wrong function getting called).
>> I can replace __weak with #define/#ifndef.
>> However, it appears that "__weak" is still widely used now.
>
> Probably better to avoid new ones.

Sure.  Will do that in the future versions.

> See also
> Documentation/dev-tools/checkpatch.rst
>
> I assume checkpatch.pl should complain as well?

Double checked again.  It doesn't complain for that.

--
Best Regards,
Huang, Ying

