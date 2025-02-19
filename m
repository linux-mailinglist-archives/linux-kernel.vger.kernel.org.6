Return-Path: <linux-kernel+bounces-521894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C08A3C38D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54341887214
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E31F63CD;
	Wed, 19 Feb 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCMDBRO/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBF1F4620
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978660; cv=none; b=o2UYejmr+vMQFI5wev4e7aMFRtfYyHWW4Tx59q+JT7nZY5B7dn/XAPACUj5AOxpv94Rej87REv7/RHFFBZFyWsZqUhw4DgJgEOLWNFiVc04nOFVzYZjfnlQgt9AAaGUd7Dg2AfO/LmiVRwbBn6XMb1sKJbxAzR3f2eLAWmpCvQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978660; c=relaxed/simple;
	bh=S6kWXOEKCNTpONNTTMFTfbh/ZbOQZ6LQf/TKh3Xx36Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvwCQE+4kKRTXUcNOWJzf4ePhjIjuNzgDllz6p1RJMvwNcEJ6bEgE08mfLWHNOxiShtzu0JKQ1fzHbskN1zHHJiB4q1XHxeeICvEzzNgR5bStsrpU+nXsC5JFgC1BCsc7WfIBlcI6sCNn517jJ7uhBrilYH0K4aEZUHrfurimMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCMDBRO/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739978657; x=1771514657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S6kWXOEKCNTpONNTTMFTfbh/ZbOQZ6LQf/TKh3Xx36Q=;
  b=HCMDBRO/9ayns3lkNYDY+YAgZgGCFvZIO615EZnMWvuW9RRPvg9PKttr
   QrqJaY0NDoNRenunyBGkWf59bIRz7oeZnwwblRjiSSZx1HLh+jDvYe87c
   l/nsLPzZnAxlF11Hf7jiL2jaf2RAVjQdL8/Ra2R7kl+EDxA1iuSDRDXb6
   2Gl6KFDLqg8Q2gSkOrvdpCuODstNd5mlt/CaQGhslzsKaxnb7FOsQMKIT
   6RtiiTdC9VXjnSBDi10KgQ4zvlWMu9rCIXiX8U/C5dC4Efsu2SSMyGy4k
   1VqPmLp7Wcqj1/uxy4Tg7BYmhxkxUnW0DC1qW1SKFEk2WoBJB+rPWlyiB
   A==;
X-CSE-ConnectionGUID: 8f0Y9FNwSK2Vol05hz6Xrg==
X-CSE-MsgGUID: Q4a6jnrhRGSuzZxneBLA1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51702637"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51702637"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:24:17 -0800
X-CSE-ConnectionGUID: P7wh4j4wSdi1qx2m16E5lA==
X-CSE-MsgGUID: Lc4PSn6jRQ6S/9GuavgXPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119385439"
Received: from dikoukis-mobl1.amr.corp.intel.com (HELO [10.95.1.75]) ([10.95.1.75])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:24:14 -0800
Message-ID: <8009a9fd-c7b1-48e3-af8b-8f481328c597@linux.intel.com>
Date: Wed, 19 Feb 2025 09:24:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: "Xing, Cedric" <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev,
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
 <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com>
 <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
 <CAAH4kHYq7_3vLXQaCA7iKF+mC5Pg0cn-1FsB-iCbN7Jim9a-OQ@mail.gmail.com>
 <650b6236-50d3-4932-b5bc-056fd29c93a7@intel.com>
 <CAAH4kHYye2ApqYb3GmHSt2Ge4B1m55mA54Ch-f1RCzh3GZuHOw@mail.gmail.com>
 <cccce005fc19dc05caf67c454bd669d524c862bf.camel@HansenPartnership.com>
