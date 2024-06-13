Return-Path: <linux-kernel+bounces-212716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C4906538
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B492899F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541813C8F2;
	Thu, 13 Jun 2024 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SzAw/VIh"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5AF13D285
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263986; cv=none; b=eZUoDLhHUI8XbU79FHmS2FBrmQf4PZvlIMPmZQT+v5OQu0NQ9PAwh/JIUByjAzG1TWf5bmVJS5VS8hW5GmsiEH4FCBTOGr6fVKWY1JuqDadoM1bCA5o/OOvFegM4uHP4IbRK3qRRmh3Empj4eIfvSb9EHUS7zSGFQievV2lYSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263986; c=relaxed/simple;
	bh=SouKpCcGuPU35PuUtIVf4fx8/4KFcZyhXdY05tRopyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2c0LSU34eK7ek6ZlnF/7HPho7O7QAMAft4K8XfYtEraLTseJYbdjdGwOul4piHKKL4EUN5eXTD0xQhiMw3ZxsJ4RuLyX4gRwaITAd9y8MjygPNpN1R9l+s0/tGUOie/+Mebfz0pcHVZ+SJfCn55jSj+FQb7CPakxaRERs6I2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SzAw/VIh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d227b1f4f0so332945b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263984; x=1718868784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBQdisfSIcfLCxaUXLlDTwMoYdzfD8LhoeZl0/Tj/fA=;
        b=SzAw/VIhC4REKBJ25UHy2FmqHs22MQouk4M6ydVgr0GxqXQse27QzsYNXGavBehRpz
         1NfVjDQQDqSG4QnUBbU36L9kJHu3hyqAXJQoF3+f0dzFXDb+6uDulxdBrb0mhDIPVIa2
         pFcmLnD0Ttfc+/+NF12SO/MV4iElDkZkQfn/iYUGVtiYXPB2gH8G27tMmz/iB4P6YHp0
         aEH02aL8OjI1KJwB7H1m1rqAuPxHZDYbEPzKVptmGwq8uHbLAcNEcIdsXR1snexZRtiM
         8t0whC4n9dKfOoAKBe9QGUuv/1uWefl4Ul8VL4NTwxs2i+w+IRUwPUVceqzRBE1SaIby
         FVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263984; x=1718868784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBQdisfSIcfLCxaUXLlDTwMoYdzfD8LhoeZl0/Tj/fA=;
        b=LYuQPPeTMCdFUim3JQiPxk5GzD60Y+1N0+bLqcqzhKeQFNZtYMdFvBtSrDBsQBdvyD
         RQwLIdXhO2gDlwR0Bue8OLYceYggsj2leO10ZZcIs06LY5jgMhDc1MJKca8UJdwUtwvP
         I09cWpA4cDZ74ufMleCE7obEfRlZIG1qRtvuhA42oOluMYiLoYc2BkiNx4dL0VSgBkeP
         mx+H7KKQtNWfIY+UlzfJSoccptNxRfBIvxRRto5tQqwqYrS2Qmfq6QWbfwccVd/tHvq4
         xTrlovFmmLjglsXMdbngBzlIPxpJYRWVVTlpthtyNmg6qeigihVKxhBE25ot85Y4vQCz
         WpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnk3qXiBOMCyNHHHBWYLSSyBYaBiccX5TA2LVkWT5622yD5ybkmtTzsl6i0Pxp1XAu0Wx4R9XxJD3NJfBu18sLAi6Ynr762AmjQI3S
X-Gm-Message-State: AOJu0YwTENk85oKRGc8a3nxUIS8dsWevpo5h5vu8WeJdReLmSdmoElvZ
	n6s/ZsmXmQ+QkfQVosEKtpArRvdobIWg7PLCvyTgdluqd9nW3Ufijm+hxRh5igY=
X-Google-Smtp-Source: AGHT+IHI/57UF4ERYhNsT8IgBFHVZFnNkvkL7rNY4vjoxvdn096FWUD3qDYx3RYqModhDDSYikhCvg==
X-Received: by 2002:a05:6870:4412:b0:254:6eb5:ab2f with SMTP id 586e51a60fabf-25514afc016mr4471125fac.6.1718263983791;
        Thu, 13 Jun 2024 00:33:03 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:33:03 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:11 +0800
Subject: [PATCH 6/8] riscv: ftrace: do not use stop_machine to update code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-6-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

Now it is safe to remove dependency from stop_machine() for us to patch
code in ftrace.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/kernel/ftrace.c | 53 ++++------------------------------------------
 1 file changed, 4 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f3b09f2d3ecc..9a421e151b1d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -13,23 +13,13 @@
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
+void arch_ftrace_update_code(int command)
 {
 	mutex_lock(&text_mutex);
-
-	/*
-	 * The code sequences we use for ftrace can't be patched while the
-	 * kernel is running, so we need to use stop_machine() to modify them
-	 * for now.  This doesn't play nice with text_mutex, we use this flag
-	 * to elide the check.
-	 */
-	riscv_patch_in_stop_machine = true;
-}
-
-void ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
-{
-	riscv_patch_in_stop_machine = false;
+	command |= FTRACE_MAY_SLEEP;
+	ftrace_modify_all_code(command);
 	mutex_unlock(&text_mutex);
+	flush_icache_all();
 }
 
 static int ftrace_check_current_call(unsigned long hook_pos,
@@ -158,41 +148,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
 }
 
-struct ftrace_modify_param {
-	int command;
-	atomic_t cpu_count;
-};
-
-static int __ftrace_modify_code(void *data)
-{
-	struct ftrace_modify_param *param = data;
-
-	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
-		ftrace_modify_all_code(param->command);
-		/*
-		 * Make sure the patching store is effective *before* we
-		 * increment the counter which releases all waiting CPUs
-		 * by using the release variant of atomic increment. The
-		 * release pairs with the call to local_flush_icache_all()
-		 * on the waiting CPU.
-		 */
-		atomic_inc_return_release(&param->cpu_count);
-	} else {
-		while (atomic_read(&param->cpu_count) <= num_online_cpus())
-			cpu_relax();
-	}
-
-	local_flush_icache_all();
-
-	return 0;
-}
-
-void arch_ftrace_update_code(int command)
-{
-	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
-
-	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
-}
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS

-- 
2.43.0


