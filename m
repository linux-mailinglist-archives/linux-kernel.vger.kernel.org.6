Return-Path: <linux-kernel+bounces-230187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7C917996
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49988B219D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106015B552;
	Wed, 26 Jun 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ydsAod9K"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C91598E3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386659; cv=none; b=hvBiSejXfoG6buicQzg+utilM85jnP1+QjgCpCGts2lezXiBZmMahxaZ89X1du9IKGvPU7lwxz39/J8+/De4TPHdD377gUFKv4zO8S6UQNSnwqd4xaMNl9CWd0DL1yfMCSwlJPMo4mZ+Urp4M17x0oOlHXhvCgB1tNzJAZvT21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386659; c=relaxed/simple;
	bh=06RBFHMu9Nmr2Q1NPTzjbWGxYqYy2/kVWYTcvUcMgCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iw1ue1wb7KTEcjKfPux7AymoSJHNoQwfFYGIaeT2NzQSChZKYN2zTufi0swGDBjDi3RcmnDuLXWwmfhSpqG4jgz7u4vyR5zXK0gpoTNUZOeyEgSczf8Rns4qzyEkn14JjKK5xFXwQsbvbc9dblj6FOVO1mUY718u/YsuiF7PUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ydsAod9K; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706683e5249so3130266b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719386657; x=1719991457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8anUdf9RYagj+8dVpBIC/eX2xYMTPOXrNSg/TEplCt8=;
        b=ydsAod9K6yXeRpcMm8tDmaqjjNyUKIdzyPtNMlOEduO6KV+O77ZIJvbPFTym+ao7n2
         ldrGpMu6MpOLla/t1FYY+iPf44ZN3G+Nh6MoNOmVLKJAhDcK4gO8VQR3eNt2yjlpui7k
         OA7p6CJ1TWmz3TrL/uKEiN2eB9BpzCL0lK6dKrX1CpGnjhONmaQBNAjWGmTqpl8qrI2Z
         ZwXQ2XOrQnlImygpB3UMOfUordVXLosu7h77IyeLiXPjWhJVjI+QXijgI24MidyjEDXz
         aUyNROmUaPistqK54MKpxsIxPhosOmRC03wiNjcRIMDcxPZQJMNueauvBmTzYsBbzZA3
         QLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719386657; x=1719991457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8anUdf9RYagj+8dVpBIC/eX2xYMTPOXrNSg/TEplCt8=;
        b=RVq3GjVf/1zCT1eau8IlQV9n1ku4FlNdq366l56dRBgmuhz4sA8ofrilbkqwX8wzsv
         h26rzxYgykVI1v0tde2wlsVWnRg5I/ZnFnRzWhFHgyyClfZ/ShBmG3yINT4Xe/uSzLAc
         O3awsz/DKv8s2GZtlcV+nRdZReyG+wUU+hzYuGWdWh2UHPElUgO+oocPGQQRgXj1p2yf
         IC/CNUn7kMb/qSqcbO+tBFkDDMTNSTQTj8aADEMAVFG9GEOx2IllyYIIe6nG8sT3D9rX
         FrmYMevMTIN8f8sBrEax8p0fGx7nezbEaZrmKczdqolohsE7AR9RuWsp2qOfpv6dEKh2
         oLDw==
X-Forwarded-Encrypted: i=1; AJvYcCUHoJJjc79vt1eJA1a9ABBI/APfstIb2bNBvWxq3vJaY/p55z6ikKCVxrNZ4Bsua63e8j1fvK4hh4qJxJ2+GVcfId1g3l3RqOKR6PlK
X-Gm-Message-State: AOJu0YyO80zHm9zKd31anozz9BZH0QN7KZ6NqFKwR0jz+Du3YDAuy4kv
	X1lpXqaJzCWNQVJ/pm3907EKjIcQ58m7dm+AX3YAtmQMqn4ANrlqy4Hc0PXn2B8=
X-Google-Smtp-Source: AGHT+IG/ltx0PscjisU5QEngpWeqUQrsUK17QM5DEDcSKzn36CUqRKBVIIjNHW6RZ5CQaoW0qeXI4Q==
X-Received: by 2002:a05:6a00:bf0:b0:705:9aac:ffb8 with SMTP id d2e1a72fcca58-70674582b1bmr8915411b3a.9.1719386657496;
        Wed, 26 Jun 2024 00:24:17 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706984a721csm2692218b3a.37.2024.06.26.00.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:24:17 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 00:23:01 -0700
Subject: [PATCH v3 1/3] drivers/perf: riscv: Do not update the event data
 if uptodate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-misc_perf_fixes-v3-1-de3f8ed88dab@rivosinc.com>
References: <20240626-misc_perf_fixes-v3-0-de3f8ed88dab@rivosinc.com>
In-Reply-To: <20240626-misc_perf_fixes-v3-0-de3f8ed88dab@rivosinc.com>
To: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, garthlei@pku.edu.cn
X-Mailer: b4 0.15-dev-13183

In case of an counter overflow, the event data may get corrupted
if called from an external overflow handler. This happens because
we can't update the counter without starting it when SBI PMU
extension is in use. However, the prev_count has been already
updated at the first pass while the counter value is still the
old one.

The solution is simple where we don't need to update it again
if it is already updated which can be detected using hwc state.

Fixes: a8625217a054 ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Reported-by: garthlei@pku.edu.cn
Closes:https://lore.kernel.org/all/CC51D53B-846C-4D81-86FC-FBF969D0A0D6@pku.edu.cn/
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 78c490e0505a..0a02e85a8951 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -167,7 +167,7 @@ u64 riscv_pmu_event_update(struct perf_event *event)
 	unsigned long cmask;
 	u64 oldval, delta;
 
-	if (!rvpmu->ctr_read)
+	if (!rvpmu->ctr_read || (hwc->state & PERF_HES_UPTODATE))
 		return 0;
 
 	cmask = riscv_pmu_ctr_get_width_mask(event);

-- 
2.34.1


