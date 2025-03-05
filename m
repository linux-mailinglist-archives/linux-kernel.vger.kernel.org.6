Return-Path: <linux-kernel+bounces-545991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A553FA4F4EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4973A9AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3271553BC;
	Wed,  5 Mar 2025 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmqDZ3IU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080421624F1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143138; cv=none; b=rX3VXxb8PB6kXufhRFvrmmljcstjUZPXefY4HR4u3RZIybRVwEkXVdUgUT/rbDqj2XtLNmIkuT/6xA3PrOK7MyhJ/cbTQqMlJgDOyewqS5PolW8ooS3DKSDE58s4skDdTGXOMT8veQU3Xq00JFzW53Fxq1ai2gTjiSL/oWlqLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143138; c=relaxed/simple;
	bh=z8PMHSd9seF3AUVlpPcwhetZy5doRJadMfFSLi+nKt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhVAUCLONec5hcbNnwwGUtlHT+kg4q3exOZwgsB4QYtOCVMPDj54LkiAij0BPhZ49dPcg3/QkbfjseoVNpTeNHMNxWU8LFV75rrpPMj2Tm4qxM2h7cOdoJGzIwitt7Jk7jV7RNqIRY+5teMwde5n4Hu4Rkj8XYxdYiec1h4wZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmqDZ3IU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741143134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjKaEiYnY5H1cwKZK+Yz/RA9HClbXYNadwatn6L8wbk=;
	b=SmqDZ3IUiSxlBD4r2kwRv+XIN4/A+9q6XuRbjEcZXYTICPCs/9Mj8o5+UgSt2T1FrCvc6H
	vtbUKQu/0xGRgLfqyKFWpF+vb1689NIIrAry/mEcJP8gtivAJ4lIqwYFLuNNu8qp6BtY4x
	5IhMffme87UhwkorE+eTBFlRpLFZX/E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-lFzbpsb0PzG0IRwWAVtFaQ-1; Tue, 04 Mar 2025 21:52:06 -0500
X-MC-Unique: lFzbpsb0PzG0IRwWAVtFaQ-1
X-Mimecast-MFC-AGG-ID: lFzbpsb0PzG0IRwWAVtFaQ_1741143125
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-474e712ef4cso49620171cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143125; x=1741747925;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjKaEiYnY5H1cwKZK+Yz/RA9HClbXYNadwatn6L8wbk=;
        b=Rxm7X+zIXzd2Mv5qxEzcy+61gfcMVgqK7hSKtYmZ9eCVwkvImO+8VwmS3dhNKSy7G+
         rL58FQy/F2XQWbvXTrTXtLQSCSLBu6TYuB1pf290adI89YBInBP9GSxaNTQiamfkRLF0
         mXODHGpuaouEFPMSqfCeliFW85aYXRptNkmsBQ/rwqC/fSJJYzkG+cx0JrD6Djg1rVdl
         XOEuDRX7wJpq+KsL+8aQ6+grbEryCv9/t029rBvRB4dd2w3Z6SjOAB55xypezYjZkC49
         OsS+GsurqVUp9NpwY7e38L690tHsegKrPUtNxd0fxkCPN1wL0dU+w06cKJ6DE2KP/CbI
         Eaew==
X-Forwarded-Encrypted: i=1; AJvYcCUIHsY0EnSYmzRKwUA1HHggGfKyHqSuxGoJ6MIAUDypaNd4TktRst6xn81Gq2ugzdYT2ir4ZbnV3jfKMRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5Jzuirtub0K86vHyClYDsSuMyuOVILMjgPBzb/QgoF/KAoE1
	RDKj6UHWnLybKjZAlgNmGsg45SNZMWsYCmJ8kVx1g50qzccy2M+RtKT/JqLvopCIuveipv+fy0n
	WqX+LMvp1ordoT1MY+havrcJ0u3F6C23qHeIRKdbg3/uKPtEnyjjrv0uSzT5Fuw==
X-Gm-Gg: ASbGncv6xq59Af839/ykCjv8gi7Sem+M6o6Pv4MKQMBtSF79Zv1DS2W5ifibpr6cCcV
	GNe+Blx+JKsUPZo5VY/rE/7XqX/4QSqzecCqCFDJFMhK2/i77/fSYt+SNyz26dU5LOkGfhIAr6r
	ny/Z+ivl98OJ9zC6CeBe+GdmV1JcYMhkg4Ha+oXG1Hb55J4raCgdL+YZYDnHsbkXrQ7C65dVRjU
	D4oPJrxSFVhL9wrHUfHHWIC9Mh7M/+UdGBBJHfPFJds53/VhtH+JAcvt1yANgatWfrk3GSzqeiU
	EACc5VRYDYdKAhE=
X-Received: by 2002:a05:620a:2853:b0:7c3:bc90:a483 with SMTP id af79cd13be357-7c3d8def966mr274516885a.32.1741143125372;
        Tue, 04 Mar 2025 18:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Kzaq47oYaXlluWqNHqU3y5KWm3Sf1dynP6q+E+3NZJnSaYHcFgkm9SxC6tuVsRmRNSnNDg==
X-Received: by 2002:a05:620a:2853:b0:7c3:bc90:a483 with SMTP id af79cd13be357-7c3d8def966mr274514485a.32.1741143125056;
        Tue, 04 Mar 2025 18:52:05 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3be81e8e9sm338768285a.61.2025.03.04.18.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:52:04 -0800 (PST)
