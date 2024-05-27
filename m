Return-Path: <linux-kernel+bounces-190528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB38CFF90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7901F22FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3AF15E5B9;
	Mon, 27 May 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZle2ZRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D01581E2;
	Mon, 27 May 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811630; cv=none; b=ezpj1g8qV6Zp41DqSKV8cgDEDXWu/1uwVSUCXrK/6a0gYr3ITdcPNyE30QShuKyPASL/KSl9Z7ykHUDkQ2Lsdj64m90obx8kkY3o7nE58XIdnhlOenx/w37CcLY6gmB+P4sikNRF+GgdlyBTRlU4x1M1FbYgEaw6iNZYilKx0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811630; c=relaxed/simple;
	bh=hIxgYxksAfA66KrdSWCpQCnHlbL7K67hv5hEDpywMGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUPmJN8YNqx5abzeV8BiBxAzHRuQnM32RF6qzs1IEz8itF784TS9ax6jPdkBp+iOqbo9310bY7ksD6NH60kafNMjjee2hG9sgC/TpeR71wT0z2bZegrvtMrKrWEoHEWfrxkcQEu5LCFMmvddSWYG29xr24/NYd4cCgZj9bMlm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZle2ZRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E74C4AF07;
	Mon, 27 May 2024 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811630;
	bh=hIxgYxksAfA66KrdSWCpQCnHlbL7K67hv5hEDpywMGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZle2ZRO0HO8NBfAzwCxTo8C5J/8Sj+gO6g2GMqAfeHUycr3R18026dDgzHidjblz
	 fVCr4dxOL2hpTIKA+pkRkwacP8ZNl8FeN1LkcbXMl3pk4hBl5DO2UjNRhjpIwnXRxl
	 T99+Pkv59cIzD0qZIrLvhfRFf6pIA6AqFDrG6tVze+o4bKWiK7cdmI4PRFq91RxHBw
	 LjV4kWrmgy9FjbWKKJ6iVNd1TlLOepSwenViYTwJV/4mP2rveSINldHlJd5dXIwFZm
	 txbvuAN40TOJbs0VAvESfiqOqtwdfAqBOV86qavDt3DD+lIgwYhyewF307bi7IigcF
	 X6VmzVxMApgyw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	stable@vger.kernel.org
Subject: [PATCH V7 1/9] sched/deadline: Comment sched_dl_entity::dl_server variable
Date: Mon, 27 May 2024 14:06:47 +0200
Message-ID: <147f7aa8cb8fd925f36aa8059af6a35aad08b45a.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explanation for the newly added variable.

Cc: stable@vger.kernel.org
Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..abce356932cc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -637,6 +637,8 @@ struct sched_dl_entity {
 	 *
 	 * @dl_overrun tells if the task asked to be informed about runtime
 	 * overruns.
+	 *
+	 * @dl_server tells if this is a server entity.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
-- 
2.45.1


