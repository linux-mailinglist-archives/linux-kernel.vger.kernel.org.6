Return-Path: <linux-kernel+bounces-261327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CB93B5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257C71F21F10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531615F40B;
	Wed, 24 Jul 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCTFGBzN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5718E10
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841860; cv=none; b=ACPVE/uJi1QELWJ6itz08tUkd9+S6jEE6ptz4QxYScpYAT/sTBilopCl7M8OeJuzUbPIRPxm5867FuC6UBUIe6ZZucaZ+tHPAgX1Tx/5yJhSMvXCiBOuDi/al3u08RCGzZ2uiNgh41MnR/Y92h9TupFGLJfEyincb29fCZjPoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841860; c=relaxed/simple;
	bh=vM51azXaHDNwpKJTMUM1O0vnkWBr8NPpt7jwhv8sLVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slM0l8iZaswiRiJduTa8w0Qmvos+H7DaTgjZAIiwO/r6dmDR+ALlK5ZRbY5dM01x496kUCAJ4lqwtaDWOv9u/vC6s2qAX+k7+XiCDiidfZSRZGEphdtoA4qf5TQm0Qw/YJ/pFJ452qA8OyR9yiDKV0ukzJ6LfOw7xBRUrj4tFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCTFGBzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721841857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1XBGctsXc7Ftv4Y/G9exRnBNRs5AQn3Z5s5GLDiSgQ=;
	b=cCTFGBzNKrfzyxYSo00PUbXILK2SAIRpsoBdtabqbrilsbQySUMXLKXq4f62qAut7hdYJn
	x4AvHW17/0DbovaThxlOlWKhAhMNroSuuLQO88G4mV4RT4xf229+x5bP1LQOAAHfmlaB4r
	/fjpi35flZW/RkqCjw6teRNDpyY2Wc4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-wXh4HStlPNGZQWl4ZNh7yg-1; Wed, 24 Jul 2024 13:24:16 -0400
X-MC-Unique: wXh4HStlPNGZQWl4ZNh7yg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b796b30abfso526376d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841855; x=1722446655;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1XBGctsXc7Ftv4Y/G9exRnBNRs5AQn3Z5s5GLDiSgQ=;
        b=u1Dxvm2tqAUS3/edSOxK6I8VpDIuUbfN/oBV6DGXZc+O71AtrQE7RISXKHkM8i7E75
         1gcX69BnfkUuE0nLbv2CED1Hlv28/TLCiIqjPNB/WyXF5z0jyTIzIorgYOAQ8faNw7Wk
         yf7W49chbfVZBrL6K0lLCaBQrjCSJym1jVCbzhQrrV8SPobcQkgRBd0PVHriSHidZy1y
         hmRBHv9ta3KAsuFTvLalChWoZQTWGsQbQkw34v3sAaql28PZFbsyNGISlZBAdMhvv6Zr
         f8TMnr/E3jNYd8zq9NxXW8lyUaAZOCaBaRoZ/n0MBpTqJydNWqePwPATSxxso0LnTJQq
         uANg==
X-Forwarded-Encrypted: i=1; AJvYcCVncvz83LR+fRSraQSTHQhAkQcL1739X0CZwem0i4BJHDeWn5W9qNBWdamiLJt+JXCIlrhpGOuGIiJpzSNe5XcpjppNdfpFqbz3Ok09
X-Gm-Message-State: AOJu0Yyzi2hyU/aIIiRtSU6NhDNwD/xs6QFDU9h2W4u9v9fwwlfCY43g
	/zrRcZpoJtWXSwjLD7DG1+5xApqd53XU4iP8a4UwI7EgEW9u7UNUY782ihGWkulcZTp6yxPWKfE
	5eskY2aXGYlYlc0NNLIrz5ropzMGkGFKiOFx1tM52piwELYBErHaXD0XaPt5FAw==
X-Received: by 2002:ad4:5961:0:b0:6b5:6a1:f89a with SMTP id 6a1803df08f44-6bb3c9ceafbmr3178926d6.2.1721841855498;
        Wed, 24 Jul 2024 10:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGmXNXlTT92t8xldGPMNOVL+0ETtI9lzy9JixqquimWa65CpXWnNSbeLyLRLbNjgjutsUsVg==
X-Received: by 2002:ad4:5961:0:b0:6b5:6a1:f89a with SMTP id 6a1803df08f44-6bb3c9ceafbmr3178616d6.2.1721841855162;
        Wed, 24 Jul 2024 10:24:15 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7e5fdcsm60471456d6.50.2024.07.24.10.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:24:14 -0700 (PDT)
Message-ID: <cf24c99cfdefda7c700a6d09e86e0bdc3e562c8d.camel@redhat.com>
Subject: Re: [PATCH v2 01/49] KVM: x86: Do all post-set CPUID processing
 during vCPU creation
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:24:13 -0400
In-Reply-To: <Zow0DVn4CvIxzGYz@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-2-seanjc@google.com>
	 <62cbd606f6d636445fd1352ae196a0973c362170.camel@redhat.com>
	 <Zow0DVn4CvIxzGYz@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 11:46 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > > index 23dbb9eb277c..0a8b561b5434 100644
> > > --- a/arch/x86/kvm/cpuid.h
> > > +++ b/arch/x86/kvm/cpuid.h
> > > @@ -11,6 +11,7 @@
> > >  extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
> > >  void kvm_set_cpu_caps(void);
> > >  
> > > +void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
> > >  void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu);
> > >  void kvm_update_pv_runtime(struct kvm_vcpu *vcpu);
> > >  struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index d750546ec934..7adcf56bd45d 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -12234,6 +12234,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> > >  	kvm_xen_init_vcpu(vcpu);
> > >  	kvm_vcpu_mtrr_init(vcpu);
> > >  	vcpu_load(vcpu);
> > > +	kvm_vcpu_after_set_cpuid(vcpu);
> > 
> > This makes me a bit nervous. At this point the vcpu->arch.cpuid_entries is
> > NULL, but so is vcpu->arch.cpuid_nent so it sort of works but is one mistake
> > away from crash.
> > 
> > Maybe we should add some protection to this, e.g empty zero cpuid or
> > something like that.
> 
> Hmm, a crash is actually a good thing.  In the post-KVM_SET_CPUID2 case, if KVM
> accessed vcpu->arch.cpuid_entries without properly consulting cpuid_nent, the
> resulting failure would be a out-of-bounds read.  Similarly, a zeroed CPUID array
> would effectiely mask any bugs.
> 
> Given that KVM heavily relies on "vcpu" to be zero-allocated, and that changing
> cpuid_nent during kvm_arch_vcpu_create() would be an extremely egregious bug,
> a crash due to a NULL-pointer dereference should never escape developer testing,
> let alone full release testing.
> 
> KVM does the "empty" array thing for IRQ routing (though in that case the array
> and the nr_entries are in a single struct), and IMO it's been a huge net negative
> because it's led to increased complexity just so that arch code can omit a NULL
> check.
> 

Makes sense, let it be.

Best regards,
	Maxim Levitsky