Message-ID: <dcaaf50f186a94147528a4c53706749dc25db395.camel@redhat.com>
Subject: Re: [RFC PATCH 02/13] KVM: nSVM: Rework svm_flush_tlb_asid() to
 operate on a given VMCB
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 21:52:03 -0500
In-Reply-To: <Z8YmEC_P73JsvRWs@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-3-yosry.ahmed@linux.dev>
	 <2bb5b47e1b6c1251ae7fffe6d4d9836a401a1be0.camel@redhat.com>
	 <Z8YmEC_P73JsvRWs@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-03-03 at 21:58 +0000, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 08:29:34PM -0500, Maxim Levitsky wrote:
> > On Wed, 2025-02-05 at 18:23 +0000, Yosry Ahmed wrote:
> > > svm_flush_tlb_asid() currently operates on the current VMCB. In
> > > preparation for properly tracking TLB flushes for L1 and L2 ASIDs,
> > > refactor it to work on a given VMCB. All existing callers pass the
> > > current VMCB.
> > > 
> > > Create a svm_flush_tlb_guest() wrapper to use as the flush_tlb_guest()
> > > callback.
> > > 
> > > kvm_hv_vcpu_purge_flush_tlb() is only called when the current VMCB is
> > > passed to maintain current behavior.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > ---
> > >  arch/x86/kvm/svm/svm.c | 25 ++++++++++++++++++-------
> > >  1 file changed, 18 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 08340ae57777b..2108b48ba4959 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -3954,7 +3954,7 @@ static void svm_enable_nmi_window(struct kvm_vcpu *vcpu)
> > >  	svm->vmcb->save.rflags |= (X86_EFLAGS_TF | X86_EFLAGS_RF);
> > >  }
> > >  
> > > -static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
> > > +static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu, struct kvm_vmcb_info *vmcb)
> > >  {
> > >  	struct vcpu_svm *svm = to_svm(vcpu);
> > >  
> > > @@ -3963,7 +3963,8 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
> > >  	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
> > >  	 * entries, and thus is a superset of Hyper-V's fine grained flushing.
> > >  	 */
> > > -	kvm_hv_vcpu_purge_flush_tlb(vcpu);
> > > +	if (vmcb == svm->current_vmcb)
> > > +		kvm_hv_vcpu_purge_flush_tlb(vcpu);
> > 
> > This is hyperv PV feature that should be looked upon very carefully.
> > 
> > To recap, 
> > each vCPU has 2 queues of pending TLB flush requests that target only small range of
> > memory pages. 
> 
> Thanks for pointing this out, I missed this.
> 
> > One is for L1 and one for L2, because now KVM supports a mode where L2
> > can ask L0 to do a tlb flush on its behalf, and KVM will figure out to which L1 vCPUs
> > to send this flush request.
> > 
> > Requests arrive from other vCPUs.
> > 
> > Here we purge the TLB request queue because we flushed a super-set of the requests,
> > which used to contain both L1 and L2 TLB, but soon that won't be true.
> > 
> > So I think it might make sense to also add vmcb to kvm_hv_vcpu_purge_flush_tlb, and then
> > depending if it is vmcb01 or vmcb02, purge the correct queue.
> > I don't know if this is theoretical or actual bug but it is better to be safe IMHO.
> 
> But I think we are already purging the right queue here. We purge the
> TLB flush requests only if we are flushing the current VMCB. Within
> kvm_hv_vcpu_purge_flush_tlb(), we choose the queue based on
> is_guest_mode(vcpu).
> 
> svm_flush_tlb_asid() is called when servicing a TLB flush request, at
> which point IIUC the current VMCB and whether the vCPU is in guest mode
> should be in sync. So we will be correctly purging the L1 or L2 queue
> based on the current VMCB.

Yes, I also think so, but to harden this code from a potential bug IMHO
it makes sense to ensure that svm_flush_tlb_asid works only on a given
vmcb without any hidden assumptions.

> 
> That being said, it's a bit confusing that svm_flush_tlb_asid() uses the
> VMCB to differentiate L1 and L2 ,while kvm_hv_vcpu_purge_flush_tlb()
> uses is_guest_mode(). We also miss the opportunity to purge both queues
> when called from svm_flush_tlb_all().

Yes, I noticed that too.

> 
> However, we cannot pass the VMCB to kvm_hv_vcpu_purge_flush_tlb() as it
> is also called from common code. So I think we can make
> kvm_hv_vcpu_purge_flush_tlb() take is_guest_mode as a parameter and pass
> it here based on which VMCB is passed in.



> 
> WDYT?
> 


Looking at this again, I see that kvm_hv_vcpu_purge_flush_tlb() can't really work
on a vmcb, so maybe the better solution is to remove the call to 
kvm_hv_vcpu_purge_flush_tlb() from svm_flush_tlb_asid_vmcb at all
and instead let the caller call both svm_flush_tlb_asid() and kvm_hv_vcpu_purge_flush_tlb()?

This might lead to some code duplication but this will put emphasis that svm_flush_tlb_asid_vmcb
can work on any vmcb regardless of which one is loaded and such.

As long as it works though, I won't strongly object to whatever code that works.

Best regards,
	Maxim Levitsky


