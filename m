Return-Path: <linux-kernel+bounces-542113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6DA4C5D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF79169AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6F214A8F;
	Mon,  3 Mar 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/ukIz+U"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700E6ADD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017301; cv=none; b=tQhlg+2s6tXMid4DZhZw32CLHZJO55TlaT4mwf4ZHFqIX/2rkOycIn2YjEt56H6Tox22LWeHTJkdxbUolv0GAe2+bnvH0VrMNf2FZzMoPP0s58oHs9bknulDucC6UB5rdrJ1KFO1RTl9VnyRsI+KQuogCWskp40UhtII+TBek7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017301; c=relaxed/simple;
	bh=v2PFZBKeFjtD1LMiKia/ctbk30Oz/m8n0hjUdRCGZM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBWc/VjigSfIHEoh26Ssv8u8xNEcLX0j+CB7/nQxp6m57NWhDVaSHMX8ttOEebkKN/prezsSLzuiQGoYfhbBPUE1/gqz8CX32Yh40lW9hwBeAh88iyRCaXb4bgOJ2iOQCHM2Upm7BwpDsxDl7jhZw+MJnAVz/71HMUFJNAgk9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/ukIz+U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso6992136a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017298; x=1741622098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=safgICgnmyoDju0SiYr9LB2QpzHr1FuLNkEIYD/FCxk=;
        b=G/ukIz+UhOem0XVmvUCNs7wCxVUyjMTQIWB9iK69Tb8xen6GCZQ8f47q1Shk74/Gfn
         VtmywTowawfDivs5p2i8H3uqpha+QsLJFzWK9AEp57mKvnCkIRoQliVySSwd5cUtXv3K
         jYXac8JDimgURWuxvhHS7KglT1u29s3oEdOSueWRBQzNtUjxMPSErCLvUTCQqqcFqCql
         n6K394xkbu8sqWfCExmeb2PJNmE9Sj8xpuy1y3JX7bDVXAKp+vvOF4dIpuS+r++Dk8xQ
         BpNTV25J6LN7CxzXK9cGgZp6rnzOPSdsEthZ65E++8yEB1Qxp5vo0h6bQMuZXaiK0Tp3
         0cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017298; x=1741622098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=safgICgnmyoDju0SiYr9LB2QpzHr1FuLNkEIYD/FCxk=;
        b=nhMKV7MerQXsS/Dlwe9sAd5SjhDDMokX9Pq0M7Tr8CGFL72oUBq/7ZcSEmfRnQMnbn
         wzCB7CWqoNIzm+MAH9no0D2o6qOdGKNe00yzRCuTm3GC2TtWtEpDcrIyBtbEwvQ7MG2u
         DqSo0crVX/sEa913sj1eLSj9tgkgAxD9diJA1uDh4IzilKURg8vXem96BX6zfMZiYNNj
         axCZ2gfULaKefquI2aFnWCWRonxBsMItQv6q9SnsCiofA3+iQVmwhPjpkGQCUrBb3KRE
         BTj8m9ReEtt/rDxumEfYOPMs2hbigt9LjC6BE8QHKA5mgNuc2NbxwgcQUtJx7maCHZe3
         QAAA==
X-Forwarded-Encrypted: i=1; AJvYcCWvwOW/58E0ttgYe/MvBHaoHc7mSFPw8gXT2y1lBx69DuZ1vblkpAy0BNgoYM3qErEk58bZp4EV3SViI2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOh8awtKy/otx+qEFrvWRY5G5uT6KevGiVyDrVCKr7u8qN+ka
	5vakZaxF+18aFl04fPsPH7EkwC3U0UXK9KT8+Y3/yaiAG4LYLVAD
X-Gm-Gg: ASbGncu/vGOE/6hNvGM7sWg09IYEH7liUtHE7BIN8dD0o5/9Jf738C5dDhQ8NV8Pa/K
	vKNcD7kpxzfXZxv40HJ2+c8m0OCB0hXYC3BuEN7pcYODxWYQVpCPvmqJQ1Ge/mX833nbaZjFa39
	3OOznMFrtmPTZLovCWWg5brAdtJHzrpaEShPNdyFvbLjbZ8Egq3bWfwoQecWg031GvQFJfAFWXX
	7GWQAtAg6V7zYgnvtHrN6w3c0er6v4K1903wsTVQ0caWJgWEMEws1WxvHnWFVpbl/+uFBQyTW/I
	Q9UK8gvMlZ/My86nyHffFEEPZShmf/qSg3cfjTNvErKG2TQomkdd6w==
X-Google-Smtp-Source: AGHT+IG+/U8XNvosCKV5PxienO4WtpizNkWBo52Jjp+C75IhfxjS4C3yjn/ohqq7HAbpkbasSXBm7Q==
X-Received: by 2002:a17:907:940f:b0:abf:fb78:673a with SMTP id a640c23a62f3a-abffb7876efmr349306666b.29.1741017297828;
        Mon, 03 Mar 2025 07:54:57 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6c405547sm305699466b.110.2025.03.03.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:54:57 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 2/5] x86/irq/32: Add missing clobber to inline asm
Date: Mon,  3 Mar 2025 16:54:22 +0100
Message-ID: <20250303155446.112769-2-ubizjak@gmail.com>
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

i386 ABI declares %edx as a call-clobbered register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/irq_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index c4719c40252f..eab458009f97 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -98,7 +98,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     "movl %[sp], %%esp"
 		     : "+a" (desc), [sp] "+b" (isp)
 		     : [thunk_target] "D" (desc->handle_irq)
-		     : "memory", "cc", "ecx");
+		     : "memory", "cc", "edx", "ecx");
 	return 1;
 }
 
-- 
2.42.0


