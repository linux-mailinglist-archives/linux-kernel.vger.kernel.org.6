Return-Path: <linux-kernel+bounces-511718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4409A32EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C4D162D35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02CF25D558;
	Wed, 12 Feb 2025 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="az8W7Jtv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DB27180B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385180; cv=none; b=kMX2oKpn3Uah6bbw+Y8qXe4nRps1S0reGkiBVwkACiVVi04CGDUyqM0E6jGp2gI63DU1m2k+oCEMYOwHxfbMxdsX/K0SCDv8rQclFl8SOuI6m0npTVtYZTQ39uwcXkMBzcPQhqygGoUVjDli16EUcT3zDMqz4MO7hEsKkAbPYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385180; c=relaxed/simple;
	bh=DScHAAMLHvU4xu4O0WcfNhf84lXVnZDNRB2q3PdUj1M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qE5/LqYKLCIgL/VToO3K4//YgyYsskZrMt1Fgh5KfDJ9yftkUYemQiV/HMEwDHWbzg0A8cPaHVlmLt8p2J9FN/tUzFS9BF5IjHAbvj+aXgxzHmaN70438zmE4LqS//o5D56tOy7F6KOcynM47jFBd0KHw5HTG0gHynCmT2C3z/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=az8W7Jtv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f90aec0fdso73688715ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739385178; x=1739989978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYmiCJ+R7Juy7BxO4gHWUFDYWab8Kg8RAmIlcH74Szk=;
        b=az8W7Jtv/DJtnL1epuGG+ZQiIdarzAKDUm/H/k6smcA0DM/eJikQFF8dKqXotbugUx
         p1VJyL0xYJgB460ioVaLlJfLER9wnHM7rTkBeBASXm5XQRLSF0ygGnTLp6ZxcYkz6VrH
         dNaHwLjUmEliH9e01MGo4bh2x/T++GDUX5v1SFJUr/lU8cCQi/p87S8gXStATBw8XV6K
         m3SgdgBQhuG3/MThSZgNLmo8ejN6sOimSBG6dgY61PejtzWjeGkUq/wZ2tUwDmn/4UK0
         M+Ag6jjyltrn+34xhMgHirHOK8yJxtRMMdhxkzhaB5pFkGI42EQ07TnOtrnEb3+VUF52
         dOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385178; x=1739989978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYmiCJ+R7Juy7BxO4gHWUFDYWab8Kg8RAmIlcH74Szk=;
        b=IW2YSiIYiOz2Ed5m+hr6BpHhati1fhSSwY/u4e0+3frssE5RucPjH81YqS80Gh1xjg
         ULtsqAZAxb1cLOIIamXTCHVKFNbbIbk2gBpoZGJOw4buWXSElom63wy5558vFhVTb6wH
         XJK5aTw/HQXBgSZMqADX5kt/8VlMg3MrdDjiEkAc5HIrrWLQsH2GyjKoSF0rHUydO8gz
         9wiFlCxOVWbY8e5N6USEJ5DoMo/RFsNu7S+rukDU7agVszHDfNPPgSrXtYIYfMO/h9Pf
         iHlJCuIih13gEy0WaupyRKTLwlxWTroNTraW2C13x2HjqUVy+RqlsOHb46NW3UDempyA
         SrtA==
X-Forwarded-Encrypted: i=1; AJvYcCXYeiqQpMkBzljrJ9ua+DTvfv5XInpkVmKMDwObokKRPnxKD3bqpvwU3E7pi+AUEUkdjkr/5fLSsjawfcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAn0I1JaQ2gNPbYGMd+1dofRrQ6cmOjMEQL9qYGRrxiuRmtQ5
	6o+qm69j773sjPhQ7LV25+2uqcBT1L0z+m4JtmThYIzWS8kfdJTjQ6nuWFEwBKAT59I6N6HS719
	sdwSp7fjrguHsr/FHJrfpuFYPFQ==
X-Google-Smtp-Source: AGHT+IECDfJK531HNRGV3syvC/DgBgcGWiTf33LlelsMxeULH9/uMoeKotioRlyy2DZQ3lTimCD19P4P0Lz7bGElf8A=
X-Received: from plbmn14.prod.google.com ([2002:a17:903:a4e:b0:21f:44cd:af62])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef52:b0:220:cd9f:a186 with SMTP id d9443c01a7336-220d1afdd64mr7208785ad.0.1739385178165;
 Wed, 12 Feb 2025 10:32:58 -0800 (PST)
Date: Wed, 12 Feb 2025 10:32:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212183253.509771-1-willmcvicker@google.com>
Subject: [PATCH] clk: samsung: Fix UBSAN panic in samsung_clk_init()
From: Will McVicker <willmcvicker@google.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Stephen Kitt <steve@sk2.org>, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With UBSAN_ARRAY_BOUNDS=y, I'm hitting the below panic due to
dereferencing `ctx->clk_data.hws` before setting
`ctx->clk_data.num = nr_clks`. Move that up to fix the crash.

  UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
  <snip>
  Call trace:
   samsung_clk_init+0x110/0x124 (P)
   samsung_clk_init+0x48/0x124 (L)
   samsung_cmu_register_one+0x3c/0xa0
   exynos_arm64_register_cmu+0x54/0x64
   __gs101_cmu_top_of_clk_init_declare+0x28/0x60
   ...

Fixes: e620a1e061c4 ("drivers/clk: convert VL struct to struct_size")
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/clk/samsung/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 283c523763e6..8d440cf56bd4 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -74,12 +74,12 @@ struct samsung_clk_provider * __init samsung_clk_init(struct device *dev,
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
+	ctx->clk_data.num = nr_clks;
 	for (i = 0; i < nr_clks; ++i)
 		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
 	ctx->dev = dev;
 	ctx->reg_base = base;
-	ctx->clk_data.num = nr_clks;
 	spin_lock_init(&ctx->lock);
 
 	return ctx;

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.48.1.502.g6dc24dfdaf-goog


