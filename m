Return-Path: <linux-kernel+bounces-256429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF3934E74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E89284A86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FE13C699;
	Thu, 18 Jul 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xAG9zuEh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXYvagEp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16813C3D2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310357; cv=none; b=UYeEMWRePvhq2PiBrMV05A0PuVHKicdkcAaU2sEx7ceo1xh/VMuC9nlHCe+6M2iGkaPTcV3HBRZQZniY6tutO6ElQK80U1chTs1jin+uonu+eDudcDYjVAw9f5fgUGHImzWsE+hOUEYFOpzd5Zoz8Yfk6Oas1j+9Ot+voVZLwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310357; c=relaxed/simple;
	bh=SCB/PolNo/C/ma+eopNRWQKP0XgbMNjsDfBluZb8jJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LHfMRlAFGNZxv3ohOX3rG1g73Nahwb7QNDgRxEjStRA+MV7HEgzkh/dCvU1WBZ3RVlegfsZJQglMN6hRfwc7TIPvS/pvasgLBajzYQDJuuiAwYqkrbj5B5ryHE2lXSJC1oIKX5Sa6A1t99x4hzXHspF6oFfKvWC3J7O0s5UkQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xAG9zuEh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXYvagEp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 15:45:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0OOltyhkR/M6InnbHS9JUDyLIT88qYJF+hevCB6BgZM=;
	b=xAG9zuEhvUofKitWw7ISkAN7S1IRLEPXKQvsg1mV8MU4C1pKyQkwvenVvsHHCZyArSbAeE
	gSjQ47gOZHDt48aHrrl7hbxCClIXoO4r55Mg7642jQQ+DEcTgGpIbxCbC4R9GMOuipBS8P
	aIykU51XXYJuPcHtJR7uYZVJLYQ1y+S9m/UWX2f6HYKq1dsye/jy0FLu/Qr4JqZb2nngu+
	hO3oz3vVmItmSxgYvnrYkPKOxgMJTEF6Hklqa/WtSbFn4M/6moHcyGUqu7zEppHS3R4NPp
	YQ75B0+rEUj1a1V/vwonumOlR+fZG5M8FiB9ydxr4+KifQKWqFC7OVTqdTB23g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0OOltyhkR/M6InnbHS9JUDyLIT88qYJF+hevCB6BgZM=;
	b=VXYvagEpxx6Fa8i0WbbxjWambBjYhynt90dDCAe8Z/EGMEh0I8yzvUk99GetsCfOJ3igNs
	Zs3Ae+paOJ3HgXAg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] x86-cpuid.org: A machine-readable CPUID repository
Message-ID: <ZpkckA2SHa1r3Bor@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On x86 CPUs, the "CPUID" instruction is used for runtime identification
of CPU features.  It takes as input a leaf number in the EAX register
and an optional subleaf number in the ECX register.  According to the
leaf and subleaf, certain information regarding CPU identification and
supported features will be returned as output through the EAX, EBX, ECX,
and EDX registers.

Due to the extensiveness and long history of the x86 architecture, the
amount of information that can be queried through CPUID is huge: now up
to 800+ bitfields, scattered over 52 CPUID leaves.  The returned
bitfield descriptions can also differ according to the x86 CPU vendor.

We would like to announce the x86-cpuid.org project, which aims to:

  1. Standardize a machine-readable language/syntax for describing the
     CPUID instruction output.

  2. Build an extensive database, in that machine-readable syntax,
     describing all the publicly-known CPUID bitfields output.

     Such a database will be properly maintained and act as the standard
     information source for multiple open-source projects downstream.

  3. Augment the CPUID database with usage hints for significant open
     source projects like the Linux Kernel and the Xen hypervisor.
     Usage hints for other projects can be easily added later.

  4. Provide code and data generators utilizing that CPUID database.

In the project's machine-readable repository, we have covered:

   - 52  CPUID leaves (and all their known subleaves.)
   - 835 CPUID bitfields description, filtered by x86 CPU vendor.

Attached to the above CPUID bitfield descriptions are:

   - 274 Linux kernel x86 feature flags (X86_FEATURE_* definitions)
   - 230 Linux kernel /proc/cpuinfo flags
   - 198 Xen hypervisor feature and attribute flags

We have developed multiple "code/data generators" utilizing the above
information for downstream projects.

The first generator produces a complete CSV bitfield file for the Linux
kernel's kcpuid utility under tools/arch/x86/kcpuid.  This upgrades the
tool to complete CPUID coverage, and a kcpuid series will be sent as a
threaded reply to this announcement.

The second generator produces C data structures for all CPUID leaves,
with detailed C99 bitfield members included.  We expect to use it to
standardize the CPUID registers representation across the Linux kernel's
x86 subsystem among other goals that are to be outlined in future
series, such as a dependency data model for the kernel's X86_FEATURE
flags.

The project's documentation is extensive, and can be found at:

  - https://gitlab.com/x86-cpuid.org/x86-cpuid-db

At plumbers last year, I've discussed the origin story of this effort:

  - https://lpc.events/event/17/contributions/1511/

At the x86 microconference this year, I should also provide an update on
future steps:

  - https://lpc.events/event/18/contributions/1762/

Thanks a lot,
Ahmed

--
Linutronix GmbH

