Return-Path: <linux-kernel+bounces-367452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA99A0294
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8D1F26967
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7721B6D16;
	Wed, 16 Oct 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="GR3lrzCY"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070601C07F9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063781; cv=none; b=cWKJ9ztAvqSnBh4V93bn8RpLgBnhncEG7mHbd+Km5scHfpIZCI0wUROimJAFHZAIMXnaY6N5DEq7AFbRTZdixpOCtPP17Kp4F//WloLZLDmYPIjhnZGB9X3PRrmylyjpE4QazaZNplXNIJkD3BnnVbTPEoDIMTHdYBF1JYlqlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063781; c=relaxed/simple;
	bh=IJqFbMl21b/RVLRiQT27dPMDBeuJTsKV7i1Cv3+IhJo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Xkkvk6baIXSkOxHjqnwU5TM9e8O1q8R7J/zch9LtF4sazUQo/VmeUB6rdvzhXEwifsegfjS1urosBgi0fyfybUmp64GHULWG2KrW7nw5Jd8XX2CzhxJaxHDoQR9R3L97zxCIhi3rsGevhf9YHrmrTNDi/Rpn8vFAaU0fdbNb+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=GR3lrzCY; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 49G5bsPe672665; Wed, 16 Oct 2024 14:37:54 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1729057047;x=1730266647;bh=IJqFbMl21b/RVLRiQT27dPMDBeuJTsKV7i1Cv3+IhJo=;b=GR3
	lrzCYW5J3hMvrSD2mBwUH0gfCviWal6XccoHYfejMqEsiSY8pl+aGzsIf2A6KTZTaJlkIHpMsTQXS
	sDKm/PQKMx9yihd8EKuoNODSiXkmSs2x0qujjNnrLBnQG8HElAz1/lD9lOr8g5FdRPBRncilr9e+b
	5I8FGJGUsbVrZbHxY0A3X3oL3s7EtPp5byJtZSmJ60xg32u6yA/8ICXWz0Oan0BOrY8vNzbCoNE2c
	z87PYaq9QV6MKPFLXHje6abnzxx3lLim+LuteGwuf2hW6LOOTG10KgEO8QgzFCsUDOGysKkMRaRIY
	uinoxBrjJU5KSPd68voSnn5c6f8a/rw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 49G5bRR83032571; Wed, 16 Oct 2024 14:37:27 +0900
X-Iguazu-Qid: 2yAacTOYEzPWnkLEg6
X-Iguazu-QSIG: v=2; s=0; t=1729057047; q=2yAacTOYEzPWnkLEg6; m=QCwC1FNAq8f4EUqZraX48VWMIYM9QXjxgerjrrR7UzA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 49G5bPFN1579837
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:37:26 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC] mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE check for node id
Date: Wed, 16 Oct 2024 14:37:10 +0900
X-TSB-HOP2: ON
Message-Id: <1729057030-4625-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The acquired memory blocks for reserved may include blocks outside of
memory management. In this case, the nid variable is set to NUMA_NO_NODE
(-1), so an error occurs in node_set().
This adds a check to numa_clear_kernel_node_hotplug that skips node_set
when nid is set to NUMA_NO_NODE.

Fixes: 87482708210f ("mm: introduce numa_memblks")
Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/numa_memblks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index be52b93a9c58..b982f9260872 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -349,7 +349,7 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	for_each_reserved_mem_region(mb_region) {
 		int nid = memblock_get_region_node(mb_region);
 
-		if (nid != MAX_NUMNODES)
+		if (nid != NUMA_NO_NODE && nid != MAX_NUMNODES)
 			node_set(nid, reserved_nodemask);
 	}
 
-- 
2.45.2



