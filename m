Return-Path: <linux-kernel+bounces-567433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F6A685EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92DF188C976
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10220E31B;
	Wed, 19 Mar 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a96plyLP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAD20D519
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369960; cv=none; b=ul64eROpq3deG20CemdJyamjMes+MOT9+vYrYmLpRicrJ8gyaFw9vNrvVoRXrz7KkB29bOr8Oyv8Oy2zQJBNLGM8rIvNaaDRh6tvpk01YcVv/xx2wzds2IPKyJvZ6TZSgRDpiWCvT6YERsHGDu73NGr18N7zRinJA3jAMZPdr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369960; c=relaxed/simple;
	bh=59VG8MIiJcdiCaxrYyH9CrSs68v8t+zrmZvnXb1LuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIIcVYGo/lXw5OHV3vBl8fQ1FYkOqRZM+CxiccUSNr6R4h7e1mFc7Zkv5/U1eqjmHHD1y2G8Grb90h4W36TDM9/3My2SQgjFVjalrk7NoKYaz+RdAOf70SebIa/WUzQn5WoDGSwX90laAC7AIdInD0R58U6ZQGSONk+x3jqHsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a96plyLP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22349bb8605so144791705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369958; x=1742974758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxDRI3yy3kbzuN5qeoEHV0+lf0cRz3kjqm00o+lSz2c=;
        b=a96plyLPwyizEm8VHzrU+fSIS+/TAWaXg9JtmMXbS2wDKL4c/Nxijf1WZwnywKTrEy
         wkwpT9Yzm8nzfRg2S90P97MPjBImPprXsBmw0iCUbIRiKHmxsWbIH8slzCfc9TuG3+OD
         aFnBrIn9zub9PpKNRFspAKXCHdtan+H4ioMtikjnMEoNE37yxE1KSPZn8Muyl/+vhyXa
         /vUPeUkpiqgx97Q5/BB/jkU23rMdZ6YquHHS6h6pTwa0CncpDuj9yAm4wdAIFNZ3BAgJ
         Emg90i6YOgDvN8phEe2vmvmMei/iPn+xvJdJ+h5vn2sU0T1hXmMOJoQZhiXt5RtCTrXr
         Mj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369958; x=1742974758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxDRI3yy3kbzuN5qeoEHV0+lf0cRz3kjqm00o+lSz2c=;
        b=XFAQv7U3a91KwkC+Xk8hhRynwOja2uNnLF7q19TZ059AlJH+QUfvim0TSeC0xvcyA7
         0nnAno+kPNKyI2Oa8fpOKG+qS+GaW1J6IPjwicxb3ShsBPOnjvur08+WCwbSIWd7C3xE
         l5cj3MCWhSV3UHBxsPjWOdg2DXsuR63rdoynVjEYJPfnynG62rXm+H4fr/zXMKF5CRmH
         nnDnIEvWQSRMFlmTpm3Qlc/6lRtedmX5jVpxq7X8Fibuy0h4WNTepiLJT3oW43bBr8gE
         RUBtNFy1tX0/cuB6ksR95xeVwD5ZS7iDKIzpUuS0iD0NlCd3xdfHoi5OY4wCQPVfOoI1
         JYAw==
X-Forwarded-Encrypted: i=1; AJvYcCXERlzD1Ohrn1PhBdzRGCN2J2Xqahr6wDu7MzC2BGfvvxlJX6OVq8hmlamKvN+QP4VQOLVBbztGIUjRHzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcoNPWUaLfp7Q9CfrFiDPJoBupQd83XqGKbvSX2T+mSwdwQVX
	lVO8Lj1tsIseHX1jJqEDWLWCvHfPAKKkcUjdlUJ5BdkA9tf08HRz
