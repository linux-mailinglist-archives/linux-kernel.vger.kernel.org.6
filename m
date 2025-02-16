Return-Path: <linux-kernel+bounces-516507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B37A372FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FEF7A3832
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5D1624D8;
	Sun, 16 Feb 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AkUPlBJF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21F23CE
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739697059; cv=none; b=O5xxCBzuJ7N78OjiuoRE15ugFa7wc4+4sIjKEsIKTsGQKydu7YIFzNxLUBFw1BgqDFjwurEaAckINL8MdpGihBR4eNErXkHMso/7HNrxrh+kuFi49piD5+B8BkREJolOPe6C7hGljzTtC0I+8eyB9dG054V25IwGXu+h08bCRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739697059; c=relaxed/simple;
	bh=ISWrzmudP6yy7TpsbT5vNHX/223JuQIIBGgXeaWSCew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uwmey7U80M2XIjRL+6E4m/lWR0SEJvrPTU0q8/YyYgVU9+SoD1TY11aRv/8NPYqMtbQzj9NUvAuuXh9aMtMkjzK3HW2JILfWk+UeOk3RtTtWOoOW4HletFb6m/r5O4tz+IrTC0eDn22PcYAz3bq0ns8vRTrs8SQNgcL9C16sQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AkUPlBJF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 098E140E0176;
	Sun, 16 Feb 2025 09:10:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 77PU4uzVe4mD; Sun, 16 Feb 2025 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739697048; bh=3TjvKEcG18tI11OvPN4kPtQptRY/6siHC9d7Rv3qshQ=;
	h=Date:From:To:Cc:Subject:From;
	b=AkUPlBJFRBXN4w3vsapi4LdDnTXCBtzL8+nfNRkiqCLRF/HIAjz4ao+v0VitYoPCf
	 i9xPCqZjZV5PsZpP1wb7k5maRPCZ6uzOCI/yWXppWoWHlGuHyEcoqSSJaTwCMkbT04
	 G6F7t95dgVNtV/nLb/iWtFt44Nkv+nW+NRBh+8012R/t6JuOT9gvv7dcIFb/l3Fb20
	 wfiL81bLmjJApQGCbB9b8DHmAqG/J4pD7sYDC1/yzs1Tt9gURis8IgOp4jzXgafDvy
	 kO6ugZADfJ+lMG4EPWxMwavpqOtcK+w/ofqICklF877N6vZrYOm5EFAw5HBISPA4Nd
	 j4joyoJzt6/QR13h4AY2spCohtXLuZfWzHcz4zr5iYvoN78ttHJVHRu/SrbnQDXL3c
	 SfD4+pBzaJURBYFPj3CQAHTgVEDGqi/z/cgxH0zCVUW3UM5VcPfNsAMoyVUXn8Xj7K
	 QRYw1+Anx7bJqe5P/558osKfgyZYed1O3BwjNGCCcu3nOUbHc4yzym8mjf6/CNv2gE
	 fwoGyzPBQJL4uCV0gEsqutdjsZkO68zsIUK1WkvtB9Hn5/1rgGpApulBDnb3QmqH/r
	 3mMOEe9kUkHuzTRxnancKrsYq1tX75BDTp9nJeRTwJj4Ti3p8nxcF5xpGLyvaF7gv4
	 gS2fz0sP7dmtbnCujKBjRdps=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05EDC40E015F;
	Sun, 16 Feb 2025 09:10:45 +0000 (UTC)
Date: Sun, 16 Feb 2025 10:10:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.14-rc3
Message-ID: <20250216091038.GAZ7GrjtV16Hk0TmHk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent sched fix for v6.14-rc3.

Thx.

---

The following changes since commit 9065ce69754dece78606c8bbb3821449272e56bf:

  sched/debug: Provide slice length for fair tasks (2025-01-31 10:45:33 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.14_rc3

for you to fetch changes up to bcc6244e13b4d4903511a1ea84368abf925031c0:

  sched: Clarify wake_up_q()'s write to task->wake_q.next (2025-02-08 15:43:12 +0100)

----------------------------------------------------------------
 - Clarify what happens when a task is woken up from the wake queue and make
   clear its removal from that queue is atomic

----------------------------------------------------------------
Jann Horn (1):
      sched: Clarify wake_up_q()'s write to task->wake_q.next

 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

