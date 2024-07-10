Return-Path: <linux-kernel+bounces-247589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47C92D18E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A68286311
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7291922E1;
	Wed, 10 Jul 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qpIvD5RT"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616D191F95
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614489; cv=none; b=Odo4upCgxJ4Ul6loWVtDb/qiKKrKUThjd2V/F+ewV4Ok4b5BsByW9xLEcvMoGkIuH5hez6VhNXrFlz9BWrHk+uL/THAqhFWxkmmm/4q4F86Cfx4NbU43e4pbM5gwCMSFWEtbR+wCIhRnWdUhFCwYSb/ugraeyg9PpHJk0nWVfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614489; c=relaxed/simple;
	bh=KAI4aw2AK+vjSEfQFJSzgOvrFR40OhxPbRnfXKCKSoM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F1+oSIBgUljxjj9QYPm9OInfeW8uCgMBWfhgG2HTcso3lKUBJAWnpGITKJpO7d5VqwcJfVgUz/RtB9CPhGaCT1cVwvJuXES0mZ7iDc2S2DzuMpuXjdbCAK8fdupaNETD8x9+87MmEhzLutp07DyOC/LWrgLV5DIu8x/MO4KYocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qpIvD5RT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720614483;
	bh=Dk9oQcXatpAOcTNW8F66wOLoyQ5TH0P2B5WSusLytqQ=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=qpIvD5RTkuF9fGU3j3NgGN1Vt5MfoHL2HHmrNHOJyC91we37pZlyXosmrger+PW3P
	 xYNcM4NoKB6F+zS3op6Adh4aUQ/GO5X3anLbHBKJBpZuEGM7OY4dWFcTZgPjeEY5f4
	 JZSBu8EIjk95riKS/NmG964c07ZcIUEbYhx9tlr3KHNr2PWsQWKh82az1UaD9qeMmx
	 V7mc2L8OrExqqsImzjcs0xgLrIvvbHjxEdjyOKOitHRQ0LXY9MtICWlf1hi71K6M4v
	 6ajrqWSis8hBkINxnV3zI8uphyFN8xWUS0l9RxNYVASz8AwVdz74wXaxI2aPSx11Sq
	 JQW2dbFkU6AuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJxw23dKxz4w2M;
	Wed, 10 Jul 2024 22:28:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, "Paul E
 . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri
 Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook
 <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
In-Reply-To: <0998f05b-9d5f-4b24-9030-22421e1dd859@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
 <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
 <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
 <0998f05b-9d5f-4b24-9030-22421e1dd859@lucifer.local>
Date: Wed, 10 Jul 2024 22:28:01 +1000
Message-ID: <874j8x5t4e.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
> On Mon, Jul 08, 2024 at 04:43:15PM GMT, Liam R. Howlett wrote:
>>
...
>> The functionality here has changed
>> --- from ---
>> may_expand_vm() check
>> can_modify_mm() check
>> arch_unmap()
>> vms_gather_munmap_vmas()
>> ...
>>
>> --- to ---
>> can_modify_mm() check
>> arch_unmap()
>> vms_gather_munmap_vmas()
>> may_expand_vm() check
>> ...
>>
>> vms_gather_munmap_vmas() does nothing but figures out what to do later,
>> but could use memory and can fail.
>>
>> The user implications are:
>>
>> 1. The return type on the error may change to -EPERM from -ENOMEM, if
>> you are not allowed to expand and are trying to overwrite mseal()'ed
>> VMAs. That seems so very rare that I'm not sure it's worth mentioning.
>>
>>
>> 2. arch_unmap() called prior to may_expand_vm().
>> powerpc uses this to set mm->context.vdso = NULL if mm->context.vdso is
>> within the unmap range.  User implication of this means that an
>> application my set the vdso to NULL prior to hitting the -ENOMEM case in
>> may_expand_vm() due to the address space limit.
>>
>> Assuming the removal of the vdso does not cause the application to seg
>> fault, then the user visible change is that any vdso call after a failed
>> mmap(MAP_FIXED) call would result in a seg fault.  The only reason it
>> would fail is if the mapping process was attempting to map a large
>> enough area over the vdso (which is accounted and in the vma tree,
>> afaict) and ran out of memory. Note that this situation could arise
>> already since we could run out of memory (not accounting) after the
>> arch_unmap() call within the kernel.
>>
>> The code today can suffer the same fate, but not by the accounting
>> failure.  It can happen due to failure to allocate a new vma,
>> do_vmi_munmap() failure after the arch_unmap() call, or any of the other
>> failure scenarios later in the mmap_region() function.
>>
>> At the very least, this requires an expanded change log.
>
> Indeed, also (as mentioned on IRC) I feel like we need to look at whether
> we _truly_ need this arch_unmap() call for a single, rather antiquated,
> architecture.

You can call it "niche" or "irrelevant" or "fringe", but "antiquated" is
factually wrong :) Power10 came out of the fab just a few years ago at
7nm.

> I mean why are they unmapping the VDSO, why is that valid, why does it need
> that field to be set to NULL, is it possible to signify that in some other
> way etc.?

It was originally for CRIU. So a niche workload on a niche architecture.

But from the commit that added it, it sounds like CRIU was using mremap,
which should be handled these days by vdso_mremap(). So it could be that
arch_unmap() is not actually needed for CRIU anymore.

Then I guess we have to decide if removing our arch_unmap() would be an
ABI break, regardless of whether CRIU needs it or not.

cheers

