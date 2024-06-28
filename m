Return-Path: <linux-kernel+bounces-233323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB06491B576
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BFC1F2260F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADB1CF8D;
	Fri, 28 Jun 2024 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="UeeZ525X"
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BB1F94D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545374; cv=none; b=FEhGRwQn+ee0PlCWZE8zye9ykK736cZeNovE+QrvvSgDjwp0eJr/gr0xnvWFpGdf5e8kUY45LpjDuncypGCSC6GC4SPJPvPGd0Ttg5CdwVgJ9rhhkiaoU+/cflaNI0qmxuSk7mv5UNUT8SbBd9wmk0sup9VYK5lM6CibLqHtiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545374; c=relaxed/simple;
	bh=AywVzZnNPSkfDr4SCvmsW8TNh71lQfapFa8bRRrvmjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muPXSHE7dbK+IneN1OpkaSw/lWAlTtxQk3vKsdGkvywQgprX7bFQZplAnUmybetezfyHcEJPC++mqlY+Rb30UU2E/fvvSnu1gpaleNBnRxrBbilvVEyoe8jUwgWSZbA0CZ1E6DkhW3SKds24E/qNF7goCpBhMXJqLyUObP23w+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=UeeZ525X; arc=none smtp.client-ip=140.205.0.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719545362; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XwOduJZ0J4vmIeZ5x8hown432z3Od2SXxlXWqlbqbkI=;
	b=UeeZ525Xy9zWz4pfiYOrI2duatwomBvjJ2lkKtA/r5paHw+z2lmsEbtP5Xkvu/28Zratcax9LBwvEmqX9UYILb/eZei0stSt7jOiPvNM2CbhsUfVUTzqC6GOCDBTtm6zHQKGhHAPOT+DmvTDzrCRKuc39yPFe2WF7ZuRhgFDxyU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023106192;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.YC4ESwj_1719545044;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YC4ESwj_1719545044)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 11:24:04 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: hughd@google.com,
	akpm@linux-foundation.org
Cc:  <baolin.wang@linux.alibaba.com>,
   <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <linux-mm@kvack.org>,
   <linux-kernel@vger.kernel.org>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH] mm/shmem: Fix input and output inconsistencies
Date: Fri, 28 Jun 2024 11:23:27 +0800
Message-Id: <20240628032327.16987-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 19eaf44954df ("mm: thp: support allocation of
anonymous multi-size THP"), add mTHP support for anonymous shmem.
We can configure different policies through the multi-size THP
sysfs interface for anonymous shmem.

But when we configure the "advise" policy of
/sys/kernel/mm/transparent_hugepage/hugepages-xxxkB/shmem_enabled,
we cannot write the "advise", but write the "madvise", which is
unreasonable. We should keep the output and input values consistent,
which is more convenient for users.

Fixes: 61a57f1b1da9 ("mm: shmem: add multi-size THP sysfs interface for anonymous shmem")
Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 13d139abe69a..d495c0701a83 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4983,7 +4983,7 @@ static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
 		clear_bit(order, &huge_shmem_orders_madvise);
 		set_bit(order, &huge_shmem_orders_within_size);
 		spin_unlock(&huge_shmem_orders_lock);
-	} else if (sysfs_streq(buf, "madvise")) {
+	} else if (sysfs_streq(buf, "advise")) {
 		spin_lock(&huge_shmem_orders_lock);
 		clear_bit(order, &huge_shmem_orders_always);
 		clear_bit(order, &huge_shmem_orders_inherit);
-- 
2.19.1.6.gb485710b


