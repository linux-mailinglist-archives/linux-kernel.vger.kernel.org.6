Return-Path: <linux-kernel+bounces-540730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9789A4B453
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D91518910D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05E1D5CC2;
	Sun,  2 Mar 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWRcKIM7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED8B673
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740942973; cv=none; b=GsS4YWp96uqAo4lpJZpdyGOPOmyxbmTonr+Yld8+gE406PFIeHlGD7nhQGFRsKA1WHMrFKkt1vmdTnvWJ70h35do4lj8xLUkFLqVQ7/32FatEnRt9jNmZvOLNNs0JDvVPr3SsiXcukfS2BuDg7bDWBaHH+p7bxm1yRNu4w3609Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740942973; c=relaxed/simple;
	bh=3cfHe78QP3y9peRNYkTXVyiARBeyWKEWuzpQ9JpA2nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVRZa41oCzWWH8aMW7YdFQvAj/lafoHESIWG3pK9H0F0xkBm+xjaHF/ebdl1DLYnO7IqfWi6ZuYW1pmvcj7DyXY2QWN+fNLu4x0SDeOLttxGIMtEEytoBTGB1Aog2JFB9ViA/3mwsQMsv1seTqJ5xqWd9soDM8s3MZF7bcBp4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWRcKIM7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223785beedfso33575955ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740942971; x=1741547771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlA0SU/ZCYX8gJRmy6w4sqXzVHg1EdDuRlFFqXo2oIE=;
        b=SWRcKIM7iG+wn8noZMjkKXn/cNHvi21EhMwlmJOBpCzIY9n4G422/xcjwxNhvP4U5o
         2cxBYR3lQqv8cvCJxb2VIbJYue2soWgwtw0ezttVne90Ww6TWfaScE5Ns4XjHeZ2tVW8
         svc84iHe2eRLYMoMhcTvcScvjM/NBmk1sopWc2BNLmfF+9ZbU/Pe9j1E225wJI9NpVYh
         29vRvhf0aixe+IKpNV+h2eUIRMwfKPJ2VW6YRzQc0TLyjhv0gXEAD8jiETmT3gvaZujT
         njrTlAWzddu4amWKjmQFD/gDl4rZtX5QsmYZiHtyVKmYEymdL4OI8JXNUQ2KJ3kVG85C
         X3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740942971; x=1741547771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlA0SU/ZCYX8gJRmy6w4sqXzVHg1EdDuRlFFqXo2oIE=;
        b=HmjcnX111fHw0Dt/7A1ovAXaYwd5ASxpNgLycjg0Gv6vnQG40CljsRhDE4SmrBedju
         NTbKsaYUTWNvZbx/nUnErSQ1CuzSiTHgyCINdK29kV0vnG9HAxvBhe7JSeqapm0IjpEx
         0DpGZe3fCN9dOmmLR1NHyEwQeY+6o1dz0QUEMa+WMUw6zpYstxvNcDUYvYC7GvaarCVf
         RB8o/qc8snQD7IcmJqJl1+xPTse/05Saz7xIPguc3awZYNsusbsO6F0roTjewgTCB0uO
         qKRIHD+hDxAuE1YPqqGuzre6vCudYBSzdQguc4mtzHEAgVsl/siL87XJqSkJ8MicIIyf
         TgIA==
X-Gm-Message-State: AOJu0YyVHslx+a+WSmx1QUC2DXZtKornzvYMsHLMSPf2ynvqQPhl/9K2
	0RtlGDEacTAeQWXadRptQr0IJFIBFikDOzNZ8StUUDRoQoN4gzQa
X-Gm-Gg: ASbGncvrW68Q+uewZVxHCoihnqacsTpm8IFUkR2xkn+03AorNrgBDq75chXHx0SNhLz
	5CvyYFVfiAt3vvQU6dNhgwGBaQdvmr89qQRBu+fmTlJy4VqglfXHnOfK+KJvo1tunZTuZx2Sc3o
	1nbGYQWFElbpAMjdkIp6JmzwfvDGW3D+XQfjQx9VMY8iFEJh6cDJ/uomy+cJyEM/yhb4Mw0EaKw
	ci60QfBt4PNQdyYvUjuruA8DDnOIUrzsJJk3mYiBjD78EBgbEkxqRNFpI7E/7mMUFn2O35Z7O5q
	HIcs7rNmSVcoXE2GiWxl/ujIaLMa1XQ6/tmTdzOs7n0fA4q38t5Xkp12wj/SBntzULzU8jMe
X-Google-Smtp-Source: AGHT+IEUIR3w9wMZn8Db6v2BPHzh68hOPUs53803xNBe5fHHG76OjaCGUoV53tdN08AN3St6ZgxuXA==
X-Received: by 2002:a05:6a20:729c:b0:1ee:833a:3990 with SMTP id adf61e73a8af0-1f2f4c95d0fmr19015154637.7.1740942970568;
        Sun, 02 Mar 2025 11:16:10 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:6284:cc95:ed3b:6b9c:32c0:58a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73630a224b3sm3655036b3a.164.2025.03.02.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 11:16:10 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: shaggy@kernel.org,
	jfs-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] jfs: jfs_xtree: replace XT_GETPAGE macro with xt_getpage() function
Date: Mon,  3 Mar 2025 00:45:58 +0530
Message-ID: <20250302191558.47180-1-suchitkarunakaran@gmail.com>
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
index 5ee618d17e77..fb736a06ea58 100644
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
+static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
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


