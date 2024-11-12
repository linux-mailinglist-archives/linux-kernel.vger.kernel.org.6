Return-Path: <linux-kernel+bounces-406631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C59C6197
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97513283D62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1221C16A;
	Tue, 12 Nov 2024 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nxRqGRi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15421A71F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440029; cv=none; b=OKOE8MIVrBYPJiTtww66Y870PfIxFO0YRmkzNwF3ejAOvHkAmgulbxBKw8vatbt06E6LJ2dIfFjzVXKfgRsLNyQMupQICYcH5I1aJoNQA4l1zvLXhZGRTsXfhiwjA/u8PFXBrPf5EgAYq3o0Xr1NcWcgxyCdctEyMAQmAleqa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440029; c=relaxed/simple;
	bh=rGRQGaVkeNTMr7723Py7dGsNHKMw9os93jBVa6XX2nU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j2joONbmjCI1wnEtNrooGfuzYkBsgY9tJiGE1U+6EMMiK2MXzatxpjCt+brLp4/KxNfxPrgKRv8dDIJAgmDfNGFZNDzVrmdkdxYL2kyJ4dy2kmPthqe4bN9lEzqg/tHpw0HlPPvfP1rlGQWhroFgN5nPGR10QKdS9NJolqnhU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nxRqGRi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9d6636498so112862957b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440027; x=1732044827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vOXNel/OE6SCTojsAWsH0vUOvFMYMCscF7RREYP2rxA=;
        b=2nxRqGRiPWUtHAKGsXcY1De7Z62iyk98sUL2Pkjv4HI4KP7AU5HvLeVQDmcxZVFrGz
         c3n7O/s3EmULRp5gU/sQaT1uZJKwcTINNRi+Rs+8/6oh6wN7cCqxDtL9ba6C2riyVnvE
         2dYD+x7zJ1ZTTTonP4QQ99OQBBFj9zaPgZEpa3zGabGMIlO80aSxGfrMHg8NFdugGWdw
         b0GNRnwqsDxcdEoQpZ1sNwaQ5wpksrXtj+xO4zX+sCYmtnT4GX/PtPTlCLDtU4P4gPUQ
         WlHEVcqy1IqOMueg2glX2DQ0MdRv6aIwTX5Ti793HXa/BREVCBLbSHspD2q88oveY33t
         uVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440027; x=1732044827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOXNel/OE6SCTojsAWsH0vUOvFMYMCscF7RREYP2rxA=;
        b=YlGBhv51VTXPkVMbBCcEZSKSzmJS1DAQbvXdYTe6HE5g3Lsvus2hxUDvG5EzL7ZDkF
         BTxp6QOLDFREQVQRn/UlVIiXWiYKdX+QtHg2JPxdmAE8XBQ5KwovDMEKXb2zxELiOeIh
         yT2UAua4ZIgV/ZRtUR7jOg54u+BFRjtuiUezcXIgi50fVOWxDqw5HSVx6k98cD4H+B0M
         kgh7RSfKmtCkWbwP/Gu9kqt++qxJl36FcqBXYjOtPjh1m6nkOEvtHNHWECosPDOBKsNW
         At12MPIoksgtPkrLol6A6oNrhFuAsnLVf/VHYfU7zijnM1Lq+8TnUlRdLHYsdI9+ywas
         PxkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QnzZK42QhV4PJxOADIQBaMDRdra34Y3ZGUto1VGlZ9aSGqKk6e8oBZ/FwDCESvG8sUTobD0lk3Whllc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8IPeCiBh+q5eObFTXYjIxk1azjdJ9chg2oBfjhcBPoopVN4E
	n4cZ3jkNizG+w4MOvofd00SnF2v2AGfNN0VJmOodMQ1Yhlmj8RqKqn8ztImlOfzwrCJC6MvgSf4
	pMA==
X-Google-Smtp-Source: AGHT+IGe4gs4qKSqInLCaAC6+0PhDGaGqwLqvLDqaEmmWP/y5kw7zUUUlJH0ngeEghl0LrA8j/8p7dRepE4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1342:b0:e2b:da82:f695 with SMTP id
 3f1490d57ef6-e35ed2520d6mr109276.6.1731440026793; Tue, 12 Nov 2024 11:33:46
 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Nov 2024 11:33:33 -0800
In-Reply-To: <20241112193335.597514-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112193335.597514-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112193335.597514-4-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 6.13
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Aside from the A/D overhaul that you've already seen, the two highlights
are support for recovering TDP MMU huge pages in-place, and removal of KVM's
MMU shrinker (which IMO is long overdue).

