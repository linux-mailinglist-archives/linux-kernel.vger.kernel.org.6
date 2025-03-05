Return-Path: <linux-kernel+bounces-546003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE95A4F50F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257217A3B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BB7DA93;
	Wed,  5 Mar 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2yQUPNY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E5746E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143837; cv=none; b=ZaFBPsmR6DOFnNiFgQ2lJs9iqs5wubhNUTUjiV0bItRD7ZYpGQ5JR0xuELlZU94NI3k2KMFkd+mPRoDZCAMUDnrAl7OWarBv5uC0QRYc5qScmGcKwX1XeQbrDeDoko4WSGFl3SXeZAw/cwCXslMXAGuK5F/w/y2QNTx3KLYBJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143837; c=relaxed/simple;
	bh=nn+0y2kYcsUE/C0FdPuZ6kFtGinNmIXAccAqcDhO/FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0CVkp9qOBacPYkjHYjOFAun18t0nSxM21zNHf25jdCHYoKoYPItCjxc44vTyVNOnz185HSusWVZbc1tq1M/kG/ExIYoyMHaBtFfrwolStcCrM8XlPV2HurDOJ6PpXtTlQ3x9Ab68HC4zTnhpj5YprCpMrnuOPQwYEO3E6/vwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2yQUPNY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741143834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGRi7Z3LudnEjtGohkS2VoNjpmTFQ+f/IeaFzIY/u9Y=;
	b=c2yQUPNYrsAUjgIxEKeSrAgs+zGx2ICqEmrvroKKAwtDp6NBbSiaFOP529wjwom58fluXV
	hqmj8qPv7QfRXlsUykP1cWbRuKkbGuQfcffIiYuW6uYWGhhGCLEfLKaNv2q4N3kJ+zJFF1
	CbScDJwExVUux6NsjbcOD/LOTLRU6vY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100--z6LyjdZMHybBxh1cxlgBg-1; Tue, 04 Mar 2025 22:03:53 -0500
X-MC-Unique: -z6LyjdZMHybBxh1cxlgBg-1
X-Mimecast-MFC-AGG-ID: -z6LyjdZMHybBxh1cxlgBg_1741143832
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8c2ace94cso90628186d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 19:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143832; x=1741748632;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGRi7Z3LudnEjtGohkS2VoNjpmTFQ+f/IeaFzIY/u9Y=;
        b=KZRJvh8RLGdyHaIA045/CxmOvMLEn9vb/SooMrjKSRNGMHIk5sl4ieBZqhPYQ3QPNU
         P90ejbBCMZvv41kGR+al2RJKPCHxvBbMTkBSmC6PDv8F3NKN1G9TGvJmFNe4o1iHPuIJ
         8MyMVeM8Vs89zzWhlllzKvkb1MbPD/mBVjxbc2N5Aq214x5eO3rnx2LWp6VenflCcv+g
         R1+lmuhhgNtEQ+ZO8iNMhYAMrWjn6iXUecjxA2FCKtopk5qHWWp0+rqDRraUy02I9kIG
         ooBFgwY8SxmU9Hvh41V4CJWDM0bVdi/2Novjx9UvfD/mVOUWMcRtjUcCOrtHa4eJJ3PF
         G+fA==
X-Forwarded-Encrypted: i=1; AJvYcCURtgInJ0PG1/ry6h7nuqKUgxsU21YzJffSV6+iy+4zral63n81pV4f72oQ22uiwvkBApqIrXbTKAt6XJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFloxQZJdXkEl5DMj6DCnkxjRThoYuFZq4sVzgSKTwC8dbS9as
	tBH7kIek3wRX9RbJcE6ySZZZfnfrq+A/EPsEqlNd/8Qno0SfX3NZAZJ5a3UKsyqIlsevR+rjZ4F
	NmOg8EvMyIE01m1jFu9nbmgX0SRP4oVF+1Hkdy8y/h0dH6sLTq0ReLIM+0vr1jQ==
X-Gm-Gg: ASbGncusxqP4EPukpswJ9AdqPCUqq02SxyCqbbuDj6iw/DOLFU0Q86+MAuFn8YypRsI
	yIHM/IJrsrzQv7Ms4JWbBb/5y0ETzWqXKP0kzkfD61aJRTiIdXilXB4zkXHXVbVx9EF+MUzyWQZ
	2FlEfCNLBI0qPZlTxBM3aVlWxGxL0bp0n+vvbgxDoP7pj43UGkqsWAjcFy1AfK1/i511ww97FVR
	haAcLPaYj/AIurWU9tFIpBRV2xu42sqwelNnz7je/pLTw6OI5xkOKwce8bDktogygw3wKBsM5KL
	tsG/ZxNsfC1hmWU=
