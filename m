Return-Path: <linux-kernel+bounces-203050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68F8FD598
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB601C24F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1013B28F;
	Wed,  5 Jun 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMnWXaOi"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEB3A1BA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611286; cv=none; b=Hxt6QRwoKX3Z8oJUtus7laL5DtGVe4s3KBDCji36rA9qznXFrptZ4c5bvjdk9Mbtzo7iGru5Q1Qfu/kOzk1Y+X8MLXYOhRuw2IXfpWD/Vww4bf7hP6i6G+0IR0KZ6B14OXpP910qnhsJO0+6/UZr9U2iJEzuiTYh/H9Zgqmgxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611286; c=relaxed/simple;
	bh=5QY5pCKyodXCSWYUDdOpsPjnRNF7cN6ofBZZxKuLfzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi58wQ0WG44PAhFxfn0HUdy3ksAGhOZYkbe3lL+9zFFcH66kqOd19p8G4hmRqfPjw58/SQfEju04zeadZmumkAX9IPwFqrEpkSmslC0zbDM935IUjZaodr3UUxDjlPmqoxc59He/0wzKN/ZVy9GnABp0v9EzOrfXWIgz0n5wFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMnWXaOi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so127355a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717611283; x=1718216083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLHG6dPtj3Cex6vJDN4EiASkGZtmU8H4G5lGm1pnEKs=;
        b=eMnWXaOiMrPCO9Iq7AOhWt3Gr2p9IkVIf0cIiYsFm3B+QsPx+8ZWcAqw27DcwFUF4K
         915+uioQbQn7H3Tlc8Ifrk+Vr7JjhsnLxEGZ7rkdfrTgvdM63bMj564gShy+1Cu0X081
         WZJNWWAUNjYd3/BpX2NQUgEEgmZTqHWQYBaHBwctbIOmYSioJcapQGclVs7DMt3Li7yK
         Huky3tDHD4UjOXF4B+8EWVyCu180KZG6kHAswxoH9wwwYRoMkObAhbLMDOYo+rl4MIPS
         Tx0BLexr1qjp0Gv8sjM77lEoJxOn5r4CO6SzuhflFnRHY/eaVL6yDcUOqHDPrTfvAmQP
         FV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611283; x=1718216083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLHG6dPtj3Cex6vJDN4EiASkGZtmU8H4G5lGm1pnEKs=;
        b=QkauCR/DlzqhjkPjv91/4Gsla8wuEvQRQIwO2FVZSMHMnlHJgK1U9HyFULIRwQjH4O
         SrAw9OMZMtoPBw06WnOlWHNdhKG6qIJOWL3J2XPwPzVs+XAU988zCAVx6CeWOe5W+8py
         0nzd6C03/3Z+/fpvMHLw3mFYnJiZ+BpQXTfTJdZ5j6nuODryQVCfMBwvR2rqAIVMZFmu
         dKoknMXF6I5LAqTclC14iVgVbfwT5XVqw5LRGpaNhxpOTngcD2VnZc1IJYg4v9cKQJxV
         dbC6N8p2003CFS63qGnTvgLi0yRCy7L6lpk36eGRwApZgr1xUGCAWtuUM6fSqz3vgwoI
         KYnw==
X-Forwarded-Encrypted: i=1; AJvYcCUUExeB1vFhsaWFOHFWJQpHZaMkGsltIonG1Z8ppUWMMWMNL2awn/GwcpS2FodNvrgB4uEeLRpFGQ/xtjJMxcuGp5979xXESQIAMf/k
X-Gm-Message-State: AOJu0YwfHGmt+8xWKKCCN2Pddtax2gFQ6Sqjabh95Yi0uv9OlkHEjiGJ
	cy2pIOk5xbfqNCNcF2IYEQ9gLQw4H3TiIb/cETmlm1nNs8ziz2qX
X-Google-Smtp-Source: AGHT+IGVVINLDZYUIOh+utafT1srdWnNvqtOZx4SMWvhHPPhcUvUZy8qs/WiL/TVwhUzu8G0CmPmKw==
X-Received: by 2002:a50:a6d5:0:b0:575:954:7ef with SMTP id 4fb4d7f45d1cf-57a8b6740f4mr2629050a12.3.1717611283297;
        Wed, 05 Jun 2024 11:14:43 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5b1f9855sm6976233a12.70.2024.06.05.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 11:14:41 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND -tip 2/2] locking/atomic/x86: Redeclare x86_32 arch_atomic64_{add,sub}() as void
Date: Wed,  5 Jun 2024 20:13:16 +0200
Message-ID: <20240605181424.3228-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240605181424.3228-1-ubizjak@gmail.com>
References: <20240605181424.3228-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the return type of x86_32 arch_atomic64_add() and
arch_atomic64_sub() functions to void and remove redundant return.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/atomic64_32.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 8db2ec4d6cda..1f650b4dde50 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -163,20 +163,18 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
 
-static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
 			       ASM_NO_INPUT_CLOBBER("memory"));
-	return i;
 }
 
-static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
 			       ASM_NO_INPUT_CLOBBER("memory"));
-	return i;
 }
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
-- 
2.42.0


