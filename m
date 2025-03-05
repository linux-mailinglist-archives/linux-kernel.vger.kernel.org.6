Return-Path: <linux-kernel+bounces-546017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CDA4F537
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED2116B4D6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695063FBB3;
	Wed,  5 Mar 2025 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFaRJtun"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B21624CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144491; cv=none; b=EElJi5Os1TwMqVziqc+SJBNnDORyV9LkrQLzwgAKBaUsIujSHJ34tiU1/DXtGqYLOHqanHAGWh5fWisE2TBr5IBxN2LfLdOVg3veObDWyd4PYb0OQmVURIgSrDxaVADYLFQnUuZPuhW8PQdzKMZD5tK+eDgwaPUHDcCZdWJloi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144491; c=relaxed/simple;
	bh=mKIwmU5nGmMStslBhDKJLOQp2Mw7lkW2KzNmyVlIHDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3K8fQj7IIiztKncCtof3PRv3ivIICWwPxYYN9hJaVfxqxtN3wwe8P/oOZFWzMMcs+arT7+IB6v7Nr980JtSQqvUbwU33UPcxtnsTrfgBq1QrB1xuMxq7q+3DaHwKEuRfTT2G8CXHcFjRI4OiSSt6qduHKYVbkMSN7+PoXAh04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFaRJtun; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741144488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8OIlrSSbnRoH/I9ueewHmQOSL97xriOrLorU3tLDCU=;
	b=ZFaRJtunE2qx2lOpwyI3mkI6x2wAgX1r/UXvfqkxIqf3HdpclWQrRmfolqrQb2mbOLLBNS
	ETuyY5+ms0EWrpW8Go5E6K0gi2P7qTI822nfCdjufXcFozAJaMOYyyxfaooZHCeVXGLF3X
	CaC58Ehj4ddajvkOECj3kkj8/CtCaHs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-YNMd3QIhMzyrw4QrOqA3PQ-1; Tue, 04 Mar 2025 22:14:42 -0500
X-MC-Unique: YNMd3QIhMzyrw4QrOqA3PQ-1
X-Mimecast-MFC-AGG-ID: YNMd3QIhMzyrw4QrOqA3PQ_1741144482
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0b7ee195bso1288216885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 19:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741144482; x=1741749282;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8OIlrSSbnRoH/I9ueewHmQOSL97xriOrLorU3tLDCU=;
        b=IXjbR8t2p46206dfzCUFmuSjf/I/iareF1IEAh+r9DXNHkNxDu+bp3p1pEi9hEk86k
         lFPFjHtnOwSAxCslytTrF9bDP0f9jQ2x+WO+C21M7mHjW6jXEMEQg3v1IONLvwfgRrNE
         ZxzdFRueVT9UErnXXdpZiRlWUpUly3FAz2LSh7ppW+C7P2z8nGnssx/B1rrscysR7cRS
         BchH6VkjfhayMN6uRq0K289s8/30Npk9IbHyHdf7hnUyO81cbPSKpiUx1W6dXNpXBvho
         rC7q5pav14j8o/KZUgWZpICG3gI+xD1JxyWXH87U/jGpgVZX4MfhS4kllnvlqcA/Pd1W
         FvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk7nRHE5TEoifAYmgw4C2ruTXH785ORlP20DZDeWTymS3g5owjpjxzMdyypYTpbr0Iai6T2f4LpzaJQmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4uIhIDp+BaO+OAW5lDHRkdHw4wno+hTm2AWJU/xu/vgsVGxi
	xR73TBd/kbsHcb59IuJ9rZ1ZEbxGoalr5i63GpCgaSozANDesuDQJPtqaZNMs8U8ZDYk8IYQKfu
	nrmdi9Y2Cti9o5f+KVku5D4B7T5DlNPdhMzr6Cbf3XYeaJWd5KyorMjMtGu5kzMREg17qNQ==
X-Gm-Gg: ASbGncsnuxEl5hbzhPpEuqi1CsH1RUh6UaKoQ+ZQK06lhgORcBJXl35nzs72pPnvH8a
	XOelPCOeIhf2gAvsdnKD18xgO0evzt1+1Vp2nZUwnqz77QKLeL1k+fVi5GHO9noXogwRBMd8R4M
	vXt1zvnBh5aJn2PLBDUUjaPJvPXrJsL9eTqe0t+bufR+Y/s5rcyDdWG5/guvij6KFu8WTbChCa7
	bJQYQB0PT8BU/APldAN1A1UstvwcCf3QDBWt32EH0E/TA/bf1M77pmdlF2/rMk6bcp5dCuMslK5
	peZSjsdxmUH7WWM=
X-Received: by 2002:a05:620a:6411:b0:7c3:bfb3:7f52 with SMTP id af79cd13be357-7c3d8ee1cbbmr262343685a.42.1741144481820;
        Tue, 04 Mar 2025 19:14:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIen1Tkw83r5Q1ou2d9UeK1E+93rOWEHWJsNCoUP22/wPVtYlHBpo4G+TU41xCNd0VtnnNIQ==
