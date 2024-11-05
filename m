Return-Path: <linux-kernel+bounces-396735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D529BD164
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08861C203DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC51DD0CF;
	Tue,  5 Nov 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0I8VELd"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5117154430
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822312; cv=none; b=gmuMRwNDwSVc+5IWeb0wlin3QUIN+vmAIm7WBVepLewZNxV/CH3rb9sTTXWqTXvl69/y1ERfyaz3XJ16oTqRzEASA4od1SxC3OfyIpzPwbSj9/tm8bpXBEzCPpO5Iffwq5v2gutjFq4mk1S4f4h4VbbD6jm2x/fw6IZqPNXmNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822312; c=relaxed/simple;
	bh=S2HoaBKy6z1j9aGSaozTsLk4YS03z3lZSxVfuzo9TYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiCZybeZDHlYN8nHdKNd+MR1e20mIf/xWyj2uU8f/KZwzIdS3/Is4NHi96qzu+fVHvhVQBvYTD2BnEWEvTll5x7GMuHxIsKZRATXYsVVYejPLPkd4fF44FPcE/iZLWbyyVTM+n0511gGbK4G08t31Yd7ZFYKLtv7Mat7x7ndmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0I8VELd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7181eb9ad46so3160806a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822309; x=1731427109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbRa1PSZPGrOnXl26Nh7aIvi1PhhuN4vNBAsvslx+q4=;
        b=G0I8VELdBoBSm9dmEmEQxsxj2raSQG5t6Uz7MyL1MtQd4ohnIUWpFFa3qruOcQ6Ynd
         POW1Lg70XbQCOt4G1ixcMtcZEP3ONqof2jvrPnANz+f/k3MhaCb+sQLL7RXAldCC16Fo
         9+TrzpsGZsYe3fI3TNLHmiBxOGRJ+vynEbZddDc/0KdF6zKtsiGHHtUi1K6KPiIjvI6o
         XdaIO9gG7zPezMZ80a6ME0/4Hpq/zQDGV7Y2lDGHKIkcr1H0rkWDNuWYJ1QjaqzuwZKn
         +lNol6YNs73Vg0Aer+vzMlbDR+YoHVpiS32E+z7cOXQxQtsceqtPqq4wpYVbCed0wZco
         JfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822309; x=1731427109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbRa1PSZPGrOnXl26Nh7aIvi1PhhuN4vNBAsvslx+q4=;
        b=CbqmjMimPiXN1zpc25DbwU3mjDHRrItKht+66G/MPmV/yLksi5y1tee5/pkN752Gcq
         ryEnwsvqKuivssuQ9QITcE3ZbPpV2lJ8V5FfcJgH2SGgHcQl6jmWi2GQ80wlhdy0fXyd
         CRpiIvqLGJPeLTI06gaE4LI3zn950SVFvP3IraaD5OOdnSGs5f0bXs6EUJU4UsK8c+tr
         xi2N8N4xulsh/Qi58YTx/KRNr9ld5V7Pv/Wwgh/qircqDkP926z6xF0u5ZK1iGcGjSkB
         FvMz/7yNK/jCpKsFapEQWWadmg3yla6y5nj14+JKKzvsdXSKHp39fZ+mmi9uKSQ36vvK
         l5/Q==
X-Gm-Message-State: AOJu0Yx6uV7TZmmy/Z7Cq6PpDxAKL/c+B0r/SbZ8om+cvOU3WllIwUtZ
	nwaOZpiY4Mrqhwv7YmoReoRspPEwtm9W01muKooa0JR71RUOwVp+uaKW
X-Google-Smtp-Source: AGHT+IGLgFAC7TVHdk51PE00KsD/F3XL1LCaUmbiEhqWt127v4d0Ih/B1vk/JY1kfTxagODV6Iq0EA==
X-Received: by 2002:a05:6359:4c91:b0:1c3:724e:f4dd with SMTP id e5c5f4694b2df-1c3f9f615f2mr1797455655d.21.1730822309300;
        Tue, 05 Nov 2024 07:58:29 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:28 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 13/16] percpu: Remove PER_CPU_FIRST_SECTION
Date: Tue,  5 Nov 2024 10:57:58 -0500
Message-ID: <20241105155801.1779119-14-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86-64 was the last user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/percpu-defs.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeadbaeccf88..70830a742095 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1034,7 +1034,6 @@
  */
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8efce7414fad..a28fa362d685 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -26,13 +26,11 @@
 #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
 #endif
-#define PER_CPU_FIRST_SECTION "..first"
 
 #else
 
 #define PER_CPU_SHARED_ALIGNED_SECTION ""
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
-#define PER_CPU_FIRST_SECTION ""
 
 #endif
 
@@ -114,16 +112,6 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
-/*
- * Declaration/definition used for per-CPU variables that must come first in
- * the set of variables.
- */
-#define DECLARE_PER_CPU_FIRST(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-#define DEFINE_PER_CPU_FIRST(type, name)				\
-	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.47.0


