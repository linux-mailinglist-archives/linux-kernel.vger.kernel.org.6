Return-Path: <linux-kernel+bounces-438598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34B9EA347
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D73161FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FF4A0C;
	Tue, 10 Dec 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KvMGilK7"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DE17C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789095; cv=none; b=IoSD7UfKwDP8bZUhWFqEJDaG8tw56ZVWd+cVAhlRmqevQJ5GhGl9te3AXIZE9rh1SzaSbjTGNQRv27+pzIoR7iiaHKbrLUDB6PnCzpkld7Jl572RM6zbvvWSOLSNsPtYGXtvcaLC6Y6k81sgi+rD0gH6CnX2wjZDG5HmyZyTxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789095; c=relaxed/simple;
	bh=Vy1XWln5Cw8TzDTS9fgOpLLRadpmi2eqtCYUaJxD/QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgpLC+8/8ZSB0nrFjhXYzFsHUggwYEZUJmyexQBbZjIUl9huFH+w5DkWneAo4Cvz25Ark172UVTBf3r7LADh+m49AVbQBJlcWe2gD7ZFQxIuV3I7aKDKoPaOJS/pqkuMgttFnSEPVnhVvaWtYjYsCid+0wR42lYsjXLFlfWXlSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KvMGilK7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ed193c9eso1380814b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733789093; x=1734393893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0pKu4QEUWyKrGc51Cv9urYoL6jDqPoRBL3/5PZAkyU=;
        b=KvMGilK7tdoVho1C1wJ2prwu5DsYyHuk1gh0TwOo4PmSNVqAb5mIn6dYQXdof3VIid
         6wLCoYe2NxMK6kLGXITRrVGGcofnCJSUnBe6+5MnWTlXAcuMOOurHNyvzqpB3mqT1Mmy
         LZsvo24IXkZmRr6fqpS8dwcYASywQ6Kx7TzhyxF72IVraRR05zRbkycXWW1kXhCVWKeH
         cLXG+wLqNeb0IGqYYucWQwDthbrI49v1W27ChkvX93Bs7oPEjEi9jhSkohaEvBrk52DG
         m5WQ9TWOQFAuAph0vz+EZu9O+FoVK99sIA3v6hpbBcLcZbnLpL3eBwIxgavG2qFYyi+p
         47gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789093; x=1734393893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0pKu4QEUWyKrGc51Cv9urYoL6jDqPoRBL3/5PZAkyU=;
        b=HGju483FVtIBC+XjaUnKStcZteSGwCc5oTmn1AT9BSSIgTSRFkt3QxGdycwkhZ7plK
         mzXcUwHufZnumq0TeHU6NnE7YFBhjdSD886M0zchyMqulFd3PV3RE3nR9fX8D4m0eFA6
         0ildOwu3lpX0/fnpNRhY+mOG2f88q6V80X4LlBJe/mal6pmWzQZShnkv4dEEv/xiZJxT
         yYFSVF9idRZMB4PGeVK4jkR9ijB40E6g3To0Il8HuWT8m/PMUPXkVqiwZaQKQNhvWeM8
         1TSXnSNIyb88wgTa8jbt+UVaivLaHl6eCOIV0zApGgigmHg6EV16IKorgoYOVcD8lYyY
         H2LA==
X-Forwarded-Encrypted: i=1; AJvYcCXEauPZQMvXqWQflTIhDFckXyFBjyJo65kwgIfpDeCjcnM2fqoZGTS9SCcBsF4llK+dtS6Jh6410Vsfavw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVujna7gy0VyRNCc39TIWIbSCQbvcd6DCw0T5M/bJkwK22o3B
	6S9Kvc1pnzcx/lDdAMrS0wk6c1l0NzQ/G0HMGy6Aslv49oEWoyAdVt//51Syk+vHcbELutViBV1
	m
X-Gm-Gg: ASbGncvcxZ5MbAI/jV/ReKU+Tu8J093kBlRHK+2K1QldRJ2b+N2blSptzZdLuIak5Vb
	avw1QViUowPQnZGvaKgBjGnkRuWS2oT4Kl8h/B7B+7h/pPugakoP2mxgYHGECaT/7vzG7Blo5bL
	ukWPpLPyQSxq8ttbktKFfJRLyUE0Osx9Wu03hDWenQlNfVqxUTiNPPt7wJlVHKqersv8yeI93J4
	lYeJfpMEBW6fcnTGDA8DB86uHjWkzU4URC6od46ghChhObn+Hi88tsO7aWDNalNmmU=
X-Google-Smtp-Source: AGHT+IHXM6yBIyUN5IOl2XwzQf3IuEJpf0cNwCaDErthAQJRzZCXMS7KQIlXRIe7/2ggUbe+PD0Nmg==
X-Received: by 2002:a05:6a00:1acc:b0:725:ead7:fcae with SMTP id d2e1a72fcca58-7273cb7fb3emr3815468b3a.18.1733789093256;
        Mon, 09 Dec 2024 16:04:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e3ca46f0sm3477249b3a.15.2024.12.09.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:04:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 09 Dec 2024 16:04:46 -0800
Subject: [PATCH 2/2] drivers/perf: riscv: Do not allow invalid raw event
 config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-pmu_event_fixes-v1-2-d9525e90072c@rivosinc.com>
References: <20241209-pmu_event_fixes-v1-0-d9525e90072c@rivosinc.com>
In-Reply-To: <20241209-pmu_event_fixes-v1-0-d9525e90072c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The SBI specification allows only lower 48bits of hpmeventX to be
configured via SBI PMU. Currently, the driver masks of the higher
bits but doesn't return an error. This will lead to an additional
SBI call for config matching which should return for an invalid
event error in most of the cases.

However, if a platform(i.e Rocket and sifive cores) implements a
bitmap of all bits in the event encoding this will lead to an
incorrect event being programmed leading to user confusion.

Report the error to the user if higher bits are set during the
event mapping itself to avoid the confusion and save an additional
SBI call.

Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 3473ba02abf3..fb6eda90f771 100644
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
@@ -536,8 +536,11 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 
 		switch (config >> 62) {
 		case 0:
-			ret = RISCV_PMU_RAW_EVENT_IDX;
-			*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
+			if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
+				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+				ret = RISCV_PMU_RAW_EVENT_IDX;
+			}
 			break;
 		case 2:
 			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);
@@ -554,7 +557,6 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 		}
 		break;
 	default:
-		ret = -ENOENT;
 		break;
 	}
 

-- 
2.34.1


