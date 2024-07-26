Return-Path: <linux-kernel+bounces-263784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174B93DA76
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DE31F24159
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868A15B986;
	Fri, 26 Jul 2024 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNJiSszU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197215B14C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031066; cv=none; b=bmyNNjSk2+X9y9Zh5UnKtK5Fl/FImHp5V8Bgzw0XZVwm4b5oq3wVwVAziks4PeM/ghqQJlwkhpDvNIRduD3a++LyFdOk6f0HPtnA7AuzoMQqbEq47+LRQ4FZXXxhDbdG3qHANJ1e+1hggE3m+yJ0Ag0/8vJlvuoL+e/AF8DqYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031066; c=relaxed/simple;
	bh=xSTwda2GjtC4wyMIao/A441KBqg4odJRHj3hK2x1g+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om4rkXd0wJnkwJwjFxtv18chy583J9rcNcs5sG7ePO3P+C1KJLb4W5M+mU2UkDMqVrwyBQeIb8XBNdbDvPABFdnXbBPWOT+BcfyxfvKSei5Hp1XWGAi7BJsxstaPZqeUM+d39uR3KeirpLkIlT4BE64Jc4AbRbdHhgNXf4YS0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNJiSszU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEAAC4AF09;
	Fri, 26 Jul 2024 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031066;
	bh=xSTwda2GjtC4wyMIao/A441KBqg4odJRHj3hK2x1g+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNJiSszULYtzhaeEVutUpqJehUbmWxSB6jq8VWOWPfAZdbHMxbimJX7PAPIKb+rCX
	 W52rkj7eh6tAwyR8729dwXxsywgY8xzA8VBFr+v2kTGuMnpKDvsv1NhQBNyZXe5t0+
	 01bV5vKyjTeG1oCaskaQOhyWG0qKuvAVy5laatvcHYtQ5BlQE8ER+P3CHL5deVon20
	 /J3e2MFPcvAexLrmDbabvPFF2loz01wv2FpsqHyCNxkF/0bpaB4P0ISCX/bAd7HSex
	 ZUsqxDXFzSeoxk0tsvawONxFpR1xpWqnzoXRtkGhxX2Kqohw7My6WB+nP6z0KMxwOp
	 LSSFCfUmNrGAQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 16/20] mm: Allocate kswapd on its node
Date: Fri, 26 Jul 2024 23:56:52 +0200
Message-ID: <20240726215701.19459-17-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kswapd runs preferrably on a specific node. Allocate its task
structure accordingly for better memory locality.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 94359a893b4f..adf8c1e7e89d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7284,7 +7284,7 @@ void __meminit kswapd_run(int nid)
 
 	pgdat_kswapd_lock(pgdat);
 	if (!pgdat->kswapd) {
-		pgdat->kswapd = kthread_create(kswapd, pgdat, "kswapd%d", nid);
+		pgdat->kswapd = kthread_create_on_node(kswapd, pgdat, nid, "kswapd%d", nid);
 		if (IS_ERR(pgdat->kswapd)) {
 			/* failure at boot is fatal */
 			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
-- 
2.45.2


