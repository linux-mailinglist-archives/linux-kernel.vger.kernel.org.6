Return-Path: <linux-kernel+bounces-269849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1819943778
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0311F1C21FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10A16726E;
	Wed, 31 Jul 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWUzbLHS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFE1A270
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459657; cv=none; b=bnaQbV3AXONADH4V6WFfqCGX2KsJkdVrOCqIuum3xi4lylXCHELhvHMKa9AlkfL4oSgiz85SX/gf36fDTra4DSkd6UYG1kQxUdYGnBBOIi7/Pw8egZ/EBuu9CvlQuzEC6B1bZTgqJy/Fe3okhUmHEfk6WbIeb9WfVOkcsx5rav0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459657; c=relaxed/simple;
	bh=OfU2AWw6gqIZUEVgkMMdwA8/GNGM2t9kD7s37/OBuSs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Aux05RWqwXzm44vLShjAL1EePpTkseOjipMjt+Ya6A3EeplMprxNBJPX9gjace14U4+YGhjzBZ7UwDktB7o6Lfu0ZaGWz5Hj6Uq+QPW4onbu4WPdCB063Np4ZiVJpOXNzopViXshz5eN4jjLRqRU26j07iWuI8wdindmJwyzCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWUzbLHS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd9e6189d5so49092555ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459655; x=1723064455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ3Hi6MdTigNx/ox3mmzc/t+EiM/L0PwVH9TYxKTSmI=;
        b=nWUzbLHS8rhLhh52OwdZdZkFqLEdsPAtj6hGxDyAi518WH5n+hAcNhCInTW9gQYEvA
         8RHfTPvcHFeu2A/pkkJnEMM7j697K1IvTfwo+lbcv35vLaVX7q3fj1GfNN9zEhv+d52c
         dIwWOWzhpfQj/+Q+7KhWj7eVY9gRviq1vKKILmIfOpg9YBvFxOhzYZUr6I5vyAG1DU2M
         UbnQZGVesh2awbP0NBuAWwE+PkoXdrxA8giiknKrLf+/QwbmMyYQWxW9Zvr7LDDfYb+3
         KvFnURL1IwLTIYCrl1Dxzs3G7vOdckCrtnZ/gL1m9At6hUxlwtIMks0NLi4sKjWyR6cT
         gSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459655; x=1723064455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ3Hi6MdTigNx/ox3mmzc/t+EiM/L0PwVH9TYxKTSmI=;
        b=GgF1TXjFSdHapeWvma2mD2BzeTVdvEJVDTuuaJvl2j54MRv/zV2fUsG3EVb1OVTNwg
         DuNmMTjK65AI3vZuh5skHfBPx7ASpQW1JGC4jkR+f0nDzTvufSDnCDAt38rle9Zvnip0
         OHqpnKuMQDNBKZZtevxhTAbW+D+aAsuHjBxH1hkaGmTKjy/sVSINYwOzw5abXgoo51Z/
         RpmR4JaGN8DKLe4/WAlg+0uhOsrFdqIuVcE/Zv4M0EffwoLPrvdQpuU19856nohu8WVC
         VcUf34SUmm0FAe5zOvARhY6DuG+DJKBD64Vm7SqAJIcI1Tud++hOnBfAUaiqlfG1XNqY
         L1cg==
X-Gm-Message-State: AOJu0Yze9Irs0VxWSL5Crh4zSZHDA8x4O0hWl2xGJ6ffGi56apud+oRx
	iNVzJ78TDsWtDFMs7X+kuK7M5v2RWxdb768lYIPEg/xTGCKi1rgoTbla+w==
X-Google-Smtp-Source: AGHT+IFfQLJfSU1xmeI6sCIgJ2qAHYfdHmZRdudcoTPE5E/hiohxu394vTNczAUKq6HiyqqX3cevvw==
X-Received: by 2002:a17:902:ced0:b0:1fd:9a23:90c4 with SMTP id d9443c01a7336-1ff4d266fa5mr5559795ad.65.1722459654961;
        Wed, 31 Jul 2024 14:00:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1477sm125265475ad.169.2024.07.31.14.00.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:00:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] net: ath9k: use devm for gpio_request_one
Date: Wed, 31 Jul 2024 14:00:09 -0700
Message-ID: <20240731210052.6974-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to manually free the gpio now.

Remove if statement as it's redundant now. The gpio bit now gets cleared
whether set or not.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 5982e0db45f9..dc18a813f1a0 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2732,7 +2732,7 @@ static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
 	if (ah->caps.gpio_requested & BIT(gpio))
 		return;
 
-	err = gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
+	err = devm_gpio_request_one(ah->dev, gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
 	if (err) {
 		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
 			gpio, err);
@@ -2801,10 +2801,7 @@ void ath9k_hw_gpio_free(struct ath_hw *ah, u32 gpio)
 
 	WARN_ON(gpio >= ah->caps.num_gpio_pins);
 
-	if (ah->caps.gpio_requested & BIT(gpio)) {
-		gpio_free(gpio);
-		ah->caps.gpio_requested &= ~BIT(gpio);
-	}
+	ah->caps.gpio_requested &= ~BIT(gpio);
 }
 EXPORT_SYMBOL(ath9k_hw_gpio_free);
 
-- 
2.45.2


