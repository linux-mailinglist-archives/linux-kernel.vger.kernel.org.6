Return-Path: <linux-kernel+bounces-518122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD7FA38A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F67F18945DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF6227E9D;
	Mon, 17 Feb 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9fMjxjr"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B4227B96;
	Mon, 17 Feb 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811655; cv=none; b=nYlniBq4eI5pFo/jtLDLa9sJisACwNbPbomPOJByLOYhMXMvYo/yJD3taMh9eW/23Fj4Dy8/mFenvzBmTYJGXc1WHk/UI0ph4/ZMQaI3HZti/w4wg/pnxIwjW1CttbiOCNH3DZv4yNfwFwUOAbdISkYwnufOqTHfEVId9wouUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811655; c=relaxed/simple;
	bh=8lvI2yFnrYJRTGggEjXBozhmoglcaIO42lmecjx/Qgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0SStYUU+zMj7DYuoEvEcsToV3GzMhC0TxO8HTzhwmW5Rf+ejb+IJ7w9nrXWLRid2v72b47pTE+vK/6s5bdJWGLaC1ViDo/CjWUk8jprvVJ1P0OXZXIPqSPmuRkHsUisN3SWIm327ZX9z00A/hoXaLt4FtTJaYbiSK1JuZpiS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9fMjxjr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso756387766b.1;
        Mon, 17 Feb 2025 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811650; x=1740416450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgtGSdqBANC5sTmLJ1PkHCo8fVQkG15TwN1atvXCByo=;
        b=l9fMjxjrmogfyTKta6T7A+WBh+Luun3ZCWP+qWkQoqLDy1xoRvrjhEgaLQmU5MolYG
         xCKlXosayFwevBw63LQ+xGMLPXqqeQQ/p/4rSusQQxlnwSUN2GXG+VACndOiAhUdzFPB
         OJlJmgRCxUSlyDPuIzVRpHYN20E46QswboGusgBFqCrnr/hF/w4RIHkCnTH5d9nOFnom
         mYEHNuyMqn/nmCj+/IeNdxaHtouDqc1vGEfp7ae5DQBdyERixyuwIvXIdgD9QdqoPIUT
         irc0o5SWfyEQYShdncXIM/x3bUN/5VQuoVHwJm6Rwrv5kcws2tn/kiItJgiMYMlAGnxv
         uudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811650; x=1740416450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgtGSdqBANC5sTmLJ1PkHCo8fVQkG15TwN1atvXCByo=;
        b=jy+ANtgQ11UIU4vbzZpaRelORLzZX+6lgAGz8oyjh5+iKkdbhi480+xjEK8WIM8nPd
         YCs2GEG5CcAJS7GuKoo48v3G4KpS6ZCDE+ndnTD1fedPPsOrvAavlruAPeBRdphqHhHL
         ecIoD93JWLq4dBda3U8TZ6smybMaVjp0M161lbvS/ZBeePLiyfVmjJArFdKLP08mkDyN
         ykXRWx2w0LCsejj6i6yg2V1K/KYe3feo0o8iGizxgRWb+zXxIJwyid5cNQcykE56pjwG
         eEyMnDGyl38+/LcQqW2nK5/1OPn/9lmzYYvDnj4LxuWcJtyh1ro+pwfryA5w8iSoe7ol
         wb1A==
X-Forwarded-Encrypted: i=1; AJvYcCVAJeTzR0LiutFYct650o1PCsoAv6FE8/p7w5IiQl1PXBBRguNGZnu5dhdMIzTbMuJNsHEdLUq5FQCpl8ux@vger.kernel.org, AJvYcCVyAZwKn5QwzigV7SoOE/3QDta3wWP19k2KAH0ZVW+wWOjwBld96NOcLwfIFVW+gBPSZ3sHbfQH4utF@vger.kernel.org, AJvYcCVyqMb3kj1ru5+LI9OAXPVmfMBi5JqsjCrLC30uiiTsKDAAquwlqcCe2+SP406VseQDTohl1d0mQx36@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgvPoh05+kf59tjWu7tSI5+vPM1XaHS55EqYrLqY95Us2MkIv
	/2UmxUQO4dO/L9I5R77bURSl724180XfxsxAtCA17EB6NXnOb314
X-Gm-Gg: ASbGncuELLUTYjSRf1pMQPFQJlEQDEO4tZucfzZ82mvjF0LycKB2woHIurYA8ok8cmW
	p0Fim+5KExqYvS0HoKWZf+q+KcChgZ4z8AD/OMR/Pqn8uxpyw1h+vyfS2/OULk+gXdii+O/z1QF
	U6lI2TWm5Sbk22SfuDqPehDo7w6daRquSDjLSuwqOyQtktXVeJWzzWK068hbadab4u36BKV6gtI
	TMN6M4Uz4tK8LjjfWMYu4sz4EaVvnzF74vpb3TxR0/F0z98qzjBe/QKnk2XVQc8g4E714gL/z+O
	7YSaUegOimBytNPJuue5XUeLwYK6uAhmfMlkxiFvg3SwDiPYkXNOzg==
X-Google-Smtp-Source: AGHT+IFdMA0w4kBmGqa/9HtjcxpzNaH63DP3PJYieRpyn4W6ybrBgVCEnM5tX1Pgqn/wqOOzj45jOA==
X-Received: by 2002:a17:906:f0c9:b0:abb:a88d:ddaf with SMTP id a640c23a62f3a-abba88dde9cmr269033066b.55.1739811650253;
        Mon, 17 Feb 2025 09:00:50 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376aa2sm920570766b.103.2025.02.17.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:00:49 -0800 (PST)
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
Subject: [PATCH 3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
Date: Mon, 17 Feb 2025 11:57:17 -0500
Message-Id: <20250217165718.74619-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
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

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
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


