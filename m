Return-Path: <linux-kernel+bounces-417699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D424C9D5816
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E6F1F22B02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395614D2B1;
	Fri, 22 Nov 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/j6Qkbt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4F4C6C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241497; cv=none; b=ofyXyGe+QoiZPwyuKOHJi4lTG6f+fZUY6aNx3WafZsOL9vz2HdbG+fUOIAWEel2PTVudpcHNGUg6gl4GkuUWLsttnfzE0Thoe204EWTgM2c+Igg14Pkk8dO19HEr+lSoRhW/hTXVI84dZQdQzxunjNOuLwuFrpXkwdQTlyPillM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241497; c=relaxed/simple;
	bh=15oWvzbzFsyC7/bysCZCjLNUSlvH0XT1jyi58VfdcYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZBmo4OmqnoTvnxLPsahf6fL9vM7b/6I+ti7ExU/Obc5gTskdgKWVgJBWS5ULwPx4c2JZUukWZcUy2Jax9bDwx1tBTtl3uELN3pTnc+l4FF1KZTECLzO0etmM545Jpkl4CD91J8/lxCZ1/S3WDD80kqfWDitneUz9AkSum+Nmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/j6Qkbt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xprF6kwslVLv7gu/pvSQtcz8F91IGU/uA30drlMd3hg=;
	b=L/j6QkbtkEVJxWJdAggI6x5aFjuZnSLEg3dFSRvFWAG2V8cymI87JIpmgJ3qIlu8QRQzQ+
	efJ0gqLH5oTdVUXaEy3XpZmXAQhIWjntaBXf3zJojkvBDFA607vRiLDj06jWcZND3J7x+K
	bJK/SB8spiLkWc7frpN4+xAHwvYUltg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-L6Nmgb4CMCOCKPzIFl3PcA-1; Thu, 21 Nov 2024 21:11:33 -0500
X-MC-Unique: L6Nmgb4CMCOCKPzIFl3PcA-1
X-Mimecast-MFC-AGG-ID: L6Nmgb4CMCOCKPzIFl3PcA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d41a3c9c9cso21290206d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241492; x=1732846292;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xprF6kwslVLv7gu/pvSQtcz8F91IGU/uA30drlMd3hg=;
        b=v11DNXz+YuB3pGBS1bNXLNfQ/115MMfKx32ZNQPKUYoDTyrZunIXicJIw4qODyerlC
         fGrDSsRCaE1QynGHb55ZNvpPkcYmG7RU/vn5YhqxsGBQ8DhVSYHDKkdQNIv6WTu10EkN
         1GEFbuZmoFi2wsCL5o/GWdRENnQPbcZGWaV1d54TrwCTXG1F1KAtjxQjK08dwfVCaRTI
         zzSSxUaKb63WKsO4KHpm2lJe6iEH5PLkLNqQiG+U5l3mjX6pePr1I0n5SsW8ly3D+OHO
         201QHeFIJlGLaycHHG5Z0SQUuEUYvRAgZwhDBAxFWSdV+J9dxfsP1zLP6Bos72CGovy9
         XC4g==
X-Forwarded-Encrypted: i=1; AJvYcCV5q9nEMA5IlAyZSQ1j86PFsFvKt5Mty1zK5cQNs2XxcQC5cPCQ/TgyErn72zdSM4/Bm6LzeWgWN+LFAmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEa0nKO7rpwcEj4hNoAVZ96ye/XSIFMX4WW8V9fh8Kd+ORPYPt
	qNBWzP8SK01fIFcJtP5toUZyVVnaLsyzzCp9SIf6GbvII6llCj6qsMpC6YZr7Fa1dSi9Pp5QgBY
	FCziAmcq40xprAIbFTVNgMTzOD+iSdwW1giW+oMUR4bz58zoB9nswtCCmmYMjkA==
X-Gm-Gg: ASbGncsOn3LC2qC0obDOfkRroHoKC8BWiXLP8rt/P3ihbvT5qzkU1rK7L7K5qIzhs14
	BeNppG4W7p2EkkgQosbizToVzZ4AIKr4mhsJcZpmSNizc5e2AQd4Xk4wEja89mGuJDV+mDAuqLl
	Aq9GltbR8kCoEbvfGZSklJAGWuw6oi8cvUTlRwFXccw5MxQXWYRMHS1lQ3YTQdmCTRI6kXW2wYZ
	lGdpMfeXQdXTMYfqgvx5qD77RMJIf2PIwiIJbGAE7JKy2hvzA==
