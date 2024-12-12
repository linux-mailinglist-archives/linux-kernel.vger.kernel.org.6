Return-Path: <linux-kernel+bounces-443974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93339EFE75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A519628C994
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777BF1D88DB;
	Thu, 12 Dec 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNjB5VCn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99E1D79BE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039471; cv=none; b=ZXkGvloY7chtImkVGkU8jRoDi8Lj/POMRTJ9ucmW1p5fexIDTchQRzahFVggzFVDqobpqPXsXFDNLcWUdW4/3TBu2YxYsIP2vKdd6T7aKm5VcMok1r1AYEWtjsRexlUuZS/dlpJoqcrKNaERIdalnRqvg62atW6aSgYSf4bWCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039471; c=relaxed/simple;
	bh=kaPZY6wsTh/Ec1bfnAaF3rdx+E8UORQZThv0ilb9dDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyMEnuKCokALDntGMKVmqObkSmWZNAqTeSHO1KEG8uNMQt1ya7c+qzaidD/qgpHUDNZHZWKDQlyZurhYMsiE3AZJPn5FjcBXP7JB02x6AF10Uhv3dlkdHfpvTsXbzGmEwcSHPvr8X9mpOVwbvnZEbnY9E19Vy0GcNa59ZGqpwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNjB5VCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734039468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKHzpPuGEO/3T/KEzMr/64WE4qzCFA/dEqv+m7ITukY=;
	b=JNjB5VCn1cApMUsIZEAsiPwdBLgKY5C7QksLS1yNN1vmCaFThTQYD2c2XxMFVLSjwun2Hf
	RACX9IMT02/WQsTGcFnvDX4gZC0fMYZwP326Au88sKf59r0xQmMM+mc5YIhj09/Fn8aR2N
	aqed4OUWOZXqeVyo0YNqxM5VKcp4I5E=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-yu3jhUb0MSKQX9tW5-_ztQ-1; Thu, 12 Dec 2024 16:37:47 -0500
X-MC-Unique: yu3jhUb0MSKQX9tW5-_ztQ-1
X-Mimecast-MFC-AGG-ID: yu3jhUb0MSKQX9tW5-_ztQ
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so10097465ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039466; x=1734644266;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKHzpPuGEO/3T/KEzMr/64WE4qzCFA/dEqv+m7ITukY=;
        b=hvT6fSA2+HIt9OUtaOfyORJ0LyaCzoWb6HmbpsMwSelg6E85kzfRc9cfHUP993MKs4
         KE8l3VDtkmINMkLIUVzL8XkWZCAzV6ohWSz4Xg4rhtU4LnUNO8FJsOPfG5JtbBNQvyMW
         GKk/g2N84+NWfRUxeCNmlG8Y0VHQtUaN1jcQzaUzIMU5hzRZwV9OJBLuz+gmTmA0nEqf
         pF4DH2Q830Mdkarwr7go9U+KfE9/w3Rcymet1l9IijMgYZVjZprMzIAemoEhN8Dpa9WD
         sW22sp5vkqqIbbcgH5z8EhqFxEHcX5UVOI7N3GU4ImAUoBA3sYP6rOtneLUS5hMlPgFn
         fHLg==
X-Forwarded-Encrypted: i=1; AJvYcCXdz1vEcNqmyUjIyP4Y8wQenDcwAJkiQcDN5P9GgyJjPGOS9pMTKkEoAr2+hE3nl5O7pLlHslA/qAXEoHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0dGvuzmR5UVgtBrZimLlJ6/02gByzGHWWP6VkSeq9Rzb7DoU
	ZRjTOIRFuYLPJcUOGpsRVaicE1TOA9ditpR5/iwF/Wu2fuS4d1hZuNr/Y1sLpwUHyZPtvRb/YI6
	R5v6dOmWL+cgTQfBtjNl2vHaQpQtUacFClHau6G+fNK9kJvqKtapRVwOxcC7m9w==
X-Gm-Gg: ASbGncuORgtxYAXvNWEm51Etuu6D/QoLJhyav1YtmhZloIet28uiVhPZAS1nLHzjb/5
	FqfU9dBzgVNUToO8fTd9WZNKd8YI1dwK59E42CPHKGsPwMkSL6emC7clDoSg3qLhwO+Sb53Q717
	jKafAdlnEpwG4GfYFk9/YtiXgJXQ6CI2ZQ4tQIoE1DCHQx5W9EKUp84cdoVlbZ/HuwtkS3HIJGu
	V4lAL++siBjudJHKl/A8zBoRijGJxxy6i65HJbJbx5ewBPWeM07Lky7
