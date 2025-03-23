Return-Path: <linux-kernel+bounces-572948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E89A6D0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CA93A441B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AE19C542;
	Sun, 23 Mar 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkagMSux"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E6376F1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742756541; cv=none; b=P1Im8glzr0T1wl9TJXB4s32c34tS18gcnrNc8m+RMm2YBO/t9XlGrcuDl/w7QcWK5lpz0bKfuT2+zEEuGuCK1rBmNogg0s4cobQnmaXzKVtnt7p77bOLQmxQdFP7llwpTWypncHkLplDXzuR+qslbPJjyZF/d+RdBiBIrlE8A90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742756541; c=relaxed/simple;
	bh=tDa9vpNu/b8nQeMcsn/2LF0GMloBDuo9YzrQSkldP8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRhJfxDdEi30hYc3q1SiyOffRGPZeF8Vl5xbyFlIM7a/ZW5s4urOEKjGoRFequjQNClkY4gTSe1cOi/XJb5F96wmtP9Tw057NQ5hxCswGhsIfGzQn9tvxKgueNIc8r+kMSI1noR7Cxyo0fKUrSR1WLsIAm+oHVuLeNuddlAp8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkagMSux; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so10318271a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742756538; x=1743361338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuNRgEM1/VSSZOP8AP4UeKswwiKQNT+cWOtWKPuUrmU=;
        b=rkagMSuxRsQn7+0LkxmjtFs7DEOGvu02Wd+ek3J8WMS8dyuLVar0abAhUPSUClOWpF
         dhX7YdcsKnmB+HUlglrob2dqx9EDR6cNTrKD/M7Hh7DTF9WhO3J27mVtL6lNMsYsqcju
         zC1wVa/EiEgCQ7Ly6/A2DWCzvMEPqsaLv5sBY9t05cEN/gxxKiFw3oQtwZs6c5r+00g0
         qhI5AFaLehU8jEws4OeWrXW43Y6JFVQ/z33cjRZgWdwTB0+S5i8xZ9eYIhOz7saPWii4
         Jti+aUWiVmQv2GrrM7pJHdAmV3oobz3h1qyLyDqnWzuLyjoj48HGHEc2qZ+6FYboEmNQ
         wM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742756538; x=1743361338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuNRgEM1/VSSZOP8AP4UeKswwiKQNT+cWOtWKPuUrmU=;
        b=nlrz+9f34czBDCoidIRL9KBdd/QLVr+11k1IJTC993L6Ieet1Dud80HAOUNclBS9JT
         zBLE356zS5xUYgiwvC5TuLZo7s+OPn7HfU1eiBBGyTobXua2kt+xrqaAEveQFlPwLrjn
         tZJTKMScLUgkBbba+rKUUdjmqZ6SbAilwG0WYEHPJq5OCquvjZlviJxLMhX9h4u/3RTa
         OqzsMQPxosohJJ3rCkLGH0ew0JAKK8hlE1VZ9RJZiKryHjJYcmUvP3H2Cm7tjjYLbJvj
         sOH20wViIoP9SGzowd7rNBsAAIjveEJinUtxzzu1JuWQCvRLKXGOUtk8mn79CsZoG0ph
         22TA==
X-Forwarded-Encrypted: i=1; AJvYcCWjraf2bIW5y7n0S6AAgXRtX94K54eyk6xC/Y0NXp6yt04oche2CcLI6BYk/gcTPkEHwQ3jAzzdSlr5yv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVx4YZereno8RSdrmaSrcuYEOK9XZ5bBv0IFaspvGjWefjBzZx
	MHlL6qN6K5wjr6qQzsIbt4RPWjXl/+uR0bfiFXKTquy16ANCgqlWYB+yKEgS5RvfZPN9VYs502X
	WpeCnktMlUZ0XItMeNw==
X-Google-Smtp-Source: AGHT+IHqKpRChgtgDh49YPKj5euGR0CZLSvO9CAU4Y43PCYdmIBq9tlLyCyLELbaKPjbaTiHWY1Fon3WmY7MX6oI
X-Received: from pjbok3.prod.google.com ([2002:a17:90b:1d43:b0:301:1bf5:2f07])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d008:b0:2ff:693a:7590 with SMTP id 98e67ed59e1d1-3030ff08de9mr20652493a91.33.1742756538347;
 Sun, 23 Mar 2025 12:02:18 -0700 (PDT)
