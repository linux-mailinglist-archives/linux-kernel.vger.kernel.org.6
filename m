Return-Path: <linux-kernel+bounces-360360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D362F999A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6830C283AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950B1E9093;
	Fri, 11 Oct 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDK58HzU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC51E882D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612655; cv=none; b=el0pBuaRYTTerKzKevfztElccJ2Lum2ka5wNC/N5X60DcXfHzHJx8npGmRRJ2RxjKgcktM3Q65I7F6jQqmNH2ZkmmaIl1uJzMoCTAVUbZsS9r9FNqSlqxn3sqqvsfG0hMsc2+QU23VKkR+xJpUiiRFtvslPQKdhxHq8Mix8bGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612655; c=relaxed/simple;
	bh=zJSdJbBzdDiSwWhIJuRompQSetjqt4adgJuhI/CyVmc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZTlTWU7+LcSP2BVHv4VfbTpRUtcHsjMBWzQ4gK4fZmk2gmg3szL0ZWu9z9gsMgumGVQ+RgygGCTxQ2F24xFeLjZeqqM+mCA3s+A7iqT9zbxJTI3Zuw2NBjcWdfVIK65KJGLmhVb5cn26VXK23v+J5zRvJd2lbv6tHICTXf3ulRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDK58HzU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2baf2ff64so27799257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612652; x=1729217452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/FKyHqildhGZez+hgtXv2QUQsqoQKXeEoi9o/+C1cI=;
        b=zDK58HzU1qhD1/8FKtH63BV+Bv7zbnn3OYFEBpaiaaPzPapCfTBf56V7cNYKTpwMJX
         wmmWgZ9rIhnWoxpI1F2FmWEO1ZOmk9a834zEUEmM03ar73nf/PySKX1FlH7o/MuZ7yBy
         tX15jxDXD+cW3Jra3UvSuVlvGkDBLU731m9r7oN8uPnJd+lO/BfYK0Z2AqErHMwgHvca
         XWN8qoohcrdQ1Hfr0zAsM4Ma5eP0vaFTHw90AtvidbyWs+tZc4My7B8tBYqETbl7CwXR
         cxIEnWyLhjANZS7i0eGns/oNplznWiH0Mxr1NjoF1d243ZrisC4EZPdtej701xfLKGnP
         iAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612652; x=1729217452;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/FKyHqildhGZez+hgtXv2QUQsqoQKXeEoi9o/+C1cI=;
        b=GfKNpPqlF/isSWAZBT+DN5AfoXLQynoNlf9S3cNf6sNjZfEBhp+hAcFKWPTznskMt7
         ShRBKSLSXz+/SH0Q6iYc8fv7WfqO9XKo7aYHy8B/jP0daANyMpTbJu/s2MAR2M8pekg2
         qL2i5OezVSxoDmTUhbZp1t43RFUaOuRDH1H29LAX8cvqCT/HX4SvpbMOfptI2axssFv3
         /LcIIpA74wdLfuIRSHNEiiBsSLdmmPgMhMe53UitX8Qj4vw7oQo3rv6sYnSgqXLzCh9t
         pgymooPXQjtk3nBFD2QCStmlYBrMX6NtwiF7hXMV/XB8wRYemhWNO2C5Rrvd79xTzLC4
         zn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWDhkWtw2T9E3PSCR17Un0uUIbAJr50fZfrfnAZk8huQZipfOY0NT1AGIZg7oQvsUBhkiHJXwcWYDBB9Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMdrc3C5iKb3u890lMNPg58Zbf1cpp6+BkqI8NGqWvCzm9oY1
	cSUsp/3YzTdLk+U62Teg30upq/7dVwOZILYaLXZ7MgDUKgKgc9toV+E37hmn2dSSl+GLLg7ezj7
	z3Q==
X-Google-Smtp-Source: AGHT+IE0XX2WG+FjtezTqk/Tu6H3cMoEAQgdFOILW3CZ3tEJw12RJ2BlCsXz43TWSq3961vu0dEm9hLeyFQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4982:b0:6dd:bcce:7cd4 with SMTP id
 00721157ae682-6e3477b4505mr376497b3.2.1728612652667; Thu, 10 Oct 2024
 19:10:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-1-seanjc@google.com>
Subject: [PATCH 00/18] KVM: x86/mmu: A/D cleanups (on top of kvm_follow_pfn)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

This is effectively an extensive of the kvm_follow_pfn series[*] (and
applies on top of said series), but is x86-specific and is *almost*
entirely related to Accessed and Dirty bits.

There's no central theme beyond cleaning up things that were discovered
when digging deep for the kvm_follow_pfn overhaul, and to a lesser extent
the series to add MGLRU support in KVM x86.

[*] https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com

Sean Christopherson (18):
  KVM: x86/mmu: Flush remote TLBs iff MMU-writable flag is cleared from
    RO SPTE
  KVM: x86/mmu: Always set SPTE's dirty bit if it's created as writable
  KVM: x86/mmu: Fold all of make_spte()'s writable handling into one
    if-else
  KVM: x86/mmu: Don't force flush if SPTE update clears Accessed bit
  KVM: x86/mmu: Don't flush TLBs when clearing Dirty bit in shadow MMU
  KVM: x86/mmu: Drop ignored return value from
    kvm_tdp_mmu_clear_dirty_slot()
  KVM: x86/mmu: Fold mmu_spte_update_no_track() into mmu_spte_update()
  KVM: x86/mmu: WARN and flush if resolving a TDP MMU fault clears
    MMU-writable
  KVM: x86/mmu: Add a dedicated flag to track if A/D bits are globally
    enabled
  KVM: x86/mmu: Set shadow_accessed_mask for EPT even if A/D bits
    disabled
  KVM: x86/mmu: Set shadow_dirty_mask for EPT even if A/D bits disabled
  KVM: x86/mmu: Use Accessed bit even when _hardware_ A/D bits are
    disabled
  KVM: x86/mmu: Process only valid TDP MMU roots when aging a gfn range
  KVM: x86/mmu: Stop processing TDP MMU roots for test_age if young SPTE
    found
  KVM: x86/mmu: Dedup logic for detecting TLB flushes on leaf SPTE
    changes
  KVM: x86/mmu: Set Dirty bit for new SPTEs, even if _hardware_ A/D bits
    are disabled
  KVM: Allow arch code to elide TLB flushes when aging a young page
  KVM: x86: Don't emit TLB flushes when aging SPTEs for mmu_notifiers

 arch/x86/kvm/Kconfig       |   1 +
 arch/x86/kvm/mmu/mmu.c     |  72 +++++++-----------------
 arch/x86/kvm/mmu/spte.c    |  59 ++++++++------------
 arch/x86/kvm/mmu/spte.h    |  72 ++++++++++++------------
 arch/x86/kvm/mmu/tdp_mmu.c | 109 +++++++++++++++++--------------------
 arch/x86/kvm/mmu/tdp_mmu.h |   2 +-
 virt/kvm/Kconfig           |   4 ++
 virt/kvm/kvm_main.c        |  20 ++-----
 8 files changed, 142 insertions(+), 197 deletions(-)


base-commit: 3f9cf3d569fdf7fb451294b636991291965573ce
-- 
2.47.0.rc1.288.g06298d1525-goog


