Return-Path: <linux-kernel+bounces-245009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10D92ACF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C40C281371
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F1631;
	Tue,  9 Jul 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmqwU+ro"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BA4A02
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483813; cv=none; b=mqDD+83xpeH/mzWZ72hbGn204kDKq5ZQtiNm8uIYjQhE3x/i4ZAey6q2zKmChGBuF79AnzEWo1UTZp3fNCM3u5WvLAum/OS2HYt1uxp2dRSEVx+1d6KFUV0mrQTExNL0Y6F43b2Ph4K+3/P+ExgOBKcRLMyYNnu9UYafqaOv51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483813; c=relaxed/simple;
	bh=u1YhRWYwhZwdoRcIhg3U0o0satceY/8ehPA4ZGJZ+OA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5z+jeODXpIBZ3YO34uxivjuRyILF1Xvae5tVbmHsiyq9eclrkayGQxLUGO0sTp8ycvl3ahzKqtE6IvuWk55WIScdI8ZiLHjhC2AnPkKZIi4LbTEiRYPnfmP94RpIeMKKxrR4YE481bHWZogxsOkRHKEhdASExUXdT8XQV7hWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmqwU+ro; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af0dff5c5so2629235b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720483811; x=1721088611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpCSyQ48xZMBu3JWSxSWQAlxvGTkpYpPpBTugKDLStA=;
        b=xmqwU+rofJ/GbwxcDXffaGCAnTv6w69BEJlCjhnxgGUZGtX5hki+0ywNF1xNSo844c
         We82ZmOom3Hpk8wn8mfhU3lIcjEAwGT/gfpJ3jk+ZkmwhaZs7q5NPl+qIdE3dmw1jWgQ
         rZ6rTeEEHo75wd/jg5ONTCzHuEU/WSI3PxZJCyls1UBoOXKhb8xzr+dhzuc1dhPHng/e
         Ah727Al44w6eXY7yThs7o0HCYyaVCzkfirY8IEWegqctboD4jLgAlw8Jm6GKo1ICuJOc
         lD3EGwbmIoeW0KPnf1SGN4f2/7PubE2OdNPw5JgNzcNQyWFZGCww+QP7TxYT5nckbdU0
         Pdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483811; x=1721088611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpCSyQ48xZMBu3JWSxSWQAlxvGTkpYpPpBTugKDLStA=;
        b=SDtUfuXp4JC4PVVLk5CCmrXm2MpTDzHgr3sPjI9jp56OPIL5EoiyEbYKxp8T4hnxbd
         unPZVIGIGaboNfKhnA2XfJ8YOHdlumg4qVAXUJv0MC+wNFY+K76MxB0WAsLan+hK7D1J
         qDXtJXpqvxo2tYPzjNe33r8xWDa38alOYpkPWPmVQRyzT36aVeYVDTeZnKuYLsPG1+cW
         Xa7mgfOxKb/M/Z5EON3ZOY8t27Xtjz4eMK0yN752AFe3snvjhozjwsMZQArAoofMluxr
         0voFCira2cOApmMVJujxDouViinZUmTrrkgdkHgFbR5VqdHbhI7IeJ7cEh6pMbldewXn
         HZyw==
X-Forwarded-Encrypted: i=1; AJvYcCW1I6SGkoxd+nrS0txG1u0rQqu6CYOErdzS1TbvzoIEYIfy0MFWDhzLjV58KHXov001k3dI74zWizd2cLR7aLH+wyb8wI04JmKqkiee
X-Gm-Message-State: AOJu0YxlaDVWVGHvySWwNd2wYV51AkWXBGjLKrWjekXA8YEStD+1Ef5J
	keUDOGkQAUp024C4CAR9hjzF9s3agoJ9XNersXKw7l8rVQZ9yTCRZur/rrB3JUROpCGE1Rnt1/0
	Deg==
X-Google-Smtp-Source: AGHT+IE8Sc6LQTLRePG8g/rnbxnP4tA1RmQTE1krI+cbmi9biNwvhd17jHYMiXVZhIfvuCRmpmWcyv3nEb0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9f10:0:b0:704:3610:9354 with SMTP id
 d2e1a72fcca58-70b4367c139mr40520b3a.4.1720483810067; Mon, 08 Jul 2024
 17:10:10 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:10:08 -0700
