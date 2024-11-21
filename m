Return-Path: <linux-kernel+bounces-416790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804AA9D4A46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DB21F22660
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E981CB329;
	Thu, 21 Nov 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Be30ITyO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD31A3BC8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182962; cv=none; b=RL0QvBZlLhribDbGCzfVz0kJAx9DFc8Rlxg2MULtjitFD1DWOpwRuU+k/pXtSo9xNkKZ32AvwRqdvVtn2ptIrMucPJAoNf1f9BhAQMN773McSCHaEiD2mvVo+g4kRG9iYC9EBsLUgbfTBxEajpuyMndgXGYNJV5Acyx9TycdVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182962; c=relaxed/simple;
	bh=ycN9sNEpXXNsr29jBffFhbNrhL2MCKZs9uGkISz6mNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilgBLvd4aht8ljiyL0He4ksdbwglRzLHzyrcNd/HPe64lbVF+7QAsBWb0JJi/4PGSUgxDSDolo3gesJrUI1ksWq9mI5HipCdiY7b7GiAyl/9zsc2kkyxamr9yZuU2oEYCvvWD8KlOICDM1VjvLO4IfM0PN7X6QmhfFgSrnVxGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Be30ITyO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so714380a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732182960; x=1732787760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZkpDbhhAmJ31UVSTe6E/iwUO0IjXdxBz12bYKwUfes=;
        b=Be30ITyOa+Qj4HIx4gQbZeT9EejKbzxrSaoHkjpfBRDguzcJvq9PnvPzVfB8HU7lDa
         W+ZdFnpKlmCI+BgZjiyiFFlSSfC4XoJjtKKsBQObhUfopmi0Q7ejPFIMOap2Qs/qBloN
         rq8n0QG+EXqQpQ/97QdZhVGoaqXdAKvxvmPXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732182960; x=1732787760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZkpDbhhAmJ31UVSTe6E/iwUO0IjXdxBz12bYKwUfes=;
        b=HjHTi4N6yL3MXHv97CIWCXfnoddnHQDuO68kXWR4D55l1cnnNiEPEDQnTvYv1GeBJr
         NuD4Vxrt0EIxrUYQi79S138jsS770jqXHTk/NYCXo9SfRxuqcAMt6WWiG8DAT4oR849F
         e9GUarhX2/jlyFAcBgoD7yETfM8KxJgNSEkgQkIXaSBRc+mUqP30o9QXmmvmg+5wqfKK
         5Uo1xGIKJWlIT0EDyDlRZEdkTXuKQIz0YiK6FrjJOABBrsHw1dU+QkUh4opMfifJORn9
         GuEmxD/uEwiJIWitCH7EPuLLayYFESoxVHkOrcJGKgrFHnf6+KOVZSBIXP2l+fBUA0r7
         3pqA==
X-Forwarded-Encrypted: i=1; AJvYcCVw7NUIEiZiHzhuoCXg1cv3G/CMVpjiXuKv4zM+mvmx9O7Fzvvjw+7mynhau8K1ULHo081ayh7va9fRQs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzwfOuGW2qErJPIq0NYhiSoAVYQWMVyzlEBICyt9GWPtv8lJ7
	GU/iueUWPUXafaBkCiabe3O9owZidk5V4dtPeQNVMiuxNKjQ2ijfED4fvsURtA==
X-Gm-Gg: ASbGncuQU1eroB7TuDhNQv4J3JC2+BeZSnrzuFIa4+VHcM/w6rHTo5sbYJVGpRe1TTx
	2PDMbqDcvbvmhqoYWImodD7EvcGrIf9q1L2Am8vv4G/ekK4QOBELflS8NUA2y7NgtxAo/58qDWu
	Pw56xnm0aGGG54EF1Vj4SUp0nMFMvZpCUURXq8F3R9N2yV3GNPQ6J+XxbHO4kRgwhFRmoPPKSDf
	jOROi7nkTwHS+BQL7y3oXXIfydA/fNtmFVib7u46hdMvqzI5xK4aruB48fY7LjkflrP
