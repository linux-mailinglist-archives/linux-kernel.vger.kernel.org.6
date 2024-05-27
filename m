Return-Path: <linux-kernel+bounces-190313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84238CFCC0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96731C2139B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1913A269;
	Mon, 27 May 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Indt6Gci"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EC3B295
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801860; cv=none; b=Dn3Xh6GRUa8GcbkvsFBEp9i6kyEMGUhaldRycYPruJctG1aX3/+GRTB0g1ImpM6XuRbrIGkrz/mJo5wRIlkegrNCPU+v23yex7nPeDjoleiYiLkjFpfIBy1vEGfQtFYpi1ZOsI5wCDtoq0aLb7zlZn0EiXYzerfaXK3EY2KuwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801860; c=relaxed/simple;
	bh=sY0VEozDSsNgGy/4WYHY9YSrt7BlCdCsOPBcV1j/lFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DVR/CdLo97B3IZAzvv+C5+z2FTdY5pYQLbXBm30fMly/lb/zXAq6N7YhJSvCTWJ5zqprQVWz2I9crQTm0Qx+2qPqBZMH8gvFvHCZX0igqFOMz/t5XhxG0+tnzp690GrpI/WmNatJ1aUCNBfciSE7O0eG0XEadKU7eijUwW0cbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Indt6Gci; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bf5e177ebdso2454303a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716801859; x=1717406659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+i4h0MN+pB0f65UZyFLyAqmTtwAUNXrnLqCFrIoIwE=;
        b=Indt6GciFbysnkz83ZdHsgAwQQTkS8IbpUNYGM6zAgHl63dj93Yvs0kHCwUJcMUa0T
         YrDWV5SwIOyMs+GxzN+IbwMQtYVg3UPQykUA2gYcHoiWO9bEmrTx8iE+ox0Q5owjvPEI
         eRUIt8cnv2dMF7lXXCezJN7f4o0sRlUi6p7Up0fuF4c4k1otAKMIIz4Amst+5u9o9Gxe
         Xz8+d8eQ8LKDpjs98tMUxREJcx7qPlKLXwjRjC9YrmWW3vd6jOm4XxoxB3zcX8gB7DfX
         +lTlHUauvhS4YxWuZWh6TCtS9Vst6umLe4Jh3ffHXAiK/FD401O4Brs2+El/q/Wd1MHv
         AVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801859; x=1717406659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+i4h0MN+pB0f65UZyFLyAqmTtwAUNXrnLqCFrIoIwE=;
        b=gvRE/yfQNp7f0rrUjuIIHT22HnmmL2NY1IGmZwVxQ7qI6s9Wb+maf8LymN6k/xRvXu
         gzOjVbi3fQn84PFgzrjQ/xBsr2QLHlNWW1zhJ5FXmMAUNA93/Epek+Hu4J37GC+roH8m
         Sw/3QCfxLtBcOHprl0WFGngzTYDuoTkokb3AfFYONK/6bKjNhhWRD9hyBTe+2CEFIGi+
         vDfOmpMoBOSMjGxHC0wfxrz3RBOTnClN/ZcV3LDnSkMHpsKukQq7Kd2Vhzpi4IaGhd+2
         pHzWGW9AWLsSt9OysTQa7e+CXGiksAsLhmzFpRvYhOnu+wHhZXMft1ZUD6YAF1DUjodI
         gfFg==
X-Forwarded-Encrypted: i=1; AJvYcCV9lYOw+DdXKx93xt7b7qnRQbNymmWxHmhBU4wtFTNqJqqS86/3BLRxWIHbr7vJDa+B6+nKHSBdhnqix7hjsUhthqW8IYGUKuEP+TGm
X-Gm-Message-State: AOJu0YzydZwcJaASFIQqD777sxacZiZxRb1IceTwofEt5ZGfZ0lJooKY
	2R8UrMNB/w92k3Z+bVUJzsVxRqBQPLMySNhlVOKY8RkZpzF5TRCx+3rtbQOQ
X-Google-Smtp-Source: AGHT+IGaW8y/BKut1imkBHJDLYE2ZbsYu38F3pmTipGIQ70gSyDKYHEKT1c3gOPKMlk+e79kTGbVtA==
X-Received: by 2002:a17:90b:374c:b0:2b1:82f5:278c with SMTP id 98e67ed59e1d1-2bf5e84ac4bmr8228004a91.8.1716801858556;
        Mon, 27 May 2024 02:24:18 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6249:183c::26a:4f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm7059830a91.53.2024.05.27.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:24:18 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH v2] riscv: lib: relax assembly constraints in hweight
Date: Mon, 27 May 2024 17:24:04 +0800
Message-Id: <20240527092405.134967-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

rd and rs don't have to be the same. In some cases where rs needs to be
saved for later usage, this will save us some mv instructions.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
v2: updated title as suggested by Xiao.

 arch/riscv/include/asm/arch_hweight.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 85b2c443823e..613769b9cdc9 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -26,9 +26,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
-	     CPOPW "%0, %0\n"
+	     CPOPW "%0, %1\n"
 	     ".option pop\n"
-	     : "+r" (w) : :);
+	     : "=r" (w) : "r" (w) :);
 
 	return w;
 
@@ -57,9 +57,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
-	     "cpop %0, %0\n"
+	     "cpop %0, %1\n"
 	     ".option pop\n"
-	     : "+r" (w) : :);
+	     : "=r" (w) : "r" (w) :);
 
 	return w;
 
-- 
2.34.1


