Return-Path: <linux-kernel+bounces-541020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787FA4B787
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA916C0E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E31D7E35;
	Mon,  3 Mar 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO58vvOj"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7A156C6F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740979395; cv=none; b=Wrjv6cO7GEr9kEMfDb2ZhM4O9kOE8ChhfL/gasPy+r2hOhikFPr0vT4h4CopKTdWT7XoVzHlyDjWPYSAANfbtKc7u/7F2Un/TPf7u6t1LPSAlyTqY7hSMXQfZi8X0eUdzwDZBFm9M4T1DpZ55jwEPxyQ/OZs6zq8jv8AIDGyQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740979395; c=relaxed/simple;
	bh=jJzQK1GmVOXUuQndrSBDWlin2sBxy4koAXCrP5OQAhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOmzROMxdUrsIlQwo/EkoTz3iYfwimz6AW6R95EfdKtSB0hWWT00LNihkHvCIvQEDRsyp0peCGFp33PGtagofdBQDcdq7YVv1EnOyFdQH5aca5tUBypFq6lLpBzCYFX5M0yFYYfp+LJmv+eozADgVjGZQ5aPOfxJFqdva9qYEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO58vvOj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso6306493a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740979393; x=1741584193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQyMj5PE5gUiweDRcbAeh1T6kmfInpXRvaLuaWvbDMA=;
        b=mO58vvOjcPPW0ZDBBXl1BjJV1aVySqggM1lq50y1fQZQ8lvdvNZ//vqyKJH7O6b6HK
         mds0JVp4W6r5gbkDjNt1Cou54D+frVTutOTpqdUYAJ7cqFidPSv7xZWsFXyD9JIhScsL
         gN9YuT7dipSvc9Yb0W9P+t0flamvCOmcb8eGaRH3PSTx+ev0anxvKj+H5l/CaAuu754T
         a7En3niu4jFCILb/Nx26Za3uWbzHVCFKpP5Xjw++pcvhMMhzYQWJmG8YPXtm5Wdlc7dK
         8XM2/dd9/QDcanPQGDOpaxeA65h38S0ClFpH+2od+Qh0qKdH6Fn5xgGTlqimDMpiTwPi
         2JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740979393; x=1741584193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQyMj5PE5gUiweDRcbAeh1T6kmfInpXRvaLuaWvbDMA=;
        b=rfv+jRK4hEFXAmGecuaHyGSkLIVhnWT4S0xnen5N6OAcOof0zsqQd33Ou23uB99TBk
         mNEbTOmbRDRNfyfvbuvd+muyBiKR/Gt+QNamh7qdI66EVbnhZzuch4VWp+6wKvbFhVNp
         knhCOcz3wQsBnCVlFcCdTqAYHX4HAs+z/CidWMNg+CylWQwuMRpxM4JVsJKP6AycapjS
         IGJnAUHzJ18/iOkWlz2/xWk0x6Lmgq3sPWzBri697LXhHZsY7SVIOpBNAIKA0iBY7d+u
         bbt5rNNmecT+wVUDvgW6ij4wlWfdZ6tl9tUs9G1KYJPaEYcb0rsVK7U5Kr03RCPwH+np
         Z5Vw==
X-Gm-Message-State: AOJu0YxxXV1ZPHIz+ycUGmYUMfGXAX+z4QoyuAX0uPHwcf+7CC1MF7bI
	Q7J28JxC+jHYAAXAeMan5HMj1FQOFb8ReZLi183DVIgPLepuMAfV
X-Gm-Gg: ASbGncsg4AiSIKDWVtBjEFQEaVvdOT/ywJ2xjmxDchwQBJEWHFxerkgIfK3XATEK8yw
	jdQ8QPQkfsmkecxWd5/Ztl7OTH0WuK/2G8Si3AyCGaQhX4l22SA4t0PseZip4yyUWXPgPVXoToa
	ChsFdZSwp6lynw6a0i8q3pvnIgT7xWHfRQAWyvb3kQLagXjjTKw7ZTz41Pw0bvFRdbTzJbHZbp0
	bkIKL9GLNGgHcFoP+Uf9nH9r1SWA525vMEWdiXIT4w+vWKSfTKR1Bx2qSHj8/SLfqASMbDLty0b
	5DRI9vrnhzX9NQi+IEo1SeQXZPEf7bmrJOmeBVqnYaY/j1PKYgB6tw2gynhYBAv8l1NZIFiy
