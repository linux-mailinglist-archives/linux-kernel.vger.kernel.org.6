Return-Path: <linux-kernel+bounces-395651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C89BC10D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05086282CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861C1FC3;
	Mon,  4 Nov 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/ga0r5E"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053D1B6D1B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760217; cv=none; b=X+7zYYogyhnlsi66wxhC/lePKFsnIeb1mLHEsv2wdE4IGCzbdqX1Ip6BL2Bmz6OIbCZlqw8DnS0r/FW1kEy+kaJdey5k5c7fAa6V39l3ZfGYR2b3pSjfR5InjXi6f8867xUp0rLxmufuqAt4ckw2ztA1aOdj2XjypqJB8BKwBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760217; c=relaxed/simple;
	bh=dBuFx1kas3MmeCLSh3pX1AAR5U67vWtV6d6/Sqj8lcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FxszjL+DNJC2Fhdmpv99wcxuZpocsWhqLGfOujbhAGJti/SkHOv1FOf/N+iQY5m/yeIFRf6pE3QDd6ayPYG+31Mf7r3sWYD3B1YsKHIYBUdiKdupMWKyOYHfR1NvxjBCWu+hCuogBqU118gy2KCQcpUhw51u3blPr2MQmVgWGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/ga0r5E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-211151bcf46so39186165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730760214; x=1731365014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls6gLEGZJHNa8T853PAtOKqHMNuKb0zzrscI5tJvK7E=;
        b=0/ga0r5EQRBVvlUENvPmcmrFiFpFY1yG7N8grmCd6Ctp1YGkk1L47m9ppYlETeaKvx
         W5v9e7mxD5bFhpV2JyMyu2iLfhJ+cI3aeaZoVBd5nEccDt0v8ntaQRaE8Bwd3aD2wdu6
         PPoxK6GbIvKhWvA5SMimbzZ7KgK5Ffq6QKyzE7pO94SC6a6aOIEmZ2hgjKFiZH9x889L
         OZXGzhrsS34PmjY0pBiDaIjWMwqMr9bvEzSflLSKgjj4vBijg1lWIhgnQtj09gSPzUOF
         TcapOYR6ihuXMr+qumZ9fOFFZh9jVyar0Mx5YvBJaRPtHvDWl+SFW8Zu0Z4wNJs2QJiu
         Bedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760214; x=1731365014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls6gLEGZJHNa8T853PAtOKqHMNuKb0zzrscI5tJvK7E=;
        b=X1nDYDCJJZBHIlKPggdNg6wip5w8i3IGkJCNXlVicSf1qYP4kz1gdTBo3RP7N0Qmkl
         bUnnUdBBf8P/n5QS5eBouGxl16uaKIVuVwhSu8iOQYKTvqttWZ7UAgTV5Koa7nCIkgVu
         uJlspS1CUhM7Se4+ISIoLu4GTQDNdO+xB8AMdcdOFjHfMqPrKojruLn0DQygvWDT0SRy
         CP9zSdJ999HnnE8AV9J1cC9jACzPSgPRsvSU7QRFc3/EWXYM7FfUiYl8hef+7QGpDUUv
         42r4LdphywcWHFuc/NaX5bAOBdOHWTPgIx2sh/q7EHyTmvwzWsQcWbZKd87xacBPa7G1
         dqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrq//lRprbVZ6Acg9+g6mUSWhdU46J+n3LstR5xEfkcLeAfJZvBmpX1X1VKEsHca81ZW7Udr6/QO1x6r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLaZL/x/V12pm+wMOClad8dNhXGlnd+EP+HDXIE3SMrZQ5c53
	xRAdRy9bHo+uQUEIfPnJxnMMIlJNd3xzEGc8l6mXRXsEVkaTeUjEuwXmib89jWibgmQyPogZ6fz
	P/A==
X-Google-Smtp-Source: AGHT+IEOZzy++cNTt7i7Bx5tmChi1y4G9l1WKuA0Im1d0mKgOa5auUlJsLselILXuxd11jZmv25S3Gq4O8A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:fcc6:b0:20c:7d4c:64d1 with SMTP id
 d9443c01a7336-21103b326f0mr156315ad.5.1730760214612; Mon, 04 Nov 2024
 14:43:34 -0800 (PST)
Date: Mon, 4 Nov 2024 14:43:33 -0800
In-Reply-To: <Zyh3wsWVvP2V2fNQ@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101192114.1810198-1-seanjc@google.com> <20241101192114.1810198-2-seanjc@google.com>
 <Zyh3wsWVvP2V2fNQ@intel.com>
Message-ID: <ZylOFcayR3lMZdGA@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Markku =?utf-8?Q?Ahvenj=C3=A4rvi?=" <mankku@gmail.com>, Janne Karhunen <janne.karhunen@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 04, 2024, Chao Gao wrote:
> On Fri, Nov 01, 2024 at 12:21:13PM -0700, Sean Christopherson wrote:
> >Pass the target vCPU to the hwapic_isr_update() vendor hook so that VMX
> >can defer the update until after nested VM-Exit if an EOI for L1's vAPIC
> >occurs while L2 is active.
> >
> >No functional change intended.
> >
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> >---
> > arch/x86/include/asm/kvm_host.h |  2 +-
> > arch/x86/kvm/lapic.c            | 11 +++++------
> > arch/x86/kvm/vmx/vmx.c          |  2 +-
> > arch/x86/kvm/vmx/x86_ops.h      |  2 +-
> > 4 files changed, 8 insertions(+), 9 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> >index 70c7ed0ef184..3f3de047cbfd 100644
> >--- a/arch/x86/include/asm/kvm_host.h
> >+++ b/arch/x86/include/asm/kvm_host.h
> >@@ -1734,7 +1734,7 @@ struct kvm_x86_ops {
> > 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
> > 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
> > 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
> >-	void (*hwapic_isr_update)(int isr);
> >+	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
> > 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
> > 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
> > 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
> >diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> >index 65412640cfc7..5be2be44a188 100644
> >--- a/arch/x86/kvm/lapic.c
> >+++ b/arch/x86/kvm/lapic.c
> >@@ -763,7 +763,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
> > 	 * just set SVI.
> > 	 */
> > 	if (unlikely(apic->apicv_active))
> >-		kvm_x86_call(hwapic_isr_update)(vec);
> >+		kvm_x86_call(hwapic_isr_update)(apic->vcpu, vec);
> 
> Both branches need braces here. So, maybe take the opportunity to fix the
> coding style issue.

Very tempting, but since this is destined for stable, I'll go with a minimal patch
to reduce the odds of creating a conflict.

> > 	else {
> > 		++apic->isr_count;
> > 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
> >@@ -808,7 +808,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
> > 	 * and must be left alone.
> > 	 */
> > 	if (unlikely(apic->apicv_active))
> >-		kvm_x86_call(hwapic_isr_update)(apic_find_highest_isr(apic));
> >+		kvm_x86_call(hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));

