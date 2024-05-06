Return-Path: <linux-kernel+bounces-169240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C28BC58F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3200E1F211CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592743FB1D;
	Mon,  6 May 2024 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcU7HWCg"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139893D55D;
	Mon,  6 May 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714960000; cv=none; b=CP+6miVKlip3gei5cZdQYp9I+HgfAccmeUQNIt4ew4ZjGS17hCcdfu9dvefFd+6XbzzTr+T4uYQyADa9VnyFMo1JmAPWDpxhGNCq4J0m7v5Pjh1AvwQZXGgck1ryKViOTv6j2w0LPU5Ec1fOLNAMc3Q6SIE1vviiCGPCkBCjS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714960000; c=relaxed/simple;
	bh=lOubGtR80AaNFh/cJV+FIWAPhTfv5Muj74fW8EsJv/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nj4MnbyyQGQMGrR1+5D5mMLLPrQOm6ebzii7uFOp7Rq2QCk4yRnbPMOmUTWXycTZh7vKkb8HoG6sEAgCioeJWZBL5HBFZCvXxuflRm64MpUHrg5UZaBf91sFuHYL4rcGrB+DatmFgqTkQvvYAI2CYp/5/dRp95IcpUdVFYH/Kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcU7HWCg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso1446866b3a.3;
        Sun, 05 May 2024 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714959998; x=1715564798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbtBOu7AIsmC5hqACAkZ2qUxEdKcn2SBtMp5/oLSpC4=;
        b=ZcU7HWCg2qJMm9oAS3H++pytOXPmT0lGq7sYOpYfeOiLnt+lLGQAtFI9IWgQWIDQOB
         WwnYPgqQLMJKv7Hx/JXRdYS5dGb/Igojb7yxcJHFrphZiIWHPU0J0vznsh+eBq1ttQNf
         JE+iXFbLw5mQRqkq1Ekc1dlHlRnZurEf4Z4i784560nwX3vJaeL2JTtH4etPZ0LeDj7E
         qUwP+JYpF/S7l275jtungr4PgmoYUfjhuW30eNdGzEsCmgL8ghsc0R4NyKhh9InH7R+s
         mph9j0xCOgXsp53sDz0gCR5H0HPknJPerCdZefRokXDXFUDaff4FrHZOSVyBBsPbbWFo
         tAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714959998; x=1715564798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbtBOu7AIsmC5hqACAkZ2qUxEdKcn2SBtMp5/oLSpC4=;
        b=Xp+WkZdmOtfdRlTfAZpgPB3N/r5ICoaSL5Kxj90bAh7PhTUXGsu6hiWBTjzBVjVPYB
         4Szx3AURUkgojXWmW/5aPfbaZDp1h8wTZaUPrqZe6Qflb9ThGOR3EtDdOhjtYmEb6pfD
         tWXZSHRh4RhqjG7cn6qNCVIKnP66m8eAw2sEPTL2yQ4mh2f8ZshVaBSGxRmavF3nhtce
         +Jlh9F0r2S8t0Ks1lWcKv7akxHImR+MyhGEa3uj6YiR3hTwJEgZNYdYsn4NT64Q2mPCa
         uRW+L9GdLCBCFPES8GwbuEnCjV4M3aZ2rBtfKkeKAsPErZznCI+gRUDsnSZ11WTMZGqF
         Oj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMFowOdoAiSgy3q9CePBRUbVR09KxruCyc7DFmUkvF3S1+M43WYDkFB/ytMiUR9YimnasvMckKFB11Aefkt0+kUQ+IqscSp2VIepAOlHwTYe466mFWKPAAM45TECqY1q750ZJhQV6defth7Z8P2Bk/O2h7PtS2LGLNuYLiiSo4SD+8
X-Gm-Message-State: AOJu0Yy/WDex7hcuNFFBSRgdqeGVX+XMjPMOAzj2e8rkpamEOdYPEQIq
	h/JlBZlFEdHNvb5DHnN9yEM45JXy3K356yxgWKbInblxTY9tSb9L
X-Google-Smtp-Source: AGHT+IGfsukyiuaHRr94O7X2ihmZy4ttRqvBKuQdqA5ieu6ZRIIBAbfj30XugXmyYBynDBFGbRy/lg==
X-Received: by 2002:a05:6a00:1704:b0:6f3:854c:dee0 with SMTP id h4-20020a056a00170400b006f3854cdee0mr12877549pfc.21.1714959998353;
        Sun, 05 May 2024 18:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id fj30-20020a056a003a1e00b006eac4297ed3sm6608511pfb.20.2024.05.05.18.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:46:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	joe@perches.com,
	linux-doc@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
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
Subject: [PATCH RESEND v6 2/2] scripts: checkpatch: check unused parameters for function-like macro
Date: Mon,  6 May 2024 13:46:06 +1200
Message-Id: <20240506014606.8638-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506014606.8638-1-21cnbao@gmail.com>
References: <20240506014606.8638-1-21cnbao@gmail.com>
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
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
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
index 9c4c4a61bc83..9895d7e38a9f 100755
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
+						"Argument '$arg' is not used in function-like macro\n" . "$herectx");
+				}
 			}
 
 # check for macros with flow control, but without ## concatenation
-- 
2.34.1


