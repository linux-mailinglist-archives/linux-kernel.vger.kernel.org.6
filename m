Return-Path: <linux-kernel+bounces-190074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED88CF948
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE04D1F20C79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D1168C4;
	Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AoNGwTjf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8opQKl9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602C208D1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791900; cv=none; b=PcOjPWHIckVyCpQkdkqe8SEKTxPAw7k2FpBLIWwTnEN7gHBbvXlizjeogf0Gau85F91X5+3EjGGkVzoTXSjaX3PPzMv9pZ7S51cHXD+SW9mlR9HTtJUZhjQ2uFGPvh/yDuyVidTg0oPET7IpiBte3oXx5yPELNhDB04rqGoQiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791900; c=relaxed/simple;
	bh=+dn/emmEEkcbSG39cIwrkA2wVajPNCrfmui1Y4Bjb98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJ6Fa51zR2Bpf/HATl7WIT3BWqF5YT5FVydlMKi/FbmQcpHmhJdDA0BORgrwkFqkPTp5x+N+C2hACyNEgyTMDlifrwJcwdURTh+u4kol11Fp1RtrGl8v+TRcJZjVu2pGC452g0DNfr3P4OG1I2Dk2wPN05bDEDWhvfHCHrR+s88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AoNGwTjf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8opQKl9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ivuBM37dQqLptpOvVQ5pDKTeLxrWvfxf7hXSdzp6yc=;
	b=AoNGwTjfxYrNKExIOJhnh8w80Pp6zrVg/HR1fZKPmXjcSGGu+skf9UJ/sQaxjYnkofAm/z
	pIledchn374Bqei75B9bG0eMVSKbfo085gEehJEZxnBl3oQ+pB/51N5qjnN5bCEuk7Esgu
	TX+z9bADX8/A+5eASDPZjZ109kkfsF9PX6IACZkCAe6yMObkJP5p4S8y2kYPvVSaxrGYOW
	xhj7bg1T0x6+eZhuALV5PbkQ/0/ZttAxKkvMQOwBeqjXtJsjcf19w5WrwwxSCmKrtPGScr
	iq4wNvjmMv4o+qLBBHSL0QQkzcWvjwM34haaNs9GuE6HMBEByHeh4i09cIzjRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ivuBM37dQqLptpOvVQ5pDKTeLxrWvfxf7hXSdzp6yc=;
	b=Q8opQKl96KesAmk8O7lXPZlE+Nen47I57u/aKpdAoSqq7eUSbNEjZerbZkeSM4uXInJ966
	dU1g4noQMaeJPcCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH printk v6 01/30] printk: Add notation to console_srcu locking
Date: Mon, 27 May 2024 08:43:20 +0206
Message-Id: <20240527063749.391035-2-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
'console_srcu_read_lock' - wrong count at exit
include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
'console_srcu_read_unlock' - unexpected unlock

Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8de6a46a056c..6efb629fd976 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }
-- 
2.39.2


