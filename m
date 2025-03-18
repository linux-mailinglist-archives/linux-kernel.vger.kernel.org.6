Return-Path: <linux-kernel+bounces-565535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2AA66A33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9987F189ABDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF201DED77;
	Tue, 18 Mar 2025 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ET+iCnu2"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A41D9A5D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278523; cv=none; b=FyyvGn24qbsVDFeeI8C7aWNlRxd9VX5CqiwvYZvHB572HFeKpIrDWXEh6eoLp/690PfcN5KZniey/ts7RtsoIirNd+9Wa76CVwfJ6EYMAZNgkwoEwEIGXEXCWSJr+m3enTG+85vTUpHkNzH40hwsSal9w76VsTZNNO6ySz1vAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278523; c=relaxed/simple;
	bh=8+1/CTx5s8hPHAvMe5c1XoVfnjHA5kPPBw+5xNvfq30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmDjb7QSFGO4l5n0gubPolSG3x2V9KRItymb5wZmRdu9zDLD9X/G2EIrIW0Lu7xTfI0rscSqqZ0h0RsQhlbvmvomdavul2xiwT1sReLDlv6BCKQPXIiqRpOJ6hfMWdcvj1/8TJ8NW5BXrwwqfzmzYoI/dWw5KTSg5uvCc5il0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ET+iCnu2; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fea0363284so486655b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742278520; x=1742883320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STOmRD1NGs9uSMt++nKAUKoj9Ow/rlWCVnbqWbWWLRY=;
        b=ET+iCnu2JhsauGSXc/nh6OcqKXvR3C/DZfFXvNFzbnD0/JnECj3nmHih6QYs2Alywx
         qGAKdPiX0lkScSz8wwe7wGeOl6SegokKKiHvr2W2PvJ5GJN/y+8V79nWRmO5goTAp877
         wH5UDNCx69QpPSrpNxP6klERkvEnTgE+5hAHiR5Gd5AifQTCK7oRDWlXWqzv1LGqNTGN
         +MxLuhN+9fAH+q6BjsqSYgyy3pxgTFu2Gtu128q/zXHb/cPyOSeWTQfvTiEAejpGkARk
         mlXw7scND76moMakUq89OBXtb6e/mV0xNud97ZqtUWcQVQ9tWuxLDditj503XVlGsPOu
         zSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278520; x=1742883320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STOmRD1NGs9uSMt++nKAUKoj9Ow/rlWCVnbqWbWWLRY=;
        b=KV90ifA98uNb9HyEY6g84Yztn65iK6Hxzhj23oI1N7t468jkFR1ZKKclN0KJACnolM
         XcqrI63rPymOFFTptK2nmDBKCU5nghiKTba8/Jweh3hceTAlbO0QQQP1LNQToYgEJkLD
         nKjxqtDA6OwuONxS7wrWnXLrh2amCNWUmXwYkemDNKzJHHpEEm+k7SMJbBpLNWn/XA2n
         MDOtM9iU3bOygfWL2hXxSgK/lYn5Zz6jWLoJCi9oz9nu6I5hlWurZ4Q2+r+wYNpBuSa6
         pgdtRiwQNrVoNxfCe2+LGB2vkpxWDMex5KkLhjOEhxNhbz9GcGxgbbX7Q67n6tiJ5Adi
         VHOA==
X-Forwarded-Encrypted: i=1; AJvYcCWjHRGSgpd9zK007MJ94KZVK7uw5K7saiweW2duHjz5Hq0x4PuUUMHoNJdpS+Bv+eyaJsYHrJ6Zq+S1c0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRw8pclYPr2db9pfVm+deS0ovMakVbcvJ/su08KKImYdGBz9z1
	v7dlQnMCmvpOprzDAUxFevVDeysrG5hcDpVeCGHWj8xNu56l7FAjGk5Z1TKbXQ==
X-Gm-Gg: ASbGncvvI0n+L7cTX6uqVSshhq7ym5XCEj92OHMJ6OxXTIb61HhLCELnj+HhfxZ/M+P
	rc9UEdRyXB2H6CqBbCxUcNk8cK8ogsItyeCP/4FmyfxAy95AFPKULtVRXV5kSQnl6q+LPYKiid8
	Uw+AJMO/jArrxgx4zDxdbEhTwoPl9Ml54HGRVPR+XcgrkWVuiC35iqE1zEeTl9WcJjVxAZv9k4d
	lH2xpXYV1og/jXV2y9XEwiOyzj+WONLRoU3Yjcpe6Yg3kUryxXQaAAXqJ09cJE7yFuytoVuBNdE
	DsoILQ3rI5Mug0757RZD3hZV/kWHB0Ogog8SJNL/MP0IWknfDYnpr5FRD/025Oc=
X-Google-Smtp-Source: AGHT+IF+QEcnPvq7HOQUCyqTY14BOpN8Y8eX1PyixCC8ZH0S4NtzfP09P+KLDIccR2wqd6pOP+an5g==
X-Received: by 2002:a05:6808:38c4:b0:3f8:18a3:b1cc with SMTP id 5614622812f47-3fea2482935mr1337534b6e.12.1742278520647;
        Mon, 17 Mar 2025 23:15:20 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b882sm2051642b6e.8.2025.03.17.23.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:15:19 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v4 3/5] riscv: uaccess: use input constraints for ptr of __put_user()
Date: Tue, 18 Mar 2025 06:15:12 +0000
Message-Id: <20250318061514.1223111-4-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
References: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

Putting ptr in the inputs as opposed to output may seem incorrect but
this is done for a few reasons:
- Not having it in the output permits the use of asm goto in a
  subsequent patch. There are bugs in gcc [1] which would otherwise
  prevent it.
- Since the output memory is userspace there isn't any real benefit from
  telling the compiler about the memory clobber.
- x86, arm and powerpc all use this technique.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921 # 1

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
[Cyril Bur: Rewritten commit message]
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/uaccess.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index d7fef81b7969..180d6e21d5b5 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -219,11 +219,11 @@ do {								\
 	__typeof__(*(ptr)) __x = x;				\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
-		"	" insn " %z2, %1\n"			\
+		"	" insn " %z1, %2\n"			\
 		"2:\n"						\
 		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)		\
-		: "+r" (err), "=m" (*(ptr))			\
-		: "rJ" (__x));					\
+		: "+r" (err)					\
+		: "rJ" (__x), "m"(*(ptr)));			\
 } while (0)
 
 #ifdef CONFIG_64BIT
@@ -236,16 +236,16 @@ do {								\
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


