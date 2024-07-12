Return-Path: <linux-kernel+bounces-251242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C758693028F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA751F226A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B241386DF;
	Fri, 12 Jul 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0HThBE4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08E137767
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828634; cv=none; b=BKEa+dNRgDCWBTPhwodd1B8P3F6oP0H5OPl/OG5BP9G2ulvRJlHVxXakcKvhIwCwwqgqHRjRmbNxQsZgtekyzLmym5QCKrT6eexq+478Vnn4lOq03tBEkXgEgNoglZei8N6gw+zI5OXGU6e0WZSvpIzPGe2u3yu59PlYWUI0EwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828634; c=relaxed/simple;
	bh=1tc/SxgnGQzs/wfQKgsplyHPjx9j9umDf1cy6BRBm/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tS7CzxwWf//Z4Fl3tYM56enuavyH5Ci+nWbcf6St8BiEGKQspeSQdGZfxIAYLVVQZ2jFxkZzRebG/sLqqq5iY/GHRpvlzjjc61Xr5DSk0Wvujr21IwDJswL8wq3mmFEBBN1PKducm883d0xfqdIzrY2qr2O7nkvggTIc7mF+VAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0HThBE4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso1859554a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828632; x=1721433432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LPdW5y0JyvKpaTGQ10x+xv6Pv2kVXNdt0axaqxmhT+Y=;
        b=U0HThBE4aAOB8duHJizN/fd+SZV7Ey5SANY+mWuKf15vQLtw4h0tGvDxV1MUsrAjYB
         BidNHC5E2DQfgp79ND2Ad3gpAMM3KvwXlBEtRTpn3GFJqnlhEBqJDB0hSPP2jnLLWAFv
         fb6JFYUJYwifp0pPBD3QrhOPGgPIc7UmkLrcsxPXuaaTx5EP3pPjRMA/d0gguOQdTT0U
         /iFDAHm+hOlIuRnkAZbpLTdguzaCMxhjU7m81fqoA9gCAFtGtQ6iwouVe08HXoxFv0E0
         PoAPLKI/Dfvk6LbJ5G7lZ69tV6PlZ+M5IBFl8rQcSXrY9lGAKmUi9dYa9DpZ16QAZlvm
         j6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828632; x=1721433432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPdW5y0JyvKpaTGQ10x+xv6Pv2kVXNdt0axaqxmhT+Y=;
        b=AWUcWg5Eg+/WUw3+3ys9VbvqJqV36EvkF5e7fgXyYKQXGFLGfnijUh5yubhShA7A+6
         FhIOC4HzH2/YDXxFAtIzYQqxUSwI8ZHuYRnzvsTcI7iqeRyYbx3LaK5g1NkEq7F2qOGG
         /PSfBh5rcZj4iba8BtDwPlAA5jvA3slf8sqZI5Jm1ocylJpYEtvigvnPLYXX/3rNvunp
         PuNhAKH3UczOIYMrXlIyC6U0yWqshH5MoMOxx680SNMdzzTiqZymnUH+0nant2xnsvvq
         ZpWnN4MlnnoW4IjBiJonRdNq1l/II3E53MNLn1dC7N+a+86XqPXhQnnfea3tk3hxvqUH
         6GMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWePfW6L7HoF7yRM7KaOcRJ/b5KCxQtlHv9448wQhJze3T/cj1sC7qTWpsz6xdBt5DvI51d87mmMc9vJySFXPPKevg5zd3vfq0pj6RB
X-Gm-Message-State: AOJu0Yyncp2daJpxgp6ho4hE0fvrTgeKIOSjYGaPBag0/HpYA2jZHDva
	D6maVM9sXFsMw24BeQNJNVdPzQ8aP/5xki/Le/vmtVWnD7O8k4v4cE+01YCVoZWl7wH4gJUNHxM
	zgg==
X-Google-Smtp-Source: AGHT+IGfR1Xzo3E60ZmaVC6PTp9lLtuRsOsi3lkFYdmCRlW4PvFCYaeBL4UD9MNG3P7Wwb2nGk6v4XuGmoQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6789:0:b0:6e3:a2ac:efd4 with SMTP id
 41be03b00d2f7-78a0e532eaemr8743a12.6.1720828631848; Fri, 12 Jul 2024 16:57:11
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:54 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

I got nothing for this one.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.11

for you to fetch changes up to 0089c055b56024edf90e85dc852440b713ce8cb5:

  KVM: x86/mmu: Avoid reacquiring RCU if TDP MMU fails to allocate an SP (2024-06-14 09:25:03 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 6.11

 - Don't allocate kvm_mmu_page.shadowed_translation for shadow pages that can't
   hole leafs SPTEs.

 - Unconditionally drop mmu_lock when allocating TDP MMU page tables for eager
   page splitting to avoid stalling vCPUs when splitting huge pages.

 - Misc cleanups

----------------------------------------------------------------
David Matlack (4):
      KVM: x86/mmu: Always drop mmu_lock to allocate TDP MMU SPs for eager splitting
      KVM: x86/mmu: Hard code GFP flags for TDP MMU eager split allocations
      KVM: x86/mmu: Unnest TDP MMU helpers that allocate SPs for eager splitting
      KVM: x86/mmu: Avoid reacquiring RCU if TDP MMU fails to allocate an SP

Hou Wenlong (1):
      KVM: x86/mmu: Only allocate shadowed translation cache for sp->role.level <= KVM_MAX_HUGEPAGE_LEVEL

Liang Chen (1):
      KVM: x86: invalid_list not used anymore in mmu_shrink_scan

Sean Christopherson (1):
      KVM: x86/mmu: Rephrase comment about synthetic PFERR flags in #PF handler

 arch/x86/kvm/mmu/mmu.c         | 17 ++++-----
 arch/x86/kvm/mmu/paging_tmpl.h |  3 +-
 arch/x86/kvm/mmu/tdp_mmu.c     | 78 +++++++++++++-----------------------------
 3 files changed, 35 insertions(+), 63 deletions(-)

