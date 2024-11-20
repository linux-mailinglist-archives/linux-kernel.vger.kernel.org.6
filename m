Return-Path: <linux-kernel+bounces-415181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFC9D3263
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A76283808
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48E1474A5;
	Wed, 20 Nov 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TPWm9p7V"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA9146A79
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072074; cv=none; b=Z3JT1KDpFV3WJuHZgqRulsdhAcPXTivDZeGcumsDiT6n9ut2/zSclezTVIP3vZ6bIxRNxzvvo5RcryJJtv/DvZqV7W1o1sBV+eq/qJavTU4K92IRM6Q3jNSOzA3KvLOzfUsLQUA6j0P0G+tPRgRbaIWtfy73CjIdQ53Q4rUttu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072074; c=relaxed/simple;
	bh=AJ57TzRTOw2S0Kp41t09aYHn+RGu20bSvQUPuwHrHnI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KpLBpnqHdmQA1PF32VT6Ye0NUW7bHDVZkgdDzY3TDmtFpzSQbEecVXB6Ja+Hej1AbFvhoVl876Tu50NovRCynAtc1wGJSGvK+c3RzOHDAgFaTMxeausE1v8QqMcJOMTOb0E7qj8lIzCLJnIxsBMOiXyxsnHJTpbLvmk0LzLFzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TPWm9p7V; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732072066; bh=N9sf+ePvMFKYrZY7XeQBpjh72pBc9Va3eTg4PtaoaKg=;
	h=From:To:Cc:Subject:Date;
	b=TPWm9p7VG+v9chPC4MGco6YyjwTgk3iDMzPcmpRQQKOzF4EF2Rp0RS4C7jNCNqqkl
	 KcBT04sCIjHU2dKd+8Cai2ABnD4kujsCsIn0hmbO2hR5EmMpdsrhlxcX0Jk22TiCnT
	 TCfKnqOpIH/QOBlZ6GLqXUWz7kwrbJAYICAQR3KM=
Received: from archlinux-sandisk.localdomain ([218.95.110.191])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 64B6C2C; Wed, 20 Nov 2024 11:01:36 +0800
X-QQ-mid: xmsmtpt1732071696t7u88rilu
Message-ID: <tencent_1E5E3AA25C261196D8C1F7097F130E382008@qq.com>
X-QQ-XMAILINFO: MJEEBIyZqkdZA6jD+mZtz2rZfHMRPLmkQefkxd5o21xC6Xbec/omIKpPepRxa4
	 +A2CI0hSHsjoeYw6ZqIvtCV8OQGfmrna4cV7ffJ2JQJOubIRv7TpywuJ2Grjqm8Ofzh9n6loud5J
	 2YB9vMhtw6sG5v/8gKSxpxBRwcxTuYysF5hk3udJDJMENN1lm5GApbQvKU5nLtN+DdZcjuvq3FSl
	 +c0JLcg8QhiZ1sSbe/e4RJDeCsQXM96XvyIlOkeRg1IB3ZPrG+V4slcLg2TEmdNFwkS6fdwID0zf
	 kl6MRyjP3Scp1svYrfeb60XQSgrP5XO3H5vAgL2rkFyR6XfzkE0Ru/K2PMu9KNQv0u/xlsK29+Ml
	 CDC0ivan3mBhtTYMEaj4jAY68uN+NnNCckg95ZjN5gisJSEgXX/1hWs0rb2cGJwx5cyYvYF6PgZ7
	 /DAcBlNNhu+z8e0UxljzGyIvre+ZBih4UMtpeeS3JZxyL0WwZLWqQxfpD1K2naOuu4avmyJSi56b
	 SkM9QWjVXmXvPwClNwQX4pB+IC8RmQ431Z9eZLKtAWRE85WRWP9kVVGF2kmp5/UfzkA5EWVQT82G
	 e2ZppMWO0zbObmgveVSHonSZluwUvSfhwhknpWAhuunQFsyGHmPZCcR+5Ve04gnAN0kBTpkh+Gbi
	 KXY/SBaGrly4z9njaaNBAfH82GR1BW+Y7zeoxmZnKQoWaeYOy7iNUpYQPcDyCc7pj1dcDc4YYIu7
	 c5g6lKe6K2kLcNoGiNo+6cQwbNGb6NuhKAmtK4QV+j1hd+4LNOXE7NrE8uG/TKEeNVS+IygbYjYH
	 ztYSHriJA4rn7f3/nkkxplDuC7RVyXdYwNIrpqSVwETgv0fO3948Eg0G37SFLNtVkDvDPo4qdoZJ
	 EqLkP3ElOuE4t0bDGYd3EwtWGC8wU0PzZ/4SPmLn8R8RLFALNG+34=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Jiale Yang <295107659@qq.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiale Yang <295107659@qq.com>
Subject: [PATCH] mm: Change type of cma_area_count to unsigned int.
Date: Wed, 20 Nov 2024 11:01:35 +0000
X-OQ-MSGID: <20241120110135.1435-1-295107659@qq.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer 'unsigned int' over plain 'unsigned'. Also make it
consistent with mm/cma.c

Signed-off-by: Jiale Yang <295107659@qq.com>
---
 mm/cma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.h b/mm/cma.h
index ad61cc6dd..8485ef893 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -36,7 +36,7 @@ struct cma {
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-extern unsigned cma_area_count;
+extern unsigned int cma_area_count;
 
 static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 {
-- 
2.47.0


