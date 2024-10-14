Return-Path: <linux-kernel+bounces-364079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2CB99CAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284EF1C2028E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32C1A4F20;
	Mon, 14 Oct 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lQr3GhLd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331B1A76CD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910926; cv=none; b=fmvvFf5uPVj0hNI9S3lOKm+ZHl0WdpPOLCYy5CYLAfBjOxYzjwKCYylaucQ/CWWkaiLJchIU0r29w1Jfbpqnzuu8BVYsp6MDqtciG4PzR4D0QY2OfgX4fDl2Re6f5MXvgl+GjXUVPjLhP/Z1G/rq9gxVQGTUcQF6ILGjp6QCSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910926; c=relaxed/simple;
	bh=oRHaMj0TrZEBFTHnnwz7NFU5wqr0qTWmmKVY0yWv7ro=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=AeV5JkKzFAJrlGR8yVIfFjljLaFWkuk9giB+i3RWGQSJZk4/pQPvgtPPaoMSh1SzXZ6mdViQG5vwEVTQssQiDHo5/Q0+sQrThZ/C5hQeKgXH1eVA6QAsZRmtdsifhsg/eP0xevwfZO+/w2YvGtVTxcfFRDkHQB/XJoC7h7iJHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lQr3GhLd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e52582cf8so1109001b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728910924; x=1729515724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQPjmbJ17ANnSKX5ASFQGSNPYugZogn5Gs1gjayADw8=;
        b=lQr3GhLdxyI6ctT++7SBQ8kl+Sxzsmm8lbq+Bi13Wq43LNIG6kQB5pBACwbjiXzT/d
         KgTFL1DAX9l3gOsCXk0MO0Iut1EA4jfCy6cVhuY5F6zL2g/zDOiORMDeI1lmSkjY6xH2
         ZA4/2CnrkdkMv79gE9npEbyQ49aFg5xDUo4bup7kUztuibF7T9U7ZV9qNiOUYr94nOLw
         N7EtKMrtgHvNFWcSViodg7F16C5tn1/w4a9c2QyOejaY6UZxjKB2a1FzZ6tv8Xdt5EMU
         SUKIq2LrE/Yg9OVs0cCrx7MyOMx6+TqP+GFu3ZBKx7DaJH5QbOlbfLtki/egKz6WdyyA
         9f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910924; x=1729515724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQPjmbJ17ANnSKX5ASFQGSNPYugZogn5Gs1gjayADw8=;
        b=irNQfcFJbIfgLW4sCCYAXPJTVKEDRcKYMEtw48mWVGPW9JJhh/nqvCNtYIZ4/ncjrZ
         hFq0WDSQYmgoG+O7+Ee7NbZdJ+ihUipr7RyGI5lGJouAi5oBjAo5OjDDm8/8YbX5tUDv
         +zfURLlbG/vNAybfBADLeh2jpCpsNuOneNAS2QIpK5rtyQCI72rQLeQkzliNcHYxSTWE
         O+M72y2rV+0NnjH0NY3QQhbD0w/WqWA/zEpYwWArxYbu4XJKY3JZqnNZXse0JAP61xaa
         zibChp+cQOya+JqCxvcFyiNqFAmCxooR5UIQntXCBKDUm/jE68jC/MiaEB6xnA93GF6s
         B4vg==
X-Forwarded-Encrypted: i=1; AJvYcCVWWAZRfoP8grxRMYLaP8fUdSwg2LddtZ+jzJjiAURwZ3lS6juW5vlEfq8/f8PF3LYJJUlvoXibbEbE5Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcdJ57j4jksueeg0lvIjsinoVg0GgsZhe7J58QX2/M98dF48S
	d4XfFFUEzLu55Slk5XGDdmvJVm0emMZD4PC+lv7IGwDHRuM0cXeXop1DVbprKtU=
X-Google-Smtp-Source: AGHT+IGY5bRY5owp5A8Ewm3iO1HNvwFWn/zOThsKSvrZ02vXYnTQ18yH7cFudlJzT7bigyD/CcmQjw==
X-Received: by 2002:a05:6a00:198a:b0:71e:21c:bf1b with SMTP id d2e1a72fcca58-71e4c17c0aemr13615152b3a.14.1728910923860;
        Mon, 14 Oct 2024 06:02:03 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e664fb7b9sm2031959b3a.84.2024.10.14.06.01.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 06:02:03 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sunilvl@ventanamicro.com,
	alexghiti@rivosinc.com,
	conor.dooley@microchip.com,
	rafael.j.wysocki@intel.com,
	haibo1.xu@intel.com,
	cuiyunhui@bytedance.com,
	jeeheng.sia@starfivetech.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: ACPI: fix early_ioremap to early_memremap
Date: Mon, 14 Oct 2024 21:01:41 +0800
Message-Id: <20241014130141.86426-1-cuiyunhui@bytedance.com>
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

Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in different address space")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 6e0d333f57e5..2fd29695a788 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 	if (!size)
 		return NULL;
 
-	return early_ioremap(phys, size);
+	return early_memremap(phys, size);
 }
 
 void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
@@ -218,7 +218,7 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	if (!map || !size)
 		return;
 
-	early_iounmap(map, size);
+	early_memunmap(map, size);
 }
 
 void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
-- 
2.39.2


