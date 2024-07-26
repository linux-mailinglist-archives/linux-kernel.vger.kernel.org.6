Return-Path: <linux-kernel+bounces-262996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9393CFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143F4281AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22C176FAB;
	Fri, 26 Jul 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyRFG/kA"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B07176ACF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982519; cv=none; b=LQxkyKp7qbcQ/dyrKLEj7URXsG30DJBUob8YcPMDQWB9B1OPlG4lRzgRGiaL138//wJ7RqBLuBr5/SUPMIa1vX/QQxdJNdkRcBDvJBtD5WcJLjVis0wxr02mbvFMLpN4pidchvGsa5XoXmSnJBQ0iBht8pmXWFtKSdcYfsLA2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982519; c=relaxed/simple;
	bh=Yu+iyUl5eY+Tf6GcgLjn5rx4IQqv7p+bCxmeLnHmgd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHcHZeqsXTC3XaNebyDr2XSoYf626Epel1wEVF0QmMd6/C0FDZ2tYZ7y/LKNoLmVMFN7OzwcWmmxPKUZMFBTRFMoSohdXgbqANkiTpafLVGPSKkUHW85ZGoGglkfLdlV2J3+RdZqCeJ7UcdX1laBvXw9Q9TSkw3F/mRCNrnM5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyRFG/kA; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db16a98d16so485868b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721982516; x=1722587316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abtGZkU53IEdf9pF5Mn1gYdLv8LhNeitOgKX0L25K3M=;
        b=eyRFG/kAIZW3gCCLx93ImFnzB0pyiFW+LKPSTkJBSl/ICg+akqM7Ak8kCo8Ci8BI9f
         p3U9AMHuWu7vwTpNE+966IYsrT9wARxXg0PJY0JowdyEY0ByqM3lbIWnJoyt9SyC6WDS
         6xb+jYiiphiOODEPje8QZBcrm9PrlFGU2n69yzhFjaQb+76T5ZCKQX5+lgyXpLxmwa3N
         lpLGcH1yOAfJPYCsmmitl9Ssu+WD8UqFqKnQ1661++UBg02Rq9+zmMvYtPB6WhNI32ct
         G8e+942q1vDgv3DSpOF3rvJ5qC0DuJ/3G8ZmTVEPRUB/yQrAvgvaOQA7ng4R5dtysjQX
         znXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721982516; x=1722587316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abtGZkU53IEdf9pF5Mn1gYdLv8LhNeitOgKX0L25K3M=;
        b=QQNjSV/nG5+9+QOovmEzXrOy3/FZ6NsvSskAd9pj1NnSeZfbKnuiEboOgamBrO5Ev7
         y2XTOBwPiomDIoyBlcZLCokvIH4aMX6alUbWufM7TuYKCKN/JT3M8Ib6p16RV3KBJSy0
         A+vzM2pIwoFFRCTrwpTlOgBfo4CJbpbOGia9mEx05W5Pnh8KzyXI//n7UL6z9GPzOuYv
         FaLUOBpEgWrxSHb44gTIzafkgEaMcIZ1TrA/4pGYpmC2j4VxlHVWmwMpxm7FNUNeV3om
         besJjbx6nHmbu6zDGSwwalop+KrZ7csYn6/wuw9YH8BJCbc4iKTJO/01u2o7WbAe9lea
         Rsyw==
X-Gm-Message-State: AOJu0Yz+LYC26KUOTRAdkCB9bIeV4lGot1Zfz56MnHvXCexOxCvHf1F7
	dYO1o2OrbBMhhi0I3mW6iITPjdW4UShSSudclIT6ixkQtPzaq/Rn
X-Google-Smtp-Source: AGHT+IGHTxRzIHgio3LdytqhLaYwJofMHIuIKI4DkXJ6UrX1JJ/LJvzCqOQylMu0Zs/IRU1TNcjo1g==
X-Received: by 2002:aca:1111:0:b0:3da:a6ce:f017 with SMTP id 5614622812f47-3db1420843bmr4908125b6e.46.1721982516459;
        Fri, 26 Jul 2024 01:28:36 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c71b15sm1968238a12.18.2024.07.26.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:28:35 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: huge_memory: don't start_stop_khugepaged for non-PMD THP
Date: Fri, 26 Jul 2024 20:28:18 +1200
Message-Id: <20240726082818.260008-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

khugepaged will be automatically started when PMD-sized THP is enabled
(either of the per-size anon control or the top-level control are set
to "always" or "madvise"), and it'll be automatically shutdown when
PMD-sized THP is disabled (when both the per-size anon control and the
top-level control are "never").

It seems unnecessary to call start_stop_khugepaged() for non-PMD THP,
as it would only waste CPU time.

Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 41460847988c..bd365e35acf7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -514,7 +514,7 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
 	} else
 		ret = -EINVAL;
 
-	if (ret > 0) {
+	if (ret > 0 && order == HPAGE_PMD_ORDER) {
 		int err;
 
 		err = start_stop_khugepaged();
-- 
2.34.1


