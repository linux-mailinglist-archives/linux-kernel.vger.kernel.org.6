Return-Path: <linux-kernel+bounces-212280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FEB905DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C24F1F22A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E6127B56;
	Wed, 12 Jun 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGZ0oYOj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC185956
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227927; cv=none; b=D1Wx1NqhwxB85i9z+Bw2r3gt2vLTVE+j43dMRx031rmwsJfbPGdPI3R9szpi0vwpFr/Vd9Ky/D3gR5Ozz8mkH3TuDfla+wi2U0Ya/T27GkjQq85uQr4pg6cYF5fBV7VbkvW1ct5tjZovksaw5ylYiAK19+8db/6kwDBF/c76n0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227927; c=relaxed/simple;
	bh=W5Lf3m/ndcYRRPBJWPF6wvhs/2Q/L4nQNdthZxKjzRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAgjmNTiZLhxvdDWtPSw/RRYoY+LifK8LZ2dKwrcjpK4MS/PSvBZgd99tOVOBnnLTe4JsTsQE4LFVvQcX86TcS7xSQw0T5rg968j55h2KTUfqhj7iFT6+ZDFqnl96Qk8vSGN7El0IQ3R7L9v5yGKcRd8qsdqYAkkLZBmlfMAAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGZ0oYOj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62834d556feso6146077b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718227924; x=1718832724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QhL6pyEL28D/XNE8O9WA5q6Sm9P5RrVE+DUX18+yxg=;
        b=BGZ0oYOjCuu+2FztOekL9bGT4kIT+0Mkyxtlqqs4iixMR2yB5xY0xLmd2xZSAFmoxL
         NhwKcdf2MJWhO87UrxL22vqKTdQMLLfk+QSM6pqmfiu5YXG7HXylm/W0MNqSwAEc9tMd
         muevp/bCQxRs5QSt/Y3L8aCehNOu6VKmCmpkViMXfCxi6SwrFY3YK3YnYmOGKM62TfoU
         bNctT8HnlUkayiMEC1SYecE80166dbZh+hwfXXWnyHYDs8G486V+oYM9ihIv27eCGwfp
         SIRYDMUIko+f1VvH65QrcaQ+j7djCOafZqYfhBx48v2xhBtBaUYpnWGbgp//+tV688Dd
         OYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227924; x=1718832724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QhL6pyEL28D/XNE8O9WA5q6Sm9P5RrVE+DUX18+yxg=;
        b=n9GeCOfP56bH15EF3+yOp4xkOX2fIfj769pbzV0QlwCleXwr1iwrjYQuuzBX7wzhb8
         xu4MC63LEOEbDEhzuRZ19vBXfLbbzSKJxO7we8e5SvNxocF5Sr6jTjqj1IkhF5d4TrcP
         OYCCqrM7OKK9bK7Ws9Wb6yQRiqP2Or78O7rPsf71EMZyVlwMnB1btiGtxURE4L0HhfP3
         I7Sse6GaLC3WdKz8KWmWs7WiAB4+uXQZHxkQPqlzTvcZIfSsBxAIRubyUgscsoZH+sT/
         n+zJGFzSKV0uQnBLnbThJWcdtBdoM7QGQ3qz9Z2wQN9GwdOvlqSkgxY7PwpR0/6g4UZ/
         m9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW9mCSa9bxlP0itbtXGKpZxronSG/qnw/iAI6NcH+gb4yURDP9aEUlnHUJsKxfHaU0YlJ4MtRiaCOZXJzbki28rxrVmIsJUnXp3ncdh
X-Gm-Message-State: AOJu0YxQzBvY83nGB3dR50VtE3c65K04f2RdFE0cI1A5Y68QmR19Xl4A
	5rTEwYZY8/Z99LGN0EQPcw/cuX/aO+vjzqBY+MFEYRmQJ4Ug7itqLLpxf4mXGOPNTX6cuZ36Gjh
	PWw==
X-Google-Smtp-Source: AGHT+IElKu5tuXfOpkwDgTwij1K2xNLep+MJ1d93sRu5Kogldzr3WaT9Nh8Ti2R0sk/kH/nRqM8JoaY4WmY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d88:b0:62c:f976:a763 with SMTP id
 00721157ae682-62fb72f2569mr9479477b3.1.1718227923971; Wed, 12 Jun 2024
 14:32:03 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:32:02 -0700
In-Reply-To: <ZiJzFsoHR41Sd8lE@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-8-xin3.li@intel.com>
 <ZiJzFsoHR41Sd8lE@chao-email>
Message-ID: <ZmoT0jaX_3Ww3Uzu@google.com>
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Chao Gao wrote:
> On Wed, Feb 07, 2024 at 09:26:27AM -0800, Xin Li wrote:
> >Add FRED MSRs to the valid passthrough MSR list and set FRED MSRs intercept
> >based on FRED enumeration.

This needs a *much* more verbose explanation.  It's pretty darn obvious _what_
KVM is doing, but it's not at all clear _why_ KVM is passing through FRED MSRs.
E.g. why is FRED_SSP0 not included in the set of passthrough MSRs?

> > static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> > {
> > 	struct vcpu_vmx *vmx = to_vmx(vcpu);
> >+	bool fred_enumerated;
> > 
> > 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
> >+	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);
> > 
> >-	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> >+	if (fred_enumerated) {
> > 		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
> > 		secondary_vm_exit_controls_setbit(vmx,
> > 						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> >@@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> > 						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> > 						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
> > 	}
> >+
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
> >+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);
> 
> Use a for-loop here? e.g., 
> 	for (i = MSR_IA32_FRED_RSP0; i <= MSR_IA32_FRED_CONFIG; i++)

Hmm, I'd prefer to keep the open coded version.  It's not pretty, but I don't
expect this to have much, if any, maintenance cost.  And using a loop makes it
harder to both understand _exactly_ what's happening, and to search for relevant
code.  E.g. it's quite difficult to see that FRED_SSP0 is still intercepted (see
my comment regarding the changelog).

