Return-Path: <linux-kernel+bounces-206539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A98F900B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251761F236B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2A19ADAC;
	Fri,  7 Jun 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4Lm2DUk"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076019AA5B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781174; cv=none; b=LCSKFSc5B4Ij33v7J7gdYScEEQdPWWsVVSkvxY1mi7AURiLrMS+FIb9HPmadtYNfO6shOHN+gpn6QksUhzG4cYEpbh9OpLGXwx17BmjsKBZK8ccloWQe6HuD+S5cNOMlbryI568EwAutexPaIdyoUVVTjfgTLIiQM+/K1MtbyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781174; c=relaxed/simple;
	bh=IQzrSRvqmZvcnLkZDTRut4HhpmQm38jC6WB4XZLfods=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iZ/wKckTOpcepeoSMhlnA1O7FOyzOqgkEbvzNWhazp1ukOF6/ShbEuSjVJevQQcHQYQrF2UBYVHtCjUd8RyP68fjNZhss6x1v77v3NGz+X6LAnYengPweC5ebmDOucobVFUmZ4FhrAXlwwIn4Rd/VVEju5SjnOcG9QDj2zKtnj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4Lm2DUk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c7e13b6a62so2086013a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781172; x=1718385972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8D2p4JaYRkh+KONnYh36xB/hyP7cXvDvqjRzrMCIXg=;
        b=M4Lm2DUkEzDAA+CggdBRrqTMULYgGaETzI/vqPTkdOpnokp6+qC4EVR7TVr8f8+9Oo
         aDlYHSXqoFQX2zrca/280zatS2/pzkgeJqZ1fQWH4XjbO1ZA4XXTntLkCuYyCzh6+g82
         BXYzP5hWI0jKOV5UFODtOhJYfQTmcloFcuE95Jn8dVArZvKX3UNRFYn6ZjCWm72G78RM
         jVm3ICMd7WPiZNMj65SvNYiRXngmdwoiR93K8E+tM6+2mVmmdOWwzsLteLgQEZlqOdoL
         iJvjnTjgODFZQHSIK9qB1a34ROmoW6mdx/+2q2tjuh1ZJ2GeuOPYclnWSNPgYkzJhOIP
         NcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781172; x=1718385972;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8D2p4JaYRkh+KONnYh36xB/hyP7cXvDvqjRzrMCIXg=;
        b=sbDvRmFHUFuRLFuu4ovn5CaaP1BkM/Jl7JloJIwGjPao/COYU566lYQjvCsSI40fCs
         sWXW7ThHD0oxkXquai2ZfBafSbgvrtx+QKO/g27ruRoslZuQMto6W6t/+VaLWErUzFnj
         DXzOd2GxbLgwxBu7JKy9nQP8/rhNUxJlzKczNH0MzmsewzdwWr9cyt5+jw34nmrUNKlZ
         WR9CkLf8RmuVqThXpGrpR18nb6LhthosHBOWusVqnzDtdV9RnHD8KxNGWLUwGHSXjP5l
         WGXV7fCS9rV868R912C7kvMFPDph91A79UO+HkRWg1tFDKxwLyquPpe9i2gbBJa6vR78
         K9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVFEA1LncE+bxPAz7NFgmXuwwo4dj7o3ereUmzluF+z/Zn5Lfcpg0h/j8acN30zRjSJx1YedGNTDd5IcQRr2v5JpYdVgYOHispA76S2
X-Gm-Message-State: AOJu0Yx47FKCn+3TTwial/6Jv5mleyqc/PAGzdx/Yo8TCFtMfRqbwJ2n
	vL9FznwVTMPfYGLdAwVWnrpxMEz4BHkxDYF7emRr50vFQNYThF+2XXK5J2+tufy1Gm9CpDzqT08
	vOQ==
X-Google-Smtp-Source: AGHT+IEgUAojaDL2kv87NlL1e/Et7Bt7YgZelBKFh+AmcQlFeDs+1cI+WfgV2S9gwmXGNPku7DS2HG0pwRU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6804:0:b0:655:199c:eb1b with SMTP id
 41be03b00d2f7-6e1603ae662mr6803a12.10.1717781171967; Fri, 07 Jun 2024
 10:26:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 10:26:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607172609.3205077-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: nVMX: Fix nested posted intr vs. HLT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix the nested posted interrupts bug Jim reported a while back[*], where
KVM fails to detect that a pending virtual interrupt for a halted L2 is a
valid wake event.  My original analysis and the basic gits of my hack-a-
patch was correct, I just botched a few mundane details (I kept forgetting
the PIR is physically contiguous, while the ISR and IRR are not, *sigh*).

[*] https://lore.kernel.org/all/20231207010302.2240506-1-jmattson@google.com

Sean Christopherson (6):
  KVM: nVMX: Add a helper to get highest pending from Posted Interrupt
    vector
  KVM: nVMX: Request immediate exit iff pending nested event needs
    injection
  KVM: VMX: Split out the non-virtualization part of
    vmx_interrupt_blocked()
  KVM: nVMX: Check for pending posted interrupts when looking for nested
    events
  KVM: nVMX: Fold requested virtual interrupt check into
    has_nested_events()
  KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject

 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 +-
 arch/x86/kvm/vmx/main.c            |  1 -
 arch/x86/kvm/vmx/nested.c          | 47 ++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/posted_intr.h     | 10 +++++++
 arch/x86/kvm/vmx/vmx.c             | 33 ++++++---------------
 arch/x86/kvm/vmx/vmx.h             |  1 +
 arch/x86/kvm/vmx/x86_ops.h         |  1 -
 arch/x86/kvm/x86.c                 | 19 +++++-------
 9 files changed, 70 insertions(+), 46 deletions(-)


base-commit: af0903ab52ee6d6f0f63af67fa73d5eb00f79b9a
-- 
2.45.2.505.gda0bf45e8d-goog


