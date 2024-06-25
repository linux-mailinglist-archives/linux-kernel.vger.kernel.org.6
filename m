Return-Path: <linux-kernel+bounces-228275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC4915D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92E41C2133F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9799612FB2A;
	Tue, 25 Jun 2024 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu6Sm5jN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B213C818
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289147; cv=none; b=rQDj4Ql8AWEqJu632fFDUPKwXuyk2sm1FhXyMulFN3hDVCxwe68BLgJkmqFKw21Zec6MuHtIX3IsrgE8c8Ccwj61q7oJz+9TTg/v64WbpsvEN4IfVITSg76A79ZCEzv2+xR+eo1R6c1XxwatsNRLtGwxeRf+TEwzQdL62DN5weQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289147; c=relaxed/simple;
	bh=5yvcxNr6EfINb4k2kkXt3e0AscGuviAUNxRV+wtNX/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs05gRPEizs5fitr/kiJ6W6eA31j8jGUkQ9QVEwglAAX83vajB+naV6E4jYr45TBib282RBet9jV/JlWcf3Tk+1193+d9YErANafyaUWn1beVqqjQJr19gOi8tQiIPqDZf2aCWEECnk82DSTfdrcERzQuc2WBfEWbMFDSTatRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu6Sm5jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CA0C32782;
	Tue, 25 Jun 2024 04:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719289147;
	bh=5yvcxNr6EfINb4k2kkXt3e0AscGuviAUNxRV+wtNX/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eu6Sm5jN/GREE9cN89U6psq/7I6UTjd+7K5yuIXCah5xsRCY4Jzc1sgpuy+gZg/Tl
	 D0Fg4puDPNIvbaxKpBL7P2kZiY8DzFjkoORnOG0bu2aM7SYN1JN8pt7C0bVIbMyln9
	 Nk4ne511q7i2gFgMk1P6oWyYE5V4irQ0y5Oo+YEdRESU0a332PRtOxAyisQCUlEcpF
	 fZvP9vUyacrjE+JMbkNURcLS2nywajgO+0G8Mrz83J2AnRH2yvLnJXBN/H3wJywTGR
	 I7aJ7npC+h7vEDo6/X25OXD4Qpu8ylwbhel0ynvjMHcC2BUbv2Qqn5S/Etl/wA/k+b
	 QKfb8pDED4tLw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of __put_user
Date: Tue, 25 Jun 2024 12:04:58 +0800
Message-ID: <20240625040500.1788-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625040500.1788-1-jszhang@kernel.org>
References: <20240625040500.1788-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I believe the output constraints "=m" is not necessary, because
the instruction itself is "write", we don't need the compiler
to "write" for us. So tell compiler we read from memory instead
of writing.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/uaccess.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 09d4ca37522c..84b084e388a7 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -186,11 +186,11 @@ do {								\
 	__typeof__(*(ptr)) __x = x;				\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
-		"	" insn " %z2, %1\n"			\
+		"	" insn " %z1, %2\n"			\
 		"2:\n"						\
 		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)		\
-		: "+r" (err), "=m" (*(ptr))			\
-		: "rJ" (__x));					\
+		: "+r" (err)			\
+		: "rJ" (__x), "m"(*(ptr)));					\
 } while (0)
 
 #ifdef CONFIG_64BIT
@@ -203,16 +203,16 @@ do {								\
 	u64 __x = (__typeof__((x)-(x)))(x);			\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
-		"	sw %z3, %1\n"				\
+		"	sw %z1, %3\n"				\
 		"2:\n"						\
-		"	sw %z4, %2\n"				\
+		"	sw %z2, %4\n"				\
 		"3:\n"						\
 		_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %0)		\
 		_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %0)		\
-		: "+r" (err),					\
-			"=m" (__ptr[__LSW]),			\
-			"=m" (__ptr[__MSW])			\
-		: "rJ" (__x), "rJ" (__x >> 32));		\
+		: "+r" (err)					\
+		: "rJ" (__x), "rJ" (__x >> 32),			\
+			"m" (__ptr[__LSW]),			\
+			"m" (__ptr[__MSW]));			\
 } while (0)
 #endif /* CONFIG_64BIT */
 
-- 
2.43.0


