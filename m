Return-Path: <linux-kernel+bounces-233537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85A91B903
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0954C1F22EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7014900C;
	Fri, 28 Jun 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="K8MLtgJy"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3C143752
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561128; cv=none; b=ruGu0CsOsLaVAG1eUZRzxJFrticcBD+nDsMS82o+efoigMS5nGzpjBM/G9TLZVkwhV/sn7loVl4vj5U1wmaWoBbaQSNK+VOC6CAx9SR32EKFBlyg6WR0JeHXEJZfetVZb2aOqzMO31TQoSfXZuxh6EUpy+iYPUj5tzgXxHN8EJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561128; c=relaxed/simple;
	bh=Ark6jD3S2s0EGCk/kplfkHpXwZMR4vMqPsKy7BXH++g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBRJdo7ai02HnvMpdIpPIDMlcxBujUjv0bOYGkQRFXIIk0gVanl1tWfuxsusJguzLAYI0LxMlaFEUAGU9rM+sOfmTH5MyamPwym4z1F3jkpuaSenQWJva3P6SeRqNA1Fp5GQmbSuP4GSYnT9zGxQmz7p1dcPZH4sn7hRDiUn/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=K8MLtgJy; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0361c767ddso55659276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719561125; x=1720165925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eu+2wcx6ARI0Khk7sEf+LxSnsWz3kwiEgnTb6o13mh0=;
        b=K8MLtgJykJ6umJOFTmnh7i1rJ0JFUa2EJUnCBDKyJyVwabXGhCIUaHu7iofA4qsI2e
         te5ZDAz3DRBbn+Phaj7JETpQCxB7PkW4fx8SexCL4w138FEa43FrSA8Pc/bZh2bIRQm1
         maxY0NkVU/w0q4RI125XHdn0viFOqJiw68wgjakzpz6/wzV20yhBTXWB3O4aHzpSK+TP
         ih3SxkzZznifi60f6IaWvfGPr5laqppuSGejZB2nlG7rEXlxec3N3M9p31bemXsAZ2Y2
         DzuVQGrMG7UpHvYm5gQ/v8NOkBhpduTmYGq8j4mT/EMCtw/y0GRnVeWO3u6tKOlFTNFA
         9MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561125; x=1720165925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu+2wcx6ARI0Khk7sEf+LxSnsWz3kwiEgnTb6o13mh0=;
        b=fKnAgA1iBqKFg/7+aYkRVIwYJ63pqZJzzoFDTZFmF2LdV73oh2rFQNbBD4GJL/SNYF
         3+nuEDmM0t88+gbshPDvvUykA8AO2Xfs+njrTVFy0jFJyr3BmBmeLc/gJCpWbCq6UGU/
         sWjcDJKQoKBFUtFqq0IKhi0A1HJ+QJRLqHd1r1syFBkMhUvdPiguhqKmddXjIBfGgepI
         ob1alyrdv/fWpLxyuM7RtvpeOoFIlaSeP7UeKKIwB3gGQIjwzv64ZH4jttvEEdjIoRle
         GSxamiXvFk3D8ZAW6RR3/mskZWWiqEK/p1kvOI8HR5To2qzlv/v7P3qnnPtjcddeRHR/
         XH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWegSnYXfOMAcH5ErA1c1+XLMui+5Z4Jl7OSUBTBMuArVJoApL+vZrZguBvLaeS5LZs3WJEDOCArUzwLW+UaZbLum6Kq0zDBgKBj6tz
X-Gm-Message-State: AOJu0Yw7FN6p6/mlAGTvnJgJ6l5FqTqnJmX0xGhjQwZYqAblNYBX7C/r
	sdQZw0J0PenluyhEci7qtI1xW0d3fetwPr+1f/+W6iOolMo9qs+f5XNMXJRlsNk=
X-Google-Smtp-Source: AGHT+IEZUhwullYVKgF25a+0boKvH0ownItzxOgMvrt6D0RnS9rjqr16EhSB3iPBE5ZjBx8I+fBacw==
X-Received: by 2002:a05:6902:1701:b0:e03:48ed:d275 with SMTP id 3f1490d57ef6-e0348edd2d9mr4844561276.61.1719561125224;
        Fri, 28 Jun 2024 00:52:05 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53bf2sm685068a12.2.2024.06.28.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:52:04 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 28 Jun 2024 00:51:41 -0700
Subject: [PATCH v4 1/3] drivers/perf: riscv: Do not update the event data
 if uptodate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-misc_perf_fixes-v4-1-e01cfddcf035@rivosinc.com>
References: <20240628-misc_perf_fixes-v4-0-e01cfddcf035@rivosinc.com>
In-Reply-To: <20240628-misc_perf_fixes-v4-0-e01cfddcf035@rivosinc.com>
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
The event state in the overflow handler is updated in the following
patch. Thus, this fix can't be backported to kernel version where
overflow support was added.

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


