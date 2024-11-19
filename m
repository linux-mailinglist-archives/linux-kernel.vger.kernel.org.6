Return-Path: <linux-kernel+bounces-414933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B79D2F70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC51F23958
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329B91D4173;
	Tue, 19 Nov 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o0xsLxbk"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5614B06E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048253; cv=none; b=NSml/B1O3RJTFT+HxxvEoBac2kPuOTRGF3J/NAgm2EfvapXRjGFr8B/EmQMsCzpal43ojgCodq4L1WrOpiWhqmSxKmim10yVYvaOsY5Pk9Iia3VD1mEXPxGHEADPwSglF+sKizjQ2YStW7Ki4APqPi+d+soJrZ1SNiAmdFrFHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048253; c=relaxed/simple;
	bh=9a3a2dykXm+Z1VuOIzXUUFPIUB4KYnT3BbloIfBYDqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZnY5ZMO94FznogXice5/UWFYZvhN8utdSMGRwwakT21S2H4lT/raTjHBJcBlWys60eIAok/JYR9T1w3wHeUNg3xoz7CqvKMAIwhhv8Z29DTAk/Zp0teB3pS/aEmrgwU6OFc4jZGB9Pe7Mt8cc91Z9sd+o5Mw6WyPidEFUCwOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o0xsLxbk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so2189568a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732048250; x=1732653050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qPwdXgi93D1Fj1M3CTUmRPQX23R+cN6bIgDXtW8EzY=;
        b=o0xsLxbkhLJ21l87Ve0dLhopPiU/2eKj5rUKGEmqAsKjm7Mklrfr3qPEAJ8B7zjOl5
         f3t0oJdnWna2iun7jK8a+iVMfFzLROCO+Gpq2c1aFOEWtf6xIMViwMoYystcsNSy3B7w
         5OVyohRwrKCXkAcSjCeEmFw/TNuAWGzZ5bJ6fz88salWfutHIM6GwYIoC8cN32WtVYr6
         B+FyKLIHS0cmylE1ND4Ruso8YkixxR0SP4GAwl2XUpEjyofzmqrVlzx7A2CK8KNtxjw0
         7AKuQMLuC/VpDm3gWz23i5llqaA3wngwXusqimS5KDHnQIDzWaSWDbQqK4WbDPTZtvu3
         PTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732048250; x=1732653050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qPwdXgi93D1Fj1M3CTUmRPQX23R+cN6bIgDXtW8EzY=;
        b=OunuBN+XBiAIGCsLjvatwR3KCUlch4UPUMFlNsUZUcMjjAMds8rw314SN8HCCxKRsd
         3UiHYuqzbzvgSudd3PILfQtCWEXwb1FOLdKoQrM6sq93P6paLyO3izh8NuZweQhgsx9h
         jfU1Hfv3QQb2wTVmLCl84RmOp2mDVUmyTF7vUePQZNbyzB377nlDMpiGsUsXqz7zFl4v
         GXW3W1x7S1RP0e0edtd9d9JrGA27evov0v7Q/wH2vwANHNChfkVkQPWiCf/oQgnSOM7I
         Cnp3uHAokCuTeCJoEHq5x2nT12806SWkADT1WUSg49HNAcJxRngdh9EstY2ReolVLDk/
         N3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUS9L8mszGmSYWt3+hUz6LLEE7NTLqZbFhydBT3hR1gd+lvplVfJty9T+RYMq7oGTB1tHubWyym5a9ZrlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvRly/meL9ppADyPfMEmaP6VFqp0QnA4ZFXYbcKzQ0Uod0zaH
	DtpMAnFm7AETdtHuvm4HPsNoLU0Ej3wINuemNu0R6xQiADx80yFD0bjMfjmFXEY=
X-Google-Smtp-Source: AGHT+IHGbLa6SegMg+6UWCLGuDz+AC9C3f5G3GHUQKuYncIbocwbfU1Y52MRciljHs7ffGD0KEce3w==
X-Received: by 2002:a17:90b:288e:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2eaca70abedmr135913a91.10.1732048250306;
        Tue, 19 Nov 2024 12:30:50 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34f2fsm79001315ad.159.2024.11.19.12.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:30:50 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 19 Nov 2024 12:29:49 -0800
Subject: [PATCH 1/8] drivers/perf: riscv: Add SBI v3.0 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pmu_event_info-v1-1-a4f9691421f8@rivosinc.com>
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
In-Reply-To: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

There are new PMU related features introduced in SBI v3.0.
1. Raw Event v2 which allows mhpmeventX value to be 56 bit wide.
2. Get Event info function to do a bulk query at one shot.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 391ca1422cae..cb98efa9b106 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -63,6 +63,7 @@ PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
+static bool sbi_v3_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
 #define sbi_pmu_snapshot_available() \
 	static_branch_unlikely(&sbi_pmu_snapshot_available)
@@ -1450,6 +1451,9 @@ static int __init pmu_sbi_devinit(void)
 	if (sbi_spec_version >= sbi_mk_version(2, 0))
 		sbi_v2_available = true;
 
+	if (sbi_spec_version >= sbi_mk_version(3, 0))
+		sbi_v3_available = true;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",
 				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);

-- 
2.34.1


