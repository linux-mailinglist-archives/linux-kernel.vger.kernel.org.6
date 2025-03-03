Return-Path: <linux-kernel+bounces-542115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CAA4C5D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25C23A366A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264A2153E0;
	Mon,  3 Mar 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJUUd+kG"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4F214A80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017303; cv=none; b=hDNNSAonNE5zqfyMfkhGXBzaLDllnZsa1ybOn8zSYLObCiaae97qkOFAm/R0VOdCp5nq6pPW8rpRhw8Fuz9AfeGrnXUgwM44v0hfqzNlQ0IBQDa54nOoh4XTtLgVyvkX9CkLyV8/O/10PKFhKg37OUGSWP2+9f3YNxp9SS+MOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017303; c=relaxed/simple;
	bh=mnNLB7I5sDalzHU4V8h4SGja0TAbnVEkMaTHrnZbiRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/W7Zd+94hzQLrp7zWZhi6VKTshU8dHvhDfGk2TbtAxNT1p0Zehfui3Utt478Ofkq0SZGb/HQsgLAc3i6sedThQgqDd6ygwhefwZHM3zSavRI/PWoNeEzk4/PcU0RmurXHjO/dfLSZwpv3lAviOfqgJMpU7xq2oAUdF5+kYKr8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJUUd+kG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf48293ad0so393351766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017300; x=1741622100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Itm0RlrEJvKzJ5rofiS189RhCysslt28SK8Oygz0VI=;
        b=cJUUd+kGt2BXb2WVrUl22VYErn1NNZBknITYnfW80OnRp97ust2PsB1IT7vVpP3Shd
         Ou06YtuKFn2AQlw0iRfdFsOb4hNsNfuxMNZSpznOWqrdMtWS791o5eg/OFtxQ18OrvGD
         yQxbITHtW3fLOeoEm+mXAo/hnJ5a2mzoeq65vuLsT11Qgt6U5gMj7R5q5dENscq2mWer
         wdtxtjO/1GBdAvxVyK6gJFNQQNwUhXctmU9gJAwVdZKexnvKHZ+VbCupF6FtzjmmZgRW
         J0P4SSgdstt/w6VkD2B7WrpuYRISNuIkAkkeu1bAP7nAL2iHq8DB+imuaUZzYfPvqweY
         m4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017300; x=1741622100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Itm0RlrEJvKzJ5rofiS189RhCysslt28SK8Oygz0VI=;
        b=UASJp60kN8Va7CL/EABFP3sptxVRLj2nO8NTLQaPBdR2xpJG3Naz0EyM+xGQ38snot
         +/yKDddWkweHTNPTXpYJ6AFU1rRjEr1SP4zQ/m2hkEA8JZ/3zfIt2nul4YraIPaK/zwc
         oF8eMoXNUNyxQyF12K0A29Z3NLgVwF0P4hf/2TmBMfeHm5jDuLQFAZfuMboYPHmKVRqD
         b6lGBcMMXPwMDlDgz6f1gB2nPxdfic8RP2lieQlOKCmaL7awyEDMkS/0E9cyr6NxGY4c
         aEGUtA4xugeNzu6lISyeJ0L8yBjNDPS6zxBI5tBJrAq4IKrU7N2YBItqbfaV3ZEj7UUX
         tIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwKSA8TqvbuF/nvJzjtV4LDRn4Eu43nbyRzZVUdOlQtabwOKkl9MS5v8cWu4Qao6xjyEiQ/t+/JOHU7uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kzc68E5bAuXDy8CZ+vPDAZaqD2nzF3xpUkgc18f8J00UuMBD
	XQTf+2xlVnbTHPKk8dYuZ3RIvfhjiZA9TUBHKLfA1we2HI6qIM1/
X-Gm-Gg: ASbGncvyOAZ4eM1w7VAZs6xTuvxuCQoAk6q/nGSV2vicPLBbOynNyhfW4BGUP9RpuRm
	460uRU01WXCObbqEoIllAi3X/iej/cOF44IzoLOASS8f7qWdYGKzuOmw1ojgbOilLiUkygcTXLT
	yUjomDtHBpv/6EengtD54Rc7uHcqCwSMt+/ylZFWy40tROARSKIbfa/R8OjCSBc24u2F9vl84BO
	bCVeYYt+R5gelA0UD7aDdqTVktQmmPjPEzPzlCxUKX36QCJeNai43tNunpMFgn1ujwHALnIiItO
	bmB6fFPSEOwV1Vk4K2Qb7dQ/necuDJviw0N/W76OXr33GmkZ0bZyVA==
X-Google-Smtp-Source: AGHT+IFSruVV3hXQii/npsctMTewLaITNtu900mxsrwy1+AJs+F6fa1VyhXAmvyvh2vP9Sqviaqetw==
X-Received: by 2002:a17:907:3206:b0:abe:e981:f152 with SMTP id a640c23a62f3a-abf265a2a06mr1623778766b.37.1741017299620;
        Mon, 03 Mar 2025 07:54:59 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6c405547sm305699466b.110.2025.03.03.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:54:59 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 4/5] x86/irq/32: Use current_stack_pointer to avoid asm() in check_stack_overflow()
Date: Mon,  3 Mar 2025 16:54:24 +0100
Message-ID: <20250303155446.112769-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250303155446.112769-1-ubizjak@gmail.com>
References: <20250303155446.112769-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make code more readable by using current_stack_pointer global variable.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/irq_32.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index f351fa1ee6a7..2428d661faaf 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -31,10 +31,7 @@ int sysctl_panic_on_stackoverflow __read_mostly;
 /* Debugging check for stack overflow: is there less than 1KB free? */
 static int check_stack_overflow(void)
 {
-	long sp;
-
-	__asm__ __volatile__("andl %%esp,%0" :
-			     "=r" (sp) : "0" (THREAD_SIZE - 1));
+	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
 	return sp < (sizeof(struct thread_info) + STACK_WARN);
 }
-- 
2.42.0


