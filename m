Return-Path: <linux-kernel+bounces-532350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D6CA44BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6504719C6E14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0D19D071;
	Tue, 25 Feb 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEQnu2Oj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014492907
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513767; cv=none; b=PApstFI57BI4WgP2tJGESrhFtxKlYsQqZh+cDgfRX/6YoYcgdGPoNyYnOLHRDr5M6c9rjHzSBTQLY+bEY8WZCrFCmbQAOlTHfxONpiKnBDlLQg1R5yYShvaOmpXHBdfDNQDIbbxtXN0GpHVhb2TtlLMbg2DLnmhWjVtDa8c8esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513767; c=relaxed/simple;
	bh=4qrl5bjmSVCvMCMSFa+LqAuS8aSu3VYul17BVNW5q48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqRM1zJxxn4fsm74Ke5NJU9qxCqMk0vID7ugoMxtjVAU6ykZS6AHHgWnOPrKnUN7k2/TiNJcf6XfGnhuOYalC1Vd+JxFQW1yri288G6/3z40oUYq/D8qcrum12cqaSBlRQ59iC2BN68SyUFTH2H8ePmqdwCHUb7wjUm6TCZkb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEQnu2Oj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so337878a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740513764; x=1741118564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu4wgS23muTwabbH8/wdDm76fiP9CrNOTURYvidM7Ww=;
        b=EEQnu2OjusOEf9YIlOmC1qo+3MttgrcWO9ObU6coVbLDpg1G1xstir39zuyvnu6YKp
         GBodxwT99w7My+TE5GpW/KiJhpJsBjgMI5s4lUOB6JR6WrcBEDj45ZZor/dRK+lQJcAz
         EZZJPK3/u6URDoGaCkUEWAtbOEUwsEI8MvopEznJFLprY2Fyh6sidvTz61nO2HefKwmp
         cwpHZFRIpBRYf+MPJE1m6gG2lFiQRzS+1nZ7u0ljy8LLZQo0YQh+TnOCoptDEFlK9Zpy
         9ngeuZKtnL36TI43zXV2+kc3LqUSgFsdSkQLo97WMzDXIP3OgKIwjvQVXuPHlxH1bPAY
         LhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740513764; x=1741118564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu4wgS23muTwabbH8/wdDm76fiP9CrNOTURYvidM7Ww=;
        b=SCHEQRpMlaSmWxkMHoeCLAIQChZRO2auv8r62CQUuX+GxDwjL2sbZnvLF+D+jMO1uY
         7R//mbnMQPZTvWNtlZs3z31T5Bc6OK0avKbRnJ9HNdLU6sor5K6TlO5OisjmeunM6tq5
         d/VkcIV6tFnPLvX6DUVUiw40iKK2PWkOKlgPv8NEG8u1lF1mXUjxONo2yLgcktAVUW+O
         sHy48JULoHe67sXbhpK4rtiI/bDl3P7q6V/y5MeDs7d3wHm3IW2M2obM1Mb8Sic7YjaC
         jaeJBim9/FPcFIE1EnblV1fiCARIK1rKY9u5h/34VdotDaxX5Xjvl4klqwk0Dhim+w/y
         OTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHRgRvGUBKkvGUEQOKQBYOmQWZa8qg6iF+nyeE1F40gjtbaOYomji1hc0kUFEFW92+I8tnhdRTjqSsgT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XJKrt/dpfaYya2fsjHtYq12932IIrnxuxfQqYyOmeCH4FoWF
	S4oEs81C49+6BfVJ2hgnUfqU/SYX5xTbY/MJfHkbYzv7O212HLnY
X-Gm-Gg: ASbGncs8o9uNPoho/XYEiKyDuprzjEXJaB6rcIhCikrwAg+FUDJ3x59NQFFTJW0KqoM
	OLH06IkathDCslQQAvsmJ5FjjSmiZjhXcjGtNdCeCm9gHHKHhLincOObzIXOsXMTD4CVIPGbsOd
	kHnBbSP6zWUqR3x8+Wxd8LAwObUzENN/S7HfUekDao0aG2kZ8LVwgHZdSws2RqImlkJjL/ZEck9
	vQOquV2nzgzooX7iMbttKHZSfxNl8s6HMoBln3EUz77C6DBxqZRfkkghZ/dPqPM2AzyOpZ4xnyx
	j+o/31eCaH0MLsQ3drXJ6beZ+jWHlayFzTc=
X-Google-Smtp-Source: AGHT+IFLUcxnEXQoTE1kvdNpckk1fwMflWZ3Dy1anPYIeDmYOiPOJHN8DHAbZO8h//Fv5u6UPtFW2A==
X-Received: by 2002:a05:6402:524b:b0:5de:50b4:b71f with SMTP id 4fb4d7f45d1cf-5e0a12baa86mr18751217a12.12.1740513763995;
        Tue, 25 Feb 2025 12:02:43 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45a8b8b48sm1683613a12.20.2025.02.25.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:02:43 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/percpu: Construct __percpu_seg_override from __percpu_seg
Date: Tue, 25 Feb 2025 21:02:20 +0100
Message-ID: <20250225200235.48007-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Construct __percpu_seg_override macro from __percpu_seg by
concatenating the later with __seg_ prefix to reduce ifdeffery.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c456e54adb73..8a8cf86dded3 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -22,6 +22,7 @@
 
 #else /* !__ASSEMBLY__: */
 
+#include <linux/args.h>
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
@@ -35,12 +36,7 @@
 # define __seg_fs		__attribute__((address_space(__seg_fs)))
 #endif
 
-#ifdef CONFIG_X86_64
-# define __percpu_seg_override	__seg_gs
-#else
-# define __percpu_seg_override	__seg_fs
-#endif
-
+#define __percpu_seg_override	CONCATENATE(__seg_, __percpu_seg)
 #define __percpu_prefix		""
 
 #else /* !CONFIG_CC_HAS_NAMED_AS: */
-- 
2.42.0


