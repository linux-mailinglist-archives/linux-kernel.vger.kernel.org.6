Return-Path: <linux-kernel+bounces-176366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BEF8C2EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39511F22A82
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226812E47;
	Sat, 11 May 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnAtFhwP"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59212B77
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392658; cv=none; b=ju7mPeNuzvkf/nHO9ttTCV9ZZ7BQd1sf511haWu4zp36sBIkmNPbLH7t5j63X84X6Rm3MFP5HswdePNar0lWGFRNxnE+e5GdZOFXzuRG7YXPuXLGfU8l+yQQtNeAFWy82PZjkk1vB+UNxdHix4NcVQ1AQqkjcolSAPUNXf2vP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392658; c=relaxed/simple;
	bh=AJC2mCYdBEAB2yez3Aj37T4b7L6YTebK7eBiJf5Gaw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NV3Guc+m3BYwKILPvaoUTkTJ/elD8n/ebj8Rn5cdAF70g120LrSKcKeu+wiGAXY77nxfA0L3fLZRTeFIV4fvR9vMsaLIO9h53/teYGDC6fsotTRpunr7iU7Ub3tUkYX5iL5tUlMkJv69syislUYXBISsfssXe1qAogqVeJf6TO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnAtFhwP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ed012c1afbso21364615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715392656; x=1715997456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wZqXklLg0B4d9pxI+uMj8pVTiukxNVXaQsQAgYgVq0=;
        b=FnAtFhwP8Fv6UEy46lgEeBmWdu3oVxzmvrQJshPbnxd+HG0xfQN1wUBtyIYCaikNV5
         +AtCR+7g+qMiaShpozQbGTMDoxtLOeCymBrLvxcBtK2JZDgW2qsdTEAJj2nmoEgh+n99
         W4VwraDeaUQ2CBOGbHkd0w1UPfMrEa4OjQRwCpdJRaVWFgLWjlEhY1J1D6LhcOwqY6Ht
         djBSMj7GTLe2IoMEPN8yLUcxsbt1/+QmMpIVUEHBrC9yculN/ZAEmWFmycPcctjH4wWL
         S3QAgjJD2k+5wEJxspErs4OmGTsJ44BfFhxpMdryTlFwn4EQKE52ypWEQJWMXRs2W8qi
         8NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715392656; x=1715997456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wZqXklLg0B4d9pxI+uMj8pVTiukxNVXaQsQAgYgVq0=;
        b=r3o/hqSV2LdwwRx0PkHUfGdfeyE7523sxsX2I4toTiZQMiOimwDNdhZOeDg+SBJ9kZ
         0vwrPbxpvWXxlwrxU62avLE/C9PwUF8THR1QmOlpteu5aSakCYVYv2JIQZ3lgmfniwe6
         3Pl6yyM0KjRacDjCkkX6yQEZmsqgZy+kffSEVThbXJCougSxtgHC9flGMAt8D//KvXSk
         kiuWWieyuaBqEvLUCr6dT/8G7M1RE7CJ62hLmCcWsAHDiJnJWIxEk12VjZWhBoYg1cP7
         7yyKX2vvy8RGVr4JyzZTsABZiAxPa+fJyYLAxTQM3xQXqD0CQg8jfwLhOHrlhiKymPMm
         CoEA==
X-Forwarded-Encrypted: i=1; AJvYcCVpp/06z5ln4QcY3Pojq4Fhgkaq9XXBzUJW1LuGSfrt74VvlhET7u1Bf5NWt6aVN2MmW0SNixZ4x2BFuy9QugVetCcT9CSnuyYb6juK
X-Gm-Message-State: AOJu0YztoKasuEVjIfptyU0z+galfZdr6Vt+P5qurDX9Sws6jqFdqH3a
	z0PIK0ZAhhpreM0L1C6QWrfQuHycK1rfcjyNMpye9JmQQwagT6X0
X-Google-Smtp-Source: AGHT+IEux3ZgZ+IjmOlJTT4iyWCBlWPONI96OiCEBJb1XXZu2Wuj3k7Urkco5CuV88bSPmjSZyGdng==
X-Received: by 2002:a17:902:da8d:b0:1ec:8206:626f with SMTP id d9443c01a7336-1ef42e6d9c0mr66859535ad.9.1715392655780;
        Fri, 10 May 2024 18:57:35 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6249:183c::26a:94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm39075565ad.68.2024.05.10.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 18:57:35 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH] riscv: do not select MODULE_SECTIONS by default
Date: Sat, 11 May 2024 09:57:25 +0800
Message-Id: <20240511015725.1162-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

Since commit aad15bc85c18 ("riscv: Change code model of module to
medany to improve data accessing"), kernel modules have not been built
with -fPIC, so they wouldn't have R_RISCV_GOT_HI20 or R_RISCV_CALL_PLT
relocations, and handling of those relocations is unnecessary.

If RELOCATABLE=y, kernel modules will be built with -fPIE, which would
reintroduce said relocations, so only select MODULE_SECTIONS when
RELOCATABLE.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6bec1bce6586..3f92dd3b45d2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -169,7 +169,6 @@ config RISCV
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
 	select MODULES_USE_ELF_RELA if MODULES
-	select MODULE_SECTIONS if MODULES
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
@@ -858,6 +857,7 @@ config PARAVIRT_TIME_ACCOUNTING
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on MMU && 64BIT && !XIP_KERNEL
+	select MODULE_SECTIONS if MODULES
 	help
           This builds a kernel as a Position Independent Executable (PIE),
           which retains all relocation metadata required to relocate the
-- 
2.34.1


