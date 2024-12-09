Return-Path: <linux-kernel+bounces-437175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C79E8FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CEE1883546
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1E72163BF;
	Mon,  9 Dec 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cSgvStN2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B514F12D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739478; cv=none; b=XynX2NPbTEX+ZVVM/t2ZpDfWem5XT1fMw9bE3E+3S+Sum5nHeUHX/YSgshBSbHsfYqbSZfZL69arhWG/GS4unE22tQazJ0MeOpOsvp6fmjCcmomD2fjTTlg6fCkCksggZzc8Jt/CuQt9w2W+8prQYFCXqOd0WyNcTXFnZ4zucKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739478; c=relaxed/simple;
	bh=OX+NiaBBQaZ6QXs43yBoIxB79i0GYB1gL2bPRsHgzNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mJTAs6sek4o4mK3eFyNF5CCZQKmvvhBmeaj8+37LN0uhPdw8XeDdy9XqPUG54WlIiD7Km9iQMOry1IznQ2pdouvm3DLaAXUs0j0onmOCLlf3FYygliavOzM9oJqv4uJ/lkr9gtTwWL2mXmKgNOkVXo9qSLkWgQcu69mOMCjLP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cSgvStN2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1873940E019C;
	Mon,  9 Dec 2024 10:17:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dibf56ZuA81p; Mon,  9 Dec 2024 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733739471; bh=iqB2uqxtPw9nmaOXDL4C1SI0ytqIAJ3r8AlKVB0FUqY=;
	h=Date:From:To:Cc:Subject:From;
	b=cSgvStN2M4vZtgVB9zfe2SfrQswJdk4DLXdK53WKYO+4aVMSMne0mHFf4LD3Z6e4Y
	 lHX/V3fsicWI1eqlNIm9JD0ITuV0a/KYEDGvYig2Vdga6gEFoOJdvOFPxKHPk1aG+F
	 69YDvaLNd4mbsKwzc1vqcRimKUGlmU2nb3xJyDfnIvkwn3YhB3qSb5llrgYRZ7ZObJ
	 R2heuM7Nsdo55+5j4Xjg/YQ9vb8CNia7rZdvTO2tTOZ2SltVRDnGkzW9QxFOd+NH2U
	 9jNLEMG/0UxVpdsoKzvb3sR/BDlDq65txpJuQUddvGSUFTCQvlKniLRbE10z3vsypu
	 INKZo0RJL7hfDdlYbmUOg1A+6EdlYYLW9UK2c6zzUkP2t3DAAlNITzFYTnRk0ocoPm
	 H1sGojNapXxz6uKO8wsB0grknKCf8mGM6OJb3rI7IDK5jKyKLi5qcIxHHezTq86C0e
	 F5cA20t1Jd56wrOew9V9FJW1fDTMuKICFGGa/BfY9CReArwsn6pIeGE7DyRjDC/ErZ
	 0IMVSgDoeNNIcGcd24psixo48eOM+Sskuu0cYs9Amanf3GyBvnDehDETCP9wyBIYpE
	 cdS4Pb/s7cJ+/D628aTXjbr5voIZTAfxrXATQgKN6sQd5Iyb16Ep02uc30cIJuahzA
	 /OLWLld79Pw7GqDRe9bfhwJk=
Received: from zn.tnic (p200300eA971F9346329c23fffEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9346:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08B7040E0163;
	Mon,  9 Dec 2024 10:17:48 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:17:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.13-rc3
Message-ID: <20241209101747.GAZ1bDy7XMTKoRqs1g@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the locking/urgent lineup for v6.13-rc3.

Thx.

---

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b=
37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urge=
nt_for_v6.13_rc3

for you to fetch changes up to b4d83c8323b0c4a899a996fed919cfe10720d289:

  headers/cleanup.h: Remove the if_not_guard() facility (2024-12-07 11:15=
:14 +0100)

----------------------------------------------------------------
- Remove if_not_guard() as it is generating incorrect code

- Fix the initialization of the fake lockdep_map for the first locked
  ww_mutex

----------------------------------------------------------------
Ingo Molnar (1):
      headers/cleanup.h: Remove the if_not_guard() facility

Thomas Hellstr=C3=B6m (1):
      locking/ww_mutex: Fix ww_mutex dummy lockdep map selftest warnings

 include/linux/cleanup.h  | 14 --------------
 include/linux/ww_mutex.h |  4 ++--
 lib/locking-selftest.c   |  4 ++--
 3 files changed, 4 insertions(+), 18 deletions(-)


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

