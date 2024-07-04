Return-Path: <linux-kernel+bounces-240799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90FE9272F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D311C24382
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C41AAE15;
	Thu,  4 Jul 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wuj2igF1"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C64D1AAE07
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085060; cv=none; b=kvW2LyVssoFZlOAUrI/X828Ml81trNZo2INRQsdtzZBKhmG6hyJsnCsx0EPvISXX9FDmtpM3ca6NTt0Bmx4HSaUhHmdnFcNwAS5dRZKoFv8/FrLGOpnkhgVHR0Lx3clK67ClISqVLl2TK0eO1ItMsCkEAHUSzuPHmvdUfHs6hGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085060; c=relaxed/simple;
	bh=vSAcbt8gumakBGtnfoBN+FKKENIOaLHPkmF6hNieuic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uV8nf9uONUnofiI3w/dLPep6nSS/kIPQtWMO0fJYAzqRgQo6YhXD68mxnZ/3kbZYb/Gy/6xekUr+tcx0IA2KO151EjUzXrVrvu2TqXNHiQW5Nb3KxdS8B+13hzTaQBTv9/UrOBSsFhKgCy3VaPA9zHSZQzEe2D0OvEVCPE+EY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wuj2igF1; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720085059; x=1751621059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=no6WZMQzqKvDKPLvg7QcgHAcKPL+I6pwmi1+4ckMgUI=;
  b=Wuj2igF1ncErMsXXnQaTAxxXQeVX68X/2PD6KnJAM9HMOh03yUsjECNb
   nnkYsIRsm0GKjMhbNfCtttHa9P/iQTDYhu6cda1uidgdcoV8R1r27PVQU
   uoiQvBEGBfHN7Eqb38AHoFeC8ezesYKGqxPSEmz3KNKG1lRUVqkJORqie
   w=;
X-IronPort-AV: E=Sophos;i="6.09,183,1716249600"; 
   d="scan'208";a="308566868"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 09:24:16 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:30020]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.96:2525] with esmtp (Farcaster)
 id c72bac90-c64b-4d96-a704-86ecd4bb90fe; Thu, 4 Jul 2024 09:24:06 +0000 (UTC)
X-Farcaster-Flow-ID: c72bac90-c64b-4d96-a704-86ecd4bb90fe
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 09:24:04 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D003EUB001.ant.amazon.com (10.252.51.97) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Thu, 4 Jul 2024
 09:24:02 +0000
From: Fernand Sieber <sieberf@amazon.com>
To:
CC: <linux-kernel@vger.kernel.org>, Fernand Sieber <sieberf@amazon.com>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Optimize vlag entity placement
Date: Thu, 4 Jul 2024 11:23:45 +0200
Message-ID: <20240704092345.51644-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)

Optimize for common path when placing an entity with no lag.
Since adjusting a zero lag is always going to produce a zero lag regardless
of the local load, don't bother about calaculating the adjusting factor.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..e78272c87274 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5190,7 +5190,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
+	if (se->vlag && sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
-- 
2.40.1


