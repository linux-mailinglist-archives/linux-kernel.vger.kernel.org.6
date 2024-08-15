Return-Path: <linux-kernel+bounces-287651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A3952AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C572831D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D71AED33;
	Thu, 15 Aug 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs3h0oQs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52244176AA9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709762; cv=none; b=C02mN1tn4JIaov1DnbZhWWOjRCfnO/KqL7oQqbVFSHFRJB6Jj8ja+aczmCojJIed2tEXYMnY1oEVyjN3F4bzU7yo2v+rHCvxaLQzprmtk3FsoTrDebsaGvzeUTTWZWIOBGVDQVJ3ua4Nc5T7yBkaEFFjRQ90ZkFCpfMyDLLlKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709762; c=relaxed/simple;
	bh=It2n54/Wszz22dJy2yFkRqq3oHwCh6v6hF6ITpdTWaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnIZDxdQJFRCnC3EgmUExCzpmpe7Dl1umJFfMrwPuxNBGq5XChKUY+M7rRpOVnkv4RqAJqHkc5ESIka6IJSj4Eu2jpfon/RHVaIKsEsgO28LxTRRmRykVlWFinqLkXR5f8T4uOzARnxbuy6bgHtVAmSEmcLUcg6NFRmRQIC2QOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs3h0oQs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723709759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6siwQRc65l8C/JRIpOzVH+/lh/N1bi7Q5Wrmcr0+NwY=;
	b=cs3h0oQsedm7XwDrJn2RVNfRlxsq/hCcFZEa1W5CA322gr8C3ljXzl+Dk+VypeWqitYHmX
	FVrZ2SUMSo0ZvpU4HUU9C4SdNaAzFaFrBFftCPVwDdTsALw89kaCkxokJugxwbtuStw0/J
	rLU0UfBpOyWY+OI72YYg04oqsH4GtDc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-0IeDo_v0OaCbyYSIf3bvDA-1; Thu, 15 Aug 2024 04:15:57 -0400
X-MC-Unique: 0IeDo_v0OaCbyYSIf3bvDA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-429c224d9edso3975575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723709756; x=1724314556;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6siwQRc65l8C/JRIpOzVH+/lh/N1bi7Q5Wrmcr0+NwY=;
        b=et907qkBqiBdbcNytVLRKmF5aj9CsJ6mdt/OTSkDn3LXVQeuM2hP/DU8RbSK+Cn+T7
         Yh9IC2IzXkiiEP2JCu2+ku0cUfbfS3pMnzOG1YzWba+yyE2vzad+yk5MeXj4TIDLJIaP
         ilOlJpwwDmoAvT3+DzaHtjKITdXEp9q4+WevtBUkK+VtOzRTmCkVWiHKygkK7/h0W8DV
         OUHA0A8S8Op5gpiF6mK6kALeSOPlDLpdNZOGDb6Sxp5ivI8yW1zeRyJBplW2g+QYn36K
         2YB9/7p/MZUPCmxvhwFMJE5u5rX751AdXeCbSZ6u+F0Ky7VFQRZqG1Qn9Hvy9H8qYBJx
         IVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUBIedwk+VGHd19CXnsRd+5XgslDg2pQTs4VXHpPzRcX7mBbs57dDmqvtR8lYoBCgz3wD43IFowS/mXsC6HiBJzRuYwvfmEUmi7kaau
X-Gm-Message-State: AOJu0YxPlUJKItezEZu7ShzedECLgrvFD3DEYjpbJU4kBzcUYoqXgDFD
	TMq3F+oP8qtcnC5jBsl8UkbUcyn63ddVrDpQ3ZYmgoCYwctOPa/knWjPLMC90g0/sxXDxUb+0Er
	founlagunuFXHx5KBBxPdJe3ye8HEB15A4O7GKVb5C6dR+ioTbZQoouHctlMe+9xxzjrumqYzBN
	/czVYA+aEhrGmS3UJhrp+F2iyPaPvX0DMYQFVNQ2VmEiNarg==
X-Received: by 2002:a05:600c:190e:b0:427:ff7a:79e with SMTP id 5b1f17b1804b1-429dd2393f0mr36255105e9.16.1723709755774;
        Thu, 15 Aug 2024 01:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoCzTh17WSwxryGBjxZNK9ZCVO20bZbVHu6qlfgD4Z3joMLanQfxCiyYHbDAD7X7wJK27mdQ==
