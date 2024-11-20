Return-Path: <linux-kernel+bounces-416142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8065E9D40CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AEB1F24E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1BB155726;
	Wed, 20 Nov 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU+Lwbx+"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADA1411EB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122474; cv=none; b=WSmV83iGrAj+I0bL6CwxYtYL9JDpTbFpvZmJNlUjmhyoiopJFPznkUP75Q9rYnurJHJf9Gb4FCuX/kOBeTVBA8RQ8s/6TA5gQSeDIrbZ5e7pTK7sp/aOGdXzL6yXcLlrIAAnDiit3TZgw5SANnv61CR/Tw7zn0Nb/GeTMQGoZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122474; c=relaxed/simple;
	bh=venJ7JUUxCPTPJhucnvj5pSjTR1KWKGddLBAVEkZ41A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cmi6LdsVjv9JmukwrIgScWmm1z3CyYqhYB7ag11CQzgcBaOvacR4+AqPoYRg80/MxYZUxN3grFDyIPW/20ROoWc+qBB1ZvrHgN4H1QoXXN66rpDP/d1g2rz+XZRupQBnm4eG0jA6CEhjqCRfXQpz5NRGgcM+QYM3Rqk3bjvox6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU+Lwbx+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21262a191a5so17715995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732122472; x=1732727272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaJ3wJ0f6FvG8wNvg98mzCvP20AnIu3gstvC0H5CZIM=;
        b=KU+Lwbx+9QblcpjwpPQeW8DW8hG0WV7rWzPCjxq4i+mWHKvZL+MfygWaSKXohy/AyB
         EWQEu7bQ6rRlkf3Dpe0VmQnc6KJf9GS3kaNo2HDSTKMHz4qnkwr+AI2QME+mwgRyct2I
         2mqQ94toNJu0WGIlEiF/cq2WaqhGmddY8gdkR9bBnHvuntkMGgzHll2pumc2I0qTnisv
         hV1znZQSQWitRD0uGQofP676sIOv0euc8hs2BwkAVJG0AcSYMgLzznzPpK6QJw3F6yEi
         mzk1HrBOaEmn9oG0h/RrJHLlzc4MOn1uv+6n2cP6AvWuLUuap7FLEl5Ixcry7FdCdD61
         nR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122472; x=1732727272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaJ3wJ0f6FvG8wNvg98mzCvP20AnIu3gstvC0H5CZIM=;
        b=Vn7sPxG6PewX4QMMxIfTd4iii0tseB61yHjMDyi6CYRLdB5Br6NXNpRTSqNMmZgdf6
         mat5TbR+YYkHTwc5VrTTJCJJrfYMDRT30539f0kYTBnN0qgt2lCJxX+rXCzCCIPOyNNN
         +9qhslR2s+YOHdKEtY6kdqxA0apknEPxRl2dMCo8xfipC5uJ+avImILDUjxtTKdJUwiQ
         6ipslUfwAeOnNqgSsp7gFQPB9qe8JN8tURqsvrE+1fXNCgiMIXBFMas1Fugkkh94xRSi
         pR0ufyeu2ft6CsoRHWaK6HHMuny+ymnU8Oiu5PwGtWnMFcWK9YmTkBZF2zDs8djViqx9
         oI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtdWE1hsppaHKevOYl2nuhJLv3GHltG0TvwxniWmvQ/pZRnLA/mfKgelhpTXnnVrxSyfU1cQcjpEg2e4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoymayK9d3VkKOjQ8gSUoiI/x+UVBeL1y3gj04Xgg/uW8uUGJ6
	jmRNpZJ9GyvKWrUTm0S1FV4hq9YTrYxC+aRx6o8YFGUaFT4phMzH
X-Google-Smtp-Source: AGHT+IEgQ91PedoZTvG/gU2rVUtRolwqHDZ3fR+DqFPXpKnBV7fzTziCpx0rL7u4igycMb3YHPc5og==
X-Received: by 2002:a17:902:c94c:b0:211:6b21:77c0 with SMTP id d9443c01a7336-2126c12c293mr34103185ad.18.1732122472243;
        Wed, 20 Nov 2024 09:07:52 -0800 (PST)
Received: from localhost.localdomain (123-193-217-197.dynamic.kbronet.com.tw. [123.193.217.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54456sm94047865ad.245.2024.11.20.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:07:51 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com
Cc: Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v3] sched/uapi: Reflect the use of sched_runtime in fair scheduler
Date: Thu, 21 Nov 2024 01:07:49 +0800
Message-Id: <20241120170749.23346-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 857b158d, sched_attr::sched_runtime is used
to directly set a suggested request/slice length. Update the
comment and descriptions in sched/uapi to synchronize with this
change.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
Change-Logs in V3:

Minimalize the change by fixing the comment only. The fix is not applied
correctly in V2.

 include/uapi/linux/sched/types.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index bf6e9ae03..3586d5ce7 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -66,9 +66,15 @@
  * and policies, that can be used to ensure all the tasks will make their
  * timing constraints.
  *
- * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
- * only user of this new interface. More information about the algorithm
- * available in the scheduling class file or in Documentation/.
+ * The SCHED_DEADLINE policy (sched_dl scheduling class) is the main
+ * user of this new interface. For SCHED_NORMAL and SCHED_BATCH tasks
+ * scheduled by the fair(EEVDF) scheduler, although not exactly the same
+ * as the sporadic time-constrained task we mentioned, some concepts are
+ * similar to the model. The period and deadline for SCHED_NORMAL/SCHED_BATCH
+ * task are decided by the scheduler algorithm. However, the user can still
+ * suggest the request/slice length using sched_runtime in this policy. More
+ * information about these algorithms is available in the scheduling class
+ * file or Documentation/.
  *
  * Task Utilization Attributes
  * ===========================
@@ -107,8 +113,9 @@ struct sched_attr {
 	/* SCHED_FIFO, SCHED_RR */
 	__u32 sched_priority;
 
-	/* SCHED_DEADLINE */
+	/* SCHED_NORMAL, SCHED_BATCH, SCHED_DEADLINE */
 	__u64 sched_runtime;
+	/* SCHED_DEADLINE */
 	__u64 sched_deadline;
 	__u64 sched_period;
 
-- 
2.34.1