X-Received: by 2002:ad4:576e:0:b0:6ce:26c3:c6e6 with SMTP id 6a1803df08f44-6d45137a320mr21571326d6.40.1732241492728;
        Thu, 21 Nov 2024 18:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzV5VTqMmVWe7TtTxnNt3pCfkC0t6uOXM7iv1ufGpnFtArMOqeHEkUI6z9ExmizFfWkqlNdg==
X-Received: by 2002:ad4:576e:0:b0:6ce:26c3:c6e6 with SMTP id 6a1803df08f44-6d45137a320mr21570996d6.40.1732241492428;
        Thu, 21 Nov 2024 18:11:32 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a831edsm4276196d6.10.2024.11.21.18.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 18:11:32 -0800 (PST)
Message-ID: <8e5d5480e7f926329759f41933df0d59185cf1e4.camel@redhat.com>
Subject: Re: [PATCH v2 44/49] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 21 Nov 2024 21:11:30 -0500
In-Reply-To: <ZuG6LqLA6tGw9Edi@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-45-seanjc@google.com>
	 <2d554577722d30605ecd0f920f4777129fff3951.camel@redhat.com>
	 <ZoyDTJ3nb_MQ38nW@google.com>
	 <b9cf0083783b32fd92edb4805a20a843a09af6fc.camel@redhat.com>
	 <ZuG6LqLA6tGw9Edi@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-09-11 at 08:41 -0700, Sean Christopherson wrote:
> On Tue, Sep 10, 2024, Maxim Levitsky wrote:
> > On Mon, 2024-07-08 at 17:24 -0700, Sean Christopherson wrote:
> > > On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > > > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > > > -		cpuid_entry_change(best, X86_FEATURE_OSPKE,
> > > > > -				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> > > > > +		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSPKE,
> > > > > +					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> > > > > +
> > > > >  
> > > > >  	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 0);
> > > > >  	if (best)
> > > > 
> > > > I am not 100% sure that we need to do this.
> > > > 
> > > > Runtime cpuid changes are a hack that Intel did back then, due to various
> > > > reasons, These changes don't really change the feature set that CPU supports,
> > > > but merly as you like to say 'massage' the output of the CPUID instruction to
> > > > make the unmodified OS happy usually.
> > > > 
> > > > Thus it feels to me that CPU caps should not include the dynamic features,
> > > > and neither KVM should use the value of these as a source for truth, but
> > > > rather the underlying source of the truth (e.g CR4).
> > > > 
> > > > But if you insist, I don't really have a very strong reason to object this.
> > > 
> > > FWIW, I think I agree that CR4 should be the source of truth, but it's largely a
> > > moot point because KVM doesn't actually check OSXSAVE or OSPKE, as KVM never
> > > emulates the relevant instructions.  So for those, it's indeed not strictly
> > > necessary.
> > > 
> > > Unfortunately, KVM has established ABI for checking X86_FEATURE_MWAIT when
> > > "emulating" MONITOR and MWAIT, i.e. KVM can't use vcpu->arch.ia32_misc_enable_msr
> > > as the source of truth.
> > 
> > Can you elaborate on this? Can you give me an example of the ABI?
> 
> Writes to MSR_IA32_MISC_ENABLE are guarded with a quirk:
> 
> 		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT) &&
> 		    ((old_val ^ data)  & MSR_IA32_MISC_ENABLE_MWAIT)) {
> 			if (!guest_cpuid_has(vcpu, X86_FEATURE_XMM3))
> 				return 1;
> 			vcpu->arch.ia32_misc_enable_msr = data;
> 			kvm_update_cpuid_runtime(vcpu);
> 		} else {
> 			vcpu->arch.ia32_misc_enable_msr = data;
> 		}
> 
> as is enforcement of #UD on MONITOR/MWAIT.
> 
>   static int kvm_emulate_monitor_mwait(struct kvm_vcpu *vcpu, const char *insn)
>   {
> 	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS) &&
> 	    !guest_cpuid_has(vcpu, X86_FEATURE_MWAIT))
> 		return kvm_handle_invalid_op(vcpu);
> 
> 	pr_warn_once("%s instruction emulated as NOP!\n", insn);
> 	return kvm_emulate_as_nop(vcpu);
>   }
> 
> If KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT is enabled but KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS
> is _disabled_, then KVM's ABI is to honor X86_FEATURE_MWAIT regardless of what
> is in vcpu->arch.ia32_misc_enable_msr (because userspace owns X86_FEATURE_MWAIT
> in that scenario).
> 

OK, makes sense.
Best regards,
	Maxim Levitsky



