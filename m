Return-Path: <linux-kernel+bounces-436329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39FE9E847D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EE51884A59
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25D13B58A;
	Sun,  8 Dec 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="klGdL2hZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151201E86E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733652432; cv=none; b=tgW5QskRxBjbGAS6zSljTa+mVMcFBxomkAGPLtWSx2+12erj/kSYB4JuUsTOJ+EgFCyPzhctPJTotlmyAsMRaMGDFjkWWKSpTI4Om7xYN6yNoicsogIBwRVAy6G39Ztnf6MxXVsXQd9HkWVTsIRhxxteXTKqnTo3YCD//U16KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733652432; c=relaxed/simple;
	bh=u3Vn3lViwvSCw/AWTLzfSlDPfauvacyr3jKbrbNC4ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pARddrPNPDiyodCGjAextFeWie0rsOrIv/rk8Kgwu+KBfV2uWqzVYhjbuHJaB4dAqzJRwBscqVzCAUXiomJZCPdsBamtDmU7b0BTUDII0YRQp0gr4GRj0M5IoPNzii1qAF3D+vG7qmTGm7HXGIIcNQUzlkhr0iA30x6LPfeyDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=klGdL2hZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9866740E0287;
	Sun,  8 Dec 2024 10:07:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W1QS4J8024k3; Sun,  8 Dec 2024 10:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733652423; bh=S+RD1yGbVgdN95hahBEB41eBjCuL70/RxY4VJYO3OSU=;
	h=Date:From:To:Cc:Subject:From;
	b=klGdL2hZtmRBc3jm9Bo03re2hhmjvVstH2s+6WdW2TmhDj/NIh7RiUELYGqp8UKNS
	 w/H27kK0ujWU8SmSiTc+VsSMx5gpFsPoo58Qv9cGk2IGA/3eF6zhrGctXl/AfOt1Av
	 2vZX9HplROWueug3RNHtscv7jB4dzCQwzkPApcUt68vT4GgG6XLFkHX0nOcjxeIhOc
	 vVDYda98B1cKa0wMHBQ6ZnU/mXPxgJhD95XphYdeXMA3R9TxJANSdHNYssKl+NDDTp
	 wWCxyJMImiRZ9KbsDIxF8ajWNe84fJt2KRRoQNjxm/rD4+aYT0qYJQvRc2avuRXPi6
	 qzPRFz+nAxuzUVa2kmhV6saq4iUMS2So2fFl1L42GmeGJoP4Ajusxosdnw+oTDDHDO
	 BWWIXkAIV2feaVfg4XTwHVQjhHHpWTMaCHkA+W2UDxZYrNbjfTv8jNepZo3Q3ssQmf
	 GEMA3Y/E5Exu815sxp/fOBtuZbUjSdisAGmujcsYxHfx+wRrPJeXRbL3TbOknM704C
	 N1i8I3BnBMsNa06atFqUTY1j9Ido61jhcDqvvUtL3tq6Qn5qXVH0e6zeUyg2fDY+pY
	 kJofJEIUZ6MnbCNlRTwQ9hZiTZtQQveTD43FnU7DDBcap5A3BjrhvkG2Wr5uLx0YrE
	 XcVEAGl+cRftLsc1M6quFNk8=
Received: from zn.tnic (p200300eA971f9358329c23fFfEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9358:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAD9E40E015E;
	Sun,  8 Dec 2024 10:07:00 +0000 (UTC)
Date: Sun, 8 Dec 2024 11:06:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.13-rc2
Message-ID: <20241208100652.GAZ1VvvJZA_sViqSL0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent timers fix for v6.13-rc2.

Thx.

---

The following changes since commit e70140ba0d2b1a30467d4af6bcfe761327b9ec95:

  Get rid of 'remove_new' relic from platform driver struct (2024-12-01 15:12:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.13_rc2

for you to fetch changes up to 76031d9536a076bf023bedbdb1b4317fc801dd67:

  clocksource: Make negative motion detection more robust (2024-12-05 16:03:24 +0100)

----------------------------------------------------------------
- Handle the case where clocksources with small counter width can, in
  conjunction with overly long idle sleeps, falsely trigger the negative
  motion detection of clocksources

----------------------------------------------------------------
Thomas Gleixner (1):
      clocksource: Make negative motion detection more robust

 include/linux/clocksource.h        |  2 ++
 kernel/time/clocksource.c          | 11 ++++++++++-
 kernel/time/timekeeping.c          |  6 ++++--
 kernel/time/timekeeping_internal.h |  8 ++++----
 4 files changed, 20 insertions(+), 7 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

