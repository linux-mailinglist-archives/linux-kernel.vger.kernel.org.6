Return-Path: <linux-kernel+bounces-399116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69279BFB32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA8728365D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCA748F;
	Thu,  7 Nov 2024 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmleWpL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+Chfr6Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6987FD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941970; cv=none; b=aXxIoRTWPwVRQgxe0utt/eIKA2Vra4uxSn0c+3M5rGpaRENsGao+1rQPqgKjrK0MpoJlfmYFGQ5ZOeHtr5aLHdHYw6z6a8LMDHZ6lge1N2qDjPy/HxlxASbO6uX2Gy18qdZa4AzXd+iqj6dxg6H/HHPD/zR3D9fwp0F8PHnPQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941970; c=relaxed/simple;
	bh=8BLm52tbFEjoztu2a01Ardm74i+i0KI3EroNuzoKLy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/HjXL/4mpTduO/fzBWqNudubaKdGdl2bs3tCs8KJhq2GbHYueSbOA/7Uc96VRDf/lITtZEU058V71JKjML2fw2BXdqJOl09NW77stYyv+y/NaRfqDFFzVS2EK20Zb4r3bPjkFYDum6mKhEIcMD7jSzb7QjjcdTUbBkixzld8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmleWpL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+Chfr6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730941966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=act+zDiEtT7+JX2MGLF3u/R7N8AnaR1UJrIxY1dNyrg=;
	b=AmleWpL0prF2mywlJ8B3QXVZwFuXCmSUL6aE4tDpWnmEhSaQiHZ2WpqVwx0QHYFPlMl7kz
	DMfnKn+ewvH/JCTOs6NgTwSqt0G7T5CeVKQ6MWtSRtSZY39DmyYRrVTL/v9B+9nImt4R12
	7NtAypxvAahnchTuHPyuakjaUDMIa9uNImYLkptgMFHNzV/hxFnengFlaoh0vnJJNayP/A
	k4PP0wjbZwDmEkZccsQMbzCfTUeSaYAiglyaBEvao3na/de+0uunxoKQU1O2Qx/4JvS1T5
	vkwrPYQEVfZ2StOShMuQn9E/U+A01gcnGrp3zTCgaAWdQFH0b+zWqtwO0M7H9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730941966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=act+zDiEtT7+JX2MGLF3u/R7N8AnaR1UJrIxY1dNyrg=;
	b=a+Chfr6QxnjBsxyaG6yTgUHFyCqMwxQcWmda81eCJS/15fc2QeBQpJhiPv74Vyin5YbPWa
	ekzf3Jo+8CahwWDw==
To: "Chang S. Bae" <chang.seok.bae@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode staging
In-Reply-To: <d8d3959a-8c38-4ce4-885d-6a1e40219831@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-5-chang.seok.bae@intel.com>
 <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
 <d8d3959a-8c38-4ce4-885d-6a1e40219831@intel.com>
Date: Thu, 07 Nov 2024 02:12:46 +0100
Message-ID: <871pznq229.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 06 2024 at 10:28, Chang S. Bae wrote:
> On 11/4/2024 3:16 AM, Borislav Petkov wrote:
>> On Tue, Oct 01, 2024 at 09:10:39AM -0700, Chang S. Bae wrote:
>>> +
>>> +static bool need_staging(u64 *mmio_addrs, u64 pa)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; mmio_addrs[i] != 0; i++) {
>>> +		if (mmio_addrs[i] == pa)
>>> +			return false;
>>> +	}
>>> +	mmio_addrs[i] = pa;
>> 
>> This is a weird function - its name is supposed to mean it queries something
>> but then it has side effects too.
>
> I think I've carved out a bit more out of the loop and convoluted them
> into a single function.
>
> Instead, let the helper simply find the position in the array,
>
>          static unsigned int find_pos(u64 *mmio_addrs, u64 mmio_pa)
>          {
>                  unsigned int i;
>
>                  for (i = 0; mmio_addrs[i] != 0; i++) {
>                          if (mmio_addrs[i] == mmio_pa)
>                                  break;
>                  }
>                  return i;
>          }
>
> and update the array from there:
>
>          static void stage_microcode(void)
>          {
>                  unsigned int pos;
>                  ...
>                  for_each_cpu(cpu, cpu_online_mask) {
>                          /* set 'mmio_pa' from RDMSR */
>
>                          pos = find_pos(mmio_addrs, mmio_pa);
>                          if (mmio_addrs[pos] == mmio_pa)
>                                  continue;
>
>                          /* do staging */
>
>                          mmio_addrs[pos] = mmio_pa;
>                  }
>                  ...
>          }
>
> Or, even the loop code can include it:
>
>          for_each_cpu(...) {
>                  /* set 'mmio_pa' from RDMSR */
>
>                  /* Find either the last position or a match */
>                  for (i = 0; mmio_addrs[i] != 0 && mmio_addrs[i] != 
> mmio_pa; i++);
>
>                  if (mmio_addrs[i] == mmio_pa)
>                          continue;
>
>                  /* do staging */
>
>                  mmio_addrs[i] = mmio_pa;
>          }

This looks all overly complicated. The documentation says:

  "There is one set of mailbox registers and internal staging buffers per
   physical processor package. Therefore, the IA32_MCU_STAGING_MBOX_ADDR
   MSR is package-scoped and will provide a different physical address on
   each physical package."

So why going through loops and hoops?

   pkg_id = UINT_MAX;

   for_each_online_cpu(cpu) {
   	if (topology_logical_package_id(cpu) == pkg_id)
              continue;
        pkg_id = topology_logical_package_id(cpu);

        rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &pa);
        staging_work(pa, ucode_patch_late, totalsize);
   }

Something like that should just work, no?

Thanks,

        tglx




