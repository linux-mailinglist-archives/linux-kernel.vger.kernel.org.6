Return-Path: <linux-kernel+bounces-294650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350899590CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B241F22B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4181C3F1A;
	Tue, 20 Aug 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Zqyqb2Yp"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B118DF94
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194808; cv=none; b=ilXSUZmiUM49HPC3RtAyLsb2jIDyBtrTEdCvFzhaAa6H434+guXzZNLgyCVeL7GJy4OXKgYFI/JIMJqVgnlF5KXJ4L6ppt3kwzDr6sfyL06jlFAh4CGevnZJxJLBDiALw3HSb2yLzASAPKI6fXcGsSucjjtJK2X29/p27e1KgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194808; c=relaxed/simple;
	bh=4ezca/HbuzIwMSXgMe2LRyvA8up1CSnzxc4yOt6pysQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJhcM44GvFqmRWv2tsRsmzdZcDngleUjOfbEzu9P/sUolG/DUDJNdHgpEv3bt6mUzB/sUlQ42eHi/P4z0yP8eB6EJ6K09i+txqM7NvqwJ6OMYk+2re+sxTK2u455bMAf0KQJayYn/yWxVX/N9ttrV9Ww6X2tfx+mFvQGsBD/Yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Zqyqb2Yp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86681cd0d2so230866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724194805; x=1724799605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Job/uX2MYzjKTJ++ttBnOuppDpxmyaGi0fl4BcognWk=;
        b=Zqyqb2YpnPRmqJVUG7dbMpWUAO28p79ka8VPs7uxt00EWu1yBMZG1Ve5OQeooFSh87
         js9Hgb+Nzu/TGFMtpjj2WLVtgEKxlE9VIwBgypAR0gjk6SoqBHc0QalUNSKgeQto96+n
         sFEkFwdxzp/AJ6IXxXHpOpjEYFdDhjXcDNGCmjmdxZ+Fg/Jvn3PZDPHpq6OqFjaGZ1tw
         zI0wEtcZQVyupshNcwHAv90zRBst8CrgCRpenbAWPXUp45Hq7zbvILflNIuLsY+A7ZZ0
         FjQezWpD7lupHY2utOVDv8UfmJD3tPAewdSxFwTk+7wz1kuO792dYRnBelAWA6GyyD08
         7xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194805; x=1724799605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Job/uX2MYzjKTJ++ttBnOuppDpxmyaGi0fl4BcognWk=;
        b=BjK70E0crWprDcPa7FERgpNohI0LizaynQB/yhS8IwRs4phlhthmt7sQKsMuIR5IZ9
         YVBnthQ7lfUcDKpZKiEE+H4mkOsv6zWJXUl+3vlhvKgw8EX4Zz62SNoTNBsnAL+jUoid
         +q1/JMcei2o0N2pZIOythXHnOu3kdSyapfnxYvST4HGk36rtMWh/u26cfst9ejM3xXxg
         M0kZGpHX9lPATxCzOmjsgyz1erAH13bpzmxrNhoD0Lyl2NJeXdx69nZu2vbHssN4c+sc
         qItOpgivpzPQdn6jwEiS7Nj8/5ViAF1asuJ6Rwd4LP9Smz6Oyd9Mn49Ql5vWV8bZPi0F
         NTVw==
X-Forwarded-Encrypted: i=1; AJvYcCXcPv7qMc7UDdrYT46x3yTehAmjYlzw7On2SaHjJTMERd3smEjMYS3weWm/VXpKp5f2gOE8S1R/k7fsUtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygd/Z0+r5jJRQoN01f9Jpi/wWkIKN2Kv5usqsd2k2IqsN2CDOb
	O5hIBO/VyxImkATF8qd7yB1xoopBG/utfXw00WC5VXzIIbb3MfzS7W7uGoN7gCw=
X-Google-Smtp-Source: AGHT+IGqlEEXsKqpcS5s1O+/2//UMr4x9harZHJcj+McT1D6iUWdMCWzBCLr14d0F+fhlfTlzbQ8Bw==
X-Received: by 2002:a17:907:94d4:b0:a7a:9d1e:3b28 with SMTP id a640c23a62f3a-a866f8b3545mr10983666b.5.1724194805029;
        Tue, 20 Aug 2024 16:00:05 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8667cb4ae8sm48779866b.192.2024.08.20.16.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 16:00:04 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] m68k: cmpxchg: Use swap() to improve __arch_xchg()
Date: Wed, 21 Aug 2024 00:59:02 +0200
Message-ID: <20240820225901.135628-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the local variable tmp and use the swap() macro.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/include/asm/cmpxchg.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 4ba14f3535fc..71fbe5c5c564 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -3,6 +3,7 @@
 #define __ARCH_M68K_CMPXCHG__
 
 #include <linux/irqflags.h>
+#include <linux/minmax.h>
 
 #define __xg(type, x) ((volatile type *)(x))
 
@@ -11,25 +12,19 @@ extern unsigned long __invalid_xchg_size(unsigned long, volatile void *, int);
 #ifndef CONFIG_RMW_INSNS
 static inline unsigned long __arch_xchg(unsigned long x, volatile void * ptr, int size)
 {
-	unsigned long flags, tmp;
+	unsigned long flags;
 
 	local_irq_save(flags);
 
 	switch (size) {
 	case 1:
-		tmp = *(u8 *)ptr;
-		*(u8 *)ptr = x;
-		x = tmp;
+		swap(*(u8 *)ptr, x);
 		break;
 	case 2:
-		tmp = *(u16 *)ptr;
-		*(u16 *)ptr = x;
-		x = tmp;
+		swap(*(u16 *)ptr, x);
 		break;
 	case 4:
-		tmp = *(u32 *)ptr;
-		*(u32 *)ptr = x;
-		x = tmp;
+		swap(*(u32 *)ptr, x);
 		break;
 	default:
 		x = __invalid_xchg_size(x, ptr, size);
-- 
2.46.0


