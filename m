Return-Path: <linux-kernel+bounces-298061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5D95C14E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9911C23511
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C411D1F7C;
	Thu, 22 Aug 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lO6NF9H4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432416F0D0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368240; cv=none; b=LG8gRG0u7WlmM0IgD2DLDYs/ZcMf5rH1Pz41GKu0+Qz9GUmlqr3+8731ZgAR1rbr2gD8axtpMQOPdtxzlZa8HvsW6TQqmSxZ2LptA8GPuCFenzJy2VlloIe0YIrNDY/IKeigocCzaSKEXezuvRh13HFRKyuThTwemKCgd5X/G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368240; c=relaxed/simple;
	bh=MkcfCenS3xFCKvWO2XiK5Kf1TRh1w2lilKwkPSXjMXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ck3eT7g1+250zf25Na9WD9D23yY9aZK/eqJzIAIdV7J7ZW5x6sD3tD8y8eBmiUHr9BG9VU3tRCAuPUeanspJjrfmdGFTzPHt43+d7hZC5TM6Cg0BQfgIiXdtfgxCJsfVLx6Oc9pWgrzixVXsDQy4imwhUFIyYMe4QA/naG4ytH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lO6NF9H4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e11703f1368so1922339276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724368237; x=1724973037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9eTeJ7+1hJHMk+pmGCHSxA/xju6KE1INydXkWpPn8k=;
        b=lO6NF9H4l6Ae1ZTzlwcAtZVP7eNjRc4I13+4kkXL90fO29D1AobljXKnM0OUKj/wse
         MyZjtq4Zst6SEqdTq1fVrljQfuZE4Ime3qabu1fiCfWGNjloxMLbqe79FEac33Feus80
         XmAN4022M/sfoAZUep80nDhEZsxr0XK5UeNLSFhSvUHLsTN5h31uq1VGpgoHmTiJak4n
         1goCO6tJBkvmkN5ordNO2yZjsqjLcJpqBBbh7pJP0iT6/jqtwdiYE22hfTJp6St0J8A/
         slaCl20DTfxPMyA1Bq4QM6HQkW5A4d2N+l84j12CKD2Kzmr9CYmudkZl4gVH8s2AnTr4
         rx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724368237; x=1724973037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9eTeJ7+1hJHMk+pmGCHSxA/xju6KE1INydXkWpPn8k=;
        b=eXG8wWtJCfPHNIvb+/HHIUaL2IKEkJV1pxynmvfhqgz9NffU7YPTBAKQsSBISZa9iw
         Rd4b7XijQHni2QcSr+26+dTbwsoUhzU5j6w7+Xq8dvbT/7C7+OcDMbloZ9PbR4oa6Zd6
         QkvNhvbJRjBz4nE8G6EByWRacK0LxAAzXoMDSWdiwDGaIcW0H5YCzHhnASMsoIcc8VqM
         oJLo8hrXPiHsu8mjt4TkqLAf0pnddFwVmGxqpQ0mqkShGdCcDPvPUvGsCcSrDfW8Qz4v
         qAU3gKkgIoKFrllkp/ZFDnNEz8xLXpKDlp2CwRws8hyZO5+zTIkzvhPOB0evKsb2oj9R
         3Yow==
X-Forwarded-Encrypted: i=1; AJvYcCXFNROY6Fsvs9f2pku7/zE0fl8iKSFxiDP9gw3lXQACaEKnqJV03QBrHl6xC8iN0jeyK5KObJnkdc5EDZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2u+zflV0srBHBygdrFzYu5R+mKiVqAgvRUCYuB3gSiMdtdiz
	3gX3pQUTQmQCQ6lvjUs8H3myD4Z2jAUVa3eNI40CFd7lA3GZC2eGOzbvKUHWgTNMLwdgrf3M0x7
	ONg==
X-Google-Smtp-Source: AGHT+IFT091iygxCVdPT22rOOgTixYu9Nccdsrs9AC1KE7uMFgRYqeS107OZYAbUZZkbRmekLfLLOaJhaag=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:26d1:0:b0:e11:5807:1072 with SMTP id
 3f1490d57ef6-e17a862de14mr572276.8.1724368237348; Thu, 22 Aug 2024 16:10:37
 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:10:36 -0700
In-Reply-To: <cc9b9df6-583a-d185-0c32-6d26d0717548@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com> <20240719235107.3023592-4-seanjc@google.com>
 <ZseG8eQKADDBbat7@google.com> <2f712d90-a22c-42f0-54cc-797706953d2d@amd.com>
 <ZseUelAyEXQEoxG_@google.com> <cc9b9df6-583a-d185-0c32-6d26d0717548@amd.com>
Message-ID: <ZsfFbMpVm9qWRVz5@google.com>
Subject: Re: [PATCH v2 03/10] KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for
 AMD (x2AVIC)
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 22, 2024, Tom Lendacky wrote:
> On 8/22/24 14:41, Sean Christopherson wrote:
> > On Thu, Aug 22, 2024, Tom Lendacky wrote:
> >> On 8/22/24 13:44, Sean Christopherson wrote:
> >>> +Tom
> >>>
> >>> Can someone from AMD confirm that this is indeed the behavior, and that for AMD
> >>> CPUs, it's the architectural behavior?
> >>
> >> In section "16.11 Accessing x2APIC Register" of APM Vol 2, there is this
> >> statement:
> >>
> >> "For 64-bit x2APIC registers, the high-order bits (bits 63:32) are
> >> mapped to EDX[31:0]"
> >>
> >> and in section "16.11.1 x2APIC Register Address Space" of APM Vol 2,
> >> there is this statement:
> >>
> >> "The two 32-bit Interrupt Command Registers in APIC mode (MMIO offsets
> >> 300h and 310h) are merged into a single 64-bit x2APIC register at MSR
> >> address 830h."
> >>
> >> So I believe this isn't necessary. @Suravee, agree?
> >>
> >> Are you seeing a bug related to this?
> > 
> > Yep.  With APICv and x2APIC enabled, Intel CPUs use a single 64-bit value at
> > offset 300h for the backing storage.  This is what KVM currently implements,
> > e.g. when pulling state out of the vAPIC page for migration, and when emulating
> > a RDMSR(ICR).
> > 
> > With AVIC and x2APIC (a.k.a. x2AVIC enabled), Genoa uses the legacy MMIO offsets
> > for storage, at least AFAICT.  I.e. the single MSR at 830h is split into separate
> > 32-bit values at 300h and 310h on WRMSR, and then reconstituted on RDMSR.
> > 
> > The APM doesn't actually clarify the layout of the backing storage, i.e. doesn't
> > explicitly say that the full 64-bit value is stored at 300h.  IIRC, Intel's SDM
> 
> Ah, for x2AVIC, yes, you have to do two writes to the backing page. One
> at offset 0x300 and one at offset 0x310 (confirmed with the hardware
> team). The order shouldn't matter since the guest vCPU isn't running
> when you're writing the values, but you should do the IRC High write
> first, followed by the ICR Low.

Thanks Tom!

