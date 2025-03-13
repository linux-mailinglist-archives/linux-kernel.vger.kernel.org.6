Return-Path: <linux-kernel+bounces-558637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C10A5E8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9695D3B872F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C528F4;
	Thu, 13 Mar 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkHn3aH3"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153C17E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824395; cv=none; b=IuTwJDI40eveBEr7/MnOuNYu6LiyUtGh46uXZ+sO636DgLhFEn6a/ezvjsrtVnHLHxPt7B+AlAqnuc1gjNncJ00POlnd5C5dNC0hLqZYPUuQxwcf0gnx6MxT3ar/qbj/FZgOV9ErYq/ilU7LPakUWgHT1GpsAaXm36AfSTiu/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824395; c=relaxed/simple;
	bh=23GDT0Rk8r3jrPpap9e9b1IjBBxLwjDYfdQD/VF0D2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbwp2T0ZG9tjuMaZEBUh552RCW8dAiwyp95tRh8Jp21izuiOzSafDXklHX45gy5pH0O1qVrWfp/XshU0ev+Ylqe/j6YwvgUfWUPM16mjp9UJALEkYjuTN9BSRajgWjIyp6T8SHY407rK/jt1aTxikASAJc5eB+93m+UyZCCifXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mkHn3aH3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so52046a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741824392; x=1742429192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTBXSAZcTlB0kyn5reMeVRSItQEZmzd639cfqrTnQ5g=;
        b=mkHn3aH3M2uC5/LU/AWh63mq41v8aULFRTIVrLUTUEToY/ze5BbQ9FEDQoMBFHjpUZ
         rEep7UJNXq4Jx7VpmKxPxw4HsWZrl59n1gicz4mdWuprgLTsib/L+0UOpTlSMj9j3onY
         FpYkUdId5fIiIbe4o/QUG91/C39BRcSazrFH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741824392; x=1742429192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTBXSAZcTlB0kyn5reMeVRSItQEZmzd639cfqrTnQ5g=;
        b=WNXKe/vUAiWVq0fKloh/9qYLh6vzRR6YRwYoe/qGPBE63Zl8H40gqF9PNuWm4TLEiQ
         ZbEFE/M8hNdJM0clFIljkS4EGiZjquED26t6ilciSDk4/Td+Lp7EXylzupA6Dmg1cpP7
         1jbtzbvWC6wzvQ/zi42q61LOpRpu/+4Flm9VdbDkHhVCczUu6lxAPvsU269RqquV7Fas
         0ukngF9/C6RvrLZyxITgXzfFaJ+R1QPCfVDr2gAtW/XHRJ+2FGexDFlOFaLoIeXlxoAn
         uyzN6ZzBHMekJbZV4ItlsNgXDGPp9A2AiPQ8+vx7dTFm6fNPFFz/gMDOYqgRmCZRo5YS
         g8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXGpddDNhz+kG+t0VR7Yf8f/FzRCfoA0yCggav3SeeA74+hR82B1IWWMvK+2iclKrdZCSWZ/wK03BYhgSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxJvYCFBx0sLLg25A30+ceDFB0tHTlVg9oszbGrurH1H+ZT+z
	njAEjK+8wQPtuXPpop2vZkoX98BLPPO8n369UAsPxlVTRU0Gp9QRvRwRZe1/tA==
X-Gm-Gg: ASbGncuXaod04+sf6k5FgGsSWJv/W6Epe5S19Xbyem/D91WlFDLtncOs4d4XKa7D1Ig
	DM8K0NomHrwtB5Q+AmV4iQmF751CwLVOpAYL041DaHT0xIVq6hXIOpoGZXccSviHnOWE5UElnDF
	RMjoBrdBPkVc8FG9LoaKkUtu1/CiBff2zVzfrCNvUTkgy2NTc3vGEzyt1MOYf0LDuObiy0Y2cBE
	J73ZSqLpaV0AFZKEBP5QAM7pkXRcJ14umDFo2s6V333igUqRhe+4uXMnz6K4JGc/Am2lsgJvfk3
	uEZkvZZFJ9JBvoBRGMtcjKwEWirWFFyMN59IuafMxDSNTFSRNroKr6aaXYPcMNiom1aV/22cJPu
	d
X-Google-Smtp-Source: AGHT+IF2hsLGbRFexw4cBQVMbT4+nYhN0RM3ql6SWU6N3Q/kqXvpffne9qXzzhEiJHBV/0VVycU7Sw==
X-Received: by 2002:a17:907:3e8f:b0:abf:7a26:c489 with SMTP id a640c23a62f3a-ac2b9ea164cmr368075466b.9.1741824391899;
        Wed, 12 Mar 2025 17:06:31 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3fc7asm7404766b.135.2025.03.12.17.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:06:31 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org,
	akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de
Subject: [PATCH] mseal sysmap: add arch-support txt
Date: Thu, 13 Mar 2025 00:06:23 +0000
Message-ID: <20250313000623.3192896-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
new file mode 100644
index 000000000000..8db637254de9
--- /dev/null
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -0,0 +1,30 @@
+#
+# Feature name:          mseal-system-mappings
+#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+#         description:   arch supports mseal system mappings
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: |  N/A |
+    |       arm64: |  ok  |
+    |        csky: | TODO |
+    |     hexagon: | TODO |
+    |   loongarch: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


