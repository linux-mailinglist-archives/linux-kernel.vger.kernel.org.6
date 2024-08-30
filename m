Return-Path: <linux-kernel+bounces-309573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80826966CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333EF1F21BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0118E371;
	Fri, 30 Aug 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJpHnabf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EB18C033
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061249; cv=none; b=TZE3CXCLWeRnsHEc+Q2C4Z1Jl+sdymhJbQjnA9iQE3XXR/HdsAnf2FMkhiyNd+S8/SNc0VMcHB5a4tFJ2qZYSeeKyi03is9iqoNOYTmyJi0u3Q7Vy5HbegweUEtL2qQyUCfiU145AcuGf96t5PCT7/vkgOeVUF1ZdVAECuux2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061249; c=relaxed/simple;
	bh=M7iA6Og7rkscgShI8ugCJiyFV+diig6JJ6ihasK6GVo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f2OxxC5hDkn8cP2gntT/mpKF52ZS2qZBB8BkPxFuMFo6dnFb06aNcLxLp4ikdb46SEnkFZ0tY/WockgNQK1AnSo2UITn7IWtdMbwbOtYY5eE4oEq4K+gfNfybIyYrxOo5mdvKFkFa2jzn0w0Se5ZkOW2w6immoNfwNdCHDOBftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJpHnabf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8eedf001so312926276.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725061247; x=1725666047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzg5+H8KkNoQ/oaD/mZ9dMAx+MaTWuSVzn0ffSsgaXc=;
        b=dJpHnabfpXmQhFh4iC9/5+f2PL7Dq9xsZT2Ye+7wjc1KnzqiemzJaOPt7vyKAA0Na0
         HX2wESe/fAhtgebFKLjSx2V6IgO8fHIebTp1cbX7Kjhetj1wY+bg13HRqZrZT0aZlleF
         IwCYpPIlk1Tbcda8XANikLapEexFy8b9uY6hLHuRNP2YDDYUFBthXZrs9ACAFq0Ss8iF
         KpHxdzt7sOK1GliNOmwDnDa5FQoQuVcQo8hT/z21AS9k/lb/Kdfu8xgE+rYk2P87r3bt
         syREOCkUaW5zmLkR8KrEtX1NYhu/KNbEbb21xOefze2OJ4mKomtOub1NUHyHB5wDzHaU
         kHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725061247; x=1725666047;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzg5+H8KkNoQ/oaD/mZ9dMAx+MaTWuSVzn0ffSsgaXc=;
        b=M8m6WCjTHo4yRU2QWGfypjiaYM77T/BnKTbUdLvWx00G7J64xBZDG5RewiH+F0SjIw
         RQb/Vk+pYjZEgWoT96h/uaB3CcCsHuRFV4jCKc9cEooGWdv9jCIIbROdKwmHm/z2Bpob
         J9K8up4WxGpjIm2GLOx2IJYwiEu7g/sQJV7Xq3TBmRK4UI82U8qbtEELjz7Haq7Zz7C7
         892lSnI0C2gBWtrTqpv2NTJFgO7yl0BZ4Mf+Xj002tIlqTc/7duEFd6hQgOTC2LpICWb
         M6abIci5eKTCN3hVk177MQdx+436W2g3+r0X2ouBQGEZ4w93dd4qgoGbSjk9VIJONY4j
         Qy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+EGX/6TNighu2s02SgO8nShbqmYa12Plj1kesrtJGoVNJmVns5XKkR27NuZZJdQn4H03lup2Y6ds/hXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2hkziQ6gcW0ZZDet5GERat0Wnca+PYPBrNtFX7/hE9ZseBa4
	hmgFZNpuMXxsJz+fdqfbmWAzW5Takh6JniQw/8KgS8q82TsMQcdfKYqgs2Cy3JKqlYEX/k1XcgE
	N1Q==
X-Google-Smtp-Source: AGHT+IFHGNIxU233H2j9s0EV/iSKYApQhaTCqlpgnaxkztZF5uywKsu0bHvHaA/yt91UoaCw96+3L5AbJv8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dc8c:0:b0:e11:712d:9af8 with SMTP id
 3f1490d57ef6-e1a79ffa017mr6085276.4.1725061246694; Fri, 30 Aug 2024 16:40:46
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 16:40:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830234042.322988-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Fixes for 6.11-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a handful of random fixes.  Details in the tag and changelogs.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.11-rcN

for you to fetch changes up to 5fa9f0480c7985e44e6ec32def0a395b768599cc:

  KVM: SEV: Update KVM_AMD_SEV Kconfig entry and mention SEV-SNP (2024-08-28 05:46:25 -0700)

----------------------------------------------------------------
KVM x86 fixes for 6.11

 - Fixup missed comments from the REMOVED_SPTE=>FROZEN_SPTE rename.

 - Ensure a root is successfully loaded when pre-faulting SPTEs.

 - Grab kvm->srcu when handling KVM_SET_VCPU_EVENTS to guard against accessing
   memslots if toggling SMM happens to force a VM-Exit.

 - Emulate MSR_{FS,GS}_BASE on SVM even though interception is always disabled,
   so that KVM does the right thing if KVM's emulator encounters {RD,WR}MSR.

 - Explicitly clear BUS_LOCK_DETECT from KVM's caps on AMD, as KVM doesn't yet
   virtualize BUS_LOCK_DETECT on AMD.

 - Cleanup the help message for CONFIG_KVM_AMD_SEV, and call out that KVM now
   supports SEV-SNP too.

----------------------------------------------------------------
Maxim Levitsky (1):
      KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_GS_BASE

Ravi Bangoria (1):
      KVM: SVM: Don't advertise Bus Lock Detect to guest if SVM support is missing

Sean Christopherson (2):
      KVM: x86/mmu: Check that root is valid/loaded when pre-faulting SPTEs
      KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Vitaly Kuznetsov (1):
      KVM: SEV: Update KVM_AMD_SEV Kconfig entry and mention SEV-SNP

Yan Zhao (1):
      KVM: x86/mmu: Fixup comments missed by the REMOVED_SPTE=>FROZEN_SPTE rename

 arch/x86/kvm/Kconfig       |  6 ++++--
 arch/x86/kvm/mmu/mmu.c     |  4 +++-
 arch/x86/kvm/mmu/spte.c    |  6 +++---
 arch/x86/kvm/mmu/spte.h    |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c |  8 ++++----
 arch/x86/kvm/svm/svm.c     | 15 +++++++++++++++
 arch/x86/kvm/x86.c         |  2 ++
 7 files changed, 32 insertions(+), 11 deletions(-)

