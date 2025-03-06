Return-Path: <linux-kernel+bounces-549897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF3A5585A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322B43AEA6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079F271801;
	Thu,  6 Mar 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWcUPP1e"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FF207A03
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295254; cv=none; b=GPF7D2RMkwZ2gxyuKZGAj2Yb44gE9KKFJpurKdmAeXjZVFaxF2QzHhQsIntAEQm4YWWQEt5HOQNoAWRKO/q+oyOk2FRPz5VyvHkLKoo35/brNPLByp3iJwSLfO6FSEQO5pO7yur90Sp3QiP7Y3QNrfMJJEHEua+KX83opJsafNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295254; c=relaxed/simple;
	bh=SUfC7KfOALJ5wxmePH27qRlLAbIWKbJNM73jMjKempA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buGi7BARp47+VzcUs0DBB8KJO23ewcc5vYrZd2T4McK+bx5UO1wcKlQWGaIe6lpJQzkzGga/vsqKbOnY7VZwmxWEtSXpdfdY6y7iPAjkE22Cj7+xFrwc1Z1pG9Bxpcus+ep/+naCYjh7OWzIO4yMFmV3SNL1pHTSjgL5sFP6nFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWcUPP1e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso222135766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741295251; x=1741900051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyG25qKRa4ECc4XnSGWcWGpn3t3HI2LhpRSGp5OKczg=;
        b=lWcUPP1e3YJ3zO0eGBtqvePaGm2rkLa3zLqflwL5YCWzMA8Iwh8tQ0apotfdXSsMsi
         5bNIqg0EmYwIR9fVzpaIvYUFDpYvUuZP6ExPVwMv3WymXrm/KeLZWUNQiupX+N6ZDVgZ
         Qolc29M6B4uPdh/adjIoi1dU9zRAAOWOsrVfr3qPNDxzaFm/WQ+o4wOcf94YPCewPn90
         aWPvV7DE4h4eHFT97yKF+DZRtDnozGOsPkBoyL124B1BCxghmKShA8yBZ6PB0D9AVN9z
         nyl63nvmHfngy7ZjGlVW4sDypjZKPVXhfT8w7nz17f8sy1KAHA3oxYo3yaC+UAOif7ht
         JQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741295251; x=1741900051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyG25qKRa4ECc4XnSGWcWGpn3t3HI2LhpRSGp5OKczg=;
        b=pcSmYSXELV2ZqA1KTf2kx3DWgOnvDO44EXKBxHlumu8kZng1uqQnd2olWpWSeZhGvo
         AHLq56otmsGZ+jhtlTFGygVdOwcCU5MLMkuciP9bg33Rx8FIeOrjRnU6Weh86ss4VjMM
         NziTb4lmLrAODy5A6zddw/bAPYf6qBE/Uc9CxOVrT2CtMtz3OlkQGFyn7Ii4eikJBi2q
         0ONuZ+qFP/5JK7pPob3XEGPbfr9kyipeueFiHJH3xbLlN9n4PNivVKRZrgYCRPJPeMzx
         RaQisysBLOQqDmJY8EMZRPSCbk0lXF99LtpbRslG+ystBJ2NVQUIV0eZtSwUHzlcd6U3
         dQJw==
X-Forwarded-Encrypted: i=1; AJvYcCWGw4nQ2JW9p1g45K+yNs2WwT6Eh+gmuX1Jx27FbgPA1fB8d2LUGczqSj5H8N291ENiHyqMjBmmwLh0vuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjkvhfLIzPZ/sSopjqkFN3196j1T7Oh0DpITh/4vWsmirH0nE
	Ear4PU1v3VsWv8gbPLJBWUZlKb1WKD5p7ei118VeZTVzHvsxxqA=
X-Gm-Gg: ASbGnctsHkCVkm8EFq6EFbSLsYGOMK0XHidOQyx2hyqJmfiS3hKR3LK+bMQH1Dur8N/
	El/3TOi6iUgfPi0QRodyr/03OQJ7L4loEeQOhqFg5U6kQap1O8DGgAsqNY8/qBYv3j7aC5GJeRq
	U9URZdSKq46Hb0oCE/yrqx4YwL6oA3Q0N19brxFotun8QlNhLPDaK8/HOar58XWGt4eZSsVJxrL
	hiyQ2GCXEo7/QHPvcq8NJi9V5g3i1i+LAWZSkXHlmXm1c90gKYiV2gfPIdwo8pba1XIuYXoRL3c
	4qJtJfD+wGjuRM8cRlVwC6GkZOaRzJWEr5PXQIz0mq5MZbOSZN5iJQU6
X-Google-Smtp-Source: AGHT+IFvQu2fs45MrDfJfgbBHbkmwyznT7xbWT9LbdmFzCNrOMUWuM3+3EnBKpWhAmcM+YyIGuGEHg==
X-Received: by 2002:a17:907:7f89:b0:ac1:eec4:91f7 with SMTP id a640c23a62f3a-ac252b374e7mr59632866b.27.1741295251099;
        Thu, 06 Mar 2025 13:07:31 -0800 (PST)
Received: from localhost.localdomain ([178.172.147.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394883c2sm154678666b.65.2025.03.06.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:07:30 -0800 (PST)
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
Date: Fri,  7 Mar 2025 00:07:10 +0300
Message-ID: <20250306210710.3403-1-adobriyan@gmail.com>
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


