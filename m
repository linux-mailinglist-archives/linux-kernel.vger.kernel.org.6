Return-Path: <linux-kernel+bounces-224496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B0912320
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBEB284EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16217333D;
	Fri, 21 Jun 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBvBso8v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8sG/1VoA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131B172BA7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968589; cv=none; b=lPVADko3ItRnh53W4CGI1GPHr1X37j4MF4RZyiLkEQtpATBFK2rKNmHbgAUvi5OjMazprHYF50vHE7y1vnrlb3i4Lzb7Zk/zFy/mu1O93nCk0laOtjiC8jfmFAQPIouQF/gfU5S0YZtNHQAAZvXbqwRDbxb9z2tiEMNvQyUKtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968589; c=relaxed/simple;
	bh=R3Ht2yHWob+Yk9kzNn3o5Tnnmax1Df7Le29IazoKMwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B8TihwP5ECBSmzwcKAVe0sGmabQKWfvDW4+DDC7DqPR4YjoMG7grBymph8OAo+HrgFClUo7FUOzZ5i7XDxJHzD0H3w/EuRkF60aUjInudDZppJtzul+AKjeYoRFtgLB7XQNOj0hHTVFwQwTgVW9jnEuMbUbERQdMALNdPpZs1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dBvBso8v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8sG/1VoA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718968586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pK4LesHt0Lj5TZzTaC1+kQyCtxKUpIst24nsrRCZsDw=;
	b=dBvBso8vUDQfZrIottnlH76/fXWBZCI93DwstMFZTpm1nmmn3WDJ7t7QABTWRvRk7IrUYe
	fEqbpvVExILbpfD93opZYMslIpy7fvPAjJJMqk6GAlVHNr01NRXpzpBd9xVlGBVK7uB5ER
	aoiJjpBQABzeBq2f08NyQukTmeLyoYs/CoahzVBDZ9ZT93O8kfi8L7zHq2b4AVP6ipf90a
	WpxQsAMhxa8gQ/xL8yirGgo8S80EqFbNw0WqEHgNMF8nq9AG1NVEoUuKWfj81gpMDb1KHU
	SnhNX3jKs18Z7j2a1hfarBdR24nhMp38+Q289BseAOQx57EmTi1hdlgB9uN9Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718968586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pK4LesHt0Lj5TZzTaC1+kQyCtxKUpIst24nsrRCZsDw=;
	b=8sG/1VoA5CmoCJtREw3YK/ienn75fxYMqmbjxupDSN4kqdSecjlclY+NmZX33ap8PQZkl2
	bp2uHECh/LK270Bg==
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	vbabka@suse.cz,
	willy@infradead.org,
	hannes@cmpxchg.org,
	anna-maria@linutronix.de,
	tglx@linutronix.de,
	shivamurthy.shastri@linutronix.de
Subject: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Date: Fri, 21 Jun 2024 13:16:04 +0200
Message-Id: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A W=1 build with -Wenum-enum-conversion enabled, results in the
following build warning due to an arithmetic operation between different
enumeration types 'enum node_stat_item' and 'enum lru_list':

  include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
    514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
        |                               ~~~~~~~~~~~ ^ ~~~

Address this by casting lru to the proper type.

Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/vmstat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 735eae6e272c..72ecd46fd0c4 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -511,7 +511,7 @@ static inline const char *node_stat_name(enum node_stat_item item)
 
 static inline const char *lru_list_name(enum lru_list lru)
 {
-	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
+	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
 }
 
 static inline const char *writeback_stat_name(enum writeback_stat_item item)
-- 
2.34.1


