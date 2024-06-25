Return-Path: <linux-kernel+bounces-229336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6A916E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390B11C22320
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850716F0E2;
	Tue, 25 Jun 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NcgtzPzc"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69311178CE2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334303; cv=none; b=hdqZ+JysCXFzJfOaxn6lctsRERSI65W898tLweWCJXwgkIK39WTh5dd0TXLYzmnhYB38Hg07Tquw+4nG4wB6v4+cCRd+TfReBJBtmXNzFJDNKiGdejlIsFE6H5rnZbXnb7CN1F3dvQ4cwaFUm9Zo2fhqxOwNPsQxsLSsPnT0A68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334303; c=relaxed/simple;
	bh=JHooToYsubKhRvNYLyZ7cftbBIY9huG4AQKTlNX8LnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWNkVAwQs2y2YEWACExGl7MNUIyl9FcnIP/8nNJYkdQzav7MWgxHzhlCqoArTcPJk/3OMsayIdJp8Pqsu0SQpRWhSREJmElIsecmC+EAlOFhXOYW+n1zJMEmy/Qv9bSC/dC1kkJccCJUga7QYZdBU7FEUgECEzz/hRgtRWGXMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NcgtzPzc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c722e54db8so4443795a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719334301; x=1719939101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZXJtegesCoNWeLT3fyH7pcXdAcWRPzbJ/UkKvHn+vg=;
        b=NcgtzPzcLXPncsQrCTVurf6tKWX7sBZi8D0ggl45wrO9A9fbTB6i+5mEHYkhicjC7F
         AuXCdaY7U39UqxLBIbcqbl6WLgtF9dyqcymjMVjVCD1RhD0P8uRnIYOWzQ6w43gSzoPv
         iLFIzUkomlPcGWbeemejH8XUW4CbfXsYI7pi0FkdGGTjE1kFzBOObZX0ihgVstfQM+Ft
         X0gnx2i/a2hleTqMQDYC92gUsCmjXhxJ5NEjVJoNBWcCGWQurLz6DodP7FnpmlBMeYQd
         hvhP+Ut2f5MnUpeJRcWOxZFOfqyqpmeFcxwPokdym/1+KzPvtuORCELDVHdXBXMAYC77
         WK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334301; x=1719939101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZXJtegesCoNWeLT3fyH7pcXdAcWRPzbJ/UkKvHn+vg=;
        b=p1wm0iAVdtjo+SkShUP/YwYl83na4hYVX1Av7mo/rXA72jMv7ie/vQPwDQMZdaFZfb
         +FoUhVuNxpb20Ecv08I8WeTEvJV4sZE/PH4rCtMhCywuFvIIJ9jUqohtAQ5CR3y7Qgcx
         kVx1p0I1DwjypdhTsIhn82+Ur5MdRHkqonAI3A2KmG2B/gqJqcaZViX1cDxS4xGX1NpA
         U9kB1EusjVXJs9RtLAqlwe17QB7mre2Fv8HDtQRWEtcNEsV9QL22miE6dlmm5rAaAKsM
         dvE/2eOj8UEmaR1EbQmI7cYl6vq+stFL1GV2Xdsw69Mj+3Qon9RMh0JwWiMsiAq8yvhR
         FbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+CmhTgMZAYR6JaPmpE7BYA3JnOBl1IElu36EXnGuDpPHKv+DaedNSLjsuWSaNJSboxgNhiY2be/js91TA9SCGNZU5T1B7H1xOgE6o
X-Gm-Message-State: AOJu0YyepZg1q/4FZ630dW9ZOBoxjw45tWdS0s0oGy5tSzrvuO9DExvB
	bit42ohSUjOOOc+qYvaLwMBxCy1szyZRRYoOm5tk17HU9uvO/V/uNmLhyoNBSsw=
