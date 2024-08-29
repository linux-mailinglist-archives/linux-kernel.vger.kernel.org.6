Return-Path: <linux-kernel+bounces-306461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E8963F52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146831F22C22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FCC18C926;
	Thu, 29 Aug 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LPcz7wVC"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AF148838
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922040; cv=none; b=fJwKnJdMPFql87xlyUYdNxqXQokSxvmNuWhuV7+CNNElN48C0YZQq4WcTnqJ0Taie+7UvdSV5hm3q6N5a4N/HnWsyyHTJ3BwmdzSqQiqgUcrRDVR5hg1txaArE0WNe/NLlX/3xzpi85aCDo5/aZtxu8dpBXzLCyvepRVj+sZqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922040; c=relaxed/simple;
	bh=81+YZ0KSh/IunsDPFB8A4sOGy/yTbcZFpSn1SUKBv40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tuPleibdsa5A0DlcSuBBWiCM1zhv1aVLwfuuwMojI1MaLEjFgfjQ8DDRFvDWEQuSNVi7DTFHEYOCZCbeY7uEwmMS5AkFjFs1oqPI+/ATp69F0L39HkxWRC7qJEoM1tvSZGIM0ze3nVkguvCNTaOXerNjRI2JBQ3B5F67z1wkIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LPcz7wVC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371a6fcd863so282118f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724922037; x=1725526837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BeNRcsK1VBAVknVZMYL7LYgNLSYxmT3BPkThGqZl++4=;
        b=LPcz7wVCXxAEh/X7Dpx2orLhRCXd9wIodZLGIH6UtELSMsgOsBEGHqFkiIfZ04Q4Sw
         N5HKYXmq3QOv8scndLkxfKXzhKNHW4SYWNpGUIoOMPOfh811290g3fB6mJDgtEtvYig/
         lJwkrorpQPsd/zGkNcs5Th2iOQPTjfNXceE233Pih8bxVWjjFDvb1W145SnPvEx5n+9x
         r86budCFqHIMXlXjbBaPZDW/yM6Ee50no7oB+Vy49gsUMjK+7amNyOpDwlUT2kvQ8fED
         u5t9ropchpihgUrFgGP107L6wSBhMLwk+0GQZhY/NozcFPnfriSsmzIedaCpOKb5j4V0
         0cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922037; x=1725526837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeNRcsK1VBAVknVZMYL7LYgNLSYxmT3BPkThGqZl++4=;
        b=kWYlslaJ7SlHfkJd+fIrye58ji/Clud7IOX0q6yyD+mxuQv0mXE0E+S+X0+0y6gEyD
         ihAPYqC2BqLSBx6IMIoYnIt7CpCHKd/olE87HGTH6TCMXA+8261vjhGOviDn+u0cGXBr
         Z55aioBXrUNF81eL1ifjvxhGYQ/QWqLQTc1VYSsZaksoXZ67F8QzVIJDFlrRSvwT0L6T
         wfZcO5fOGDXxKlQVX7aBDohOAOHn2k/6epOnBG3afEf/ICTkfKl1zQq5u5nLsspskdD4
         5lcYQldUFUPDQMBcA5gOG7+QtNf9xd7OLwlw6zNEcUQdH+2bnFK0CI3KYZRTi3aXZ/dX
         WFxA==
X-Forwarded-Encrypted: i=1; AJvYcCUPyOZIDPeMcQRVy0c4Hal0nwzaWa7y2tMA611CaIfNmM30jrGi/PztbkMIcEvfQQ9gRJ1iVTBmF38UstM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvskLWfnxVWJEwM/XNRo2mvQaVOATtN6HG0yvUQdrpfjON1L5
	4FN9QNa8YTMTNZ3C1RXKHz6JVhV4WXfwx5JPkgeJRr43Q6PsHq1Elb3/5gyDPOA=
X-Google-Smtp-Source: AGHT+IFDn/Gg69njG25mI4d4sEhZazC4fYygfh318ZFGyBPM6YU+PgABbs6EeHt9ufd4I3vB2nPnxQ==
X-Received: by 2002:a5d:51c9:0:b0:368:4218:a3d with SMTP id ffacd0b85a97d-3749b54fe8bmr1391056f8f.37.1724922036607;
        Thu, 29 Aug 2024 02:00:36 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efb15b8sm860971f8f.105.2024.08.29.02.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:00:36 -0700 (PDT)
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
	Andrea Parri <parri.andrea@gmail.com>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH -fixes v2] drivers: perf: Fix smp_processor_id() use in preemptible code
Date: Thu, 29 Aug 2024 11:00:34 +0200
Message-Id: <20240829090034.15777-1-alexghiti@rivosinc.com>
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
simply use get_cpu()/put_cpu() instead.

Reported-by: Andrea Parri <parri.andrea@gmail.com>
Reported-by: Nam Cao <namcao@linutronix.de>
Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v2:
- Do not disable the preemption in static_key_enable() (Will)

 drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 31a17a56eb3b..febd8e74a72f 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1373,11 +1373,16 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	/* SBI PMU Snapsphot is only available in SBI v2.0 */
 	if (sbi_v2_available) {
+		int cpu;
+
 		ret = pmu_sbi_snapshot_alloc(pmu);
 		if (ret)
 			goto out_unregister;
 
-		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
+		cpu = get_cpu();
+		ret = pmu_sbi_snapshot_setup(pmu, cpu);
+		put_cpu();
+
 		if (ret) {
 			/* Snapshot is an optional feature. Continue if not available */
 			pmu_sbi_snapshot_free(pmu);
-- 
2.39.2


