Return-Path: <linux-kernel+bounces-412267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5E9D06A3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DE41F21F91
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78511DDA34;
	Sun, 17 Nov 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQR2QxK"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CCB49627
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731880345; cv=none; b=UvWqomW7coF2sPZ/wnVajtmobTW7pLz5jsuyH07cBVuJ7ioWTh0uRHLVY6CQXFnDD0q/Wnww0xtLm+NqKFQ78YGPS1P6bW57GJM7RTz2OFxyozheqr2vxiMfPTWz4uEkojRmgrKdplWb2/JZQnPW7iAfoXkeXIXL0JWF9WEhZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731880345; c=relaxed/simple;
	bh=NU7crY72ANGOmaw+FykFygE/dkkujprQhyOPT2KbGvQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=V8WQueqcPAmbg46e6X6SHqISapSsUXB7R9RSk1Yh1HMnHqaT3H1f7hcNzjLfJTlJbm6OZJ/H4d6+Yz4JVNjQ1tB4UIqJDYPSGSnWbbZ8+MwF1qhpwMq6zuBjgW4OIT0s/fUh2fhROPLf645rPM23A8h0LcVS3rCtwDYDDYim1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtQR2QxK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f809332ffcso2389901a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731880343; x=1732485143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZFa1I2jutht+G4LRPkakmXfxYKKGJlHT58aBpyCo3A=;
        b=NtQR2QxKGMgVriG77nTFVjWrg+BmqFeusp5kcsJcNZeTM+0mead8unEKoPxX1a8U2c
         J19iPVn3Bi/xccGEjm7XElJH5859KEgrqDKtwP3yeRUcnTP5L7/Z3XATlIGjqco881zq
         1OomwoYINlc++Ii0K+v3zx0paFuMng2poL8oTme3FHTRnTeqh2YC8EDUzJ5XhJ4Hi/yB
         tTYjpQH5WB9Dg5lBCg7LFE5Vc+2blHJppOND8JjTS/evHTN5Euk/1Q+AwAaUMJ7zahzg
         ELafV0QdBSgTumy2CXP69IBDhOJZOgzI0h2r8g2rraU2OtSq5exy216hFxYk0sQnXPsg
         z7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731880343; x=1732485143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZFa1I2jutht+G4LRPkakmXfxYKKGJlHT58aBpyCo3A=;
        b=BvouINxM1yV3Rqdg+kTx/ITc96kABL1GsS/LD40rhvkxj2BymzZu9LHvdZdr9QYk4g
         uO6dWPrhniIMoKoubyRQujT5W4UgfQGp9ThHOVf+Rgw1oCw7O2Dii52GHeCw4RwR4isF
         vUx9Q1rOe4SY6fJNbJmHW4i2lfuuzAURNHHpVDKy+/v3YTIpdJ07kmglFDlaBUTESxYv
         Pw15OtuYHvOZ/H8yQDTPGg+iSd0+wo9R5i0DXCEK9BQb3MEwfd+G/KKVOC3hqKYD517j
         tJNNd4tZnk9qNM9+mnwDoq0cjuhtV5nLwxZ5MDC7q/tzic6XaezJQcDIx9kDnJ1/8iTZ
         peGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbStWXCx3GeZryLpXDP3V/T9tfQ4N6jgDq1ZkldYI/SX8eaPqPf/WLzfGrM4yFCYaghwypvYRmLhqmwi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHPEq6qYchdWPRg170RapB65+5VipNdXfDCjXfqAFDNDjthpG
	x19PZzxXRyDFWK+3jlXKeTET4wd2eAbpQzRemi6/QpMvFDVto4s6
X-Google-Smtp-Source: AGHT+IGH3sWRJ7aCqF1wjKKWMkrxL2s288oAl945dj2z0e7cyzKT3LxbZQOtJvHKEce+XipNgoXQCw==
X-Received: by 2002:a17:902:d509:b0:212:4b3:1080 with SMTP id d9443c01a7336-21204b3158bmr55172805ad.13.1731880343068;
        Sun, 17 Nov 2024 13:52:23 -0800 (PST)
Received: from debian.host.ucla.edu (wifi-natpool-131-179-61-163.host.ucla.edu. [131.179.61.163])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211d0f56f02sm44450015ad.272.2024.11.17.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:52:22 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	ocfs2-devel@lists.linux.dev (open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
Date: Sun, 17 Nov 2024 13:52:18 -0800
Message-Id: <20241117215219.4012-1-danielyangkang@gmail.com>
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
v2->v3: code style change and return ret
v1->v2: moved ret definition and removed blank lines

 fs/ocfs2/cluster/heartbeat.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index dff18efbc..76f1e7bfd 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1536,10 +1536,11 @@ static int o2hb_read_block_input(struct o2hb_region *reg,
 {
 	unsigned long bytes;
 	char *p = (char *)page;
+	int ret;
 
-	bytes = simple_strtoul(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
-		return -EINVAL;
+	ret = kstrtoul(p, 0, &bytes);
+	if (ret)
+		return ret;
 
 	/* Heartbeat and fs min / max block sizes are the same. */
 	if (bytes > 4096 || bytes < 512)
@@ -1623,13 +1624,14 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	struct o2hb_region *reg = to_o2hb_region(item);
 	unsigned long tmp;
 	char *p = (char *)page;
+	int ret;
 
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
-	tmp = simple_strtoul(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
-		return -EINVAL;
+	ret = kstrtoul(p, 0, &tmp);
+	if (ret)
+		return ret;
 
 	if (tmp > O2NM_MAX_NODES || tmp == 0)
 		return -ERANGE;
@@ -2141,10 +2143,11 @@ static ssize_t o2hb_heartbeat_group_dead_threshold_store(struct config_item *ite
 {
 	unsigned long tmp;
 	char *p = (char *)page;
+	int ret;
 
-	tmp = simple_strtoul(p, &p, 10);
-	if (!p || (*p && (*p != '\n')))
-                return -EINVAL;
+	ret = kstrtoul(p, 10, &tmp);
+	if (ret)
+		return ret;
 
 	/* this will validate ranges for us. */
 	o2hb_dead_threshold_set((unsigned int) tmp);
-- 
2.39.5


