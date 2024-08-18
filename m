Return-Path: <linux-kernel+bounces-291164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8A955E36
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D092B1F213B5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3315ADBB;
	Sun, 18 Aug 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtPKZwPz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC1155CB3
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002225; cv=none; b=TmhyKHHpMBBwb7xCzetc249eTVaSiRf/Td8AE21ilH8HJvmlKz++iH9QYIe5pgUn6KlwhaiXP1nFhJqadjlBEOrpldut2tGSZ0usSh77DrBWpHtAcSFueaSmXNVtiZgc5NO8U4DRzUJ7hvXCJ6S81fpAlqcmb44vnrdEAzj5EgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002225; c=relaxed/simple;
	bh=RYClEsujtW4S94dyvDLYYanO3sNFLNhXP2WVnH+jFRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVsptp0GUccQ8Uzr1JiV0masytPHzySJJDb+pzXki4UZTU/gCR8n8vg4pdaq46rmrrsprh6J+mZxMcx/2poTd0T3bbZa8hZGSp6CdRdRz6+IoqJsoJ+Yjv58CabmomeVgRN8uJ0J2lHvuEBWbbkkf9Wsy/Cvja/CMEDIcHi0tws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtPKZwPz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42819654737so26951105e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002221; x=1724607021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiRlsM6vBlOVTpadv+7qxVZ/+NvHjXgHFTSiZbF3Lk0=;
        b=mtPKZwPzZeVt5FwqSoxw54qKVefPFMi1Zr9JAvTNIXyR3VaTbXQGzi7oAUPdhsnibu
         TGWZbpEafNdhYqmDmPVegXUJYez9KTbLlUaaXRaGlOqIUptYa67Vijtt8wWMZ+n5x/QV
         rcSV3db2gl/XAlP4D0JOaFgAoWvUdp6YC6E8ecBLDWjvPj4lhFnhUqsOCwDujqmmi7b+
         GOO03dha7sgF7VW4VMWl+r2uSPKVj7V1nWymYdr1XOXH5lkGxYh9A/qjfzSuAp2HGwE0
         qZTshDNPvjt8Dorn7WnvZCN8yt4D2EB2TwYDILephmEXGWKdPyf4Jwm2zqOtMDOtO2ku
         jQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002221; x=1724607021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiRlsM6vBlOVTpadv+7qxVZ/+NvHjXgHFTSiZbF3Lk0=;
        b=uR0oFMBRD2VWb2KzWJ4xzKAL83uMfQ3gB9xKvwRam1eYnO4ikqHrUUcWQufCZG0qHf
         W2jSO9Ib5isoCinWaPdLBZW4L+L/2S7UZ2NNlSKuZV1p/OfFKFHzk2HBjok/zCW92GBa
         kmx1zTVtw5O8f8yHHtkHAx9s2vg4yxranUtuu/gz/hnFOK9r4NRLePMw0u7Ie/7nl02A
         hiEssLWXFJLtSdogCHA05HV4am1LyagaWBpnjEyqnqDcdn36CxAzjs+N2xOvb/ulQxvc
         XP70c2mFk8qt4O4Yrwu263MM5eV+iU8e5e6W10x0btZx6EjIS5OvrMUV4BX01Nwwiw6v
         Bh0g==
X-Forwarded-Encrypted: i=1; AJvYcCUgzYNOusyKpR3ctkN6gtSUXMbfY0leY46119AEyWWquK7EB56yWQ2i+21YT2sdxuj6vWxnDEtrl+rtKDdQiUdz0daEC1HsxayL2WYw
X-Gm-Message-State: AOJu0YxyTawKbSNkFWKtuX82WnzK2HP96JyUp64t0YRuP+QQyh/ZgvwZ
	xXM+h3aoeSDbS8DwyhT3Rz/GxprEy97JPeGGtGYlBsR8V7eD8060fF0OP9VSE+E=
X-Google-Smtp-Source: AGHT+IHlDcGvSSlmSoCOZtAKT2zYd9WHqBA3yrLaM9pCakhIJQ/7iIvhr20DdpvwtiU7bWUoZXaPcA==
X-Received: by 2002:a05:600c:1910:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-429ed7b8ab6mr53592135e9.17.1724002220484;
        Sun, 18 Aug 2024 10:30:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm134999915e9.43.2024.08.18.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:30:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	patches@opensource.cirrus.com,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: clock: cirrus,lochnagar: add top-level constraints
Date: Sun, 18 Aug 2024 19:30:11 +0200
Message-ID: <20240818173014.122073-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818173014.122073-1-krzysztof.kozlowski@linaro.org>
References: <20240818173014.122073-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clocks.  Drop also redundant assigned-clocks properties, because
core dtschema allows them if clocks are provided.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/cirrus,lochnagar.yaml         | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
index 59de125647ec..ccff74eda9fb 100644
--- a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
@@ -67,9 +67,9 @@ properties:
     minItems: 1
     maxItems: 19
 
-  clocks: true
-  assigned-clocks: true
-  assigned-clock-parents: true
+  clocks:
+    minItems: 1
+    maxItems: 19
 
 additionalProperties: false
 
-- 
2.43.0