X-Received: by 2002:a05:6214:e47:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e8e6cfd54cmr27116346d6.20.1741143832608;
        Tue, 04 Mar 2025 19:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbY725G3hV7UZl92cHpkhctuxiwjmRdm8JwvoGf1/DihEMV7V2E/2IiLMuI6rWwQ0Zrg6quA==
X-Received: by 2002:a05:6214:e47:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e8e6cfd54cmr27116096d6.20.1741143832269;
        Tue, 04 Mar 2025 19:03:52 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da230sm74065666d6.112.2025.03.04.19.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:03:51 -0800 (PST)
Message-ID: <d070c0c136bd05a68492e81077303603deefb9af.camel@redhat.com>
Subject: Re: [RFC PATCH 12/13] KVM: nSVM: Service local TLB flushes before
 nested transitions
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 22:03:51 -0500
In-Reply-To: <Z8Yq00wc_9_NRRkZ@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-13-yosry.ahmed@linux.dev>
	 <540397690642d3aa7e77775a721ba5a62bbdc2ae.camel@redhat.com>
	 <Z8Yq00wc_9_NRRkZ@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-03-03 at 22:18 +0000, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 09:20:18PM -0500, Maxim Levitsky wrote:
> > On Wed, 2025-02-05 at 18:24 +0000, Yosry Ahmed wrote:
> > > KVM does not track TLB flush requests for L1 vs. L2. Hence, service
> > > local flush that target the current context before switching to a new
> > > one. Since ASIDs are tracked per-VMCB, service the flushes before every
> > > VMCB switch.
> > > 
> > > This is conceptually similar to how nVMX calls
> > > kvm_service_local_tlb_flush_requests() in
> > > nested_vmx_enter_non_root_mode() and nested_vmx_vmexit(), with the
> > > following differences:
> > > 
> > > 1. nVMX tracks the current VPID based on is_guest_mode(), so local TLB
> > >    flushes are serviced before enter_guest_mode() and
> > >    leave_guest_mode(). On the other hand, nSVM tracks the current ASID
> > >    based on the current VMCB, so the TLB flushes are serviced before an
> > >    VMCB switch.
> > > 
> > > 2. nVMX only enters and leaves guest mode in
> > >    nested_vmx_enter_non_root_mode() and nested_vmx_vmexit(). Other paths
> > >    like vmx_set_nested_state() and vmx_leave_nested() call into these
> > >    two functions. On the other hand, nSVM open codes the switch in
> > >    functions like svm_set_nested_state() and svm_leave_nested(), so
> > >    servicing the flush in svm_switch_svm() is probably most reliable.
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > ---
> > >  arch/x86/kvm/svm/svm.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 5e7b1c9bfa605..6daa7efa9262b 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -1421,6 +1421,12 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > >  
> > >  void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
> > >  {
> > > +	/*
> > > +	 * ASIDs are tracked per-VMCB. Perform any pending TLB flushes for the
> > > +	 * current VMCB before switching to a new one.
> > > +	 */
> > > +	kvm_service_local_tlb_flush_requests(&svm->vcpu);
> > > +
> > >  	svm->current_vmcb = target_vmcb;
> > >  	svm->vmcb = target_vmcb->ptr;
> > >  }
> > 
> > Note that another difference between SVM and VMX is that this code will only set tlb_ctl
> > in the current vmcb, the actual flush can happen much later, when we do VM entry with this vmcb,
> > e.g if we are now in L2, the flush will happen when we enter L2 again.
> 
> Right, but I think the internal implementation of the TLB flushes is not
> relevant in this specific instance. Do you think it would be useful to
> mention that here?

I am not sure to be honest, I just mentioned this because in theory there can be a difference,
in regard to the fact that we might think that we flushed the TLB while in fact we haven't yet.

I am trying my best to think about what hidden problems might lurk around and surface later.

Not directly related to the above, but I am thinking:
I really like the way SVM flush works because it ensures that redundant flushes don't cost anything.

I wonder if we can make VMX code emulate this,
by having an emulated 'tlb_control' field and then doing the flush (INVEPT) on VM entry.


Best regards,
	Maxim Levitsky

> 
> If we were to document the difference in TLB flush handling between VMX
> and SVM I think a better place would be at kvm_vcpu_flush_tlb_*(), or
> maybe in kvm_host.h where the vendor callbacks are defined? Not sure.
> 
> > I think that this is correct but I might be mistaken.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Thanks!
> 