X-Google-Smtp-Source: AGHT+IFC/BljQb5OFwlkFgIbTVSZBE2FadnD93ug9y5ymH8CspR8zNPlkoaoiAnz+Z+9FwRVDg0IMg==
X-Received: by 2002:a05:6a20:3d87:b0:1f0:ee68:aab4 with SMTP id adf61e73a8af0-1f2f4d224cemr19344596637.23.1740979392686;
        Sun, 02 Mar 2025 21:23:12 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:232d:15b4:ed40:d86a:9957:4de7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de3ad9esm6128503a12.39.2025.03.02.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:23:12 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: shaggy@kernel.org,
	jfs-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] jfs: jfs_xtree: replace XT_GETPAGE macro with xt_getpage() function
Date: Mon,  3 Mar 2025 10:50:34 +0530
Message-ID: <20250303052034.13420-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503030707.dKjJdF6z-lkp@intel.com/

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 fs/jfs/jfs_xtree.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index fb736a06ea58..fa4f77b436f0 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -115,7 +115,7 @@ static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
 {
 	int rc;
 
-	BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
+	BT_GETPAGE(*ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
 
 	if (!rc) {
 		if ((le16_to_cpu((*p)->header.nextindex) < XTENTRYSTART) ||
@@ -123,7 +123,7 @@ static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
 				le16_to_cpu((*p)->header.maxentry)) ||
 			(le16_to_cpu((*p)->header.maxentry) >
 				((bn == 0) ? XTROOTMAXSLOT : PSIZE >> L2XTSLOTSIZE))) {
-			jfs_error(ip->i_sb, "xt_getpage: xtree page corrupt\n");
+			jfs_error((*ip)->i_sb, "xt_getpage: xtree page corrupt\n");
 			BT_PUTPAGE(*mp);
 			*mp = NULL;
 			rc = -EIO;
@@ -270,7 +270,7 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
 	 */
 	for (bn = 0;;) {
 		/* get/pin the page to search */
-		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -825,7 +825,7 @@ xtSplitUp(tid_t tid,
 		 * insert router entry in parent for new right child page <rp>
 		 */
 		/* get/pin the parent page <sp> */
-		rc = xt_getpage(ip, parent->bn, &smp, PSIZE, &sp);
+		rc = xt_getpage(&ip, parent->bn, &smp, PSIZE, &sp);
 		if (rc) {
 			XT_PUTPAGE(rcmp);
 			return rc;
@@ -1080,7 +1080,7 @@ xtSplitPage(tid_t tid, struct inode *ip,
 	 * update previous pointer of old next/right page of <sp>
 	 */
 	if (nextbn != 0) {
-		rc = xt_getpage(ip, nextbn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, nextbn, &mp, PSIZE, &p);
 		if (rc) {
 			XT_PUTPAGE(rmp);
 			goto clean_up;
@@ -1435,7 +1435,7 @@ int xtExtend(tid_t tid,		/* transaction id */
 			return rc;
 
 		/* get back old page */
-		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 		/*
@@ -1451,7 +1451,7 @@ int xtExtend(tid_t tid,		/* transaction id */
 			XT_PUTPAGE(mp);
 
 			/* get new child page */
-			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+			rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 			if (rc)
 				return rc;
 
@@ -1729,7 +1729,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 			return rc;
 
 		/* get back old page */
-		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 		/*
@@ -1745,7 +1745,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 			XT_PUTPAGE(mp);
 
 			/* get new child page */
-			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+			rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 			if (rc)
 				return rc;
 
@@ -1806,7 +1806,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 		XT_PUTPAGE(mp);
 
 		/* get new right page */
-		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -1882,7 +1882,7 @@ printf("xtUpdate.updateLeft.split p:0x%p\n", p);
 			return rc;
 
 		/* get back old page */
-		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -1899,7 +1899,7 @@ printf("xtUpdate.updateLeft.split p:0x%p\n", p);
 			XT_PUTPAGE(mp);
 
 			/* get new child page */
-			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+			rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 			if (rc)
 				return rc;
 
@@ -2286,7 +2286,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
 	 * first access of each page:
 	 */
       getPage:
-	rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+	rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 	if (rc)
 		return rc;
 
@@ -2524,7 +2524,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
 
 	/* get back the parent page */
 	bn = parent->bn;
-	rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+	rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 	if (rc)
 		return rc;
 
@@ -2809,7 +2809,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 		 * first access of each page:
 		 */
       getPage:
-		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+		rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -2854,7 +2854,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 
 	/* get back the parent page */
 	bn = parent->bn;
-	rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
+	rc = xt_getpage(&ip, bn, &mp, PSIZE, &p);
 	if (rc)
 		return rc;
 
-- 
2.48.1