X-Gm-Gg: ASbGncvm6p0unMAUzZNA7cHy13+smqNYzb+WWofLMHt/AYiWO4EcwCp3Mo9XrINsfYd
	o0STL/Ehj+cc5lMUP+7F0TzJXBxpt140C5DIEHcQ5IjnNQdnyiPjm7Qs0LzYoQxbU+bZZrJ+a9e
	ShzTuKIRs7/3XAaYXW621/QlRpsIOzlVKS9Z+amY9+1ryEVz/fN/Tvp9hZkyjwm8e/knNuH+vHP
	WnRSgI6+3WFeEmdtnVtftbsvyW3O7YQOALhc5wkAFMcwVXdWXUqApqHqBXJZ0PgIO3QNJqP7Ezq
	61a/UnnPL/uMUi1xrXoycj8++GOVH5tEHP/ZLaHNMlMyEbmTjoj+tw==
X-Google-Smtp-Source: AGHT+IH7w54kbrZ4KACEo/HNZuJdpE+uY4oEwrMSF7BbiB75U+3UDroYU+kXdh1GJBNXlIS0Aq57SQ==
X-Received: by 2002:aa7:8885:0:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-7376d645d8cmr3026676b3a.11.1742369958356;
        Wed, 19 Mar 2025 00:39:18 -0700 (PDT)
