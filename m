Return-Path: <linux-kernel+bounces-320249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B749707F9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1817B1F2244A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDE16FF37;
	Sun,  8 Sep 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Er4GvlMO"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521D170A12
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804442; cv=none; b=RPajFRlV2YMvr6EFKJNDrPq6QTCYAoLAF0YGbpobp/1MEZYK6i5kSkzeXTstsczKMAv37CJgZq0L2m5EDEcn6NL67JZdQR00LjatJKKHwnOlHcdnq3m5Vl1374/uY6lc15i8G5ETdwltzBoJvkAmxUtSUCZulzPSsRy/D8j3A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804442; c=relaxed/simple;
	bh=Zxej2+RfME3K222sBAiQeMPUVM72vjM2LFlvxrbl7gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ae9/HA6doHTtkHNBigQMYNVawJlXvw/sSw5r175WFDrXU8SDuoc0GwFek14r3vmL1bz/DcNm5keqFoNaDB7hXpaPiDPBma4fYegXtaY/Plw0UDKeE9E30NirLgryXWvWvCByptUT2wkM5D6IX1tB9d7qc0ITCr944MQdtZSgjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Er4GvlMO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso1293405e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725804439; x=1726409239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD76QrcvtGoS8LAgez4yfl7ZobGyguVxNj5LqFJ82RU=;
        b=Er4GvlMO7ZCFInb6xqdUDeA/+D5qjnkhwgI9/0WU6OxYnNzQSWrXSh2sE/kSaZcee2
         hkOC/vkvO7QjNEeVRqZnE8O9HdHbPHVG+GJEveHRYG85nlfb2mFnoqxi0NHnKJ46Swc2
         qYowe+KnkLbwiFq2BBa3mZ37z48gZPE4WVljlR1LyiDv3QLZNb/wxa5ZhD82DmaeuDhm
         wIBi6Z5Fbqf/NNXQOeXWXogYDpCGS/u/lSSDtP3AMocoCzIeJUDgQgtV5FGvco+wtzOW
         gVJlsHISLoRYmHzmML4LoGPv0dQQfDL8ughzMYcn+bSWvYD9B9LTA70UfmSsqu7Dxptg
         ZnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725804439; x=1726409239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pD76QrcvtGoS8LAgez4yfl7ZobGyguVxNj5LqFJ82RU=;
        b=gSerip6kA/7CcZz/L6/VdhYepghmO+lWq5GBb14CO7+GY006xwFxfBiYqvzv6llSkL
         5nZftadgw5oyJUTeC1x3Q+WFnO48M0XRmTv5qlaLBCPyMcTCTRs0pKgexb4l490hk3is
         Q8z+d7TsAF9SO5jT0DmBC+6V0+x34gcdoL5RblnR1vHZBIGi/Yz3kzH8WrY+X5UCNqW8
         OyIy8YaTTkuBMxYx1DPZYiCz9llLuKgLZhilspSAdiTCBqbZepmVNFhxHC41CVl5UJ6a
         sGxfK4oNinMACPUd3YyyHlJUe+PRWuD2rNnNkMUxWKva+IJF6Y/PBy4qL9Ps5dqvMFb6
         Cr0g==
X-Forwarded-Encrypted: i=1; AJvYcCW2I0xd/zZB6wOdsg/aBIAZjJxJTmyVVvgYYWptZkbLFEed34lpZxCsYRWVhOZCGwFojhhc2Gn3n4opnBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAgZ2HY+nVFDnNu7wGlPDgDG8Zv462s/Wxqa8/tQIrt34CN4q
	4E8Nxxhl+yweDgv6Kc5aRPE8B7PCA6oNvYaRqUVcbwuKs+fGJUyRbTD3Sm3kgRw=
