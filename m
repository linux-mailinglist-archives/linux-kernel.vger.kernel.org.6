Return-Path: <linux-kernel+bounces-251760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97A930974
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF1B1F215D2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF14204E;
	Sun, 14 Jul 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mx59djeT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7323B1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720948651; cv=none; b=Bj8kfzUJnHhxmuKYA5tsvinj2qBGdcNYX3jYmk5zO5taizGCQTueDqFI3E/78vQmoeiD/AgOxw34bGFDH5hn5yGrKCM+ygVfBYvP5M+SLfjngdRmGZ66RWJa5FT6qqhDiSqlJwf3BHh/IkvltztFptgrMV84xk/KBDrpaB2m35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720948651; c=relaxed/simple;
	bh=rv7LDe3Qo1wUSYX7lQ1p8xwzehFSWgI28QXS5Kkiv2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ce07+EIGwmIWMzM6V0J6Oor9VsoVF/tDm0MTUWQgjkOIx29IWzSwElgEAwmiZJYSBkzsdAUDhG91m32lI+MxwGvhtrzllhtvuED5gOz+5BmDrJkaAfXulXxv3CrXVvJw4DE19XqhDII9dihQRmg6GilOs1us+K1NYU0TX51ES2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mx59djeT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE1EA40E0219;
	Sun, 14 Jul 2024 09:17:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oNHOIViBCzlQ; Sun, 14 Jul 2024 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720948636; bh=nScQNm6Vp9EafM+8tULBzPWDbQTx7FrZNyeJtv0vWfU=;
	h=Date:From:To:Cc:Subject:From;
	b=Mx59djeTRqnvsgOuNTE4bF7OoBQIg5lCvEP3/4KZNaKkisRziZC8c/tbHYYO9sCEa
	 hydG1fFEGThLjMtN/kD/xFAU7m8AvrohNdzv99awDxJE5JcOlXZrJXxXcr6PaD6DDh
	 j18TyLmxdOX9Ywl0eQhFTsOfdZUm5P7cvwAg4vk6r4xvr8OgNZI+RNOssbFEaSB8Ou
	 0bWKUnFPKjuFjkeDtkE5sO7QnrgJ7CTsfofmBxImzkUGSk06JNRM8Mt1lB7YiiW6RU
	 lcl0C3VKpKWBpaEMtB2QLtAlPaUaIc3I61fOl1Of6+ibGeW9NC6hJkHR3Y4/PCFC9g
	 /FRf8g1yWL0j3a0CQwlOpv8hBU9475Uw42mAYcVB6uQgryX71jlte/gVxbd3IKd0ub
	 nVBw208HBJeib+jxbFcSzARUgdFi6cuCiqgO7udxGGtWTQ7jF74B0K7OgXD4V9PMwT
	 AjehXLGiPpXLWSnzTRsCS3fcfOFaJEjQhB/oKiT0uNpyA1LxKlAsnPx7j7HMPPQsep
	 DwghNsdnDD4hB0HT3nVulVmaGcUQKZewm4gO/EAS6/XKl8A4U/TG+MyTedoiieEtbm
	 zYLWrxqG3DbwYdWyg0Wf9SswJ1OHnNbuez1fCEsOY05+z9ZTIRqfwaes35nZMVHmFH
	 UFkrmrTAPTK121bM/WZec07Y=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C306540E0177;
	Sun, 14 Jul 2024 09:17:13 +0000 (UTC)
Date: Sun, 14 Jul 2024 11:17:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.10
Message-ID: <20240714091706.GAZpOXkrEq7nE6-Tue@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull one final urgent x86 fix for v6.10.

AFAIK, nothing weird stands out in x86-land - I think we're ready to go.

Thx.

---

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.10

for you to fetch changes up to ac8b270b61d48fcc61f052097777e3b5e11591e0:

  x86/bhi: Avoid warning in #DB handler due to BHI mitigation (2024-07-03 13:26:30 +0200)

----------------------------------------------------------------
- Make sure TF is cleared before calling other functions (BHI mitigation in
  this case) in the SYSENTER compat handler, as otherwise it will warn about
  being in single-step mode

----------------------------------------------------------------
Alexandre Chartre (1):
      x86/bhi: Avoid warning in #DB handler due to BHI mitigation

 arch/x86/entry/entry_64_compat.S | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

