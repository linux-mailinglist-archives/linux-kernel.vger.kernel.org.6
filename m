Return-Path: <linux-kernel+bounces-176311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE98C2DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4EB1F22F81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114A17EB83;
	Fri, 10 May 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE4sJ5nE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805317BB15
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385072; cv=none; b=CY600d6YvhEl4IQgoVpVWy+Ur20qJB5VxgpLodO08ARYeeTV6SPJFm9OsBAU3RLgMfMiTHaZTC1JJ/4UdVxOZ/LA6whaiXXOCBR66+JugI2fHSm5jv11sBpmQSTRm/sdH8ZKun3ioxQeO1J7r3YbQFLi3KhIVFp6LRlX19Rj9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385072; c=relaxed/simple;
	bh=T0wVo1wXvWe8ytX6MGdiHwIoOQJ74v8DOKvii+EjS9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOyrZN2KVsoxv+sr54q/FPiQLSYJ61Tbs8BuMRDtJYhGgTDnScQmSp1zf4WuTtTKt/cjwVMV8jcv3urjjuFCiScJnFygixQd9U+Fa1xNSJKtXJZo/ejyJFE3i3vZ8jlgHap6FSbJnH6wdM1NWX2jfnSeShi34eCcWjadTSHbQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TE4sJ5nE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so4346302276.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715385070; x=1715989870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=d+ECv8dHV8OhTCfj4K3yI3ukOFgKkrhitQiLiv2Tb+o=;
        b=TE4sJ5nEIFa5sB90jjhpyOmPBT/YLIrXY3oxh9OF2ut8aVafWpDG6XekDmS/K18O/R
         GbKSqn1D+U5SKWFpSI2aN5ACzw5xoC4X511vxImapm52zFyn+ZChFSVWXEwpEq2th73l
         HSkhwc0lQ53paDpdl4pEyV9ZRDHtsGUwsMeJePNwP09Pg5RWMyzWO/N0akByBv1FUe3V
         y7Ak7kqc9PxsVRy4RxdkleZkQ2foB+wYu+WsBXfJQ2EnwN4Re4eeUAaXxht6SBwQolWF
         3niV4zjljP5BqOCOoy4NGf2WiFeV7aLGF9LlfzJrdOT7ULb/ah1A8ditC75ceXpV1VO1
         XpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715385070; x=1715989870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+ECv8dHV8OhTCfj4K3yI3ukOFgKkrhitQiLiv2Tb+o=;
        b=Wtz80cbQVjGXA/L7WxQ2zxc+oSvNPsM9s7FRLpnp9pjD+Fpf/WJ4R8ZG6lg6Q84jDp
         mApZzw60Su7OXNNtE+ZgCG25bOm1XNWjZi9vInklrMlDEp7zJdeGkOcYZmTSP2krM6fw
         VYhE+kn3Wbxq7l8jM22IPsmjWkzkb/FlgjZ8lM9ahIfSgAay/nSs1O2qUFvUlgc5QX5L
         cRHsBtFVITuL8pg51xkOWsTduUEL9ThfBk6z7019/0Qte3TpnSKX8F45nPySm5HJYr+t
         A53ZdQI0x5H0vEtH2v/+M6Lfp6Jdv3khua0aEHo7bxcZMmF8JjhRvAN64B2pPuvMwkIc
         Z3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ixyb+4y8kQ5ZeyMr/iY81xgfEVy4M5V+GpJh7prV5PGaSIFK1Q31kOUgNfXrLYXCCTh8g3dDA7E/Iknu6fGzvogxZEzRdddhyb/v
X-Gm-Message-State: AOJu0YzgRJgdIR/6x5ie5QoBqJd+MzcpyaYMWtdtzowm7UxSnw9WsXVz
	NYmdtQqAIkV5lMOjGuzAFAvGcwgsuFjO1zUPJ9gexDCiL+Oa/mLdz2T1VXs6lg+urEa8KbFEjaO
	8pg==
X-Google-Smtp-Source: AGHT+IHgoNFKDOWfJIGqO90viZo9MWPYb/vJltDGPl2sayOnNc/ezO04aEjlW/atuSsSw/nvlbabSxpDnAQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d8d5:0:b0:dcc:50ca:e153 with SMTP id
 3f1490d57ef6-dee4f304739mr990122276.7.1715385069943; Fri, 10 May 2024
 16:51:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 May 2024 16:50:51 -0700
In-Reply-To: <20240510235055.2811352-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510235055.2811352-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510235055.2811352-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 6.10
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Minor fixes related to EXIT_QUALIFICATION and EPT Misconfigs.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.10

for you to fetch changes up to 23ffe4bbf807c34cd5374f3e53196ccc459707f4:

  KVM: nVMX: Add a sanity check that nested PML Full stems from EPT Violations (2024-04-09 10:24:36 -0700)

----------------------------------------------------------------
KVM VMX changes for 6.10:

 - Clear vmcs.EXIT_QUALIFICATION when synthesizing an EPT Misconfig VM-Exit to
   L1, as per the SDM.

 - Move kvm_vcpu_arch's exit_qualification into x86_exception, as the field is
   used only when synthesizing nested EPT violation, i.e. it's not the vCPU's
   "real" exit_qualification, which is tracked elsewhere.

 - Add a sanity check to assert that EPT Violations are the only sources of
   nested PML Full VM-Exits.

----------------------------------------------------------------
Sean Christopherson (3):
      KVM: nVMX: Clear EXIT_QUALIFICATION when injecting an EPT Misconfig
      KVM: x86: Move nEPT exit_qualification field from kvm_vcpu_arch to x86_exception
      KVM: nVMX: Add a sanity check that nested PML Full stems from EPT Violations

 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  | 14 +++++++-------
 arch/x86/kvm/vmx/nested.c       | 30 ++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.c          |  2 --
 5 files changed, 34 insertions(+), 16 deletions(-)

