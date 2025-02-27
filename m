Return-Path: <linux-kernel+bounces-536533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA912A480B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6B3A6282
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FEB23E23C;
	Thu, 27 Feb 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+kjX8wW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F323C39A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665241; cv=none; b=lqaodfVttonu/fsfRdSGBfbIGfZMcY3maaM5m6/D3nXvp7BVlzBUEZ3LzOZ7DXMbAqh/aYxCizHpjFdxaLrflIXsTKA/qmPljdjFfJr1Ih+qV/uAUI2aiBhjdsclS/OhOJEXJVaCQUyXxL97Cf3kI/620xX2kOa5XdvqYCawCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665241; c=relaxed/simple;
	bh=XAN1YWH9D7fhIC80lM9v65r9S5cnQUbTdkwcS0usi4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFWREciRj1hrpreKIUZMO56czzU13eZJydspttggYJ03aF3RSIPYHeSlILXK4o5e73ZEbMnXSYm7rvuWOUJZjERtNtNqahJE8muGlcLk5dtIkNUJwrKthuomrtpxxWEJI7yrKZenYLgQ1/ivK8VzOx+quGaVTzc7h7VFGgQ3ook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+kjX8wW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab744d5e567so178435266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740665238; x=1741270038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gwIGXInW+F7WA8WdnAv9e0DBkovllqoBbjCqtJC5/A=;
        b=d+kjX8wW90hRLQu6ukkeqlcEswKP5/GzPI1V1atHvI8gITb48jhNPGV9BlYua6fXQU
         hVAEKcql3s9mQ5DTqKgg6Z2CDoZCAXzc/YB91sIL4ULk4hcczEeDrPVqj8n3uzFgs4/u
         0g8bHzqeumh0RLau9rSFTWz0hNZbgb+pVolB4am9BL20Fqf3yWsicA0AFdRrEFLxHDv4
         Z6Hc0NpbfLSglJDBBmQNgtkaMmTb609cNy8no+Zv1FfVtSIONmQFdTUlPbJpjWCx4c07
         V7HBMdzVerUHJWEdOMUqaQSTE2hvAw7TpVi36Qe6jySAoeBj9SVf2RfAkNd/ezZINpxl
         UJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665238; x=1741270038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gwIGXInW+F7WA8WdnAv9e0DBkovllqoBbjCqtJC5/A=;
        b=e8c0EXQxEEUwiuD/f+ow85mcRhJ8z/pnenCyVNyCGl6dg9m+pF+lXdLcez5sjeZynZ
         RlzINfqx7SkV/uN5EvQQV00CiuJvkUGvQTXDZpZ9iUrNvjT/rOfG/GnnUE201VxhrMJi
         ACD/0XaYxWLuWOLyBXGoxmnXdPLfFG3sa8DHkBhAYyj0Yj++IQl5yL0bXyB6SlJjYjpy
         vtCLfyhIOOz/WRnqtrq6tWo5C/RY+OtmJ+6o1YAQS+mkFQjlWZt8YgTmgALd8yDFWhhf
         stkOiDt7nCq0TA8cAQVuiBwvApA9i6IZBQG/9zc6mPWKZhjDjlyRJJy627yjcBHgkToz
         fp5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZtK8kLP1PtbcZvIY1jdbg5LtHcnEBx3JzkGEfL8M1tiXD1zKc40flij5+ZdOnruc+cWiawA7UELCJ5H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9h/5i2DZZBtl3gcFftaIcqfuHdU3cAxqLoX5XQNzLACYBwo1
	Br4Ozm0gnRCwTMF4hpzWjMqqldsEgAMvBZZmSmRWNZdSkVBjTQKw
X-Gm-Gg: ASbGncsIapYBb67oCzUM9B7uRnVaDrSt9ArrFjlEYE1W+FrnG6y3d4roqpIQlwmlhdK
	fzV12WAJp8s5go0mymyZXNLk4ZRaNnNS0/voiyKrOLpRB3VuVW5pwbB6gs9tvLq+nRXV/0XGQSm
	ULz5IhoZrsFH3SeR0oZq+HHl9beo4otBhSWvKXJ+b7ZdueNIyVEDfclG9LSUqZG8GEFbYosOJlC
	fiZxYYfcpxUxgq5Fr9XtWd6wXK7wmg8ewE5Z5V/N0kZwQrsSWWSqvqSX/jn0StzCD1Y59YwsJZh
	E6hi5UeOGhgqxsdzzg==
X-Google-Smtp-Source: AGHT+IHj01UdUdouLpLrpg/EF9SJ2fYdEnZ4H9STAdnJbEjkOTio6fzxgP00IHhClcTagCh6QcsNjA==
X-Received: by 2002:a17:906:5f92:b0:ab7:b9b5:60ff with SMTP id a640c23a62f3a-abf05de37admr438714866b.2.1740665238060;
        Thu, 27 Feb 2025 06:07:18 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9ac0sm128481866b.5.2025.02.27.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:07:17 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/percpu: Disable named address spaces for UBSAN_BOOL with KASAN for GCC < 14.2
Date: Thu, 27 Feb 2025 15:06:58 +0100
Message-ID: <20250227140715.2276353-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC < 14.2 does not correctly propagate address space qualifiers
with -fsanitize=bool,enum. Together with address sanitizer then
causes that load to be sanitized.

Disable named address spaces for GCC < 14.2 when both, UBSAN_BOOL
and KASAN are enabled.

Reported-by: Matt Fleming <matt@readmodwrite.com>
Closes: https://lore.kernel.org/lkml/20241213190119.3449103-1-matt@readmodwrite.com/
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Kconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95ea2b4b95db..60c2a16c7801 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2369,18 +2369,20 @@ config CC_HAS_NAMED_AS
 	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
 	depends on CC_IS_GCC
 
+#
+# -fsanitize=kernel-address (KASAN) and -fsanitize=thread (KCSAN)
+# are incompatible with named address spaces with GCC < 13.3
+# (see GCC PR sanitizer/111736 and also PR sanitizer/115172).
+#
+
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
-	def_bool CC_IS_GCC && GCC_VERSION >= 130300
+	def_bool y
+	depends on !(KASAN || KCSAN) || GCC_VERSION >= 130300
+	depends on !(UBSAN_BOOL && KASAN) || GCC_VERSION >= 140200
 
 config USE_X86_SEG_SUPPORT
-	def_bool y
-	depends on CC_HAS_NAMED_AS
-	#
-	# -fsanitize=kernel-address (KASAN) and -fsanitize=thread
-	# (KCSAN) are incompatible with named address spaces with
-	# GCC < 13.3 - see GCC PR sanitizer/111736.
-	#
-	depends on !(KASAN || KCSAN) || CC_HAS_NAMED_AS_FIXED_SANITIZERS
+	def_bool CC_HAS_NAMED_AS
+	depends on CC_HAS_NAMED_AS_FIXED_SANITIZERS
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
-- 
2.48.1


