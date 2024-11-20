Return-Path: <linux-kernel+bounces-416089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67929D4017
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E771F23942
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B514C5B3;
	Wed, 20 Nov 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4L+hwgq"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250F142E77
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120295; cv=none; b=NNZRXWhEEUWi8SXGVMtjaxsplLwtE+DSRtqwsEMguZvAIf0e2fN04SxvCTuls7DTYRmHlXQoQqk8YJ6rj1fP/oyoUlccV1Ttj52KGQHfGVwD59pwKQ3CLTTF0m23zhduYxnGcwDVPn5QiBZa2szOV57pliB4XMXRvCnMKu0/SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120295; c=relaxed/simple;
	bh=Q+l6Cv7jwTPILSch36jOEoXOnjXz8m2RT4lRwXML0VU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6oRN0Y6r/y/hjVLqMHPhxcloz4Gfkai20hHQf9oRilrgwqECfzHCwFakySZXxRVxH7Kn/Kotyc8q2UAvGA/U9QFNblp0MhGvqk3lr+sxek7V+3044Pxt4wi5k9lYAQ2rgaSW6VbzpjbynHeuS5jphIDKVhjKS1XBfMndnP1U+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4L+hwgq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdda5cfb6so52752125ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732120294; x=1732725094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo3cYItHRsu8SdofGbFrSUdngYAz2EuSxidQOSiNuyA=;
        b=d4L+hwgqUuKQwCVDRmAmt9iXR7pGfJFCy3XbiSIPYdB8pvIqZtcQITfVZa4/4O1ONB
         oEKhfijTExX0c7PYnSlS2/P1/NBahrSZj5sogvLjH4uJ4j4tSuj9SQl9JKkHWIjgtRsW
         ezm8gUa/pgW0jHhmgP22hkBoXH4Y51KNzYBN66Of0PM/6NEZL/NooAS2qwoUzGlamR4H
         V/rII0KeqVmKImpQr2lAHoip5it+/6T8jbsfaCJ/G0f5y1vaCkFhwkdcNstTN1DewxKq
         QkPh385tB55I4H0LzZwpBNJ8wUEgpaPaJdQD6jHdQHEEJuGmRxpG0Xvc54y1DH38s+2k
         l7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120294; x=1732725094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jo3cYItHRsu8SdofGbFrSUdngYAz2EuSxidQOSiNuyA=;
        b=vrVkZ1LjZbs9HuvVNk+Jipm3+mpKWpZxVTam6jqW7eG2BhXfrNEimtF5vEbLfHVdRR
         pNT7LtfkwkPHfxHbI5dqwK33kJd0HllY8D4hrsdgVwaeJ37Pir9gDZ2paM+aqCHzmTWr
         fTKXASGdO/zkbnkjw74SJCbhnEx3sXAV89VFjXlTTgA1RjbX6SrKgZbhLHj9liniSU1M
         jcSyan3Ri5qcV/9fP0ocd910IaiR2VGOfHkaXC0E2x66Kre8BxJgZzqaXLeIf1E3ZXwM
         RbWyiZRHUxsmM6nQCDa+/lr/cgzTEPHu86fgWqS9ghcrKm9BcdIS7bDpYVmfS101Xccz
         f9gw==
X-Forwarded-Encrypted: i=1; AJvYcCV83cWtKzkKgdAZ5ZG0TXNdBQfQivbsp/Zfnri5V0iiPkpkUKbL6QzOwyhBplXYmbkQ8qtURGfvK1QpZig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XC6EtyGlnKUFvsfcQdtNRbNlzJdXwo0nmQanOncrFWrW6E4S
	7dYdfElTs9StbTqwUWzFn+WOg0Ff4vtzvPwgbghwUfsrkyMKwOOS
X-Google-Smtp-Source: AGHT+IHoaH1jZOYbVRBJ8Bp/rydZCssTUtdZRnzH956JRbFONzHlsvJLGEPfKfhJxV1jLgk+qIseKg==
X-Received: by 2002:a17:902:e542:b0:212:10de:4aba with SMTP id d9443c01a7336-2126aea8a38mr33178005ad.28.1732120293452;
        Wed, 20 Nov 2024 08:31:33 -0800 (PST)
Received: from localhost.localdomain (123-193-217-197.dynamic.kbronet.com.tw. [123.193.217.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8da43sm1820403b3a.97.2024.11.20.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:31:33 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com
Cc: Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH] sched/uapi: Reflect the use of sched_runtime in fair scheduler
Date: Thu, 21 Nov 2024 00:31:29 +0800
Message-Id: <20241120163129.13577-1-s921975628@gmail.com>
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


