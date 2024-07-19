Return-Path: <linux-kernel+bounces-257458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A5937A66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3931B20BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62114658F;
	Fri, 19 Jul 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BlvwbSJw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C914601E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405370; cv=none; b=cGt31aGXy3AIilfAbQyqtuo2/0KGVbg/EltpyFmsIySJXJa/i2Rh1I1L8oahap96r2FRET/Y3Tb/6szrl7eXnF9oY8UTl7oOY6w/TlqL90d7M7uMVRrw9Xeod5FmFfZ52K1y1lC8swQ+OUlzv6H4vLeGGkVD/pVOkq0gZHskqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405370; c=relaxed/simple;
	bh=bE9VM3napbCXTd+VFzqBz/32jthJiTjrJJrl8O+H0xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJ6rk/htyvBTy9Z3zcvWtn1FoacSTgd3AGHKc0MhPbp0p7JcvnS8zfehN2FasvNdKKdkmG3nXqD5hI7Vo3xCWRux/4ASjPnQXqSkKlZfcDFSCK33zypIRkDK8HBhbjGnerYp4sCgoPlyoEki3xLhYIfWwnXejIqcDUW2xy3euzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BlvwbSJw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc60c3ead4so17011195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721405368; x=1722010168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4afLvyEEC8RtJCW4UQr1WFckvidc7t8VQbZfjqmPCBw=;
        b=BlvwbSJwgwJvjmehTbKA5eb15lbDnSObpwh1lFbokC83aYCtiSQhXykDf7zu9N1W1F
         2gESUKUwuVECik2sb84XZYHvvgvYSuHUYhPm6MnMDMvdjLceFHOJIfw4DYjXN/B9kVUR
         dUch25Z7AlbUf4GheLtP+hZVQza7384crvY2SyvR38l6t+ZrjvQx2p9QqPBIagVQIrjg
         OlIFy8joB/xmhk0aH3BQjJ7QiHjnYTkeUoWgXRzGdOSnl8cMz6TGm6eI+6DYZ77Lcjc9
         Z98LQ+/3sG9iadsoEprRm1SFoIgcYMKQ6BC9BEdBKNhScNsBQ1hw4a8SRKMIxM3fJ4+f
         2zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405368; x=1722010168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4afLvyEEC8RtJCW4UQr1WFckvidc7t8VQbZfjqmPCBw=;
        b=rtkUjmMhebiekeq5A2wLOmmOplXpXANAEE1mvmM//K8BPQl7gl4oTZXx34txXgVLxN
         HF9wltixnnT9S74iccL8w8CC1SKAGphwjAS0/ikIn+SJGIEphwKi6XrlERCu9jvs+CgY
         wNcaCOQZAX+Lt0I6ODAy4yFheDn/W9AU//hKNgBHQ+MBZmkc4sm1X+66jzgrGxUhuRCQ
         4O3sHZo6cMD0JdFT5OWx4XLpn8By0RNvPj9ybFkaM1sxBGhITK3KfxMn8JlVrMP4wAgy
         QQYoYaXlDEGeVOeCW9FE1wfS03mXRLoxiOOGvBHMG8OfMyE9an1Z93lnRkUIPwPsE930
         Bfwg==
X-Forwarded-Encrypted: i=1; AJvYcCVNP9JZkAVutj7ua+doJ2A3e/1CdynismB7bH5ms6jbr0uAjiKOJD1105Ew4qH0Hqx1+r1JQ6/dXt/S2+dmByHfxQS+kCPCZUp6qg+k
X-Gm-Message-State: AOJu0YwclvOcFMcjZu748g92ixFnIK/yUAnyCdVX+b4wHw8HToiwMNPh
	Kgfz7VewSsZQ4Jf4Sghj/2GICtZ2E3NsdQri+//IvYunw9BSMOQgFDCs5aBXRuk=
X-Google-Smtp-Source: AGHT+IFvnzeRYXUnxpbkoVZbtYpLHtISa8TDnsAJ4DZ27uwiHvkB35LGFVFo5pBDK1eTxYFOHUVg1Q==
X-Received: by 2002:a17:903:2306:b0:1fb:55da:c3d with SMTP id d9443c01a7336-1fd745637b5mr4123095ad.25.1721405368211;
        Fri, 19 Jul 2024 09:09:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([223.185.135.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f518sm6632615ad.69.2024.07.19.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:09:27 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 01/13] RISC-V: KVM: Order the object files alphabetically
Date: Fri, 19 Jul 2024 21:39:01 +0530
Message-Id: <20240719160913.342027-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-1-apatel@ventanamicro.com>
References: <20240719160913.342027-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Order the object files alphabetically in the Makefile so that
it is very predictable inserting new object files in the future.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/Makefile | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index c2cacfbc06a0..c1eac0d093de 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -9,27 +9,29 @@ include $(srctree)/virt/kvm/Makefile.kvm
 
 obj-$(CONFIG_KVM) += kvm.o
 
+# Ordered alphabetically
+kvm-y += aia.o
+kvm-y += aia_aplic.o
+kvm-y += aia_device.o
+kvm-y += aia_imsic.o
 kvm-y += main.o
-kvm-y += vm.o
-kvm-y += vmid.o
-kvm-y += tlb.o
 kvm-y += mmu.o
+kvm-y += tlb.o
 kvm-y += vcpu.o
 kvm-y += vcpu_exit.o
 kvm-y += vcpu_fp.o
-kvm-y += vcpu_vector.o
 kvm-y += vcpu_insn.o
 kvm-y += vcpu_onereg.o
-kvm-y += vcpu_switch.o
+kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
 kvm-y += vcpu_sbi.o
-kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
 kvm-y += vcpu_sbi_base.o
-kvm-y += vcpu_sbi_replace.o
 kvm-y += vcpu_sbi_hsm.o
+kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
+kvm-y += vcpu_sbi_replace.o
 kvm-y += vcpu_sbi_sta.o
+kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
+kvm-y += vcpu_switch.o
 kvm-y += vcpu_timer.o
-kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o vcpu_sbi_pmu.o
-kvm-y += aia.o
-kvm-y += aia_device.o
-kvm-y += aia_aplic.o
-kvm-y += aia_imsic.o
+kvm-y += vcpu_vector.o
+kvm-y += vm.o
+kvm-y += vmid.o
-- 
2.34.1


