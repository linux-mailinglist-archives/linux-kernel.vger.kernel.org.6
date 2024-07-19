Return-Path: <linux-kernel+bounces-257337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB39378B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1553D1C2134E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5D14372D;
	Fri, 19 Jul 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u83d2GBe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OinDvsH3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029C12CDAE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396905; cv=none; b=uDxQ+kP7sqiBY7VVFvfg/vS+Y7qnYBaexrsHI8CbtYb752uWO0mLHpM5vdzk6JWtGZzmn5+DVInpPf2wyg0iBlehe22HLVfTxFaFjW0p0dMyNdtIFdw/eG/oi8Ze/CzExoP7mcIBJfisNRF49/w5eNPMzmHXh8ND/0raaSCOmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396905; c=relaxed/simple;
	bh=s7ETTH33fA0SIwykyqhyinUWuBUMdhpnAhbmqh0CCd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UkZUaPOvJDxqCNJxoECjiS8j1e7por40JRn2J/VjIl/h0y3Y1gc+9/GWZhaaxUHVBX5A4zKjPzKkpjqOtqnL3/2WdNiJcX8d+yk3Wg6hoZ5z1eGczPXHECA5ZT78ycUkRbxYv/biqH2wxrSKQ/Fp3/IIP+fP2rhbVTrXBFcTkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u83d2GBe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OinDvsH3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721396899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5++DmDEVMSGdhpk9gWUbi5tzr3w5rBzS5Sh6yl7CFes=;
	b=u83d2GBe+IlKXI6PXMygfLeqFASMg70MmjSi5TxiiEOw+qa7Piist/PIPZ+yaT+NORk8Eu
	jKzKTvu/JeFT4cXW1oeTK4ZKcUs+XpZebFZy1lK7fWAS8aahcxoutwa6Nq/u9mIrEkrT/l
	K9Gx3e0A+Wm3L7rc7i6bWpM6dXdy7JQo/Y1n4qW0UOJarpapJZyD5ophjUGPNY8Hrtg9ky
	CEXJYUdywJShGrSKOLIcUSGyQvo43zKSywugDmhbp868wqzIe4kl9iNR0XlL99bTPHCxVN
	h6Kwia14CS+2/pgcb2vXoc/6knnYUVUybiIXSkrkGRCUBvYXnQuvnsgomiNFkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721396899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5++DmDEVMSGdhpk9gWUbi5tzr3w5rBzS5Sh6yl7CFes=;
	b=OinDvsH3+dlZjO771LEl9ROOffkLTYU/6QytqmiReRO8iCTlwmDC2mU/vvMUyCt0RI5zif
	0XOrhMTPt6Rbz4Ag==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH printk 0/1] alternate fix for nbcon_cpu_emergency_flush()
Date: Fri, 19 Jul 2024 15:54:17 +0206
Message-Id: <20240719134818.3311665-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr,

Currently in linux-next we have commit b955f0eead54 ("printk: nbcon:
Fix nbcon_cpu_emergency_flush() when preemptible"). But as you
pointed out [0], there is no need to disable preemption at all if
we only need to know if the current CPU is in emergency state.

Here is an alternative patch that correctly addresses the issue by
avoiding the migration checks.

Since the previous patch is not yet mainline, perhaps you want to
use this one instead in order to avoid a revert. Up to you.

John Ogness

[0] https://lore.kernel.org/lkml/Zn7b8g1HtuTIAwyi@pathway.suse.cz

John Ogness (1):
  printk: nbcon: do not require migration disabled for
    nbcon_get_cpu_emergency_nesting()

 kernel/printk/nbcon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


base-commit: c51cf7315db1392af58b909d1004133f6dbf0bf6
-- 
2.39.2


