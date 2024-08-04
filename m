Return-Path: <linux-kernel+bounces-273645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2B946BAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B11C212CB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED96A8CF;
	Sun,  4 Aug 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jl6sJAoa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O2Ijat/O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EC1CD2B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732717; cv=none; b=Q+jax3Z/6jwaq50sTIJKjCLF2MtfOD1RaXLi/6ovfugD9P0Fsmo3RqaUY4YaEjF0z+UdcdNV7szdLa1WG5sJJnkY3ft2OxoeeB7JvUC+/7Y+bumZF3QTCSDeSE4XT2/X5aiUfqCqbXL0lJEscy4CA8gzlT3zBRLwALPRz2OSzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732717; c=relaxed/simple;
	bh=RDZ3qF+j30+orNYUh1q6eIsAysiEihmR66fcNeVaLGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trQOGU4XjLwDvDDWSyenxRcuZjB2nctrPev0DyRVKG/ZVL7ldGsEpMyDsUeBajdm3jWTCsv7zRUe5EDFiLSHyOOSwggK/p8bbTHsMQEGncy1PG7CVXf8meI4saN+o8FqKF+lFhox0EZlP4y1oRd0tefh9po3W+Op6FdMcxMtCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jl6sJAoa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O2Ijat/O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfipR2k1jdF4e+b1cRrN/G4ZDnI3s/6veQOnOWMQKzA=;
	b=Jl6sJAoagAt+bYZi8VSg8hTFPADbxXBX1EFpAt3SKVrSLuBdbfLVN83MLI1CiOMdCavwIm
	dcX3R2omxf16d9vK+xk7yYcOUH5oHHhrGbg4loVPdTAdqmiVeoMtOQUToGgybv+HOBcpSD
	2e40G79SqFuYlQFlA16R7AafGpdN6FbM28QbaPG4JKwPkik7bZD7VCnuKom0HzlW7Lue0g
	/3Nak7eBLZbdLJJpxjnJ55rwyrybJOX1KqjPieysyvyubqGd1nsMbjZJR6xXGsVp3VvJJ5
	XXda+wTTnFaiAZ1xmbKMPkFK4RXTqrHZx5Wecls/sU7lCmiSQHi/Y7aEiNJGSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfipR2k1jdF4e+b1cRrN/G4ZDnI3s/6veQOnOWMQKzA=;
	b=O2Ijat/O+6FeiJkWNMuu2AODPgWjAv3Ba/ZyQGmb/FLaTxxsiQPKZtU4qzUxfMr3EkTx6E
	A7Jx3uYuCBlwmhBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 25/35] printk: Flush nbcon consoles first on panic
Date: Sun,  4 Aug 2024 02:57:28 +0206
Message-Id: <20240804005138.3722656-26-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In console_flush_on_panic(), flush the nbcon consoles before
flushing legacy consoles. The legacy write() callbacks are not
fully safe when oops_in_progress is set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d54eae0d06e9..f61ecb84c3f6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3269,6 +3269,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
 
+	if (!have_boot_console)
+		nbcon_atomic_flush_pending();
+
 	console_flush_all(false, &next_seq, &handover);
 }
 
-- 
2.39.2


