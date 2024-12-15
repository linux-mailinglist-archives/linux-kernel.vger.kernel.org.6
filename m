Return-Path: <linux-kernel+bounces-446371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564229F238C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C71F1652FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813C15B0F2;
	Sun, 15 Dec 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MoR/bXM4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C1176FB0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264015; cv=none; b=IVO17xgFZgIs9fxVqYsIRN1J1KAKuAWj6EiiTih82NMdz3X5L4Llx4QdbJ3iH7XRYzddXijjCe5CptgpmS7qYJuYTTQA+FWrGgWm1vtrARWTdko7Sne/bysglPLEu3yd91Cz90+c5//oyPXf193ftXr9HXyvUAN4Ine/8K/R/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264015; c=relaxed/simple;
	bh=hLZPbKvAmOHP5ghaLADqj46JseSFPvZpUTsU9dpIhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YdV2r3oH643lfrm7qtMlgILW58hI0An6WnJdT/JM8cPLC9T+l2genhNGH0unAYwBBPen9006gcrpp3r6d52PiD5Ma5eo3k1e96MaUXU1S6jIsaB7rSP5SNXmqjWwQDbS6s5R0qK4TXC6iVWsOvsq2NRUwGjL8dR0slcXWfSa5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MoR/bXM4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20EC340E0263;
	Sun, 15 Dec 2024 12:00:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G08Xu7MDpJvn; Sun, 15 Dec 2024 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734264003; bh=VGVjg9gGvyDg3ZADSAvldODgaKhoRaH7H7E5cm7jR+w=;
	h=Date:From:To:Cc:Subject:From;
	b=MoR/bXM4m0U5+C1J4FVcFUHR5SXE7sXlcLFeKfUM6TvsE4E/HaI52eDGFC/U/Dx4N
	 u/ua6pVEcjHFgexoVwqIHfMNEMqVuNU1cpmXt0umMzi+zESXkL5NANFTBxlEu/OxoB
	 gWn8ey2Q7Pd8E8D5NKzJ49GxZteXblGARi1NZN4MTJy+QvHhJGQZwRAVS1bAXjwm/A
	 00mkHWcqjBe6/TCQT//rT/5cWDjz4aK4o7HZn+WbYOI76lYLqV346878Ry/W5QZaQk
	 w2LI3a4zG4K491pL760eOZo8JAAaWy5ecEPYIcW9G63phsWhR7ma91xqZiJNsgn3fv
	 UxTwE4wA1ZQSn4QVT4YhiScZxvNqtWh3GB75gnEWs5y/uCwnycNPyGa1K//ZbWg0IG
	 Ojrnm/LB3n4ZHOCMPOAdp/QHhcYik0FWkcwCuRfzPKbvPdnGhVQEnweGLqsxyD4S30
	 acSGgVVai6gLn1YKjOHedbdnQ3sQzjpYT1nP+UN5wk6REEg/qZV1/r1YJ/hDC1NyFA
	 4ezBsg13WWVuNoItla0kUrJdneg0OxCZqeEYbA44iRLWoKIvmQiX1KW0/I5MLGWfX8
	 S0y1I5GaaLR/sLAV1NCzO/viKEwDjJvv6cWnRD/+QwOCwR5xdasmt4mTagcKYU6pbY
	 yVZT8YahXSNRN0t4dAMl8hQc=
Received: from zn.tnic (p200300eA971F9324329c23FFFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9324:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B85D40E01C5;
	Sun, 15 Dec 2024 12:00:00 +0000 (UTC)
Date: Sun, 15 Dec 2024 12:59:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.13-rc3, part2
Message-ID: <20241215115953.GAZ17EuW-ZrT9oIblh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull more urgent sched fixes for v6.13-rc3.

Thx.

---

The following changes since commit 82f9cc094975240885c93effbca7f4603f5de1bf:

  locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex (2024-12-02 12:01:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.13_rc3-p2

for you to fetch changes up to c7f7e9c73178e0e342486fd31e7f363ef60e3f83:

  sched/dlserver: Fix dlserver time accounting (2024-12-13 12:57:35 +0100)

----------------------------------------------------------------
- Prevent incorrect dequeueing of the deadline dlserver helper task and fix
  its time accounting

- Properly track the CFS runqueue runnable stats

- Check the total number of all queued tasks in a sched fair's runqueue
  hierarchy before deciding to stop the tick

- Fix the scheduling of the task that got woken last (NEXT_BUDDY) by
  preventing those from being delayed

----------------------------------------------------------------
K Prateek Nayak (1):
      sched/fair: Fix NEXT_BUDDY

Peter Zijlstra (1):
      sched/eevdf: More PELT vs DELAYED_DEQUEUE

Vincent Guittot (1):
      sched/fair: Fix sched_can_stop_tick() for fair tasks

Vineeth Pillai (Google) (2):
      sched/dlserver: Fix dlserver double enqueue
      sched/dlserver: Fix dlserver time accounting

 include/linux/sched.h   |  7 +++++
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  8 ++++--
 kernel/sched/debug.c    |  1 +
 kernel/sched/fair.c     | 73 ++++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/pelt.c     |  2 +-
 kernel/sched/sched.h    | 13 +++++++--
 7 files changed, 84 insertions(+), 22 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

