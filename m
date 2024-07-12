Return-Path: <linux-kernel+bounces-250314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7C92F661
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B861F237B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375113DBAA;
	Fri, 12 Jul 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m67OAJ4X"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BF13D50A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770129; cv=none; b=MrcUY9hIOLnFHr1oZr7KE/cXJzEKXdYQwsl09zV7pfS+BHAsyD2+ALdwakVhf+fyldmEypugUxy/NbcuYatg3RkbunqSKx+M48xc6VYfuS65N0/F3goHbVMfBQq/93ZZXqRggqDduQXI7OjUiNublL65UnLMw2teW/+PC9jzaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770129; c=relaxed/simple;
	bh=WUOV0cBbuht+SBU7dV7D/GHBV2YpQDAk9iDAyfSCuoQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B1aZgtoAF3vuKRIz+X/o9zutatwiNPe+/qi08OqpuAyS/FFeMXvO39/zfw7G9fV2nM1aO6jpKnx3uReAVxzzdXwASOzfy6loRRU4Bjvke0oEgC2PhWJQlVKphxvYHWRNy9uFoYmxATi5P4K6c4l9RrWaP6FQbLiFKyGXtBFszeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m67OAJ4X; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c4309fc8so252856366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720770127; x=1721374927; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxudLGzxPUebSk8Tkpt3subtuV+nHyCTtoyy+RoXjN0=;
        b=m67OAJ4XXULmtswx7zewCQcdzsGzfwAcKCYQ5Qcc4l0ZXYw7CIR/TAsCapqxBrzBm2
         XJcNJhQPbIbenll8e4ANDiu9QSGcJLFn06EHShq7eFP1RK7+jVOXNVVytcw+ZB6s2apc
         f9IWZhA/FJfVuYaqFN+F0CX7b0e2RHlyJSkKzAo4wqxQ514zsDtpufkVHxAqWqW9ZAQd
         45Frz07fKwvs/p8UYDHcQpqpTAGJSQXyoSAoXAl4gHH/srwLxxxQywM8oM+/YkcOsWB4
         aSaABLF92aIFsUXuqX5QSdlCEzM57YdnhJ8avcQvwrsvK7x9mz6VHtGAzCNR3lZ68neR
         Gahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720770127; x=1721374927;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxudLGzxPUebSk8Tkpt3subtuV+nHyCTtoyy+RoXjN0=;
        b=WMf/qbIS+mA+FxlATsNHzGpKjDAWCNSR85vjyX8VTZyoQ90WVgL71cxJoKG21/HIOY
         uwsGscBjjGAbfjgdvJHMy4V5vaUBT4MZZGTB6YI1E2AS5kV79WMETftoYN5iA98MTDiI
         b4w7w7IEZAhAhBYmV+Ft1RtoQSMP5zwzZbiuW5zxKZXqKV4QZrcVTYg5qWx/j3YPWXKo
         weccB8oy5XoSwSyEjpaJyT8yCNjwg9gsEYs7kveTPPizzUMxK2JgUHxpGMFoEIvVp6fb
         lSB8GohSiLEXpsmv7YXULFeOJGjDDV1WSJMcf/nJ2uMiFXLfO2+pnBO5dtDnoNJhaYCU
         0CNg==
X-Gm-Message-State: AOJu0YwTz2V1IjZt7jQcqoDYK16QGPYf0cPI1eBp0uqXmYiaAlipKpSo
	vEe71AcrL9TKAo6ZxKQSQRCoWPaJuxZt47ZVd7Kkv+doD/cN6/VV
X-Google-Smtp-Source: AGHT+IG91VrY3H+K56Sw6iIR9/BgoIVyBAKRefBtZTJbyAceWgpu5l5bPwgNL/990VDkjE5phs8hSg==
X-Received: by 2002:a17:907:724a:b0:a72:5a8c:87c6 with SMTP id a640c23a62f3a-a780b68a9d5mr781712266b.10.1720770126327;
        Fri, 12 Jul 2024 00:42:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc75sm318557866b.33.2024.07.12.00.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2024 00:42:05 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/2] radix tree test suite: include kconfig.h with incomplete path
Date: Fri, 12 Jul 2024 07:41:50 +0000
Message-Id: <20240712074151.27009-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The include path indicates it is the kconfig.h in tools/include/linux.

Let's use the same format as others for better reading.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
index c0a2bb785b92..fab6f47a9472 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -11,7 +11,7 @@
 #include <linux/err.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
-#include "../../../include/linux/kconfig.h"
+#include <linux/kconfig.h>
 
 #define printk printf
 #define pr_err printk
-- 
2.34.1


