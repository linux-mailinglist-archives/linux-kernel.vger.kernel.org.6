Return-Path: <linux-kernel+bounces-263782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FA93DA74
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB451F23E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1C15A876;
	Fri, 26 Jul 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfaHtNlM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC315A858
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031062; cv=none; b=T9DmkILJsLGKokuewNLsCkRizVSk8auox8cTlRFtdlo7XD6Cz/JnmkwUWt7GJIQAokF0+vxQAhkFo5wBPdsNOOcp/XOZkX8d8aRGxTSmeswpXhPfZxDSYdE1UtAqee1ZALYYbs6ztSh6NggNeKQtC3aXWM06xPJwJOLTxbRw1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031062; c=relaxed/simple;
	bh=0SibR5bQwBKFRBO45aA49JEwgVAnlIbZLSKlUtRYW0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyqPxUz4KnzGKwch4rEXFRu3fHMdtbpnbVhkmpfhQ5p+IavAFOxudoCNh6932SnF65Xkm5duJJJDewSDUrxUgyssczW35o37l3jl/EMx162q0OKUw/tP8hOA+JKYZ4/ELyNaCf+K/TWJGuKLUylwbJpVlSTcFnRCSNZzom/WAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfaHtNlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A550C4AF09;
	Fri, 26 Jul 2024 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031062;
	bh=0SibR5bQwBKFRBO45aA49JEwgVAnlIbZLSKlUtRYW0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfaHtNlMZlMJahhsPYP3XpnKrqeJqsjfxxstfWQNrL9lYhrDvZtANMo274OaJx/WR
	 DK06QKky13O60roB5A1PC+pKD3hZucY4vdLhblwxyPKDFOePStfUXAM/+oCpScsUF2
	 VQHCBe3uZD8wqdoKdHhmwfxBAD00C1S76vldsuXXYD/yILvkN86vgtKpOVHSbLjCIo
	 ixfo2steYAN967ul7maL36yPU0W2mRJU0P8dmMoi6Vzt6t/ObrFIeg0/+AxrxQFv6U
	 cmkFLHddcdM3frJXp9chc8owG7UMLfzeBceiOIUjFtLAUGktjLI922jIcKN8lmkBz4
	 /9K0TNVD224dw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 14/20] mm: Allocate kcompactd on its node
Date: Fri, 26 Jul 2024 23:56:50 +0200
Message-ID: <20240726215701.19459-15-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcompactd runs preferrably on a specific node. Allocate its task
structure accordingly for better memory locality.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 64a6486f06e1..dc4347c4e352 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3252,7 +3252,7 @@ void __meminit kcompactd_run(int nid)
 	if (pgdat->kcompactd)
 		return;
 
-	pgdat->kcompactd = kthread_create(kcompactd, pgdat, "kcompactd%d", nid);
+	pgdat->kcompactd = kthread_create_on_node(kcompactd, pgdat, nid, "kcompactd%d", nid);
 	if (IS_ERR(pgdat->kcompactd)) {
 		pr_err("Failed to start kcompactd on node %d\n", nid);
 		pgdat->kcompactd = NULL;
-- 
2.45.2


