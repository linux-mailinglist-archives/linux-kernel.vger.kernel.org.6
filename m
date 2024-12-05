Return-Path: <linux-kernel+bounces-433074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51A9E53A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6021882CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0802206F3B;
	Thu,  5 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z7Xqp8Bt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973F2040BB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397597; cv=none; b=rNp6iBrP27BCH9kXIqnWl9i5wIbdw1mJ/nuRZweIzzfO9TvfoNo1nR//xKCOCe6mQJ4txISKx7BN3JHpJdaWMPV+RuUeC2oOILdbP0KhO32bl3ud77inBRd7kmUNKwZBfJhEt5MP6ugkgCGFptiqeotvOkE9CjrjpW13zQ5mWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397597; c=relaxed/simple;
	bh=4JJzIfTPYd1xwS7ML8LLTZkwdWqlo3aofGz7RuYx0M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7sINV9Hk+zqeImrdNmahCMfl2+v8Bm+bPK8Q4gSoXleWlztyvBHy7I8XStAqVPJcta6HHNNtTB8hxTtDrngQ2Tx0n2ZSVB446EFPYWBBnboD1i6reqQP5iko3UvC9ScL6YJq7SWY6aDqB82k1oDEQtKJSBJZNnWGHaclogWs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Z7Xqp8Bt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5500f7a75so110905966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397592; x=1734002392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOYk7rkhvjRCnvuEcjwAqfr4aBzSa8a4sxHUvLuLnTs=;
        b=Z7Xqp8Bt3QCBMN83myr49psF1QSSZiSW58Ok5ZEu6sx7+jKp1QgbrGpeSf+YS0db8c
         bjew2GmkBBr1jCUxm9zbhO/Of290nrUXby3pFPxfEmMRZMbrFhoVi5Jsf2KTVRLO9Y3d
         SqSd5DV0sDs5ju0rqYmAaJ4Wxz02QGTQfpKJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397592; x=1734002392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOYk7rkhvjRCnvuEcjwAqfr4aBzSa8a4sxHUvLuLnTs=;
        b=SDCTNtYHoXo8aWQA3dETXijqAgGVjbmzl2d5MpoBvE1hXu8+slDLyMNk9iVDngKItD
         30LMXKdLVunfugJjmsJ0UlGIoBDR1dxMWsZNNLlo/jyN3pJtJSaqaZaVppfUDWhkUThD
         XWQVwfescHmNTbCvSXzvBGMM08w7nr5jyJYiyozI7tIqegO/RNb0xyfdWJc4dmnQUXsG
         X9cfsEusdqIEwHea34IoQPhqL9aeTEciqt7FHB7XnpZB/IIeTMlDoHy6t8BsSf8207yr
         xHTFhCKtJ1mUKTM6UpENqBQ99D8EGtoIgPyLhl/y81hk1MIVznUXJ/t1DbnL+/ZIATo/
         +HGA==
X-Gm-Message-State: AOJu0YwfJtt1CGYdmNJuXSeVv7PSWeRaX2v/wB2UkvtPlMzCmLagI4+G
	t5XTMUL+vSPNifEWMXYYd+xPoL2lYr8vFJkAGI22leh55mW4RhKtm8MIhd4hq1oMwpMUFg/aNvx
	E
X-Gm-Gg: ASbGncu+2cNsABUJbtJdwYmq32mDH75Tz7W+yw/dI3nXo1yVqRYQu9TuCdEyYkCeJtD
	zcGwOYepW2Qh4b31bc2e5Zsb8dKUS0QNKVayTk3CDczn16kY1J/G3HdY3Uq+5zyYMiI0Nt5oI9f
	DsSXcAlxjb/tHgXJoAVWzmZnl/A2Y8DFoh3UPeDrL8shFuH+FPukfEDFrrbVDXkG3YJdlCdwdGh
	L4GSUnZaYF0qXKx9C+0V5/X/qGfli25zwqocErNp79BrVcHimdiSZeBjtUQ58L8SAVNmzfYocAi
	E4hs140OZQVgxcueyfiC05sAW3mDIpeAePnjAfPt//dJYQ==
X-Google-Smtp-Source: AGHT+IEKdcdUCceUHogmpJQSkfQi7gvSkiGqFxS5Oof8+cN49W1U5s4xMeC1Lw+OiTYCvRjxODLcuQ==
X-Received: by 2002:a17:907:7758:b0:aa5:3f53:ad53 with SMTP id a640c23a62f3a-aa5f7d8d1dfmr756999466b.26.1733397592064;
        Thu, 05 Dec 2024 03:19:52 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:51 -0800 (PST)
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
Subject: [PATCH v5 06/20] arm64: dts: imx8mm: add anatop clocks
Date: Thu,  5 Dec 2024 12:17:41 +0100
Message-ID: <20241205111939.1796244-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Add the bindings definitions for the anatop node. The patch is
preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4de3bf22902b..597041a05073 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -600,6 +600,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


