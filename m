Return-Path: <linux-kernel+bounces-214174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9E908082
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DE52842D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2B158D82;
	Fri, 14 Jun 2024 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LNDgX3iZ"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA72F25
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327283; cv=none; b=C97It4DHaXKu35HiSJ254GuttZ2/bOAi3ha49hAehMnkXdmyyIPFmdSmwolLyynNqM97hYSnOcAJI5fvDAZqiJs7k3ELKin64dFl8jibVigraSK8doOm47JFMybf5t4GoLPBltP56ddpRQbymdfvBCuDmfVLxw9ecTpDDhx6vKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327283; c=relaxed/simple;
	bh=tIbaCIP9xAaKgjIU3FiXTfrp4VG6oaih8IQWZccKNQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BxobczFqE3aa1OUtdOe4jU8HItzE88xILlGvIy38Fv+ukSNLkapK6mk1DDHYvtloYK0KI5Cbm5EVOtBDAY1/eb5FCzDKAFnkuSxolEq2/XbAOCx8EernsddedPlpP7w0DgK0nyFdSpWLCPkDUAqMVCKV47zbLJtsxIFh0O9fGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LNDgX3iZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718327272; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BQDb2F0aaOJSuzhQ9lADc/Q15DnIgg4AnXxoddC9IM4=;
	b=LNDgX3iZD0wpYv8+b6agYJBdfOA27xdC97aGDMvcqHQm86jUi3GhIlX+3YfNpR/L2WE8lYEAHCxN9KhwSJSt8bsSXYIavBUbwW1m+bbOTr5ApsLAZmwzFRsT1oVRllFJCg7lHeJjbGQ166XJp3ITO61ZA9iFDQBkPWYU1+ekAeI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8PMaPD_1718327271;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8PMaPD_1718327271)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 09:07:52 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	hannes@cmpxchg.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: add VM_BUG_ON_FOLIO() to catch lru folio in mem_cgroup_migrate()
Date: Fri, 14 Jun 2024 09:07:42 +0800
Message-Id: <66d181c41b7ced35dbd39ffd3f5774a11aef266a.1718327124.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mem_cgroup_migrate() will clear the memcg data of the old folio,
therefore, the callers must make sure the old folio is no longer on
the LRU list, otherwise the old folio can not get the correct lruvec
object without the memcg data, which could lead to potential problems [1].

Thus adding a VM_BUG_ON_FOLIO() to catch this issue.

[1] https://lore.kernel.org/all/5ab860d8ee987955e917748f9d6da525d3b52690.1718326003.git.baolin.wang@linux.alibaba.com/
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d9fda1d84a0..62fa3869065c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7844,6 +7844,7 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
 	VM_BUG_ON_FOLIO(folio_test_anon(old) != folio_test_anon(new), new);
 	VM_BUG_ON_FOLIO(folio_nr_pages(old) != folio_nr_pages(new), new);
+	VM_BUG_ON_FOLIO(folio_test_lru(old), old);
 
 	if (mem_cgroup_disabled())
 		return;
-- 
2.39.3


