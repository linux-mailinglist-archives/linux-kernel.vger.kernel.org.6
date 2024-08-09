Return-Path: <linux-kernel+bounces-281022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FF094D1F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365791F222AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB6197A8B;
	Fri,  9 Aug 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lFJeMQ7d"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDE197A66
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212969; cv=none; b=PKcn8/Of86Y4Fajci+ozc5/cNpLvbJ2NCW8R+zlK+hmBFN0XeRAIQCHWoxE0A5wBU6t/5CwYf44+i9JWnnwz5I6/rmn2dwQ8RTD0T2zNxQBOlbWc4kFnWsP9qR2JzKZ6ktXPffKRu9wDm33joBw6x9ZNca4LfoRG4XezCN9Y3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212969; c=relaxed/simple;
	bh=ggvDZFDXx83aRXKsYxtw5YjUyKbrE+InX+rEpXnx5R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ungsEjUavRpGKiyKUPSii72R0uOClWdFr11W3aG0RV9kp7Ut50i2sQrvGX+b28TkEjy8O8FPHqmtVY9GSAcppRX1Tj/EVGc4IX+KGHN32+Toqoe+kLvv8dSKxiSQnf3TRgU4veHyTlaDFry8RLHkNOIuxzzi7xH5hSJWGcZ2Vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lFJeMQ7d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso20300915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723212965; x=1723817765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQPGc9dApofQX7O8RmOj4WWUlonbWJviZjIvwMVzuhs=;
        b=lFJeMQ7dMoo7RSy4HTUwgVIkiXAljXEySmbDBK+GjSe8oLl0raiA179UL4pqwismut
         S2MYXfzIHAb3sPEcbiVurZ4WxCvJ5UskOCUogp6a58Y6t6zp6yN8uOQof89GagrIj6ta
         Rtr+83kQJgX3GeuC+lpRg6oawhVarEpw0G/LbUGlmVh8TpiNl/zFAweEYEebS+dCc+Xj
         8NU7/KqKgAXRBSXBi915tY7zhNexSr//1OUsSSMsa8M6OxgsLdGW25H5OlIZh2ccR1Tv
         leph/C/u4R/miDMbGGmSSH8B0rFDfS+uzfulPfwoClglJyUN/DSPYMBTTF9Y3GqH4Tpf
         CfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212965; x=1723817765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQPGc9dApofQX7O8RmOj4WWUlonbWJviZjIvwMVzuhs=;
        b=AjdiMNelQYW7W9sK9OkyiSfS8TZfAkAyH7CdMyi4MHtorzxA2F3Jj+lVHVtXGBC/eH
         WDdqW2mnaI5oX7u7b7E9ys45x+XBmWmj/VaxZFmhuxhXQwYOj4eJN+qWTu/lPJryE9HK
         a7duIylx+ZDGAfZ45xAHGndmZ5DOQb0afq69+iubuakLCOBNTx5d6OOOwuPkmorIP3/b
         96Qzy3vajSv4gslgXrhAF4AkFsHoAbiBEdJ9gzdlbTnWbnESZ2nCfCamDMMhJ5NKXjAg
         kBOVJqeyAveMPcZTt0zPSSmQCjhu5cOyVf03sAen7sPfURrUtzOG0k6fEuVKh7WBiTL5
         LVVA==
X-Gm-Message-State: AOJu0Yzt7qSYCkRumWny/7YMvwDxbsiqqtXUs8WxSQbobLB+ar7tBc/9
	hXVaKKTvGMmU2spKPT4Lm6quJ0W0zHc0aUYzvEsv5Zf5Kr01UmpDb21pst/Ft4E=
X-Google-Smtp-Source: AGHT+IFKIaWHWbci8QZZ2n7KZHpTQJTq8X3FH+0s4WBET5a0XwLzcQi1C+W6ZdH57q8gpmX6bD+Krg==
X-Received: by 2002:a05:600c:4fc5:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-429c3a5e344mr15355045e9.35.1723212964533;
        Fri, 09 Aug 2024 07:16:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8289:d6d0:e805:3543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e049sm130484035e9.23.2024.08.09.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:16:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 09 Aug 2024 16:15:56 +0200
Subject: [PATCH 3/3] memory: ti-aemif: don't needlessly iterate over child
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-ti-aemif-v1-3-27b1e5001390@linaro.org>
References: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
In-Reply-To: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=h+HcmdehTG8k81RElf2GAXaNvmMSoYgOir/34Z+arm8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmtiSgdkIpM4AoEgSTv8HPmcLl+BNouFixeSXAX
 2ah96dBZbqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrYkoAAKCRARpy6gFHHX
 cqlND/4liOOlmWJvu4c9vkoCDLr1Bdq2rDoYgv0evZd/ewiz29r1VQxGS77NBbmccQk6oLXSxjE
 q4VBQU3BKbvC6oR6NaTlljHr884SiMq8UVUXpo5+wL1Z0MVKY/nvCQ3MCvuJEENHG5xV6Ab1Sqc
 9F+RFi8KiVZsdAVCCV4hnjOWlhS8YAwfJXevn4E86GZdT9zTuUL+6y6NUNSM+V+6Yp3fM2IeY7j
 B3Nqy2cAmSbHtvHK27DagcHJWEWLANpvyWbp3TnMvkes7opptbs28s36WwmkHxvp7NDuDDmA256
 jq+DLPkvEQkxrB/HiTUPG3mB9YyEPvmECAMNPKcALjwBbAfIlG/Aq7F/8H1PeKfgRSMN/IaZBNt
 Q2D0SB3pThurmVBftLyXVnaTgE7Tvd26m3xxJ24ztyow365i3UJ7JwvQrI3i0RYxFWrg0afU1uB
 JCdsJnmSwMvn0Mf33rx3+VX+7e+uqmXU3U+ZSUIlYA1UKKn3Nahyp2LbOL3LErC3bU2KF2xmHZK
 gjKc2q02UXHB0dyL+dIpdsckpsL5r4TAp5mRdM8IeQToGW7jot/a8KT5TiLbKfYtAq3vnoZR3uD
 fz7xgPdY2dmCGe9D8BZ56YiNzHW1jWhVPCUsUtM0Jj5o1Ug8suev10RA6T7TYLG1zbMS9lwq7u3
 s/PMowrQTmCrpkw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When populating devices from a specific node, we don't need to call
of_platform_populate() for every child node manually - the routine
will already do it. We can call it directly from the platform device's
OF node. While at it: use the managed variant of of_platform_populate().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/memory/ti-aemif.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index fbe0786f5ac4..49e7cbe98fdb 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -383,13 +383,9 @@ static int aemif_probe(struct platform_device *pdev)
 	 * child will be probed after the AEMIF timing parameters are set.
 	 */
 	if (np) {
-		for_each_available_child_of_node(np, child_np) {
-			ret = of_platform_populate(child_np, NULL, NULL, dev);
-			if (ret < 0) {
-				of_node_put(child_np);
-				return ret;
-			}
-		}
+		ret = devm_of_platform_populate(dev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;

-- 
2.43.0