X-Google-Smtp-Source: AGHT+IGJAcrrz0nQ3n+I7PfPJ77mMXJZlyi6m4sZ0dF/GjJ/GFC76+EHDCQVX8nyW1opyCljOBAe5A==
X-Received: by 2002:a05:6000:1545:b0:374:cc10:bb42 with SMTP id ffacd0b85a97d-378895c641bmr2967036f8f.2.1725804438882;
        Sun, 08 Sep 2024 07:07:18 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc074599sm4863371a91.31.2024.09.08.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:07:18 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	glass.su@suse.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ocfs2: detect released suballocator bg for fh_to_[dentry|parent]
Date: Sun,  8 Sep 2024 22:07:04 +0800
Message-Id: <20240908140705.19169-3-heming.zhao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240908140705.19169-1-heming.zhao@suse.com>
References: <20240908140705.19169-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After ocfs2 has the ability to reclaim suballoc free bg, the
suballocator block group may be released. This change makes xfstest
case 426 failed.

The existed code call stack:

ocfs2_fh_to_dentry //or ocfs2_fh_to_parent
 ocfs2_get_dentry
  ocfs2_test_inode_bit
   ocfs2_test_suballoc_bit
    ocfs2_read_group_descriptor
     + read released bg, triggers validate fails, then cause -EROFS

how to fix:
The read bg failure is expectation, we should ignore this error.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Su Yue <glass.su@suse.com>
---
 fs/ocfs2/suballoc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index d62010166c34..9e847f59c9ef 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -3118,7 +3118,7 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
 	struct ocfs2_group_desc *group;
 	struct buffer_head *group_bh = NULL;
 	u64 bg_blkno;
-	int status;
+	int status, quiet = 0, released;
 
 	trace_ocfs2_test_suballoc_bit((unsigned long long)blkno,
 				      (unsigned int)bit);
@@ -3134,11 +3134,15 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
 
 	bg_blkno = group_blkno ? group_blkno :
 		   ocfs2_which_suballoc_group(blkno, bit);
-	status = ocfs2_read_group_descriptor(suballoc, alloc_di, bg_blkno,
-					     &group_bh);
-	if (status < 0) {
+	status = ocfs2_read_hint_group_descriptor(suballoc, alloc_di, bg_blkno,
+					     &group_bh, &released);
+	if (released) {
+		quiet = 1;
+		status = -EINVAL;
+		goto bail;
+	} else if (status < 0) {
 		mlog(ML_ERROR, "read group %llu failed %d\n",
-		     (unsigned long long)bg_blkno, status);
+				(unsigned long long)bg_blkno, status);
 		goto bail;
 	}
 
@@ -3148,7 +3152,7 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
 bail:
 	brelse(group_bh);
 
-	if (status)
+	if (status && (!quiet))
 		mlog_errno(status);
 	return status;
 }
@@ -3168,7 +3172,7 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
  */
 int ocfs2_test_inode_bit(struct ocfs2_super *osb, u64 blkno, int *res)
 {
-	int status;
+	int status, quiet = 0;
 	u64 group_blkno = 0;
 	u16 suballoc_bit = 0, suballoc_slot = 0;
 	struct inode *inode_alloc_inode;
@@ -3210,8 +3214,12 @@ int ocfs2_test_inode_bit(struct ocfs2_super *osb, u64 blkno, int *res)
 
 	status = ocfs2_test_suballoc_bit(osb, inode_alloc_inode, alloc_bh,
 					 group_blkno, blkno, suballoc_bit, res);
-	if (status < 0)
-		mlog(ML_ERROR, "test suballoc bit failed %d\n", status);
+	if (status < 0) {
+		if (status == -EINVAL)
+			quiet = 1;
+		else
+			mlog(ML_ERROR, "test suballoc bit failed %d\n", status);
+	}
 
 	ocfs2_inode_unlock(inode_alloc_inode, 0);
 	inode_unlock(inode_alloc_inode);
@@ -3219,7 +3227,7 @@ int ocfs2_test_inode_bit(struct ocfs2_super *osb, u64 blkno, int *res)
 	iput(inode_alloc_inode);
 	brelse(alloc_bh);
 bail:
-	if (status)
+	if (status && !quiet)
 		mlog_errno(status);
 	return status;
 }
-- 
2.35.3


