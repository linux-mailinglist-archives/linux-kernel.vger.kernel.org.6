Return-Path: <linux-kernel+bounces-554499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E257A598DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387EE18887FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB74C23C8C9;
	Mon, 10 Mar 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="02fXvqYm"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81D23BD14
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618409; cv=none; b=fos7bG3oh16tCng9epvZ58nx7eKrQJ0VcUgwRPPG0oZGZRh0OmA0Md56FSksWHIu/pmZWJX/Mm8Dxh/Ca8MJmxpQGd9tmDwpsr4WoNRIYkf1ri1zhWVcPeqKEH8JhZ9Wj23f3HlExh8YRfXDgOVRsuxMlSJEbQD3ZC3GJxdOfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618409; c=relaxed/simple;
	bh=zWvCMjEUr0fm2YGOtkO5JQMRJ3MfHFejTQpY2YYRpeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqtZ8GacdZlgs5oVGUYnCutQlf5lWny/Faxr58xO+gycVnZj+YdUgFgoQ6Wd/ZDR/tlmvEiw0QeOADvyXkJ4zcJQJdePt7PlUkW5Y20DJs/NdJFZ3LLYv7oP3IOp1y3eEfGdnDEvh6rgG//peOSMtZTRVEktQk/xsgFIhfAcZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=02fXvqYm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2254e0b4b79so11056135ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618406; x=1742223206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opxHamP1ejpgUrZttGLg4zwDHWHLF3xPs1/Qb/08WRM=;
        b=02fXvqYmI7IQzrMpZK7gWQgvRJrftC9vOY2QlY/CM8V2HigjhV+w/NhLxRTeEtYott
         S2q7kSjN72yJa5Ufr7WNsgAxBQaPRxaPtmQ14/lwF1on8E1MOrns3WfNwEZCQNFrYfxl
         GX52zg5xG6UIPsdCmuXWJna4/t0SmvTqPIp2e0KDF5gTKiAT1Amm+d7ScFnLCsHzXtGI
         FEyqvUmVtYaQI/Zb7K1ksG7qzmbIOSeCsvQqszo50mYTw1QzcKG9b/fXneMLRQWsQOnq
         bg32wUkKQoBy8zsP0AAuBeuiOmbpUWRyIMYciP3/LXXmnjAuZ1ZA/9PzQt0oY9ba4Agc
         5BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618406; x=1742223206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opxHamP1ejpgUrZttGLg4zwDHWHLF3xPs1/Qb/08WRM=;
        b=GFNOYQZBhkNDKKh7dmxhRTRvDFRl20FVJ51Dfm6x5BhNV17nJHmjeko9EsvcUOkngH
         gTec56HhRazjZ476zxJDhb891sAO8o5ArYzTc/28SpA9StWH9zCvLTqUQFiDyQ2hqOOY
         lDlNsNsOdQXJspHFkoJnkkMZUHMoCLgyoBeUeC/ZuQPbrjfljY9MAOqQyfaaeOiQOgF9
         LeBqHQpTwhvlB+19Gjw7CE85u/UD/AP5rr1NREsV2AnCqtPnEHHA2IKkjUokU/Jke5NI
         bw4kP//63PuOhFNG+AdjQXj+Oj1EF6vX5fS1TXPGRSpT5nqoVCzMUwcvUAq3M22JasDN
         DaYQ==
X-Gm-Message-State: AOJu0Yw0kndjLDvO6QP/FAOkFAj4vgyyv5QOZrN0S2189qq7st212r1d
	73i/SwPFLk3pmKggBWRqp5/48wWO+n7dXai2MfLVilgI5RxC3tXmq7qNDNyfrr0=
X-Gm-Gg: ASbGncuZ4n7nUoU9JDs8bsq5jiUiVHq6ZjrkcMGge1fa1qO/0WEmI6ZRkFjhgeI7iBs
	jgbJ2LJGLzAWV3K2VQjjjfskWeMyTkiKvTLTKFUTTgAZUoOYd2duemcceobTwY+iSKsDDvZWsye
	r92QR0Pz8aEyJg64Awoyu433SJBlR7lsNIysTkZv2eGCVqE0PoHzdm/929UnNVz3/mn68IqEYiG
	kfnxeg7xOfF7TFwBId4/ne9+3wS8nZOTDfP9+10gsF+EO19ekhI/y7NdxhVi2sN0lhZSqigmNcO
	NdXkgS/v24skYRFvrfKVSRLSM8pbrSKIfA36795h9EEnEP4UpoG0nPo=
X-Google-Smtp-Source: AGHT+IGghOp+j7sQ0Qt7sq7k8fXJkHLz3hwRxKC8iR81NfpyoYASRowQ1NRmeDSzKjKxRLkZDMtKZA==
X-Received: by 2002:a62:fb06:0:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-736baa02af4mr14991022b3a.20.1741618406530;
        Mon, 10 Mar 2025 07:53:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:44 -0700
Subject: [PATCH v11 22/27] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-22-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 6e561256bfaf..be08e5bb6e62 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+bool disable_riscv_usercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -390,6 +392,9 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_shadow_stack())
 		return -EINVAL;
 
@@ -469,6 +474,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_indirect_br_lp_instr())
 		return -EINVAL;
 
@@ -501,3 +509,16 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "true") == 0)
+		disable_riscv_usercfi = true;
+
+	pr_info("Setting riscv usercfi to be %s\n",
+		(disable_riscv_usercfi ? "disabled" : "enabled"));
+
+	return 1;
+}
+
+__setup("disable_riscv_usercfi=", setup_global_riscv_enable);

-- 
2.34.1