In-Reply-To: <030c973172dcf3a24256ddc8ddc5e9ef57ecabcb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-41-seanjc@google.com>
 <030c973172dcf3a24256ddc8ddc5e9ef57ecabcb.camel@redhat.com>
Message-ID: <Zox_4OoDmGDHOaSA@google.com>
Subject: Re: [PATCH v2 40/49] KVM: x86: Initialize guest cpu_caps based on KVM support
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > @@ -421,6 +423,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  	 */
> >  	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
> >  		const struct cpuid_reg cpuid = reverse_cpuid[i];
> > +		struct kvm_cpuid_entry2 emulated;
> >  
> >  		if (!cpuid.function)
> >  			continue;
> > @@ -429,7 +432,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  		if (!entry)
> >  			continue;
> >  
> > -		vcpu->arch.cpu_caps[i] = cpuid_get_reg_unsafe(entry, cpuid.reg);
> > +		cpuid_func_emulated(&emulated, cpuid.function);
> > +
> > +		/*
> > +		 * A vCPU has a feature if it's supported by KVM and is enabled
> > +		 * in guest CPUID.  Note, this includes features that are
> > +		 * supported by KVM but aren't advertised to userspace!
> > +		 */
> > +		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] | kvm_vmm_cpu_caps[i] |
> > +					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
> > +		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
> 
> Hi,
> 
> I have an idea. What if we get rid of kvm_vmm_cpu_caps, and instead advertise the
> MWAIT in KVM_GET_EMULATED_CPUID?
> 
> MWAIT is sort of emulated as NOP after all, plus features in KVM_GET_EMULATED_CPUID are
> sort of 'emulated inefficiently' and you can say that NOP is an inefficient emulation
> of MWAIT sort of.

Heh, sort of indeed.  I really don't want to advertise MWAIT to userspace in any
capacity beyond KVM_CAP_X86_DISABLE_EXITS, because advertising MWAIT to VMs when
MONITOR/MWAIT exiting is enabled is actively harmful, to both host and guest.

KVM also doesn't emulate them on #UD, unlike MOVBE, which would make the API even
more confusing than it already is.

> It just feels to me that kvm_vmm_cpu_caps, is somewhat an overkill, and its name is
> somewhat confusing.

Yeah, I don't love it either, but trying to handle MWAIT as a one-off was even
uglier.  One option would be to piggyback cpuid_func_emulated(), but add a param
to have it fill MWAIT only for KVM's internal purposes.  That'd essentially be
the same as a one-off in kvm_vcpu_after_set_cpuid(), but less ugly.

I'd say it comes down to whether or not we expect to have more features that KVM
"supports", but doesn't advertise to userspace.  If we do, then I think adding
VMM_F() is the way to go.  If we expect MWAIT to be the only feature that gets
this treatment, then I'm ok if we bastardize cpuid_func_emulated().

And I think/hope that MWAIT will be a one-off.  Emulating it as a nop was a
mistake and has since been quirked, and I like to think we (eventually) learn
from our mistakes.

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0e64a6332052..dbc3f6ce9203 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -448,7 +448,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
                if (!entry)
                        continue;
 
-               cpuid_func_emulated(&emulated, cpuid.function);
+               cpuid_func_emulated(&emulated, cpuid.function, false);
 
                /*
                 * A vCPU has a feature if it's supported by KVM and is enabled
@@ -1034,7 +1034,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
        return entry;
 }
 
-static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func)
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
+                              bool only_advertised)
 {
        memset(entry, 0, sizeof(*entry));
 
@@ -1048,6 +1049,9 @@ static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func)
                return 1;
        case 1:
                entry->ecx = F(MOVBE);
+               /* comment goes here. */
+               if (!only_advertised)
+                       entry->ecx |= F(MWAIT);
                return 1;
        case 7:
                entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
@@ -1065,7 +1069,7 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
        if (array->nent >= array->maxnent)
                return -E2BIG;
 
-       array->nent += cpuid_func_emulated(&array->entries[array->nent], func);
+       array->nent += cpuid_func_emulated(&array->entries[array->nent], func, true);
        return 0;
 }