X-Google-Smtp-Source: AGHT+IFgmAX/NR/Rny+7cxUhqpzJmnRfgk5/0YiE5Juy2IWGyJPjWd26T9/Jdru1Y0LXwKSKowzy4A==
X-Received: by 2002:a17:90a:de86:b0:2c7:af97:ccfa with SMTP id 98e67ed59e1d1-2c861297f4dmr7174509a91.10.1719334300631;
        Tue, 25 Jun 2024 09:51:40 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a623a3sm8991226a91.5.2024.06.25.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:51:40 -0700 (PDT)
From: Evan Green <evan@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Yangyu Chen <cyy@cyyself.name>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] RISC-V: hwprobe: Add MISALIGNED_PERF key
Date: Tue, 25 Jun 2024 09:51:20 -0700
Message-Id: <20240625165121.2160354-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165121.2160354-1-evan@rivosinc.com>
References: <20240625165121.2160354-1-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
hwprobe_key_is_bitmask(), when in reality it was an enum value. This
causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
since SLOW, FAST, and EMULATED have values whose bits overlap with
each other. If the caller asked for the set of CPUs that was SLOW or
EMULATED, the returned set would also include CPUs that were FAST.

Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
returns the same values in response to a direct query (with no flags),
but is properly handled as an enumerated value. As a result, SLOW,
FAST, and EMULATED are all correctly treated as distinct values under
the new key when queried with the WHICH_CPUS flag.

Leave the old key in place to avoid disturbing applications which may
have already come to rely on the key, with or without its broken
behavior with respect to the WHICH_CPUS flag.

Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

---

Changes in v2:
 - Clarified the distinction of slow and fast refers to misaligned word
   accesses. Previously it just said misaligned accesses, leaving it
   ambiguous as to which type of access was measured.
 - Removed shifts in values (Andrew)
 - Renamed key to RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF (Palmer)

 Documentation/arch/riscv/hwprobe.rst  | 17 +++++++++++------
 arch/riscv/include/asm/hwprobe.h      |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 13 +++++++------
 arch/riscv/kernel/sys_hwprobe.c       |  1 +
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index fc015b452ebf..c9f570b1ab60 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -207,8 +207,13 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZVE64D`: The Vector sub-extension Zve64d is
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.
 
-* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
-  information about the selected set of processors.
+* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
+     :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
+     mistakenly classified as a bitmask rather than a value.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`: An enum value describing
+  the performance of misaligned scalar word accesses on the selected set of
+  processors.
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
     accesses is unknown.
@@ -217,12 +222,12 @@ The following keys are defined:
     emulated via software, either in or below the kernel.  These accesses are
     always extremely slow.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are slower
-    than equivalent byte accesses.  Misaligned accesses may be supported
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned word accesses are
+    slower than equivalent byte accesses.  Misaligned accesses may be supported
     directly in hardware, or trapped and emulated by software.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are faster
-    than equivalent byte accesses.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned word accesses are
+    faster than equivalent byte accesses.
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
     not supported at all and will generate a misaligned address fault.
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..150a9877b0af 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 6
+#define RISCV_HWPROBE_MAX_KEY 7
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 7b95fadbea2a..22073533cea8 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -66,13 +66,14 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
 #define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
-#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
-#define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
-#define		RISCV_HWPROBE_MISALIGNED_SLOW		(2 << 0)
-#define		RISCV_HWPROBE_MISALIGNED_FAST		(3 << 0)
-#define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
-#define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	0
+#define		RISCV_HWPROBE_MISALIGNED_EMULATED	1
+#define		RISCV_HWPROBE_MISALIGNED_SLOW		2
+#define		RISCV_HWPROBE_MISALIGNED_FAST		3
+#define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	4
+#define		RISCV_HWPROBE_MISALIGNED_MASK		7
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF	7
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 83fcc939df67..991ceba67717 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -217,6 +217,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		break;
 
 	case RISCV_HWPROBE_KEY_CPUPERF_0:
+	case RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF:
 		pair->value = hwprobe_misaligned(cpus);
 		break;
 
-- 
2.34.1


