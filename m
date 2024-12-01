Return-Path: <linux-kernel+bounces-426691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B69DF6B8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B26B21B33
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950521D9A6D;
	Sun,  1 Dec 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A42SVbds"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD31D933A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075250; cv=none; b=iJM58CYT5VLIcTi+zvR7U9wIg9FV6fzbTzSakWaJhJd2qA30Jy9F4/F5taU4Lp5pYzmscfT1flZpdJItywchGplET4BWXHTqhwUz9GYlsB2al1RIyuW0ICZ75Gbu2w8ju00jJEVUONSWrBGRApNlpTAsyTmYz+2mMt3soFgDoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075250; c=relaxed/simple;
	bh=pAZvwlhdsPQOXTECn8htnfBSk5QEXWk0LGMj+aO20ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8soqBc0839bmYKhYm6RgafRCiwc5WB3xLXauee8w/W4mqMGo2PHbZCBz+JamybRKkyw2E8RKpDw9oaxT+zSZMZnOk2mj9GgLSaiMHwTt0rxmTwhvbHu0Z7nW2WP8XaxUmLRmbbdRMOESfjRSvy08j18BYrHdhoQnXYbxUCaeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=A42SVbds; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so373380766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075247; x=1733680047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25hkQ29mTLGKqj1oFjf7AGoT1DWsKqPuwzAecsYSYFU=;
        b=A42SVbdsNGzk3gHTrp22u1MnL7so/pO639stk/E4fX9ySQvMbdX7RTjwCQNUuEt2aF
         P5xUPci9D2RRLiaPKl6tc6QjRKCb/Is9nRXSezQ02hKBar2mgWLMT3D752z5UvM186CT
         Ds/P9Xf/H2C0ehlvINPQsSRI9jsU9GPdjqlSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075247; x=1733680047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25hkQ29mTLGKqj1oFjf7AGoT1DWsKqPuwzAecsYSYFU=;
        b=oSCOU6UnnCVefYKajG8vTNHlRKwP2AwHRmWwqc6ANo3g3AYl32IdbvxRsVDQjS3vLl
         DruMA6Nl/fMVI8ARfvC90WuhuuE+K0uctLBBRORdU3O9qxGvZdEjNMEhE2CBJQ/l48PE
         4r9K1mMRpV+qEISlAmAhH5g5hKSRjOAwKBsh9jlfygwLcaf4WlDXxlEFFTNVIJxw6/qD
         bW0qb52IGH3Yg8Afu5bW5Gm/xe98rXQMU2iAnKkWdUGxhnswUjtlQXJBp0vO98e+1S2j
         4vWJFrjgKTOjX3j6Z/oytNxh0lql8YnhPS2h/Dt6VHA0dBW2hRvktSKNYDgVoVMdnEGA
         0yHQ==
X-Gm-Message-State: AOJu0YwziuyiJJJFQAymiFFm+AzDVz7B2oHLftoOUqIUKoFk55LPDNFe
	qUEEG7bSi4OKUNvJQ8YKhxjeW6tgnNBgAfYgOIDYDexB5ZN/fufQccMqn6scFMnGHbDQHmDVws6
	a
X-Gm-Gg: ASbGncsS8RgeNhZwG1mM4YPzcGt2feXzkhAHVKP/iLiz2UpW1ykFHekkTLumKFwZhEm
	yYzAVmI7xqq7Ne2LSqNlXMwTI0XGwRMXO104N+zUcvla//467TucX4VzSXwrMTeWd5Q2u5LMQcO
	R+wNRR6ZZmXu7a9yEh+U566gk1Hs5OGanAkmAbSIHxsdLfgLiFDHzb24g9ThSj2z5+N0WinxIn0
	C6O8Z+jRJEH+Tmso4tY/JNUwr441FYCWbBdeEQgJKfcNT1HjsZ3lYBD2Oh7qPmuA1nvw+gTWoHv
	YdskimHBJBudr1c3Th42ElbycVfiqMyzpLF7wdkyX3rF9rNNyInp3nXMHMwmbs7C/Eq6R/V7k2R
	nJxhG+5TU9aZQ1wMK
X-Google-Smtp-Source: AGHT+IETqWOabkVlO1PkfWKeKFWRO9lagZn7Lq5BjUv+Xpoj3trCPw9o4vBjnJJzR25eaHHFJ7m37Q==
X-Received: by 2002:a17:906:3152:b0:aa5:2232:c8e4 with SMTP id a640c23a62f3a-aa580ee8d1cmr1705022666b.11.1733075247468;
        Sun, 01 Dec 2024 09:47:27 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:26 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 05/18] arm64: dts: imx8mn: add anatop clocks
Date: Sun,  1 Dec 2024 18:46:05 +0100
Message-ID: <20241201174639.742000-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a5f9cfb46e5d..49be492b5687 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -606,6 +606,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


