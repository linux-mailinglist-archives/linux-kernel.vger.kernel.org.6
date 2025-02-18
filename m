Return-Path: <linux-kernel+bounces-519850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14392A3A2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308A43B4D52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AA26B2D0;
	Tue, 18 Feb 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJ5DEJJ+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D960198E60
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895918; cv=none; b=fcHoC6xdSkhOIXTqoEzWfH6akhS/zJWCH7pT6OjUPPrZhCv466r19qjk6Yg/V0NtLOzgccrLRphdg/ucJhvZhLGWWdwsBS0y1D3FA9AKKdDUittZ8nF1oBIDb3D0TTuzcaGK/z5sIjNSp0UZwikwG9u6dyVr76FtVOCJXElUxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895918; c=relaxed/simple;
	bh=41BI8YlrCGmBKS+t8IH/N263QGj1uwZ0cBkSEzL2LRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1s7e7wJRUau6DE2NxLdeQ1QDdne7y3RB8s0Aud2hm8fQ4XRRQpXgHt5rKgm54vWeFWT/qOOkTRHm2J0ICQW47h2KpbMy1Fjy8udyWVSqTRTMODD3urE5/0rNCkVekHWrj1OPJThHtXhAwirvCyHTkVqni0X0P+CKKKE4p9N6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJ5DEJJ+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739895915; x=1771431915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=41BI8YlrCGmBKS+t8IH/N263QGj1uwZ0cBkSEzL2LRI=;
  b=AJ5DEJJ+uZvoA7qulgh7uVAy8dkhTu53b92aq0P9P/O1Wsg81q1p6aJV
   fx9ubB6858NidTAJwReQ545l5C5axqcTSfnGt5t6cHJlrVEOrZOehVEvV
   50pp35hsGqcUVBSXMIl3NZX6PjLzsDC3DXFMAnpX5oE/8/6RXZWrR8RZ1
   XTO62EsvDdZGY2n5+n3axoUwszrCC0PsqgOMda5p/V6bNf00uu6y0f8J1
   SPyXFMafJ8jdPOx7eRe3Xb80F5TMcmybM6Ok3KAn87sj58W1ogNHnXSYn
   PNWrExG1yl5O+Wigncw0Y0ITpCF9HpezUyE2OjXQBfx5ud0MojVJhRqjW
   g==;
X-CSE-ConnectionGUID: zo9RmKOSRjCXqk6HoY9BAA==
X-CSE-MsgGUID: iy/yKA5sSdKts1gDESVLJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52029936"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52029936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 08:25:14 -0800
X-CSE-ConnectionGUID: bR7eGB9cT/S1HdZh82AbWA==
X-CSE-MsgGUID: APnwE7LjS5Ss6ce2pApoEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114374448"
Received: from dikoukis-mobl1.amr.corp.intel.com (HELO [10.95.1.75]) ([10.95.1.75])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 08:25:13 -0800
Message-ID: <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com>
Date: Tue, 18 Feb 2025 10:25:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: "Xing, Cedric" <cedric.xing@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Dan Williams
 <dan.j.williams@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com>
 <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
 <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com>
 <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
Content-Language: en-US
From: Dan Middleton <dan.middleton@linux.intel.com>
In-Reply-To: <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/25 3:59 PM, Xing, Cedric wrote:
> On 2/14/2025 10:26 AM, Dave Hansen wrote:
>> On 2/14/25 08:19, Xing, Cedric wrote:
>>>> But if this is for debug, wouldn't these belong better in debugfs? 
>>>> Do we
>>>> really want to maintain this interface forever? There's no shame in
>>>> debugfs.
>>>>
>>> There are many other (more important/significant) uses besides 
>>> debugging.
>>>
>>> For example, any applications that make use of runtime measurements 
>>> must
>>> extend RTMRs, and this interface provides that exact functionality.
>>>
>>> Another example, a policy may be associated with a TD (e.g., CoCo) by
>>> storing its digest in MRCONFIGID, so that the policy could be verified
>>> against its digest at runtime. This interface allows applications to
>>> read MRCONFIGID.
>>
>> The attestation world is horrifically complicated, and I don't
>> understand the details at _all_. You're going to have to explain this
>> one to me like I'm five.
>>
>> Could you also explain how this is different from the hardware and
>> virtual TPMs and why this doesn't fit into that existing framework? How
>> are TVMs novel? What justifies all this new stuff?
> TVM (TEE VM) is a broad term referring to encrypted/protected VMs on 
> various confidential computing (CC) architectures, such as AMD SEV, 
> Arm CCA, Intel TDX, etc. Each of these architectures includes hardware 
> components for storing software measurements, known as measurement 
> registers (MRs). This patch series aims to provide the necessary 
> functionality for applications that need to access these MRs.
>
> There are no real/hardware TPMs but only virtual ones in TVMs. Virtual 
> TPMs can be built upon the native MRs provided by the underlying CC 
> architectures.
>
> If you need more detailed information, I'd be happy to discuss it 
> further offline to avoid cluttering the mailing list.
>
Hi Dave,

Let me try to add more plain language usages.

This ABI lets applications extend events after boot such that they can be
part of the hardware-based attestation.

One common reason is to _identify the workload_ running in the VM.
Typically a VM attestation tells you that you booted to a clean state.
It is much more valuable to a Relying Party to know that they are 
interacting
with a trusted application / workload.
Projects like CNCF Confidential Containers [1] and Attested Containers
[2] would like to do this.

More generally, Relying Parties can track the state of an application in
the attestation. Auctions are common examples of stateful flows where it
can be meaningful to, e.g., attest that a bid arrived before or after the
close of an auction.

[1] 
https://github.com/confidential-containers/guest-components/blob/main/attestation-agent/attester/src/tdx/rtmr.rs
[2] https://github.com/intel/acon

Thanks,
Dan Middleton



