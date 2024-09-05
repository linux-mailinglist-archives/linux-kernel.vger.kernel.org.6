Return-Path: <linux-kernel+bounces-317011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14396D83F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A38B28BD71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2919D895;
	Thu,  5 Sep 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAMKpFsz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965619CCF4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538836; cv=none; b=QgJ9UwjqubMh6qNNFZqtrGoJDAXKYwuc9gxzYA8996/J8Yy935YXyAEofOWGdCOk5QOVkWUjVofo2zTAbQtBARFxD2bfhSuSdOG6lc2F4aIevNI7x22EaTzvHuqCST/du+PJLmpXQisvZX89iMTYl3Uqhalkv+GTrnXkPVYPLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538836; c=relaxed/simple;
	bh=V9YCik7gHn007L52C96jX5aOJls83fMTR4hI1O/NKSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWAHAzLJgqTFrqf5BhSDUECjsuTQoDuyInK5ZJ+YaKfT9tMXTQVH2UJRj5JMVKJ6P3OC1xOCLm3JCum6oXAsXIQacSCrgcWHsqJfw2iphEAp92+I7bZ1+GFXTToqvMWWsyuIhiS92wqSCiOfxbSwRi2+asyZuhwljOtqvfWXSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAMKpFsz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so5527615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538832; x=1726143632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HaI8H3FoFf5DkYAUaiPm+4Z9x64Xtmwnoeo29QHwWM=;
        b=AAMKpFszZEYh9CyNrbeMIvoQi22MfiiWbnfw8Q2fm4FUypAgI4PRzg424BlkmNp4hb
         a7H5Uwuin2HTu7XVXZW+j9jySluCwk3PipEIe2CvgaVmYZx67p/NjyGDBg7yPrxBk4QX
         c9f6JLvqt6t+XA+aToeLlil3cL67mdJoqcgrYgQXPQovD6CYGPvWhFIetACrvgK9Qvcz
         6hAxJx/Q3p/bAc1x9G03M2CR0jKe+uvhROx+SfyQtrhUnOm6OaI6Xuy+3S91m+zQEAsL
         cetPl9wRbGPbYSsE+nxPMD3BawJlDpORmhhI+0lZd/MJT6SzgbToGMcMriXd4T8ll8cz
         SjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538832; x=1726143632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HaI8H3FoFf5DkYAUaiPm+4Z9x64Xtmwnoeo29QHwWM=;
        b=hMci1j22FfGoVwhveYuQ/3COvEWP06tFN9LuGT3si+e0+9fNDh+bGi5Ome889Eq1Kf
         lCzKvKn1Xgdzmv6ksnsJDUW5Noi9RBTeV380NgPyY9Yrr6iiH3vj7Yj9URqqLM/CH/bi
         aGzAeXo1NwysAEyU3BbzDAszqh3JBzLxw8KwqhLjGLNjDEC/M7jsCtl9nULGL8N29CWs
         gQ/+PQNKsEJUq79wUzQGC3olWUrEjnhxv1pzOT8KTS4egkxEKZ8rhA+pO6DntcglYLFG
         YE/mi2wgNKmWqTzunknYxeIfk9PNVKpUXGa0MCPep+w7fPXbJE9Vr7SUXGRfNKzpaGg6
         wUMA==
X-Gm-Message-State: AOJu0Yy5mOWQCDB9U6w22vxt2Bx3TCFYKrUq0uuJ3115WnZBX4E9eyY7
	7HdN3PTUene0mslL+eAXagEyIREx/S8FXtr9RrlEwjg+Ki0qNRe4EPMc7/umaso=
X-Google-Smtp-Source: AGHT+IE2hEOGwUOJkuyF1I8qI9uOVWO+FZGUIZ7HMVcfHwMRCsmidU8BW4tzIrgihpb0nST6p/Hbfw==
X-Received: by 2002:a05:600c:4ed0:b0:426:654e:16da with SMTP id 5b1f17b1804b1-42c7b517656mr115747575e9.0.1725538832267;
        Thu, 05 Sep 2024 05:20:32 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 05/18] mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:13 +0200
Message-ID: <20240905122020.872466-6-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/tests/oobtest.c     | 2 +-
 drivers/mtd/tests/pagetest.c    | 2 +-
 drivers/mtd/tests/subpagetest.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index 13fed398937e..e1ee68f8b8f8 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -17,7 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "mtd_test.h"
 
diff --git a/drivers/mtd/tests/pagetest.c b/drivers/mtd/tests/pagetest.c
index 8eb40b6e6dfa..6878700d2fc0 100644
--- a/drivers/mtd/tests/pagetest.c
+++ b/drivers/mtd/tests/pagetest.c
@@ -17,7 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "mtd_test.h"
 
diff --git a/drivers/mtd/tests/subpagetest.c b/drivers/mtd/tests/subpagetest.c
index 05250a080139..f34bbf033c4d 100644
--- a/drivers/mtd/tests/subpagetest.c
+++ b/drivers/mtd/tests/subpagetest.c
@@ -15,7 +15,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "mtd_test.h"
 
-- 
2.46.0


