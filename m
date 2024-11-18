Return-Path: <linux-kernel+bounces-413160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD69D1458
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1366F282E63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41019AD7E;
	Mon, 18 Nov 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K/cKf/xc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F501A9B51
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943341; cv=none; b=OQoqsRi5m+qORF7V00CXlMFfV1mLYb0s3S26h2bbhlv9x5EfgF4iWwvnjlZWQpxbhz/0Ez1klyBeBM2pQ3Vp2TxAtnqOxnyOuFpV+5Syrs2MsY2zXeXr3uojXTeDf97OmFxpNpx19bB7WnmSLZuH38kSPN8ZRhMhueed+jIkmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943341; c=relaxed/simple;
	bh=rfscN9LreANPm71G6IcmzMglWMfix8zvLltWpIltm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LLAj+OrHtof2Cl+5Rb7Os+lIsgAAFA5HZQtpM1j/X8wfkWs4BN5rMYLw8Z9sf39OR/9WlL8aXflPcKGPwD3NDvlILOb9dZJvnWlk8A4EUgEuvND5fu2dMQ7CPEODzJ/KBhelwQ3r1Dlp8M1OCFo2y6WHKpR3FPJSE+qyp8FmYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K/cKf/xc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB28940E0261;
	Mon, 18 Nov 2024 15:22:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UmJOoXyyW1as; Mon, 18 Nov 2024 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731943333; bh=yJxQxwiuDlZNdXpGwAeh8WpiaiQhI2lII45pzAIQxuA=;
	h=Date:From:To:Cc:Subject:From;
	b=K/cKf/xcrxpw6h38RmFPrPOJzaj1FqGMhehibBCqDN5FEjuMJnMJZTo9ehfFM/TCL
	 ew7KN5slGi/oq6p0I4ASwewhm1mPyZH+O2FPGoEJEvs426Y3NLTmjpBmX2iA7kTOZj
	 cXLvdeUNp4sAEPD+j0sf9ggHP/3jgusoKPtAMZEVadBVp8wBZ6fOJK4p3PsusZ/irp
	 5/G5SwycRD5zGuScaVc2wibi5aYUqLIMn4gZQxOb8cQMZzBWhZ6Gqhx5cRx4xRgc6J
	 nY3vVyVXLzfCeX6lhF27A9HZXMOc52hTWzJL38Y5apJn1y51r9A5wg5fphBIAPf56f
	 ANQmDH1Ib9kb8qzHqFlKziOI0vXM6o9nWQtdR1NuXJdk36h4ji6KKVwql+Z4NNz/pZ
	 b/lnAP+svYerK7R8fvDr9wW0ztdYF38f8aDms2hO5JlI+kYtSP1W7kUWhfj2nOUnl4
	 j6MAOnU8gZFrdeW2/p62za0C0dMk4LAbX6pcEVeoJK5WBlnVWIokfI+/2YDFxW8elV
	 ZFZSrgA0/KczvDKji2yZ8rnQGQIcq087XjI8u6FzFUjOs2lJgGXCF2yqyYelgJ50Sv
	 lugPWHbkUMQ/pbRmwVjUAiqbG5kY7uVpyiN+VEvaqEaJD9vxh+Q9MCbLb1gJ7GUYcH
	 YaBgjVWtgeNFF0WwcPHYGraQ=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66D7740E019C;
	Mon, 18 Nov 2024 15:22:10 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:22:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for v6.13
Message-ID: <20241118152204.GAZztbnHMPrcQOkacl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please a single x86/platform cleanup for v6.13.

Thx.

---

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_platform_for_v6.13

for you to fetch changes up to 90f1b42b179487ee77d182893408cc1c40d50b13:

  x86/platform/intel-mid: Replace deprecated PCI functions (2024-11-11 11:59:21 +0100)

----------------------------------------------------------------
- Replace deprecated PCI functions used in intel-mid

----------------------------------------------------------------
Philipp Stanner (1):
      x86/platform/intel-mid: Replace deprecated PCI functions

 arch/x86/platform/intel-mid/pwr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

