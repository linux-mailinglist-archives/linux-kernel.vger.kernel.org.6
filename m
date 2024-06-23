Return-Path: <linux-kernel+bounces-226006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A68913901
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C6C1C209DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66525A10B;
	Sun, 23 Jun 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XcmiDVd1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95515E83
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131015; cv=none; b=XXyIZgjS/qFrwbKwUYsT5TLxLJmwRV9ZhHZ0f1OkzPE6KdDYe87+lO8lf3pmnLZk4RBcm1whUnbVaBGg/g2rkNG9GX5XBsNtfWu8ZGNRCEqUTjZR2qFkS7UyZ5AN+J/zqymGvLMKP61FKQ03YhOUf/9SL0Em0AatW7gzzAJyepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131015; c=relaxed/simple;
	bh=g7HLKh3I64pTchYEP21ACw0QOLWjCkA/UGIbpYIH2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O9/RL6lhL2NEy/vp5QkodxGcNMS59r86YpONQimscfOXik472ncYll1JSU9YUIHLGPYcNSwzAXdaM3er+CIh0XyScXab0EoEZ91Os1LiHNKSQ/zNRUN9Zxm34IXcqdog5uGdY9g7IprbZlsaBOlQzlHsE0r29MpExcWANcMPUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XcmiDVd1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 41A4640E0219;
	Sun, 23 Jun 2024 08:23:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rtIfKzB4RjS9; Sun, 23 Jun 2024 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719131000; bh=die/TGwHezGHQuB0ovtlhjiYCTuSD6YwCsOCgLJVN7s=;
	h=Date:From:To:Cc:Subject:From;
	b=XcmiDVd1tHeI5USc8QFt1nOyeCQRAYOdRLDheNmV8vc7ysxOmGEhsnQpWL2AfBUHG
	 fhPXiKoJupKWVGT170kBMjmvxmHsK2/VAIXxP9qnrMuFflu1un4BppVPqk4BTcrI1S
	 Vk9iLOKt/35M5HSwGABUNcUL2OtlPfeYiUBx7yOnoz/X0hj4FdHbSBtU7ImMjiDg7p
	 zX3pPDvYP/zfxUCiT0pnCVjVEU3dLRMZ+YuMBz8wtgPEo3rWdG10+Rw4cnINY25DMH
	 fLe5AtRquRN7JDc8FBHDoQSeS5AeI0LvpVxm1nearta+l+VN359+zQb3KIH8omH4Cg
	 1QyzMmLlavpNv+lisR7XTG+Y/XGEvytT012OynciCZn1YwxTDKNqwbhPAAphVxSHJI
	 Yk+PkJKJ/BRAEQG7nDgImYxZs9sU3wBfVmx2AmF3zPG+fEFo/InogyWZsnmHDYm4ot
	 sfOt/x2n+k+01GRgnYPwipCoklAAUbWSVJ7VIElpMOh8yffnJdM9VXmClFe5UDP7o6
	 ojQv5wCHo7zzDSWn7obIJZB7RtRr86iepkjte/blNKSmfs+1M+8eZFfc+lcP9+KFhi
	 ldIU8BU5QNw57C7Vk3ALDELBhbZOMVOprviFuKJiQL09TQzmmrcyi8SQhVEj4edz6a
	 OwHW54r7bxtf38rQK3r6GNok=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9481740E0187;
	Sun, 23 Jun 2024 08:23:17 +0000 (UTC)
Date: Sun, 23 Jun 2024 10:23:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.10-rc5
Message-ID: <20240623082310.GAZnfbbi9ZV1nEpkpE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two x86 urgent fixes for v6.10-rc5.

Thx.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.10_rc5

for you to fetch changes up to 739c9765793e5794578a64aab293c58607f1826a:

  x86/resctrl: Don't try to free nonexistent RMIDs (2024-06-19 11:39:09 +0200)

----------------------------------------------------------------
- An ARM-relevant fix to not free default RMIDs of a resource control group

- A randconfig build fix for the VMware virtual GPU driver

----------------------------------------------------------------
Alexey Makhalov (1):
      drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency

Dave Martin (1):
      x86/resctrl: Don't try to free nonexistent RMIDs

 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
 drivers/gpu/drm/vmwgfx/Kconfig        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

