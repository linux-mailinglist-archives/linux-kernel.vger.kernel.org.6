Return-Path: <linux-kernel+bounces-530420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF636A4333B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949BD7A57E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665FC14A627;
	Tue, 25 Feb 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nBZjsb2p"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A0199B9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451357; cv=none; b=kOkJ+HbMK4MSHFo1eJugWI6QlYZ+4tcejDfy3Hy2GMSKXUvuhaGJwGi+UNoncJ1+u9nE8Zob6Ro7uynlMfoCfzJt1qC9fFEGimLiZ0/1gjb+KiDWT9efZxc8G8pJjdb4AQY37KI5kfTz2dwpPoTkKLEi1kFjYvj1bQNyV7ttKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451357; c=relaxed/simple;
	bh=W8bVT3KdKXtHJWTSCayGdVWSdCOptjFaSdECSOxAXbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oT+JyW1z35qkOvSb6CcvULloMks1kFJGzsWqNiutpMn+CV0t3A292FVUp9/enSuUd2OU+1EiSzz7ejQVNQQR7nK17M3Ahx4pPragY6BwKkADf5L6RV7tTt+Wp8UUEDK1zvlhIHb+xB4bBHYITquHdXEHr/dbgUDiQ0jLcqaFlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nBZjsb2p; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so7922178a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740451355; x=1741056155; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZanNtGerLw/d8sQjxfza/brPslbbPWAc0F+e/+SVZc=;
        b=nBZjsb2p64lSHV3UQfHh8/HkbMUTV3vN+/Y/kzx1VGutq9pBRMQpRddKp+x+GeyIf+
         kcnVYe1yCGIiaE0aYLwrPZuG/VjJHp3U4wKXCjdudwRZO4fXlnRNy0iaySpnXFh7F+FR
         4sdWM5mJY8JBfVb5/MNAGaamtHocF8VXhVPViJH+nc36Y/w/E83/5FgNp9lukIPTLpa1
         IsUxIEwbScXz6s98iGm+OaE3iIMW5xKhwovUpRmlFGf17qS7wypvTefZA/RdmTRUou+7
         SpUTL3+ZInn8AofNYDrjgayDaGbMZU7ovlgD8u8JeuDYRW/OqHgEf/OjMZ8wUcQMc2k4
         D6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740451355; x=1741056155;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZanNtGerLw/d8sQjxfza/brPslbbPWAc0F+e/+SVZc=;
        b=PWnwcU2BFQpgaPqqYgilrIxx5XiH/ThDxQuoH0HaBQNPgj9a4vj+r21W29o+lRliNC
         ZH9wN0weKFKY/VaxVCrc3eSJbuCdfwPdEXAY/RuC3YBzQ6o2lHLrcb0MSYM6+74tVbXH
         SvwG2uKh0teuSAL6JNaJrjE5kpIShswsbVquNp4DLLv6iCdmR+WpdejKMtywJ6hvHYhk
         c3ezESVlFDHbhQ+JhbhwnrGmmB7lviDPM76AcJoopHjKgRs+LonsYqqEdqP6LaqO5lVC
         3CQJtiUv7UpUdrUwqV17QxRKBsxEmyYtCyV1gHkpTeOwuonuqiK7xLS3ahP7YOxfuArU
         Xf+g==
X-Gm-Message-State: AOJu0YyLjQqUueyo7USdQVpH3s97XMBDXMlMz5oDO9A0JehHPz3ThMm0
	0+XkON8s55nMGYKG6kC+/hqbuhHl+t39H5QOEwdEYXSyZ823I0TK9qk1Y+YOYV0=
X-Gm-Gg: ASbGncsxde/Ygaj2h+RaopaZTO1UXdPUZm12F/FAdgmlqAUD9UECs2m9iHD+WhC1eVJ
	wub3rsgowbpPFZ68bkVqunY8NxT8bO1LKJX4BjOYCu5NcUzatTkbBNDJxKU8Z71bK9ETL/u08JI
	BLIWQoTWwEoyzq0DmWmKP5WTFDtkYiqqBqCF6xX6SXtQVJmkKxjXhtg+5j0rI+X6aRvaCQVSTPp
	f35GL4rlxy8Sd0yjlfGJ+sOxtElEl5lnmGa5Hv5v8SW/zlszLHS46LThmpLugGQu1OOVFJG8FHE
	XCV6DW25uHOq1JJ891UsnQmR2Lx0CBp8w/H66B9e+w==
X-Google-Smtp-Source: AGHT+IH9Mpxjv6YP2dwaBxfmSmdJtkTNXmqQrMZT7HWbkyf1jCK+dNT3UgG+ZQDzaPqR9bpDWYMqpQ==
X-Received: by 2002:a17:90b:56ce:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-2fe68ac9543mr2456297a91.1.1740451355356;
        Mon, 24 Feb 2025 18:42:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a09d819sm3163885ad.163.2025.02.24.18.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:42:34 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 24 Feb 2025 18:42:21 -0800
Subject: [PATCH] riscv: tracing: Fix __write_overflow_field in
 ftrace_partial_regs()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAAwuvWcC/x2MUQqAIBAFrxL7nWBSBF0lQpZ81kJUrBFBePekz
 4GZeSlBBYmG6iXFLUmOvUBTVzSvvC8wEgqTs66zzrUmyuPjpTzDn6yX8OYVSzIIgWPLPToEKvW
 pKOp/HqecP9rKXD9pAAAA
X-Change-ID: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=W8bVT3KdKXtHJWTSCayGdVWSdCOptjFaSdECSOxAXbo=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/pePaFXX7s2bp3zKU+I8VTyye6Hcs5ZQW55OV0N6vaia
 hpWz592lLIwiHExyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBFnD0aGFYa+ihbXIxac9TD4
 9vNykqqDfbtqVTSP5KIzEwJEHk4QZ/hnnpNy6V9D9YeoQjaz4m0ray4lp765IDFlloPj0tglt+y
 5AQ==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The size of &regs->a0 is unknown, causing the error:

../include/linux/fortify-string.h:571:25: warning: call to
'__write_overflow_field' declared with attribute warning: detected write
beyond size of field (1st parameter); maybe use struct_group()?
[-Wattribute-warning]

Fix this by wrapping the required registers in pt_regs with
struct_group() and reference the group when doing the offending
memcpy().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/ftrace.h |  2 +-
 arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..ec6db1162021fbf4fa48fc87e7984266040aa7d9 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 {
 	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
 
-	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
+	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
 	regs->epc = afregs->epc;
 	regs->ra = afregs->ra;
 	regs->sp = afregs->sp;
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c18e15c156de11172a5d7f03ada037..2910231977cb71dac3cc42f2dc32590284204057 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -23,14 +23,16 @@ struct pt_regs {
 	unsigned long t2;
 	unsigned long s0;
 	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
+	struct_group(a_regs,
+		unsigned long a0;
+		unsigned long a1;
+		unsigned long a2;
+		unsigned long a3;
+		unsigned long a4;
+		unsigned long a5;
+		unsigned long a6;
+		unsigned long a7;
+	);
 	unsigned long s2;
 	unsigned long s3;
 	unsigned long s4;

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
-- 
- Charlie