X-Google-Smtp-Source: AGHT+IHjEi/AY0wENllp4hRhBejtoC8+iDABIpse2LbxjAgeclXsFeuknXaJ/kZQDeuvcIrPHGkU0A==
X-Received: by 2002:a05:6a21:788c:b0:1db:eee8:f2a0 with SMTP id adf61e73a8af0-1ddb0912f62mr8897525637.30.1732182959743;
        Thu, 21 Nov 2024 01:55:59 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:527f:df65:78d6:c140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21287ee2a07sm9910355ad.140.2024.11.21.01.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:55:59 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] Revert "delay: Rework udelay and ndelay"
Date: Thu, 21 Nov 2024 17:55:38 +0800
Message-ID: <20241121095542.3684712-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 19e2d91d8cb1f333adf04731f2788ff6ca06cebd.

Journald was recently observed to continuely crash at startup, causing
the system to not be able to finish booting. This was observed locally
on my MT8195 based Chromebook while doing development, and on KernelCI
on a MT8192 based Chromebook [1].

A bisect found this commit to be the first bad commit. Reverting it
seems to have fixed the issue.

[1] https://lava.collabora.dev/scheduler/job/16123429

Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Honestly I have no idea what's going on under the hood. Journald getting
stuck means the system doesn't boot to the login prompt. And turning on
journald's debug output didn't produce anything.

 include/asm-generic/delay.h | 65 ++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index 76cf237b6e4c..a8cee41cc51b 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -2,9 +2,6 @@
 #ifndef __ASM_GENERIC_DELAY_H
 #define __ASM_GENERIC_DELAY_H
 
-#include <linux/math.h>
-#include <vdso/time64.h>
-
 /* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
@@ -15,18 +12,13 @@ extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
 /*
- * The microseconds/nanosecond delay multiplicators are used to convert a
- * constant microseconds/nanoseconds value to a value which can be used by the
- * architectures specific implementation to transform it into loops.
- */
-#define UDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_SEC))
-#define NDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, NSEC_PER_SEC))
-
-/*
- * The maximum constant udelay/ndelay value picked out of thin air to prevent
- * too long constant udelays/ndelays.
+ * Implementation details:
+ *
+ * * The weird n/20000 thing suppresses a "comparison is always false due to
+ *   limited range of data type" warning with non-const 8-bit arguments.
+ * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
+ * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay
  */
-#define DELAY_CONST_MAX   20000
 
 /**
  * udelay - Inserting a delay based on microseconds with busy waiting
@@ -53,17 +45,17 @@ extern void __delay(unsigned long loops);
  * #. cache behaviour affecting the time it takes to execute the loop function.
  * #. CPU clock rate changes.
  */
-static __always_inline void udelay(unsigned long usec)
-{
-	if (__builtin_constant_p(usec)) {
-		if (usec >= DELAY_CONST_MAX)
-			__bad_udelay();
-		else
-			__const_udelay(usec * UDELAY_CONST_MULT);
-	} else {
-		__udelay(usec);
-	}
-}
+#define udelay(n)							\
+	({								\
+		if (__builtin_constant_p(n)) {				\
+			if ((n) / 20000 >= 1)				\
+				 __bad_udelay();			\
+			else						\
+				__const_udelay((n) * 0x10c7ul);		\
+		} else {						\
+			__udelay(n);					\
+		}							\
+	})
 
 /**
  * ndelay - Inserting a delay based on nanoseconds with busy waiting
@@ -71,17 +63,16 @@ static __always_inline void udelay(unsigned long usec)
  *
  * See udelay() for basic information about ndelay() and it's variants.
  */
-static __always_inline void ndelay(unsigned long nsec)
-{
-	if (__builtin_constant_p(nsec)) {
-		if (nsec >= DELAY_CONST_MAX)
-			__bad_udelay();
-		else
-			__const_udelay(nsec * NDELAY_CONST_MULT);
-	} else {
-		__udelay(nsec);
-	}
-}
-#define ndelay(x) ndelay(x)
+#define ndelay(n)							\
+	({								\
+		if (__builtin_constant_p(n)) {				\
+			if ((n) / 20000 >= 1)				\
+				__bad_ndelay();				\
+			else						\
+				__const_udelay((n) * 5ul);		\
+		} else {						\
+			__ndelay(n);					\
+		}							\
+	})
 
 #endif /* __ASM_GENERIC_DELAY_H */
-- 
2.47.0.338.g60cca15819-goog


