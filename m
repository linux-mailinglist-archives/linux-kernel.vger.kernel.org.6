Return-Path: <linux-kernel+bounces-341896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5489887E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1541F21CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F81C1722;
	Fri, 27 Sep 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tg/QpMHE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907F142621
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449587; cv=none; b=cX8/jLGscLOiBi9e5DcOSrfcUggXKMIWSv6VV6Oo762AhynwBmwGKs38pTz+j72JnQX2Sge4LqtB7wDecqexTHfGnM2Es+JD4x0pVu8CLBHGUNDXNw5nZ0jVawg26hPUlQA0UQ9YbL3SLVdHUt4qRWsqY33wyf9PU3+SVUgH/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449587; c=relaxed/simple;
	bh=MhvHlb41uB3vtMebx6w3rvKTSexye7N1XKBFVEm6Bl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uH2s2h6tjos+yO4D0PBb64mtzLN1RA3TmbYn7sDI4OaDkokYNq6WYg//83YDpG4oqGxKTfeBEdkRM8OsTLgN0neDjNU8526nwf+CdcINW4tHIo6h8vumk30Bd46KTrdOP0vvV+nFchbaJhGX4zeoOElQ8mLXcecxlLC3Wdw4Xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tg/QpMHE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20937a68bso47285077b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727449584; x=1728054384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6R06oOXx1S8ejEMrplXTXPe+qhgQnWUqDVaBNXxtoE=;
        b=tg/QpMHEYzIYrWOZPiVV9swD7gBaBqWkdV6zUBf2dyKExyvN7kMSAUOEebg2KBUU5+
         MKeSnBRsquXrFJaH0IVMs3DnEQnXHgAPgpWRat0J26QFSmXkgdkgLCsAMZMwxCDbSt73
         BSOeWpdxNTrbbk8sZxb3dfT6TsCotQK+eCGv6UW2hBhYucIWS6GkaqgCOKnLazI4Fidz
         3sR857OaUhjNgTq3kAOWRsN+4IpT9TtEm3BT1uQZAz8H76kMrF0/ZHT7bhdLa2nxtCDk
         3VYy+WqprbzA6qC/A42Boz0oIb04c38i+Broy2Ljkwo+eCB+d0lk9L3XvHcWTw6Lz7aV
         2fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449584; x=1728054384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6R06oOXx1S8ejEMrplXTXPe+qhgQnWUqDVaBNXxtoE=;
        b=MchgvdX/gXNoiJC7mAeTUkiA5u01FLDYUYt2QBUUI54CFd0g5H9xOozFRhUyCHW4FD
         AdfnHEjxfvu1XrG/LU3nsiK85sIpQTM3ImBo2KOj63TaQr6N7noBuqUzboKIl6TmDrNo
         Q2Bcthvw1SGinYjcwcJO/6+i52HDrLvllFdDHHziZ+OoE7EQTHtdgXvhcl4qEl0rZyvi
         0PiBrvOzCxBixsOqiliQjhv8Ur0rLLs0dhRbFfltuUzTG4bt4+13pyXKGC3hKGX7oPcY
         m0YvDsmxo7+pcUIADmXPYaUILt5QT2bdRtLafw2b/Ma86stLp2mPt7Diq73NH8JYQ8LV
         zclA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVpxyjl30SuvFpRHylXIk2Qer3w6bUpvJAqgN5a9WqTwkL4ZdKMDlqWjV+7q6uFXta6j8U2GhCADWNwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiM3L8WsYNNE2QmTK123Czshqzh/N7A2flB/aW5sBKbM/9UiG7
	4LXkNSyjnSV0GI6s+tiTgLGMi+L/1ye6rVrOlGsXpWcL1Gw+gWMUVa6yLYTcU1zfwLQDS7fA5ZF
	GOw==
X-Google-Smtp-Source: AGHT+IHO8GteQC94R0wRPLaRP1hmwgiBq8ayuUUE9PrCkb1KFmRLBEeIiRzjI3DdAiG+v/hu+OXnZCn2kCs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4043:b0:6e2:155f:2638 with SMTP id
 00721157ae682-6e2475c85dbmr203777b3.6.1727449584326; Fri, 27 Sep 2024
 08:06:24 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:06:22 -0700
In-Reply-To: <ZvbB6s6MYZ2dmQxr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6eecc450d0326c9bedfbb34096a0279410923c8d.1726182754.git.isaku.yamahata@intel.com>
 <ZuOCXarfAwPjYj19@google.com> <ZvUS+Cwg6DyA62EC@yzhao56-desk.sh.intel.com>
 <Zva4aORxE9ljlMNe@google.com> <ZvbB6s6MYZ2dmQxr@google.com>
Message-ID: <ZvbJ7sJKmw1rWPsq@google.com>
Subject: Re: [PATCH] KVM: x86/tdp_mmu: Trigger the callback only when an
 interesting change
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org, sagis@google.com, 
	chao.gao@intel.com, pbonzini@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 27, 2024, Sean Christopherson wrote:
