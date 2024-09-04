Return-Path: <linux-kernel+bounces-314974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071696BBA7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D441F21C29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939E1DA613;
	Wed,  4 Sep 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdrufKEF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5jUHUeiw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E91D9D63
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451547; cv=none; b=GHzxm52WuXgndeauzMsvaNr+HPWKpPEUa/BdfMFKJv3Akjh5/fCWbgxT31jDJF/hOJGn1TBVm7Fec9Yt/Oj9/R3x8pYBDgzwDbd7vtSdqMkVWeuLCVRdhXz1Uy8n28PpW3Kr1ZKp28b1/mhwuMtF9pQzkiw6/XmofSAql0RHZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451547; c=relaxed/simple;
	bh=kwwonIjNbiF+nIWxN1xkgRulkm971AS9mlpJ3YgsBdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BT75vsrZ+L9qMMc/3uC3vCM3lvZpAfV69JeglelZUV2IG4k/KdVCRlozf7mh8tWsb+jlXS73IkvLpaFCb/9vnk6VsIy2X24nVe9bq2YHhTEDrdsPs+EThiixY8rD83rLVOzvZiEEeJXXjjDz07TPFTwz4cQC1EQO7FWOmFGi89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdrufKEF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5jUHUeiw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqhp2BqfbOC269R3Gq7Hb9GO3OL9/GpefoaZ5mnrWOA=;
	b=FdrufKEFtdu7RxRmd50bKPhwpeO9r5Alks+9H8yf4dmlYFPyXIgqomZRGgCEwaKfgJ8gmt
	dvQIOuz0Vd3TCU39MOYL0cpKcilnq+C6CrezmsR+L1YL6v2n3nTgos0PSY+1bzspK38voO
	impeVWKRpocHyiczbEjw+vV2tuQTer8kVIFsb1cLoownR9ejhnmlqoaWMwxXGOA+ysTE9g
	TEMpnWMnXSDJqh1W2rZPXmG9zMJBjLL3u9jH4pFgq8T1x6Fvmixt6Rj0901BftoyA1lngz
	NP89ktwLMS+PB/ozUV6sh+KzRcHyfEnl3xs6qpMZOMEywBs5FVcyJBSsr6FojQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqhp2BqfbOC269R3Gq7Hb9GO3OL9/GpefoaZ5mnrWOA=;
	b=5jUHUeiwxRm7K+1EWN84syTiM0SFzkO6RmpY6VXkCh72j7JhBaVUatQA6XLJhs5lLyfB2s
	L9+bb1Sf2NXsloCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 16/17] printk: nbcon: Assign nice -20 for printing threads
Date: Wed,  4 Sep 2024 14:11:35 +0206
Message-Id: <20240904120536.115780-17-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is important that console printing threads are scheduled
shortly after a printk call and with generous runtime budgets.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c  | 6 ++++++
 kernel/printk/printk.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 98440889d222..fd12efcc4aed 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1321,6 +1321,12 @@ bool nbcon_kthread_create(struct console *con)
 
 	con->kthread = kt;
 
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(con->kthread, -20);
+
 	return true;
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 66cfe7b8f95c..afd926611f0f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3555,6 +3555,12 @@ static bool legacy_kthread_create(void)
 
 	printk_legacy_kthread = kt;
 
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(printk_legacy_kthread, -20);
+
 	return true;
 }
 
-- 
2.39.2


