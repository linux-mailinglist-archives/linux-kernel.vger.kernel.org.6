Return-Path: <linux-kernel+bounces-444092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC6C9F00A8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4F016A7C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FF2F43;
	Fri, 13 Dec 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pzYJsboV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F5184
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048587; cv=none; b=BE4k+WhpMyHZna0m2dRIAQV6xKOATi8gT+9JnOoqKK/R6rI/dPmk/4lI55m9rD7M7GuJyjlI9g3LSgIpNMV7tLlzxRjPAc8M+vhTFxrDlqegJw4nytHpW1Voe6r6sC0Ah4ePpgDfG1QxapWXVxzXP/IoZmpdJTGo6bVu/f75yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048587; c=relaxed/simple;
	bh=lTpIts3udrYSfHg1aaa4pMV9Eqla2kPW+BNzwpyA+oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvEnLCzf2vS0WEsVXzP53Vo4MXm77rlIU+sYy3ojMv2We1lpFonU7khq+GKPwAoPR7znckdElTZDg/wJHiDrkcEgVkdMFPs7XxfaiT5e2weFWcIHyBjRlgJcJVhwblwrSPdDxTZIPLI4pPSLxpofehGJEGqP+nF/GxrrVxDR5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pzYJsboV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728d1a2f180so952311b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734048585; x=1734653385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCAy7SVqNUeDgI7VOXMtmc8sKn2/Fu8F40D/mh4hVio=;
        b=pzYJsboVU2Zmv8f3v/Smc+fkkHciUR28i4aWFPq4WhcxolgofMTfVxWP8lXON16xQ6
         t2GTw9Htc2Vt6ZXzJC7gaownhjCfkVq5Qv9g8zzBV9x3nW/Ut6KzPi9xL30/143jNfa3
         wgXnEzGCXNE5C5ZKRr+emdeD2tvrt3T+hQ3vBNq5fIhko4uSFFjL4CNBCJN5AS5Bpm2w
         FDpebPRCtgS4rwTqbXIfG8ukWXX3OQEdBHvUakObrvPtuCFtJ5o67oxtzmFFuPcRs/Xy
         bntGKzobhymdevWVE8DDCUQflF4t7kZWpfzyrdmZuyMbNPdOxrF7oZX8cnwja0HrbWIW
         mgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048585; x=1734653385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCAy7SVqNUeDgI7VOXMtmc8sKn2/Fu8F40D/mh4hVio=;
        b=Wab40e443UntUfiQt6XA3OADbHbQ85IC4hvapCN3GR9rx5bhV4i4pYzMdgeFC7w4ia
         G2hWCCjxG4CVdkO2D4zIQp0fkwxZ0krR2KfwQB/Ki5lrqcL6Cv0ETYhnnL2ZXpYMUL5i
         nfnkGalMyUtzH/e6noNhfpsd/j2p3AoK+Yq4uhfw9R7amWLtNXQu/+NHOrejePFZdSaa
         UsRdhmcMGxYZXEMMRG1ahSeXHT3FifaHy7gTZnCYClL6p1x4JzkLsoN+4wm0gMn7/sC4
         LwGLJ0ywCrhQQwXhY5GigRRj1dIjwlDLvI9YU03dDAlcEojCzjMcojMg7EnnY9AKhb7D
         Afdw==
X-Forwarded-Encrypted: i=1; AJvYcCUyO/lnxMxVO1Jh6A06voyYhVk4evkKQK/eF2rnvPZatcR3PBXVauOAcoVOhLB0uEW1qfaCdBSOOW8pIJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidhtPNXLSQwEsOm57cWEu1x7/9FX6VkuFFxrU+Grz4sZ1ijT5
	zyr3Vl7awFfpcQAR9LkFtz06u0CuJ+ARkIhjl5tQz0qDvz6t5blbm+9eJiFdAcBa+x8PRiyU4OB
	Y
X-Gm-Gg: ASbGncsplUNKz6PXx19Ezv+iFTpqCaRXKxG8j8TOO4ztj0X+wRu7mqYa7iv3a0KIMup
	yAJDmQFHZcI01oFpZ2wdyBVni6BXRWcF9LCmuhN4rMDW0ywbEdxS80/YZhT7x8EUJiqvtEUrWuk
	v7egqyToHtJdnFkOgTtDjokwx7Tj5vtdjq+n0763tHbxV63uV3hknqVJEyGjddK2D0klXdFP5rh
	qsQH/wbfDf4VMFzVN+4KrwNTN6HtYi9BC/+DOBC4E/+DZJKLylnNmX7JVrhaYP1H8vmug==
X-Google-Smtp-Source: AGHT+IFUwHgks9QcEF9SAY9GOpi7wPRiwVMzhV/sEpt+kOA7+YUYYNzQWBpZatxjHq/0pnhF+jfgrw==
X-Received: by 2002:a05:6a00:8c15:b0:725:ce39:4516 with SMTP id d2e1a72fcca58-7290736054bmr2582686b3a.7.1734048584760;
        Thu, 12 Dec 2024 16:09:44 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f0a0779dsm7441455b3a.154.2024.12.12.16.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:09:44 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 12 Dec 2024 16:09:33 -0800
Subject: [PATCH v2 2/3] drivers/perf: riscv: Return error for default case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pmu_event_fixes_v2-v2-2-813e8a4f5962@rivosinc.com>
References: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
In-Reply-To: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

If the upper two bits has an invalid valid (0x1), the event mapping
is not reliable as it returns an uninitialized variable.

Return appropriate value for the default case.

Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmware event handling")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 3473ba02abf3..da3651d32906 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -507,7 +507,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 {
 	u32 type = event->attr.type;
 	u64 config = event->attr.config;
-	int ret;
+	int ret = -ENOENT;
 
 	/*
 	 * Ensure we are finished checking standard hardware events for
@@ -551,10 +551,11 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 			ret = SBI_PMU_EVENT_TYPE_FW << 16 | RISCV_PLAT_FW_EVENT;
 			*econfig = config & RISCV_PMU_PLAT_FW_EVENT_MASK;
 			break;
+		default:
+			break;
 		}
 		break;
 	default:
-		ret = -ENOENT;
 		break;
 	}
 

-- 
2.34.1