Content-Language: en-US
From: Dan Middleton <dan.middleton@linux.intel.com>
In-Reply-To: <cccce005fc19dc05caf67c454bd669d524c862bf.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/19/25 7:29 AM, James Bottomley wrote:
> On Tue, 2025-02-18 at 19:21 -0800, Dionna Amalie Glaze wrote:
>> On Tue, Feb 18, 2025 at 4:41 PM Dave Hansen <dave.hansen@intel.com>
>> wrote:
>>>
>>> On 2/18/25 15:57, Dionna Amalie Glaze wrote:
>>>>> If there are actual end users who care about this, it would be
>>>>> great to see their acks on it as well.
>>>>>
>>>> We would like to have this for Google Confidential Space and
>>>> Kubernetes Engine.
>>>>
>>>> Acked-by: Dionna Glaze <dionnaglaze@google.com>
>>>
>>> Great! Thanks for chiming in. Can you talk for a second, though,
>>> about why this is useful and how you plan to use it? Is it for
>>> debugging?
>>
>> Confidential space on SEV depends on the hypervisor-provided vTPM to
>> provide remotely attestable quotes of its PCRs, and the corresponding
>> event logs.
>> https://github.com/google/go-tpm-tools/blob/main/launcher/agent/agent.go#L97
>>
>> On TDX and ARM CCA (maybe RISC-V CoVE someday), we don't want to have
>> to depend on the vTPM.
> 
> I still don't get why one of the goals seems to be to artificially
> separate AMD Confidential Computing from Intel (and now Arm and RISC-
> V).
> 
>> There are runtime measurement registers and the CCEL.
>> When we have a sysfs interface to extend these registers, it makes
>> the user space evidence manager's life easier.
>> When Dan Williams forced the issue about configfs-tsm, we were told
>> that it is bad for the kernel to have many platform-specific
>> interfaces for attestation operations.
>> This patch series is a way to unify behind the tsm.
> 
> You say "unify behind", but this proposal doesn't include AMD and it
> could easily.  All these RTMR systems are simply subsets of a TPM
> functionality with non-standard (and different between each of them)
> quoting mechanisms.  The only real substantive difference between RTMR
> systems and TPM2 is the lack of algorithm agility.  If everyone is
> determined to repeat the mistakes of history, TPM2 can easily be
> exposed with a pejorative algorithm, so it could fit into this
> structure with whatever the chosen hash is and definitely should be so
> the interface can really become a universal one applying to both Intel
> *and* AMD.
  > The only real argument against adding a TPM that I've seen is that it
> potentially expands the use beyond confidential VMs, which, in an
> interface claiming to be universal, I think is actually a good thing.
> There are many non-CC use cases that would really like a non-repudiable
> logging system.

Hi James,
This isn't excluding AMD. AMD just happens not to have a feature common 
to the other architectures.
Intel TDX, Arm CCA, and RISC-V COVE all provide architectural 
measurement registers. SEV happens not to have these today but should 
they in the future, they can draft off of the work here.
Might also be worth remembering the original author of the series 
represented RISC-V COVE.

While someone can emulate a TPM using the architectural measurement 
registers as a backing store, they don't have to. Certainly it's also 
possible to provide a vTPM in a protected region of memory, but that 
shouldn't block the legitimate interests of using the architectural 
features of TDX, CCA, and COVE.

> Just on algorithm agility, could I make one more plea to add it to the
> API before it's set in stone.  You might think sha384 will last
> forever, but then that's what the TPM1 makers thought of sha1 and that
> design decision hasn't been well supported by history.  The proposal is
> here:
> 
> https://lore.kernel.org/linux-coco/86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com/

This was helpful feedback. Cedric incorporated it into v3 of the RFC series:

https://lore.kernel.org/linux-coco/20241210-tsm-rtmr-v3-2-5997d4dbda73@intel.com/

We thought your silence on v3 meant you were happy with that feature. 
Lots of threads to track though so also not surprised if you didn't see 
it, or possible we misinterpreted your feedback.

It is retained in this patch set:
https://lore.kernel.org/linux-coco/20250212-tdx-rtmr-v1-2-9795dc49e132@intel.com/


> Worst case is I'm wrong and you're right and we have an additional
> directory in the configfs tree (and you never get to see my tiktok I
> told you so dance).  

Now I have something to look forward to today. :-D

> But if I'm right, we've got algorithm agility
> (especially if post-quantum has some impact on hashes that hasn't been
> foreseen) built in from the get go instead of having to be welded on
> after the fact when we run into problems.
> 
> All I need at this stage is crypto agility in the configfs ABI.  I can
> add vTPM code to that without anyone at Intel having to worry about it.
> 
> Regards,
> 
> James
> 

Thanks,
Dan Middleton


