Return-Path: <linux-kernel+bounces-373417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDE9A5670
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F41B22BDF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80E19885F;
	Sun, 20 Oct 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hnv3Kl3R"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE1193078
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453668; cv=none; b=uoghhnJB7ZG1rKPBhoxzENmfs6t510rE0fk/WPRwsVnpU6d1b12cTPVdN7TJpJ/k3/uDuccKJow8s7niijyfXXOOSS5QGTIslMVEM6Piz4ldNVI9TiqqL0LhD56U07HG6aV9zf0uS+JGDRtwYFht5bPNmojIhT4iCvcoiCNbiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453668; c=relaxed/simple;
	bh=rmXeXWote8XruyHvLXjR3P0uOzIQEpHMI/zHFfQn3bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0zLAEZ0ZyOXf2qI7bhmEuQW7u1dSDZigWsVkGy4IUHXlddD7IuZQOfnrj+J7LoPPAKLwn4UzzhnoiTwtP3oap0BBxNJ4zfqkUbD/WyD6OYnaIs8WXEoXDRh5ZC7qCKRy89o3YZqdux/Cc0Rz4KEQoGYFaRLnCaRcqnSvQuWR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hnv3Kl3R; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so2534623a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729453666; x=1730058466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8r3hycJZuUwFSSkivtdNHwET+4m1ywMgYdIz6RDPHA=;
        b=hnv3Kl3RQ+1bTskC6LESXltALpEf9nal4YCegcxXhEa6ZXzRdABHZDQ+6b0Hz83dZx
         dzXHVAe1H4gogtHUtLvRkv1ISs3yFtxoll92Qx5NfXmyunZtDAvRA/MTdPjMbKdsfEOB
         wQZ/4ZY9JHjr8eQD+Wd7iFUE2rgsejCL0hrsJ4P3xSs9CTBzG9vdV8d6+rHJ+He8/Dwo
         /E4tTzNaeVqMYi13yGJyZ0hByClQvQ+7XZruejCYFyMaN93NNdDaXcDEz5V1NGR7l9ZD
         De4J4XHvB2o7t6WoyTQk9yMuRfAUsSR7CevwIyzFpEtcS60ynXfsV1W7nTATnYkXcSNh
         mMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453666; x=1730058466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8r3hycJZuUwFSSkivtdNHwET+4m1ywMgYdIz6RDPHA=;
        b=MBkJ470IWhVHFmAmaLibwmF+YMUhVzHuP/3fMv1/jBpa0DcvxFr4PnVsdjPhLmygyw
         gDsBixo7XnylAfinKBUN12b3NJkBMXs2OCjvuPraThZLlKq9oni7nUT99Qwo5RBKCLFM
         LKv9OcQOhN1U7oUGHLZoer8liWEK2M85Hv5J0XzuM2X43ZTC1ThGD4sZhPFrj4axZ6sb
         Y27xqLVk1Qm0A2bEJZtfqyTuDkb7PUYqjj289IZRbMVfgnAh06VQ9U5Qfy+W7a7BNPrm
         x3wATASxjL2dYl93VwBTCnMOY7h7y0DvDFKbZ6TEub+C6TlJ0iPJ1IA7Qky1J+FYMOCO
         vFxw==
X-Forwarded-Encrypted: i=1; AJvYcCX5QFtqZfLTj4GQ9L+QU2uVBkRU9m1Kq5bkLRLoGDf0VcdOJHNGa9sf8e60jUyxX+QbBJFRVfXdsv0SSn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMn5yPudda9IHBAuUFryVKq5gMtOlrygMaVjt0rMcFYLomK8a
	3gUhWKwv9TUXqEg6z+uKmPaO0F5BX+dpZBUmE2GGBEuRz+6VODL2VrSG+IAUB/o=
X-Google-Smtp-Source: AGHT+IFyn/+eyWYLXWNY3Vno/OCeNQB3Y8TPoxaOdFGwMyaqKIUSGpcQDYXeZGWcpxBme0KP3op6hw==
X-Received: by 2002:a17:90a:b781:b0:2e2:f044:caaa with SMTP id 98e67ed59e1d1-2e5619f8409mr10947652a91.37.1729453666060;
        Sun, 20 Oct 2024 12:47:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([50.238.223.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d4dsm1933188a91.14.2024.10.20.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:47:45 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 01/13] RISC-V: KVM: Order the object files alphabetically
Date: Mon, 21 Oct 2024 01:17:22 +0530
Message-ID: <20241020194734.58686-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020194734.58686-1-apatel@ventanamicro.com>
References: <20241020194734.58686-1-apatel@ventanamicro.com>
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
Reviewed-by: Atish Patra <atishp@rivosinc.com>
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
2.43.0


