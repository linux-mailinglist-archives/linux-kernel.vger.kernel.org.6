Return-Path: <linux-kernel+bounces-380500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755159AEFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3009B213F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6602003DF;
	Thu, 24 Oct 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fErzhPTT"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB516DC3C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794528; cv=none; b=sAvPb09Yv+jZbRZxyFjvlzkBeu7E8w6RTC3Il4PxjbiQo/ychV0wff1Kg3mkFkuyyMjsv3OymY958ZrHyMg8fzZBgGlNvmnjrlHl4mR1+PSaxPiPlqjRW/DFwaKc6dCf/UoegIjqto7Qxi80rKekoST36TFq9RWvmOc4f+3SPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794528; c=relaxed/simple;
	bh=sS7XEftG8NwIg0jvOsxy+xf/DVgTuOwDySgcJpjgz04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJKe2MsLV7ghJFTkPYGgYILEcCI6xkRJV/UpsZXH4pcYs/Cf5h0Dk09SQL24YQAB8qG6hidLFdwDRYnYKjceassHEV/OeYqsTHSNSX0+XfDhzFGzUqcQ7GMFtM/UwuXJZlr5HkYGfU54oj/xTbHulN3hNf73kei7tP/dfVLQ6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fErzhPTT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so1575027a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729794524; x=1730399324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnCw1JhVMlHCUGTY3kum+p0Q1aFqVM0KcNSrF8JwsPI=;
        b=fErzhPTTEV7GrUxe21x2OjQZ0yj0XipU04HxVp5ntveDFjHj1uB5+ADnH2O3XNzTZn
         zN85KnV2q2ndHI2xK3mvK4OaEeOcWsAVRaDNTtblDxp18ezWcMqMcuTRBdtGiAWkiUiZ
         VQbbJYOBmTELqzc4C0Ne5onPZflplJu5T+VJJ12KZ6oIw754Cc8jq54pj7MHcdLr/Iba
         alYa5bkwRk+627uYGrkNF7LdQ7inktT7BfXv+4pfBqYL1RNqLSu8pHil4FnFqLD7X6m9
         aURLaQL88LMSgZohKIWKqgF714a3Z9AcJ8KFB+7645oWibBny62rQCuoQCryGgw5rjsD
         4EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794524; x=1730399324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnCw1JhVMlHCUGTY3kum+p0Q1aFqVM0KcNSrF8JwsPI=;
        b=gutx1se+jbLcuY5wSNO5L5tsDjamPZdjtv5em4KCfoF2lCptWnYdmtPwIxo5C5rZYN
         0CdgeEXG/LBn0eCL/bOjnp3677lVLST2nqgpOSI9Bgqeuj1XMO3iVpG965VO+Vs2Aaep
         uW1drqF3BIr6dUFqlmLZzdNwIEo5zNXOeBDeKggjZmMoxrUX9EOxU3OL1QpOebBHvakX
         DFWD23mpVCCxOooZEFQnMWgEoRL3R8hyZpkhMUeTpdrJabPmVhX1n7pqAJgZGx13Xbdi
         VYWKK6tV9HIgqOIxyYmcgLAITrkyKhDWDj3RCyd58jVg3SKGA6JMmu1vD2ZpvmYZFWli
         wB1g==
X-Forwarded-Encrypted: i=1; AJvYcCVnFDFGtaf/BvadB37gjIL4dqZLwDtu2mnmytmsyOJx3NEggqdWcRmkNi+3+j5sLpqB0Z/ymjg7HEtus3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbccnua6gCUJim2GxpOrrXuSPLRv5hHxokC+OAEjzlsLRjtBP
	vZ1SRXBsqOxdE2UV7cL9bNxIiIRPI5/vdadDlJwBUwOv5Qfn6SoJ
X-Google-Smtp-Source: AGHT+IHnBqTl/xJxWBwJh5GwWwMP8akxVMRvgD6mDmqkERdk/KIJHipRL/gCf6Xy4s+Kt/6JJamoAw==
X-Received: by 2002:a05:6402:3586:b0:5ca:e4e:59e6 with SMTP id 4fb4d7f45d1cf-5cba249c5d9mr2237754a12.27.1729794524254;
        Thu, 24 Oct 2024 11:28:44 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c726besm5989669a12.93.2024.10.24.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:28:43 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
Date: Thu, 24 Oct 2024 20:28:14 +0200
Message-ID: <20241024182833.177994-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation on targets that define
atomic_inc_return() and to remove now unneeded initialization of
%eax/%edx register pair before the call toatomic64_inc_return().

On x86_32 the code improves from:

 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    31 d2                    xor    %edx,%edx
 1ba:    b8 01 00 00 00           mov    $0x1,%eax
 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
            1c0: R_386_PC32    atomic64_add_return_cx8
 1c4:    89 03                    mov    %eax,(%ebx)
 1c6:    89 53 04                 mov    %edx,0x4(%ebx)

to:

 1b0:    be 00 00 00 00           mov    $0x0,%esi
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
            1b9: R_386_PC32    atomic64_inc_return_cx8
 1bd:    89 03                    mov    %eax,(%ebx)
 1bf:    89 53 04                 mov    %edx,0x4(%ebx)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Mention specific code improvement on x86_32 target instead
    of register pressure issue
---
 arch/x86/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index e2fab3ceb09f..6290dd120f5e 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -144,7 +144,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * Update the sequence number to force a TSS update on return to
 	 * user mode.
 	 */
-	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+	iobm->sequence = atomic64_inc_return(&io_bitmap_sequence);
 
 	return 0;
 }
-- 
2.42.0


