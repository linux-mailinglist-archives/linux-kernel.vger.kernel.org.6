Return-Path: <linux-kernel+bounces-380471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C699AEF29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65096283048
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA61FF05F;
	Thu, 24 Oct 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZa+XP6h"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEE1F76DC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793185; cv=none; b=YOFy0z4zGG9eubNfEgrSP0IY/D2kPe41+reLtFiMrnTXak+VMYoqZBcM6AQ6wJnuI9FFh381gWOIsXpfdXPZWaD1MYNrr4skqhDnqO946oBP1B7WeX3fWYNlkaJcb4s45yDMZI7Nrfn83FvyOd1rDVzX/9sBL+7ylEyXAq0YjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793185; c=relaxed/simple;
	bh=GDtJXjN944t/dd6KlQDlRbH5k6oyDHJjLRQO10PA6dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAnFcLzuYBBQ+0GTg3LTl9p5fLgmVac5lUrx1XWSMRxJrBk2syYoSPMXrruXipgvCKohqWNTGZMZVibwaCF78crttLmvszjHpIQIRXxqVUwXx9t6Ab80sVjZ5OqFNmde/kLFjDgL7tME2bzubDS8cr84XNxgKdiRchN5XjzR33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZa+XP6h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso177381466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793181; x=1730397981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puDshiaA+XhWAGIplIG4B4fPu70/MjcqXtqTkd9Ez4I=;
        b=lZa+XP6hXyTBRZOOgP1XXj+9veEE9A8l8+l27Io/12NNk7NpCEH2Qtx1Jqc2649p28
         9UBJETomblfDl1l8r+ZVNz9sdkCL8y6UMXY+pzlKNdDDfeooC946y5IpukmgC5krUc36
         saVjulLGYFWQB2m0E2Mwl1DkzEj50jSREwD8BIMZxDTgV9KPSrIlCwKPZPqk4TWQBmsZ
         Qz7S2+pGmL2W2TDBkhaV2j66qU0ponvIu2+uoWXnVJl5af7u83nZ8l2dDffU04bbLMyC
         1pOBGPUaaUsKMoUX1Se1kIMzbu8bifNDC+VUgSo7JHp3cLHv8haVLrk277Eom72l8ry2
         ZiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793181; x=1730397981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puDshiaA+XhWAGIplIG4B4fPu70/MjcqXtqTkd9Ez4I=;
        b=gxWHdXrjMdlOQp7ew8xwvEDiD1E3X9XDf2ewFYyaLLPNZXFRzH0l/WbNi4nys9B9CW
         EJMPhmvQVzjt6Db9GWpu8lgEX9B5wljqcAhHjsQeaY1BpIp7UKH11c60nXmEy8mKnOIx
         ipX/m/snqV1bLZ05Rlm51I1d14reAUsL/dKPyuNmqbP5cj3muyiJy0K7Px0aC4Wll1Dc
         erj9YdtK+zTy9Si+xzlZg6G5tOGgHyHy4/bIg/vhWxdajt+VEnJXiVPlZ1DARxMnJNzz
         JzByGW+V8HvsUyGNGrQyoosc4WHTbe9pthxf8ca5HLKdvZZ7RL3zPgqD7o08H1DWkbjN
         /nCw==
X-Forwarded-Encrypted: i=1; AJvYcCX36z1ygwHKBk/HgLfZgQh/3WOlRx4CGmSJ07wZDYvS8d7Yzz7uhemzrSUobZ4/t5B359OqAqOgCzQPhDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnkxCIDGfdzWCX9jslOZ5QvQQ58/l3OzVa1v8ldFtwRf4TuTA
	vGDEQhjAIeKmg0WzjQK8mfEhvAAfK+7ifcfymujeJP5Cahr3h4J9E21Rfw==
X-Google-Smtp-Source: AGHT+IHAcvmaqOU0mQ3uhJudrgbkxvxRXsjs4LIDyejp03soCAfzCWis4CutoGNxdydmwdWYfeiWDQ==
X-Received: by 2002:a17:907:72cb:b0:a9a:1918:c6c6 with SMTP id a640c23a62f3a-a9abf84ad47mr738752066b.8.1729793180982;
        Thu, 24 Oct 2024 11:06:20 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571ea5sm644337466b.160.2024.10.24.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:06:20 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] locking/atomic/x86: Use ALT_OUTPUT_SP() for __alternative_atomic64()
Date: Thu, 24 Oct 2024 20:05:13 +0200
Message-ID: <20241024180612.162045-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_X86_CMPXCHG64 variant of x86_32 __alternative_atomic64()
macro uses CALL instruction inside asm statement. Use
ALT_OUTPUT_SP() macro to add required dependence on %esp register.

Fixes: 819165fb34b9 ("x86: Adjust asm constraints in atomic64 wrappers")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/atomic64_32.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 1f650b4dde50..6c6e9b9f98a4 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -51,7 +51,8 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 #ifdef CONFIG_X86_CMPXCHG64
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
-		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
+		     : ALT_OUTPUT_SP(out) \
+		     : [func] "i" (atomic64_##g##_cx8), ## in)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
 #else
-- 
2.42.0


