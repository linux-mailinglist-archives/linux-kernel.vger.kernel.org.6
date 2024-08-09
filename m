Return-Path: <linux-kernel+bounces-281417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4C94D6C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B0F1F2235F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AA14D29B;
	Fri,  9 Aug 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ0yY33R"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BC33CD1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230190; cv=none; b=CkTER6IZFfjWrtOaOi/35gHw+T6CzbaZsfCUZHnG3O9Dojds3f5k4bK05Zbpu130C6qLaPx6X/A1nmDRDqhRVptzGbgqnKQMMtOdvJHIWnVmuiQdGvJK3IFsH5BDilPoMgplNXCmPgtJWxYEFSz72Uix7P2xXo/QDnluVkvDOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230190; c=relaxed/simple;
	bh=thw4Am/PR1g2R+DuDWBc1N0Oh0RjkayNhytTMRsJf0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUmD9ASeq9ZDPsal3bO2sgyOcfZubPpczR8NkOtgMRVWmq0RTiawHsyT8wizN1V4XrBSkOGEkQ8Tn2FZC9nTtU9j0R4uTvJfhkbIuHKNDUUuCTOmrAL7Gz8fheR4IanMBxI3664v6S06yIWiVqGu+3VH9ikeqAavb1ASy5gdeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ0yY33R; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428163f7635so17740535e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723230187; x=1723834987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paBUc2iwfJd8fdxpcSoCfr5A+mknn/ALUrhTNjNcrWw=;
        b=ZJ0yY33ROx+mLlcgxnilmtpPu2c8cToaFf4wBPVDnNUItNKMxx9OOvlnQQAZQVcsKt
         tCa7XGBVFQHfs84/j9FkBs5IHdokmYk4U7sFcUbguA0mpO7KCzUYNUfvMz/AvTEpDGta
         HPdFB164YBaa+wGYHRTkckwWQb/o9FqgMrFQXXKlF4CRWY014EizHayHfn6YIcohWS1Y
         juQ5bn94yQBv9nIIUuvQFhsGozGq3CdlqiAo+rC5+MujXI1epIsv5gEVl/xEpcByx8zk
         npJF15tCvbCfXn1EJr4phY8AUiBUMvfDgEfIcmHd6AfhkbJwRESmyglJBqjk/TPyxPet
         kbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230187; x=1723834987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paBUc2iwfJd8fdxpcSoCfr5A+mknn/ALUrhTNjNcrWw=;
        b=k6GlkWiM+NZvQMp35XXzQEwoAE+lv5dcMd6F0ScWbXCI/kxzVy4pH+Dt5LVpLzLt99
         z0jmjurW/Q5f8lXpRcyix43xFrvcYM0MLp0JyZLzi+odfwDTA5BBqPJt4OafDTv9twh3
         PvmxHyuomTJdkNa072MtFLWDKyNX1/lsXUeBvbf+epjNunYZdA6O34FXZbRLT1LHkezy
         wbaAaezNrUXdTxCTMq1FbUPW2w/0avZ4P1sXo5A0YAwvV9fU4J39coO7TKPMnJNs2t50
         1JUvp7Ud83w7I9LGtfV6CEM3N8FbqsZz2gliuIkqoWYWl07PomLmIfvX/L4okWeMK8s/
         8u/w==
X-Gm-Message-State: AOJu0YwoYbLCvup9gCWFYcc9ZnWTMmSTnA8eGIZtFtU1D0Rm0zW49n9c
	lLykJY1ZFBvtB/iyIOX0vF8/ilky9kEPaPNP39+crL2R1KE9F2pLRYpjZdW/KiI=
X-Google-Smtp-Source: AGHT+IH2ATQCq6rSOsiOGymfBlxZOkyF7WDLLYBEvgR6GwhIpQWL1i1g0MlRNClUDj5iSeE4qYuO+Q==
X-Received: by 2002:a05:600c:4509:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-429c39c67f1mr19092075e9.0.1723230186306;
        Fri, 09 Aug 2024 12:03:06 -0700 (PDT)
Received: from localhost.localdomain ([156.197.9.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4293e41496dsm65442665e9.23.2024.08.09.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:03:05 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 2/2] locking/lockdep: Testing lock class and subclass got the same name pointer
Date: Sat, 10 Aug 2024 01:01:41 +0300
Message-ID: <20240809220141.341047-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZrLaKCEJc8FqI38I@tardis>
References: <ZrLaKCEJc8FqI38I@tardis>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking if the lockdep_map.name will change when setting the subclass.
It shouldn't change so that the lock class and subclass will have the same
name

Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
 lib/locking-selftest.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..2b4650bdf833 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2710,6 +2710,32 @@ static void local_lock_3B(void)
 
 }
 
+static void lock_class_subclass_X1(void)
+{
+	const char *name_before_setting_subclass = rwsem_X1.dep_map.name;
+	const char *name_after_setting_subclass;
+
+	lockdep_set_subclass(&rwsem_X1, 1);
+	name_after_setting_subclass = rwsem_X1.dep_map.name;
+	DEBUG_LOCKS_WARN_ON(name_before_setting_subclass != name_after_setting_subclass);
+}
+
+/*
+ * after setting the subclass the lockdep_map.name changes
+ * if we initialize a new string literal for the subclass
+ * we will have a new name pointer
+ */
+static void class_subclass_X1_name_test(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | class and subclass name test|\n");
+	printk("  ---------------------\n");
+
+	print_testname("lock class and subclass same name");
+	dotest(lock_class_subclass_X1, SUCCESS, LOCKTYPE_RWSEM);
+	pr_cont("\n");
+}
+
 static void local_lock_tests(void)
 {
 	printk("  --------------------------------------------------------------------------\n");
@@ -2920,6 +2946,8 @@ void locking_selftest(void)
 	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
 	pr_cont("\n");
 
+	class_subclass_X1_name_test();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.45.2


