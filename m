Return-Path: <linux-kernel+bounces-341078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542C987B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4802866D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620781A0BE5;
	Thu, 26 Sep 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="EDxt4jr0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327861A0BDC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390183; cv=none; b=CAkQCsQqlgCG2Ktw9D+jeIUju/2RBacFR5aggfIfylrtepPK4GodWy2fJcPen9qzM9BqTh8UaGGMBszdPC+rTDUCRxjxsB22IHnmrUECpyWCBGM1H/JaCxWioQ+avUM+5IPzXFha+7YOilgR3Or7Lh1kn15Ie738i7xrC/V7ywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390183; c=relaxed/simple;
	bh=FaU5RC+Sicxb3jzFNAuSvbNCDKWv7I9KrwOVtcmXLes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JeYpfaXm9puI3WaeOZAi5URK3tUiue48HU2FU5h4eGHD1ZrlEHGxUm4YV7DYh0Iu+Ct3fK6Tk+OR2c1AQ2vBqzqZwpdbrvneVtNIDgyAOcK/c2lZd1DhdR7AOkkD4ZL/hwtA8oc3nnOjON4ix/AMtWk3Z2kL6TIoIZbptv3ousQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=EDxt4jr0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2068a7c9286so15417815ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1727390181; x=1727994981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+sqj7dWG8SJEyXPhTIn2pZyQsxVPULAdCT19M7tZEg=;
        b=EDxt4jr007XQnSEA45j0xMS0MFJgDUMMkRmumCdG1x4Wmg+LLq5kzhryItc1N9/haT
         UByKYdDebmuwh4laQ1xXM3AiuxPnr9qEyTR8cI4Y+Y8UoAZyTW7JPnNA0W5Y3IvYAo7z
         oEskWxzOy5WbwlxT6RZFIfvte299/qp8PEG1n7ug4qzcq6QSzvGjKtPp87kgLBPqy68k
         IAUUC0QMll6Moo9aObTlMD0UQur6jKEYyHKCaaXawrKEBm9qNGGC1sZzWXl7NMaNa8uE
         Am0wzJZOUQrYRq4WusOY6o8ZRNw5fC0N7nx9mjFMmowHWIz4v19gG9J9t+0iThig2/3V
         XvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727390181; x=1727994981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+sqj7dWG8SJEyXPhTIn2pZyQsxVPULAdCT19M7tZEg=;
        b=QHCM973lTJEW1LgzK/0QfFy2vbHps43630gJV2Fe+flLMmVBVFXCjnovrhYykMMnt+
         BsKTD3hVzeCVwaytfAGIa3wfYwGacLBlFbIsTRqZb6Y2WhPBtWYBVLW7ulCNdaph0ki4
         CucyXOIUGy6yoF+5W7ohrEALFQTjBd8DiJJlLsLjM3H6CkxQIX6qj7lmz4VOSECNPZ+C
         o5ZFiNJyu86CFNxxavLwfGZEyb8JgfpR77dQTgJQs+4Siw1MX1pMpAQymPICvA3WR+8m
         PsvhOJ50sjhxh5QsQl2FMtLAyl9kXpK7i7D3yF5mGAAlXEmR5ONCswcOApOSd6Y29y/X
         WF8g==
X-Gm-Message-State: AOJu0YwJOLs/59lMP1y117XaCH8AIvd5PbAUd1r1VsCw1ZzJi6VNA/Co
	hwYZ/xF+xvfzKOou/GDD6rvFCtxx+zWEwM+Tmk6tEqHG8uzHd+acRLOtSRoIJzM=
X-Google-Smtp-Source: AGHT+IH82xcREV/x3IX6LnWOk/NukWjHQpX32yjNFt89AYb5km7Qq/VF9Ezag36aHJG6jTzH/Cm4/g==
X-Received: by 2002:a17:903:11c4:b0:202:13b0:f8d2 with SMTP id d9443c01a7336-20b37bc96b7mr17271865ad.46.1727390181400;
        Thu, 26 Sep 2024 15:36:21 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db1556sm3138165ad.118.2024.09.26.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 15:36:21 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Christian Heusel <christian@heusel.eu>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Ahmed S . Darwish" <darwi@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] kcpuid: Fix potential dereferencing of null pointers
Date: Thu, 26 Sep 2024 22:35:57 +0000
Message-Id: <20240926223557.2048-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang reported "clang-analyzer-core.NullDereference" on the `leaf` and `range`
variables in kcpuid.c, which makes sense if malloc/realloc fail.

These changes will ensure that the variables are not dereferenced while null.

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
 tools/arch/x86/kcpuid/kcpuid.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a95d3f..c05226d105b6 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -144,19 +144,29 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
-		if (!func->leafs)
+		if (!func->leafs) {
 			perror("malloc func leaf");
+			return false; // On malloc failure
+		}
 
 		func->nr = 1;
 	} else {
 		s = func->nr;
 		func->leafs = realloc(func->leafs, (s + 1) * sizeof(*leaf));
-		if (!func->leafs)
+		if (!func->leafs) {
 			perror("realloc f->leafs");
+			return false; // On realloc failure
+		}
 
 		func->nr++;
 	}
 
+	// Check for valid index
+	if (s >= func->nr) {
+		fprintf(stderr, "Error: Invalid index for leaf\n");
+		return false;
+	}
+
 	leaf = &func->leafs[s];
 
 	leaf->index = f;
@@ -210,8 +220,10 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	idx_func = (max_func & 0xffff) + 1;
 
 	range = malloc(sizeof(struct cpuid_range));
-	if (!range)
+	if (!range) {
 		perror("malloc range");
+		return NULL; // On malloc failure
+	}
 
 	if (input_eax & 0x80000000)
 		range->is_ext = true;
@@ -219,8 +231,11 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		range->is_ext = false;
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
-	if (!range->funcs)
+	if (!range->funcs) {
 		perror("malloc range->funcs");
+		free(range);
+		return NULL; // On malloc failure
+	}
 
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
-- 
2.34.1


