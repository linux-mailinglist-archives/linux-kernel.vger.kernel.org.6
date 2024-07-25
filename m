Return-Path: <linux-kernel+bounces-261644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5B93BA3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F4E1F2396A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE117C91;
	Thu, 25 Jul 2024 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEm6d3x5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAE10A2A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871730; cv=none; b=P3I1tCYc0Mte2+klZ0C31OC8HII4puBMklPgPVpI2ABBuzO8fCN//7644BN95C5/GwEUiV33CEMtVRodke4+iPwtoKG48CxTCK9Llod1cW3SYpIPPrNTWGHRZ6WE7kUkdNEzf+UtbZT+dVJRaxbGq58MgYh8kiDs0PvHwQEs36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871730; c=relaxed/simple;
	bh=aJh6DP5xw/FEGxsis3V+hHehmpjsGXJOrKF5Jrecqac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TUQIS7gNWjaIl6Bu02IMRNWQedV6TuKiQEHbOa21AFwCfuKTaPX/VyZZkPw/3L3o3/Ypx+nF3fgpFpw7k1LevHCzObbmy2H9zYC17WpuD3awvi0TSK2/M/PQSUzhIRbBsScyZzoBxlRhO+0+3wG7vDze2rfXxjTvjyM+fTAJzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEm6d3x5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso4762566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721871727; x=1722476527; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9t9X8YtjQJ97vnjdUQkBC7tpE7oM03qFERBGMdqLiQ=;
        b=TEm6d3x5+YYO86p7JS/UBxwfyztBc3sA6WixkbMrhcu6FMW5QfZ553wU0hPmPkxwwE
         0xzKoJyLpL16U5Xin2J+WHloLvAz5bUGfKox+OODakMTHmMEUlnpnjt3pnw/0NzTOzwE
         hCFNWkrg0EIMB70vKnFaqeBlRZpyrIhZoMB+BKgJG/wXRlS5EL/8HIhBV+iUBMVIeNbo
         FitQd3RVema/UgBNzLJpMPQCJq9nTCz51dnExu2zC/oFc+n8kWjg6Ydkx/9p6CmcNIPs
         BX0OZJ5AfJnKRlUqeviCKvzUr4MvLHcboREfzteDGK2SbPhUJA+kksDqHShtNaIruUnI
         ZX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871727; x=1722476527;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9t9X8YtjQJ97vnjdUQkBC7tpE7oM03qFERBGMdqLiQ=;
        b=KHmmO2pO4LmTMdrapaV2cj0eY5NVyJ1w2gcF7bZ0ZlOagKneSP/Zypz1Jvc2iCOSzt
         98yT/y5yTccA73xpwjTDXPrveG/fuSA2d+/2yYYGQH4NraYf+GQRMT/BnL6T8aECi3lX
         pvgKkdkhrXufqtQYEWrDFGAj0f7q0+haRj4XjvYKHU0l+9FBNt06MCZfCPRN3jyO9DJt
         Qb2vbPoFkwnpPYBgSJvaziOcQH3KcL0VPDEM+yjOl1FuZO6FCjLBY/tzXk4oiKBskg83
         LYtONomAilYTBaqyrmpjQHRH3mlpCASCV64nNO4ZQrXu0mZxxwF7AFN534+TE83i4HHO
         YRVw==
X-Gm-Message-State: AOJu0YwrinKTbIRudia4dbeC7HK+RkGJN+mbc/YEdSLMzw3ni5qxmAeH
	Y/FPwIX+32el0wVy3DReNLXs3bNB2LMKq3AhtEVOY4hlnF340t2C
X-Google-Smtp-Source: AGHT+IGV/bfSCfjZ2C2cURoUMo+w0MNVOHbB3RnlpWzPQrY+R7g3EebmWtmWo1mrRNSyoHfngvlUFA==
X-Received: by 2002:a17:907:971f:b0:a7a:8522:5eec with SMTP id a640c23a62f3a-a7ac5076647mr83849166b.53.1721871726359;
        Wed, 24 Jul 2024 18:42:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8039sm17289766b.200.2024.07.24.18.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2024 18:42:05 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] memblock test: fix implicit declaration of function 'isspace'
Date: Thu, 25 Jul 2024 01:41:56 +0000
Message-Id: <20240725014157.17707-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240725014157.17707-1-richard.weiyang@gmail.com>
References: <20240725014157.17707-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of isspace().

In kernel source code, memblock.c include the definition by
debugfs.h/seq_file.h/string_helpers.h/ctype.h. Since it already has
ctype.h in tools, let complete the include chain to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/include/linux/debugfs.h        | 2 ++
 tools/include/linux/seq_file.h       | 2 ++
 tools/include/linux/string_helpers.h | 8 ++++++++
 3 files changed, 12 insertions(+)
 create mode 100644 tools/include/linux/string_helpers.h

diff --git a/tools/include/linux/debugfs.h b/tools/include/linux/debugfs.h
index 4ba06140b1be..a99b0e0c5414 100644
--- a/tools/include/linux/debugfs.h
+++ b/tools/include/linux/debugfs.h
@@ -2,4 +2,6 @@
 #ifndef _TOOLS_DEBUGFS_H
 #define _TOOLS_DEBUGFS_H
 
+#include <linux/seq_file.h>
+
 #endif
diff --git a/tools/include/linux/seq_file.h b/tools/include/linux/seq_file.h
index f6bc226af0c1..8614fc2ca695 100644
--- a/tools/include/linux/seq_file.h
+++ b/tools/include/linux/seq_file.h
@@ -1,6 +1,8 @@
 #ifndef _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
 #define _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
 
+#include <linux/string_helpers.h>
+
 struct seq_file;
 
 #endif /* _TOOLS_INCLUDE_LINUX_SEQ_FILE_H */
diff --git a/tools/include/linux/string_helpers.h b/tools/include/linux/string_helpers.h
new file mode 100644
index 000000000000..bc11a762be8c
--- /dev/null
+++ b/tools/include/linux/string_helpers.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_INCLUDE_LINUX_STRING_HELPERS_H
+#define _TOOLS_INCLUDE_LINUX_STRING_HELPERS_H
+
+#include <linux/ctype.h>
+
+#endif /* _TOOLS_INCLUDE_LINUX_STRING_HELPERS_H */
+
-- 
2.34.1


