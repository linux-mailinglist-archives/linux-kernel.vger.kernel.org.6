Return-Path: <linux-kernel+bounces-298689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E21495CA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE14CB278BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AA187349;
	Fri, 23 Aug 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/a0jPm1"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DD13AA3F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408171; cv=none; b=j+pBn/obCZ7pUcN7Fv/VYVgoGXqkh3ssena6HfXzNu1zfpYv01XrtQEpyraHRX6muo9GgPQFBL+22kCDiZIaZHfih5wk3yhT94qYFiC9rxZhOTqWG1N20im4u1mEDAn5iPQU1Z3pVdb2krqP7Y1BfKWy+n+Rsaz1xGV3jtRjUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408171; c=relaxed/simple;
	bh=LtVfsUrkXvrpIrQ9RY7ofd8SPZNPe5l+WNIEpOclJW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5pt92v/jeJUU77141y1F/56H/eO33PiqAIKLv3yzijwee1fOIgraSMb7W/2Fv4WiWubqVoj0M8W/Q76F3/Bt8V9ac3OJqE4H4e9C0AqKx8Rg4oje4mBRjH+olNThFrprHlqMhjpvzqBBH29hoqMXE/9KAnYH02ws9D0FJU3Tyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/a0jPm1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bec23c0ba8so294933a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724408168; x=1725012968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL8lrH4m1zu8jQzjHDxCkVbmtMdz/cav5HroEZBlyVs=;
        b=K/a0jPm1lAb2W92lShBuUHweqnu55ZjNYvEK7poxfGEugLMAGScMWNMO5/AvYVOFVS
         ZDbBiVL9ltenX++J+zE8KjWmwLCfOrUy/uYSV79FsryUJMtFY2jq5pJbmZjtdag68ZHs
         8otUyoWxMnJoG2lGMhlhg4CVjwYwEv4Ih+7hbAmfoQG0QKN20Jz/Y19JiZA1YeB1xGgc
         gafWQXC1zeVIiofXrF6HLPeXRqcq6sJFoLETrkIjRXzHk2tmGSEd5lVbHx6uDMZRVHr8
         rAie5TTK6v4h48OsxZV1dqKdvsqLwntCYmzdGvMu9sVvyteBZhp8v0MG0n6on1/vzqd6
         W5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724408168; x=1725012968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL8lrH4m1zu8jQzjHDxCkVbmtMdz/cav5HroEZBlyVs=;
        b=dZF6NzgZGDjUUEk/cqeW2P1WTlFkC4xoPPrAMegxQ5FaGwtZdEAky2vGr4nCgBwZ1i
         yIo5WJ/tWCl83MAj0E5uRPcyvINedh6FPqx4zQmVnhbFMPwNhPMqAmsT13QuHmYaz96M
         64fQWEoPs+g6bfghbDdKI41zGHQNGi4I12ob4dWhIEbeIpOkv9oVj49DifWT0Y1/ihWs
         70TLZMlN8bQxZgGJ/XEoHrT5QZXLKD0RQvtSWgwEdUxb7pNLwS66kcX/keo5zYYXhniZ
         2SaI24Rh9zyo1mj+8v0qJ5Radg9dYh5fyfEXWyV46088azlXFfEhLIbA7wMGc9iZ13Pm
         zzFw==
X-Gm-Message-State: AOJu0Ywxxu/pnvdvzrmDBTcSediggfbbQ2nKpw8/pSbvERgtLoYPUt+F
	gg1L4Nri0/j7nmzEH/nprG6764QcOj0WoXZbVoLiY0KNVsC5kKemUfqFRPrZYa8=
X-Google-Smtp-Source: AGHT+IGpZrdXtuPVCcQwhIvIg5Gw3qd8+DVV59c115ma/5r72tOpjy+Z8GPBzffzBb1Nt11PqlAWTg==
X-Received: by 2002:a17:907:7e95:b0:a80:a294:f8a with SMTP id a640c23a62f3a-a86a516134dmr78367066b.1.1724408167575;
        Fri, 23 Aug 2024 03:16:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a1df5sm237912166b.68.2024.08.23.03.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:16:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 12:15:56 +0200
Subject: [PATCH 1/7] memory: emif: drop unused 'irq_state' member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-b4-cleanup-h-guard-v1-1-01668915bd55@linaro.org>
References: <20240823-b4-cleanup-h-guard-v1-0-01668915bd55@linaro.org>
In-Reply-To: <20240823-b4-cleanup-h-guard-v1-0-01668915bd55@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=608;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LtVfsUrkXvrpIrQ9RY7ofd8SPZNPe5l+WNIEpOclJW8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyGFeW1M44IyaAdN7DLEIjIFH+IOVjqjv+CZGH
 CteVueXlu+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZshhXgAKCRDBN2bmhouD
 1yNmD/0baNim+hSwFmuf5i67uJCDBqNTmfRLqjw3IiXAtxprRD9OIHTOUNWewIxpDKOW2T0fUkF
 BI70RMp8aE61rnmDenkEnr0rs++uDEmfbAc57plGITtw8W1vkscwjMpkPNbRyJCZDIdZZTCuQLJ
 gTDsSuI0psahI86kXZov1XJf+BCjnY5bFLoiGqzgnx/+hnM66gEBroFbZ6TCCQ0LS+73Y8t9S7X
 52NeItgsVFGuFGKozMb4xBPk79pFerDotzNhQrtHKePgxKPJLsRLEZt+VOt21egL4sTxL2jv6Nv
 aN6qoIQI2V1uXC+IPVjn3BlXEkCi5G1/fDzq6/hiKEC6Jb7youNNcMhA/8gNCD+O6zVCOabX+Ab
 QBz6cb6Fb1CysHtTGZ7RNISe+uu9B4OmxQde1sW1gjB5Fq+QtuWEPJfMsH0ZcmpQIGvyPBO7NL2
 kgUo+qPxlfM9rRtqHeNxV6tT00CNQjx/Ju73fVontHAEufbDCYycooO5HLpyCFhG3Cnx3cJdz4M
 OJpxz3kUxIMmGEFw4nzyYq0imW7Vi05VIdscaw9diXPkyjzjY+C/xKbQ3q+c4wb4uUrWv0/k38v
 pXxFFjwg6xdKx1PbWm4Sd15uz198MDoxjFvtsYZ9WUXOOQ71/GFcW7+CjqI+aNeKIoo6DOQ5kTy
 RbwH5RnPsLmRMHg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not use 'emif_data.irq_state'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/emif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 974ed641473e..b32f3a8f9d71 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -57,7 +57,6 @@ struct emif_data {
 	u8				temperature_level;
 	u8				lpmode;
 	struct list_head		node;
-	unsigned long			irq_state;
 	void __iomem			*base;
 	struct device			*dev;
 	struct emif_regs		*regs_cache[EMIF_MAX_NUM_FREQUENCIES];

-- 
2.43.0


