Return-Path: <linux-kernel+bounces-211641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D309054CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671151C20F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7017DE14;
	Wed, 12 Jun 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fe5lvo2j"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FE17D8B1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201447; cv=none; b=eoW3Kv03RcTmIlT2Qex2zBeXvUeL5FJhjSass271ZYQlkfZY5/3ibgXFw7tPfYmZLFEvrgKGrpLeiUZI4266EBwmVoM//P3elzTUA5iN5vi+wlm0eZ5kWJtkMna1OjKLEj4KgRd6s634HOrefGOkkItIWi8VSgOiFYgXtw7/YtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201447; c=relaxed/simple;
	bh=a0/DHXF2SUZ9T62+RNnFm7pTHl4jfZzPu4UlkE1hp4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVQZAP/rZ2zs+ug4zosGGmL/8JWwDpXym10piGjPS3ONc27sgEBZ1FOPi/G5yohFJLN15IQyQA/sITiMEcLwq1NjpQLbGBIt0krLU0qmd3iyctHUBruVGT+nYPrVJ13Z7cq7OtbntOSs5oxH8xrthB1OqjGhESKEDAYR5s1lLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fe5lvo2j; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so23231221fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718201443; x=1718806243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDZBDbUR/Osz8PKcQ2HcjsVNrayHLES+DrpHvD2F5Pk=;
        b=Fe5lvo2jFCMPLmfuLZ4l0vLQpjx3qF+RW7XPQcOd8xAGaRx1CmdX8ktLxgRsHoPxDN
         zHz8V1NXknemc7w7DSIiCSOPzifVeWcZ83xImDBZynFDUa5Y4OaRVbq5z8ubsRUHZZCs
         MR2fx4WfIbZ1jOcxTv7O4vc+44rsIWlE46a4b9NUGKGEtdK2DvEZJ70nyWLjj9o0fTAV
         fG76egoThXupZnsZrStmY5yJ6NFZMdEkOwEkrvLbqNs9l3yyQaDT+lR+0Hu2/5NR1QEd
         Bm0ZTCo9rJ3pf/PvGmBhxTvTU2RaCrMy4EchzEMGuDWj+/Ci6Rr+r7VJCtnaD/LBbZvo
         lOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201443; x=1718806243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDZBDbUR/Osz8PKcQ2HcjsVNrayHLES+DrpHvD2F5Pk=;
        b=nboonLuedDl1bZPDaPEahHapVE6wENkKBW/wHU0FiC+/u+2GyuL5fsYFy9ldP3XPNG
         sTuiwLys2WmJjG71hbrDSWlby3PQ7BBnuYp02cKdMj8K3gTI9y1fYHaRF2QNHQ6w6xab
         egfVXECKy8SAcL2LOjjuHQ1g7ZiTQtatBg4to5TuFAMehslQcatsVekBn6ep3ovOdG2U
         +eetCiToDic1VQQbThsMTeBJobi3i4gfRLMOfkKJ/sy72qA3pUANfIIonnMb1DSLJO1E
         Z0ds5r8FC0Sr9xExf2VquCwND+7EZ81nKQzopd5//9jlmXSRQKbx2bIhpAucgAr4uPL0
         Hcrw==
X-Forwarded-Encrypted: i=1; AJvYcCUchq5jer9aN0pt2pr5cZN/Ek+aIJ7bWIsXVjEKdpxHYKnkJrZkBDxzJLveDRSoDKGf2q1HFNFa0LdKnzMAKw83jLLxF0JGsbjd1tiu
X-Gm-Message-State: AOJu0Yx8sUzM9/odVhCxuP+uH9792C0fk1kNuBzp23XAoEnRTXEtCLpS
	YOAs91vkCMJYHY03O9eTqGEGT0LV4BXtMuvZQTvX3036fxhr753v81aCxTF/kcw=
X-Google-Smtp-Source: AGHT+IFjLR7yr1vu07suK4U8uhG1T2SNjOgZASn+EN8VRdq7sFOEyjV5ivQ5D5ogr5TWg7tHypOgaw==
X-Received: by 2002:a2e:9b88:0:b0:2eb:120c:1a59 with SMTP id 38308e7fff4ca-2ebfc9d0865mr11492691fa.16.1718201443353;
        Wed, 12 Jun 2024 07:10:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe7670sm29304585e9.6.2024.06.12.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:10:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH] MAINTAINERS: ARM: alphascale: add Krzysztof Kozlowski as maintainer
Date: Wed, 12 Jun 2024 16:10:18 +0200
Message-ID: <20240612141018.7348-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently there was never a maintainers entry for the ARM Alphascale
ASM9260 SoC, thus patches end up nowhere.  Add such entry, because even
if platform is orphaned and on its way out of the kernel, it is nice to
take patches if someone sends something.

I do not plan to actively support/maintain ARM Alphascale but I can take
odd fixes now and then.

Cc: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7a13170b697..647233a62f50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1946,6 +1946,16 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun[25]0i
 
+ARM/ALPHASCALE ARCHITECTURE
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Odd Fixes
+F:	arch/arm/boot/dts/alphascale/
+F:	drivers/clk/clk-asm9260.c
+F:	drivers/clocksource/asm9260_timer.c
+F:	drivers/rtc/rtc-asm9260.c
+F:	drivers/watchdog/asm9260_wdt.c
+
 ARM/AMD PENSANDO ARM64 ARCHITECTURE
 M:	Brad Larson <blarson@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