> On Fri, Sep 27, 2024, Sean Christopherson wrote:
> > On Thu, Sep 26, 2024, Yan Zhao wrote:
> > > On Thu, Sep 12, 2024 at 05:07:57PM -0700, Sean Christopherson wrote:
> > > > On Thu, Sep 12, 2024, Isaku Yamahata wrote:
> > > > Right now, the fixes for make_spte() are sitting toward the end of the massive
> > > > kvm_follow_pfn() rework (80+ patches and counting), but despite the size, I am
> > > > fairly confident that series can land in 6.13 (lots and lots of small patches).
> > > > 
> > > > ---
> > > > Author:     Sean Christopherson <seanjc@google.com>
> > > > AuthorDate: Thu Sep 12 16:23:21 2024 -0700
> > > > Commit:     Sean Christopherson <seanjc@google.com>
> > > > CommitDate: Thu Sep 12 16:35:06 2024 -0700
> > > > 
> > > >     KVM: x86/mmu: Flush TLBs if resolving a TDP MMU fault clears W or D bits
> > > >     
> > > >     Do a remote TLB flush if installing a leaf SPTE overwrites an existing
> > > >     leaf SPTE (with the same target pfn) and clears the Writable bit or the
> > > >     Dirty bit.  KVM isn't _supposed_ to clear Writable or Dirty bits in such
> > > >     a scenario, but make_spte() has a flaw where it will fail to set the Dirty
> > > >     if the existing SPTE is writable.
> > > >     
> > > >     E.g. if two vCPUs race to handle faults, the KVM will install a W=1,D=1
> > > >     SPTE for the first vCPU, and then overwrite it with a W=1,D=0 SPTE for the
> > > >     second vCPU.  If the first vCPU (or another vCPU) accesses memory using
> > > >     the W=1,D=1 SPTE, i.e. creates a writable, dirty TLB entry, and that is
> > > >     the only SPTE that is dirty at the time of the next relevant clearing of
> > > >     the dirty logs, then clear_dirty_gfn_range() will not modify any SPTEs
> > > >     because it sees the D=0 SPTE, and thus will complete the clearing of the
> > > >     dirty logs without performing a TLB flush.
> > > But it looks that kvm_flush_remote_tlbs_memslot() will always be invoked no
> > > matter clear_dirty_gfn_range() finds a D bit or not.
> > 
> > Oh, right, I forgot about that.  I'll tweak the changelog to call that out before
> > posting.  Hmm, and I'll drop the Cc: stable@ too, as commit b64d740ea7dd ("kvm:
> > x86: mmu: Always flush TLBs when enabling dirty logging") was a bug fix, i.e. if
> > anything should be backported it's that commit.
> 
> Actually, a better idea.  I think it makes sense to fully commit to not flushing
> when overwriting SPTEs, and instead rely on the dirty logging logic to do a remote
> TLB flush.

Oooh, but there's a bug.  KVM can tolerate/handle stale Dirty/Writable TLB entries
when dirty logging, but KVM cannot tolerate stale Writable TLB entries when write-
protecting for shadow paging.  The TDP MMU always flushes when clearing the MMU-
writable flag (modulo a bug that would cause KVM to make the SPTE !MMU-writable
in the page fault path), but the shadow MMU does not.

So I'm pretty sure we need the below, and then it may or may not make sense to have
a common "flush needed" helper (outside of the write-protecting flows, KVM probably
should WARN if MMU-writable is cleared).

---
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ce8323354d2d..7bd9c296f70e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -514,9 +514,12 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 /* Rules for using mmu_spte_update:
  * Update the state bits, it means the mapped pfn is not changed.
  *
- * Whenever an MMU-writable SPTE is overwritten with a read-only SPTE, remote
- * TLBs must be flushed. Otherwise rmap_write_protect will find a read-only
- * spte, even though the writable spte might be cached on a CPU's TLB.
+ * If the MMU-writable flag is cleared, i.e. the SPTE is write-protected for
+ * write-tracking, remote TLBs must be flushed, even if the SPTE was read-only,
+ * as KVM allows stale Writable TLB entries to exist.  When dirty logging, KVM
+ * flushes TLBs based on whether or not dirty bitmap/ring entries were reaped,
+ * not whether or not SPTEs were modified, i.e. only the write-protected case
+ * needs to precisely flush when modifying SPTEs.
  *
  * Returns true if the TLB needs to be flushed
  */
@@ -533,8 +536,7 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
         * we always atomically update it, see the comments in
         * spte_has_volatile_bits().
         */
-       if (is_mmu_writable_spte(old_spte) &&
-             !is_writable_pte(new_spte))
+       if (is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte))
                flush = true;
 
        /*
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 345c7115b632..aa1ca24d1168 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -133,12 +133,6 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
  */
 bool spte_has_volatile_bits(u64 spte)
 {
-       /*
-        * Always atomically update spte if it can be updated
-        * out of mmu-lock, it can ensure dirty bit is not lost,
-        * also, it can help us to get a stable is_writable_pte()
-        * to ensure tlb flush is not missed.
-        */
        if (!is_writable_pte(spte) && is_mmu_writable_spte(spte))
                return true;

