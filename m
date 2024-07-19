Return-Path: <linux-kernel+bounces-257723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463C937E20
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67511F21CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780F1494A2;
	Fri, 19 Jul 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fw7/KlD+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50351487FF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432944; cv=none; b=mabbedRHRz+hkoj8zBc5zt2tlwvZEhsd25uoFb7ZOLAJ93jqNSspVtH15BQ0zzOsrYPbLHU6c/9Mc+19D/7+HExUBJxqcOg/i1zy+KqodxGt5Z01Cv6kL0Qpqcwn5aEARivPEs+kiKM3a+sOT+Ul6vTHgCgRiZjwcwu9sT0ykJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432944; c=relaxed/simple;
	bh=6wsU/LpGgHKspwokYc263qb/EOwNhT1RF7Hmbr9VNK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=f9OAkIEuyFCPibTadfsKLsQggl/5UNy8pOI0yZFlWP/yqq4Kd8iJC/D0HtLnQ7sgr4XU7Oz5w7MemfoDGz0gdtJ0nHKKGTbSeLRl3DvRF4azUEctctaHKUwK22N09u/j6mXmAl/7x9IEwX5JjgHjjPPDwuHfM3HdlICpWfD07GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fw7/KlD+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb52437680so1982276a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432943; x=1722037743; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXRHjddCb/uAlT5JdVupsNS5X6s2B0avadUtvsjzAmw=;
        b=Fw7/KlD+uWiyoIHFNJOm1HBm1yYIBmV7hcrafkFksyoyYawo+m2ZvxHUqdgJyVvjV6
         53Ss34GKDsG6W8RS63lEoRDHEwPpp52SfR9BRR6K+NvrKr5mEl0bpJCWzH0yvIAtrH0g
         pgZIyFKKlnQo6ai1AfI0YqGHwymneX2/sXBow3K9HIqEe4gB6ibuawb4o7ftb4lBEpTA
         YN+0AXD6KLaQq0T6sLOsqnvQdNc4BvpJ7MkTsnpFECgZYLi3LEn239e1h7QnA+VARnvW
         JH4HMt/9gstn5dmSDTroWxOf9QhaVS+WkjlZwZormRVuMsGpGtMQ2/HHUo0hW4I7IBSb
         5m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432943; x=1722037743;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXRHjddCb/uAlT5JdVupsNS5X6s2B0avadUtvsjzAmw=;
        b=poZ8ZHq96NhjSqcH/RsmWAJRQH1pL5fXliKOrpy7Pkxl5r/A1Iu9xY0T5fxilcvUS4
         3mjU1RvPzxbS5J5u+W6Ef9Wp9zmSysem7OPV+lWoSmerjufsmOY9nzVWGiknPlF5bPnC
         Y5c9m/m5+6GXzuUGY04WzE2AJHH6TpZrRPcE1VpOdR4JMvniTPGC+nYOAcpCyDXSMK3F
         kxn58bINbTJW2volSaogdPFJtWwk6EOrhcPIrFKJNM+WKmUmt061XPZgQiFleikh83pz
         dgDXSlQPesbHflQ0uWrOfxaCg0JS+ucUmT2SwqWYF89oBhanOk9WVaflUt7NvpR2wOkC
         p+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoBxz87l+M5uaWYllWI3NRBSP+yAiDp8yTHsC8KQpQl+eU7ebPy489MqSEkzoBjeHf3xtCXo7je3+dZruF946QpkjNFxAxQMyR6cFg
X-Gm-Message-State: AOJu0Yzq88/1ZXRnzw3uiPyG2xRwNmwNatVyNYQNQpHvUV2bt9EqS2rS
	WKxmraKRWw//e6Zl4PSwhfB13fQQEQpZqC1CPSR69O6aPwBIIB+hV2x9RnrFnWCPIjOFSwS+yMt
	YYw==
X-Google-Smtp-Source: AGHT+IGXG4esDPDe74ftxFit5jMhyNEDCksax5AUss1yZJHXjt5MZaVtYuxu7UpOwkzwCaNkZhbfdp6JNN4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fe8f:b0:2c9:ba2b:42ac with SMTP id
 98e67ed59e1d1-2cd1618bd8amr3887a91.4.1721432942785; Fri, 19 Jul 2024 16:49:02
 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:49:01 -0700
In-Reply-To: <20240719234346.3020464-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719234346.3020464-1-seanjc@google.com>
Message-ID: <Zpr7bRMdinPsPWBU@google.com>
Subject: Re: [PATCH 0/8] KVM: x86: Fix ICR handling when x2AVIC is active
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 19, 2024, Sean Christopherson wrote:
> I made the mistake of expanding my testing to run with and without AVIC
> enabled, and to my surprise (wow, sarcasm), x2AVIC failed hard on the
> xapic_state_test due to ICR issues.
> 
> AFAICT, the issue is that AMD splits the 64-bit ICR into the legacy ICR
> and ICR2 fields when storing the ICR in the vAPIC (apparently "it's a
> single 64-bit register" is open to intepretation).  Aside from causing
> the selftest failure and potential live migration issues, botching the
> format is quite bad, as KVM will mishandle incomplete virtualized IPIs,
> e.g. generate IRQs to the wrong vCPU, drop IRQs, etc.
> 
> Patch 1 fixes are rather annoying wart where the xapic_state *deliberately*
> skips reserved bit tests to work around a KVM bug.  *sigh*
> 
> I couldn't find anything definitive in the APM, my findings are based on
> testing on Genoa.
>  
> Sean Christopherson (8):
>   KVM: x86: Enforce x2APIC's must-be-zero reserved ICR bits
>   KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()
>   KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)
>   KVM: selftests: Open code vcpu_run() equivalent in guest_printf test
>   KVM: selftests: Report unhandled exceptions on x86 as regular guest
>     asserts
>   KVM: selftests: Add x86 helpers to play nice with x2APIC MSR #GPs
>   KVM: selftests: Skip ICR.BUSY test in xapic_state_test if x2APIC is
>     enabled
>   KVM: selftests: Test x2APIC ICR reserved bits

Gah, ignore this version, I managed to hit send in the middle of a rebase and
left off two patches.  I'll post a v2 to minimize confusion.

