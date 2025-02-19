Return-Path: <linux-kernel+bounces-521388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA2A3BC97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F263B65CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BC1DE4F0;
	Wed, 19 Feb 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sfJEkSVV"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC31C54A5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963905; cv=none; b=G/Vy61JPTiFu4TXPdicEP7H3WpOBNwQiNXaGtkNe03zbjOlahv8ooe3DaanNeCPi2Am9OM1YUwMfQHhYj+Uj+N31q2seqKg7irmJyR4EXJKvH/44Cw1FogTPsWVErnONaEkYU5RO5adT39pqeB+Ex9UFXwXkh7s7pm758vFMwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963905; c=relaxed/simple;
	bh=qX2hWdIZOjkJ2mAbPYVL2ddWMZ3+XmsOG1FZ/nWmFzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmUCdELdKIS7MwTYW/XTO90vhnn5S97L9VizquIP5z1wRLy/m1fhy6xf5CsLhZxK+97AFz4GJMT5Wo17z4u1uWSEqm1n+1+A6Q+iqXgf9h/RS/ZJdyX0IzyJp9mtF+sSU1nt9kvyzcbPNuXUaAO75etuKqoha2k9ZdbhfK4MLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sfJEkSVV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739963900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xILe55JT+zkdX0guevtGjAuqkjOYRDPDNgvFJ7GIHAA=;
	b=sfJEkSVV4GZ8YAgeOqU2Z7Xvic5oqprqHet2EEOidUleK2pb/fnFeolT60EaeM06oO356g
	tpFsWszSD1KCBazsuL/tHDCRQtK1eG5EHRgc64CzGL+A0C/nLvkoPzdvRbpYXUb18X/tWt
	f8FbDGRQTEEYDX2CBP6EmSoH8t4uIs0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sched/core: Remove duplicate included header file stats.h
Date: Wed, 19 Feb 2025 12:17:57 +0100
Message-ID: <20250219111756.3070-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The header file stats.h is included twice. Remove the redundant include
and the following make includecheck warning:

  stats.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..d2688b0f265f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -91,7 +91,6 @@
 #include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
-#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
-- 
2.48.1


