Return-Path: <linux-kernel+bounces-230188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E30191799B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0933C2845BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47215F3F3;
	Wed, 26 Jun 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g1wmV/pH"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AF15A488
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386661; cv=none; b=rj18FisfhLxASfxC3NSTjGl7ZFxa8Quq0R32SPA4Nj1p5H//jy1UWK5wyg9DGZnOQ7/wI6zQRaYDLwGNM6hbDWpk6juSmQ9PhL7UaUdczBv7xE1gfMljmBabnLXB0UK3CMk5mcZyg/T1mUM8NQKtBUevi33uNLr9X1PvA0OdlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386661; c=relaxed/simple;
	bh=Q6fB+0U1vwNDij8/HH+ONSB+ggEQtVYZcG1us9ReQnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk8M9aShmtcFnAyR4Dm72atlNQE/mcKE1zs487bgG3OwIFlm1F0iIRGTgCREthvKtrd48z4WGllrO/e8LGUN5kxVhWUWIJ2fhZQcKjkA6q3IiZFP4otCdhNJhHsxukG/wVtEZuzcUtxw/tWj1r0nXbxVB0PGJJ2D3oezlGf9luM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g1wmV/pH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70675977d0eso3026329b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719386659; x=1719991459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njNBT7xpsrpGcVD9LgzuKuD8VWJ85LTW2hNYGRcpIO8=;
        b=g1wmV/pH4O5LWKvS6hBr7YOkbXJGRiIh5pz2efN5qPfQrlwRjDVvMP+9B0yqgx/YPW
         IiLvqbO305UCLNExCAZj++IAc1fM2foAN+5+54abI4JFu6u3xhK8Ts/A0EibS1naTKLG
         NdSHrHnnRyp3JSIt/guO37fYnS2NwPmU88b7QZCV2Lp5tQ28ChbFLRZjPw/NaAXy9o+Y
         xqPyg8U7aBySoOdn/9EC6p1r0KZjmWkb12h4ngpPLE9nBYRTLhH8tUssM+bFT6uC0Ocn
         XTMdHETYhK4Uk5DHc0dhsQSYPZofnlxISQNBOesdc4PC55UsCpSv3wOy5VDpSBQhO5/e
         KP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719386659; x=1719991459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njNBT7xpsrpGcVD9LgzuKuD8VWJ85LTW2hNYGRcpIO8=;
        b=f5h+Y14nP+B7AhKBL+U98FftcQaT/Bgakj7ib0ZDi+wQ8WUHA0biSsX5B8A9gojxhr
         gqVWnRp0uc9ufXg3vwu+y/M2bABn+OW27SX/tHyU9vkO6zwggUFoI2Xr8YY5MxaQEbg2
         +64VWbSNN/OSJ5iOKNoppCWzPztmHR24kDWXvaaska1L15Qcjgt/HExOhZuBq5veCY0b
         t9aDJhlDi2AAXNEdKzuJDNx/3NGBZwhQx+6ZADZ9KN6mlYQ4HKqPFjFKETF4AZe/CPZT
         Lii9WtdHqnx9Gffm5dHz56xB9c2IJBU2MQTPrFBWNzwsA4xrRKZUkYpjC7FUPiE0GBeP
         m60Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmIjfXEzE4ljHpnZPsAUiFXRKRxT2fsxUbM2JjBIdfMB74HaQQJ2pj3pxgNl79lJjqB+dVE1ypRy+y1xgqKsXFGGuvdyMy6UDFkibo
X-Gm-Message-State: AOJu0YxgyQ1faR6FJ2JYLxd0QbQzDk/h/d37JqK3NGB3iUy6BSol225M
	f/UDiVc+dKKsuRUHok/G7WEuBoeqMT8Un9Jd6zSEmEqOuYNvAkRqc/g4n0SAaN4=
X-Google-Smtp-Source: AGHT+IFjsQF5e7oc0NKST2xoCih6SJziqYjY4xf7uMtfC2cP8xPNNQr3F5oh1Cg01FunjCN8iViJ7Q==
X-Received: by 2002:aa7:8ecb:0:b0:706:57ce:f042 with SMTP id d2e1a72fcca58-7067455bfd2mr9223061b3a.7.1719386659342;
        Wed, 26 Jun 2024 00:24:19 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706984a721csm2692218b3a.37.2024.06.26.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:24:18 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 00:23:02 -0700
Subject: [PATCH v3 2/3] drivers/perf: riscv: Reset the counter to hpmevent
 mapping while starting cpus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-misc_perf_fixes-v3-2-de3f8ed88dab@rivosinc.com>
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
 kvm@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

From: Samuel Holland <samuel.holland@sifive.com>

Currently, we stop all the counters while a new cpu is brought online.
However, the hpmevent to counter mappings are not reset. The firmware may
have some stale encoding in their mapping structure which may lead to
undesirable results. We have not encountered such scenario though.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index a2e4005e1fd0..94bc369a3454 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -762,7 +762,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 	 * which may include counters that are not enabled yet.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, 0, 0, 0, 0);
+		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)

-- 
2.34.1


