Return-Path: <linux-kernel+bounces-550512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF6A5609E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692F57A9C69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD6199E9A;
	Fri,  7 Mar 2025 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7yZBrPw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C5194C77
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327938; cv=none; b=ejWzoGS3/sPj4Y+sNBP034na0RozSBM4EpVutsSX0Jfh2a/qu+wdMboQLtfg6LaGdQWc0P+nlOK92YNZxpdM6K26P8yxIgY5f76pGDz3g3gsoFGQkBIoIsomV52GBJ9Xhp4QwNrQmMI1JYDkj4rBQAy4jbtsxtozKKfbt9tOHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327938; c=relaxed/simple;
	bh=SUfC7KfOALJ5wxmePH27qRlLAbIWKbJNM73jMjKempA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkOPs4lVXHDU4Ay6OQdw+Il3MpQfJTf2XLaB6418U2C0iP+MDhMlR4vv0pXQaMTBb9ogmHCJ911mWpvQj3sHeAaeLQLB9ZL5WHL/wqe49726IkZdoFbIA64M0HkK9fBX8tv1zLwYlYzeb/RYTwnTClQoCnC41tUJ5zzlOL9p0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7yZBrPw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso683602a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 22:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741327935; x=1741932735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyG25qKRa4ECc4XnSGWcWGpn3t3HI2LhpRSGp5OKczg=;
        b=D7yZBrPwC8GUKJfg/izFkBWA5JKRiY7tMMVBvcjpfsyewhH3Tlu5TWnfpKEcRFxyWv
         e7bwkLLjgror43G6kT7xXWM/mZzt+3ITrI68GpucuZF3FrNzWt5W0T0oP/YbNneQHsjX
         GIOVrx0aO7EtYfNwFuoJeQmJ18iolpa2YE2eweV9GVfIX2YW4wpPr1LXXLsQf4PHYXAJ
         brifCG5Zwdxs0C5PBPgxmiTP4Qva6kJqsfLZ1NE4XHLSnZamMN8RUxPHd517fVtYXOm6
         eD3ffdFxN11X4et1tWrEH1F4cSl/kwDTXokAhqWc6pe2J3/P+FmNGYF1S6olcFmGnyfF
         h1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741327935; x=1741932735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyG25qKRa4ECc4XnSGWcWGpn3t3HI2LhpRSGp5OKczg=;
        b=CxEd4zTa5PTmd03D9d+OLVijqMMT8MoF/wXkO4gXm78st8/iiJs94VxkwxPlqqhkFB
         x13YDwIu+8xwdNxy4dPz78tEr19PQbtVfhoNF5Jn9SgthbqJrg8rcGUbXV/f+Y+FWtL4
         /uqGBmTuGT5Qf5AVuMX3ceCkPNJZAo3j3RzaGeSobWIBI0Jtp9OS7l/hpS0atH45o/yO
         K5OqaZXMy+ZF+30FNQ+OUvYWI8A7rTpZdNq3k3ZonBFM/1IcaFWmykhaTclUUxFy9yGM
         FmJugfl7JskIllfSQ45sdbnRTEj9hZkoW4hubEsJknLr4ch2kU+fpFRTVU07yiJ1YDrL
         iHyw==
X-Forwarded-Encrypted: i=1; AJvYcCUdPCliQCEm5wiajFbCM+OEkiNWZRGcxaYqZ9UZ95JDt+U+X9VzfzxvyerezpgqsmGtvtEzOz2ecrVooPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZCHKUqWhCp3ZgVaJdc9LoP38qWxT2lz6PjcSekznl8bgBvfa
	B6i0EpfgdC5pkQtzluMi8RzmDZp/T2SwY+7go5vHwEGN/SnGcE8=
X-Gm-Gg: ASbGnctv6UStHrUuWxoMTJa7zCD6i3YL2qaViM7DqDRLZUkUYLE27CKB2VNyEkoJfcx
	E6bowZp/wyLLYPvEDwQ2fgEvsA9f42x6Bq5vF2JknL/ZvNOy0fE6WK5IAkA5lrKVholsZilpLIr
	Hnw8a6VO/bB+3oAbS33gJhv0LxfOrRDweHjdVOTEP25wk0nd5dUKrofBvEX2SG+poTp+q633h5x
	Lu2BfpE8sw7rmgXCXzUTEg5t8Gxk5SiqkthHsDcjZNW7f1mUjTirHvSphTolOYH4WjbVrlr7rdd
	UkaFFPv8hSOjTtE5wnO7BYC9v2fSV7JXKfcB3zzW6EJcHmlxCQckFLFL
X-Google-Smtp-Source: AGHT+IFfs/8FTfsbkybk8G4LIOP0nCJV5Du4CrPbI9l1E84oUsLvwRWcih0iTDX1ePMBQBgkMZ+qig==
X-Received: by 2002:a05:6402:4021:b0:5e5:e78a:c500 with SMTP id 4fb4d7f45d1cf-5e5e78aca9fmr3350967a12.12.1741327935313;
        Thu, 06 Mar 2025 22:12:15 -0800 (PST)
Received: from localhost.localdomain ([178.172.147.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdd8sm216824166b.138.2025.03.06.22.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:12:14 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 1/4] x86/asm: inline constant inputs in rdpkru(), wrpkru()
Date: Fri,  7 Mar 2025 09:12:00 +0300
Message-ID: <20250307061203.3281-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put immediate values directly into registers deleting dummy variables.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/special_insns.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 21ce480658b1..494a1aa19f05 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -79,7 +79,6 @@ void native_write_cr4(unsigned long val);
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 static inline u32 rdpkru(void)
 {
-	u32 ecx = 0;
 	u32 edx, pkru;
 
 	/*
@@ -88,20 +87,18 @@ static inline u32 rdpkru(void)
 	 */
 	asm volatile(".byte 0x0f,0x01,0xee\n\t"
 		     : "=a" (pkru), "=d" (edx)
-		     : "c" (ecx));
+		     : "c" (0));
 	return pkru;
 }
 
 static inline void wrpkru(u32 pkru)
 {
-	u32 ecx = 0, edx = 0;
-
 	/*
 	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
 	 * requires that ecx = edx = 0.
 	 */
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
-		     : : "a" (pkru), "c"(ecx), "d"(edx));
+		     : : "a" (pkru), "c" (0), "d" (0));
 }
 
 #else
-- 
2.45.3


