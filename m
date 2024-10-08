Return-Path: <linux-kernel+bounces-354509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48049993E73
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4512B21164
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8529213AA27;
	Tue,  8 Oct 2024 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQgahom9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CF2905;
	Tue,  8 Oct 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366387; cv=none; b=qqiFGM87aZO+yiN4NMy+oA+y/o/axmFF299hND/ZbkVPHZT1NHpyOyUU5bJeAiU11V3U/Z219V4jlgPa6hwJwseNO5+kEVdctomUvivbF2f9annJmo9OKs8GqY3QgXAXyUrjpith0DA8z+Ewuedua9XhUD1xJYV3PiHuI/2I/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366387; c=relaxed/simple;
	bh=N/Spo9SDduv0RLowIffYPfGmNx1YtohH9VQK4z1BrSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AE+grb318TDyJFnFeOfFNgbZS0A0bMIYe7hl6X11H9uG2hNmymSV78rziphngwXnCyM0Px4g5BpiI9orupRH5af+1jilqckBo9xxQkHVFyzEhp6ZY6l/2egPX/kfyI5NAr4vBiYpYqf5dEhcZUehXdfI2Z+Oz5Z0woWIOvDlEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQgahom9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b7259be6fso57469635ad.0;
        Mon, 07 Oct 2024 22:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728366385; x=1728971185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pc93Myxhw5WDTjlUIkYMv2Vf5o3lHuclVJG9aINvVes=;
        b=aQgahom9TbAgn8J8DOXeff+FkjyKQDzTC4ZWWNPSh8uShbAJGh7yRqB6ArLDXqM+vt
         0aXBb+nBmodkql7HCUSVAW5gd8wSqLKQVRIZG1ff3WHwO4tvtj1sdcEvd7pHbOBkDB4I
         DtNGan/6bIFPosNdZfatTSalVu2Lr2oEXpXl90IJHZS6OUF/NP3+gJ0U/Od/fNqHQI5D
         zgXX3fxqsxj53LMIF/CNNxLMRiOxjKZrUxe7VjXLImy6AhCnsJiNALbZgYFS7/3Tw3Ax
         I1iVk15B+y6hYKPazhfP9jpj1DfpZkB/FLaYSkQXlBB6OKwsz1bGYJSNojF3gM3sZeKR
         aBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728366385; x=1728971185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pc93Myxhw5WDTjlUIkYMv2Vf5o3lHuclVJG9aINvVes=;
        b=m6QCO23JxBM0tmIcEBvLEMaINsBe+uMJ6qQS5lyOOMXAxqQmytRxMZoc8CXSZTAGnH
         bpvuRqj5132vjPyJz5wl6uRWApCK5d9e1GAeA+nqox/qHlOHTBZ8eaupjuM11Oy8jJHc
         znVOaYdNij2rdn+kHxLD3it43j6jXXX6UftmL+NeTaVAkWv2Qd3utjWoekV69NKkEYrK
         J50YKZi7AobdFQQEMUghD0Dwx1SoUCtb0h6TZwcmWMTjOi/KPU2YL9+x0JfoWAhFefPT
         zq7oFogfsBPlSvs+YBzk8n3Km5boHEcbHR2jhVb2FCYRXDv2RffUkRTn8wRT+ggwQbcb
         0ncQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2qUylZyQ5V6B8hX0Dom1z66NnxPTcGB/7KW/NDjBjQVc+hk7shxSauBgXCSHLtpwToMHaK09rxTkdf48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEB5d7s6J+gWooDj2UxGlDcjQs/0D8AEhYqFYdmgi6or8TzFUS
	sczFyBsge7IhXbfhCFAQt5TUlZTNMd17Ef+kmXv3xdxLxXR6VPK22/qWkUNZ6BI=
X-Google-Smtp-Source: AGHT+IHxznj5YGFHAoWp8hwcy9eUBWmkaPeX447OgP8eReH1zm/Z/baPjrCgcZTCfhWCxirLxtgdrQ==
X-Received: by 2002:a17:902:e2d4:b0:20b:b079:5b7a with SMTP id d9443c01a7336-20bff03519fmr136454675ad.50.1728366384899;
        Mon, 07 Oct 2024 22:46:24 -0700 (PDT)
Received: from localhost ([202.85.210.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c5a90c002sm1136015ad.72.2024.10.07.22.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:46:24 -0700 (PDT)
From: Yang Li <yang.li85200@gmail.com>
To: guoren@kernel.org
Cc: linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.li85200@gmail.com>
Subject: [PATCH] csky: fix csky_cmpxchg_fixup not working
Date: Tue,  8 Oct 2024 13:46:15 +0800
Message-Id: <20241008054615.43062-1-yang.li85200@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the csky_cmpxchg_fixup function, using the global variable
csky_cmpxchg_stw to determine the address where the exception
occurred is incorrect. The global variable csky_cmpxchg_stw
stores the opcode at the time of the exception, while
&csky_cmpxchg_stw is the address where the exception occurred.

Signed-off-by: Yang Li <yang.li85200@gmail.com>
---
 arch/csky/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index a885518ce1dd..87ff26212261 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
 	if (trap_no(regs) != VEC_TLBMODIFIED)
 		return;
 
-	if (instruction_pointer(regs) == csky_cmpxchg_stw)
-		instruction_pointer_set(regs, csky_cmpxchg_ldw);
+	if (instruction_pointer(regs) == &csky_cmpxchg_stw)
+		instruction_pointer_set(regs, &csky_cmpxchg_ldw);
 	return;
 }
 #endif
-- 
2.34.1


