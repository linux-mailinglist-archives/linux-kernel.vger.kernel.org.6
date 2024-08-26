Return-Path: <linux-kernel+bounces-301905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2395F72A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2762F1C21713
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A3197A66;
	Mon, 26 Aug 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sq4VmgnJ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74295450EE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691136; cv=none; b=tVnXMyk3zbffpUeXdzsrB8AvE+W+MoRSA6PemqaX1f8gD/Z3LZbxb3fbuXSA4eDRRd/uZRfuCNq5SPwXcw0ePWTEIW3vIn2foETXWeulVxzHKVKfwe9OOMx+BQibxGro3m3lQJTEPri5Mfop3x78WP/3LZRevtbpMLWmeTTsmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691136; c=relaxed/simple;
	bh=VhbxHOct3VSjYTJ3syNZsDNA0Z+xOUZb/xIlEVl1bO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gi7xqQpegz4Nk9HTjpPqcE8OUXxFKM7uHFr026A2AY28amul5oGXIB95HM8NQBafl5M+PxfFRgtJw4EI6rviA5UBqi4QoLn+3Bo37MWWeqyS6daF0vebupVGg+1VVCtr5rDZPzp5aA/FSFjMV3fwaHDmvbG4gXduBasIdFmC4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sq4VmgnJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso2879383f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724691133; x=1725295933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BL9JjpcnqKHeua2e3XbD0fdD08HoTxgLl7O829TDGu4=;
        b=sq4VmgnJRNVR2iIpmJoM104brBgRHLGD/ofBUpCayPbADYLlV2UPbzHSGEChzyqGCl
         OrXYu432lRxOVskvgo3mvsPBNVqyUHWV/ytWtPiorDGRFJ8yAj9Ph4ax8FjVSR0UUswF
         //KhJmydP1sSX/pCxNgU1cfgHSxjwl9biLPa/+5GRCVAV7iGcnodRzCuWQ2j5Sy0GDyx
         y08Ju6bjKRbwMluyANqnEyrP4JCIObi//Ae0K7WOi9yUuAmg1Mc3hCWIJ9M8dwLPiRr/
         ccTbnPuYfk89akbk3VsbR9aBaIfkOw6MtovjrjakXoKz6z4gdNSTBZaRo1fNeIhOwkgK
         h4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691133; x=1725295933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BL9JjpcnqKHeua2e3XbD0fdD08HoTxgLl7O829TDGu4=;
        b=OWFk8NhpBDQLr0vfbIdAP4szyLSNdZJ0sqMEEvMOM1liw/PgIWMPnYAtQXDpvhCj7J
         guqRcybqbBqoFVCeFYW/ABtOWGWoH/ibp5ZEe5UMVpBj37JCbT7kb6xixBCiPYSOIbHC
         qxATKt2ccv3LEgdE+eKkC1Zi4W917+3NLOiKMqqNO6GX79GcPp4IgBwJN+Z/NIKIrypm
         okBovOiz5dnbaMCAVdqz3BUJS9PNEIvqVbwgoDs1y8O4u7DkChUBo0bDbzpkBX082r76
         F2O+5PzINLt3zlOMzr0VlnU1pGxdEe3adYtFHgl9QPbAFCxAyGrlbjiTMTzXdLo7vgbF
         C8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVE6piGFjhTb4J6NR1p/31US9liW01myfYFQ/9bi+YvtkIpTw3/D3VnBV79n+0y53FynOaho+wKUVLsQxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZ9YZAzx+I6qmUZP3lUpOc3DfxJ18DvTUGCj4IUuP97nSClRP
	aPIMjqMQgLT+phdsmLsBczThQQuAukgP63Uis4Cl4XPCg01zhDwsDD2N8nfIsAE=
X-Google-Smtp-Source: AGHT+IHgPww2vGsUStPy4YUKa5Ssz7uxojN5Zc8AsHlLup59YaFfKd8Gz+nUHC6X++d8ON3xrClYDw==
X-Received: by 2002:a5d:6885:0:b0:371:8bc9:1682 with SMTP id ffacd0b85a97d-3748c7dcc10mr183591f8f.33.1724691132518;
        Mon, 26 Aug 2024 09:52:12 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811044bsm11137226f8f.23.2024.08.26.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:52:12 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in preemptible code
Date: Mon, 26 Aug 2024 18:52:10 +0200
Message-Id: <20240826165210.124696-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported in [1], the use of smp_processor_id() in
pmu_sbi_device_probe() must be protected by disabling the preemption, so
simple use get_cpu()/put_cpu() instead.

Reported-by: Nam Cao <namcao@linutronix.de>
Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 31a17a56eb3b..25b1b699b3e2 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1373,11 +1373,15 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	/* SBI PMU Snapsphot is only available in SBI v2.0 */
 	if (sbi_v2_available) {
+		int cpu;
+
 		ret = pmu_sbi_snapshot_alloc(pmu);
 		if (ret)
 			goto out_unregister;
 
-		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
+		cpu = get_cpu();
+
+		ret = pmu_sbi_snapshot_setup(pmu, cpu);
 		if (ret) {
 			/* Snapshot is an optional feature. Continue if not available */
 			pmu_sbi_snapshot_free(pmu);
@@ -1391,6 +1395,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 			 */
 			static_branch_enable(&sbi_pmu_snapshot_available);
 		}
+		put_cpu();
 	}
 
 	register_sysctl("kernel", sbi_pmu_sysctl_table);
-- 
2.39.2


