Return-Path: <linux-kernel+bounces-286640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA94951D58
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2255F1F263E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C01BBBDE;
	Wed, 14 Aug 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6j+Ovcn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016511BB6AA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646105; cv=none; b=l/dJNf2pi8JdA7DlaJj2+BXIYVy6oCBPe+zsNCoaixeLlDDKJiB74yEPv2LAvC9CNzXQi9fKac9A8hakxGnRf1ndfATASacy2qNElpXeUMII5LC67jNTohiF/GpQY0f7h0rDtB39Ch6UTbhZyJymAjRuKHN+KaO/7Bv4Hjn8nW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646105; c=relaxed/simple;
	bh=kUgF0cUl3dMj466Jcm5VVUd/sQE57nGiTyxbsxext2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z3lQNIzbBgP53rzHBcp8XVyaL4KkJHQo5EVTRFxN7FO2ZXvTukpR9h/WKXX/36PNXYBq8wewKuGKi+2GIQmb+SuPNgRZQuopJTRYtHb+PNiJcd/QS22oGAf0/BEOs3UyCnrkIHHKcW7k+Yk81TudveSRrNdFb0da5DtRUq7yylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6j+Ovcn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so10931911276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723646103; x=1724250903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZO6m2EPCg+BEClD5O/UaD6XP5dearzPGgfE50iwHdM=;
        b=h6j+Ovcnw8BEQ3WGKLmdwxY7SwAoRxT7IfSsLJMrubpJVDFGvK55tCzuA1YwAg3fbE
         Dw7ZFJQZlrfH9RJy62DsnDOBnbdCtM9Jr4GWqZnMmxmSQKc8aX5PiCrxWgMZMX3fEP0E
         D2pf2h7qx9ct69AXuXmYeJEkGWOutq0GUUMUNXuUMfCR2j31/X/Rue4bk6ujRRdFTbTI
         P4BvpV29qUxxn3+xyeA7wr+8aueDi+DQkRKVb+siBxp674nUy3PcB5ZUgePOg0MnQ03F
         Jt8DJpydVD/4UnofYJ1lnc9nWsN5Hr6ALqytPDBcfdJ7jvOmxFvbYsCCOksAZ7HouNx6
         Lbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646103; x=1724250903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZO6m2EPCg+BEClD5O/UaD6XP5dearzPGgfE50iwHdM=;
        b=bGNBl1JPrqBiavhJ5uqryjknqeOChIFTRKrv5q0ExB37QmVKjrC52O51/Zu0KXeW2J
         me8yPtQn+RH71dY1Hb/r9gx/kErDgBAiB7dF9vXIBoqNnASz7iN5ee9oDs2eQ9Arwbpg
         /p/jzfsGnBHtVFsnQBSRpMuq2eN2I8L/vzXxOXDwJbeHiPIlUGlzIIiQCQSMj5TD6Wr6
         /CODcu3f4UaVh2ievrk8R1v0yZCBTElxkKKsSmr4wwS+JMOcGj6+GQRKgG2h1RG4DKvP
         iSBS6ev1dcU/7R2IAZXLJvExYZC3jKy+cTbi4O2czf8QJiJhguensLzsQAON3qSJW6+x
         EHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBLpDp82sqpsPEyprZBYeRNWKUshaMZ6FNcQFBLkdILRqkqlWvpq7QCm5bbHUqX2qgCiFjQtnzmJSKe6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZgAYjizpHmVADEWkWgHrOsqfdn7r5PLFvk1SIxYRb70wAdut
	ltvQXB8/XHJHMI3Fh3gHUPjUIcatMQLStrirJftAEv7tZ12IzE62BMTe2vc2JAFG3k59V/igMpv
	PbA==
X-Google-Smtp-Source: AGHT+IFu38/YQ+6pcEZAPERvSvU9PJFoT7OocvzhIr4N07sxW+6eXQk76yQEUC3C3MeMfUmPczeM3hOUO48=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dc44:0:b0:e11:4401:ee1f with SMTP id
 3f1490d57ef6-e1155baf4d7mr38937276.12.1723646102797; Wed, 14 Aug 2024
 07:35:02 -0700 (PDT)
Date: Wed, 14 Aug 2024 07:35:01 -0700
In-Reply-To: <20240814123715.GB2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809160909.1023470-1-peterx@redhat.com> <20240814123715.GB2032816@nvidia.com>
Message-ID: <ZrzAlchCZx0ptSfR@google.com>
Subject: Re: [PATCH 00/19] mm: Support huge pfnmaps
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 12:08:50PM -0400, Peter Xu wrote:
> > Overview
> > ========
> > 
> > This series is based on mm-unstable, commit 98808d08fc0f of Aug 7th latest,
> > plus dax 1g fix [1].  Note that this series should also apply if without
> > the dax 1g fix series, but when without it, mprotect() will trigger similar
> > errors otherwise on PUD mappings.
> > 
> > This series implements huge pfnmaps support for mm in general.  Huge pfnmap
> > allows e.g. VM_PFNMAP vmas to map in either PMD or PUD levels, similar to
> > what we do with dax / thp / hugetlb so far to benefit from TLB hits.  Now
> > we extend that idea to PFN mappings, e.g. PCI MMIO bars where it can grow
> > as large as 8GB or even bigger.
> 
> FWIW, I've started to hear people talk about needing this in the VFIO
> context with VMs.
> 
> vfio/iommufd will reassemble the contiguous range from the 4k PFNs to
> setup the IOMMU, but KVM is not able to do it so reliably.

Heh, KVM should very reliably do the exact opposite, i.e. KVM should never create
a huge page unless the mapping is huge in the primary MMU.  And that's very much
by design, as KVM has no knowledge of what actually resides at a given PFN, and
thus can't determine whether or not its safe to create a huge page if KVM happens
to realize the VM has access to a contiguous range of memory.

