Return-Path: <linux-kernel+bounces-260199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9B93A46D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0923B22115
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637614C5A1;
	Tue, 23 Jul 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/y2ICbV"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D0155C90
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752394; cv=none; b=uGgYdh6E1X46z3UaDgC3EJrRZv6J5Ia2kEU0AlYhZqDLM8nFlj8Vn4+rbZbfu+p0Mhis7l+rFkh5RH6v5FLrmqGCt5X68Eplr6eEtflc3QgXg8y/JyozSCW1mRoZd0RI7fHOcJ49UHZhnRXCwgnaV8VAWOrnzZzdImLIAXt4Pqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752394; c=relaxed/simple;
	bh=Rlsm3g465sL7REjC1ICV1eiOlwWaRmEDM1DT0XXv+YA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNxJ1178ZR6SAQBQLHAXIRm5/NXte4Z44s0h2BjNdzFG6I1aHBkVWmDQBWtklQDEmpOKA02OzUA5MKXET0/9heLlVT78GccHqKIKi9fU63qKfEk2HJBY07FmNXyiznjUleW7lcq4IDjsTRqOMyPdHIuTgrg0KCxmoC5JB5vTWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/y2ICbV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7044c085338so3245276a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721752392; x=1722357192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgQLREszlba2w2e3rfY3g/vnEu09NDSRrgY7DbqY56U=;
        b=x/y2ICbVqcUiU02XjFn/lUWlurBQ2umA/4pmmpitBbu6O1A+qVpdlbN4ziwSjR5QBZ
         PLJkhXvYcPFqoqtqYFlT8+Rf/IikHevM1xRQjtNL3EvC2ia0G/WZQ9i3PNtS1Sr54KoC
         QkTIkBjZEFG15PXcg4EOLw3m4wNeUG3lME/ZvXSNSSfqW4fNNaaeBH92nMTlf4eHz5t0
         kb/3dHoLwijLz3W3KubM7LDbxKYF14O8/m0V74ngylrnDrwXSJnku46uHz1sx45CnRfh
         HfKFFz16xjKgm6YxoE1mhGhX4/T3jpCP+jAHmkaej3WAFZQhTztSvjU0O00VbgwXBa0l
         RQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752392; x=1722357192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgQLREszlba2w2e3rfY3g/vnEu09NDSRrgY7DbqY56U=;
        b=JPJSX99YMAdRSVW1WmADShbmDLtBEoWO/BHYiKh811SucXuyJ/DZZSG59yD5sI0oSJ
         pGrd/uVAUvWAOUv6ZwaRiwEWnpi4yZE5D/4ltdpJmT1a74zqPW+Xr2K3vbTe/jfsL0TV
         BPW91RZztOxYjP3dQWuCMuFi8fGhx62WjpsbdnCRfGeMMEGme/D8yckLDU1gwDFFZR0V
         k6cNG6phhuxZUXPtiGUh274RWWeli7GeglW/PRt0yh7C6aAKY6PlQysdjbLosrhl7/4j
         c03rTOUt4SAr7Mv0IXKWrT28Ae6WUbQianAVtoHmu4zId50wxaZkyb7Vh+Y9EhnaumnJ
         VRCg==
X-Forwarded-Encrypted: i=1; AJvYcCVogwo5czvFy6FNxisY0CRLzJ3QaQqYAyCRSfyArnfdWvj9H4kigZmti03EcUFI1GK5Ew7timZzeqeHpPRGAM8UIWlt1roRjXDTIJ6n
X-Gm-Message-State: AOJu0Yx/tsIc+tsr3nTDIgTcFLzXUjqZBXdNarqQ9P0CBiQIsZh6uQnG
	NOX3FEmqE/iYzWA2LzFI+JRgPmvBEieaFnyxcpflrOCpioz4IhcFqQkUx1v8PgA=
X-Google-Smtp-Source: AGHT+IGBpe6peQ8ESbWSihyzWm1b4sHXIw/4hvjia5dWTqI2J3ZsUT5UEo2Jo5H2dBkib0oiHWbtaw==
X-Received: by 2002:a05:6830:6f0b:b0:703:795b:f675 with SMTP id 46e09a7af769-709234ca4b2mr449959a34.28.1721752391805;
        Tue, 23 Jul 2024 09:33:11 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f61913b8sm2059965a34.68.2024.07.23.09.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:33:11 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mateusz Majewski <m.majewski2@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: exynos850: Add TMU clock
Date: Tue, 23 Jul 2024 11:33:10 -0500
Message-Id: <20240723163311.28654-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a constant for TMU PCLK clock. It acts simultaneously as an
interface clock (to access TMU registers) and an operating clock which
makes TMU IP-core functional.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/dt-bindings/clock/exynos850.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index 7666241520f8..80dacda57229 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -358,6 +358,7 @@
 #define CLK_GOUT_UART_PCLK		32
 #define CLK_GOUT_WDT0_PCLK		33
 #define CLK_GOUT_WDT1_PCLK		34
+#define CLK_GOUT_BUSIF_TMU_PCLK		35
 
 /* CMU_CORE */
 #define CLK_MOUT_CORE_BUS_USER		1
-- 
2.39.2


