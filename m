Return-Path: <linux-kernel+bounces-516535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A750A373A4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5A3A4CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292B15539D;
	Sun, 16 Feb 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PbIfEBwl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01968290F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699287; cv=none; b=bTtPeghm6mglPQ8hjgRK8moXHgp/SHFQwkFlXNSoWuXQqZn664y1eaI2NGWdskX3zKnNLbMyeGWiDIqPm7RCFqWudzddqHpqEBoyzxFsJVGgXq502jbt0Jp/FdS5eWsb10clGxGfwEBFc5gsDBNojApw5Foun7+hF4wYk751/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699287; c=relaxed/simple;
	bh=ElBr53ityjoXsjxGolFWfW41cNlBwy8j7C+ID80nHhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tk5DUqgn4Q+8t2zcwx4z7L5BI6WyeYlNHjFmJ436OYqq02xnizejPY0IMsTohujJtd5DKbleOUoiuyMIdvlB0K21wN7Adbg4ujvDaKg6TnmACnLjRF7jIN9s6SJxOghoLNU1JHBoUe44ORATUIRW2wKMmVNHRWUlTRZSKTh5flE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PbIfEBwl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D723D40E0184;
	Sun, 16 Feb 2025 09:48:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 68dDbt179i65; Sun, 16 Feb 2025 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739699277; bh=ckkn2ZdXR5GbRLKHPfTZHp/zXJacxZCqOYk2dd+ySHo=;
	h=Date:From:To:Cc:Subject:From;
	b=PbIfEBwlHgb7hFXtlkd2fatk0J2DzO3jra8bC9HWC3a/s6Tm4GuYzX6Fi8hw0UD1A
	 lOXCZVQmNpyS+/nL/mGQxCEJUtAH2Ufoj/568sEb9OzeKMunv1ZXmSt10DaYOWJVjN
	 S4k7+QvJNsuiVgZL/6tD8q40w68lVQYiSEXjKuuVadgnA/uzMzpMZb8WYnpv42ENnN
	 toI+Sa971SOtXRdChdok479/jGUenZmXz0H/zgHj9Q6tFZSR2c6WbXiMvAw9UZqfWc
	 QYzDc/avJ/q3zlNOgN1zPpGi7+eoKcrJ3C0tAHltt8at8qUpEs9xH9ndasvLOf6p4L
	 R4PLQZbVuONZfoDc11HCQ7GARKjWwQynOetkBzEuHs6pVCrg8qzfF3Ch0uXt8/B7Ys
	 gLoCEmV6ek5KEHx3XNXsTmwZm1nTZ2ovKIc+2cdDxbG78mOOOO11W8+du/PC+teqy1
	 Rdzn/5SmLesWlF5jIMY+QoHDKgiPwU6tbpAMbaV9ykRWq99+7/x9UCcZvBaQHEnNIG
	 lfalirzRP8YTuQLeXzsk1exRIIGNlzShLxzfWdBnC6qKxxU08QZN+gqqPPKVWunAJm
	 RKRkmVzUANMPEoZW90SJQ8XE1PspNy7aWYjlWSL4w2wwE2Vl13eVOcJf4YTmor9JP+
	 QiYrQMFBTujdvgFj4EIvEEUo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F7E940E015F;
	Sun, 16 Feb 2025 09:47:54 +0000 (UTC)
Date: Sun, 16 Feb 2025 10:47:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.14-rc3
Message-ID: <20250216094748.GAZ7G0RIr-bVZOHJ0i@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the perf/urgent lineup for v6.14-rc3.

Thx.

---

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.14_rc3

for you to fetch changes up to c631a2de7ae48d50434bdc205d901423f8577c65:

  perf/x86/intel: Ensure LBRs are disabled when a CPU is starting (2025-02-08 15:47:26 +0100)

----------------------------------------------------------------
- Explicitly clear DEBUGCTL.LBR to prevent LBRs continuing being enabled after
  handoff to the OS

- Check CPUID(0x23) leaf and subleafs presence properly

- Remove the PEBS-via-PT feature from being supported on hybrid systems

- Fix perf record/top default commands on systems without a raw PMU registered

----------------------------------------------------------------
Dhananjay Ugwekar (1):
      perf/x86/rapl: Fix the error checking order

Kan Liang (2):
      perf/x86/intel: Clean up PEBS-via-PT on hybrid
      perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

Sean Christopherson (1):
      perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

 arch/x86/events/intel/core.c      | 33 ++++++++++++++-------------------
 arch/x86/events/intel/ds.c        | 10 +++++++++-
 arch/x86/events/rapl.c            | 12 ++++--------
 arch/x86/include/asm/msr-index.h  |  3 ++-
 arch/x86/include/asm/perf_event.h | 28 +++++++++++++++++++++++++---
 5 files changed, 54 insertions(+), 32 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

