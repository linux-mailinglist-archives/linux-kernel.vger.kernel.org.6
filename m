Return-Path: <linux-kernel+bounces-524946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E07FA3E904
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DD517E64F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F9F9444;
	Fri, 21 Feb 2025 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="JKmvoI7z"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AB2111
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096571; cv=none; b=nAXkPPxUBob8yY/qM4RKQZio2YdnGzpFwqc/hmldVOhu+s5j35ux+oqWOOcHfD1hNV7hVEJAHfEEn6y1yPT6wfb8ix+BqagkOKnRUxeDGPFp0mooBvw6MzLeorg8TznH80Q+RkqkPeF3bCl7gDIwyFlx1xanjoVV6YkiVS0AyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096571; c=relaxed/simple;
	bh=8tbJj5z5g99BWv7aelIaSWo1aUJ9tKIbu+IV0jhMGM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTz8VG9LDZutRSXuV3oAvhaMMKHmf+0nZKyia/QdxIulGZSUbXYPo/JrT+uxqetiN2s2hCCAK6wGdqKxsqcXDx9FUxezWMJdZwOcrGclTlO5ir4+K5hH3phQRTpwl733Tt4dZKKh6oEHs8fTmVBDkBdivT38fwiIu0DfLd4WUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=JKmvoI7z; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f41091f7c5so829570b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1740096569; x=1740701369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVS2gJ1tGF7KfC44fJzPB6s+5bKduKUUF483rWDGJdM=;
        b=JKmvoI7z7UpELzL8/u6IlZ96brShkyefFqDK8nEgKAS3c0drmciJau0PjYjIxWO3Lg
         hziuPMdgslbKlUn6SFxD1RkhJfusuxuK/LwhAB0MdTuoEDyb8QqHOSDSR9HrdSF4YCRn
         2m2hrUHzmgqisrg6WGG42GVJP20bOHSbHRlsfB6n/tuH/J3QmiAdLLc6SFKW5JnGO+Jm
         5qMe5aHhlbVYbVoKwLEQ3Xsj++SCHgJunFth1ysS8zeVBU7fXE7ClAvKiZfWB/2pIt5o
         6HWFXyZLDQmwTPyikI5/BKSicz1aETF0+qbH8re7NlEasDx1m2hdWvW7ayJqYN5IhK+i
         JO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096569; x=1740701369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVS2gJ1tGF7KfC44fJzPB6s+5bKduKUUF483rWDGJdM=;
        b=daw+sEC/ENc+iTnA2ZToSkU11QeV8GDw0xBC8dzEG73yHOjnpn953SsCGQeixE2gHG
         EBNmWW1uyMq36PabOAgzm0+ajo2ETe6vWoBK0vIU0oYsXjEPoNz7G5fAMgf/iarYLXDC
         8QjfN7ZOvMGPm1dwIFCC7pqDAckwyem+9EO8RWTX2lHeWjYbPsJB7JnsSfi8S8gFapR6
         dlTyaR6y8RmeUYDk7h4wV+eUmu971jeog/2AITky4tFYBsJ+fxPQr7GjwuNy4koQlO8Y
         xOz6roWfE0NZLx95BM8bjA+Wwld0xX0+ZNDQyvvsnOM2XoLIuX+wMObXUBIFyZInK/S2
         YgOw==
X-Forwarded-Encrypted: i=1; AJvYcCXlAOTVHtm/Hv8TiBovQ7YQ2B6tzTmOsPT35QrfwmqugD9zTrs/jL9DrAP9C3kWsiztq5UPdxDXlwPs/30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMxY6FZImoHQh0agDhXyGPVyVTPhsd4gzOVChNX6qxNcOYu6Y
	XewcOr3jJaTIofD4QDX8imGLBDSdF9wgYhrT3chpW4jKieknN5bkg/9UUaWAvg==
X-Gm-Gg: ASbGnct4zHoW7rfeRO0f/qwFmuFI0vDERj4WI7pH1cJWO3ukWfcXiHdVGFEeEh2omxm
	sV0FIgkAziIie0yk/HgMOTI6PS8MN1ZxeTvy2LdV+IgLkYqs1/pmCDy15we456BxmkZ8Ph+j95F
	KBuaCZ4QA8jAsOm/2q4tTtH/foYeJXYXg0UD8rZ0UdemtR4h1Yg+pD/Xv2FamlSCAMmKcUx8Kud
	tQSxWU7WLpvIg3GYPL2XeRKRa0yKkL6Ou/Qp/s5jAgoAhMHFGeEkh999950Txbk5Q4PWHY9S6+o
	MftxFcTphPsbqS3mFsFsDJlAJNXDNJfkAA==
X-Google-Smtp-Source: AGHT+IFKRfnHqdiP+z9IB6oatR7TvVXNmSxjSJMg1TAS9ThRlHl4CaTM35ogp20h33uxLtf3x9nOIw==
X-Received: by 2002:a05:6808:1490:b0:3f3:db88:841c with SMTP id 5614622812f47-3f425a75607mr599965b6e.9.1740096568994;
        Thu, 20 Feb 2025 16:09:28 -0800 (PST)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1573401b6e.42.2025.02.20.16.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:09:28 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v3 2/4] riscv: uaccess: use input constraints for ptr of __put_user()
Date: Fri, 21 Feb 2025 00:09:22 +0000
Message-Id: <20250221000924.734006-3-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
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
index 43db1d9c2f99..fb3961ecf38b 100644
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


