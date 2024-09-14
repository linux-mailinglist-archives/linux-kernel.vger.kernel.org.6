Return-Path: <linux-kernel+bounces-329041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4C978C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C91C24920
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B291F19A;
	Sat, 14 Sep 2024 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffjpccr9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29918044
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726276441; cv=none; b=s//PpolE6fdCd+FvkeghgfjUVzFMCFZDz9+2e+9Yi8z5X4HBI0WG6VHmuZEOiXFzsN0oEEAWB0qWBe8IshUGnG/wQGrFQwGAH6rhkxOH75x8Kw6uyB2A+LM0cQ9MPzEgOEUXYAEjmYC9dyTiZr5bqdsEno46bMyS2Em/XdKTvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726276441; c=relaxed/simple;
	bh=ExoZITeT8vdpAmAdIIZ9I8AL3y8dN7G3G8J+621IInE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LmTSW+t3QdtVSlYsp+vWJ+KtXyuPPMhsFI3jl5FImXPbZxjywzO7pfppd5oUubviKyvmqzRapWnLaSXjrkse6YIiMmdQ3+OG9DgcuiE87zAFb85eT1HbtHWMVkT/62NJc8ohcvvuScJEqQ5kZ9fqD03awOXrT3Yzez684lE9leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffjpccr9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so4765661276.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726276439; x=1726881239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9TLAp+O1W7qMdk5rDFQ8BmVg/YGy7ndsRosC6n7b5qA=;
        b=ffjpccr9NRgHDBGRvPq6rsfdIVPfZ0wnb9kHplMPpbftqrzVLNwSDkJSQ77RQ+HaWr
         TPiSBE/gXwf/6aUWRvgWsPhE69be2MwS7P398qEl228rBXrB56Oq/G56hlHf7BYLWg+c
         lu8OCtR9Zr+FbKKFnx/0CB+8uNbPpzy1TtrVUqa812NIMGpBuzYFwKQ/TB8WkJnIgw7m
         jyxZi9X79QD7mQrTAKB/+7RdLFoEhlfhMDxG/9CnPeShrQtT+BJk4+s6Jky1QUiz+/y3
         UPnoq7WU7sj6zbK9V7k7G2nHqFjN9/bir+bttD4s5eywhMwA5ZUFg4sTe+ZrTv+xwGyH
         JrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726276439; x=1726881239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TLAp+O1W7qMdk5rDFQ8BmVg/YGy7ndsRosC6n7b5qA=;
        b=rtJrQEPTdxXHw8srLrbkdpq2CS3OU+0ef/t4KtOvg0+pnym+riQrNW1fUtGfkxAInc
         jnydsx4Lqdo6LzMtkSJbr4xzM6Y/1lEGKbH5dZg2hskeUhj95ce3gLD9nmJawID46W8J
         i/pzc6VyRvWks59X2yQDqb6dPyupmw2fLryOB8Ny9l0EUwVzGDL37fkO2i7rQzuxa8nu
         OZpmi1u4EW6vSEA7huPx5U3q7icvDEyHy4Jgtc5d5RP4I4nUTyMvcZVBPCVg0655vhdX
         MSuu0pXbUnA+vyNrAWhcTINbgvwouQMWWgXuYRrwZbKzqtzOOuhwYHo7GOQ/19bYGip/
         PX1g==
X-Forwarded-Encrypted: i=1; AJvYcCWmVOlJLma/dnKk1woCRxO9zbfJ+ziXXyhLb/Nht8Aedfqj0OkB1gskY4c7GtvYi21avS7iEotFu8fkpgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx507Jffek/VkFCx6BFmI3HTAi4/leJt8qR0cmkyaZiJ7bEdIzy
	ZrRR4PtkNYeXeYlBQuEXtS12cT9QGdvd0nOOEOo4WWZJ/nM5XN9i+K55tLKHMaOB+0K+3xYlR4f
	mqw==
X-Google-Smtp-Source: AGHT+IFU+zIpfMcULNa4fEmUA9OUbZKHi1gV8iwEarOxF3jBVam9+F23SRLggLGcE83n4gOd353JcM1RChk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:b4b:0:b0:e03:2f90:e81d with SMTP id
 3f1490d57ef6-e1d9dc528e0mr20621276.11.1726276438759; Fri, 13 Sep 2024
 18:13:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Sep 2024 18:13:45 -0700
In-Reply-To: <20240914011348.2558415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914011348.2558415-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240914011348.2558415-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX and PAT MSRs cleanup
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The theme of this pull request is to clean up the VMX MSR macros.  The PAT MSR
changes (reviewed by tglx) are included here as they allowed for an even more
aggressive cleanup of the VMX macros related to memtypes, e.g. for specifying
the EPT walk memtype in EPTPs.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pat_vmx_msrs-6.12

for you to fetch changes up to 566975f6ecd85247bd8989884d7b909d5a456da1:

  KVM: nVMX: Use macros and #defines in vmx_restore_vmx_misc() (2024-08-22 11:25:54 -0700)

----------------------------------------------------------------
KVM VMX and x86 PAT MSR macro cleanup for 6.12:

 - Add common defines for the x86 architectural memory types, i.e. the types
   that are shared across PAT, MTRRs, VMCSes, and EPTPs.

 - Clean up the various VMX MSR macros to make the code self-documenting
   (inasmuch as possible), and to make it less painful to add new macros.

----------------------------------------------------------------
Sean Christopherson (5):
      x86/cpu: KVM: Add common defines for architectural memory types (PAT, MTRRs, etc.)
      x86/cpu: KVM: Move macro to encode PAT value to common header
      KVM: x86: Stuff vCPU's PAT with default value at RESET, not creation
      KVM: nVMX: Add a helper to encode VMCS info in MSR_IA32_VMX_BASIC
      KVM VMX: Move MSR_IA32_VMX_MISC bit defines to asm/vmx.h

Xin Li (5):
      KVM: VMX: Move MSR_IA32_VMX_BASIC bit defines to asm/vmx.h
      KVM: VMX: Track CPU's MSR_IA32_VMX_BASIC as a single 64-bit value
      KVM: nVMX: Use macros and #defines in vmx_restore_vmx_basic()
      KVM: VMX: Open code VMX preemption timer rate mask in its accessor
      KVM: nVMX: Use macros and #defines in vmx_restore_vmx_misc()

 arch/x86/include/asm/msr-index.h | 34 +++++++++++++---------
 arch/x86/include/asm/vmx.h       | 40 +++++++++++++++++++-------
 arch/x86/kernel/cpu/mtrr/mtrr.c  |  6 ++++
 arch/x86/kvm/vmx/capabilities.h  | 10 +++----
 arch/x86/kvm/vmx/nested.c        | 62 +++++++++++++++++++++++++++-------------
 arch/x86/kvm/vmx/nested.h        |  2 +-
 arch/x86/kvm/vmx/vmx.c           | 30 +++++++++----------
 arch/x86/kvm/x86.c               |  4 +--
 arch/x86/kvm/x86.h               |  3 +-
 arch/x86/mm/pat/memtype.c        | 36 +++++++----------------
 10 files changed, 132 insertions(+), 95 deletions(-)

