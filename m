Return-Path: <linux-kernel+bounces-256430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBD934E77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8828C1C20F63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CA13E033;
	Thu, 18 Jul 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9/PkpcB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kqvkoTK4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978413C687
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310490; cv=none; b=IqS9eAc/du1/7DnFFP0xaJOmb3DhL43XGSwtoG3HFrEpqyQaY+O8R011LxJYNny60PSj6/CwEWONlLRISz+DzEIKWzJFaoUTyaXvyDtY/zZdNpQEMeUZhKYKYO6GEUrxUJnbukgSXifVP/Y36lfub7a1favsQWfjkrYda2KKI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310490; c=relaxed/simple;
	bh=f0wwsmjtQ9avqg0ojHdBV984wDPxr3vTy98hQFhtDQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlQEiqeTZBCoQFQyTtZ20VV2HxA+NsN0bL3RX9z5RpSqCKqfDg0xsF9+687431s5Elxd17t13fI02KGKjbBxrFxrOU7P53f7ICUnV6MtAEyMos9caww1pQ/CYkuTeM/Y/rAPqfw27Pity2Cm1pzWZkGsdKWor9Og2bqss4nL4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9/PkpcB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kqvkoTK4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ce+iD0me1R/vk1RQ5hDE7ERHKxhgscv8L8ADCDOKWas=;
	b=i9/PkpcBtbbhUTCu1mIh69zH2bDjl5T5ilInxXSzVA0NujNFX7Ta0euPy+k+Y2GY1NA3jq
	hLSwRpXImWtTmYop/5j1YrcS6sK9Try539ZohrEVVJqTR6AHcc+yzb8rzDJ8cooJktbpNu
	Z1718n8O//WgCyEuvalvSH9IebbqWQ8OOUSQ6IDvn1WsD2CEot6uaEMRvtQ2saI2V96muj
	qtJ2ZKkYF3tQzLPcKNwpjQ9/4XqQ/zehOBYFlBB6duRYTevhakM64VALczPm9UgNuM+fSe
	XUOWsOm2zcLKX0qCWQKOTkdhQyktHE52dgXSClHZsZWLERvIuZnFNZ9ShED8Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ce+iD0me1R/vk1RQ5hDE7ERHKxhgscv8L8ADCDOKWas=;
	b=kqvkoTK4SavZmlUZEkmu5r4KFKCaf5u0n/ldEX5y/ynawIAaQ1FfXLkoQVWw2ga34i15Cl
	nkhqmHSSG8ZQ4QDg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 0/9] tools/x86/kcpuid: Complete the CPUID database
Date: Thu, 18 Jul 2024 15:47:40 +0200
Message-ID: <20240718134755.378115-1-darwi@linutronix.de>
In-Reply-To: <ZpkckA2SHa1r3Bor@lx-t490>
References: <ZpkckA2SHa1r3Bor@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch series enhances the Linux Kernel's kcpuid tool with full
cpuid leaves bitfields coverage through a CSV file generated from:

   https://gitlab.com/x86-cpuid.org/x86-cpuid-db

The existing CSV file covers 291 cpuid bitfield entries, while the new
generated one in this patch series covers 835+ entries with full
descriptions.

The new file also covers having the same bitfields' format repeated
across a number of subleaves.  This is encountered while enumerating
hierarchical CPU structures like cache, TLB, and CPU topology levels.

The generated file has the following blurb automatically added:

   # SPDX-License-Identifier: CC0-1.0
   # Generator: x86-cpuid-db v1.0

where the generator tag includes the x86-cpuid-db project's workspace
"git describe" string.  This is intended for projects like KernelCI, to
aid in verifying that the generated files have not been tampered with.

There's also a hint for future contributors:

   # Auto-generated file
   # Please submit all updates and bugfixes to https://x86-cpuid.org

We kindly expect the x86 tree maintainers to guide developers so that
any bugfixes or enhancements to the CSV file are to be submitted
directly to x86-cpuid.org upstream, thus benefiting the whole ecosystem.

Beside reading the actual new CSV file before and after, a nice
demonstration would be to run the command below:

   kcpuid --detail --all

and to compare the output accordingly.  The differences get even bigger
when running the above on the more featureful x86 CPUs; Xeon and Zen.

The first set of patches in this series are kcpuid bugfixes and
refactorings.  Afterwards, cpuid enumeration support for hierarchical CPU
structures is added.  Then, the auto-generated CSV file is introduced.

Thanks!

8<-----

Ahmed S. Darwish (9):
  tools/x86/kcpuid: Remove unused variable
  tools/x86/kcpuid: Properly align long-description columns
  tools/x86/kcpuid: Set max possible subleaves count to 64
  tools/x86/kcpuid: Protect against faulty "max subleaf" values
  tools/x86/kcpuid: Strip bitfield names leading/trailing whitespace
  tools/x86/kcpuid: Recognize all leaves with subleaves
  tools/x86/kcpuid: Parse subleaf ranges if provided
  tools/x86/kcpuid: Introduce a complete cpuid bitfields CSV file
  MAINTAINERS: Add x86 cpuid database entry

 MAINTAINERS                     |   10 +
 tools/arch/x86/kcpuid/cpuid.csv | 1430 ++++++++++++++++++++++---------
 tools/arch/x86/kcpuid/kcpuid.c  |  105 +--
 3 files changed, 1083 insertions(+), 462 deletions(-)

base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
--
2.45.2

