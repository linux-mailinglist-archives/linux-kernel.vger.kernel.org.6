Return-Path: <linux-kernel+bounces-318753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A908496F2AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BD51C218FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B041CB157;
	Fri,  6 Sep 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cPERfHJ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Zo+jdnB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370C14B08E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621531; cv=none; b=p03+MmwKMR5CTjdXM1I65ONV+bJ+qFhNfJSumdI2/JE/0/g35hdeX9gBVJOxF6ug7P9oBmTBf+2Dyq0n2hMpxox8G0OAkidK7N3VndvXWHezvKHvgN5nN8wQdLpNDIu31rHOlfPV4ZUFqMZNnHFCqj4dQupdfcoGeX0wLKMzSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621531; c=relaxed/simple;
	bh=HEP2lp2UMK+97IqGCmgYal4fO7wnNYZc3qCTmzndaog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwnYTEV1QuVYPkTlTpQtTi4BLIAY1crXKOXU/Scax1BGDuQMLFFdVHoxcMDnGsojgN5kWNNX5HEH/2sRIaePJiyvbVEJ5Rdg8C0I6MoZ/EVlb2EfHBEiaU9ADwvtzXeHvM/J16Uh1ik33SaG4Y2ZkK9cUek6pcUQhCqrXOzylZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cPERfHJ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Zo+jdnB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725621527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HEP2lp2UMK+97IqGCmgYal4fO7wnNYZc3qCTmzndaog=;
	b=cPERfHJ4Tj2syRS4X5vjMKijkIyRTwEw9huXhX9ScPLCS0xD+UUfqUaFqNU7HN81DP+lms
	FCbf+Om+VF0i75oYNFOg/X2Mk0PkXhJeNbIshIc7TdWBM29Heg/58FfdaaVNnKbUql8sIF
	5E8xkD3wqFvc2OGbJCzCQFEZVUNjlfs7Qq08SQ3RvXsjRsRh29ajYXz00ETMQcW/L6HZ1p
	715/QF7D7Qy9nUF6DcbeU1cXpBBgeSo3O9OcZy/BhYtfZJfhiKWSb7qrJjIR3wtEX+f7/F
	ZYRMv5y+Ai8LOB8AtcG8/sN5Zipm+pA2TIhhhh1Yw/tm4x+VsxopQtkGSCV26Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725621527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HEP2lp2UMK+97IqGCmgYal4fO7wnNYZc3qCTmzndaog=;
	b=1Zo+jdnBuun2+Zt18Bs7uRsHBtWFLpAlPrv1lIh0pP2m77SRND7ZqSK2NhuFslp4lFSirE
	8K5jxNV6h5G6rnAw==
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Clark Williams <williams@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/3] Allow to enable PREEMPT_RT.
Date: Fri,  6 Sep 2024 12:59:03 +0200
Message-ID: <20240906111841.562402-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The printk bits required for PREEMPT_RT are sitting in linux-next. This
was the last known roadblock for PREEMPT_RT. The RT queue has
additionally the "atomic console" for the 8250 UART which is not yet in
linux-next. This means "legacy console" behaviour as in no printing from
atomic context in emergency cases. The 8250 UART driver is the only one
providing "atomic console" support as of today.

With the printk bits merged, PREEMPT_RT could be enabled on X86, ARM64
and Risc-V. These three architectures merged required changes over the
years leaving me in a position where I have no essential changes in the
queue that would affect them.
ARM and POWERPC have a few essential patches left and I lost track of
MIPS.

Sebastian


