Return-Path: <linux-kernel+bounces-418029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 849869D5C01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87CCB24DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F918BC29;
	Fri, 22 Nov 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwuFhz42"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE7165EE6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268043; cv=none; b=l/a0sCkKLpnf+5z0UFcfFWKx7VY2KjhJIGUxTqSpYQx6fskBk1IO6BxyaSu2PeVSWx1abRgDZF7MHhz928xFrquB24OY7LO7yZyH7ARfMdlmb6l9lIQQP3ehvW7soAsmUvBsWmVxbdDGT9ZfiiY7H0BNQEH/RAYW+c2XvReP9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268043; c=relaxed/simple;
	bh=/Ietlm2M38XkX0/kNUuz/YArcCY5PSsSsF6zo5gkfDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMgh1zyyVXPkF69CUalbHO1DJ3eFl+mM9mKWhnlHuefBBPMvA6a1epNXn2pGATUeVZ0OAn7hB+OWpuxFP5MzUn/g5INL9zikL4NKGAVWSe6rUribfA7hv0lBdBVsLiPngkalH0O0Q3I7cMUOU8m6+I4HlbHjOIys3iA8+ZYAlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwuFhz42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732268041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UhrnamlKMhk/hOtaEby7mW+uh6C+Y32a0RErHwVTWt8=;
	b=WwuFhz42VGVleYaIbHdpMpSOVT7bCPHSfNFxkYqi+wg1FzGLObwbu7r6P94q+GkZyOQ0v4
	UwB8/zNDuXBSxKRK2TIsNAe2WqPOOG/5i2m+8ide45jmCcP58hQZJPjjIVhsU4HVLSweG8
	qZfrt21e3S83RyoeTj2nbU7prs3SONk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-1jxpV107PuKwvaiYeygXNg-1; Fri, 22 Nov 2024 04:33:59 -0500
X-MC-Unique: 1jxpV107PuKwvaiYeygXNg-1
X-Mimecast-MFC-AGG-ID: 1jxpV107PuKwvaiYeygXNg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso99755266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268038; x=1732872838;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhrnamlKMhk/hOtaEby7mW+uh6C+Y32a0RErHwVTWt8=;
        b=faJjclNQXwVDCYrQD1XzPDEmnu0LnmNVEyjEN29eP2GCjhU9A38q6wUEkqtTAE8fZM
         TOn9Y4ZaPdRcnBvFknw2lGBB1zwHsfVt0sVDmlmR+wC84OEDpSn8GFnl1nugZy/EwtiS
         o5wl6XCPLGx+HPcVoCAGSc/RhwWzasa4+vcC8HLhRDLIMNrIIF4ce+afgz5xgNivOUFB
         t2lCNT5hD2XAiQJHIVl8zhBV+7ppiPMYb+Ar5xvlAMr34nIFzcbF9BomxXCq5EQy1NiO
         KlgRa0R/dDYGQRepudQTgbh9R03N3hrAEMJ4ctFTLDGnb3MSHWQfuTgXBvsmd9V1jUHX
         OteA==
X-Forwarded-Encrypted: i=1; AJvYcCU3kCxHJVgn9Ufu2ME+QFqXK0uA7sgNHh6H8hixTgFJPPVO/A87V5Tx6mNogA7DJe/ngN+8yPGmrJkqRXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdbLYFbklYbUKMMeGsVWReZpkR5PKDNaMOfseRU55cSwaRyQU
	NEVeTWp9BphI8u1c0z5LQ6NCcNTpCg4L/3XvFCFZxNRVw7RmqFb1L9AMnpeORC1eX7/llR5GPp1
	stiHGMvPfdPjbiJGQHFP/ZZV9iWCeNaW+0bmxcsFlGAbct6+6qstMYvQgkiN63g==
X-Gm-Gg: ASbGncvf5S7o12N0NgfFmLH4a2WpR2EF9gcw9WxA7nvLpqy+PgVBYY3kop7JD5oukKg
	VNSQgvhh7EcvrnAItqEOceVTVTcRKek2EmMXvR49n670k7p9gwSS7NejcRT7BXpYMqdS1K6HfSx
	tjM852eXmxdZdVQSlgthBzBlYBYCMeB6A+CxcosUdHIaqNJboFk/7gu6m+riiwru9HEDcl3anW5
	eqZCvO6+nEXnOjCjAZdo4oTAy6gIAKNKShZd/uSpWWk
X-Received: by 2002:a17:906:3096:b0:aa5:1d68:1f45 with SMTP id a640c23a62f3a-aa51d682049mr58566166b.10.1732268038179;
        Fri, 22 Nov 2024 01:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFYv7zR6qFmsckcecsvksi7MmCXzK7rX4iEUTBXVqGAocHOTO1fd8ZK0DR8K9GcVlM9+7Tpg==
