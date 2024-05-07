Return-Path: <linux-kernel+bounces-170614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7028BD9B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAA283175
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662A4EB56;
	Tue,  7 May 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuczOKv2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E751010;
	Tue,  7 May 2024 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052511; cv=none; b=beZP7sJVLx7UkQ5CNm0NtQM3oxxUFz/l7CHhL/gCO4fzMk2SxUx8wqV/CKTTT0Y1we7tvzQ7TIIxPq/fL7XWUk2vL0z1/l3rB8wUClMxc+wrcTMMPk2coIFITWH+mX+TernWCSkRmsMeeHVSQ9ZVEO3QxIZoxBqwfPeGvbczQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052511; c=relaxed/simple;
	bh=RJFOiqz4QzNMe5fUaO49lQKw+BLYKHJV5ZAJCUpwMoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Niciju62KqKrFDIRM7OE43uCEauU4nyjvf6ti8pEQnGwQmfG1M/u4PdVB/LtT9s94NoX/buLiG/2Kob9AHRjnArfIydNWc5HIUxGUOU67Z967KW6qjjtsf0Nn/kBdyvOsjR4nKyXhN7geWsZQUqTi0vyfonjF2mBDWl3xga7rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuczOKv2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed41eb3382so19917215ad.0;
        Mon, 06 May 2024 20:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715052509; x=1715657309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO4svkG2NjlN6TUmciRZsz/RMioTaNbu5km5tihixL8=;
        b=SuczOKv2EEwxVN3jnA//e3vuukpTB1USQJtZo4DxwPcyfrlaBVj3P9T6+nfeZ6qUEl
         Vj3gnX+nVa7p3/iXtzlzr9Erq6uaXUsWYeeid6esYR8dFG+xrgltIviI6j2dUlhgbULN
         I2dvEO5PiI/0fZuUqj3SWxb+sPhvPj68u7QdqnX65hdUkll37hAKV2b4KXeQnuWzOZQi
         5JK/XYRB9H8LzsPKx2TBJW+s+GLkpcyUngvrKcfnS0fZyX/ezpgZFGLWmx2iQaJ9/Uz4
         6XOPVnKS3RO6nnVMtKm2NV3S5Vwa/mGcDP81TqycSOZEjb6A5xxE5KKK+ty6R8ks+3Xr
         Wedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715052509; x=1715657309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO4svkG2NjlN6TUmciRZsz/RMioTaNbu5km5tihixL8=;
        b=mzhRaH1sD7kUJvx47yWuZonuKWeX2TTYbZqE5nwR3dgbL7u4OCAh5A/FENnSfpr9A6
         YxM3CtMfFKhZJ6C9BD9FXq7wR9hyQ1dA2TdUY/b4yJB9k5s6m2Ge4Dws9xh6h4xsIwxH
         DtuVWAAhq0G7AdS7FhEpuo0BYhZGwZnAGpRiUxzAf64nGaahxoGBl4Yy21TWsyzxFkJR
         JdiOoeLJGenzR3AgO3LnuAg82KxigF8uiO6/qVZY286aK5R2LFUFrGY8Nyr353eiOwfv
         rL5UOlM1bXgPRdEKugZ90d1yLyxWapNoKSuxCSEWTYGi5/RMdc7lH/SKGe2q9SLMyTEO
         p9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrLlM/yooDDVkw17FHtsjElqCdjCJtf84XSq04lfUFYSVRxMm8PPNgQt6sOl6RwD+1PwSx8Rb95c8LV8+JyOLpp5Ya9K76o4x19kknXod0R/JXaY4yiqFjcdq9Rn/zlxZmKIw2oolgXR+JqBSnAiED5KKJNfNuffrDBRE2Tax5/MaM
X-Gm-Message-State: AOJu0Yy2+hja8Ml+JCw67Rm1Ig4gW3QJSUufZhcuXxPXwXStMxxO70tu
	Qvf/JZ2Ssbbow+/ZTqEo8MlzFFaEmyEUrUB2rVMV06mzo5IOaYF4
X-Google-Smtp-Source: AGHT+IG3qDqL1LI9mMmJY13LJ3nnxFJ9FUPUeAEV+FMwxCHYwOzUfyhz2TCvIPCdZnfdRqvb8d6a8A==
X-Received: by 2002:a17:902:e5c7:b0:1e8:92:c5e2 with SMTP id u7-20020a170902e5c700b001e80092c5e2mr16956588plf.47.1715052509309;
        Mon, 06 May 2024 20:28:29 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001ebd7bdaaffsm8988409plg.288.2024.05.06.20.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 20:28:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Charlemagne Lasse <charlemagnelasse@gmail.com>
Subject: [PATCH v7 2/2] scripts: checkpatch: check unused parameters for function-like macro
Date: Tue,  7 May 2024 15:27:57 +1200
Message-Id: <20240507032757.146386-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507032757.146386-1-21cnbao@gmail.com>
References: <20240507032757.146386-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xining Xu <mac.xxn@outlook.com>

If function-like macros do not utilize a parameter, it might result in a
build warning.  In our coding style guidelines, we advocate for utilizing
static inline functions to replace such macros.  This patch verifies
compliance with the new rule.

For a macro such as the one below,

 #define test(a) do { } while (0)

The test result is as follows.

 WARNING: Argument 'a' is not used in function-like macro
 #21: FILE: mm/init-mm.c:20:
 +#define test(a) do { } while (0)

 total: 0 errors, 1 warnings, 8 lines checked

Signed-off-by: Xining Xu <mac.xxn@outlook.com>
Tested-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Joe Perches <joe@perches.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 14 ++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 127968995847..a9fac978a525 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -906,6 +906,20 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/1399671106.2912.21.camel@joe-AO725/
 
+  **MACRO_ARG_UNUSED**
+    If function-like macros do not utilize a parameter, it might result
+    in a build warning. We advocate for utilizing static inline functions
+    to replace such macros.
+    For example, for a macro such as the one below::
+
+      #define test(a) do { } while (0)
+
+    there would be a warning like below::
+
+      WARNING: Argument 'a' is not used in function-like macro.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
+
   **SINGLE_STATEMENT_DO_WHILE_MACRO**
     For the multi-statement macros, it is necessary to use the do-while
     loop to avoid unpredictable code paths. The do-while loop helps to
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..2b812210b412 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6040,6 +6040,12 @@ sub process {
 					CHK("MACRO_ARG_PRECEDENCE",
 					    "Macro argument '$arg' may be better as '($arg)' to avoid precedence issues\n" . "$herectx");
 				}
+
+# check if this is an unused argument
+				if ($define_stmt !~ /\b$arg\b/) {
+					WARN("MACRO_ARG_UNUSED",
+					     "Argument '$arg' is not used in function-like macro\n" . "$herectx");
+				}
 			}
 
 # check for macros with flow control, but without ## concatenation
-- 
2.34.1


