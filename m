Return-Path: <linux-kernel+bounces-416138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8239D40FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7460B367CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C115666B;
	Wed, 20 Nov 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO2uqjQK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFA13AD20
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122159; cv=none; b=r6Xd2R/mPCxqUPkPzakCx7lAO7m7Zj2xTbBNiiADGtnovgYq+klsOdNkcPVhL2RKSxykx0svzuhEcDDhvSNv+cdm8zW1YiSU+QyCzLrJ7cT0MrEHeVB84iOkdryhAb0qhPFEMEQfV2D5u26HFxrPpQfgwgPIhZuZUXl+rj+EcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122159; c=relaxed/simple;
	bh=gMN2OcYg5A2F6BkhpGsyDqG6AS1QuO59SdTxWCLbHGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtfbNEULMlC2us+50aEti4K5QouQM2PCTBq3hEs9pIceHOZKm2o1+udGkU+6V7/ZAz4+BmMJJSAzUr8jDhSnjTln8UU8IabEuLKmPOOXqBdVPoKxdQYeDhxrZgx94QCVQ8wkWlVjktPGWc4fHMyB2ie7g+6aADco/2t7NgB+52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO2uqjQK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso3932a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732122156; x=1732726956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TDJn8odgkDPpYgPYRRndwZ+2afB300hqyzxkJVtamI=;
        b=gO2uqjQK0IEm/T3esyY9xVOtQxIbEjDhFKTSByGU4njgXQPGLd17zm8+G48m1FJfNB
         7QlkwPWTG8JhBJ85lOCBVTVS4RuP1ln2hB7do8D8qYZ1zO6gQIpQGme9K2eh/ZCG0gOf
         wt5V+mpmaAGxesSpy8qi3w/9gPssCS1WoZ+5KykI+kCZIC8z9+Mm3qFNhjsrrViFDW+A
         3379hMc6BtkbdZG5kvkgt/8SvueG5xf9JF3m1s1M2pmkq09vSUgQ8oIeGchdns1smRLb
         bHWPCLW8RtlRH57XHc/jvNnza7BJgKsEMDGnfC+D6/eE8GUD4VXA1l/WsMTNaHDUzYj6
         yuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122156; x=1732726956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TDJn8odgkDPpYgPYRRndwZ+2afB300hqyzxkJVtamI=;
        b=Q8OxBEnDo1iVGqoXWt1ZU5YuSuqYTRVd/eFyCmP+5nSYGS5UrG8HvldmxKMjyBgQBM
         yhx5GdURZFqYbA6eE11Y37S5K4pLIqwzzW5+QmwWEOyc6PfdRW/TzfxiKvtrGG8RidWE
         X4t++PBrhZvODMlDTnkgDXdMX0EisaA76PhpltglMeiQLhmPLkSW1MD53x3ILqIy72xw
         DHzshq+GWKUn6HcShimXqpqR3PsPuV6dytK0+FQh31vgO5Mx7EVL7E4RtPuLYe6O2S1n
         vhfIG/y5Ac0wUJmOlrxAptoqPlPYKDbuF2aw/VQJqKsxvQhmBS4dfu1PLQps5CJhILtI
         kziQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLQx6xLzzrHxdvfeM6eF5Yua7TEQ+nN39p0sv+s/zMF5wVTx2iapT8ONgbpbNcMSA62QCd+ow/kt5dN5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5OQOz9nnMHS9lTV0NGY4pWC5wrM1u+MZBIBoC1aBcVZkJmfQ
	JRc2aB8jiZpdtiWSQylRATBki9EstIBdLCwYM2tLaCLaNOhibflZ
X-Google-Smtp-Source: AGHT+IGDOviFLPHGmgW8MxRzPWutHYGv/n2P85FClo11uUk0UkI1BoWKLX+TGYwwK+iryTjZLjstsA==
X-Received: by 2002:a05:6a20:918c:b0:1db:e884:6370 with SMTP id adf61e73a8af0-1ddae004030mr5183402637.7.1732122152650;
        Wed, 20 Nov 2024 09:02:32 -0800 (PST)
Received: from localhost.localdomain (123-193-217-197.dynamic.kbronet.com.tw. [123.193.217.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dc03fbsm9743150a12.70.2024.11.20.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:02:32 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com
Cc: Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v2] sched/uapi: Reflect the use of sched_runtime in fair scheduler
Date: Thu, 21 Nov 2024 01:02:29 +0800
Message-Id: <20241120170229.21563-1-s921975628@gmail.com>
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

Change-Logs in V2:

Minimalize the change by fixing the comment only

 include/uapi/linux/sched/types.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index bf6e9ae03..b52850b24 100644
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
@@ -108,10 +114,12 @@ struct sched_attr {
 	__u32 sched_priority;
 
 	/* SCHED_DEADLINE */
-	__u64 sched_runtime;
 	__u64 sched_deadline;
 	__u64 sched_period;
 
+	/* SCHED_NORMAL, SCHED_BATCH, SCHED_DEADLINE */
+	__u64 sched_runtime;
+
 	/* Utilization hints */
 	__u32 sched_util_min;
 	__u32 sched_util_max;
-- 
2.34.1


