Return-Path: <linux-kernel+bounces-374706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611149A6ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D591F217EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F71CBE99;
	Mon, 21 Oct 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSxHyEaL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCC1CDFA3;
	Mon, 21 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525991; cv=none; b=nrt3ckGDilxL8yuiqtryjNo5FKeLd3fRz6Zgo8EOqby1jG3CE1Eqips3cJ9RyTneX1azl3rlcKns8y988ZdOUIpnGev3M1buT1XsPJiSQYjiawAQKDF/sRH218nAYAiAtlqsglfZqQCPaK0xm//1mmyrMghETqonnsLxwF6hp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525991; c=relaxed/simple;
	bh=8R+zVYCQ0RWA8+jdszP1DwcyZb/7p5o1Bnpx7gy7wsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRr5WYv57FcBJMZ0Nj/ZBT7vUNk+jS9pEMvg1YOZszHggTqfwsgfhlIvZcRV6fn7Lo+agLyXS9VIl7kjtp0FNBZxwk4COZ38QbCuVGbAdKsil/GvFVZZv+AEQ5yrH256hW7rB1CaST00FeiPRSVCVKGne1lygtAjbJyW3BsetD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSxHyEaL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso6099024a12.1;
        Mon, 21 Oct 2024 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525987; x=1730130787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTflBq6Wu+WzGzt/MtvhqqnQ6l51cdQmFA1c3BjJmYU=;
        b=XSxHyEaLrsJ4M+5Nx9t/g04upSfWl8vENTKqOL9FR3NNU0oIp6iJS8RfPDYGHJxK4/
         HzDnZCAkEJ2PbblltZYmz/WPWX9XmVvYDSkDlH0xE7vk4NV417oWvjQ6c1V0Pnq828BN
         wlJaQq3Z2vYkB/q1HtmzxCG5WEeISYj2Y3DrlrrEm509DDODyySgGWEB5A3p89UxkS59
         bHICGmPWhqsFs4IQv6G4IgYy+za1NfaYhH3lHeQW9Wds2xfavD1wMvCGSR8KKYaCpmMK
         is+h4IeMoQ3EYocRpIFOxu6hj22bCrMzGw/c49q4VTn/g2/KZ8jF2VwGKbWaB2RMWF+R
         XcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525987; x=1730130787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTflBq6Wu+WzGzt/MtvhqqnQ6l51cdQmFA1c3BjJmYU=;
        b=msEn/FgFxYsZnK8e++Pqdh4Mrj+J5BR9eZPR7l57kOEbav+BogyF2+CHlDhTEoyqkS
         C+a11iE9HQ2atkSidrtMb07WJedgHkwV8T1QhYytpZ4pZe3hQpTmzFdjOIJLm2Wj8wHl
         on4Eta6pBJZWYJ1+HP/b+aBgXPacTSpxwoSgbNHWDkKXC2GyDEEQcZsuNWY3maS9HtZj
         byZ2NiQ2HiGDAvzWphNIv56optSWre97//qBWP7sFN2zzkp6+nT34Ld8p48hlmvtoYTX
         Q/ceHw164OQtTBTRfYlNYMf0HlDpyutHplCAZf90GraR9guFzRCzm4m12aBfKwRN9ErS
         6nLA==
X-Forwarded-Encrypted: i=1; AJvYcCU6AGhQ/T5YCu9uKu+plQypWF/Gd2kaa0whKNXMkBbzrbBPib/XKIhlCYnW9NHTYzqAD8o7Ynf2VPgWb9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wrFuE+BZuZ5G2s3wDNG/qJb+MZMjlOKjN5eoPa/eeCa8ryEL
	TqmHFU2Zo0YJTaG6lXXtrrg8S5fCdjnV1yR3vEyMLOohwWUTVTZ+
X-Google-Smtp-Source: AGHT+IEChIjZGjoCGqr943QI0nBxeCsGg66mphofROWuAzvsijseO6Jj5mGOXrTZJY/QOqHKNBN/6A==
X-Received: by 2002:a17:907:9725:b0:a9a:3dc0:8911 with SMTP id a640c23a62f3a-a9aa890a26fmr53497966b.16.1729525987013;
        Mon, 21 Oct 2024 08:53:07 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:53:06 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/6] arm64: dts: imx8qm: drop dsp node from audio_subsys bus
Date: Mon, 21 Oct 2024 11:52:19 -0400
Message-Id: <20241021155221.112073-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
References: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

On i.MX8QM, the DSP is in the VPU subsystem, which means that using the
'dsp' node from 'imx8-ss-audio.dtsi' is wrong as it's placed under the
wrong bus. As such, drop it.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 3ee6e2869e3c..f8b577ebdbef 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -603,3 +603,5 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
+
+/delete-node/ &dsp;
-- 
2.34.1


