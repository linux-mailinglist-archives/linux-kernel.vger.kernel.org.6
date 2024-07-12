Return-Path: <linux-kernel+bounces-250128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05592F484
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F37283476
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828BF1863F;
	Fri, 12 Jul 2024 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaMZAgeF"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613212E5D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756307; cv=none; b=FbsO9aB7fw1Du3uZQy4FqSeyuQ48QDV7B5+uxHzddXo2CX3nf6Ruh5sCqDaHXUC3U0UzcZYFLfuNkybFNciDTYqBBJLEt564AaM2SClVska8wf6yij+j94sZWZRJ8j6ogwE0Ds47DbmwMVsQRMwnGaGtG1ysBUDXgGnulcQGGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756307; c=relaxed/simple;
	bh=jz++yfWXOdSw1TCpcBSMI2BPGY4+ubzO9uTur3cMn2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WR4yC3IliFat55WhZxpKbHMlXEHuoSRDKbvNc1Zd79Ml/xb6BqVxkFvPle2Wefea7S1aRnkSoXjjCIkx/+F2eZYVZCcHUSuDHjR7+7vV/QmhudSNHggpSKLfJzI4yPqYI4vOghk8naWJIcbm4TfwOdnCoHnGuZ7MLPTSAz87nFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaMZAgeF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso14429761fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720756304; x=1721361104; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TyQlU6I/jiYkGlfq1197jGcyZ0KF+HN5OropbzcVk08=;
        b=SaMZAgeFfcxnDDbxkFJROXS0j9G9slkd2HF1pLXmq15zAN761p1+PDGOKdC5KLW18B
         0CcO6ER6OtKJvgvqLMPeJKbm9OJUt6JbRH2lKqIDGF0Sv8wpb0kjEk5iFZw4kG5GWEa7
         xdVlHPVhIeWfVeF+f+XiAQ5ZJURmZCMj9KckvB1gs69UIqBFROGOhWtPUSIvHcSnr0rv
         OtBtEmVuOPmqcExAl02ltkjhz8ttQ7agzU3qXaPX+Qto4WZgI6pOpHZOy26reNStDnuQ
         dQDmIkT23p7Fl1p8SesqpLZpdNxnx/2ZV52VZW4J9ncfuyw6Guwb0bOGGRtBP9q5Yw04
         ZNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756304; x=1721361104;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyQlU6I/jiYkGlfq1197jGcyZ0KF+HN5OropbzcVk08=;
        b=olIfg63GqBd4A0i/dUCIzQ6foCSSue3eIgieudMgUpN1sEn8mwUXht0mgQ22OIaYt5
         MCAv5ngdK7uXg7Zkhg7DRnjcT8eJsYi2xWsMFlfVN6jqe7U7/NYaKHS2mu7OSQq/YjYc
         c0CwfPZiuWc0V5bev+yZT+MCKsIDR0PYjIHYdBTZIcPQoCDGXcCu8+MUrHcS5B2CPHP2
         7fC7y6KQSfXFGOoMepUYcD3Zb9hwfFfH6nGiE0V8YZ/xmj+nAn13RfRadirOHCE2v0CZ
         lyaSq5Q4P+BcCnv+3wpXJJoeFzlS6qSxLZlvPbJ0PmxY05kHFXD+V9cZbb2z97u53svq
         h0bQ==
X-Gm-Message-State: AOJu0YwrbwWtVpvuwCxTwpCI3sIF2fHVD9w21SctP2YOU3oRWDVSDvZh
	iAwPkDQhF4tE0umaQ74GIpbxN1y+6v1es0CYnGQ2+ON3Kh1jfn/5
X-Google-Smtp-Source: AGHT+IEK9t2pOh9KJ0YSVooVs/Js8zZyCAua2NoCqtsWQcOWOWHE6kuCTkxYpkqw/hXZwXoTIs1YyA==
X-Received: by 2002:a2e:a401:0:b0:2ea:7d8f:8d12 with SMTP id 38308e7fff4ca-2eeb31979bdmr63277511fa.48.1720756303816;
        Thu, 11 Jul 2024 20:51:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-595b1c0c869sm3285535a12.30.2024.07.11.20.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2024 20:51:43 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com,
	will@kernel.org,
	broonie@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/3] tools/testing: abstract two init.h into common include directory
Date: Fri, 12 Jul 2024 03:51:38 +0000
Message-Id: <20240712035138.24674-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240712035138.24674-1-richard.weiyang@gmail.com>
References: <20240712035138.24674-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently we have two test suits define its own init.h. This is a little
redundant.

Let's create a init.h in common include directory and merge these two
into it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
---
 tools/include/linux/compiler.h                   |  4 ----
 tools/{testing/memblock => include}/linux/init.h | 14 +++++++++++---
 tools/testing/radix-tree/linux/init.h            |  2 --
 tools/testing/radix-tree/maple.c                 |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)
 rename tools/{testing/memblock => include}/linux/init.h (81%)
 delete mode 100644 tools/testing/radix-tree/linux/init.h

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 8a63a9913495..e0aaabd18a99 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -122,10 +122,6 @@
 # define unlikely(x)		__builtin_expect(!!(x), 0)
 #endif
 
-#ifndef __init
-# define __init
-#endif
-
 #include <linux/types.h>
 
 /*
diff --git a/tools/testing/memblock/linux/init.h b/tools/include/linux/init.h
similarity index 81%
rename from tools/testing/memblock/linux/init.h
rename to tools/include/linux/init.h
index bd74abc5cba6..7ed407976dda 100644
--- a/tools/testing/memblock/linux/init.h
+++ b/tools/include/linux/init.h
@@ -1,9 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_INIT_H
-#define _LINUX_INIT_H
+#ifndef _TOOLS_LINUX_INIT_H_
+#define _TOOLS_LINUX_INIT_H_
 
 #include <linux/compiler.h>
 
+#ifndef __init
+# define __init
+#endif
+
+#ifndef __exit
+# define __exit
+#endif
+
 #define __section(section)              __attribute__((__section__(section)))
 
 #define __initconst
@@ -29,4 +37,4 @@ struct obs_kernel_param {
 #define early_param(str, fn)						\
 	__setup_param(str, fn, fn, 1)
 
-#endif
+#endif /*  _TOOLS_LINUX_INIT_H_ */
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/radix-tree/linux/init.h
deleted file mode 100644
index 81563c3dfce7..000000000000
--- a/tools/testing/radix-tree/linux/init.h
+++ /dev/null
@@ -1,2 +0,0 @@
-#define __init
-#define __exit
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index f1caf4bcf937..d6c72838652c 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -14,7 +14,7 @@
 #include "test.h"
 #include <stdlib.h>
 #include <time.h>
-#include "linux/init.h"
+#include <linux/init.h>
 
 #define module_init(x)
 #define module_exit(x)
-- 
2.34.1


