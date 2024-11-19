Return-Path: <linux-kernel+bounces-414937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E19D2F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B28B25556
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467331D7989;
	Tue, 19 Nov 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b4KgB1ok"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208516A956
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048256; cv=none; b=smAcn1Lq2UXfvE3fft+uOJb/KcZ5vfDOJRElXMwZuereyrLDV9pyo6Hj6+/FrVrv3a2tAiPUaomlubCEsuAFVOV6wehCaVSApouONXsmPndMtR9gq1mN1ZM/Nu8cO0Vf1PUgJWR2pXGWF9ooWnuBciUvs//7Z+TNcdNLPAl7pQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048256; c=relaxed/simple;
	bh=rkpDrsA/PVcggHd7+EAEFge1PhxYTYtvQjpCCjdH2MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfgvLowwG7zehHJxJ+CdG6xiBWDVMPlPHCP0LY6OM10PRTZ3Oo133EMXAGKBNOf+BvBIqI8LSpP31AwvhqM3/aHtX3RmOR0t8TB8bAahEyvxZbn0ad5bNgGl+jUhjkaaLPBye+CTfpwXZXkWfy08p5Ce3IyEg4RhwIfqD22DY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b4KgB1ok; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2124a86f4cbso13654185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732048253; x=1732653053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCeV16Tw9Ue2BbFuxP2Jm0elvtAXwe5u9EmpHjH7wzE=;
        b=b4KgB1oklVUhjKk1dZMrSuSg+6IsBMa/TBmqo+HzHkgZ9Q4CqdC/d0/LFLNaNyED/x
         A2igfBBLHuVmVS5PVg9dxqdrYCirnHwoFSnfOFMQbwFrgVuCssHYvJ7rzxO92cpzxtxS
         tsbCnwcb0V/eQkXb8/XSWeXBmRvPwFqyiMlJRmWGAzeomfsKEzGKylBm77/fo4ilpQpr
         yViY2ChqgD8nXEIK1xkvu+HmV16jypC2JIY6jhQJLJD0/VmKh60HxGInbqhl49VTVCuh
         9z3p3cHrgXzqDP+Szu3kBNrWrpzoDmG4xgDX/1gc9ZNRIx7PbaCxs25iUrsKycCe6ukk
         jg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732048253; x=1732653053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCeV16Tw9Ue2BbFuxP2Jm0elvtAXwe5u9EmpHjH7wzE=;
        b=bAn5L9DvMXMhjWBzGi966icgDD+47qMmKuMXobjo61CoUhSNpI/cSmhPryN8bNmv/i
         Cwq684tHvlWfDUY4s9crVeghgHgAUxzGJ9AjPf9q41NYO+lrZU/k39Ikq7/7F151wB/a
         tkNOOtsRWbQ6WXgPt9yo6rMaodG+afcGaJ2Oi7xj9yn/yKSHz60jUGwvH6aCFX4yIz6U
         kqalktkcjxayCgqQVp0ClBOCjYiE2jNoQcCFR9/jiGPZzMA+AP0gLGeS91G6sDKbO5zu
         CoXPccmHv8JGL1veW58gIZkQ8XzpqVZjDsehju3gUb76uJb2ZdDEwBwrLzD2r381TMcG
         PMUA==
X-Forwarded-Encrypted: i=1; AJvYcCUeGqlXbHpV9eOmS49iSv82fpdix9qhrj2Q5LSi6QytMbKLDJTQWXEdGHMRz4hg2ZRD1kNRplYNrXqfebI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4215zvscKsgUM41iODZjCIj2qU2y4p2vs2uvGlDCfqtG3w8Zl
	ZKvDrlxg9dhG9jDyt0LzuBrmDg09cews9qDc+1K3XUkhEhzeEmMSxSQFnezZXZI=
X-Google-Smtp-Source: AGHT+IEafgQoRfTXfxDGUyFBcxI9JgtU3iA1K006RwHi5mhUuXe4EdyQsqlE+qS4Y+FQs5c25dBVLA==
X-Received: by 2002:a17:902:dac8:b0:211:e812:3948 with SMTP id d9443c01a7336-2126a259979mr4712555ad.0.1732048253488;
        Tue, 19 Nov 2024 12:30:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34f2fsm79001315ad.159.2024.11.19.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:30:53 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 19 Nov 2024 12:29:52 -0800
Subject: [PATCH 4/8] RISC-V: KVM: Add support for Raw event v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pmu_event_info-v1-4-a4f9691421f8@rivosinc.com>
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

SBI v3.0 introuced a new raw event type v2 for wider mhpmeventX
programming. Add the support in kvm for that.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2707a51b082c..efd66835c2b8 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -60,6 +60,7 @@ static u32 kvm_pmu_get_perf_event_type(unsigned long eidx)
 		type = PERF_TYPE_HW_CACHE;
 		break;
 	case SBI_PMU_EVENT_TYPE_RAW:
+	case SBI_PMU_EVENT_TYPE_RAW_V2:
 	case SBI_PMU_EVENT_TYPE_FW:
 		type = PERF_TYPE_RAW;
 		break;
@@ -128,6 +129,9 @@ static u64 kvm_pmu_get_perf_event_config(unsigned long eidx, uint64_t evt_data)
 	case SBI_PMU_EVENT_TYPE_RAW:
 		config = evt_data & RISCV_PMU_RAW_EVENT_MASK;
 		break;
+	case SBI_PMU_EVENT_TYPE_RAW_V2:
+		config = evt_data & RISCV_PMU_RAW_EVENT_V2_MASK;
+		break;
 	case SBI_PMU_EVENT_TYPE_FW:
 		if (ecode < SBI_PMU_FW_MAX)
 			config = (1ULL << 63) | ecode;

-- 
2.34.1


