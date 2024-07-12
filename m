Return-Path: <linux-kernel+bounces-251246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D737C930297
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CF3282FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE113D24E;
	Fri, 12 Jul 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVB2k3qX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BD134414
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828642; cv=none; b=YRVjZIlf5kZHQf8mko8SgpYhmQdOtzC/16aroL6jbHBLdvCTktbCxaxL3kdkymXmv8WbwL6bLnxoPD9bih+DdafvAAeGE/9868Y4m6ZOE0sKVZb3GocjgR/IX3xuJyADtvlS8bhfu2BJsnc35kh/8h/czH2VXSBeTp2Mc3GIeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828642; c=relaxed/simple;
	bh=Wr2h5A42P94pdCqPl9/PjT045Er8Omv8AATJmSj6YqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M11YYhr2rA7Q9M/rwdmGv0QdXcK+HEUdIzZsvilBpQGT8cScn+UxJL/xRoembCMIDUKUsHxbK8ysIoyTT1l4LPecqDj6DDQ5iDRJhHWk6VmhHI04f/EasjKFZVCvDZZStYrVuamFtM+AjRk7/43miE21eACFolIY5w5gC4+tDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVB2k3qX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650b621f4cdso41420517b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828639; x=1721433439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0aVSPRfxF0sXEPqrPlgXmebj7I67TFWz+QkySkarfYo=;
        b=XVB2k3qXAYXwgAQGn7r8wA3SyHzrFX/ofnIdAX2tN7y6kxnEP6AtReNBbtosqfuahP
         ix/jCAJ6HrY7hls9gpG+cNdLhH0RD3Tmhw085DQwBKC8eYdpvP4ZgP08VHSTZrTihA34
         wJAddDoVjXTdigBjCELGXA6hMHenQhyKYCBkphefrtDp/qqqF8JWqUbrkVk/MDJ7aAoR
         clDtm+arZT8yTaU1bPqgOLyGtNCv2p+Plv3pNs8nvEb7a2YMCKbc2FRJhPypYrfNG0NU
         sIhouR0pfj8AwMa/88m7IjpxhE/iWBrQH5CNagVR9HWHjdODodH6oxZx83Sh/yqPSMSK
         rBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828639; x=1721433439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aVSPRfxF0sXEPqrPlgXmebj7I67TFWz+QkySkarfYo=;
        b=p3Azg1cu/gmh/PzG9jsTvzqEm/+gecXrlAP886wIzjnoPocnOn/wUBFfBTCJB3IsJg
         ASMKkh7EFyxI/3Yrdi2Y/Q+sewdqCeluG5ZYEJCX1/2/24D/tOFxn5tyFyKVbGobd3pk
         p0xYJSvTRVFQWXtdDWvQAQnhhtbSjzhbNY02P9lmQsp+WoikT2t/yw4BBOPRmOaFGRRm
         Oh28vNIQEArKGP7S61BzFtobM5uRoq6YJEhP7xjKv7+Hw090ZAVJPf4hp2HMa2Qz+NkN
         cgFbuX6MaK1Gh1UV0toWYRwlFBlY0CUaCKIlkgtZZvQoEtThUw/UvN19C6m8/mgGtuh0
         /KyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvR7Rj2J4OOKro6gPvji30pesFY43tQTrznsnR////h3JhzEu2zsii2b+uF4xPK6lfHeXLlklEbOU5dYqmwfTKzef8ozOoN8dqH3Fs
X-Gm-Message-State: AOJu0YwIYBXwyYQYmQI4U8JnZNA064BiEYngRpzWdAKRIFRVzsIS/2mu
	/Ht9Eycd6TZwdLNuePjqHzuOv5h6LofQYMBBvfXpA62EEH/+IYKlKuXfJXv5HzTqiyoooTbZlLG
	QyA==
X-Google-Smtp-Source: AGHT+IFGWew0XmB9c0tC2o+YJi9cj8VDCzYYdxRJw0fL6BRr99o5BGwnOHpBqTEVJxovZl9ooyW1S6VaUXE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2e0d:b0:e03:2f90:e81d with SMTP id
 3f1490d57ef6-e041b14c989mr797370276.11.1720828639756; Fri, 12 Jul 2024
 16:57:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:58 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-9-seanjc@google.com>
Subject: [GIT PULL (sort of)] KVM: x86: Static call changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Here's a massage pull request for the static_call() changes, just in case you
want to go this route instead of applying patches directly after merging
everything else for 6.11 (it was easy to generate this).  If you want to go the
patches route, I'll post 'em next week.

The following changes since commit c1c8a908a5f4c372f8a8dca0501b56ffc8d260fe:

  Merge branch 'vmx' (2024-06-28 22:22:53 +0000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-static_calls-6.11

for you to fetch changes up to b528de209c858f61953023b405a4abbf9a9933da:

  KVM: x86/pmu: Add kvm_pmu_call() to simplify static calls of kvm_pmu_ops (2024-06-28 15:23:49 -0700)

----------------------------------------------------------------
KVM x86 static_call() cleanup for 6.11

Add kvm_x86_call() and kvm_pmu_call() wrappers for KVM's static_call() usage
to improve readability and make it easier to connect the calls to the vendor
implementations.

----------------------------------------------------------------
Wei Wang (3):
      KVM: x86: Replace static_call_cond() with static_call()
      KVM: x86: Introduce kvm_x86_call() to simplify static calls of kvm_x86_ops
      KVM: x86/pmu: Add kvm_pmu_call() to simplify static calls of kvm_pmu_ops

 arch/x86/include/asm/kvm_host.h |  11 +++--
 arch/x86/kvm/cpuid.c            |   2 +-
 arch/x86/kvm/hyperv.c           |   6 +--
 arch/x86/kvm/irq.c              |   2 +-
 arch/x86/kvm/kvm_cache_regs.h   |  10 ++---
 arch/x86/kvm/lapic.c            |  42 +++++++++---------
 arch/x86/kvm/lapic.h            |   2 +-
 arch/x86/kvm/mmu.h              |   6 +--
 arch/x86/kvm/mmu/mmu.c          |   6 +--
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/pmu.c              |  29 ++++++------
 arch/x86/kvm/smm.c              |  44 +++++++++---------
 arch/x86/kvm/trace.h            |  15 ++++---
 arch/x86/kvm/x86.c              | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
 arch/x86/kvm/x86.h              |   2 +-
 arch/x86/kvm/xen.c              |   4 +-
 16 files changed, 261 insertions(+), 248 deletions(-)

