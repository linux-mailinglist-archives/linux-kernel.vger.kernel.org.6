Return-Path: <linux-kernel+bounces-570488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5821A6B130
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97264983D07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584022AE59;
	Thu, 20 Mar 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="aAFzRlBe"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EA22A4F8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510672; cv=none; b=DmswjL5LIxKBlZgCzJbXOZQoQuCp6d6gHQ25yj7tAtAiVrhgCnHEutSsXSvJbP+nb2DkQQMN4qp1CVxmh/RN5XgPEQg4GMKb4beHrd9/V2JaJjMzxo5v56/Nsjw1joExSHSQwVOaoWmbhXTqkd9PrgOvgI7NqlGEF3OhvM30Kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510672; c=relaxed/simple;
	bh=HKMnBVdHsElfI+VU/kTaLpcWor2d4s9BxLReognxMNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUsGKbJmD7+9/gispbypKOo5ihn+k1PRqStqvffeXuR/xg4WX3Bs9hOgMrzJOze6rZ6szZjC2O5DMBlu/78UP+Kk86o808wEAgeI4CDBOYsNwsLoXb9Drk58NOGxOJbpy0u9OyVZNULOItMb7EOB7zuU1H4wRfu5CPGukzUWEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=aAFzRlBe; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fea67e64caso803828b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742510670; x=1743115470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh8UBXGzUbnvdsif2sw+KTYhRC1BSjBoml8SqEobyIk=;
        b=aAFzRlBeXhuIoT3hwxsqqL5DcWagE+GOYw7XWHEXF52kAvMwaYFf/GQQp+0xeAMkmt
         Lzk1N6ARexytSbVbuZ0edssnL/Hap3xnI3CgH0MZtEeNs5gOf6724ilY79z+tWkcG03s
         WgYhRHCEVswwH7eCRt58Jwi/JSxrkxHRRr1QVzGPBphUGSWqSeU5Wz4JncIGRjuQ9/l8
         1caF9KjCP55wSxM5n6QzLzqAP1JEfZeAbAPycJKvzlILMj98DU0+ijnlIbZzS6bKC2ey
         5Qeso9YOAe5vXu+QNyon+CZSiaUMCKfnBzdyzFEgi7W7dB+vVG7PquRLtecILqmVLvVS
         D2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510670; x=1743115470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh8UBXGzUbnvdsif2sw+KTYhRC1BSjBoml8SqEobyIk=;
        b=P4CGbZAdPT6KfaEkn9tG93oXg84GrtLRtYBBkdvVE3GONzjLtrOturseyTG31uOgn9
         6hEd0lvk69pdjz7GNsmxbZblhvDeK+mqQdfnMAUwIaDAafMqoPldT3IhKESOMEyMwH3s
         4FhbemiBY/P91PR1EDtuD7yuADAUhWJ0Zs0eJC0T0U6JfgYXoW0RK1ejio0VP0ikGcZK
         ENwDVs9ULlnMxoH2iuAMz4bvqZEVtLfiyz6xJ7g3qky9U7ByxY1hz5qD2fxmzotwHRi/
         QBlB3ZfuuufDlUAO+/Rk6JpkbWrZ4EY+copvCnh8P5+/Ny9/cjmmyeS8V0pcfGH8hhtd
         8hAg==
X-Forwarded-Encrypted: i=1; AJvYcCWBx6MvtUDYQHlkEKQDT02NU7heNomLcbtXXuVi+RDNx9iro2fMvt85dxdp5g+JOPMHSpkN7QOchXo4dAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwuKXGAw6S5mlfiTLU4wRjM5/hmN/94o/2IwNbZRzfEdp6ocs
	cLwLmjv83k90wNqM4QC2txkxFXctltRnCkp70XYXDbHOg1TyCxH8SVhtPr5a8A==
X-Gm-Gg: ASbGnct0H6NVHegCg1Q4JZGwlTAlYJ3VK9A3t+dvbWp2b7p72OxID+SFHrElATp8k/O
	H4G1Ov0xj3LfqmDFZAdXeD8stDqseHX9mBxico8zw/KlppwIXwkLhtNP0QPni6cm44KYTTZQChi
	MgoFO6osxLR2PotTBgpz0MWeVBZz2ZgIdd5swRcrrtMkRoko2/gFA4sz74UZ/oHdj+Rm7Ip6MCO
	vfvE9xjd2txAIqNW2goCrUP8Ndnr+yZzDQd4/jEdASkfQM0v1K725AL4NgtTY1+5WOAMDTidrzI
	tgPtu2iFHfyWDFLJ3TtvlW5msztDmlVaHAf554GTYYGt4Iv6gsjOkqdJpnIpWJnOnAcCwrGXXQ=
	=
X-Google-Smtp-Source: AGHT+IFPgB4lmDSuUaCrMpZ/2qFcRUoJ3Y+avxEgpvQKbDo7r4YIRe2aaoiARhfstm7Tp4du8Zb0Lg==
X-Received: by 2002:a05:6808:1a12:b0:3fb:7ac1:512c with SMTP id 5614622812f47-3febf7481femr654995b6e.17.1742510669653;
        Thu, 20 Mar 2025 15:44:29 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dcc09sm103524b6e.12.2025.03.20.15.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:28 -0700 (PDT)
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
Subject: [PATCH v5 3/5] riscv: uaccess: use input constraints for ptr of __put_user()
Date: Thu, 20 Mar 2025 22:44:21 +0000
Message-Id: <20250320224423.1838493-4-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
References: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
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
index c9a461467bf4..da36057847f0 100644
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