Date: Sun, 23 Mar 2025 12:02:04 -0700
In-Reply-To: <20250321133447.GA251739@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321133447.GA251739@nvidia.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250323190204.742672-1-changyuanl@google.com>
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
From: Changyuan Lyu <changyuanl@google.com>
To: jgg@nvidia.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, 
	robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason, thanks for reviewing the patchset!

On Fri, Mar 21, 2025 at 10:34:47 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Wed, Mar 19, 2025 at 06:55:42PM -0700, Changyuan Lyu wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Add the core infrastructure to generate Kexec HandOver metadata. Kexec
> > HandOver is a mechanism that allows Linux to preserve state - arbitrary
> > properties as well as memory locations - across kexec.
> >
> > It does so using 2 concepts:
> >
> >   1) State Tree - Every KHO kexec carries a state tree that describes the
> >      state of the system. The state tree is represented as hash-tables.
> >      Device drivers can add/remove their data into/from the state tree at
> >      system runtime. On kexec, the tree is converted to FDT (flattened
> >      device tree).
>
> Why are we changing this? I much prefered the idea of having recursive
> FDTs than this notion copying eveything into tables then out into FDT?
> Now that we have the preserved pages mechanism there is a pretty
> direct path to doing recursive FDT.

We are not copying data into the hashtables, instead the hashtables only
record the address and size of the data to be serialized into FDT.
The idea is similar to recording preserved folios in xarray
and then serialize it to linked pages.

> I feel like this patch is premature, it should come later in the
> project along with a stronger justification for this approach.
>
> IHMO keep things simple for this series, just the very basics.

The main purpose of using hashtables is to enable KHO users to save
data to KHO at any time, not just at the time of activate/finalize KHO
through sysfs/debugfs. For example, FDBox can save the data into KHO
tree once a new fd is saved to KHO. Also, using hashtables allows KHO
users to add data to KHO concurrently, while with notifiers, KHO users'
callbacks are executed serially.

Regarding the suggestion of recursive FDT, I feel like it is already
doable with this patchset, or even with Mike's V4 patch. A KHO user can
just allocates a buffer, serialize all its states to the buffer using
libfdt (or even using other binary formats), save the address of the
buffer to KHO's tree, and finally register the buffer's underlying
pages/folios with kho_preserve_folio().

> > +int register_kho_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(register_kho_notifier);
>
> And another different set of notifiers? :(

I changed the semantics of the notifiers. In Mike's V4, the KHO notifier
is to pass the fdt pointer to KHO users to push data into the blob. In
this patchset, it notifies KHO users about the last chance for saving
data to KHO.

It is not necessary for every KHO user to register a
notifier, as they can use the helper functions to save data to KHO tree
anytime (but before the KHO tree is converted and frozen). For example,
FDBox would not need a notifier if it saves data to KHO tree immediately
once an FD is registered to it.

However, some KHO users may still want to add data just before kexec,
so I kept the notifiers and allow KHO users to get notified when the
state tree hashtables are about to be frozen and converted to FDT.

> > +static int kho_finalize(void)
> > +{
> > +	int err = 0;
> > +	void *fdt;
> > +
> > +	fdt = kvmalloc(kho_out.fdt_max, GFP_KERNEL);
> > +	if (!fdt)
> > +		return -ENOMEM;
>
> We go to all the trouble of keeping track of stuff in dynamic hashes
> but still can't automatically size the fdt and keep the dumb uapi to
> have the user say? :( :(

The reason of keeping fdt_max in the this patchset is to simplify the
support of kexec_file_load().

We want to be able to do kexec_file_load()
first and then do KHO activation/finalization to move kexec_file_load()
out of the blackout window. At the time of kexec_file_load(), we need to
pass the KHO FDT address to the new kernel's setup data (x86) or
devicetree (arm), but KHO FDT is not generated yet. The simple solution
used in this patchset is to reserve a ksegment of size fdt_max and pass
the address of that ksegment to the new kernel. The final FDT is copied
to that ksegment in kernel_kexec().
The extra benefit of this solution is the reserved ksegment is
physically contiguous.

To completely remove fdt_max, I am considering the idea in [1]. At the
time of kexec_file_load(), we pass the address of an anchor page to
the new kernel, and the anchor page will later be fulfilled with the
physical addresses of the pages containing the FDT blob. Multiple
anchor pages can be linked together. The FDT blob pages can be physically
noncontiguous.

[1] https://lore.kernel.org/all/CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com/

Best,
Changyuan