X-Received: by 2002:a05:6e02:152e:b0:3a7:6c5c:9aa4 with SMTP id e9e14a558f8ab-3aff039a391mr3984515ab.12.1734039466553;
        Thu, 12 Dec 2024 13:37:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeV195XzIYia2v2u9MDS/N8vM2Lw7lpW67TJ3ir6GUbqpYrtePcNFNOCHDFoVqZrzpzMNyiQ==
X-Received: by 2002:a05:6e02:152e:b0:3a7:6c5c:9aa4 with SMTP id e9e14a558f8ab-3aff039a391mr3984305ab.12.1734039466125;
        Thu, 12 Dec 2024 13:37:46 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c5db2de1sm2002931173.32.2024.12.12.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 13:37:45 -0800 (PST)
Message-ID: <a3e75091f2b6b13d4907ac2fdf09058ab88c4ebf.camel@redhat.com>
Subject: Re: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it
 was written
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, Paolo Bonzini
	 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Date: Thu, 12 Dec 2024 16:37:44 -0500
In-Reply-To: <Z1ox4OHNT6kkincQ@google.com>
References: <20241211193706.469817-1-mlevitsk@redhat.com>
	 <20241211193706.469817-2-mlevitsk@redhat.com> <Z1ox4OHNT6kkincQ@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-12-11 at 16:44 -0800, Sean Christopherson wrote:
> On Wed, Dec 11, 2024, Maxim Levitsky wrote:
> > X86 spec specifies that the CPU writes to the PML log 'backwards'
> 
> SDM, because this is Intel specific.
True.
> 
> > or in other words, it first writes entry 511, then entry 510 and so on,
> > until it writes entry 0, after which the 'PML log full' VM exit happens.
> > 
> > I also confirmed on the bare metal that the CPU indeed writes the entries
> > in this order.
> > 
> > KVM on the other hand, reads the entries in the opposite order, from the
> > last written entry and towards entry 511 and dumps them in this order to
> > the dirty ring.
> > 
> > Usually this doesn't matter, except for one complex nesting case:
> > 
> > KVM reties the instructions that cause MMU faults.
> > This might cause an emulated PML log entry to be visible to L1's hypervisor
> > before the actual memory write was committed.
> > 
> > This happens when the L0 MMU fault is followed directly by the VM exit to
> > L1, for example due to a pending L1 interrupt or due to the L1's 'PML log full'
> > event.
> 
> Hmm, this an L0 bug.  Exiting to L1 to deliver a pending IRQ in the middle of an
> instruction is a blatant architectural violation.  As discussed in the RSM =>
> SHUTDOWN thread[*], fixing this would require adding a flag to note that the vCPU
> needs to enter the guest before generating an exit to L1.

Agree, note that this is to some extent visible not nested as well, for example 
this workaround that the test has is for non nested case.

One can argue that dirty ring is not an x86 feature, but I am sure that there are
other more complicated cases in which retried write can be observed by this or
other vCPUs in the violation of x86 spec.

> 
> Oof.  It's probably worse than that.  For this case, KVM would need to ensure the
> original instruction *completed*.  That would get really, really ugly.  And for
> something like VSCATTER, where each write can be completed independently, trying
> to do the right thing for PML would be absurdly complex.

I also agree. Instruction retry is much simpler and safer that emulating it, KVM
really can't stop doing this.


> I'm not opposed to fudging around processing the PML log in the "correct" order,
> because irrespective of this bug, populating the dirty ring using order in which
> accesses occurred is probably a good idea.
> 
> But, I can't help but wonder why KVM bothers emulating PML.  I can appreciate
> that avoiding exits to L1 would be beneficial, but what use case actually cares
> about dirty logging performance in L1?

It does help with performance by a lot and the implementation is emulated and simple.

For example this test without pml collects about 500 pages on each iteration
with default parameters, and about 2400 pages per iteration with pml 
(after the caches warm up).


