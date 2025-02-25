Return-Path: <linux-kernel+bounces-530456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99642A433B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97CA17A859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8D24BC06;
	Tue, 25 Feb 2025 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cvgcx60o"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8752206BC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454787; cv=none; b=l1rGF4i93ot/l3UCvdClkrssWoa5JaENFlWEQ3GvtDyw1D2JZAMKLOimPmk/X7T2WB8VQBjM3eIvmNOxMXTFGo/TthrZbNG5IDmrB6D2J7aKUtGMFS3RFRuc7KNGbH9MB5KNKxYEQ9NDghBUTgMEfKi8O6kDWdXDoWU9lGWG8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454787; c=relaxed/simple;
	bh=aF1WRTePyUyRnZHJpGhucp9w76Ljz8qdTGSMRJjqC9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPd3C9pD71g9/B6aBU8XRdxzs09cr40V5nE1WbjkR1kJ9gCL6gazoPdwrKusiLWNoL/r3y3oH3FZ7v7qqtjvCc14kZJEYVBtdvWsWUf/UiW52AE8QfdFPAbJ7im4ymFCCHBESerwRk2ZoMTWHHr3LjvaMotOsyPwCRnpVbDI4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cvgcx60o; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740454780; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wfIqepXZVUfIjlPUk4Da5gDeRqNF03KNFcNHAJQ76D4=;
	b=cvgcx60oMVecghl6p12IkDscpCOmPH6tPl6KPsWU3kBOJAb7edkSA9qwlP1VqZu3wqZmhM89DNxipte0qMY4aK/veXfSLJVDusraqJ+nzn/FgAIQ/viR97WQzDKO/sm5Oae3Hqsf6W92Kayaxb0GtOCoVoapng3eu1hkdSbt6dA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQD6RSw_1740454776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 11:39:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: allow 16-byte volume name again
Date: Tue, 25 Feb 2025 11:39:34 +0800
Message-ID: <20250225033934.2542635-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actually, volume name doesn't need to include the NIL terminator if
the string length matches the on-disk field size as mentioned in [1].

I tend to relax it together with the upcoming 48-bit block addressing
(or stable kernels which backport this fix) so that we could have a
chance to record a 16-byte volume name like ext4.

Since in-memory `volume_name` has no user, just get rid of the unneeded
check for now.  `sbi->uuid` is useless and avoid it too.

Fixes: a64d9493f587 ("staging: erofs: refuse to mount images with malformed volume name")
[1] https://lore.kernel.org/r/96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 --
 fs/erofs/super.c    | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f955793146f4..b452b6557aa5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -152,8 +152,6 @@ struct erofs_sb_info {
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
-	u8 uuid[16];                    /* 128-bit uuid for volume */
-	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3dc86d931ef1..19e52ffa34c5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -317,14 +317,6 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
-	ret = strscpy(sbi->volume_name, dsb->volume_name,
-		      sizeof(dsb->volume_name));
-	if (ret < 0) {	/* -E2BIG */
-		erofs_err(sb, "bad volume name without NIL terminator");
-		ret = -EFSCORRUPTED;
-		goto out;
-	}
-
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
-- 
2.43.5


