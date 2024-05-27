Return-Path: <linux-kernel+bounces-190100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404418CF965
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A47B226A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD13513C673;
	Mon, 27 May 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKwVz7Ri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TorGkXxy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03B13AA2D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791910; cv=none; b=rSjK8dwn/1if+oyYZ057HHa3Il+28gOq5509ABnNAJBgPQVR0XOaLAz2dPm+Z6azHLMkxf/HkEQVjM48rFEz9qf5Q4UpGEZCx8nuPT1rBYV6DQzRh+qXBnOHk8XStuSFUeBPxzLw0WleOmFUEtm/1uj4oba6PcKxndZGA5KkCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791910; c=relaxed/simple;
	bh=ApV3BrzIy3FzvWp+ns3WoghCqTJI0MOJzDStPgz0cJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=px8XYre+nIXyap7zpBfy2adVlEXlIQfT3bJDCTinxI/ZEWzON0ECAPRSKd4uNaKbAOq1VgA9DM3hxWWk9qLkIjAFhrpC2wlPqafVph+KAbKGsWf7QQvsfxA7Mx0lpgnN440FxalLEx0xE20N0+OBgk6dSeuaLuay8CUCIuXT4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKwVz7Ri; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TorGkXxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ypq720fklC/HaR4UTxfPN0fK1+MPpff79Yq5uFGIqB0=;
	b=xKwVz7RiSbkQ6LlCzh2pdMGlVTnTHcm80TDxjCbg98R66FcxTCVE276nR9ikUB3MgWLi+w
	dT2csWpy4EYXIbqxSZcPUqMqbiI6Lqr13wXPJ9OcuuANggqPvo2Y6CFK76j9mm/9WYxeHM
	r0CME2p0PREryWHTPXTcWis6lPEUd8HKOZs+5K1EJ4I8qjijhAdsN4u6uoWwnIU/2Z0M6w
	SlHMCl9E0AfmaDeqmCkYdwxMX8ktmV3DqlGAG0jp3b/zyLOvqW9JvCSCBZj/QGtTIFjDni
	GqZHtLyUcuIJqhpay/2cv8L7eTEK/WH5COJ9sFKZgJM9QzvV7B28mNOhLeGVIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ypq720fklC/HaR4UTxfPN0fK1+MPpff79Yq5uFGIqB0=;
	b=TorGkXxyqExrWA7fo16ISDGIhpNuo1sMGn4Cc0BBLveKqmAuU3HBCaF6DxM3YmyjGqd127
	a46Oi2RTTYvIFPAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH printk v6 28/30] panic: Mark emergency section in oops
Date: Mon, 27 May 2024 08:43:47 +0206
Message-Id: <20240527063749.391035-29-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark an emergency section beginning with oops_enter() until the
end of oops_exit(). In this section, the CPU will not perform
console output for the printk() calls. Instead, a flushing of the
console output is triggered when exiting the emergency section.

The very end of oops_exit() performs a kmsg_dump(). This is not
included in the emergency section because it is another
flushing mechanism that should occur after the consoles have
been triggered to flush.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ee03193f9495..3754a2471b4f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -634,6 +634,7 @@ bool oops_may_print(void)
  */
 void oops_enter(void)
 {
+	nbcon_cpu_emergency_enter();
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -656,6 +657,7 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
+	nbcon_cpu_emergency_exit();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 
-- 
2.39.2