> 
> [*] https://lore.kernel.org/all/ZcY_GbqcFXH2pR5E@google.com
> 
> > This problem doesn't have a noticeable real-world impact because this
> > write retry is not much different from the guest writing to the same page
> > multiple times, which is also not reflected in the dirty log. The users of
> > the dirty logging only rely on correct reporting of the clean pages, or
> > in other words they assume that if a page is clean, then no writes were
> > committed to it since the moment it was marked clean.
> > 
> > However KVM has a kvm_dirty_log_test selftest, a test that tests both
> > the clean and the dirty pages vs the memory contents, and can fail if it
> > detects a dirty page which has an old value at the offset 0 which the test
> > writes.
> > 
> > To avoid failure, the test has a workaround for this specific problem:
> > 
> > The test skips checking memory that belongs to the last dirty ring entry,
> > which it has seen, relying on the fact that as long as memory writes are
> > committed in-order, only the last entry can belong to a not yet committed
> > memory write.
> > 
> > However, since L1's KVM is reading the PML log in the opposite direction
> > that L0 wrote it, the last dirty ring entry often will be not the last
> > entry written by the L0.
> > 
> > To fix this, switch the order in which KVM reads the PML log.
> > 
> > Note that this issue is not present on the bare metal, because on the
> > bare metal, an update of the A/D bits of a present entry, PML logging and
> > the actual memory write are all done by the CPU without any hypervisor
> > intervention and pending interrupt evaluation, thus once a PML log and/or
> > vCPU kick happens, all memory writes that are in the PML log are
> > committed to memory.
> > 
> > The only exception to this rule is when the guest hits a not present EPT
> > entry, in which case KVM first reads (backward) the PML log, dumps it to
> > the dirty ring, and *then* sets up a SPTE entry with A/D bits set, and logs
> > this to the dirty ring, thus making the entry be the last one in the
> > dirty ring.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 32 +++++++++++++++++++++-----------
> >  arch/x86/kvm/vmx/vmx.h |  1 +
> >  2 files changed, 22 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 0f008f5ef6f0..6fb946b58a75 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6211,31 +6211,41 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
> >  {
> >  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> >  	u64 *pml_buf;
> > -	u16 pml_idx;
> > +	u16 pml_idx, pml_last_written_entry;
> > +	int i;
> >  
> >  	pml_idx = vmcs_read16(GUEST_PML_INDEX);
> >  
> >  	/* Do nothing if PML buffer is empty */
> > -	if (pml_idx == (PML_ENTITY_NUM - 1))
> > +	if (pml_idx == PML_LAST_ENTRY)
> 
> Heh, this is mildly confusing, in that the first entry filled is actually called
> the "last" entry by KVM.  And then below, pml_list_written_entry could point at
> the first entry.
> 
> The best idea I can come up with is PML_HEAD_INDEX and then pml_last_written_entry
> becomes pml_tail_index.  It's not a circular buffer, but I think/hope head/tail
> terminology would be intuitive for most readers.

I agree here. Your proposal does seem better to me, so I'll adopt it in v2.
> 
> E.g. the for-loop becomes:
> 
> 	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--)
> 		u64 gpa;
> 
> 		gpa = pml_buf[i];
> 		WARN_ON(gpa & (PAGE_SIZE - 1));
> 		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
> 	}
> 
> >  		return;
> > +	/*
> > +	 * PML index always points to the next available PML buffer entity
> > +	 * unless PML log has just overflowed, in which case PML index will be
> 



> If you don't have a strong preference, I vote to do s/entity/entry and then rename
> PML_ENTITY_NUM => NR_PML_ENTRIES (or maybe PML_LOG_NR_ENTRIES?).  I find the
> existing "entity" terminology weird and unhelpful, and arguably wrong.

I don't mind renaming this.

> 
>   entity - a thing with distinct and independent existence.
> 
> The things being consumed are entries in a buffer.
> 
> > +	 * 0xFFFF.
> > +	 */
> > +	pml_last_written_entry = (pml_idx >= PML_ENTITY_NUM) ? 0 : pml_idx + 1;
> >  
> > -	/* PML index always points to next available PML buffer entity */
> > -	if (pml_idx >= PML_ENTITY_NUM)
> > -		pml_idx = 0;
> > -	else
> > -		pml_idx++;
> > -
> > +	/*
> > +	 * PML log is written backwards: the CPU first writes the entity 511
> > +	 * then the entity 510, and so on, until it writes the entity 0 at which
> > +	 * point the PML log full VM exit happens and the logging stops.
> 
> This is technically wrong.  The PML Full exit only occurs on the next write.
> E.g. KVM could observe GUEST_PML_INDEX == -1 without ever seeing a PML Full exit.

I skipped over this part of the PRM when I was reading upon how PML works.
I will drop this sentence in the next version.

> 
>   If the PML index is not in the range 0–511, there is a page-modification log-full
>   event and a VM exit occurs. In this case, the accessed or dirty flag is not set,
>   and the guest-physical access that triggered the event does not occur.
> 

Do you have any comments for the rest of the patch series? If not then I'll send
v2 of the patch series.


Best regards,
	Maxim Levitsky


