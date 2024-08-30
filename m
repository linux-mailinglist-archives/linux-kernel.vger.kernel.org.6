Return-Path: <linux-kernel+bounces-309047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C7966585
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55961C23224
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054E1B5EA6;
	Fri, 30 Aug 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXiPA8zH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bumET0S1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDF1BAEE8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031773; cv=none; b=AUUafnBOrzo0J3h3W4AoefLi9hrgAEgSueLXrme8HAb62k3SfMj+7aGeqAfYTkpwByT+n1UVHpDmqBibSX4yyA7ypZF447YIyYfJ4VU2Q1F7W7X8Wgqjm0VOoecOQzuU+5UJtBg1iiERfaie3pyufnspPaETCs2B6nqGShgBMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031773; c=relaxed/simple;
	bh=dMJ3G22DaEAmSBEb+VUjJdPyBO6c5j3VTVlMc7Ixp+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLgmD+sgLMAmFe7CnpLUGl46YjtCQciTSBO3XBNB4EcS60LKeA7HVyND+4n9idVnjGNVHT8mrlNxaA/IA1XaPuxQTXlVOI2Uaydj7NneHgZuXRFNTEwbaGNMSR1Ojtyj4W/b8Moy9dH/PihTp0cSrDm1eoy2hoUe8m/aL92YY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXiPA8zH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bumET0S1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfMaXEid6qzuyKyUebh6BXsmnCqdBipNozQCXlzM1e0=;
	b=OXiPA8zHAiiaMmzcbFIUyl4xvYf9wprbYJ6KqANKSIurPTOg3lQFqVwoOO0nrJGoSBV6JW
	isyrFLGqCOKYJZWfQNJJSLC51X4Q15hccDW18Zb9ExKrOsLV0VB3clJFLrEnzAMGwsNvrB
	IQ6n+bOiTW6G8wd1Bg/IoNwNGO0oo/LnHHcR+Z20IvI8lYa7+5eUcWIbafENeTXwxEORqV
	CoBcv0QL6msLJ7SNxHjMlrc3xvBrqGY3Q08UHJngYalC429eMdxamm3ll8TTvfBA5dLgQO
	rLojJ+uEeQSRTUXQ1asMwPZj7Qu4sQ94mvHXXDkTISih5sELwc1wRAz5+AuDWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfMaXEid6qzuyKyUebh6BXsmnCqdBipNozQCXlzM1e0=;
	b=bumET0S1tur+oSlfT6oxF6LA+rIkmBB/S9+vIlP6uAEidXrw1YYNWxSGWMH2MiezuevctR
	e4EEUlFEYo8/LmAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 16/17] printk: nbcon: Assign nice -20 for printing threads
Date: Fri, 30 Aug 2024 17:35:15 +0206
Message-Id: <20240830152916.10136-17-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
index 1559b5dc3075..384bda9b1019 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1318,6 +1318,12 @@ bool nbcon_kthread_create(struct console *con)
 
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
index 1c6afb0ed4d2..c4a6aaddf8e6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3553,6 +3553,12 @@ static bool legacy_kthread_create(void)
 
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


