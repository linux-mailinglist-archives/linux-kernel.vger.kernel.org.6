Return-Path: <linux-kernel+bounces-534451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0FA46723
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6B6425B25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5967522258E;
	Wed, 26 Feb 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCCwRZB0"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC152248B4;
	Wed, 26 Feb 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588407; cv=none; b=ssztbwVvE9guwTbpAYYwnidgDUJeUdSlakkKPP5J5eZZjdgYdC+ZH+EsJ/P84BGr4MimrGi/rNhsl+6GRdWpIPK20Z9UFwwBkjTwcGks8hrUtQh623eWT9TnJVQb98tYUME/Z3zFeKgdPcbwZhLym1kqUm7kzXhJrCAMigWHTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588407; c=relaxed/simple;
	bh=712s+CZwtbCsu6iB8mRETbiuzFlVQdvECgHqf0Zlhsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgod0pwpUl9q6vtOmowGajYiO8zgxe4S6Yg9QsVwZ2PqdFvzKwCq1tlf2F68ixBwAMv/vT4kwG0ChiOScxCmfZoLmkBWmJE58JpMTa5LYj0jlBCh+Qrj69NJv/zKVNptnMkX3K62OkEbSA+3vz9TvDjiux/8WhDFikiucMshdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCCwRZB0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so222455e9.3;
        Wed, 26 Feb 2025 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588403; x=1741193203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia5D1StmV4CnXYyEpke0sKKPWzBMRVegEo2c54oP3lM=;
        b=mCCwRZB0L17WPOq4j/La3UAmcB/5wTuvF/9xePaSnajR5cu8FWIe9czonLMYsa+haW
         nZZuX6md7msrcpYMre1F+oIyK/HDqpj7P+MkW71/fo2/Ef+hZadmUS0/Z1RD1jkrWDX9
         LicFpS+rC6bX+JSIw/xrYiZ8BJ260B5D8ZDGgxNgukXCIhWDgXK/RKPU2LhjVF5xeJXF
         vJQk5plyQIgNhmH0+UEDWYXOacYBqLYpkZMHBQ2Rc+CTq/Moz18gMfXOzZnWBTCUHCJd
         2RmcI6LsNu0KAXNKztKyNI0yBwgjKW6OltJ5FLeuG+V+0IIZSKNA6BXM42JKEwFP4U4u
         vMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588403; x=1741193203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia5D1StmV4CnXYyEpke0sKKPWzBMRVegEo2c54oP3lM=;
        b=iFyd7QZKodppLQlYoWaQIN9dz5O0MtBTuMCicWCgE1/DnSowV3kybQzAdsgxcl+uBh
         3HOwsFYLNWiAICG8osFj/iGSVAlbiDOodRh9zdPmiDMXrbt7D692m13fje8IFETYlT3k
         THX2JUF7FssFhlrg7uIt4n8i2TXSELF9mhDL3H9gwJbm20JLyz52nZdX7whKUvdGNYaC
         jNxYHyPkyyNijbhYYvllpLfQdLR0pV0keac6FV2px9lzCW6pueJQ++a2qS6P6zKVOfMd
         +G3zSw+8g4mVwf7lXBr92f3xAIUaaBHAJvkAFSi9O3QkV/gzQkZtL0Hs3NQuiyB72Cth
         X7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUawPh8oCTFnAyDl+3Z85bFnkCHmUoNBy4Zyo8dEr+2CCaCxnCbVOgBNus6Zn8/q6l51Iq9WK/s9pxP@vger.kernel.org, AJvYcCW3NcLQ2BbBNGF9SB2nErucOnqFN13O0oOYxp5KI5IEUH1DpHtepdJxV0ybGPIvTmVOeyQLWbelBfDabNVF@vger.kernel.org, AJvYcCX3CUaspXOu2lD5qN2KALqyNAsetugQc0pUsvGtiTcqHen52PffvoDMg44GoP3/TCfN6iuUBw3PbxHB@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJ1vShv9QSQLeaPBuUk+aFkCLzVnlxyQPTH9sibeAg9+3shm1
	Poh5D6hGiSzfnUb+bDQkrZvm/83UMSA/70CPnv8f8XlL1iOdlrD5
X-Gm-Gg: ASbGncucvMzuaKS7dt22x3EMqZ17LaHXD6MOvToYGbbohxjgX/8VqnY7wOT2QfKTO4n
	0kB2tX038nSS+AM73kfyTkERzV/IGOmD0o/JBraTXKEqNMsxV6a6G3BiurTZXVkbuWXvAWqB740
	gLiSwEf6zWs4tKFxcCyaYxmcp8qf3en9qAd+7bHmGBKO2GpZpohYFDxfkNOuwrxKoAdrVQgm3Zt
	WYCgu2rX1JWlP3G4K7BkW71RtcXGH2K5fbgwj6Wbx1iFdND+1m6/2ysuUHp+MEXh2jdh4ENbCbx
	4eh7esUedZk1cy0AB7/gIy14SHTOwSXcFtm4/gY6RejA3mLdQmpggpvQ4kFLvXae
X-Google-Smtp-Source: AGHT+IGWZHwSsvPWIGZD7v0lzUemtXIqVysf29/KMNwus1o2RKo13ASNNOWiAsEb7Vjp9//75b552g==
X-Received: by 2002:a05:6000:1789:b0:38f:28dc:ec23 with SMTP id ffacd0b85a97d-38f7079aa1bmr17417528f8f.19.1740588403302;
        Wed, 26 Feb 2025 08:46:43 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm6200215f8f.73.2025.02.26.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:46:43 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
Date: Wed, 26 Feb 2025 11:45:12 -0500
Message-Id: <20250226164513.33822-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Needed because the DSP and OCRAM_A components from AUDIOMIX are clocked
by AUDIO_AXI_CLK_ROOT instead of AUDIO_AHB_CLK_ROOT.

Fixes: b86c3afabb4f ("arm64: dts: imx8mp: Add SAI, SDMA, AudioMIX")
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..86c3055789ba 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1619,10 +1619,11 @@ audio_blk_ctrl: clock-controller@30e20000 {
 					 <&clk IMX8MP_CLK_SAI3>,
 					 <&clk IMX8MP_CLK_SAI5>,
 					 <&clk IMX8MP_CLK_SAI6>,
-					 <&clk IMX8MP_CLK_SAI7>;
+					 <&clk IMX8MP_CLK_SAI7>,
+					 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
 				clock-names = "ahb",
 					      "sai1", "sai2", "sai3",
-					      "sai5", "sai6", "sai7";
+					      "sai5", "sai6", "sai7", "axi";
 				power-domains = <&pgc_audio>;
 				assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>,
 						  <&clk IMX8MP_AUDIO_PLL2>;
-- 
2.34.1


