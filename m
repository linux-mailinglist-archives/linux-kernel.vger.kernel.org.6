Return-Path: <linux-kernel+bounces-321405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A18971A10
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5661F234C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5D1B81CD;
	Mon,  9 Sep 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HjXgkzD9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898531B9B4E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886477; cv=none; b=TnLzD0dU17ZbxtvAH3wqe5A07lLq5S+g8XNAH595e3m8roNfzK6NxurGvV4L3OzgFxcqqtBrSBVmYZt4pRnpovejGOHH5v+SwrrFXj4ByOv7nYOvu+tZPEighaEOXJW/X1FrnL5E1EIegQcYVbIGTlno01JZ3Toaeg3I8jlKhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886477; c=relaxed/simple;
	bh=DVbM986IyW579UYCKg9Lb1GAUJyV+XhqiK+uh+mTIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KaeGMtsC9Yd619CeCbItlDfEzCnuzHmieS73mCLs2MgsiKpll2dKigrwT5/gMJekf/wppNDbs1o5UkeYOQ85tTJPNEl4Sx5f79lmUL0zRvdoPwL3BOZx+OU64wQ8j3689ljl8ekGypcpFlv4VPWc5+DqX0uY+GWRCm61JKBTzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HjXgkzD9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4648E40E0263;
	Mon,  9 Sep 2024 12:54:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3Ivji5yppDpy; Mon,  9 Sep 2024 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725886469; bh=4FSbrEYnsWkb0afCRJQAb/dUFren8K3Wwu02nOYx6cs=;
	h=Date:From:To:Cc:Subject:From;
	b=HjXgkzD98L9GURCCM785nMgUsVlXpVIAGYPJckLl1RIBtUJpTEOGk6oOlIZNby86g
	 RRRM8tVLutekuiJdTy4ooRuCjdWWvcHx3prThvHyE09dvO/FiXKlmW4Bp/PrZ4V802
	 7WiRzvUfRMB2O//VQdDPFidYCaDPOTTjrvfRoigH6alF6Tuyll9Er+ix30BL4BIsDu
	 FfVCddMCTZwAsgQaV8baOETnWp7UlWrZEStFJd4lSQQBvV6WBSnLLGP4/eFztx0ZI8
	 9vSHbf/FINN54kgAI2iJGXEEOYVdctZrhpb6kYiQiXvdDeLBKhDydYCMxAqwDzDQom
	 RXP0d1ikouxIRs9XOGBJw1fDvhOFrDIv3LLcWKQBDxuD/hIy8jcGcZDI2KC8SWbPJP
	 shBvczyrLj4+WoUNP4liyLM7toMu307yqzp4lTpjrehK4qwABN7Tyq8Ef0x62BR/nQ
	 /tS8Mj6/m3p8PBimdmSUxn8mfCfyHWvnrtX3n5KqzxMXjx+DPTqavEe7PE5JDHpEjR
	 HE4H6tUCd+GfML2HKorRiWzkbYrm1G1JdKHDiQTJTEFqGA3T4RXp3f+riwnA8t01PY
	 EmpH+jHPpKwTfY4TMz4WErcwVQm4KLRSLGtLRD6W0EokXuR+wka+SgIAdKDLBa+3lA
	 63/CDJ3nywzqJ067AcZMJ9WQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47BBA40E0185;
	Mon,  9 Sep 2024 12:54:26 +0000 (UTC)
Date: Mon, 9 Sep 2024 14:54:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.12-rc1
Message-ID: <20240909125425.GAZt7wAapqHkBB-5cG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull some x86 RAS updates for v6.12-rc1.

Thx.

---

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.12_rc1

for you to fetch changes up to 793aa4bf192d0ad07cca001a596f955d121f5c10:

  x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error() (2024-08-01 18:20:25 +0200)

----------------------------------------------------------------
- Reorganize the struct mce populating functions so that MCA errors
  reported through BIOS' BERT method can report the correct CPU number
  the error has been detected on

----------------------------------------------------------------
Yazen Ghannam (3):
      x86/mce: Rename mce_setup() to mce_prep_record()
      x86/mce: Define mce_prep_record() helpers for common and per-CPU fields
      x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error()

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/amd.c      |  2 +-
 arch/x86/kernel/cpu/mce/apei.c     | 18 +++++++++---------
 arch/x86/kernel/cpu/mce/core.c     | 38 +++++++++++++++++++++++++-------------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 5 files changed, 38 insertions(+), 24 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

