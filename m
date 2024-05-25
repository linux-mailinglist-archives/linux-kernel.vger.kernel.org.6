Return-Path: <linux-kernel+bounces-189478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0218CF08C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5471F2120A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D3127B5C;
	Sat, 25 May 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="jsJpCN/O"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4198625D
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659135; cv=none; b=p9h5O9wOkuZqInqhLDv4/USiz/KIJcF29WCVSwz0hotHgg0fs0UOHAMnnHV4blJRSmiQHA5xVPbG0X3R9zhsuhntlc5Ertkgivdhw3G6cFkwRicQL+CasXvmitIHtnWl8frivDYGxiwL0PaBJnFzWaVyCO55Uan3p+hjzYg92tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659135; c=relaxed/simple;
	bh=ifCbnpwwdLSR1ptlXaG3gY9JdMDdGLFeG2/bnUDNc1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijGgQ/SQ/1qaLtLTi+8Jz1AtG17rzYDRSbTFHjZCaAZjSe3qoas0PcW/pfG1pg1hlnFcfXkDDezABZJbKAovrYcRhX0XOh4Rrbfsb2hxaYmenKR1wR53jnMhpU1s2pNbtobEcRp2cen3KAfPNNdzm+lRUv8zDcwDobSlYGrTKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=jsJpCN/O; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso179278066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716659132; x=1717263932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hoa0fhHT1L3lcNO0gKeqVH235WRYgvKVzPvZxHoujA=;
        b=jsJpCN/OKg2jcDzRWLpmOEv9afCWlAQ4U5CtjFj8V6SnpGsJkdmz5N2/kuf0fzfVsr
         t2gDrKtB48DU/GYiDfU23jVg4vC2goCv9Io5iZKVspBe/PQ0sh0liEch3LBt9KaJowaC
         5gTQk6QZdLE8lDI6YzkSXFkALuHv3OnIX8hI9eYnXLa9MIEFZ5egUOsBNQcCOjuPnusW
         e9yhTiAvk9dbTRTLqMc3NC9x7h3ISrPFHiAQf8FVvEuAu9IEullq3c3VJrusrfwALGmP
         ITrr4B8jHF3SRwSKGgpzvwvkVjU4w/698vGZ8nA/85CgwZdX8bh/7d6JrH2LXg6+uhTo
         QYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716659132; x=1717263932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hoa0fhHT1L3lcNO0gKeqVH235WRYgvKVzPvZxHoujA=;
        b=mtOA/x5vwHfBMhUoMW12TZOFrPAGYb07KRp22xM35hTc90q12UCuQgBKeZbdBOXlA9
         oVuAhZvsuzsIbAlBaKiBhr0wA+s8V7OITIxg5Fq97dTxdNJDzbmjYjb000pwTwNBHc2X
         Ieaxkp1OyqmsoyMjkeJ8fTnrd/MXBE7O1xWzCHlzEDgSv3qm4KvyhIc5FHfJXEMeuam1
         rifilee5nbSi3oFHGGy4Pm3YuWr9f21pUEknLiR+uF4l6zPgZ1QUKqSCMfFTJgYPIY6g
         BwDWuZOXsodzU/ImoX4dHfOlqqylCKiYblyWvtr9+Ev+MRv+u+sHur8NMxgy6wcr9kVk
         qTmw==
X-Gm-Message-State: AOJu0YxJ5ss8oUnrSaB4cWCj0ABFRkeHjCb1Ht4pKufRcnUA7QnnBqlZ
	KoXDDNrQJhPxx8u6AjLUJeIkEXFUgaFjCFTtag9yH6Rlag4+Egy9MgYrzNu3DpI=
X-Google-Smtp-Source: AGHT+IFJ1lA0pYeo9NJ3OUxER0GYcBDF8kinUR/EIazcpobsxpnx+ZeFukAxV40so5Rro3/ZzP2TFw==
X-Received: by 2002:a17:906:488c:b0:a59:c62c:212d with SMTP id a640c23a62f3a-a62641aa355mr355593466b.14.1716659131770;
        Sat, 25 May 2024 10:45:31 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817c5esm272090866b.43.2024.05.25.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 10:45:31 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] x86/asm/bitops: Change function return types from long to int
Date: Sat, 25 May 2024 19:44:49 +0200
Message-ID: <20240525174448.174824-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return types of bitops functions (ffs, ffz, and fls) from
long to int. The expected return values are in the range [0, 64], for
which int is sufficient.

Additionally, int aligns well with the return types of the corresponding
__builtin_* functions, potentially reducing overall type conversions.

Many of the existing bitops functions already return an int and don't
need to be changed.

With GCC 14 and defconfig, these changes reduced the number of x86-64
instructions by 342 (using objdump -d and compared to 0b32d436c015).

Summary of the most significant changes in instruction counts:

	insn	before	after	diff
	----------------------------
	ja	16044	15166	-878
	cmp	171197	170583	-614
	movsxd	16796	16271	-525
	add	94692	94454	-238
	jbe	9053	8815	-238
	xor	97499	97478	 -21
	...
	and	47291	47312	 +21
	nop	1036207	1036233	 +26
	cs	5622	5656	 +34
	int3	2815714	2815842	+128
	lea	118250	118488	+238
	je	190859	191132	+273
	test	204887	205484	+597
	jne	134316	135161	+845

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/x86/include/asm/bitops.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b96d45944c59..4d91517a395d 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -246,7 +246,7 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 					  variable_test_bit(nr, addr);
 }
 
-static __always_inline unsigned long variable__ffs(unsigned long word)
+static __always_inline unsigned int variable__ffs(unsigned long word)
 {
 	asm("rep; bsf %1,%0"
 		: "=r" (word)
@@ -262,10 +262,10 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
  */
 #define __ffs(word)				\
 	(__builtin_constant_p(word) ?		\
-	 (unsigned long)__builtin_ctzl(word) :	\
+	 (unsigned int)__builtin_ctzl(word) :	\
 	 variable__ffs(word))
 
-static __always_inline unsigned long variable_ffz(unsigned long word)
+static __always_inline unsigned int variable_ffz(unsigned long word)
 {
 	asm("rep; bsf %1,%0"
 		: "=r" (word)
@@ -281,7 +281,7 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
  */
 #define ffz(word)				\
 	(__builtin_constant_p(word) ?		\
-	 (unsigned long)__builtin_ctzl(~word) :	\
+	 (unsigned int)__builtin_ctzl(~word) :	\
 	 variable_ffz(word))
 
 /*
@@ -290,7 +290,7 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned int __fls(unsigned long word)
 {
 	if (__builtin_constant_p(word))
 		return BITS_PER_LONG - 1 - __builtin_clzl(word);

base-commit: 0b32d436c015d5a88b3368405e3d8fe82f195a54
-- 
2.45.1