X-Received: by 2002:a17:906:3096:b0:aa5:1d68:1f45 with SMTP id a640c23a62f3a-aa51d682049mr58563666b.10.1732268037704;
        Fri, 22 Nov 2024 01:33:57 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28fd61sm75159966b.5.2024.11.22.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:33:57 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kalyazin@amazon.com
Cc: pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 david@redhat.com, peterx@redhat.com, oleg@redhat.com, gshan@redhat.com,
 graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk,
 derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH] KVM: x86: async_pf: check earlier if can deliver async pf
In-Reply-To: <f8faa85e-24e6-4105-ab83-87b1b8c4bd56@amazon.com>
References: <20241118130403.23184-1-kalyazin@amazon.com>
 <87h684ctlg.fsf@redhat.com>
 <f8faa85e-24e6-4105-ab83-87b1b8c4bd56@amazon.com>
Date: Fri, 22 Nov 2024 10:33:55 +0100
Message-ID: <878qtbvcho.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikita Kalyazin <kalyazin@amazon.com> writes:

> On 18/11/2024 17:58, Vitaly Kuznetsov wrote:
>> Nikita Kalyazin <kalyazin@amazon.com> writes:
>> 
>>> On x86, async pagefault events can only be delivered if the page fault
>>> was triggered by guest userspace, not kernel.  This is because
>>> the guest may be in non-sleepable context and will not be able
>>> to reschedule.
>> 
>> We used to set KVM_ASYNC_PF_SEND_ALWAYS for Linux guests before
>> 
>> commit 3a7c8fafd1b42adea229fd204132f6a2fb3cd2d9
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date:   Fri Apr 24 09:57:56 2020 +0200
>> 
>>      x86/kvm: Restrict ASYNC_PF to user space
>> 
>> but KVM side of the feature is kind of still there, namely
>> 
>> kvm_pv_enable_async_pf() sets
>> 
>>      vcpu->arch.apf.send_user_only = !(data & KVM_ASYNC_PF_SEND_ALWAYS);
>> 
>> and then we check it in
>> 
>> kvm_can_deliver_async_pf():
>> 
>>       if (vcpu->arch.apf.send_user_only &&
>>           kvm_x86_call(get_cpl)(vcpu) == 0)
>>               return false;
>> 
>> and this can still be used by some legacy guests I suppose. How about
>> we start with removing this completely? It does not matter if some
>> legacy guest wants to get an APF for CPL0, we are never obliged to
>> actually use the mechanism.
>
> If I understand you correctly, the change you propose is rather 
> orthogonal to the original one as the check is performed after the work 
> has been already allocated (in kvm_setup_async_pf).  Would you expect 
> tangible savings from omitting the send_user_only check?
>

No, I don't expect any performance benefits. Basically, I was referring
to the description of your patch: "On x86, async pagefault events can
only be delivered if the page fault was triggered by guest userspace,
not kernel" and strictly speaking this is not true today as we still
support KVM_ASYNC_PF_SEND_ALWAYS in KVM. Yes, modern Linux guest don't
use it but the flag is there. Basically, my suggestion is to start with
a cleanup (untested):

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6d9f763a7bb9..d0906830a9fb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -974,7 +974,6 @@ struct kvm_vcpu_arch {
                u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
                u16 vec;
                u32 id;
-               bool send_user_only;
                u32 host_apf_flags;
                bool delivery_as_pf_vmexit;
                bool pageready_pending;
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index a1efa7907a0b..5558a1ec3dc9 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -87,7 +87,7 @@ struct kvm_clock_pairing {
 #define KVM_MAX_MMU_OP_BATCH           32
 
 #define KVM_ASYNC_PF_ENABLED                   (1 << 0)
-#define KVM_ASYNC_PF_SEND_ALWAYS               (1 << 1)
+#define KVM_ASYNC_PF_SEND_ALWAYS               (1 << 1) /* deprecated */
 #define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT     (1 << 2)
 #define KVM_ASYNC_PF_DELIVERY_AS_INT           (1 << 3)
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83fe0a78146f..cd15e738ca9b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3585,7 +3585,6 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
                                        sizeof(u64)))
                return 1;
 
-       vcpu->arch.apf.send_user_only = !(data & KVM_ASYNC_PF_SEND_ALWAYS);
        vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 
        kvm_async_pf_wakeup_all(vcpu);
@@ -13374,8 +13373,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
        if (!kvm_pv_async_pf_enabled(vcpu))
                return false;
 
-       if (vcpu->arch.apf.send_user_only &&
-           kvm_x86_call(get_cpl)(vcpu) == 0)
+       if (kvm_x86_call(get_cpl)(vcpu) == 0)
                return false;
 
        if (is_guest_mode(vcpu)) {

-- 
Vitaly


