Return-Path: <linux-kernel+bounces-250090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C551092F425
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A041F232B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B329460;
	Fri, 12 Jul 2024 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="cGX5LLRU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaD08SoQ"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4268F70
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752309; cv=none; b=qZ0hdafG6zxGZf3J8oOSNWkyQp69LUhIdQYIfJnhtoXSfjFYPkV4FUePde7OK1qWB74wfoCYn8ylWdtKvHtZ7pjmBG+LKXxzHTUvdJeyYPfY1DPo764sFhR/mEY9jAJWLy6xonVz9Gb7bKnKq4fXgdIyyb2Gt03yVU/wnwlOVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752309; c=relaxed/simple;
	bh=PinMlmzLmmq7KztT2fDEb93yYErd8hJTdF9//UQnfKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGLxFRHNokX/MaOXGDb9pcTKpaHcc4rr6DDcQTJD1i76NcVR13kajqzuscBcNy4Fv9H56cW5z546wEX4damDubSumFQabeTE68XcLhyRJzO6VnsRzP8qM+3phitKwFB+ZCWW3BkFH4AGH4GuX+XlJu41/lAZU/FGKKLeiZPpzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=cGX5LLRU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gaD08SoQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B165E114158A;
	Thu, 11 Jul 2024 22:45:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Jul 2024 22:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1720752305; x=1720838705; bh=mZXQybFJfj
	4oW2kR9aus3Dkh3XdyBd8HLQGRekYCKZM=; b=cGX5LLRUb2PZAgUTusLHvdsUrO
	Y7A9YYWE/CdjEyqHuxSt7AijHCdpZuewiLmMjgwdAn7JNea275wrOAdxsLnq5mfN
	zZBKNNu70qAfm8hKF/0dGaJEoVJvvH0TSA6MRwARfVQfSV5A1/EXREhTdsFN//BT
	qdGSUzZ8mlQpyyiJ4tu2ULABC0TPw8mdsXO77Z8wmQ+pRivZ5HC5mSPY4DpWkhax
	bQ0iwHl9r6rVy3bzAA4qKvaKU6oOtRgUOs0g6VYMyglrevbszveorYHJ1zD3IKIX
	Xt+PzJJlEmnaNh2L6ZiU8x3sAv7TrLufeBmX4Pu+Tsm2o+9tEGYMncDXsfFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1720752305; x=1720838705; bh=mZXQybFJfj4oW
	2kR9aus3Dkh3XdyBd8HLQGRekYCKZM=; b=gaD08SoQKUgO0Ncqp6huEs3QqY0dv
	jX22KgUAGW8lh0zyK+hQOyw9rN9C4KY8/xc1ZF8x4rFN0YCOO629hKJ/SMSs0yiK
	CLcbq0nvoweWPC3rMmboPn8TIOydYMKo/ayTaKPmD0gv1JlEb/JY+8PfdtqFmu6Y
	MsXzkdo3z8f2/0LFZ92idNfwt4h5gHtLxpqVqc+VOAg0ZL4TsVOAS6ofzTnSKCP6
	1OY9lh+9qoimewFkHD4x9MehYMUKt3vCpyLckCOpGlbeyJCk/ctG8UKf9sYJ9bVx
	pLEUf6Dn1l2JWQEJmQSCuBlEFPbj4yXu15i04pXN+TjLsCNH6/atQS1zw==
X-ME-Sender: <xms:sJiQZlHaEYSYOOtSKa8wchWjY3YsPxZB0uMntaKTp-FRrBZgrLG7EA>
    <xme:sJiQZqXWYA67Joufqqv-PdHMwwW0sE9ill9Jxv1ODWN_HgIU5dc8-6EGQHUvwwj_O
    hbfyvf448kNPMSamw>
X-ME-Received: <xmr:sJiQZnL6jw0tvIOUA6fEr3dLy25Jg3wF_hvHFBVAbgNhbLrTKcod83Vr9Vi-d4XDbWzYc0CRfotu4FQ0PC5YcfrQr9qsONI-r1Z0gPhOWnjTuUPgO1A9wqqr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepffejueeife
    ejudejudfgiedtfeeltdfgueffhfdulefgtdekteekfeejheekhedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnth
    drtghomh
X-ME-Proxy: <xmx:sJiQZrF6SyP6s-KV9V6uIIWoeN5xHn1q9Jwhibl7a2nACCWfVQCagg>
    <xmx:sJiQZrUHzqz5_lkoM41Ym_puqe4RcS-Yh8zditnL1TBmHI46DVba6w>
    <xmx:sJiQZmOCaEAmgHvFmaAZS93qAioLIE7a3XfH0m5zcS3ScK11RW_6_w>
    <xmx:sJiQZq0HhtF4V6ePsHdQ7xmWt31v5HAu1fClE3QB1-ljGNyKzzJcpg>
    <xmx:sZiQZiFUcX1ydHrR_PlcYmR66kw008C-661_HaWrImrXg4cGRO8HGNbr>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 22:45:03 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Fix and refactor do_{huge_pmd_}numa_page()
Date: Thu, 11 Jul 2024 22:44:52 -0400
Message-ID: <20240712024455.163543-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

First patch adds the missing sysctl_numa_balancing_mode check. Second patch
introduces folio_has_cpupid() to replace open coded folio last_cpupid check.
Third patch consolidates code in do_numa_page() and do_huge_pmd_numa_page()
by moving more common code into numa_migrate_prep() (renamed to
numa_migrate_check() in the patch).

The RFC is mainly for third patch. It changes the original code behavior:
1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SHARED.
2. do_huge_pmd_numa_page() did not check and skip zone device folios.



Zi Yan (3):
  memory tiering: read last_cpupid correctly in do_huge_pmd_numa_page()
  memory tiering: introduce folio_has_cpupid() check
  mm/migrate: move common code to numa_migrate_check (was
    numa_migrate_prep)

 include/linux/memory-tiers.h |  8 ++++
 kernel/sched/fair.c          |  3 +-
 mm/huge_memory.c             | 31 +++++---------
 mm/internal.h                |  5 ++-
 mm/memory-tiers.c            | 17 ++++++++
 mm/memory.c                  | 82 +++++++++++++++++-------------------
 mm/mprotect.c                |  3 +-
 7 files changed, 80 insertions(+), 69 deletions(-)

-- 
2.43.0


