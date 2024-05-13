Return-Path: <linux-kernel+bounces-177816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16638C44F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B121281FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145015533F;
	Mon, 13 May 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4PTOStX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155814F9F7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617069; cv=none; b=kL9p1Gh+6QbFa4Zb598tcm21Bwp07OIod91huaGbNjmB/Xygpg81FgRhDa0chEMeCmqkrqP7exP2rQm9NF1xLgfJVskxeOGOmAGYOGfLP1h4+dAMFKX8DhW741j/qbaRTCxPzK2gd/JqCaBO3onlupCK0XNV7ZOlUQkWQQobeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617069; c=relaxed/simple;
	bh=wMrmx8TErJhl+bR6e/Ke/YXbXF9pjOpqNtYB7UPdxyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYP8A5SBwt5oNC4KXAoLajW4rTAlW9jnnNu3em3VdkM26k1ROGZ+pFtjIGX1/msNVDQYmF2mihUB5uWI4mNjnAejMpdnfS88icp7Q47KexRKGpKwJGXpQ+mA45G8uf1J4SbeojCJg71uu3MzRkhcaZ4X/Tm1+PHYGdB+VF/a/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4PTOStX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62079696c58so80217757b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715617067; x=1716221867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rItCtWj2XHXpZCLir9e6El9qiZq8WC4GDD0p8rFS9uo=;
        b=l4PTOStXySOd0UzVgvfNQJzDBszby9cv1l0/oJr0zEvRPHXmdJLkqfGbjJn5MqrA7m
         sxZQRpqaG/DnNKmMrXsivtyHTA3VlFFQgZocp78u2BqgoLfSIiSS03ycWDwVD6nhnx9S
         po97XjFRTAubkFkugU4n9vYHVzgsZ4GJP/yFTbI9PMlujCSky389TWT5krSxxKAR4Ctm
         DQw/PS1Ch0Ls5+CJDC+kpWE7qOfSQtzHOjmBXm4exduYtDq851w6LjXS4GWYvV+/eCle
         Omf3rziHdYbvzJJuMkuDm2ueCRw0oRex5ojCCXcJsGD4YkGpy2MVmEVB+6FwmEGva9D9
         JHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617067; x=1716221867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rItCtWj2XHXpZCLir9e6El9qiZq8WC4GDD0p8rFS9uo=;
        b=DtbwZz62Y4gwxPrF3XxWodngD63ZlGCfDwsRF18wq5aAhZDD8Ij793YIrZysXDzzr5
         3yhLfEz6hTQopugV3XZq28KtY99vDfYJcecucj9UpnFDeVwSEhlULz0xv8EsaBOANA3T
         v8hC8HcjsnFLyo8k6BUi049b2axqLQ1QJwOfJWENylx44XCd9IpDIpi59KXWjeNwaby9
         x1S/Sm+gGyefSJ+bWjnldAiHxZgqv3D4DFSVZlCC1rri2E4AIaQA+Gp95tLTfRtXYweg
         cS6deWC2G1sXqEfTQM7UxkUHpYcSbghXOMMw/IX2BX+ZXqHZMtDNtIAR0Ymiy32Aqkf2
         rZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJDVIADN3E5CWSH+7jhcqlBzLc8H0biiObYU8+bDhzQUX9CmSHt2804tWkLDD8qwTs54bkFLo/UYeQyRJNvtcG70Ap/s+bU1mKSvcn
X-Gm-Message-State: AOJu0YxxMvoG3ZRJyyZ8vQ+3gKThK83qU/0TTpCkj3bCwhz8XnNxRNj+
	jYFSuuO+1+1FhFPB5+vra+KgWCMg/L7e8BMcc+Pd2xqJmq62fiyprRJPF1eLhq/YLoG/WjpO3xG
	Nbw==
X-Google-Smtp-Source: AGHT+IGIVSvfYePEn31Jb5gBhaa8P/rfVIwSisstyCzgSXRTit9FXnRNBffs/JdtpoEozNvIZDAjwzX4m4g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3801:b0:61b:ec81:3f3b with SMTP id
 00721157ae682-622b0038dfbmr27061897b3.5.1715617067105; Mon, 13 May 2024
 09:17:47 -0700 (PDT)
Date: Mon, 13 May 2024 09:17:45 -0700
In-Reply-To: <cb59d42e0ce59c6e6f3e9af019654687b04c4f5d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-3-seanjc@google.com>
 <ZitrMAplXSCKrypD@chao-email> <ZivfqQysu2hXHHFG@google.com> <cb59d42e0ce59c6e6f3e9af019654687b04c4f5d.camel@intel.com>
Message-ID: <ZkI9KcIYujLadSLA@google.com>
Subject: Re: [PATCH 2/4] KVM: x86: Register emergency virt callback in common
 code, via kvm_x86_ops
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 13, 2024, Kai Huang wrote:
> On Fri, 2024-04-26 at 10:08 -0700, Sean Christopherson wrote:
> > On Fri, Apr 26, 2024, Chao Gao wrote:
> > > > diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> > > > index 502704596c83..afddfe3747dd 100644
> > > > --- a/arch/x86/kvm/vmx/x86_ops.h
> > > > +++ b/arch/x86/kvm/vmx/x86_ops.h
> > > > @@ -15,6 +15,7 @@ void vmx_hardware_unsetup(void);
> > > > int vmx_check_processor_compat(void);
> > > > int vmx_hardware_enable(void);
> > > > void vmx_hardware_disable(void);
> > > > +void vmx_emergency_disable(void);
> > > > int vmx_vm_init(struct kvm *kvm);
> > > > void vmx_vm_destroy(struct kvm *kvm);
> > > > int vmx_vcpu_precreate(struct kvm *kvm);
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index e9ef1fa4b90b..12e88aa2cca2 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -9797,6 +9797,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
> > > > 
> > > > 	kvm_ops_update(ops);
> > > > 
> > > > +	cpu_emergency_register_virt_callback(kvm_x86_ops.emergency_disable);
> > > > +
> > > 
> > > vmx_emergency_disable() accesses loaded_vmcss_on_cpu but now it may be called
> > > before loaded_vmcss_on_cpu is initialized. This may be not a problem for now
> > > given the check for X86_CR4_VMXE  in vmx_emergency_disable(). But relying on
> > > that check is fragile. I think it is better to apply the patch below from Isaku
> > > before this patch.
> > > 
> > > https://lore.kernel.org/kvm/c1b7f0e5c2476f9f565acda5c1e746b8d181499b.1708933498.git.isaku.yamahata@intel.com/
> > 
> > Agreed, good eyeballs, and thanks for the reviews!
> > 
> 
> I think we can even move registering this emergency disable to
> hardware_enable_all()?  It seems there's no reason to register the
> callback if hardware_enable_all() hasn't been attempted.

Hmm, we could.  I don't know that it'd be worth doing though.  I suppose one
could argue that it would allow out-of-tree hypervisors to more easily co-exist
with KVM, but I haven't heard/seen anyone crying for that.  And it would be nice
to have all of this code in one location.  

I think we'd need more explicit synchronization if the callback is registered
on-demand, but that should be a relatively minor, if it's even needed.

So yeah, I'll give this a shot and go this route for v2 if it works out.

