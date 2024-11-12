Return-Path: <linux-kernel+bounces-405762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626F59C56B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1838E1F231F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5523098C;
	Tue, 12 Nov 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WeBxBdXy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFB23099D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411268; cv=none; b=WjdnjIE912GJyuzuVr+FRpkCkMgTqu1ltyg057PnywRtBa4j2M8R5MvHyuFndsNFEHPbxmNFuV0YUhF5NycNrs1pekPFVNJgtsh5MgtNBqzkpLZywZKLfNs3ZFYHMx0YClTQwVxV/1Wusc81hUIj312RwYJKqqR4eQi4RziKkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411268; c=relaxed/simple;
	bh=TrMy78+4/7TuXB5dSLOYytj+XVDnFYxxAmNJU2r194c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EDwk9Dba9y6R8Pbj1uXnG0fG5Q7v9cp15YGyGOuy7J7ILc9VRPeHF1MCVqNkHdclmKozHEMot56SOLe2DpS+5twPAieCTogMsfm9JHCdaDWcEDzwGEc+8nXll9KVaVFpGKdj5DYiNWTqj+pSuwst553ccBwgS401Gva8g9o+oDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WeBxBdXy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so46257205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731411265; x=1732016065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUe71YecPH7XQ8UJJ5yU95TDCXx24YG8e7+/RrAak7Y=;
        b=WeBxBdXy5OLr9ToL90KK+sUy27BeRvY4FnMtz3rRKtoRvzNH3Oyqq7juB46XWOBbqk
         Kqn1A0q8TLUI/BSLUMDLDM72l2baktoVQ6EQ4csovw/+M7vTl4N/OiHVSfWv00CWx2St
         lLNB8hhN2LoqiGedr+VHX5vZSHsmY3Nde3LDUIdf1bxPc1WAnWcdamPLhywSglN2wOYu
         C7+2DQVJ5F6ta12S9MiOxrYmRB7NeMhjbD+3rw5kLzxnxoCeWCUPpTI/a+V0IaDsPEXP
         eFallY4yuCEsAYctimzSHzcp4Rq6+MpKX16ah5r0Gowg5qpGiMs34SuNEeO3jfFQFGlD
         X6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731411265; x=1732016065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUe71YecPH7XQ8UJJ5yU95TDCXx24YG8e7+/RrAak7Y=;
        b=o/bhTgEkqmBcl1XH1ZMYAMoEzFYwNmwWhIkhz+jpOaYORrtFHZUt/KKoXqCn70Q3/c
         Umj/InkqoIPQO3BIYdMw/1HQ4mEKtq1ZJgZJKuy6eOQIr0xgjQEVUi9JvrKWYlY0aPF5
         uwiNNw7MW3I7OaLN0quCIHTnrCvCH9ePPJ+I5i7AAKr3xOeiKybqHzSsy2mKA0uVEajo
         7FS99qp25EL92Hdjtib+NtoDTwSwjKsD5DVmAzzT2yz0Nh8B0zEaHoyZQipmODOvsyhA
         nVfm4RhXDzpzy4/Uqrf7tiHq60DIsqqDCajL+81kOPmb5Sm7ZOaivXRTaBkL9k+7vNzQ
         qxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdVrdcgikqnXTdpbhxc3EX8RG3GlJq2MAHXmRwYiFSvOf56P4ELNq8TQ/2Gvp02GgTnCoQFC8tT4o+sOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOgRHekZv2S2fGXOLYIPEG0KdtBX0MrZYI1MyN9VVg553+xAG
	kpc81LPZedxojAwGDImAG0VlTkBcrXD5kDweOH4Ho4bTFpJZN6PNVExxUrxWZEs=
X-Google-Smtp-Source: AGHT+IH7M/UX7fkmVreC1luerEEXE6GOHNSoZB9sCqED65rS6AXsEUNqfA2l6fwGjpmBaETaxjbK2Q==
X-Received: by 2002:a5d:6c69:0:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381f17261d6mr14681736f8f.4.1731411264652;
        Tue, 12 Nov 2024 03:34:24 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97fe9bsm15071138f8f.35.2024.11.12.03.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:34:24 -0800 (PST)
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
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH -fixes] drivers: perf: Fix wrong put_cpu() placement
Date: Tue, 12 Nov 2024 12:34:22 +0100
Message-Id: <20241112113422.617954-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately, the wrong patch version was merged which places the
put_cpu() after enabling a static key, which is not safe as pointed by
Will [1], so move put_cpu() before to avoid this.

Fixes: 2840dadf0dde ("drivers: perf: Fix smp_processor_id() use in preemptible code")
Reported-by: Atish Patra <atishp@rivosinc.com>
Link: https://lore.kernel.org/all/20240827125335.GD4772@willie-the-truck/ [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 391ca1422cae..1aa303f76cc7 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1393,8 +1393,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 			goto out_unregister;
 
 		cpu = get_cpu();
-
 		ret = pmu_sbi_snapshot_setup(pmu, cpu);
+		put_cpu();
+
 		if (ret) {
 			/* Snapshot is an optional feature. Continue if not available */
 			pmu_sbi_snapshot_free(pmu);
@@ -1408,7 +1409,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 			 */
 			static_branch_enable(&sbi_pmu_snapshot_available);
 		}
-		put_cpu();
 	}
 
 	register_sysctl("kernel", sbi_pmu_sysctl_table);
-- 
2.39.2


