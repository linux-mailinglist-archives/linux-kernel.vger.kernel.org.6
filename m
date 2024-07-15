Return-Path: <linux-kernel+bounces-252434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B499312FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BD82825FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D3188CBA;
	Mon, 15 Jul 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TnxjyKLD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E316CD36
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042626; cv=none; b=lXzT0z9hq3KrZI0bckSdblDAS07LBGzbzyw61uPRQcUtN9p30yRlogMcKFppDba4QpbGR9DChlmJbskJ6rDHMLtaZE0VZvKcgkEzOsNRDqfKtO9DplB7sORrcplBHQgDswvrFL3XzUV56zIc2qYD2SVgH7lQR+bbxXogYF6zbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042626; c=relaxed/simple;
	bh=OQtKlEM90EGGXqPFr7eTy5TGYT9QG36bLVo6XMtrfXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WhpamKyVfugOI73qNBapvtICIKHCS+Zs8/Va6MhW4jg/8PlEQ0IXAUEqAJJ0XybGY7+Om+HOKGp5tqHJARr+7xbqPDGhmheL2Q6jEdcefUxVbf0EFU7+K0pPH+q0Duf0gBVN84jatlx7KC2403cIHd4Py/epbphe7ma+Rzo+BNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TnxjyKLD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 607F940E019C;
	Mon, 15 Jul 2024 11:23:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kmRqgXZyKDmj; Mon, 15 Jul 2024 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721042619; bh=MP1CrB4sQJUWjZBO3Jfu7c26FIeYv3oaH9Eqc+I4mlI=;
	h=Date:From:To:Cc:Subject:From;
	b=TnxjyKLDkVuopm8xQpRLERXc44buppVNclDDmWMnAb4ByIbjY0KQ2+Cf8Uombi9LX
	 VvEK6/NXc4brWTwM84G/XIEVhOTMeXRqsG1OBJmZ6XE3U69UbvQc8n1IhFUUhnRwhD
	 HNZZyhhGny6q3g7sDzi2GPjqI+0sl41qLOuOU3r5jKiF3768DR/HhXLAqpeQSC2qSt
	 /GQQyTge4kBHIoPQAUF4XAnHFkzbBSBKJOiMEFYvFR3hM4JJPjErmVQnYQd/ogGUBp
	 vINdE9ic0ZPpThIwjdGwZARgoz5Igh7FsGTSkygK7zKSt+q8ENY1LF9GMSFAoQSirl
	 GXMzh/8EXUmnLDgFPADbYK4eQ9NkrO6TH0f1g+6BIrTVjUXZwEHtyTLFf8cnJJH403
	 TaBtc2n3Xcbe56QJp8sovnyiwtbKhro4PJfSKjdrSZw+G4OxVKf4zTTuY81VA6JXXc
	 kQ6hhvYtTBJyrMf4fh9bwtHDG/fVAQXxzwghMlzXamhAGhrfo9FJeoPOfbDPoF+xFn
	 qW4pbRqP8yMgWoVQnxAmUDUAnRlUmX1pvZaPZ2wFgcGkGToBThUbcW/yU66qeEIDKy
	 C4PsbbvjClOJB1ULqqntOfJ9yJaVkhgd4kD6rcmqtXPOeaXaj6woeD3X//lTsWy6QE
	 0+nI7CMegxrtwILU+Cn/WxZg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6486440E0027;
	Mon, 15 Jul 2024 11:23:36 +0000 (UTC)
Date: Mon, 15 Jul 2024 13:23:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.11-rc1
Message-ID: <20240715112329.GAZpUGseCodLDRBpET@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cleanups lineup for v6.11-rc1.

Thx.

---

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cleanups_for_v6.11_rc1

for you to fetch changes up to 71315037cb7d40cdb2f4fbefad31927f6e6caba5:

  x86/boot: Remove unused function __fortify_panic() (2024-06-14 18:08:45 +0200)

----------------------------------------------------------------
 - Remove an unused function and the documentation of an already removed
   cmdline parameter

----------------------------------------------------------------
Nikolay Borisov (1):
      x86/boot: Remove unused function __fortify_panic()

Thomas Huth (1):
      Documentation: Remove "mfgpt_irq=" from the kernel-parameters.txt file

 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 arch/x86/boot/compressed/misc.c                 | 5 -----
 2 files changed, 9 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

