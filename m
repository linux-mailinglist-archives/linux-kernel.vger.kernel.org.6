Return-Path: <linux-kernel+bounces-526493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB255A3FF65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A33B7AD5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E9253B7F;
	Fri, 21 Feb 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZN6Tze0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178B2528FB;
	Fri, 21 Feb 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165021; cv=none; b=KxsS+vuBiUzPefi3FjPT8vwhQeg4rPHNCOZOnAMtZtQKUAD/hwfb1Syf1hlmieRqUABu80Ub9DqTzPKqQr5bmH2FDWOUs4t8uC6Xya2Rus7sSnlhNEdJznQ/Vq5RhYePDlAwGO7YhviqN2crFFTwTBhGHPk6hVC5auMkG5sF/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165021; c=relaxed/simple;
	bh=aGMEv09mgvOMWn0LVWhHooUpN8dKT5EsPlQPTtFVSQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4Zn7YqxK5TdEA7NX28nHKS01KCN3TcXjvDJcjVRdpAAW6lDGWLO4NP+bqS4Mzp6EsnSCMNfAdE43Puf+yublKa6Km1pTlkHzGfO11arU0yrpmBmYTDzFfpvKUH1LoaKBmVpVzPUu8XZlfmUTdiJSSEVfy+dcgla/tGiBgh5do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZN6Tze0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so3565222a12.1;
        Fri, 21 Feb 2025 11:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165018; x=1740769818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3oJX0NNej/zcXG8s4cxQRhfNdLEwQ8bXLo+d66KAIA=;
        b=BZN6Tze01ufY8ojkhaayAdhwtDONWiUJql73W1YJNwyxxoiGeSVXYOGNtDRCFkb7zt
         s1q/m7S1qHVxfkCeSD+4AjnkpugepRDkKDLlr4Tv8DKVm0/EprzPRg/fzTfhVwvmqM1J
         5nBCEYy6bLczVeYPA+H4V4wfZAJRoGixV5bIXwvDeNTRoB8niopx7JhQXS0FqrjDgRmb
         ZsBG/qFoxgmLZE93ux92RYjXVLOS9x0yWneAYqmBfFNQBLKI/lxjNoTREFYm5ecYdCox
         0BEf21tsOQy3zQfu/jaQNS9HT8ZBnHf5FzwwTpHFGou2/02pCKboicGM/+dWwMU+ZMcr
         QEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165018; x=1740769818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3oJX0NNej/zcXG8s4cxQRhfNdLEwQ8bXLo+d66KAIA=;
        b=c7HUiAd6ZH28F+r91FhH1hJdDL3btpzWfU+39x2R0qDnYlQ9A5JPGhe0aLF1ZcnUl9
         E3uu24CWQc56CWqffm4nlxpOA3f8zjh3EyhbKg71Pdi3NPAoOm7id0YaXXcEuW3Dckc1
         Z/Ski9ZCKkA/gBPW7uAZLnFMl5A3GYQANROftFkmRi4bJuSmYV7i/Uo269bZcnVGCE9L
         xLR1LPjP7rPn6AWZ+ft7tWdodxAUlqv/Y4+GgECfzGAsHJD5Lstv1YVIvIqtwMWd6Sai
         FCzlGVku7FJGttZdTz6fB5jF3rznphP22NBWo+8XwqL25IQuWidsCDBMgEuFkpexYrtV
         Ntlg==
X-Forwarded-Encrypted: i=1; AJvYcCUFlF5N+pHyY2lukkdlnxa/kvJRwJtGPRLVrDboZo0zlGxsvZRoMLlH106S4KNmQv5dJbiuLuWE8k1E@vger.kernel.org, AJvYcCWN07QPIokWlckDnjfRxJUCe8QPL6XjhSb2qB7cPS+VjGBk0BVDhUKPIr6flC8Wmg2jFF14vrmuvhu696Y6@vger.kernel.org, AJvYcCXTtHm1RJ72WzfFnbViI68rko4rbnAoJH+Og8csy0vw3E3e7T8MboXKLXzvS9O+1WrWM00Zmg8s1312@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRslDir++As8ZLBy975hlgA5qy3DV0Prb2sGz2UNlP+HnTYAb
	BXRt7MH+tySso1zqYWEvWJELU9gl+XDIwPEPyX46Pq5atUpUa6GJ
X-Gm-Gg: ASbGncsXEEmoBCWavZ+jpRHejfH0mTxlDR3ZA4YYUfzNbXjxN3fGhXDvpR51b0zeFvu
	HZvV7ecHoc4pXkVKnF0v8T/KOISIQz9SWkohRYq7ftOeCiBhKszB4Y3JQrVk8p61SJDE412j76C
	pc0ixEK5h2MnrGtamTc9lx0VLsh1xsOsIDz2owkyJtsHwmu+v92z3QRvRlWh2JbxxlhozCLpOJM
	RpNWM80EfLvG6xMqhCok8CNNa1jPWKDbybeatvUDS+mVXT0wtbhjXrAmscURKWjXyOXbTfHGe8X
	W1H0nE1D1h+Uvcb63FRF9cx0Av+aPilNrCR3WP6tqMbVcUkK4V2B7z3o7+o=
X-Google-Smtp-Source: AGHT+IGynN4ZF370Lzvi3ueh0CqKqONEKwybpfbsK9fvcCWm2za00Rn41+jeaxCDTpgJmAnwoZijwA==
X-Received: by 2002:a17:907:7f9f:b0:ab7:c94f:af87 with SMTP id a640c23a62f3a-abc09a4b598mr518223166b.16.1740165017795;
        Fri, 21 Feb 2025 11:10:17 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm1027261566b.61.2025.02.21.11.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:10:17 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
Date: Fri, 21 Feb 2025 14:09:29 -0500
Message-Id: <20250221190929.31469-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
References: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

AUDIO_AXI_CLK_ROOT can't run at currently requested 600MHz w/ its parent
SYS_PLL1 configured at 800MHz. Configure it to run at 800MHz as some
applications running on the DSP expect the core to run at this frequency
anyways. This change also affects the AUDIOMIX NoC.

Fixes: b739681b3f8b ("arm64: dts: imx8mp: Fix SDMA2/3 clocks")
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 86c3055789ba..54147bce3b83 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -834,7 +834,7 @@ pgc_audio: power-domain@5 {
 						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
 									 <&clk IMX8MP_SYS_PLL1_800M>;
 						assigned-clock-rates = <400000000>,
-								       <600000000>;
+								       <800000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
-- 
2.34.1


