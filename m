Return-Path: <linux-kernel+bounces-261376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E993B684
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE101F23E65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2A15F33A;
	Wed, 24 Jul 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyFtf7rv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B607155735
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845161; cv=none; b=OL/c6iseRQeSskKDfA4KcLWyAej5tX6KSCVe5WvKZEId+iUkHrRtiTNqdCjiCSXivJmAJszn0HuQLeqdRLMHD3yCSaITxezZztvE/DAbTh5jOBzzxaycYTMH2oTEb0rgUIe6OoRFa0XX+B0M82Zc4l09iSEvqLr0UcwXL1azoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845161; c=relaxed/simple;
	bh=Xlsr3+e3X6nmQKN/3OPAYPVM2WCI6I49qa/zfaddnks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmWiAbEW8C0PalpnpIvCroI5spsWCtUja9B8LH5mZkPj1oitt/9tYDS+RzOn8ydL/f+e/V6Yw/+7XOepOCIjIQV3uJ1v6FrNXrEzyNYvhRM4KdFCe48B4Lw4P+IlrIYdMtDULFK3lASlR3P0Yv0OO9ACsVW0ISfCBqtUAlXvOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyFtf7rv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721845158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG+Z0VgBK77YO3uQOGptWCjeSjYO5kEg9xaC/tvqiZc=;
	b=eyFtf7rvMDr4DdzxAQJN8ONZfCWpjUdVwRr+2U9lNfWTLdj3Rv7M1Mb+65FHHYbyJdBva4
	lzZJWKeNSPIXAwlC0HGrZjFJnFkT8bry/gdH6Kh+4IzR0fg7VN4Qa6MmgvCnRNO8mfKJS9
	SUV3i90//JppDNghW6+eNfqfh330q9s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-tO0Rp-wCP5aUoO-paNw35A-1; Wed, 24 Jul 2024 14:18:23 -0400
X-MC-Unique: tO0Rp-wCP5aUoO-paNw35A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7a6d56e53so2166326d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721845103; x=1722449903;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OG+Z0VgBK77YO3uQOGptWCjeSjYO5kEg9xaC/tvqiZc=;
        b=WVn15+3461fg61BJdJRCsuYlCSNYnSg9qd+HNKEQKSWhMlu3FMJSJq1+wK9Nw4uEyd
         wQoGHtOPJMrrBCmRy+ln8l0mKo0wdqNxfnV7kWqrB/DUPbYf3lQKtA4zlxhk26SNk8iH
         qbWo46MfLGIPk63WPpczjwQ2gnXcUiMNqtWskoLx0hhaWd3vRfo9iqHTktQVSSxHurxE
         TsVo4SI46q6exNJM2W7My4ddxA+OgmmBzoP4SKlAz9ErjPkeUkQ385ZSlEWtmLrbitMb
         08rCojcqxBsOrGPCXi4mNCE/YQX3lWqP8snF/yBRFU4sV0Gt4T8df6PINo8h3UUow/Yx
         /Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCVCnDvPPdXNhw6ofJdmmuLyRuwXYXAdNhSqC230vFeeWYntE5Q/KNLfdVlJBBx9VjTYxfUSOVnxR2RIshtS8nhvpkkf2I0Fwmipfzo+
X-Gm-Message-State: AOJu0YwVlutsEeKFaPQMMqbgTbb1XjqBQELXG5YCezTtgGst+MPpcZyT
	5TTKXI5mX6Wx0ykrhv0ORGJiL6l1Z5v7+FNnyBQbtvgd7d+byKSp3T1IYN2SvBVxf9U5SWbLNkJ
	XGrHmGSQd/qZ0djD9/tOxupWH9901Zy4irBs24zXOymikejIkGUsHZ7zN3AiThw==
X-Received: by 2002:a0c:facb:0:b0:6b5:2062:dd5c with SMTP id 6a1803df08f44-6b99129ed1dmr51085516d6.8.1721845102972;
        Wed, 24 Jul 2024 11:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzp5YHHhVThEiFTn5V5wo00MS1NlOYpQSfiEo0+h3Ax7L+IzEWoagCZ4NCEPDBfTTH4sRIKQ==
X-Received: by 2002:a0c:facb:0:b0:6b5:2062:dd5c with SMTP id 6a1803df08f44-6b99129ed1dmr51085166d6.8.1721845102682;
        Wed, 24 Jul 2024 11:18:22 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb0a768sm60563936d6.139.2024.07.24.11.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:18:22 -0700 (PDT)
Message-ID: <ed95389522d5c2767dfa60d121dc04ee73087add.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: nVMX: use vmx_segment_cache_clear
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>,  Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 24 Jul 2024 14:18:21 -0400
In-Reply-To: <ZpbhItUq-p_emFUT@google.com>
References: <20240716022014.240960-1-mlevitsk@redhat.com>
	 <20240716022014.240960-2-mlevitsk@redhat.com> <ZpbhItUq-p_emFUT@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-16 at 14:07 -0700, Sean Christopherson wrote:
> On Mon, Jul 15, 2024, Maxim Levitsky wrote:
> > In prepare_vmcs02_rare, call vmx_segment_cache_clear, instead
> > of setting the segment_cache.bitmask directly.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  arch/x86/kvm/vmx/nested.c | 5 +++--
> >  arch/x86/kvm/vmx/vmx.c    | 4 ----
> >  arch/x86/kvm/vmx/vmx.h    | 5 +++++
> >  3 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 643935a0f70ab..d3ca1a772ae67 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -2469,6 +2469,9 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
> >  
> >  	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
> >  			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
> > +
> > +		vmx_segment_cache_clear(vmx);
> > +
> >  		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
> >  		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
> >  		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
> > @@ -2505,8 +2508,6 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
> >  		vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
> >  		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
> >  		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
> > -
> > -		vmx->segment_cache.bitmask = 0;
> 
> This actually exacerbates the bug that you're trying fix in patch 2.  Clearing
> segment_cache.bitmask _after_ writing the relevant state limits the stale data
> to only the accessor that's running in IRQ context (kvm_arch_vcpu_put()).
> 
> Clearing segment_cache.bitmask _before_ writing the relevant statement means
> that kvm_arch_vcpu_put() _and_ all future readers will be exposed to the stale
> data, because the stale data cached by kvm_arch_vcpu_put() won't mark it invalid.
> 
I noticed that after I sent the patch series, this makes sense.

Best regards,
	Maxim Levitsky


