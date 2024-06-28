Return-Path: <linux-kernel+bounces-234682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBD91C967
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF92838DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807684DF8;
	Fri, 28 Jun 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Er+H6hG7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789684FC4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615450; cv=none; b=MCJsA0Qno4NAg6gOnJuDN3GICaLFfn8oE/CMuHh0lVr4sZXm89z1ItTOuD/HKQslHVqlYihaIZvrUmw9/FTq48xBcd2UlyejAP6xpZyiT1ojDWon7vv12wfuxDdP5FO7j7uOtVuqjGVlMHI8PpFsbEsxgnPl/T5yfVSmxbYTxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615450; c=relaxed/simple;
	bh=xqTfxbGpJ1LTx0EYawrcihiFOXIZDPg324p4s749fkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S/199vZd06dZNc4s2QWM4jw7JulhhFIwpbBhNAPwb/sONStYw1gyxpj113vws7oR4MoEzI8kAgWdFcvGMZdL3PcTDuiN/E8+IIil9GcOE4cnc1fu/yXmwhK6lXB5pEKBGgDnNIXgigfE0jVadwD7Bu9fLBul1iexlRBJNF/hK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Er+H6hG7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e036440617fso1488772276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615448; x=1720220248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ka2TYBXePDNRFwUO0goijz2z1ga6wWdatJtCubR5EY=;
        b=Er+H6hG7aTDVN1udg48F0sdOA+euCVmz7ARQSwIiVdPZkYtauVeWgaXca1IC1w6s5n
         WhlQHX6nb3R3ZmfR2yjizlO1X7svZgnEEWHLXJpybY3Onpwk7KruUx6WF3Y7nq3HJQeK
         ogKECBIeaL+595uM5S72NximzCkAByJdR5t+CwB9ET1KMpAjNQM2doGM/tOxl8NbpIdu
         NK00eLpXvXVQeCJbZmiJLuff1QZXxnl+7mJf3WtYIbNFf58qJka5TtSq7uEhqEDKAmuA
         TEViFM5ursWIymAnKH6NhydCPXZIjbENxc04rDorVB5iRRUDZArSSR39l5XTRKpCWn83
         eTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615448; x=1720220248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ka2TYBXePDNRFwUO0goijz2z1ga6wWdatJtCubR5EY=;
        b=AIPviaXw/2aXcg1hFfCv3SBp8JIu32cO0yAeX7fvgLUAOmefAVnVNeIx3LHEcJpOGg
         2RULQqHhd1SJ1lMgoxgUlUycT591zMcGwUZRuM/B3xh6BU67RR6idg0GnCMoh7OvZ7jG
         DMb8c93X9ebbcpmLQjM5YpPoY0bjCRD/8G2/kxPzf/f/W8zdwijTkbILRWOw6+Wn6zcm
         9UwfxGgXFVFpXfnGFreBUoobbDkFnKplc7ntvcTTduhvTe+MN5qMw0pKkPnlYsiRkgon
         fTcJ0Z08W6LdsIJxwN1M2v7Lhwp60oqp8mDO0a/TEOxkv4IkBXRDKO+dssW+QSnsw3b8
         0Jvg==
X-Forwarded-Encrypted: i=1; AJvYcCWFmE4dcVsMtf12oRHlJQdnk7zhRHYfEdoxjSHEY2MyshWzXtSXk3SAVLPemNVIZ4BMuh/iHLsKGR9OibVAdUjN9E0dT96oUYEusY7L
X-Gm-Message-State: AOJu0YwwvYfjiKvUB7hE+NhvT1H89KpMMDPTULXPj1a01mkXsnxRa2O0
	tgU3dElsMygDipYZ5h5lEmL8afBOfB0oLYFkx3vkNKJ6EXx4q2Ervw8l4uVy+8v6WnQELMMadYH
	Mpw==
X-Google-Smtp-Source: AGHT+IFoGt81NvBqI8YvaFKmDsppbhxEa6FMKcoUWrJ7elSWW0PI4NsQXKltGFqVdnHkj9yDILZDIhYdDZ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1145:b0:e03:3f26:b758 with SMTP id
 3f1490d57ef6-e033f26b912mr606523276.4.1719615447833; Fri, 28 Jun 2024
 15:57:27 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:38 -0700
In-Reply-To: <20240607172609.3205077-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607172609.3205077-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961397058.229961.11129325445549877683.b4-ty@google.com>
Subject: Re: [PATCH 0/6] KVM: nVMX: Fix nested posted intr vs. HLT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 07 Jun 2024 10:26:03 -0700, Sean Christopherson wrote:
> Fix the nested posted interrupts bug Jim reported a while back[*], where
> KVM fails to detect that a pending virtual interrupt for a halted L2 is a
> valid wake event.  My original analysis and the basic gits of my hack-a-
> patch was correct, I just botched a few mundane details (I kept forgetting
> the PIR is physically contiguous, while the ISR and IRR are not, *sigh*).
> 
> [*] https://lore.kernel.org/all/20231207010302.2240506-1-jmattson@google.com
> 
> [...]

Applied to kvm-x86 vmx, but it's sitting at the end of the branch in case
someone has feedback.  I'm out next week and really want to get this into
6.11-rc1, hence the quick-ish merge.

[1/6] KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector
      https://github.com/kvm-x86/linux/commit/d83c36d822be
[2/6] KVM: nVMX: Request immediate exit iff pending nested event needs injection
      https://github.com/kvm-x86/linux/commit/32f55e475ce2
[3/6] KVM: VMX: Split out the non-virtualization part of vmx_interrupt_blocked()
      https://github.com/kvm-x86/linux/commit/322a569c4b41
[4/6] KVM: nVMX: Check for pending posted interrupts when looking for nested events
      https://github.com/kvm-x86/linux/commit/27c4fa42b11a
[5/6] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
      https://github.com/kvm-x86/linux/commit/321ef62b0c5f
[6/6] KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject
      https://github.com/kvm-x86/linux/commit/45405155d876

--
https://github.com/kvm-x86/linux/tree/next

