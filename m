Return-Path: <linux-kernel+bounces-406516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004619C604B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58102848BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A05217329;
	Tue, 12 Nov 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LH2AZ4FM"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13E216443
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435736; cv=none; b=BAEVCvh4pO5M60JFaDJ20iR9v6RmmqUcuCdfNeyO9MuqyCJbtowffZ72APJlHCr1nGSfol5nT3qNGLtQXEExVY17rxRt1HCCzJVUUwNF3fubiX/+3kG+pRo5rEzB0S7ItgDGq7A4ARKg/uqYrR8pmRe7dtqGVWwHGY6v/fNr4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435736; c=relaxed/simple;
	bh=W4QOB34iHDUpWJQ8v+WEVPSPLvxlPmgNFDX3aJtXUj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1jPkWVN/yhsmxcwWWfcy6zzuwnLResLGcXSmpfYZYq380Z6Ou/T9MUNsQTN6SSQ55zHK1XEp2Ym+HlEw7vId0pxrzpBjkxkM77HRNq8ZhC5emEL/eMUidPqBcCjr0P62a/wkCFaWp9gsgBAy88ZavLBsuTlpPio1MuzlldsoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LH2AZ4FM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e297a366304so9215913276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731435734; x=1732040534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MngSK2aNtfKYEgf2hNRlirtYcZGlI1I1a3Pi4HPECxM=;
        b=LH2AZ4FMN2/k5nLPCWgCG3Bw2FU14EpbKlush6bNfUd1XH5uhhTro3JmRvyOTq+wTK
         0e752UJk7fO3ib8QEnpPl0gXeQDHNESAmlwSHr1JQpMO+M7kT/zdeE2nuLFz9XV2sQPn
         zSFmq9hil9Nms7GBMC5vbD7LvlZObrFq4gm7AS93zpQxf/7TnrNZweP97lz0j117xgbD
         nV0WsiZRdH6mpn8zkMJCPozVUGaHDPDPkyiAxPU9Pz9SmG6bRfQZYQATA6+DN0SzbCGH
         I+ADo8E8P/4FwI6O6CnhyKolap0u4WxTQO9XMVJCIYatsJv1yOA89n4B+BM+U6Q1mQtM
         CWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435734; x=1732040534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MngSK2aNtfKYEgf2hNRlirtYcZGlI1I1a3Pi4HPECxM=;
        b=GNSd8nGWoLh+QhrvbjG6wCqgVwJ+Uk379QT19aY8chTPxV+4tt8badAeLoHALPXiRX
         UcgVKj0eNRQ1sRDdPhJ7Nn3XbgWNQe/1+dARf0ge9xAVvMbAuS9thw/IZNHjGqQv6GsI
         u4LvmlIlW3RxyPzwP1Atyv5vLxUAd/Wg34vj8xeKXTzcA73XnekC8YpuC5v7q8lS8dKn
         qRhWhn6SL+U9CghzCcVU84uXq4oIiB4DU9+etzLM0Nn2Zl9+XbR6UgsAcSF2r3ZBm88g
         G9oqPr7dJFA6dZmhy6BPt7KAAMJzfMGuPjICcIwsW6LK6wQ52QlnDEitSze9issLN+wC
         /wsw==
X-Forwarded-Encrypted: i=1; AJvYcCViDWFr9LSvvbz5E6I/6eSlnWQoOdEY4ugudvgeEOjp7VvlzGETa0YMbrR+qCg6PRFKyEA4yoYCdkEeqLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vy8RDoozRI5kGzusVYBgS0BWXeu1Jk3vqCmNiKGO/Ybh/LkP
	KirraCOQbG4/Pptgi73A2JMX1Pl4vXtJ/MgHVbGsgydFAzBx1eiS9ozQk8nvPgviUC9g5vXJ04F
	0qQ==
X-Google-Smtp-Source: AGHT+IGZGYSeYkhyGhIQNwjnPYziizKdLoKlqE3/c+SeZ9aQSqJrsM+xk7c/t1MtkOqq5B3Lrp0mS4FaV7U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:bfc5:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e337f8c911dmr60115276.5.1731435734060; Tue, 12 Nov 2024 10:22:14
 -0800 (PST)
Date: Tue, 12 Nov 2024 10:22:12 -0800
In-Reply-To: <8c70586e-2513-42d4-b2cd-476caa416c16@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112065415.3974321-1-arnd@kernel.org> <ZzOY-AlBgouiIbDB@google.com>
 <8c70586e-2513-42d4-b2cd-476caa416c16@zytor.com>
Message-ID: <ZzOc1PJmM-iKqjMC@google.com>
Subject: Re: [PATCH] x86: kvm: add back X86_LOCAL_APIC dependency
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	kernel test robot <lkp@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 12, 2024, H. Peter Anvin wrote:
> On 11/12/24 10:05, Sean Christopherson wrote:
> > > 
> > > Fixes: ea4290d77bda ("KVM: x86: leave kvm.ko out of the build if no vendor module is requested")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202410060426.e9Xsnkvi-lkp@intel.com/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > Question: is there actually any point in keeping KVM support for 32-bit host
> > > processors?
> > 
> > Nope.  We need _a_ 32-bit KVM build to run as a nested (L1) hypervisor for testing
> > purposes, but AFAIK there's zero need to keep 32-bit KVM up-to-date.
> 
> What do you mean here? Running an old kernel with the 32-bit KVM in a VM for
> testing the L0 hypervisor?

Yep, to validate nested NPT (NPT is AMD/SVM's stage-2 paging mechanism).  Unlike
EPT, which is completely disassociated from the host's CPU mode, NPT is tightly
coupled to the host mode and uses/supports all of the flavors of stage-1 paging,
i.e. legacy 32-bit, PSE, PAE, 4-level, and 5-level.

Because there's no architectural way to prevent L1 from using 32-bit or PAE NPT,
KVM needs to support shadowing such NPT tables.  And so to validate that KVM (L0)
correctly shadows L1's NPT tables, we need a 32-bit hypervisor to run in L1.  We
briefly considered writing dedicated tests, but the effort required is absurd,
relatively to the coverage provided.

It's quite annoying, because I highly doubt anyone actually uses 32-bit hypervisors
of any flavor, but nested NPT allows for some truly unique setups, e.g. where KVM
is using 5-level NPT to shadow legacy 3-level 32-bit page tables.  As a result,
KVM has paths are only reachable with a 32-bit L1 KVM, and at the very least we
need to ensure they aren't juicy attack vectors.

