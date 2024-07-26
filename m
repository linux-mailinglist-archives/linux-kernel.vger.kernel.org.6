Return-Path: <linux-kernel+bounces-263769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684CC93DA4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED158B23285
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF114E2ED;
	Fri, 26 Jul 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaadakLA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16614AD19
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031029; cv=none; b=OCPIXvc4lcOpA3nljNVxpYnnrtBNReb9OfoX10q6YU/nYFmfZYeD1/+LL4VgDxikNRVuPpKU03sjlg0DYHc+2USPjgvnXHyYnx8MH/CixYeRhUxPvgx9NcSVxKIeoqYt1RDJrl2EnRJ7fpbB0Z2DN11NpMFs5HzA5v8bxIHRlrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031029; c=relaxed/simple;
	bh=+TkN7tN2uMXDLL+Z8qGtECBNBa+6qsa5rGwPPeI7P3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3lJrv/D3yZaKQuKZx/q8AwriCGbmwk8t83ZCK2F2PcdL1roFfYuvRTPDjHhRSkYC9Zo1aeIr1uho77/FYCv6nbzR97aAHiV+lbe4GS1amLgmymkWJxqKagHOI5cYxGXWRgJ9auzXSDm+sZsRWIXpAus/iY9Tg8wOLqeL1HcUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaadakLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA81C4AF09;
	Fri, 26 Jul 2024 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031028;
	bh=+TkN7tN2uMXDLL+Z8qGtECBNBa+6qsa5rGwPPeI7P3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaadakLAefQ96ENToJYEMPO1xO++rukkGM5rYo+n2HftEC1Pib2oOjdosseUCGpYc
	 rUBAASveV6B3Ft9azUwaF1UYZGq2YJLcrDKH/5sKCx+EeFYS0uSJuSkhwUCg/QEmnP
	 QstZC5gmx32fTLp/vHMvYonVE96dPBlTg1IGlx4d84vw/d9ylTrghwMPabMdrBIbht
	 2TzVZAmwSVB41MnZ/WjKuQHTRCvE57gIS/ex4yWwrC6koBLBbnfmSxOxqruvhiMO87
	 QJk/fd4kYxW2FjJNnfvAfMqiXLtspliBlurelJm1aQmgx+Esgd/aE99FWg2oGLvlzQ
	 jx3PuYwugg9Lg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 01/20] arm/bL_switcher: Use kthread_run_on_cpu()
Date: Fri, 26 Jul 2024 23:56:37 +0200
Message-ID: <20240726215701.19459-2-frederic@kernel.org>
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

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm/common/bL_switcher.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 9a9aa53547a6..d1e82a318e3b 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -307,13 +307,11 @@ static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
 {
 	struct task_struct *task;
 
-	task = kthread_create_on_node(bL_switcher_thread, arg,
-				      cpu_to_node(cpu), "kswitcher_%d", cpu);
-	if (!IS_ERR(task)) {
-		kthread_bind(task, cpu);
-		wake_up_process(task);
-	} else
+	task = kthread_run_on_cpu(bL_switcher_thread, arg,
+				  cpu, "kswitcher_%d");
+	if (IS_ERR(task))
 		pr_err("%s failed for CPU %d\n", __func__, cpu);
+
 	return task;
 }
 
-- 
2.45.2