X-Received: by 2002:a05:620a:6411:b0:7c3:bfb3:7f52 with SMTP id af79cd13be357-7c3d8ee1cbbmr262341885a.42.1741144481470;
        Tue, 04 Mar 2025 19:14:41 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c395c5376bsm781326385a.37.2025.03.04.19.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:14:41 -0800 (PST)
Message-ID: <36d8ffbda9e69c5245ded717e7491f6fcd5ca72e.camel@redhat.com>
Subject: Re: [RFC PATCH 13/13] KVM: nSVM: Stop bombing the TLB on nested
 transitions
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 22:14:40 -0500
In-Reply-To: <Z8YrdcWd1PD76adM@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-14-yosry.ahmed@linux.dev>
	 <da0b13813b11e5b13f01dced9a629ac07fad27cd.camel@redhat.com>
	 <Z8YrdcWd1PD76adM@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-03-03 at 22:21 +0000, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 09:21:54PM -0500, Maxim Levitsky wrote:
> > On Wed, 2025-02-05 at 18:24 +0000, Yosry Ahmed wrote:
> > > Now that nested TLB flushes are properly tracked with a well-maintained
> > > separate ASID for L2 and proper handling of L1's TLB flush requests,
> > > drop the unconditional flushes and syncs on nested transitions.
> > > 
> > > On a Milan machine, an L1 and L2 guests were booted, both with a single
> > > vCPU, and pinned to a single physical CPU to maximize TLB collisions. In
> > > this setup, the cpuid_rate microbenchmark [1] showed the following
> > > changes with this patch:
> > > 
> > > +--------+--------+-------------------+----------------------+
> > > > L0     | L1     | cpuid_rate (base) | cpuid_rate (patched) |
> > > +========+========+===================+======================+
> > > > NPT    | NPT    | 256621            | 301113 (+17.3%)      |
> > > > NPT    | Shadow | 180017            | 203347 (+12.96%)     |
> > > > Shadow | Shadow | 177006            | 189150 (+6.86%)      |
> > > +--------+--------+-------------------+----------------------+
> > > 
> > > [1]https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 8e40ff21f7353..45a187d4c23d1 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -512,9 +512,6 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> > >  		svm->nested.last_asid = svm->nested.ctl.asid;
> > >  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> > >  	}
> > > -	/* TODO: optimize unconditional TLB flush/MMU sync */
> > > -	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > > -	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> > >  }
> > >  
> > >  static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> > > @@ -530,10 +527,6 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> > >  	 */
> > >  	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
> > >  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> > > -
> > > -	/* TODO: optimize unconditional TLB flush/MMU sync */
> > > -	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > > -	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> > >  }
> > >  
> > >  /*
> > 
> > Assuming that all previous patches are correct this one should work as well.
> > 
> > However only a very heavy stress testing, including hyperv, windows guests
> > of various types, etc can give me confidence that there is no some ugly bug lurking
> > somewhere.
> 
> I tried booting an L2 and running some workloads like netperf in there.
> I also tried booting an L3.
> 
> I am planning to try and run some testing with a windows L2 guest. I am
> assuming this exercises the hyper-V emulation in L1, which could be
> interesting.
> 
> I am not sure if I will be able to test more scenarios though,
> especially Windows as an L1 (and something else as an L2).
> 
> Let me know if you have something specific in mind.


KVM can run itself 'under' HyperV (although in this case when it runs a guest
the guest will be L3 overall, so not really something supported but still something that might
reveal bugs).
In this case KVM/L1 can take advantage of L0's TLB flush interface.

Stress testing L3s also can be nice, although in this case from L0 POV, it doesn't see L3 at all.
Instead it sees that L1 runs two different L2s back to back, so the current code will
likely flush everything all the time.


The direct TLB flush that hyperv does, especially from L2 to L0 should also be tested,
it's a relatively new feature, so we need to check that L2 actually uses it.

KVM also has its own way of TLB flushing paravirtualization, which can in theory interfere with this.


It's also nice to run a hyperv enabled Windows as KVM guest, and run a guest in it (can be Windows or Linux or anything else)
Such guest will run two L2 VMs, Windows itself and the VM you run inside.


You can also try other L1s, like VirtualBox, VMware, running in Windows or Linux L1,
and themselves can run a windows or Linux L2. 

You can also test other OSes like BSD* and such as L1, they might have a different TLB access pattern and
might reveal something, who knows. These can also run L2s using their own hypervisors.

Running a very old (say Windows XP, or some very old Linux) as L2 might also reveal something.

(But don't try to run win95/98 - this OS is known to not flush TLB properly (it doesn't use INVLPG when it should),
so it doesn't work well on AMD at all because of this).

Finally, it might be worth it to develop a TLB stress test if one doesn't exist yet.

Best regards,
   Maxim Levitsky


> 
> > TLB management can be very tricky, so I can't be 100% sure that I haven't missed something.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Thanks!
> 



