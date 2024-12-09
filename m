Return-Path: <linux-kernel+bounces-437335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D5B9E91F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503001881F93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DABF217648;
	Mon,  9 Dec 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNCY22og";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tG4yH4H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801861E48A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743069; cv=none; b=jtrl3hudhC/nTwAgfq/q0ZTvIH5AbPhlFUBN26vNgLfVB7goUfO8VoOIKjpDYT5TG1AlL3cWi3MAkhqrOFksYt55rCn1xyUVpPk8Se9xG5wvv01bCDYz+buqfbFthND1is+0VoRfk9KDBX8UTjlS1Du95zxXXs5dWHl+JJurBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743069; c=relaxed/simple;
	bh=W+xeX970+1phYNjQnnccxyjk+dnQMrYnouSl3s2TR6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nnf0UosN2Pob3I8tWF8vz9gviyDxLveg5zEreu28rtOIKIgzhrPE5SgmL4VYuFX0Ax880+e9znAq3ZQiEKT3eesrgJ64V+rAhiGLBdSS3KMUow+1qIER09nQWmwmphmsRklZSGZ02wtdiif5pHTz/tPMNFj9g1fU7A++dMULEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNCY22og; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tG4yH4H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733743066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/A76RQe01v14vSNFA5wdo1/HuRPPbVq6bDEecpQUNc=;
	b=QNCY22ogE9TQKa6tY+806dPU96OmKvZ6dhL4cEi1F0UuBkmiDIVVBXeJS+zbciSrGx4b46
	jsgeDxn4W9egu7wMPIgMMaamp5WLvb6T3ZU74Bl4AKcqmfpQ7UcxyXsolwr0bI1HyH4dFU
	37wv/UlbXheVoAIGPdmsssffcEQ79SmUNvT8g1PiSJCqTkTcKMmy3caNtCryE3Jn3VvVy/
	ZzWo3Y9uUxxokIK+10mwg1EFrpThiVomdtAjJyHhz5ctXsNaiL5WKXJ3mcpDI9HWtt9KyT
	a0jHNxr4TzUuIU5uNuEyoFRrslF7fC8degK8cKgqRG5BEBHv+lnpIfIqzlN2gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733743066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/A76RQe01v14vSNFA5wdo1/HuRPPbVq6bDEecpQUNc=;
	b=2tG4yH4Hv4rPpjcGjOuueDMz5kN1rWmArHazaNrj8CpxM7bLTP9LeBj2dWGuiamZdf72HC
	2ndeWrtXNseyASAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Omar Sandoval <osandov@meta.com>
Subject: [PATCH printk v1 0/2] Fix ABBA deadlock for legacy printing with cpu_sync
Date: Mon,  9 Dec 2024 12:23:44 +0106
Message-Id: <20241209111746.192559-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

An RFC patch [0] was posted to fix an ABBA deadlock related to
nmi_backtrace() and dump_stack_lvl(). However, the underlying
problem was trying to perform legacy printing while holding the
printk_cpu_sync.

This series causes legacy printing to defer when holding the
printk_cpu_sync.

The first patch in the series is not necessary for the deadlock
fix, but was a redundancy I noticed while working on the series.

John Ogness

[0] https://lore.kernel.org/lkml/20240715232052.73eb7fb1@imladris.surriel.com

John Ogness (2):
  printk: Remove redundant deferred check in vprintk()
  printk: Defer legacy printing when holding printk_cpu_sync

 kernel/printk/internal.h    |  6 ++++++
 kernel/printk/printk.c      |  5 +++++
 kernel/printk/printk_safe.c | 16 ++++++----------
 3 files changed, 17 insertions(+), 10 deletions(-)


base-commit: 4022ef25504db2fb79a2acac0afe9bac934f8dd6
-- 
2.39.5


