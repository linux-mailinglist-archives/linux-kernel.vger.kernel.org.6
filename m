Return-Path: <linux-kernel+bounces-252397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BF1931290
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CD6B20BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDAC188CAB;
	Mon, 15 Jul 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TDwsHkQ7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE8187876
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040400; cv=none; b=iOx66qWmM4X4pkNvoTskRVZwzOqR4VLM0sXpFFTU/8g33zvaRLJS+cWpnjNlwS/2VG4Z/XwQBo1Z3bZOC1btAmMGS4tXAx18AHf33ZrAWYMCVi22VDKtddMKVs46GX3BN0v+zUtG4GsFomMJmodAtPdM/9oydU+dNyssdTmMb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040400; c=relaxed/simple;
	bh=CwOo8NaJLNmJEZKdA1WAC/NL8RPQXM8XrRqhohO97S0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GtlqWuLRqoyoPcfebd+JKq/fuMtHddQoCkC1w35ZtDyB62fBc/2scAR2+DhI6Azxi2jvETexrwqN1Wd/aDOcwKt5xT0EwqIDDHktisW8XQs9T4sb0SwPTa1pvYGnAS3irQT+SOcgmHs0ODwpk4iadoqf0PASEA6p78b5JmMxMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TDwsHkQ7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1D6140E021B;
	Mon, 15 Jul 2024 10:46:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZQ6G7toqsk-f; Mon, 15 Jul 2024 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721040390; bh=RBWMgRYf7a9xNVMq0E8WN+8BHfE3VZ5k8tOSfQ2ZyU0=;
	h=Date:From:To:Cc:Subject:From;
	b=TDwsHkQ7cihBSws71i7vQui+fKRBj7S56ZRzetaGw3ucqapiXBIiySCK0Sdxebb5R
	 JpPqnWBecoZwRceIep3oZCnqhiGufwRFmT3bNWtbMlTm/k0hw0hp1clZFqwf8rJvwP
	 dfXE27z2XS3gjpRHapDc/xzIsMAfaf/OiTs54EMY743o8noePNDq76VCCRlqjlslXv
	 hycFDWOEe55PmiB2nKfObjBFOZNk18vH8w2FqliLT2rSbUFYaUu8qgHznfDvONiL+h
	 MMMhmcfj3PLYb6+lN1e8EbXnFZqr3wmLItA0mY8KTWXHgwXQNHP39g2f3sZonMtlUK
	 GlYd2rSAJQva8mHoV6JPnboKFEoGQglIdSexZQmR1tnIXgla0tuaxn9eVSUkg3liXW
	 Z6Ddr1ds5HgJfYlt+CFbujZOZt/d7Fm4bXXwedaM6xUF9Gqpdf3fd+xMeVTvsBDKL+
	 kWWRyek913t10TSNPZwb0czO6ZXuHkAyRuUSHqrS8+A0Domq3JWDy9MACwiCjCfNbe
	 4SUIYgPpbteSAqKcuAU3HsMoMzGGxw2yyDpEdJhjI0jJ1qHxrI27wCc7Z2fHI3p5L9
	 o7xdL8HfTA0EB3JQuy4ZkgkK0wp0ld74HcdBKSC/88AKKt/UysQ2u1yRPMWq+tW6y1
	 K7Y1+vwCDSHTyOLzIeliFqso=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57A7E40E0192;
	Mon, 15 Jul 2024 10:46:27 +0000 (UTC)
Date: Mon, 15 Jul 2024 12:46:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v6.11-rc1
Message-ID: <20240715104621.GAZpT9_YnUJpJAtq00@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull ras/core for v6.11-rc1.

Thx.

---

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip ras_core_for_v6.11_rc1

for you to fetch changes up to 5b9d292ea87c836ec47483f98344cb0e7add82fe:

  x86/mce: Remove unused variable and return value in machine_check_poll() (2024-05-27 10:49:25 +0200)

----------------------------------------------------------------
 - A cleanup and a correction to the error injection driver to inject
   a MCA_MISC value only when one has actually been supplied by the user

----------------------------------------------------------------
Yazen Ghannam (2):
      x86/mce/inject: Only write MCA_MISC when a value has been supplied
      x86/mce: Remove unused variable and return value in machine_check_poll()

 arch/x86/include/asm/mce.h       | 3 ++-
 arch/x86/kernel/cpu/mce/core.c   | 7 +------
 arch/x86/kernel/cpu/mce/inject.c | 8 ++++++--
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

