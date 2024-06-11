Return-Path: <linux-kernel+bounces-210325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2E904259
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E2B1C23347
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991E4C634;
	Tue, 11 Jun 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TfVWZPhu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684B29CFB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126733; cv=none; b=LRnbU5S1oezKQYiyu1q/fBOdIbbxvAdhbTBkcCtWzBd32OJvWwu+968lvL/C4y3+o4/0z9JX8POfyUmeyS8LuDIuRx/tTYC6zA4YlJ6jJZeWc8CJYPYabPSYhm1hiz0i1TKZqx4aeod53VlgSz3KUx/rKVd+rloio9QVEnUaXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126733; c=relaxed/simple;
	bh=sXsOnOsEJkzdxHb0AOeo80FrLDjg8+O7EkvX3iyA3cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK1yVR00fdtgovEyKo7XYVeHiud/32Qgo/RFWiB8VHoWAOV31mQTf/zZelhHucnd4NBuX7EDXFdiyhBorjPxcnDWz0pDpfKckucthLVC1BKMzfy+kGSM65dixFw9IW/Q0QlH8v/wwnTgBD+Qr8qrxAuFdTc62fHNFAAGI8baGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TfVWZPhu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.212] (103-24-144-85.ftth.glasoperator.nl [85.144.24.103])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5FE1F201F17B;
	Tue, 11 Jun 2024 10:25:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FE1F201F17B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718126730;
	bh=hYy9Z7UOfeApYVUUfEu6Uk3cY5SNJtjciFlw18SBFjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TfVWZPhuOEPUhvge2t3eWBrq5Xs+fciFZeQd+9BHY7bmruOwjJwOfWnOef8AzDfjV
	 KuGF5ntY+kyWuyT8fxcIB/hEQ7ul1pWBgxERnYFoLUc3/AesZ1aysJ6ztqornQFRRU
	 gC/gGDZoKaF5/05iddjqth0JkF5CsHQ01TJ09oac=
Message-ID: <31ead5ce-fb38-4c0d-9bf9-606b59d6da09@linux.microsoft.com>
Date: Tue, 11 Jun 2024 19:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
To: Chris Oo <cho@microsoft.com>, Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, John Starks <John.Starks@microsoft.com>
References: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
 <4df2ebee-40c0-4ea3-8909-13b90f049ff1@intel.com>
 <fa788a95-1814-4782-8a36-f9dce7a04b66@intel.com>
 <DS0PR21MB3863B0D93D5F6D8CBE83931BA5C72@DS0PR21MB3863.namprd21.prod.outlook.com>
Content-Language: en-CA
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <DS0PR21MB3863B0D93D5F6D8CBE83931BA5C72@DS0PR21MB3863.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 19:17, Chris Oo wrote:
> We have a usecase where we have device drivers in usermode using vfio that mmap regions of the address space to access device BARs. In this case, when the #VE handler cannot emulate mmio on behalf of usermode, we need the SIGBUS to know if we should retry the attempt via doing a write via the vfio file descriptor. 
> 
> We don't want to have every mmio go through the vfio file descriptor, because for pages that are actually backed by physical device's BAR we won't take a #VE and introduce a bunch of extra path length, but only if the host has chosen to emulate some page in that BAR. We also don't have any way of knowing which pages will cause a #VE because there's no way for the guest to query which pages the host has chosen to emulate accesses on. 
> 
> Chris
> 
> -----Original Message-----
> From: Dave Hansen <dave.hansen@intel.com> 
> Sent: Tuesday, June 11, 2024 9:16 AM
> To: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>; Dave Hansen <dave.hansen@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; x86@kernel.org; H. Peter Anvin <hpa@zytor.com>
> Cc: linux-coco@lists.linux.dev; linux-kernel@vger.kernel.org; Chris Oo <cho@microsoft.com>; Dexuan Cui <decui@microsoft.com>; John Starks <John.Starks@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
> 
> [Some people who received this message don't often get email from dave.hansen@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 6/10/24 06:55, Dave Hansen wrote:
>>> Enlightened userspace may choose to handle MMIO on their own if the 
>>> kernel does not emulate it.
>>>
>>> Handle the EPT_VIOLATION exit reason for userspace and deliver SIGBUS 
>>> instead of SIGSEGV. SIGBUS is more appropriate for the MMIO situation.
>> Is any userspace _actually_ doing this?  Sure, SIGBUS is more 
>> appropriate but in practice unprepared userspace crashes either way.
> 
> I also can't help but wonder if there's a better way to do this.
> 
> Just thinking out loud.... Ideally, we'd reject creating a potentially troublesome VMA at mmap() time.  That's way better than, for instance, panic()'ing at some random place in the middle of program execution.
> 
> But I guess that's likely not possible because someone could be doing a VM_MIXEDMAP VMA that only has normal private pages and never _actually_ needs or has a shared page mapped.
> 
> I'd still love to know what actual kernel drivers and actual userspace would be involved in this whole dance.  It's still way too theoretical for me.

Is there a reason we can't fix the handler to do the #VE->mmio emulation for userspace too, so that this scenario
works just like outside of a CVM?