The following changes since commit 5cb1659f412041e4780f2e8ee49b2e03728a2ba6:

  Merge branch 'kvm-no-struct-page' into HEAD (2024-10-25 13:38:16 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.13

for you to fetch changes up to 4cf20d42543cff8778f70b0c29def984098641a5:

  KVM: x86/mmu: Drop per-VM zapped_obsolete_pages list (2024-11-04 19:22:53 -0800)

----------------------------------------------------------------
KVM x86 MMU changes for 6.13

 - Cleanup KVM's handling of Accessed and Dirty bits to dedup code, improve
   documentation, harden against unexpected changes, and to simplify
   A/D-disabled MMUs by using the hardware-defined A/D bits to track if a
   PFN is Accessed and/or Dirty.

 - Elide TLB flushes when aging SPTEs, as has been done in x86's primary
   MMU for over 10 years.

 - Batch TLB flushes when zapping collapsible TDP MMU SPTEs, i.e. when
   dirty logging is toggled off, which reduces the time it takes to disable
   dirty logging by ~3x.

 - Recover huge pages in-place in the TDP MMU instead of zapping the SP
   and waiting until the page is re-accessed to create a huge mapping.
   Proactively installing huge pages can reduce vCPU jitter in extreme
   scenarios.

 - Remove support for (poorly) reclaiming page tables in shadow MMUs via
   the primary MMU's shrinker interface.

----------------------------------------------------------------
David Matlack (5):
      KVM: x86/mmu: Drop @max_level from kvm_mmu_max_mapping_level()
      KVM: x86/mmu: Batch TLB flushes when zapping collapsible TDP MMU SPTEs
      KVM: x86/mmu: Recover TDP MMU huge page mappings in-place instead of zapping
      KVM: x86/mmu: Rename make_huge_page_split_spte() to make_small_spte()
      KVM: x86/mmu: WARN if huge page recovery triggered during dirty logging

Sean Christopherson (21):
      KVM: x86/mmu: Flush remote TLBs iff MMU-writable flag is cleared from RO SPTE
      KVM: x86/mmu: Always set SPTE's dirty bit if it's created as writable
      KVM: x86/mmu: Fold all of make_spte()'s writable handling into one if-else
      KVM: x86/mmu: Don't force flush if SPTE update clears Accessed bit
      KVM: x86/mmu: Don't flush TLBs when clearing Dirty bit in shadow MMU
      KVM: x86/mmu: Drop ignored return value from kvm_tdp_mmu_clear_dirty_slot()
      KVM: x86/mmu: Fold mmu_spte_update_no_track() into mmu_spte_update()
      KVM: x86/mmu: WARN and flush if resolving a TDP MMU fault clears MMU-writable
      KVM: x86/mmu: Add a dedicated flag to track if A/D bits are globally enabled
      KVM: x86/mmu: Set shadow_accessed_mask for EPT even if A/D bits disabled
      KVM: x86/mmu: Set shadow_dirty_mask for EPT even if A/D bits disabled
      KVM: x86/mmu: Use Accessed bit even when _hardware_ A/D bits are disabled
      KVM: x86/mmu: Process only valid TDP MMU roots when aging a gfn range
      KVM: x86/mmu: Stop processing TDP MMU roots for test_age if young SPTE found
      KVM: x86/mmu: Dedup logic for detecting TLB flushes on leaf SPTE changes
      KVM: x86/mmu: Set Dirty bit for new SPTEs, even if _hardware_ A/D bits are disabled
      KVM: Allow arch code to elide TLB flushes when aging a young page
      KVM: x86: Don't emit TLB flushes when aging SPTEs for mmu_notifiers
      KVM: x86/mmu: Check yielded_gfn for forward progress iff resched is needed
      KVM: x86/mmu: Demote the WARN on yielded in xxx_cond_resched() to KVM_MMU_WARN_ON
      KVM: x86/mmu: Refactor TDP MMU iter need resched check

Vipin Sharma (2):
      KVM: x86/mmu: Remove KVM's MMU shrinker
      KVM: x86/mmu: Drop per-VM zapped_obsolete_pages list

 arch/x86/include/asm/kvm_host.h |   5 +-
 arch/x86/kvm/Kconfig            |   1 +
 arch/x86/kvm/mmu/mmu.c          | 201 ++++++-------------------------
 arch/x86/kvm/mmu/mmu_internal.h |   3 +-
 arch/x86/kvm/mmu/spte.c         |  99 +++++++++-------
 arch/x86/kvm/mmu/spte.h         |  76 ++++++------
 arch/x86/kvm/mmu/tdp_mmu.c      | 257 +++++++++++++++++++---------------------
 arch/x86/kvm/mmu/tdp_mmu.h      |   6 +-
 arch/x86/kvm/x86.c              |  18 ++-
 virt/kvm/Kconfig                |   4 +
 virt/kvm/kvm_main.c             |  20 +---
 11 files changed, 280 insertions(+), 410 deletions(-)

