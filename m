Return-Path: <linux-kernel+bounces-575585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA94A70479
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B37F1891FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB71990AF;
	Tue, 25 Mar 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bAuWqNV0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32D258CD6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914819; cv=none; b=K9AUZAhoJbx/NkJdZe8lpsyJOwIlCaTNT505rDi370OUbjB2S3oBq+r9cZh1Uw4buSyj918vyyoblKydg/7OfwaPbObfUrL2J3Ab/nNJ20z5A8NMN949X8nJQw0IlGl9uxpJ+rN3ezG76o7xW6OnuG2Yp4kt89VO7oc1IPm2B90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914819; c=relaxed/simple;
	bh=h3uRvVb+0ICGMx0LfqKOcjSmYhpqbNlOGvum+Ghq0Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jk/XyI0GjRFv0SiGV39UmyACoiILP2yiz+rDW0V6aweh1501dSPw7zbxo5Ww6n3GiNuyY4rzCsqGXkWIVoEgsB4ge5Ov1oB/u8TJiqyGDu9vnZgERkkQ4YTPgNXuq/BCHzI3HCIA92pIHzOJ1wor52hlV923CJYDPysI3L7zNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bAuWqNV0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 23B4940E0219;
	Tue, 25 Mar 2025 15:00:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TUSoyLxPEBCb; Tue, 25 Mar 2025 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742914810; bh=t3V/3rW/HEY2R9g3mjaWW4qaO0Zv73LHgVqmtFGKwNY=;
	h=Date:From:To:Cc:Subject:From;
	b=bAuWqNV01lZt5yJsaZNANZpN0y1QJnedHSa50luyx2Ca7VAtnDpFgjPDqZX+OlL46
	 AZoqG54SvkYfOV/75jPM+ZvH51O3+ecQsABtbnvqzrJpvCxff+BtzzeI9bh/+v9ibo
	 8+U/A9+ZufYBuLS+Y4O69D5tmvrbzgIGE5PMHunJnBHLqAxW8DFprZNIi3d6WaJ+jE
	 ej2QYMJrcqPnWXP9aYKTLK5FwOzIFKl3lCE0GmCPbKXFTxCzFzoVDLZUky74HBfsyq
	 +eJEEtJjgdTtVydSbO6d+d49YvJ9f7u1CneOc8JSZJ+rKaI8tUzT//2pqDueWC8roL
	 uqAz+WOkRVgwVQ2IK3xh4nXl3q3aQoj9YtzmxCnb4lGBmHTxb6XjMXLxYpDx3Xy5xl
	 NSWVKXw27X+mzCQeN3k6YF2vM/gBslBH7/OY3U4KEarsf1Yh8IlrPcsAlOhzVckoe4
	 MJveThLML8dAO9Cs1f6rQS3X+vTEGI19GtifwWjnNiwE8O8shbarDiRKyXTkO9fHes
	 JtlwDvqsnu6MpzYrhgr10R1vzQ0Duv3txEjF+7ctLymEkHjAx3thJ66aFmgA7lZQss
	 1IMat8W+rqZ9T3p3R7B3Oxe93H7tHICzxe6kWo2syhdxvjEFlFwgqBi1IYD6bzW/p0
	 jOLL15SFuBBTwfEkhet24Abc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9077240E01D1;
	Tue, 25 Mar 2025 15:00:07 +0000 (UTC)
Date: Tue, 25 Mar 2025 16:00:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.15
Message-ID: <20250325150001.GAZ-LE8Zk2JIGck0qW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single RAS cleanup for v6.15.

Thx.

---

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.15

for you to fetch changes up to 6447828875b7d768e4ef0f58765b4bd4e16bcf18:

  x86/mce/inject: Remove call to mce_notify_irq() (2025-02-26 12:18:37 +0100)

----------------------------------------------------------------
- A cleanup to the MCE notification machinery

----------------------------------------------------------------
Nikolay Borisov (1):
      x86/mce/inject: Remove call to mce_notify_irq()

 arch/x86/include/asm/mce.h       |  2 --
 arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++++++--------------------
 arch/x86/kernel/cpu/mce/inject.c |  1 -
 3 files changed, 22 insertions(+), 25 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