X-Received: by 2002:a05:600c:190e:b0:427:ff7a:79e with SMTP id 5b1f17b1804b1-429dd2393f0mr36254675e9.16.1723709755074;
        Thu, 15 Aug 2024 01:15:55 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1ca28sm11970905e9.44.2024.08.15.01.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:15:54 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, kvm@vger.kernel.org, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] arch/x86/kvm/vmx/vmx_onhyperv.h:109:36: error:
 dereference of NULL =?utf-8?B?4oCYMOKAmQ==?=
In-Reply-To: <Zr0rEy0bO1ju_f1C@google.com>
References: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
 <Zpq2Lqd5nFnA0VO-@google.com>
 <207a5c75-b6ad-4bfb-b436-07d4a3353003@gmail.com>
 <87a5i05nqj.fsf@redhat.com>
 <b20eded4-0663-49fb-ba88-5ff002a38a7f@gmail.com>
 <87plqbfq7o.fsf@redhat.com> <ZrzIVnkLqcbUKVDZ@google.com>
 <87mslff728.fsf@redhat.com> <Zr0rEy0bO1ju_f1C@google.com>
Date: Thu, 15 Aug 2024 10:15:53 +0200
Message-ID: <87h6bmfbgm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
>> >> What I meant is something along these lines (untested):
>> >> 
>> >> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
>> >> index eb48153bfd73..e2d8c67d0cad 100644
>> >> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
>> >> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
>> >> @@ -104,6 +104,14 @@ static inline void evmcs_load(u64 phys_addr)
>> >>         struct hv_vp_assist_page *vp_ap =
>> >>                 hv_get_vp_assist_page(smp_processor_id());
>> >>  
>> >> +       /*
>> >> +        * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
>> >> +        * and aborts enabling the feature otherwise. CPU onlining path is also checked in
>> >> +        * vmx_hardware_enable(). With this, it is impossible to reach here with vp_ap == NULL
>> >> +        * but compilers may still complain.
>> >> +        */
>> >> +       BUG_ON(!vp_ap);
>> >
>> > A full BUG_ON() is overkill, and easily avoided.  If we want to add a sanity
>> > check here and do more than just WARN, then it's easy enough to plumb in @vcpu
>> > and make this a KVM_BUG_ON() so that the VM dies, i.e. so that KVM doesn't risk
>> > corrupting the guest somehow.
>> >
>> 
>> I'm still acting under the impression this is an absolutely impossible
>> situation :-)
>> 
>> AFAICS, we only call evmcs_load() from vmcs_load() but this one doesn't
>> have @vcpu/@kvm either and I wasn't sure it's worth the effort to do the
>> plumbing (or am I missing an easy way to go back from @vmcs to
>> @vcpu?). On the other hand, vmcs_load() should not be called that ofter
>> so if we prefer to have @vcpu there for some other reason -- why not.
>
> kvm_get_running_vcpu(), though I honestly purposely didn't suggest it earlier
> because I am not a fan of using kvm_get_running_vcpu() unless it's absolutely
> necessary.  But for this situation, I'd be fine with using it.

Ah, nice, so we don't even need the plumbing then I guess? Compile-tested only:

diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
index eb48153bfd73..318f5f95f211 100644
--- a/arch/x86/kvm/vmx/vmx_onhyperv.h
+++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
@@ -104,6 +104,19 @@ static inline void evmcs_load(u64 phys_addr)
        struct hv_vp_assist_page *vp_ap =
                hv_get_vp_assist_page(smp_processor_id());
 
+       /*
+        * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
+        * and aborts enabling the feature otherwise. CPU onlining path is also checked in
+        * vmx_hardware_enable(). With this, it is impossible to reach here with vp_ap == NULL
+        * but compilers may still complain.
+        */
+       if (!vp_ap) {
+               struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+               KVM_BUG_ON(1, vcpu->kvm);
+               return;
+       }
+
        if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
                vp_ap->nested_control.features.directhypercall = 1;
        vp_ap->current_nested_vmcs = phys_addr;

(I hope we can't reach here with kvm_running_vcpu unset, can we?)

-- 
Vitaly


