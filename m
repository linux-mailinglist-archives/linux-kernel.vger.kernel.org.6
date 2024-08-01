Return-Path: <linux-kernel+bounces-271736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FCD9452C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326C728288C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B052143883;
	Thu,  1 Aug 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAm4kLMe"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E97143881
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537299; cv=none; b=OP1pD2upJdfZZR68+RoST0lQA2pQA0CQlCWBa9ttN6A8mwY31lV9WDJmJcw6/hk6hCB/ZfhFDO8uyyAL3a/EkLpbg/2wt3fCsktIoRW2akRR0RJjqS0km4wgO52h5HVxpwccI6UWqq5G4pVmPBAMDe7ThzlR1u3TWF1LDtgkrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537299; c=relaxed/simple;
	bh=bJBBwTWOIhUdQKdD80wTHo1N63QWUZdpxgE15p1QpWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PZr3ivRTmJebfHgfXakHSzyjz5XYZjcMLCT1UYDKbptbvCqY67F6zZlwGTiDMv3teNk6yDo38h4YbRQSnj2pxzfYBvKCYjnZAYsYPbgIhOO5od829LGCiIp9e25sxZ6tqCKSqGRXS42Q8XrwfbYZSdElsuLj0cjPEQZNUUILMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAm4kLMe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7278c31e2acso6459752a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537296; x=1723142096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5EkBnRfWKwuX6kDL48Ot+VYn3mvhS1OzqZQ8BnW+y4=;
        b=rAm4kLMeTswEX+Qy/eSV3fBmjz1UxFh6ZrEgw0wfEPzJBzz2/jBy+ZGPL86CN58e6u
         0QDSueua4zOhpOILB6dDcafqVguT9U7eFfjxL7O+2k5iPy7tVd9zMtgBZnW4xm5oYSBX
         QFE/1VqbyVum4l17/vIrNYeLG0eRsXDz5MmO/INNpusXKxJ/SHYb+FnB22Cuuk/Krbfe
         /zSgeWoKaChtxK5amhx0MVVHEQnjUaXPcGTLEDmuhV4nWiYnJdsHMLXXfustGTXg+9ly
         K/4R1mYY6GM2jv3IYVsSLBBk1LWLwDaFsokJodsypplPgSuUIY4l0ejigsXq2aroWbMI
         aNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537296; x=1723142096;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5EkBnRfWKwuX6kDL48Ot+VYn3mvhS1OzqZQ8BnW+y4=;
        b=ByZTrGT+ehONpGBhnGNI7F5nhvksaD6JyYwlMYSx8bzRHs2QgnUuEhmR29HJ8/y0j9
         RRDnMkSpFqr/BN8/m8OWIZPgthMN3g3l15y2PO63bX6yhHWMvi+7au9TSCO1KQVMkIoZ
         njAZc+ugrT6wbQfhhgXouVPGBKOMUbt4xO8h4B05vwG5ZPG+0u/4z16nXxntPTxIxgA7
         1FpjaQf6A+cy+i3URj9ZajNwDfp7zrEiTbr32VOZvF7mxPSZ94CZxs42EWvVPyV5rko2
         +QuGUtVj5WFAmMd//V7eOLWDs4fk2VLK0N3VDMlsbEQ0mNxmtMhZakB8PrQG4mU2vV92
         ztCA==
X-Forwarded-Encrypted: i=1; AJvYcCWsVB8NTAUpiVYpNe6bBBoRWWfOaR5KrCvimwU+YAmVDfQOB0GsJnrsA2zvdLYwr39S1P8qmpZcLTpHoPG20KsVJTMIWnq4EzTcriAU
X-Gm-Message-State: AOJu0YxqWirRkaeVqHz0yozvs1mzBtfqtVWhXG4ogDJ8xQyS+v9Ammjl
	vySzYZR+DB4II3ClrX1XF6PgWKQgc5L9pxOWYzhrxSRuH/Jgh0VMqwwPovYjQEfoIga8OCLudIn
	TAA==
X-Google-Smtp-Source: AGHT+IFfJvKXPAF6nK7osNErDMb0tU9m4CZX5bmW6NnyQFFbG/iPCvr7Qm9PYR9AVkiifLTpXumq87WxKuE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:340c:0:b0:719:ae7d:9f2e with SMTP id
 41be03b00d2f7-7b746ba799fmr2825a12.2.1722537296466; Thu, 01 Aug 2024 11:34:56
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Aug 2024 11:34:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801183453.57199-1-seanjc@google.com>
Subject: [RFC PATCH 0/9] KVM: x86/mmu: Preserve Accessed bits on PROT changes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This applies on top of the massive "follow pfn" rework[*].  The gist is to
avoid losing accessed information, e.g. because NUMA balancing mucks with
PTEs, by preserving accessed state when KVM zaps SPTEs in response to
mmu_notifier invalidations that are for protection changes, e.g. PROT_NUMA.

RFC as I haven't done any testing to verify whether or not this has any
impact on page aging, let alone has _postivie_ impact.  Personally, I'm not
at all convinced that this is necessary outside of tests that care about
exact counts, e.g. KVM selftests.

That said, I do think patches 1-7 would be worth merging on their own.
Using A/D bits to track state even when A/D bits are disabled in hardware
is a nice cleanup.

[*] https://lore.kernel.org/all/20240726235234.228822-1-seanjc@google.com

Sean Christopherson (9):
  KVM: x86/mmu: Add a dedicated flag to track if A/D bits are globally
    enabled
  KVM: x86/mmu: Set shadow_accessed_mask for EPT even if A/D bits
    disabled
  KVM: x86/mmu: Set shadow_dirty_mask for EPT even if A/D bits disabled
  KVM: x86/mmu: Use Accessed bit even when _hardware_ A/D bits are
    disabled
  KVM: x86/mmu: Free up A/D bits in FROZEN_SPTE
  KVM: x86/mmu: Process only valid TDP MMU roots when aging a gfn range
  KVM: x86/mmu: Stop processing TDP MMU roots for test_age if young SPTE
    found
  KVM: Plumb mmu_notifier invalidation event type into arch code
  KVM: x86/mmu: Track SPTE accessed info across mmu_notifier PROT
    changes

 arch/x86/kvm/mmu/mmu.c     |  10 ++--
 arch/x86/kvm/mmu/spte.c    |  16 ++++--
 arch/x86/kvm/mmu/spte.h    |  39 +++++--------
 arch/x86/kvm/mmu/tdp_mmu.c | 113 +++++++++++++++++++++----------------
 include/linux/kvm_host.h   |   1 +
 virt/kvm/kvm_main.c        |   1 +
 6 files changed, 99 insertions(+), 81 deletions(-)


base-commit: 93a198738e0aeb3193ca39c9f01f66060b3c4910
-- 
2.46.0.rc1.232.g9752f9e123-goog


