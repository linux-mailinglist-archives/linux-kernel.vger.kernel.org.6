Return-Path: <linux-kernel+bounces-277505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A427094A24F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50EA1C23E02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64918FC9B;
	Wed,  7 Aug 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4hbmgXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021E2868D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017639; cv=none; b=eTsprBpIo9UolVHBIGHzzoUUFCzdfVI/7RpIcM434NSkkOaYLPjUSOcLDkQCSDNIr8jWq5J4o/mb/yBIdbec2Tmtghcvg3YCwT19HKOJaSRWhddQOpCFkRpdBHlQvRRXX9gE/6xPFFbn79OHQuNfbOLd7sR0hFASMI1jsPs3/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017639; c=relaxed/simple;
	bh=dFBbOvxikVYDjKlK/gppRmeBoVQiCWxuOBy9aJCzg0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfMalXh6ZpfQTSBrKq5WDNPZuPLJbI7ISJ8a24m8gz9yCqBQjNxaD7B91BYB59o4XY2j8XJ6byzK8MJmOxlQGNRgMyCHxpeQYwspl8bfmAflwyDuFJiOZ7SuFFGuweX9A/mxg/hcOTCeGRqcoWqOsP14x1J7pns8nT/qcuLsfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4hbmgXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D052C32782;
	Wed,  7 Aug 2024 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723017638;
	bh=dFBbOvxikVYDjKlK/gppRmeBoVQiCWxuOBy9aJCzg0o=;
	h=From:To:Cc:Subject:Date:From;
	b=N4hbmgXbv06+VE+Au42vtyqHx834Ro0CuWNuBZMMHeYIcTm5uxF2Rt7JcKH4eGuIx
	 XN562pxBVWPBxi1hfifkdUazEbB8nQJzAbWJ3JufFIi5HHPzhW8MUUv+t1WGM5nsR7
	 knB4lgssaufhPdfymL4MtDQCu+MmoQcubvZgzBMNGTIoqUAcNG6v2jyWeliTPEBCfX
	 1wATiP/KXMraWk/ZeaAFa4LFm4d0wI/RsJl3e5owSwM55fJ57CDaKB0to8ltC7K3gW
	 o48xiN1i4SXKP4aVBiW5d9yNK2QjtAQR2s5X1uWumIgnS5RK39k/6oz0LmpjfvurW1
	 b7rRtWUUItoOg==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: avoid integer overflow warning for fair_server_period_max;
Date: Wed,  7 Aug 2024 10:00:08 +0200
Message-Id: <20240807080032.2302853-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The clalculation of fair_server_period_max includes an integer overflow:

In file included from kernel/sched/build_utility.c:72:
kernel/sched/debug.c:341:57: error: integer overflow in expression of type 'long int' results in '-100663296' [-Werror=overflow]
  341 | static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */

Avoids this by using an unsigned constant to start with.

Fixes: d741f297bcea ("sched/fair: Fair server interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0148bc65d39c..242e7f264a0b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -338,7 +338,7 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_max = (1u << 22) * NSEC_PER_USEC; /* ~4 seconds */
 static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
 static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-- 
2.39.2


