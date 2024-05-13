Return-Path: <linux-kernel+bounces-177619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3948C41B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB241F23003
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836315219A;
	Mon, 13 May 2024 13:21:05 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507C152185
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606464; cv=none; b=l89E81ZGkN6ysZ3jiX2JkqjJp6X5hc6qHhtR3C5d2mu23ShnFSyre8eWdp8w1IIAp4RF/RUtD6vqNwGWnn5pgx7oDyG13Qdmgo30qYjZZPK4pmjciwDKbJYBEtdNMEEDqh6VYiCUDrvGkFw4UElWBaHKc7HsceDg59+SsE5TWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606464; c=relaxed/simple;
	bh=pc/VJ1lCqkuIAuXgBQOqD4NDNJ806OYBSWFMiP8vFMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHDPHRu2Q+bPOH4S6G5/dokkurPqh3Xk8SZNj0Dt1n1LvSHPj/UFTtX57afQK2AbK1noswh2l8qgSnI49lvp3+E0rExiZAOwCyfgmc0pA+F8TB080CaiaCnfI/gbwEOETw0BbnEKSnVjnO6DqkPckb1kkJkkmtR2np2s/0PxrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by laurent.telenet-ops.be with bizsmtp
	id NdM02C0065V4kqY01dM0ZD; Mon, 13 May 2024 15:21:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vb7-00399m-Ry;
	Mon, 13 May 2024 15:21:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vbv-008tqU-Vr;
	Mon, 13 May 2024 15:20:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] sh: smp: Protect setup_profiling_timer() by CONFIG_PROFILING
Date: Mon, 13 May 2024 15:20:54 +0200
Message-Id: <effa5eecbd2389c6661974e91bb834db210989ea.1715606232.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715606232.git.geert+renesas@glider.be>
References: <cover.1715606232.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/kernel/smp.c:326:5: warning: no previous prototype for 'setup_profiling_timer' [-Wmissing-prototypes]

The function is unconditionally defined in smp.c, but conditionally
declared in <linux/profile.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index b3ea50aabba3d7f2..108d808767fa9984 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -322,11 +322,13 @@ void smp_message_recv(unsigned int msg)
 	}
 }
 
+#ifdef CONFIG_PROFILING
 /* Not really SMP stuff ... */
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return 0;
 }
+#endif
 
 #ifdef CONFIG_MMU
 
-- 
2.34.1


