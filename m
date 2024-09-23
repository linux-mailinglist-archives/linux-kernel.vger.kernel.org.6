Return-Path: <linux-kernel+bounces-335610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDC697E809
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74651C20309
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737B1946B0;
	Mon, 23 Sep 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRfN3xlX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D61946C9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082089; cv=none; b=nVrxQJlzMiCFbX3IGsI3CAckPyZsyPFOBnj1iIP2fjlBargdhf3KA9oULHLMhOxxcuMn37IcgUgnd9VtMMxgFYlsox58sR9LuhzuxhlGHv30coQn85eL7u9iGj6M0iBb/RIpRA2sToh7cRFSpx23qVPQFKTNg7CcChg6lDZcy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082089; c=relaxed/simple;
	bh=Eb8d5lyXFhSllOGcwU1VmnjYWiuaJB9lPUZZG8MTkDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2hBlQ4ymAwN+TZSYJgdxifBNeRkbAwViOt0d4RINrGTl+21NDXipvHPwW9s6PabCfg8MYqJGHX2RO7HHyHi0CRSemhR6XojSbb3dlvw1vjYfzuBvWRAadrYl1I/OP5uypQM7MxKPCBIuUD04GZoyzHBA8sHMGn5ffQIo2LVAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRfN3xlX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so2299560a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082087; x=1727686887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCA0RTe4B5CkvnInMX18gUuR5vgyuSITkXk+PtSiiZc=;
        b=NRfN3xlXWgJ2p40+MEXhoD1RDL/5yl9LTiIEjfRWl+TEEmbmA6I+JyiupOKNuynF6G
         lJSmnaOsGFC+4PEYjuO/kCWL0PcZjIrzYKOxMTtZ9nfhBE6mvlmiA9nG30ImxrPpaLOB
         0jj+u+nz8P0uClj0X1ULviuWfuZKyfsSDaq4J1j+r+o4Q62QrjBc5aETQH0aGocdwIOH
         b/iFiD7e2O2UAtNQQ5OTNnvM4wDIzOFZjrKu2p70ioCAWnTXkDBImvBpaUvJHCX2XYu4
         7PdkH5eBQOcTAYIHYXCu00WVCIlTOmgZ4ELrUbExwFLTP4dnkV3isuTcMSR3nFeq6sLg
         zLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082087; x=1727686887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCA0RTe4B5CkvnInMX18gUuR5vgyuSITkXk+PtSiiZc=;
        b=D9dFmPZQbSXw4sabawmBBaKH9U9pYlTGKqJDUJ0s5q4hPQRI4Wdt3F/Na5sEYwpsJu
         7nr2zqNGsts71penE3m41YmvlxbNp2aaPNtoS+/qosaJAEMwNLyVUbxOhipoISYyr19h
         fjLaxIxO5C5+Pfdz/ZqQ6FdLxc6IIY1QpJgQmnHeblU4AIFe0MxHf7hLzrcsr6H4eJMT
         1mVt3jLPXX/e1unjFl4WaCweabPETMFcwjgwyUW2PqLuksl+t0hhq2lCCDnzvQKGWBlO
         GOTuQqkBNgPvGa6QXZL57BGm938QFzCDD6PzD2mQCXS94wZt6UBs38QdJf1Z9nQOFIUq
         aJSQ==
X-Gm-Message-State: AOJu0Yy5RXzlQq/EKwh2SDfAq6P/WCRSf2F/WOTpGbR6k6C7mCDsiKrc
	xL0A6eZQtDGPPTzZwCu8UOKG865Mr5JUK3oxqj0Za9ZWg1fVknBz
X-Google-Smtp-Source: AGHT+IFQiaVsuB7T4CDhBig9cPff+916x+W54KDCddVoWqeOCfSucKRgf/rCV1csMNGhz6oNpsrebg==
X-Received: by 2002:a17:90b:485:b0:2cf:c9ab:e747 with SMTP id 98e67ed59e1d1-2dd7f36cb4cmr14325238a91.1.1727082087430;
        Mon, 23 Sep 2024 02:01:27 -0700 (PDT)
Received: from localhost.localdomain ([39.144.43.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8ca487sm6768872a91.39.2024.09.23.02.01.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:01:26 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 3/3] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Mon, 23 Sep 2024 17:00:28 +0800
Message-Id: <20240923090028.16368-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240923090028.16368-1-laoar.shao@gmail.com>
References: <20240923090028.16368-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b6cc1cf499d6..8b633a14a60f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -735,29 +735,31 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	s64 __maybe_unused steal = 0, irq_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+	if (static_branch_likely(&sched_clock_irqtime)) {
+		irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
 
-	/*
-	 * Since irq_time is only updated on {soft,}irq_exit, we might run into
-	 * this case when a previous update_rq_clock() happened inside a
-	 * {soft,}IRQ region.
-	 *
-	 * When this happens, we stop ->clock_task and only update the
-	 * prev_irq_time stamp to account for the part that fit, so that a next
-	 * update will consume the rest. This ensures ->clock_task is
-	 * monotonic.
-	 *
-	 * It does however cause some slight miss-attribution of {soft,}IRQ
-	 * time, a more accurate solution would be to update the irq_time using
-	 * the current rq->clock timestamp, except that would require using
-	 * atomic ops.
-	 */
-	if (irq_delta > delta)
-		irq_delta = delta;
+		/*
+		 * Since irq_time is only updated on {soft,}irq_exit, we might run into
+		 * this case when a previous update_rq_clock() happened inside a
+		 * {soft,}IRQ region.
+		 *
+		 * When this happens, we stop ->clock_task and only update the
+		 * prev_irq_time stamp to account for the part that fit, so that a next
+		 * update will consume the rest. This ensures ->clock_task is
+		 * monotonic.
+		 *
+		 * It does however cause some slight miss-attribution of {soft,}IRQ
+		 * time, a more accurate solution would be to update the irq_time using
+		 * the current rq->clock timestamp, except that would require using
+		 * atomic ops.
+		 */
+		if (irq_delta > delta)
+			irq_delta = delta;
 
-	rq->prev_irq_time += irq_delta;
-	delta -= irq_delta;
-	delayacct_irq(rq->curr, irq_delta);
+		rq->prev_irq_time += irq_delta;
+		delta -= irq_delta;
+		delayacct_irq(rq->curr, irq_delta);
+	}
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-- 
2.43.5


