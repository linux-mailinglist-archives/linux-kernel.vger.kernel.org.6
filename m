Return-Path: <linux-kernel+bounces-407245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550569C6AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3121F24387
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9718A92A;
	Wed, 13 Nov 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0QPuq5q"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1721185955
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487275; cv=none; b=TqiR9W7Mb3hlrIieyJgZdV/R29v3nzVB0t2QFKQ2x6V+DDuTUITKbOKIr5OfooODOKN7AGbjFw6t8VXkq00uUuHyjFQgHI5BbwrguxXTmb1NKa3JI3R/+6yTeRwfZr4xuvXTmu5FhSPtWmJTfjIfF57YBHAIXIv+oqHGdb/idn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487275; c=relaxed/simple;
	bh=9ac3S7GwjMYsuWPSg9A6e77/XxzmBRaa86u9PtncFZM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nktE4Os/3qCkCQjODZXWUATKWSOFym3B3ovYxHthQjsrRkEAOR61NjD0K7bgEV/sb6+K7CZKK6QMnXcqYLQn58t6PpD3HaiX/Pq6jLUMIn+Zeyn9Wu1lh0dyS+gZrXri6iP61VptKImw2vfgLYQITupFnqiNyRF4o4TKo9Jmv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0QPuq5q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21145812538so61061985ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731487273; x=1732092073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hARpX5ZPx74ElNUTsqJ78OBOuYxJi1lpnBAIag7Jp+g=;
        b=k0QPuq5qYNk5Tt7mSgrD0GRDXhRpBj/PfjyJOW/RXnnD9NfTlhC3Xq96mjLeHQZkn2
         qLfFr433liUqzEMtLwwKa4K/0DIG/YbfypOKt0Joc+zOSVeVVDnYsac4tzHkXmmO38/z
         XJT03AGZSCLK1irDK8JoCO+ZPw+LF4M8G/616hk1zJ5dYMkb/y3Bdfl/yG0g7aNXGnGk
         AMzCecNqH4VcR7SUUbc4k+5tSRTofJuvZ6lsvtojlEkCAoT1on22zNXX4/J8+nKKE7KA
         C4XzD+j8McF61YWMaTcWf2ylHrEq9QbbPain+TxfurlE3dW4+IjbaKzOlMx0jyDqN5RU
         SESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731487273; x=1732092073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hARpX5ZPx74ElNUTsqJ78OBOuYxJi1lpnBAIag7Jp+g=;
        b=D2D+K4ShBg5rs6EJaeqGck1zcpMoM3qALoR+teELxfvEaacsPTHR2OLzEpDEnwwKqN
         oQu0/phjiLtdEHkRWIJS30XKkh5+7ICRO+hj2Y3v5uWGtOR3rR7x8eY1UU9CbYmQNKXs
         L7dyxorm3PxSNhh4n82SwhAlXghBQ573FE3v2fzoYGsUFsFuG6NNHk3OjTnZn1IwVedb
         rTzpAel+uu9jXuizHimwg3yXTVwkoKKLh6/yO5KJ+1Mg1Mg0SyXbnNCqcFyPsGvTrp8r
         rX2DYpWEtx9lLcSowQ3+SFo2WhEPacTGmn8OxIamz36KHtP6EbVGPVhB6yj8qolk9U67
         mXrA==
X-Forwarded-Encrypted: i=1; AJvYcCVw3gmUpOWrX9XEhJOrTOrYMIoG5xoPTNm5m++Z/2XPmjQh3qc8xzoqD3cvah5kx/mTbCX037R464T6HoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyFRv1NzpyAUct07imYFG5sy8cgszsiSwWj8iYl1rlPqUfoAD
	QEHrQMqyBUhdEP3IVnJL14VLdSYbjuEv+V4iuoTzVf3Td+JHyqlP
X-Google-Smtp-Source: AGHT+IGIEuI1rvXnQCvJTS4p7g2yPIXhYnzr0HRFq8xLhfWXpkWFmXjk7RUi+cYqXEN3kz7hHMHcYw==
X-Received: by 2002:a17:902:f54d:b0:20c:ecc9:c50b with SMTP id d9443c01a7336-21183d67ce4mr251260245ad.42.1731487272793;
        Wed, 13 Nov 2024 00:41:12 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177ddd616sm105613825ad.63.2024.11.13.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:41:12 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	ocfs2-devel@lists.linux.dev (open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
Date: Wed, 13 Nov 2024 00:41:07 -0800
Message-Id: <20241113084108.186506-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function simple_strtoul is deprecated due to ignoring overflows and
also requires clunkier error checking. Replacing with kstrtoul() leads
to safer code and cleaner error checking.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 fs/ocfs2/cluster/heartbeat.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index dff18efbc..4fc1b23f1 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1537,8 +1537,9 @@ static int o2hb_read_block_input(struct o2hb_region *reg,
 	unsigned long bytes;
 	char *p = (char *)page;
 
-	bytes = simple_strtoul(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	int ret = kstrtoul(p, 0, &bytes);
+
+	if (ret)
 		return -EINVAL;
 
 	/* Heartbeat and fs min / max block sizes are the same. */
@@ -1627,8 +1628,9 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
-	tmp = simple_strtoul(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	int ret = kstrtoul(p, 0, &tmp);
+
+	if (ret)
 		return -EINVAL;
 
 	if (tmp > O2NM_MAX_NODES || tmp == 0)
@@ -2142,8 +2144,9 @@ static ssize_t o2hb_heartbeat_group_dead_threshold_store(struct config_item *ite
 	unsigned long tmp;
 	char *p = (char *)page;
 
-	tmp = simple_strtoul(p, &p, 10);
-	if (!p || (*p && (*p != '\n')))
+	int ret = kstrtoul(p, 10, &tmp);
+
+	if (ret)
                 return -EINVAL;
 
 	/* this will validate ranges for us. */
-- 
2.39.5


