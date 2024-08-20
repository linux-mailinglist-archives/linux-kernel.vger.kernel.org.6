Return-Path: <linux-kernel+bounces-293351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF9957E38
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0626283A60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66B20FA88;
	Tue, 20 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i7Dt1FPf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5IwcT1t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44341EB49C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135416; cv=none; b=b1zBmAQCmKDNUK5yKipYatNlqtWBlJBywMOrM3syhlnHOC19ZylKeDL4zaBLeU82pVWkkcC4g3P2jMgmIBffikxdSI8nAQxVCQAZqyPD6tcSEehUax1LvnGe5iDeoc1XDh+dULHGYYDEDLlGJIZQKMbmGR45nkK1UAPBg70iJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135416; c=relaxed/simple;
	bh=lcL9QyQlFbOCIpJqsyiB7FdRCNDCHLSoQT/vBTo43tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCu8O1XtOb1aswQGRNeVuSonn259kZrHQ0wzGcy9QoI6yno6RiSkqU65sOXchXaC1JiG4X8kvEBUGCxKhd5+34n+KWyvBKdRxawoEBlcyLN+8L7u2QJsv7i7MgjH5H5QdcYXW5bZ9498bgAlcCNgMHIshKe5hgT3CRVLVMbuKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i7Dt1FPf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5IwcT1t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRTk/yfdipteoG9XJ2QvJ40TAJoTxvycbtzz8xB4kDU=;
	b=i7Dt1FPfL2MJ+1d9wrUHJjKLUEPw7YPlKvnwFJuhLI+CyeALuAv47XrNJjHsnrbey/i51A
	i6Xm7G4bDmAOuxVej/2tqyq4zMae/LIuZV/CV4CqxZ7MZqqicSVkb+SnHxk+eMZ8UXKe7u
	VF3JvSliqCmhD1O9YMie1UZv9y1mc0BVo1R1A8gZ0SWCCn3lWGAgmHWIP64sLrH00JQPdn
	kvQVEu58jEvKKIE9xQBMvKl9fzeWEDJHdvMNeeJy76LlAyaUTb9hfbP27s9Qc3el0SKGsy
	82Zsyu3Y1PGZDku8K/kFznK72aFdMS+VJsrKU5/zWc3lTrQCv3bN40OqF9KPNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRTk/yfdipteoG9XJ2QvJ40TAJoTxvycbtzz8xB4kDU=;
	b=a5IwcT1tqlf+HXVivyNpmYCnZlY7mAk0J1izZJoi0oz5hlYg0dUlNPBJaARI18yJ76LaML
	ZUvH8/VxKEeODCBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 25/35] printk: Flush nbcon consoles first on panic
Date: Tue, 20 Aug 2024 08:35:51 +0206
Message-Id: <20240820063001.36405-26-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7c9f8f6e1738..c6e633329e4d 100644
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


