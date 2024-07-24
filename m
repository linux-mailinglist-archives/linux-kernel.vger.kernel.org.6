Return-Path: <linux-kernel+bounces-261360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC493B65C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C6AB242BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2016A37C;
	Wed, 24 Jul 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBaX2S05"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE7158871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844008; cv=none; b=cCi8JAEs4mynbrULKhD0leXy1EOozHYCnZhP0lp5u9Xq3EsQayf+azk6TjQ/nlsxp+ZZH08K8Jj5/kN5eYNlleipoLS3GyWJ7/TF955+hKXzswc0R8f0C8M4/yrKvCuRumC8MHsjiMJdM5y6uxX3cSvNVRbUDJatolCn3OsZkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844008; c=relaxed/simple;
	bh=wi4PVMj/RylII+kfp9JvNJ0g3isAzxZ36/+o7Gw4c2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOAj6ldbZJgqK/gEFycb5CIIfRFoBcMMZI+zbbZgnpagNLK1t6fpD5FKHDd3yOq7Bgftp8FsepDVPG+q4A6vA4PVYNjrSDISi/pwVxJLKeiNbgBIP53BO9KmOK3hAsPkWh4Y9W34Ya0ipxrUTr+fanS9AiR2V9hMV8cGC2RwL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBaX2S05; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721844004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUhs1zi8/K2uHCURlex7Z0IBPujaiiqC2g0oUiZ4EtY=;
	b=LBaX2S050/6zYA/nH//rukZYczI5fsDnXfbKnsocKugb5jJQSCeU8S4NEAiHhHZWVPWBgl
	Vh/hQm8m3egw+OtHnl1y/Ho4qRlnSXiysHO2uz/1ApPbSptqggMUup3gNYqojruotHZzTZ
	Ubdxxoq1gMhtrqjRFuOv3GS5G4oWqvE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-2n0iFUWoMbCaU1uPY3eZVg-1; Wed, 24 Jul 2024 14:00:03 -0400
X-MC-Unique: 2n0iFUWoMbCaU1uPY3eZVg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7a2b9ae51so812286d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844003; x=1722448803;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUhs1zi8/K2uHCURlex7Z0IBPujaiiqC2g0oUiZ4EtY=;
        b=jRUPtyxtD6mTh3FWaNYJobk1IDtT3MZiwSq5ARmEkBoj6Cxw547cmpjuN9rGxOuCrl
         WU9Fdkhz+btgltHmzCatB1NJQV5d+2fM3AucVbZQlNMakhOJabdi+ei+Z1MjkSXpEZSM
         DON3adExSvWb6SMspKofEm68Sjm37YXbQpYxMu/yv4HNa/uCojD4yA6CiUTh47+MpJI/
         dUe4iuCDgNqgLRCKfwuLr1RGdlKz48KOANFXAhWYtkmEIIfUWGx1c1R9RVyhy54uwxKr
         9ydh4ia5moRGowFuGNgToMPJuHp6DX5pcooNVx4/EAv7zsACUT8XrGnFo4YMyIJLK/tg
         aL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdFqoCqLs1NGI8BKLkKw7Wt3oS/4A9Fw1h8mfBN0FCMWQl1inyw0BpQ0mwJFmyBFRqSwPTS6IrgEMIyJc5yEeQltT0bLycjz4b7pWn
X-Gm-Message-State: AOJu0YwOxMOk/FBd9opv2M0HMckdUZuO/V6O7WgabYiPQ7tDS+GDGII4
	OgB1uXMSAZ0ppDxKvRyOU75v4zeGFByrRC8ZjDhnvrkPRXj1W8DQC66/KMj0GNsPrFjPd2M59BT
	0VzoO1njw5+JvcYcDj2L08S9nCbir0Ho1LcPh6m5wKKJgl+fzE7oukARJnkmYdw==
X-Received: by 2002:ad4:5f4e:0:b0:6b0:7f0c:d30e with SMTP id 6a1803df08f44-6bb3c9cf607mr5057186d6.10.1721844002963;
        Wed, 24 Jul 2024 11:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV5ZeOzeO98y/PIGai+ELZySp2k2TXNjwAGQ61vgRr5QwqvMpKKDJO87IqdHpG0qrm2UACvQ==
X-Received: by 2002:ad4:5f4e:0:b0:6b0:7f0c:d30e with SMTP id 6a1803df08f44-6bb3c9cf607mr5056596d6.10.1721844002640;
        Wed, 24 Jul 2024 11:00:02 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7dc47esm60141676d6.43.2024.07.24.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:00:02 -0700 (PDT)
Message-ID: <f6e5e836b356c4f852e9191d4eea283ff9534b09.camel@redhat.com>
Subject: Re: [PATCH v2 33/49] KVM: x86: Advertise TSC_DEADLINE_TIMER in
 KVM_GET_SUPPORTED_CPUID
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 14:00:01 -0400
In-Reply-To: <Zo2PRdv1KMf_Mgwj@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-34-seanjc@google.com>
	 <924352564a5ab003b85bf7e2ee422907f9951e26.camel@redhat.com>
	 <Zo2PRdv1KMf_Mgwj@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-09 at 12:28 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > >  4.47 KVM_PPC_GET_PVINFO
> > >  -----------------------
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index 699ce4261e9c..d1f427284ccc 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -680,8 +680,8 @@ void kvm_set_cpu_caps(void)
> > >  		F(FMA) | F(CX16) | 0 /* xTPR Update */ | F(PDCM) |
> > >  		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
> > >  		F(XMM4_2) | EMUL_F(X2APIC) | F(MOVBE) | F(POPCNT) |
> > > -		0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
> > > -		F(F16C) | F(RDRAND)
> > > +		EMUL_F(TSC_DEADLINE_TIMER) | F(AES) | F(XSAVE) |
> > > +		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND)
> > >  	);
> > >  
> > >  	kvm_cpu_cap_init(CPUID_1_EDX,
> > 
> > Hi,
> > 
> > I have a mixed feeling about this.
> > 
> > First of all KVM_GET_SUPPORTED_CPUID documentation explicitly states that it
> > returns bits that are supported in *default* configuration TSC_DEADLINE_TIMER
> > and arguably X2APIC are only supported after enabling various caps, e.g not
> > default configuration.
> 
> Another side topic, in the near future, I think we should push to make an in-kernel
> local APIC a hard requirement. 

I vote yes, with my both hands for this, but I am sure that this will for sure break at least some
userspace and/or some misconfigured qemu instances.

>  AFAIK, userspace local APIC gets no meaningful
> test coverage, and IIRC we have known bugs where a userspace APIC doesn't work
> as it should, e.g. commit 6550c4df7e50 ("KVM: nVMX: Fix interrupt window request
> with "Acknowledge interrupt on exit"").
> 
> > However, since X2APIC also in KVM_GET_SUPPORTED_CPUID (also wrongly IMHO),
> > for consistency it does make sense to add TSC_DEADLINE_TIMER as well.
> > 
> > I do think that we need at least to update the documentation of KVM_GET_SUPPORTED_CPUID
> > and KVM_GET_EMULATED_CPUID, as I state in a review of a later patch.
> 
> +1
> 


Best regards,
	Maxim Levitsky


