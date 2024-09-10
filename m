Return-Path: <linux-kernel+bounces-322267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C49697267C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F2B228BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59652770FE;
	Tue, 10 Sep 2024 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4GEghjC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA66F2F4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930467; cv=none; b=IuJDBEJb6Pai09Q8Bq5XN8QM0p7D1Gtl5YGDOsEuyUB3C7KscT84Fx+H9hePD6WVNcwGO9P5MlMDznrj3Fxg1j37p/Qx7WnzsLIApElEJ7+p6aWGsRqDCfTbhKNeEEVQjjcUbg36slFuTjSXSA6OHYDKWZFRA/3BB5Is9CAb9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930467; c=relaxed/simple;
	bh=ATHsS1AmT3JG3F7YpaxSATtnFZdtl+P+auqorHApaBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjylwP7TxHL8hYJNk4g7If2KrzxaT/FeVwpUmCaQ6t6hf09kNiRLc5ccmwPvRsn23h4YnOZRfg1Zm8lHxaHH1lPL+Lu7QVy8xSLfT5Y9bOer2Dez4OnS3it4CqseYD6k1alrksiZjGDWvhLVdi+Anmo2HB9RrNRf5xPwlAIIVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4GEghjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725930464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1Tybp6E4T4YrtJAbYUVLevBkFVS1yDP1bl67K5nnks=;
	b=A4GEghjCoqMlPQ0IIpTpaBrzUQPclGgu2t9L76wrxqinNLLT6mXAJixfGa4VqSczWF4OLd
	4XhzzT6RNi9WOHV7eqhQ9E7skeWCeWRKQqu+nnJLUMxRO65LKUsT7aq03nhvgpVXn9HkfL
	mM6VWwZdVAP165lR9GLt0+0vOmrht5M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Q1MRFAjhMOaNaxTgtNgn6Q-1; Mon, 09 Sep 2024 21:07:42 -0400
X-MC-Unique: Q1MRFAjhMOaNaxTgtNgn6Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c3554020afso74777816d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 18:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725930462; x=1726535262;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1Tybp6E4T4YrtJAbYUVLevBkFVS1yDP1bl67K5nnks=;
        b=MNbMrkxfRTlrPUIk2MDGeM/DBDmgI8FHIk+G2ijwZuxGaMcJHlgP4opTuQjTmeY3sw
         H7EK04QNGOsWxS+JU6T7hEJzuR6Ts9H58fMmmANL2BpuKbJzerrvhRuUvCgZO90XzqkZ
         Xwf4PdTK9EWmdosVLxl2p0uQ1mEeC+s5GX/q5Uj9uPUSu+iKE2Pt9hAfxTO6EDPeZhuP
         wMI3JHlCwtVG5+gyg62Thhtq1gwr6seZppZj5LmdRtFIY2UIcpHD2u9EdMYPBpCwfjKg
         Um4FsMSNb46efECMdUSP5yCCkbI+7yaJ56rWUno3yYulTIhpzAkX6nZUsBO6+Np8UN2C
         HtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGFAZdMLUVwoG0gV9kU5DTnIbBXTdZoTAnKUAsoSD4qKZnwYaGLtstJEtbLd3mlSjC+KPto/kd4FiCaTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBmJKyMJy12H+cvUiAy5gNHkKZ5uP/xFiEJWTnPx2dRQv8bPf
	a84V/lAoZ81JAqcgXn+uNp+245gNR5/vldExXFHB2pUEdp2AX2IiIJGWxSLtQdZhBttXWw6agNU
	+LeQOXhlkqvthvu+G0bjZ805lk1ErI0pcofiTbIdEHecrUE4uBSUiNoAcaIFvwkaJHFJLUH5n
X-Received: by 2002:a05:6214:3f90:b0:6c5:1616:b5c5 with SMTP id 6a1803df08f44-6c532ad6e5amr117463506d6.15.1725930462105;
        Mon, 09 Sep 2024 18:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1iFOB9OlXSHTVdnaaPPLfkmO7lh6TSHwWW9yPfAV+5I6XTNWVIUUSS2xEO1Zny6HH9/PWvQ==
X-Received: by 2002:a05:6214:3f90:b0:6c5:1616:b5c5 with SMTP id 6a1803df08f44-6c532ad6e5amr117463226d6.15.1725930461611;
        Mon, 09 Sep 2024 18:07:41 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d890sm25672526d6.94.2024.09.09.18.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:07:41 -0700 (PDT)
