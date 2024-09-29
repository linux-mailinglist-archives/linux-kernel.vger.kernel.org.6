Return-Path: <linux-kernel+bounces-342792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A398930D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A01F22FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0378E2263A;
	Sun, 29 Sep 2024 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyTahrqO"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6B1362
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585237; cv=none; b=GbUTAyph5y+/A/YR+LlL0iNhfm3JHEqKSXJ8bhBvd1hyGq96Sc5waaKGNEGBnaCl3GJiESPIO95xMwWn8GyaKueTASqBBIwroM4QpZ1czNvI+dXXp6aRUfspSaRWPllb0/Qakgg35KgrhW9xTMnDlWtQTl/1vgBrhUvvh26EO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585237; c=relaxed/simple;
	bh=0gVAvVq9QWjCEzx+xpvsDjjt2Opmges2p9QPYWzAETk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4qYhDVPHnqYkv0m0MV7tAahP10FzpzcvIe/GBlQhPvGKhpxTeF5wYgj8ooMiUR/vlxjp35bm+iauomeVPhx8ifEctY8GE/LnzjLb9a5aG0eiRDnJTBYvIdadv/gR0bf1ptZ2O4QhY6k+dKtT4RubjxU2EGw/z/4JG+sHSV6L04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyTahrqO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ac2d50ffso290047585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727585235; x=1728190035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMFE0GTqbW0T50ivmGcDcpWDKEF/OBy4KQ/5LsKTloY=;
        b=AyTahrqO9v5OVvFyPUYqP9Gr20pcLiMIkPaJN8ioU8d38EKd1Al86B83PEnQxftQ6f
         Oo57qDTnyh8VWu/kgsixDkZ71UjLaI5VLSwX9rdj6W/6uBAFeMB4wY//LMxB+KqyZOG7
         q8yp/OgyCWSm534Dbuu0k9dXCIAlEhh1vEnbDySGCvvKImLMXothANibnfaJSq7jKoA4
         Vl9OTQFCKf5B6xLGGCrdSCbE3bXk5Fwab9W9J4vxTLZDFqgq/BeK5gZF74F6+yvmSFP9
         nm+dku2/sMuSmwKe/zrfPBB3pEec8sYaejv0r5MiH7XTe4PBgSpSoHon51L0aGFq2ByP
         fkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585235; x=1728190035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMFE0GTqbW0T50ivmGcDcpWDKEF/OBy4KQ/5LsKTloY=;
        b=RbqtIoHyXaIUyh9tAv9tSVEGIPqG/+Cl3KcrvsVMLC5scUu9KscblECbGPFVwa0g9t
         ob81q3rPJKIaTnnc1Xo8D6ESdb0oQhu3oaZpeTvNiq/O9tCA/pL6Izmu1U3M5oq8CEwP
         xBnHQzEYuiVRUVe2k7f/AEkl3rX5Oo1O7p8QTKK57N1BScgVY4myL7wYzkdczxArHEtm
         jlCdO1oooybtRl//x6n94YParmupwxUVe2soRS6H9qb7O1vhwqKb3PiCtL9/sKZgBYYH
         mEUsKFFlBgo/5+Tm0nwiXg1cO4DaKaSUy+8AaEoQY/ADWOugTupdspSTCP1QdLWsvpJP
         pktA==
X-Forwarded-Encrypted: i=1; AJvYcCV+o5GVIbcA3X2BNGLHLSU0g/V5W+f0ZOJTXk5WlBwuCeHadgPtBvRqVOcqTVBJOTzqUxyJUDEAh+GhjBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OigmPLhG9LESLhD3UXL+pLphBWxwLUjCwWBxR70zwdbJAqqE
	bHzxCap2IipmwF297emu+kZoQSYIxR4eTQ2f8EhwkEIOmXOwiJ6q
X-Google-Smtp-Source: AGHT+IHZvcEw/8OZTzrIKSCDcpNxoH4EfzOWCLhV8ZiAVwg04IbAxDIGxPpmTDDtLuStHKwADjYamw==
X-Received: by 2002:a05:620a:178c:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7ae373a7a7dmr1433156385a.20.1727585234780;
        Sat, 28 Sep 2024 21:47:14 -0700 (PDT)
Received: from localhost.localdomain ([185.221.23.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783ff45sm265461385a.115.2024.09.28.21.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 21:47:13 -0700 (PDT)
From: jiaqingtong97@gmail.com
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jia Qingtong <jiaqingtong@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: vgic: fix GICR_STATUSR in vgic_v3_rd_registers
Date: Sun, 29 Sep 2024 12:39:35 +0800
Message-ID: <20240929043937.242769-2-jiaqingtong97@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Qingtong <jiaqingtong@huawei.com>

vgic_uaccess use bsearch search regs in vgic_io_device.regions, but the
GICR_STATUSR have wrong order in vgic_v3_rd_registers.
When check all vgic_register_region, it turned out that only
vgic_v3_rd_registers has this problem.

It's harmless since vgic_uaccess behaves as RAZ&WI when it can't find the
specified reg. This is exactly the same as the behavior of the GICR_STATUSR
register.

So just move GICR_STATUSR to the right place.

Signed-off-by: Jia Qingtong <jiaqingtong@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 9e50928f5d7d..822b4c1a01dc 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -651,9 +651,6 @@ static const struct vgic_register_region vgic_v3_rd_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GICR_CTLR,
 		vgic_mmio_read_v3r_ctlr, vgic_mmio_write_v3r_ctlr, 4,
 		VGIC_ACCESS_32bit),
-	REGISTER_DESC_WITH_LENGTH(GICR_STATUSR,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
-		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH(GICR_IIDR,
 		vgic_mmio_read_v3r_iidr, vgic_mmio_write_wi, 4,
 		VGIC_ACCESS_32bit),
@@ -661,6 +658,9 @@ static const struct vgic_register_region vgic_v3_rd_registers[] = {
 		vgic_mmio_read_v3r_typer, vgic_mmio_write_wi,
 		NULL, vgic_mmio_uaccess_write_wi, 8,
 		VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
+	REGISTER_DESC_WITH_LENGTH(GICR_STATUSR,
+		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
+		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH(GICR_WAKER,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
 		VGIC_ACCESS_32bit),

base-commit: 17a0005644994087794f6552d7a5e105d6976184
-- 
2.46.0


