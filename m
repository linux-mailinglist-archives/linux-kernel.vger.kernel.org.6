Return-Path: <linux-kernel+bounces-327456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7B97763C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4EA2854F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3D23C9;
	Fri, 13 Sep 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Nu1pOB+9"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5053D62
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726189109; cv=none; b=LrwIOhzWaMJV2KVA1EmDnZpIpJK/b961LqN8ZxtJz+k9Ud0rivQemuf1vXpMyCite2gmsEkioiIK7icTCxvSg5AasNuKCFGFPdUtkDhn1dycnT6ekXKyDX8XHsdrVwYbQ0z/+wGspCxsfJplTmoCqmENYCMVQrlwnhHEhUab6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726189109; c=relaxed/simple;
	bh=dv5zqGalx/6pokySRq+zljqFqgGfrgBShqFj9/O9/KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F80WORgp+pVAc0G7HoiX+Emq84FoaQ/RvbbziQ70lixawa8cs+2zd3+H4QJabr787Ce1g7dYrG5aSjjiHzmBti4Tc4JltHYjMAYqQv2LbiIeYi4GvO7qD8ALUu782BDP2Q6DMlIlFe+LP/1Hon3JlQaeY6dFOqX16MbBNVtZniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Nu1pOB+9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ij4G8PuCmkQK+5g7ir8F6xcLkS3vHaWksgFXv59lSPQ=; b=Nu1pOB+9k0ZEMtux
	TtkA0YbcsIkCLO0n9dFHoqmg9mgC/4le2j+YkDvUeXiK7554F2MMGm8/jsSBxluiXty6jQhsGDtOr
	2KTXo/Ej8xRKCgY+18LGnQtV4fvP4t0lCRJXD6vedrzB7M3D3YPoNrnQFZ29uB3Sq9NOGopGfZ0aH
	cs/fbYjGNtb0o7KLV5PB/PblXknCBRYaF54vjj1mkwdj5K4WRFnKUk9SjxgGXM8gRdVkydjIgF43J
	p1q3E/FFiHf1VJEb+XaybW6JeVVoyj1JHhzjdV9A8qQL95HHj/G5JsHriCSv570ifNIr0oxIbxh54
	yfFdiwzijpWZZKSjpA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1soudR-005U6R-0H;
	Fri, 13 Sep 2024 00:58:05 +0000
From: linux@treblig.org
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] x86/boot: Remove unused function 'atou'
Date: Fri, 13 Sep 2024 01:57:53 +0100
Message-ID: <20240913005753.1392431-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

I can't find any sign of 'atou' having been used.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/boot/boot.h   | 1 -
 arch/x86/boot/string.c | 8 --------
 arch/x86/boot/string.h | 1 -
 3 files changed, 10 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 148ba5c5106e..0f24f7ebec9b 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -305,7 +305,6 @@ void initregs(struct biosregs *regs);
 int strcmp(const char *str1, const char *str2);
 int strncmp(const char *cs, const char *ct, size_t count);
 size_t strnlen(const char *s, size_t maxlen);
-unsigned int atou(const char *s);
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
 size_t strlen(const char *s);
 char *strchr(const char *s, int c);
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index c23f3b9c84fe..84f7a883ce1e 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -88,14 +88,6 @@ size_t strnlen(const char *s, size_t maxlen)
 	return (es - s);
 }
 
-unsigned int atou(const char *s)
-{
-	unsigned int i = 0;
-	while (isdigit(*s))
-		i = i * 10 + (*s++ - '0');
-	return i;
-}
-
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
 
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index e5d2c6b8c2f1..a5b05ebc037d 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -24,7 +24,6 @@ extern size_t strlen(const char *s);
 extern char *strstr(const char *s1, const char *s2);
 extern char *strchr(const char *s, int c);
 extern size_t strnlen(const char *s, size_t maxlen);
-extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
 long simple_strtol(const char *cp, char **endp, unsigned int base);
-- 
2.46.0


