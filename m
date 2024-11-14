Return-Path: <linux-kernel+bounces-409957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F39C948C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22281B228A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED201ADFE0;
	Thu, 14 Nov 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H97JNTwM"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E224CB36
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619764; cv=none; b=sohAV/3b0kuYo1IsmI9bfP+V+V/JYPHqy59ACRs6Mjm81TfuTpse0Z8HGQXThUE2Tt5I+S6lXfjswKyv9/zJ6pqTzQ778hCo6soIguwaFLcC53yolonih1GJtpQbB1dBlMEriiEd6sePMgBqaLJacJlGQkzwHQ+xYih5cvsjFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619764; c=relaxed/simple;
	bh=H2HedUANVsUlNqEMn49Ng6o5Yx7OK7i0DBxc2jZFXJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aE+7ylzcPZUMaL1WZun6DoKs8s/zyP8NguTlGzRno9OV7isaa79ldE3ptly1+jb7rtWWg5B5/tXIJaZSPy/u1DKG5RPajMU2KWNufzDEOKYyQ52RfzMCePyfcwk3eoWjGk+E8VDfKiDq9E2tW3LJhXzYRJiaUfm6bfGP5etNjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H97JNTwM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ce65c8e13so233325ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731619762; x=1732224562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EuHFw6q03XCp7lup6jLddcHFjKtqe3X8eorkDm7w/hA=;
        b=H97JNTwM0+/1q+jaI6brFX0QEqgXy95+hMuSoXp7TqA84dba4fYtx/Rb9+uiaujgYL
         HUC8BYWGJht+EcS1V574Z8K5vwrr1N3qxrEorFJTs32/rZwPTHxyrsPMYBGnIUXxb0DY
         DtPJZ7/hQCN38FpHRrvSB4YUbVvhfoh+U1crzczaagd0wH7EwtlaH+7Y9zr8eZuoaNoF
         Bg6nXbKiz1W4mamc6Wbt1eeZ1xunDpJfY+V/T0reY9wbKtDpxeWZBxIkVGTjZSI4qT3M
         1ylZxd14yZzT+q55jpg7zSUuEIoQK6muTX9Oe+UxbKLI61EUU15EtxfX2359zp2AyYb4
         gYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619762; x=1732224562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuHFw6q03XCp7lup6jLddcHFjKtqe3X8eorkDm7w/hA=;
        b=MkB/WznGWsKOCYxiVUmecTWPubX811dEragVYHnhB/TcXbrhlTvlFTj9oL7+8Uv8RC
         ZDR9IvG54ZpNPOQsDwX+MPq55tuLJHFh/j6HY2NETL3yPzXmxgqof/lNbOcmaB0Fmd9K
         zaebqkV26Y1EjCmDAkPBMHNH/DqHKvB305Vg54H3D3Ka8wJ53iDE84ChaUohqaT6HO+l
         DMEkOWAenkDWr/jbOs7map0h6XXuwWNcMQERj6w39YnZUr+d34xSEgg6K0dRW7OYgjq0
         dLAX/qTHQmqRhSwkcw1HYvGq5TyeUEk0JJZefTUjwbRdCp0SiJiFMPKix7UkTv1clIn3
         NFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUG7ytYhjK4kVUGkhPZegc3LAe602sQ2Wzf/bLEqCcADOGGZmzyK/vA67qeKS6PsGEauHi6odi+bq0fQKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGd+QEdTRszaKbohfTDWibkrhFhEGAV4DjpSJGjnS2JvuTdaqV
	qoB9KZ0TjMl7KsN6QpAc3bnxXc1eX4mZHMjGek1kXY75zE1ODCPk
X-Google-Smtp-Source: AGHT+IFyJEUxPZNPdrNl3tzCmtz/Zc9PrJDCThXArRtOM55/LgUVKGi1XczAzWCBjI9vkEB7+knyCw==
X-Received: by 2002:a17:903:2a8e:b0:20c:bbac:2013 with SMTP id d9443c01a7336-211d0ecead8mr5050745ad.48.1731619761915;
        Thu, 14 Nov 2024 13:29:21 -0800 (PST)
Received: from newslab-Z390-AORUS-ELITE.. (pc51.csie.ntu.edu.tw. [140.112.31.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f45641sm832945ad.177.2024.11.14.13.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:21 -0800 (PST)
From: Chin Yik Ming <yikming2222@gmail.com>
To: palmer@dabbelt.com
Cc: paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	parri.andrea@gmail.com,
	atishp@rivosinc.com,
	charlie@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chin Yik Ming <yikming2222@gmail.com>
Subject: [PATCH] riscv: Fix a comment typo in set_mm_asid()
Date: Fri, 15 Nov 2024 05:27:25 +0800
Message-Id: <20241114212725.4172401-1-yikming2222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/verion/version

Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
---
 arch/riscv/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 4abe3de23225..55c20ad1f744 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -158,7 +158,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 	 *
 	 * - We get a zero back from the cmpxchg and end up waiting on the
 	 *   lock. Taking the lock synchronises with the rollover and so
-	 *   we are forced to see the updated verion.
+	 *   we are forced to see the updated version.
 	 *
 	 * - We get a valid context back from the cmpxchg then we continue
 	 *   using old ASID because __flush_context() would have marked ASID
-- 
2.34.1


