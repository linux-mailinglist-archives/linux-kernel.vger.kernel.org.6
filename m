Return-Path: <linux-kernel+bounces-335203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710697E286
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301AC1C20DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BC29CFE;
	Sun, 22 Sep 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHuopOJM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F8E56E
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023631; cv=none; b=peDmnqAoL2GuMq5vnM3Tbw/2bp0gc4ROrIy/z55LOmjXZB8VVnKLzTvZV7SXgBN1u/aVqs8rGfZaOoYqTlv4kxhfcLgLkjgzJAVMlxdOwKJFpxWDwBdk0qwhsqP576/9FxILBi63xGUgWFHMRPdpPRerlQ4k6veovT/UBJTE3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023631; c=relaxed/simple;
	bh=dkNJ6/prmp2vy+3tS7W6THOe+jSCd89VFA9zzONhQbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Enq1OIWDY+gBE0HuOOLaSeqfF/Ei4Bdz6lYOZUe04AEkDgWMyIFxHacb6J4Ecu0VCqwbrLzneU8T5uo26Txf9uQKXL+o6nBhkWcnRwiVDtu6UJG3ZzpFrbh++V3BYgf//irTL0f1S+XkWgiFafAXNXdpA3zRlEgtMp6a6w9KanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHuopOJM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-205722ba00cso28998235ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727023628; x=1727628428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVq0KkFUULdiukIr/KzH52cv4+OSTUO7xPO7UKIE7DY=;
        b=HHuopOJMmxi+Ksww/qofr96E8+LHOQNe+vMRL8kOtMGxkvzLCDg3NoZiFToNET0r+t
         N1zmMoNRj47GIKXWlxYkNoClp+uhWcgnddU9xi2kr1F3mzn+Zvqpd2GCWhSLVN6ccwb/
         U79pjQOBLLm2n8lEIthatjgSPI0KSvm6D1XlvcfLh189DtapMHFWEkhkqOAHSBXx1n+c
         I+z9+8qdvRwyr+srdT4sxjWeKA2WkToU5PQNeJs44h8I4F9iYwL4Ht25eGmakYKpXeX8
         1hhUq2TyXZJ7aJDFomgVWtvwpf/17WSx+IX/oE2OADSK9pbcjoqV0ZdWbXRaXfsX8AW1
         K35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727023628; x=1727628428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVq0KkFUULdiukIr/KzH52cv4+OSTUO7xPO7UKIE7DY=;
        b=oUJtm1atzpRPOfi5/v6BhkifiZisXcmkGVj/Z96PM+CcP6wE3xfj4QVFZqCxGetXoW
         B18ADSa9VMLTtJszFH6nFYcMMIdK/0+3/wjSVIdc5LihjBRpoknXkYkxclRsGO6awmcy
         CzV8DgA0+t93lk9Cl63wOLEhdsBrj5OyduVnrPgu8l90guQ6IM+dnWCQCxhvx9S3a6dP
         2RTMp90qqLlyNKgRJlKzuJDwId2En4Z9w6LU+MEIv+d8VJ/s3Vvg3ihQzDqb8KWVCujM
         A6DsOfpgLJZLijUyxO/svFfDpJxq2aIr1/xZ8DkNQgAeMozl78iuTDzKb/m5Jazpxnfo
         YF8w==
X-Forwarded-Encrypted: i=1; AJvYcCVggKYWpMhP1xPYPWKPCZiLtOAupfRWtsyjw48wXALm+s6a1RTt9wvYvREiK4ggeHjb09gWjWtXj1nWJNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpAIQCzfoPz+0kfjs+IHd+M/ZJ1o/zkqZSwKlW8Wu5ZZQ3iH9
	eXx2lnkylCKXB4ienTxe2eGKFil9pLK9kyHLaH6fO5T26DIOKKeC
X-Google-Smtp-Source: AGHT+IGvAUWEgL+fGNlGelLLJ2knKac5i+E1zkKjfdK8TeOCO7+h12L2GXlVZYW+3If9tWhfc8+yKw==
X-Received: by 2002:a17:903:41c4:b0:207:816:6b7c with SMTP id d9443c01a7336-208d98078fdmr99566335ad.13.1727023628224;
        Sun, 22 Sep 2024 09:47:08 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da9absm121079855ad.51.2024.09.22.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:47:07 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Return error code for failure input for sscanf in parse_cblock_range()
Date: Sun, 22 Sep 2024 16:47:01 +0000
Message-ID: <20240922164702.49615-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported following:
'''
drivers/md/dm-cache-target.c:3204 parse_cblock_range() warn: sscanf doesn't return error codes
drivers/md/dm-cache-target.c:3217 parse_cblock_range() warn: sscanf doesn't return error codes
'''

Since, the only negative value that is returned by sscanf is -1.
Returning -ENVAL when sscanf returns -1.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/md/dm-cache-target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 17f0fab1e254..c35d65e310d6 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3200,8 +3200,8 @@ static int parse_cblock_range(struct cache *cache, const char *str,
 	 * Try and parse form (ii) first.
 	 */
 	r = sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
-	if (r < 0)
-		return r;
+	if (r == -1)
+		return -EINVAL;
 
 	if (r == 2) {
 		result->begin = to_cblock(b);
@@ -3213,8 +3213,8 @@ static int parse_cblock_range(struct cache *cache, const char *str,
 	 * That didn't work, try form (i).
 	 */
 	r = sscanf(str, "%llu%c", &b, &dummy);
-	if (r < 0)
-		return r;
+	if (r == -1)
+		return -EINVAL;
 
 	if (r == 1) {
 		result->begin = to_cblock(b);
-- 
2.43.0