Message-ID: <65fe418f079a1f9f59caa170ec0ae5d828486714.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] VMX: reset the segment cache after segment
 initialization in vmx_vcpu_reset
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 x86@kernel.org
Date: Mon, 09 Sep 2024 21:07:40 -0400
In-Reply-To: <61e7e64c615aba6297006dbf32e48986d33c12ab.camel@redhat.com>
References: <20240725175232.337266-1-mlevitsk@redhat.com>
	 <20240725175232.337266-3-mlevitsk@redhat.com> <ZrF55uIvX2rcHtSW@chao-email>
	 <ZrY1adEnEW2N-ijd@google.com>
	 <61e7e64c615aba6297006dbf32e48986d33c12ab.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-09-09 at 15:11 -0400, Maxim Levitsky wrote:
> On Fri, 2024-08-09 at 08:27 -0700, Sean Christopherson wrote:
> > On Tue, Aug 06, 2024, Chao Gao wrote:
> > > On Thu, Jul 25, 2024 at 01:52:32PM -0400, Maxim Levitsky wrote:
> > > > Fix this by moving the vmx_segment_cache_clear() call to be after the
> > > > segments are initialized.
> > > > 
> > > > Note that this still doesn't fix the issue of kvm_arch_vcpu_in_kernel
> > > > getting stale data during the segment setup, and that issue will
> > > > be addressed later.
> > > > 
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > 
> > > Do you need a Fixes tag and/or Cc: stable?
> > 
> > Heh, it's an old one
> > 
> >   Fixes: 2fb92db1ec08 ("KVM: VMX: Cache vmcs segment fields")
> > 
> > > > ---
> > > > arch/x86/kvm/vmx/vmx.c | 6 +++---
> > > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > > index fa9f307d9b18..d43bb755e15c 100644
> > > > --- a/arch/x86/kvm/vmx/vmx.c
> > > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > > @@ -4870,9 +4870,6 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > > > 	vmx->hv_deadline_tsc = -1;
> > > > 	kvm_set_cr8(vcpu, 0);
> > > > 
> > > > -	vmx_segment_cache_clear(vmx);
> > > > -	kvm_register_mark_available(vcpu, VCPU_EXREG_SEGMENTS);
> > > > -
> > > > 	seg_setup(VCPU_SREG_CS);
> > > > 	vmcs_write16(GUEST_CS_SELECTOR, 0xf000);
> > > > 	vmcs_writel(GUEST_CS_BASE, 0xffff0000ul);
> > > > @@ -4899,6 +4896,9 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > > > 	vmcs_writel(GUEST_IDTR_BASE, 0);
> > > > 	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
> > > > 
> > > > +	vmx_segment_cache_clear(vmx);
> > > > +	kvm_register_mark_available(vcpu, VCPU_EXREG_SEGMENTS);
> > > 
> > > vmx_segment_cache_clear() is called in a few other sites. I think at least the
> > > call in __vmx_set_segment() should be fixed, because QEMU may read SS.AR right
> > > after a write to it. if the write was preempted after the cache was cleared but
> > > before the new value being written into VMCS, QEMU would find that SS.AR held a
> > > stale value.
> > 
> > Ya, I thought the plan was to go for a more complete fix[*]?  This change isn't
> > wrong, but it's obviously incomplete, and will be unnecessary if the preemption
> > issue is resolved.
> 
> Hi,
> 
> I was thinking to keep it simple, since the issue is mostly theoretical after this fix,
> but I'll give this another try.
> 
> Best regards,
> 	Maxim Levitsky
> 
> > [*] https://lore.kernel.org/all/f183d215c903d4d1e85bf89e9d8b57dd6ce5c175.camel@redhat.com
> > 

Hi,

This is what I am thinking, after going over this issue again:

Pre-populating the cache and/or adding 'exited_in_kernel' will waste vmreads on *each* vmexit, 
I worry that this is just not worth the mostly theoretical issue that we have.


Since the segment and the register cache only optimize the case of reading a same field twice or more,
I suspect that reading these fields always is worse performance wise than removing the segment cache
altogether and reading these fields again and again.


Finally all 3 places that read the segment cache, only access one piece of data (SS.AR or RIP), 
thus it doesn't really matter if they see an old or a new value. 

I mean in theory if userspace changes the SS's AR bytes out of the
blue, and then we get a preemption event, in theory as you say the old value is correct but it really
doesn't matter.

So IMHO, just ensuring that we invalidate the segment cache right after we do any changes is the simplest
solution.

I can in addition to that add a warning to kvm_register_is_available and vmx_segment_cache_test_set, that
will test that only SS.AR and RIP are read from the interrupt context, so that if in the future someone
attempts to read more fields, this issue can be re-evaluated.

Best regards,
	Maxim Levitsky


