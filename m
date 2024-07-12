Return-Path: <linux-kernel+bounces-251244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10388930293
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345F01C2104F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19C13B2B8;
	Fri, 12 Jul 2024 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RNuRJ+B"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC713A3F9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828638; cv=none; b=kHJ8eWiRIhlo9B+mycNBPmCrJnY1k3b6d0q/px1aqoVwBvJoNfAXwiHLrUVOxqhgd5hpk2L6TbjIrxoDcG87fz1/ppIyntFL6VFHeo1lOJUBdgElLohbzjp5vs+vBdYjjHmA82JNCGKWpWG06Rmxaj0rIKLZU4a+nKIjOMlxKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828638; c=relaxed/simple;
	bh=SPL7rW/eqX8PLFoMekm0YLHu92H6jrTDTmJTj0Pi5n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BoPEsdcWdrvHsT5f4kmb9sv6spqjLUiY3gcvhD377Y1nvkl2MH6PN5O2obX3DjRZZQ4JoIKOoa3+alWT+XL6ecHAmF59+NocFqS20VuUeou+DwG4znqUdwamSEOUC/RU77iXAPJHcsBiVUzg9XijtG3Gpo1NuOa0HKf996rw8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RNuRJ+B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e039fe0346eso4632428276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828635; x=1721433435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0VBhxle6QEdRgy+LXsQtUVeYiw0Y7V3wixvog2TxeJI=;
        b=4RNuRJ+BjHbSg8JGlbxPxeZYsw35HG4PtYlUlOnk5q3DK5IMM/n/RKn4jyRtenJ79F
         rdhk+RbHhlQTLGntM7CfwQ8D5nPCWDUJAUc/WmUTp+YfFcrgk+vUzXyapSSIOfCakQy6
         4qmRH2PXJ/pHkt7fbvamPDks2a8J/w+LgD6L3O/jSkP5SQKyah3cp90XODlzug7MxRAh
         MxbQL+zBX36B6RuEVlFds7XHfcalhYe9yKtPnNxf/h5SzY4hB8Z51vIx1raJFgg8t8wH
         OrbpXQwrNdnju3ZJZUqeT+jS1FRfZgD/jl8lAqGZJ5SzyIqeYiY4xWTE7AnZ8sOMbZxF
         B3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828635; x=1721433435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VBhxle6QEdRgy+LXsQtUVeYiw0Y7V3wixvog2TxeJI=;
        b=exlpIEaCZCzxMlVvVNbZeHz/fBbii8PZ+BnIXHeIetZdpVL10dANZzHCq11vJwUkof
         +lhW1yXPiD6r0CcfbXoaPV1fAaJIigR17uNYdWf7D5Eudo6g9wXuWK7GM3V7/SV6/s5K
         AjPSMa1raTJ+5MgxQ3m363yBI/Nv7c3vkv1wSP33VD2O8ZhIkxqXs+lV9dMbJOhiIORE
         GmYUOrd2OCb1ZRiqSwoulC8JoaCabNSdPHYsOHfzVwqbq/8TCeytz7MEhrAuf4rBrBGE
         ltCGn6MBOmTWN3X14fPDtgC/sGeBoViSe6gkEGHwDJHhnty/E0MOOSIpHWJeBlSFD61i
         QZVw==
X-Forwarded-Encrypted: i=1; AJvYcCX/z905lZnYedF3wruZjriNozECMsWqY+L95LU4TFapQoNcSiwhDoO3jW1ccyn1ALc75i4ZY1qqFKYaXFlrctmhzMGmqOvbetP23ZQB
X-Gm-Message-State: AOJu0YyFPx51Bd+KVLRChEsbnPsw/fd7RpIt/vamkINhZbm7CDuzOcPE
	YWsJZH4L5sHux+hvdEsyFomEfmfr9yfSO9LLV5NekXYaBY6qSVttDDMIxjiiYqQ105kfGAyyIlE
	wgA==
X-Google-Smtp-Source: AGHT+IEjfwLNTxah+0UFm8gqdtBQzZzDeGTx0qOM1AN4Q/JVfXWdikQSi6Gmg3zLzkGqToRJskKjZTe7BgU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:3cfa:1aa9 with SMTP id
 3f1490d57ef6-e041b1134afmr28281276.8.1720828635635; Fri, 12 Jul 2024 16:57:15
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:56 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: PMU changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A small collection of PMU cleanups.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pmu-6.11

for you to fetch changes up to f287bef6ddc208cae49c8d3833aeecda47872608:

  KVM: x86/pmu: Introduce distinct macros for GP/fixed counter max number (2024-06-28 09:12:16 -0700)

----------------------------------------------------------------
KVM x86/pmu changes for 6.11

 - Don't advertise IA32_PERF_GLOBAL_OVF_CTRL as an MSR-to-be-saved, as it reads
   '0' and writes from userspace are ignored.

 - Update to the newfangled Intel CPU FMS infrastructure.

 - Use macros instead of open-coded literals to clean up KVM's manipulation of
   FIXED_CTR_CTRL MSRs.

----------------------------------------------------------------
Dapeng Mi (3):
      KVM: x86/pmu: Change ambiguous _mask suffix to _rsvd in kvm_pmu
      KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
      KVM: x86/pmu: Introduce distinct macros for GP/fixed counter max number

Jim Mattson (1):
      KVM: x86: Remove IA32_PERF_GLOBAL_OVF_CTRL from KVM_GET_MSR_INDEX_LIST

Sean Christopherson (1):
      KVM: x86/pmu: Add a helper to enable bits in FIXED_CTR_CTRL

Tony Luck (2):
      KVM: x86/pmu: Switch to new Intel CPU model defines
      KVM: VMX: Switch to new Intel CPU model infrastructure

 arch/x86/include/asm/kvm_host.h | 30 +++++++++++++-----------
 arch/x86/kvm/pmu.c              | 36 ++++++++++++++--------------
 arch/x86/kvm/pmu.h              | 10 ++++----
 arch/x86/kvm/svm/pmu.c          | 11 ++++-----
 arch/x86/kvm/vmx/pmu_intel.c    | 52 +++++++++++++++++++++++------------------
 arch/x86/kvm/vmx/vmx.c          | 20 +++++++---------
 arch/x86/kvm/x86.c              | 17 ++++++++------
 7 files changed, 94 insertions(+), 82 deletions(-)

