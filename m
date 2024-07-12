Return-Path: <linux-kernel+bounces-251248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E493029C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAEC282FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60710148314;
	Fri, 12 Jul 2024 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYFY0IiS"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7113DDA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828645; cv=none; b=PdjWTqWFyOLCtIAGdcH7b4uRL55TR7TunqNPmWNl30FbY2tv4Vf7J60BtiJkuFo6WcWzi081miJJzqs6zt1vMw89X6DQ+mm0vQfPXedFQbdeNyGft2t9pLT+CMxeHzS0D9t7KnXLxm0H5UVF64zk2t63m+jz0ImWPNMQJKWSjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828645; c=relaxed/simple;
	bh=eq1JA2ePxM3mjEul2G7fb81NyoBUjXUxYq+DZmBNYxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c07HkHJ532Ua+o33iJeHGs2qNegNjER4eXbolTOrls9tNtmTuv69airomwevhpwshqIs4eHwL4g25VfX0t/DwpFFaA1WFe+rvE1N3m7BXcuMzFPScgvAW7kR+kARE6oaFTWFk7JxYs7MIWCDy0866Z0jkn952x5eGS/A/qhtVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYFY0IiS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-78e08ce33d0so33244a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828643; x=1721433443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J3xHAvdZdvAD9Iu41FwIbpRFkFLc9qVBDxI9JyPGo9U=;
        b=RYFY0IiSEC5hNIMa19QYzRIOD4QQi/5qmkVTqGdUDCwwvlFdX1aR0Qr2YRl3rEy7d9
         a2tG0LBcyg2eZUDdp7RuMfO3SmXTADp72R8y5YPGKKiNR76QUVCPqrFrbbzG2XsBmk1z
         q20P+yGY5BBKRKQLjwCxLy5gBu7kYM4nMoVyFwfFnmw1zhnkOS/m7x6Iy6Y6eDFQ8MJF
         bCv8bQ5mi91BTkYe/26mDhQ/0Kecs5zw0+NYAJfe71G4O/ESV1m2riroBvmgUeXmhRAq
         u2fPEr9DitOUTwsdQQwwu9cw926WIfCC/DU6XMx5AbqteLsX3RFZPiWUM+B97SbTy5Sc
         uYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828643; x=1721433443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3xHAvdZdvAD9Iu41FwIbpRFkFLc9qVBDxI9JyPGo9U=;
        b=NRliUbBsiMl+e5fBzq4cB9dy6pGt/WG1DeEGUoastS+hg7SPyBqsWnYYtP11gDuk2K
         cG8oN3nczJy6fKFQaIvCA+NVgCYtfHTDmUCoKvS2S3WasXMoUnKESNEfvc3j5SLxitsw
         9BgtA1WR65Lv7KmxhHkrTsUlLjd145UyFPlp5GI3w3rIV+nPWYLG8VI91LRr5T5YlgIn
         d+aj6iH7ANLrMkNont1MWKinKk0S7k/mpdLXru2fx3g7s+dMYKrkbvMRExlNWi1BB4NM
         aZzbYezO6g3LDkvH2MttHG5ZJl4k0fWtNQCatkFsBxdkZnVDjqKf3uOJsf2RRTLNQY9j
         +ESQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNMBaFHKTXtUT2NphEURQwbhmE1rUo5AcjJ3MspyCJjCNOgUBYHTxQ/bmnx08t6wVuWlHJd1QOGvhPSMb5DlUjjTbmGP6eUHKPqWHn
X-Gm-Message-State: AOJu0Yx/CGeyYQeE4Q413F3uG4wtc80bMXqFps/E39hD7MISgTdBl1RT
	ACI6xR3I0HI6CjbRwU99S65T1u+fPhHwinLMbzB5bGBIrlrkvjSIb0EGA3QCjMwiqSVsLttEeNP
	gsg==
X-Google-Smtp-Source: AGHT+IGQLs5O0L5JBnEXbmG2mFVWmRhyKv+IQIuD+etowp4fU28KaYUZKP5dZMlkROFbq3MMtiwqQ6gmtI0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:fd8:b0:75f:3d6e:6461 with SMTP id
 41be03b00d2f7-77db673ee4dmr24530a12.6.1720828643559; Fri, 12 Jul 2024
 16:57:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:57:00 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-11-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The highlight is a largish series to fix nested posted interrupt detection.
The series hasn't gotten any reviews, so if you have time to take a closer look,
it would be appreciated.

The following changes since commit 02b0d3b9d4dd1ef76b3e8c63175f1ae9ff392313:

  Merge branch 'kvm-6.10-fixes' into HEAD (2024-06-20 17:31:50 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.11

for you to fetch changes up to 45405155d876c326da89162b8173b8cc9ab7ed75:

  KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject (2024-06-28 08:59:07 -0700)

----------------------------------------------------------------
KVM VMX changes for 6.11

 - Remove an unnecessary EPT TLB flush when enabling hardware.

 - Fix a series of bugs that cause KVM to fail to detect nested pending posted
   interrupts as valid wake eents for a vCPU executing HLT in L2 (with
   HLT-exiting disable by L1).

 - Misc cleanups

----------------------------------------------------------------
Kai Huang (1):
      KVM: VMX: Switch __vmx_exit() and kvm_x86_vendor_exit() in vmx_exit()

Sean Christopherson (8):
      KVM: nVMX: Update VMCS12_REVISION comment to state it should never change
      KVM: VMX: Remove unnecessary INVEPT[GLOBAL] from hardware enable path
      KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector
      KVM: nVMX: Request immediate exit iff pending nested event needs injection
      KVM: VMX: Split out the non-virtualization part of vmx_interrupt_blocked()
      KVM: nVMX: Check for pending posted interrupts when looking for nested events
      KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
      KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject

 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 +--
 arch/x86/kvm/vmx/main.c            |  1 -
 arch/x86/kvm/vmx/nested.c          | 47 ++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/posted_intr.h     | 10 ++++++++
 arch/x86/kvm/vmx/vmcs12.h          | 14 +++++++-----
 arch/x86/kvm/vmx/vmx.c             | 38 ++++++++----------------------
 arch/x86/kvm/vmx/vmx.h             |  1 +
 arch/x86/kvm/vmx/x86_ops.h         |  1 -
 arch/x86/kvm/x86.c                 | 19 ++++++---------
 10 files changed, 79 insertions(+), 56 deletions(-)

