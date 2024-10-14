Return-Path: <linux-kernel+bounces-363732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427899C64A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451371C225D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5D156886;
	Mon, 14 Oct 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QhdeJ4CD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5521527A7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899244; cv=none; b=mXVyjcL3tNQm7GtTbyJWVg02KKCddoVCASSZ6dT0Ih8vuBoTk2IAmZV06euZm8DGidaw/+gesYI9qYFHBdVGiXidUaUSr/lyK4XJBQbn/wHPaWD3KVOBuVCpSiIyl9IwHZtmcqXKMiS86wmSMm3ATqv0xSR2dxVmZi7Np7Gf5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899244; c=relaxed/simple;
	bh=Naw0Zp65neeH/lp6kK0p1aABP6t8tLIRNhqGbcsxXOc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZMqC7W76HLrTl11zYH36yiW7Zfc9wYWsq9IAlghHQBjcWSZ3ooDPdAzGpNYYZHGDYtsIWwy7DDgRjkI0/AtAyl04DKAdAkC5cTSzfNOzsHY7aSTRpBuoLJGqGgDgazq4ooeHZFSiJAHhDosl4I1lsBER4739x9cnwkz888hrtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QhdeJ4CD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cdda5cfb6so9651965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728899242; x=1729504042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n58iiwTpzY85BchUZIr1TDODnx4LudJgqcinpAoQ7vk=;
        b=QhdeJ4CDBjj8Mi6aYF+L4Er/FE4eKtfhrFMBBJayhBJH+UZ6hnMeGDDooS+m8r0YIY
         Pp/ZjXEoy2N2V5xPl2DUQlfFNHzeTV+BYaLElN0k7MtbBpT9KntJaeAvKIdqsgQOKAgI
         5I88szhUklqnKgz/Cdb6x9YW0lnH8nXAa1lMyx/ECSDoZY9rhMLA0FIUaJe2Bsp1yQmz
         nuQghgkRjA8HUKjnmzuryHUei3DlcQFWQAuPe6g7FiJyOEdM4laN1DMyBK63f7bl9rZc
         TkV/aqsNf1nP7RyNXQYpcbxrc37MQAyXQLbtEMDWP5UvG5hJl2CsSChLnrx3DrYDssSK
         LRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899242; x=1729504042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n58iiwTpzY85BchUZIr1TDODnx4LudJgqcinpAoQ7vk=;
        b=gdkZynQXqEi762+Av0bJpYoHHwiiS6H85sq3qF742CIcQKQPuYX0bGwgUiIRHXd1WV
         9NBbz/oNDuikmKVB1lkTNQwJM4a4A/EPB+S996DLd4R6cnBMIh8Er2mYcr25muMYttTT
         vzFFm5bqGCSGuxWQu7nvX8fEoqjpT4aIf96vyTQuABJuXvRv0Me+DIB16XRgSEeNUP+8
         +lbbAbkRfWfrdSn1yTQDwG3LzvbpGogn6T43EuR9HRlrvKqJ49rVVc1sTWfgGsAnm93d
         fUekUecq4+dpd9+Cb/+sAcHZ3zUIRRGGLhlxb2PVbhhLnDgjkehUQ26izKLkcJsX8CF7
         P06A==
X-Forwarded-Encrypted: i=1; AJvYcCW98u/iNOp4KADJmIX7W6IMxIwaeDeJsnN4N0Z39jFz3DEhHeKTZTNmyf2KgUZgVSAChPy2zeewHjMXfbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjyWnG7UqWSNJMxIIZ3URx/ecrcFSZ86Bcz03cYzqODQmLsXsf
	ZYSQYUvZkhneq4zjYK9AK5Xonms89PWIdHeFrVRnN9h03pgFfT6e0l2nlm3BhBE=
X-Google-Smtp-Source: AGHT+IGmzF68/qQ+7bOjFdgyKBRsCojyZ+YIvq/M5Xf7hscDg17luLPgQdaAdaYtZxk1MyR8puiWEQ==
X-Received: by 2002:a17:902:d588:b0:20c:7898:a8f5 with SMTP id d9443c01a7336-20ca148bea0mr155253285ad.28.1728899242026;
        Mon, 14 Oct 2024 02:47:22 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c2133besm62817625ad.211.2024.10.14.02.47.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 02:47:21 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sunilvl@ventanamicro.com,
	cuiyunhui@bytedance.com,
	ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	jeeheng.sia@starfivetech.com,
	haibo1.xu@intel.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
Date: Mon, 14 Oct 2024 17:47:05 +0800
Message-Id: <20241014094705.71775-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SVPBMT is enabled, __acpi_map_table() will directly access the
data in DDR through the IO attribute, rather than through hardware
cache consistency, resulting in incorrect data in the obtained ACPI
table.

The log: ACPI: [ACPI:0x18] Invalid zero length.

We do not assume whether the bootloader flushes or not. We should
access in a cacheable way instead of maintaining cache consistency
by software.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 6e0d333f57e5..3177c9af8764 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 	if (!size)
 		return NULL;
 
-	return early_ioremap(phys, size);
+	return early_memremap(phys, size);
 }
 
 void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
-- 
2.39.2


