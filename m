Return-Path: <linux-kernel+bounces-293359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1498957E41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590A61F22211
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54853DAC09;
	Tue, 20 Aug 2024 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWG/qAai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k45CE/Qd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8925205E3F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135420; cv=none; b=Q1tFmqVZl4AkFMcoyTOjfDZZo8Km2UXupGXGN1q9QI/PKdtsu1llKLcObmmc8lmBJSzDD+MWP0K+h3qCwXSqyiwFB4tRYawhk0VNH1T2oVOHjzfEXiKxpzq3fcWkUF/6Ji+KKobpLf7x/k6Cz2pMTOrmMOYj6QM1H69beBeHL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135420; c=relaxed/simple;
	bh=/KIzCAQADSEec+ME6HGN8mI5s+OVwZWIqDnDZjyRzmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QD5gL0ZW6679J67/4U33ldYYwekeJAX2eF/rbhkbr9xzq4blGWKEA80gwatcDEbyIgNdK8djPjSa6LaOsYLvCwsO1YK/8CRDyIgC3SpaEF+XSv0a0p9l0dQZoAHELjXR1FozhJMRQBg9la+Omhq1qCerbBjt3MjXSNQ5Qobb8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWG/qAai; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k45CE/Qd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUeFIaL6KNp0KTbbamX+34Yv3jlAXkUwhzOF46k6K98=;
	b=KWG/qAaiC2QBZ2pj3YlOXlUk21kalJh1OU/xFjtW1vP1/HKy+Fn9sjL1yNu/QROfk76ase
	JlP/THreqO82/qouhiC/OSXCrqiJJr+Q5ELaECqJDUJ3wY6imF5rjKBrlpJMz9Ny294Ccj
	4LscZ2lX3DdDnGXgOwhLenUtDn3mDQYngnzPhvsWTx5gPEpPyq+tVAo8vNBC0VcInGZBYr
	ztIqYPKOzfTwpwqUWR11AeJdpoBQtRiwITLDxF0INIEyVUdbRbiiHR/mC+5wZAnefXaB0G
	+L2VLRjDDS3zcO7MnKQyTO3N9lHtdWEeI5YX66Rr+qZl1uB/i+RcN2mYxlLtew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUeFIaL6KNp0KTbbamX+34Yv3jlAXkUwhzOF46k6K98=;
	b=k45CE/Qd9SbAbEa9sB8fYBo60QUq+jDC0gOn+Ftqwy4raPwdsDI5DSk5QyEjpiM3QSfJ1j
	KyoK8DqKKx3+ZaDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH printk v8 32/35] panic: Mark emergency section in warn
Date: Tue, 20 Aug 2024 08:35:58 +0206
Message-Id: <20240820063001.36405-33-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Mark the full contents of __warn() as an emergency section. In
this section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 93096d5abcc7..1a10b6e2a855 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -718,6 +718,8 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	nbcon_cpu_emergency_enter();
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -753,6 +755,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG
-- 
2.39.2


