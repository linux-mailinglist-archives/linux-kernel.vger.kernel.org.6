Return-Path: <linux-kernel+bounces-357096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57650996B85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD561C22E82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FF194AEB;
	Wed,  9 Oct 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2OLGGWjI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4AA192D82
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479680; cv=none; b=BWkKaOYN9FkQ/wTTOpoSomdq9UhNi/fUwK7EUT4QhG4P0EfsT/V1kcCuTOD7DEiwc81wPGSlIw9UivsYT6jISZxXbHfX1/aktg3eYJ80bpDIaoZWMak/MAslSZQAV1XIJjEaAvVV//uOhWrxbjxFZxPbQPRWv8N33MpuDUucIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479680; c=relaxed/simple;
	bh=d3uSPZxORKmVlB66mNShAQmiJU7ra9Q4AGAbI3fZ8z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fXINq+Ke2leDjXsEIkKAwoqZZ/K6la2O7ohj7ZHyQSHRXWaLQhA8ZcBzPD2sFZlNO41NXWrVCJx01fxW4Hx8BLZWIsvAGIxDYfCswBlbZd/YpOIXLs3QswbrNb50IimY4quaQJREcSiSwN2HAuPB3VtQAF65DRffeve+GXWAzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2OLGGWjI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so125848577b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728479677; x=1729084477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgsDKPkC09+Onhv3ZGoUVeFgaBkjKnGI6VWOvKgtHCM=;
        b=2OLGGWjIXihdPod7b4tSfNInoBC8yJmZNH6CYCushwdRcewN7n3QlUGi/H6WCDinRe
         emVcio9Srhl+AMsXeafWucSlq6n04sxs6j5sxwr1BYyXf143E37Kel6aTqCn84ON1COB
         +ELmx+bWmfAUlgrtSJJ9v82SCVLp+j1Ps2LZP3wJHcY4LThZ0qcvDIVADz6my826yi2f
         /MEPjCwJ56o9oMN2rwrYmu/RDGVrKC7GojfgTNtkoX98PGIPONIblo6KGBqqQ11vvSgY
         fU/eVAzP7/koFQsPq1U254MVgwiWVsCktULFnuAYk+IYQQXW+6YBn7lZog5m07COdsgn
         r2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479677; x=1729084477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgsDKPkC09+Onhv3ZGoUVeFgaBkjKnGI6VWOvKgtHCM=;
        b=BAaw8u3QhN4cNo/RhlMuevOW7cAPNpVYCUX1FH3bEV9t7wNVChr7b3THnoH3Mf2Bty
         AezGUgb4+gFlqlfQdYBX3MrLw0w/2OC2WrIG8/mb+rdE8uAwH3I1qo2DdGmXrOsX/G0M
         r1nRjDrxAb4ZL0BZsqHElLMNk7IEWgFtdcQMzIhaf7cufpKyR5JsYb0rR9ZJNYxaoS91
         ah0ayc7IqQMIjZCBMN/7qYijfGh9mP4LtMjHyBl37FJhp9MeaP0sFvc+z3Gjz1dS7tcE
         xK634cpjhtY9AocJaFi7Bjd1FXqI51WT/VtpnhAtM66ejjoiW1UHMIhSlpUQ4T6Fb0Jt
         NVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFESzTBjfEVcUfJ4GLg4mgGX874RCTpdbh8WdKOhyu7kBO1bW6tXl4Fr2lXuP5XqeRTtfk0dE/clc28Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLKuIu43RwdJf9mseSgg/DVxczeYeHEMCb3YlRKPgZEwhCoKc
	WmolzagdGMV0ZTAXChxe0KXX2DDggL1sGWByXvZiOAuGH3Dv4UMvPfYr+hp1ZZJuME91HxtYHSk
	TxQ==
X-Google-Smtp-Source: AGHT+IEO0k4jXJioiSmPAvdcWPAQJDTNJQQZHdjpBAGmJ2rcmUcV4emzzrWNTnFXRkQogPoiWl6B2lJBrJw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:6c05:0:b0:e24:c3eb:ad03 with SMTP id
 3f1490d57ef6-e28fe540170mr478276.10.1728479676345; Wed, 09 Oct 2024 06:14:36
 -0700 (PDT)
Date: Wed, 9 Oct 2024 06:14:31 -0700
In-Reply-To: <ZwZLN3i3wcJ4Tv4E@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6eecc450d0326c9bedfbb34096a0279410923c8d.1726182754.git.isaku.yamahata@intel.com>
 <ZuOCXarfAwPjYj19@google.com> <ZvUS+Cwg6DyA62EC@yzhao56-desk.sh.intel.com>
 <Zva4aORxE9ljlMNe@google.com> <ZvbB6s6MYZ2dmQxr@google.com>
 <ZvbJ7sJKmw1rWPsq@google.com> <ZwWEwnv1_9eayJjN@google.com> <ZwZLN3i3wcJ4Tv4E@yzhao56-desk.sh.intel.com>
Message-ID: <ZwaBt0BzzG6Z0UGN@google.com>
Subject: Re: [PATCH] KVM: x86/tdp_mmu: Trigger the callback only when an
 interesting change
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org, sagis@google.com, 
	chao.gao@intel.com, pbonzini@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 09, 2024, Yan Zhao wrote:
> On Tue, Oct 08, 2024 at 12:15:14PM -0700, Sean Christopherson wrote:
> > On Fri, Sep 27, 2024, Sean Christopherson wrote:
> > > ---
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index ce8323354d2d..7bd9c296f70e 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -514,9 +514,12 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
> > >  /* Rules for using mmu_spte_update:
> > >   * Update the state bits, it means the mapped pfn is not changed.
> > >   *
> > > - * Whenever an MMU-writable SPTE is overwritten with a read-only SPTE, remote
> > > - * TLBs must be flushed. Otherwise rmap_write_protect will find a read-only
> > > - * spte, even though the writable spte might be cached on a CPU's TLB.
> > > + * If the MMU-writable flag is cleared, i.e. the SPTE is write-protected for
> > > + * write-tracking, remote TLBs must be flushed, even if the SPTE was read-only,
> > > + * as KVM allows stale Writable TLB entries to exist.  When dirty logging, KVM
> > > + * flushes TLBs based on whether or not dirty bitmap/ring entries were reaped,
> > > + * not whether or not SPTEs were modified, i.e. only the write-protected case
> > > + * needs to precisely flush when modifying SPTEs.
> > >   *
> > >   * Returns true if the TLB needs to be flushed
> > >   */
> > > @@ -533,8 +536,7 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
> > >          * we always atomically update it, see the comments in
> > >          * spte_has_volatile_bits().
> > >          */
> > > -       if (is_mmu_writable_spte(old_spte) &&
> > > -             !is_writable_pte(new_spte))
> > > +       if (is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte))
> > 
> > It took me forever and a day to realize this, but !is_writable_pte(new_spte) is
> > correct, because the logic is checking if the new SPTE is !Writable, it's *not*
> > checking to see if the Writable bit is _cleared_.  I.e. KVM will flush if the
> > old SPTE is read-only but MMU-writable.
> For read-only, host-writable is false, so MMU-writable can't be true?

Read-only here refers to the SPTE itself, i.e. the !is_writable_pte() case.

