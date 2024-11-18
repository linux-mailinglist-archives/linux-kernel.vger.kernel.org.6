Return-Path: <linux-kernel+bounces-413598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81699D1B80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7919728123B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C5192D82;
	Mon, 18 Nov 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Ob8+ePIX"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE601E909E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970893; cv=none; b=Mc6Iw6tFx3Pk1NZUiCZVU4rU0eByYiezzSfg0CZnLgV6dEFxla5NQZOcchh15GfZ83CPMYkJpdENWs9gGzc0YHqpIx5jEROdL2GPKoFqMiIvUx1RXupoTKbnxsztdV+KvmrnFahDZgBvGLkcda8X16Q7IF5Hg8aF2jEf5ksn8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970893; c=relaxed/simple;
	bh=5sq2RndBvjwbPDbRstQdV6Pr5uT7zETeUtlaWtTno4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0pfoOwF4hSceZQP/7wygUXqoD6LKZpfIfRjFQZcLOspBTJ7ulApEdujL6tJllHSH7yNfUIvWrptMIvxQtHj2zOBTZ4lpIr1vah0w1CMLBhpH0AsY4DojWV4Isp1AAV3e81ummSWLXvvRWdfttvc9AMrzeoB+7RrjVWbwkCNUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Ob8+ePIX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b1457ba751so13899285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1731970890; x=1732575690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PToKMxR8SXs7rV9viWVleXFNB1vBa7oV5mNalHrcMMc=;
        b=Ob8+ePIXEkT+R8HcZg6cZbb1xYZpXSP6JJLiZ1RmJGqRV3voR8l2jbM6gW608/BfAY
         Wfz/P1mKkTY1Y/NyNKz06pGVy2/oV3kKjCmjNISyzDOf9zPAykl3rGcmYbGrBhuniD/+
         Vnnvb9LLculrhXLAEmFSLW90Ia0TT/+k081KTa22Vb7wJK6muNXMPfkZ17sKPhV4FXkc
         eEvoWhLbI1HJ1H9DlMLv6Z7akDA1SX0c/k4+SNRPlRjaov1dw2+tmugBFJxw1n7qnosg
         zeNpHL1tv9liA8DUzUh7UH+dhHDraXPvHsvQUHQKFX3GG4AUVdUh3CLwOc23XoaSurP5
         wjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970890; x=1732575690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PToKMxR8SXs7rV9viWVleXFNB1vBa7oV5mNalHrcMMc=;
        b=pGtzgHckUfgWEMHz0T/ipJ4ZWrpBHcnX4eY2KwhmQnwYZwYWA1WRpuwGQmYXZGyBTD
         NyboP3COksmAKNr95DR+ytE+k7xSXNEMUJL+USriPx0sAdRv7jliVjJT3onP9dTYRjjd
         1XaRLbpHJfDveAx/y+vVSXtwDVIRGVl5sTUBDJAYEyLfQQfTR0sS5VqoyhgcLRqTI9kl
         XoQy5Bud5pWkMZwWAFF6zo8TtCafRa7I3bmyiepySsOtGr3mT6BO8LWdt4mDiu6Ra74B
         e0Mt/WnW1nDTSImgnbT39XXw/a0Z/RD6d3xcHmhq+dCg7+HMejDcBapxiYEtLAXIKEBe
         qI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3x6MlN4zo3W1xRvFdHNb4YH0u3CgeKDaQtd0ok5BIqc5bUE0MeO18uutoGjEw1DkIaWSC01xb2gzBMZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7nQwwGmx84S0uc/yd241sSSvyPkOg32dgS0cuC7REJ0eKJB/
	K67uuoqFsHvdmaXLfKlKsEMHIEfkP8aPsUzvvhSK+izOnrt2xPW43PPbrJ3lIQ==
X-Google-Smtp-Source: AGHT+IEdKYZYKIfiFMuOvuSqJaFWovb+3yVp8wkhP6JmHG9WTJacACUFPkjQt/TtG4UdQbsLVQzgYQ==
X-Received: by 2002:a05:620a:45a7:b0:7ad:832a:4063 with SMTP id af79cd13be357-7b36229a32fmr1994256685a.7.1731970890344;
        Mon, 18 Nov 2024 15:01:30 -0800 (PST)
Received: from aus-ird.local.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a897eebsm35344185a.94.2024.11.18.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 15:01:29 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 2/4] riscv: uaccess: use input constraints for ptr of __put_user
Date: Mon, 18 Nov 2024 23:01:10 +0000
Message-Id: <20241118230112.2872978-3-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
References: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

I believe the output constraints "=m" is not necessary, because
the instruction itself is "write", we don't need the compiler
to "write" for us. So tell compiler we read from memory instead
of writing.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
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
2.34.1


