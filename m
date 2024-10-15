Return-Path: <linux-kernel+bounces-365337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4457D99E0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE952830A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08641D9A7E;
	Tue, 15 Oct 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e12uUUhH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2F1B85F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980311; cv=none; b=j5oBV+GOzGvniw+7870CcLqFMFEi7dY7xe8A+5SsZ4U2OELSjiLkp9yLiXGnU0DxG2zs7erqxFAIP0+WpW8rnpK58d0FtLjXa2XRnVPAgqSxg2bEkLxs6w4XWaII0wwS4FxNuFPyJ75LZ0J3M7ki+R6n2HeHapa6siEUV7mRTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980311; c=relaxed/simple;
	bh=ZvCjhxA9HJtkjiVT2jrS8KFmWhTXeVw6tlAsxhIikfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UzRBjlJ0oFmpAVOyaGOOwo+0NfHPxgJxVvvZzg7h3LRqN8gzPfxNHMJ30tghi/fxrlnIuQyR/QvD4o+Kle2wMPL9CQ0Hd0YHS+cizgaSww9em4dFFVvg+yhtI0pRlSgqOCMPrqYWgSOZnQM6lIM7tyzYnCgpf5eRBXY7rxi8oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e12uUUhH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728980308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSzugHJUE0V5VnxcNgtSlLmUlo3tP8MuSc6Q2lgQWPQ=;
	b=e12uUUhHAqI/PgeVtnf+pMUYSVrKNSSz0t6gHX/JVwGyjrOcbHlbd2BKchk80aJh9hjMnd
	O9707dXwnSM8EmhAbCM4u5Jj19XMKR9hI6p8fGxLC9F1Ker29vThvybb6S9HV1ErtzXyKj
	RRVyHIf/XSbK7y8z5IXHj9UpGJfsOLw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-J6wGr2z_P5Gwszg_z9VLlQ-1; Tue, 15 Oct 2024 04:18:27 -0400
X-MC-Unique: J6wGr2z_P5Gwszg_z9VLlQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e7dc83ecso1858120e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980306; x=1729585106;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSzugHJUE0V5VnxcNgtSlLmUlo3tP8MuSc6Q2lgQWPQ=;
        b=qLZMLuKXBv+gVZz/xzfZM8m3Hw3K7tYk3TLjo5Fjb8V3WGMpLydpVN8pqSWeh4uiYB
         +3uUOr1mN3MFuAM40MGjsYOq2WXmnxXkCCbjG1nodtArf782jPzaG/SkWwXqOCak5tuQ
         nrccCpPxI+GBUr/f28YrxdB+KTIUSocmYE7MKQf3plesbyCC8zhNgS6UwUA3fbYNPugi
         /+IL/wG+ABLKBw7Cv6r20LAc5f/+uJjHUFjE+KTWvbBSrIWdAzFuz/PUSLk+GLFR46Ov
         JstMXya8xSa7F6GngYKJRpXcLaV6uMsDYPX15jzfs6ozwxpMbvai9n/nrajpMfR4Iuwe
         pVsA==
X-Forwarded-Encrypted: i=1; AJvYcCVcsJch6tmihxiaal49ZWH5WUeNeccVYOPa1spOEBB29qdgZhc8t/AEELPHAFIRQkt1kGPHxiBu6pBfRyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWN8hXHiJwlhN+WUX46B4wBn8bj1W59dRjG3rjOt4kqn43u/Ij
	1uyT5xsmkrhZBqI7z5PoH9GApWpDJULcyD879nfk22GB+c/O3CX+l1AfZN3AUSf47Jew9861X7n
	NgVieVJOvDepbL2TqKQoT7zW3YNZug5tHI4GgkiXdPsJuao8Tu6LcU0DXYg0Ceg==
X-Received: by 2002:a05:6512:110c:b0:539:e65a:8a71 with SMTP id 2adb3069b0e04-539e65a8c28mr4531966e87.34.1728980305700;
        Tue, 15 Oct 2024 01:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM8egqE9jF4dTVTryZ5qbA3smtlVhU0CSpeShuRlF/pW2Bor/bfD2IwVw3AXprpgQ+VaOz1g==
X-Received: by 2002:a05:6512:110c:b0:539:e65a:8a71 with SMTP id 2adb3069b0e04-539e65a8c28mr4531938e87.34.1728980305162;
        Tue, 15 Oct 2024 01:18:25 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981765esm40175766b.129.2024.10.15.01.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:18:24 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nikolas Wipper <nik.wipper@gmx.de>, Nikolas Wipper <nikwip@amazon.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
 <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
 nh-open-source@amazon.com, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
In-Reply-To: <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-3-nikwip@amazon.de> <875xq0gws8.fsf@redhat.com>
 <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de>
Date: Tue, 15 Oct 2024 10:18:23 +0200
Message-ID: <87h69dg4og.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolas Wipper <nik.wipper@gmx.de> writes:

> On 10.10.24 10:57, Vitaly Kuznetsov wrote:

...

>>>  int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
>>> +
>>> +static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
>>> +{
>>> +	return vcpu->arch.hyperv_enabled &&
>>> +	       READ_ONCE(vcpu->arch.hyperv->suspended);
>>
>> I don't think READ_ONCE() means anything here, does it?
>>
>
> It does prevent compiler optimisations and is actually required[1]. Also
> it makes clear that this variable is shared, and may be accessed from
> remote CPUs.
>
> [1] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html#Variable%20Access

It certainly does no harm but I think if we follow 'Loads from and
stores to shared (but non-atomic) variables should be protected with the
READ_ONCE(), WRITE_ONCE()' rule literally we will need to sprinkle them
all over KVM/kernel ;-) And personally, this makes reading the code
harder.

To my (very limited) knowledge, we really need READ_ONCE()s when we need
to have some sort of a serialization, e.g. the moment when this read
happens actually makes a difference. If we can e.g. use a local variable
in the beginning of a function and replace all READ_ONCE()s with
reading this local variable -- then we don't need READ_ONCE()s and are
OK with possible compiler optimizations. Similar (reversed) thoughts go
to WRITE_ONCE().

I think it's OK to keep them but it would be nice (not mandatory IMO,
but nice) to have a comment describing which particular synchronization
we are achieving (== the compiler optimization scenario we are protecting
against). 

In this particular case, kvm_hv_vcpu_suspended() is inline so I briefly
looked at all kvm_hv_vcpu_suspended() call sites (there are three) in
your series but couldn't think of a place where the READ_ONCE() makes a
real difference. kvm_hv_hypercall_complete() looks pretty safe
anyway. kvm_hv_vcpu_unsuspend_tlb_flush() will be simplified
significantly if we merge 'suspended' with 'waiting_on': instead of 

      kvm_for_each_vcpu(i, v, vcpu->kvm) {
              vcpu_hv = to_hv_vcpu(v);

              if (kvm_hv_vcpu_suspended(v) &&
                  READ_ONCE(vcpu_hv->waiting_on) == vcpu->vcpu_id) {
...

you will have just

      kvm_for_each_vcpu(i, v, vcpu->kvm) {
              vcpu_hv = to_hv_vcpu(v);

              if (vcpu_hv && vcpu_hv->waiting_on == vcpu->vcpu_id) {
...
(and yes, I also think that READ_ONCE() is superfluous here, as real
(non-speculative) write below can't happen _before_ the check )

The last one, kvm_vcpu_running(), should also be indifferent to
READ_ONCE() in kvm_hv_vcpu_suspended(). I may had missed something, of
course, but I hope you got my line of thought.

-- 
Vitaly