Received: from archlinux.nitk.ac.in ([2400:4f20:11:c00::103:25cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115295e5sm10923556b3a.23.2025.03.19.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:39:17 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: shaggy@kernel.org,
	jfs-discussion@lists.sourceforge.net
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH REPOST] jfs: jfs_xtree: replace XT_GETPAGE macro with xt_getpage() function
Date: Wed, 19 Mar 2025 13:09:12 +0530
Message-ID: <20250319073912.6849-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace legacy XT_GETPAGE macro with an inline function and update all
instances of XT_GETPAGE in jfs_xtree.c file to use the new function.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 fs/jfs/jfs_xtree.c | 86 ++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 5ee618d17e77..4fea5e90e29b 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -49,26 +49,6 @@
 
 #define XT_PAGE(IP, MP) BT_PAGE(IP, MP, xtpage_t, i_xtroot)
 
-/* get page buffer for specified block address */
-/* ToDo: Replace this ugly macro with a function */
-#define XT_GETPAGE(IP, BN, MP, SIZE, P, RC)				\
-do {									\
-	BT_GETPAGE(IP, BN, MP, xtpage_t, SIZE, P, RC, i_xtroot);	\
-	if (!(RC)) {							\
-		if ((le16_to_cpu((P)->header.nextindex) < XTENTRYSTART) || \
-		    (le16_to_cpu((P)->header.nextindex) >		\
-		     le16_to_cpu((P)->header.maxentry)) ||		\
-		    (le16_to_cpu((P)->header.maxentry) >		\
-		     (((BN) == 0) ? XTROOTMAXSLOT : PSIZE >> L2XTSLOTSIZE))) { \
-			jfs_error((IP)->i_sb,				\
-				  "XT_GETPAGE: xtree page corrupt\n");	\
-			BT_PUTPAGE(MP);					\
-			MP = NULL;					\
-			RC = -EIO;					\
-		}							\
-	}								\
-} while (0)
-
 /* for consistency */
 #define XT_PUTPAGE(MP) BT_PUTPAGE(MP)
 
@@ -114,6 +94,44 @@ static int xtSplitPage(tid_t tid, struct inode *ip, struct xtsplit * split,
 static int xtSplitRoot(tid_t tid, struct inode *ip,
 		       struct xtsplit * split, struct metapage ** rmpp);
 
+/*
+ *	xt_getpage()
+ *
+ * function:	get the page buffer for a specified block address.
+ *
+ * parameters:
+ *	ip      - pointer to the inode
+ *	bn      - block number (s64) of the xtree page to be retrieved;
+ *	mp      - pointer to a metapage pointer where the page buffer is returned;
+ *	size    - size parameter to pass to BT_GETPAGE;
+ *	p       - pointer to an xtpage_t pointer mapping the page's data.
+ *
+ * returns:
+ *	0 on success, or -EIO if the page is corrupt or an error occurs.
+ */
+
+static inline int xt_getpage(struct inode *ip, s64 bn, struct metapage **mp,
+			unsigned int size, xtpage_t **p)
+{
+	int rc;
+
+	BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
+
+	if (!rc) {
+		if ((le16_to_cpu((*p)->header.nextindex) < XTENTRYSTART) ||
+			(le16_to_cpu((*p)->header.nextindex) >
+				le16_to_cpu((*p)->header.maxentry)) ||
+			(le16_to_cpu((*p)->header.maxentry) >
+				((bn == 0) ? XTROOTMAXSLOT : PSIZE >> L2XTSLOTSIZE))) {
+			jfs_error(ip->i_sb, "xt_getpage: xtree page corrupt\n");
+			BT_PUTPAGE(*mp);
+			*mp = NULL;
+			rc = -EIO;
+		}
+	}
+	return rc;
+}
+
 /*
  *	xtLookup()
  *
@@ -252,7 +270,7 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
 	 */
 	for (bn = 0;;) {
 		/* get/pin the page to search */
-		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -807,7 +825,7 @@ xtSplitUp(tid_t tid,
 		 * insert router entry in parent for new right child page <rp>
 		 */
 		/* get/pin the parent page <sp> */
-		XT_GETPAGE(ip, parent->bn, smp, PSIZE, sp, rc);
+		rc = xt_getpage(ip, parent->bn, &smp, PSIZE, &sp);
 		if (rc) {
 			XT_PUTPAGE(rcmp);
 			return rc;
@@ -1062,7 +1080,7 @@ xtSplitPage(tid_t tid, struct inode *ip,
 	 * update previous pointer of old next/right page of <sp>
 	 */
 	if (nextbn != 0) {
-		XT_GETPAGE(ip, nextbn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, nextbn, &mp, PSIZE, &p);
 		if (rc) {
 			XT_PUTPAGE(rmp);
 			goto clean_up;
@@ -1417,7 +1435,7 @@ int xtExtend(tid_t tid,		/* transaction id */
 			return rc;
 
 		/* get back old page */
-		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 		/*
@@ -1433,7 +1451,7 @@ int xtExtend(tid_t tid,		/* transaction id */
 			XT_PUTPAGE(mp);
 
 			/* get new child page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 			if (rc)
 				return rc;
 
@@ -1711,7 +1729,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 			return rc;
 
 		/* get back old page */
-		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 		/*
@@ -1727,7 +1745,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 			XT_PUTPAGE(mp);
 
 			/* get new child page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 			if (rc)
 				return rc;
 
@@ -1788,7 +1806,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 		XT_PUTPAGE(mp);
 
 		/* get new right page */
-		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -1864,7 +1882,7 @@ printf("xtUpdate.updateLeft.split p:0x%p\n", p);
 			return rc;
 
 		/* get back old page */
-		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -1881,7 +1899,7 @@ printf("xtUpdate.updateLeft.split p:0x%p\n", p);
 			XT_PUTPAGE(mp);
 
 			/* get new child page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 			if (rc)
 				return rc;
 
@@ -2268,7 +2286,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
 	 * first access of each page:
 	 */
       getPage:
-	XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+	rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 	if (rc)
 		return rc;
 
@@ -2506,7 +2524,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
 
 	/* get back the parent page */
 	bn = parent->bn;
-	XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+	rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 	if (rc)
 		return rc;
 
@@ -2791,7 +2809,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 		 * first access of each page:
 		 */
       getPage:
-		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 		if (rc)
 			return rc;
 
@@ -2836,7 +2854,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 
 	/* get back the parent page */
 	bn = parent->bn;
-	XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+	rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
 	if (rc)
 		return rc;
 
-- 
2.48.1


