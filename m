Return-Path: <linux-kernel+bounces-526492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257DA3FF60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A477ADE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4F253B61;
	Fri, 21 Feb 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLFD2KDt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B5253B41;
	Fri, 21 Feb 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165019; cv=none; b=rppRzsV61Mfs31bgAxqHnfoQ7U6M2krDOmJt2dlgRLyJx+am957sYgtN0oTsm79EOblvMNotyPNggnngWoBVxi7qwQNAQ++SoBiifVVaZVXpitHdiiGsflArAcZEY+Qid5ESeff6IWbIQjafRGwj4KX8vrua3c12PMPSZ2F4td8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165019; c=relaxed/simple;
	bh=712s+CZwtbCsu6iB8mRETbiuzFlVQdvECgHqf0Zlhsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3KYiO5qANHhtDHju0RcSPNlFi9qjHCIGF4IVfFX8Rw6g+B0df+m2RNDSp2GY5fgteeNeddM9L4tpzbkUfOHzSBFFEcD+jpYIqZLxHWQ2nE7ke3dtt+ksjEfi9QTi/yp/A/MmeoAxAc1LJ3LXYU4OSlqVyfVLaJvc5Tc1ZcNUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLFD2KDt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab744d5e567so429759466b.1;
        Fri, 21 Feb 2025 11:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165016; x=1740769816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia5D1StmV4CnXYyEpke0sKKPWzBMRVegEo2c54oP3lM=;
        b=VLFD2KDtoyXWF7Fhx0fla1aF6dF3HZRCk10cT8tkGj0WnRVtF+BVlcPHFDnnjuF/ot
         nZcoRAMvRPq2pWip0rgv1aPeVi2zAMoDJ1QSSS4dSqD/k76vOOZzUsOxANwiPM2dyZKL
         WhyVrOF5Fpekp3Ej0sYZlNss4/Kd2K2NUWVM7BWzgNbwgFC7X3ofWlUpJYSFBVXGjvx+
         TeF8cZ5v6H4PQ/lkpyudI4w8UG9CuLFX8aT9e3gCtBUAKXr00kA5IhqeBnR8L1bJ58Dv
         6AHiL9BiYpa5ed6lwb9kXeuJ1vP+D9VcKN6XObC0r+IjvXPyL6SPbnvcgi1XOV4IhV5M
         xinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165016; x=1740769816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia5D1StmV4CnXYyEpke0sKKPWzBMRVegEo2c54oP3lM=;
        b=cX6X+ix3bvTOkfKCeLAjGIwiW7vxuC8xVB+7I1Z9RhKndyurv20Hsi7Xa+IvMZJBED
         n0mULmMvDZ0gw4n0/5yAkvNy7IyMIa+nqaepvaQ83yyk4dNAw/AtM7n6eGxJZJcE7KR8
         wRYfZb6u6Nq8Du+D8e+x5gwflLlYS7nai2VAU1A6w/9qqXZZ0swtFxUZNVcEmUvGnKIS
         zWpvVV46fksGCO+KRAjGsA7It6wKg5bnTH5SFJ2BpZDdNyOJggs1UMh2OKnGaUZJfbE6
         C75MqBLDBfSVZrOGa0SQ7hHfHcSO/DVl3mpeQGOk17KcFZ8xTlFRGGBQgZ5ILU8fpXYx
         B0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW8cnTB8/xRz5kuD/qVEhUT5VI7uPQK0vj6nvVdV4/pqcB5lP9hb41GBtHfC91b2mhcngyPHtPHVDQ4@vger.kernel.org, AJvYcCWjRmcb4vMZjhek91ME4+21Tes+NilneX5571Goho5BDGFX6p8tEDDjqvnRsmYVSanT/tfNTrrHIpSe@vger.kernel.org, AJvYcCXoK6ysQfpsH4GB0+OV17SnnxWRszuKXtisDr7Ox8BGGG8fHkIU057uGq11TCUeV2sBaUkQVX9FEX/ojj/J@vger.kernel.org
X-Gm-Message-State: AOJu0YyaX2yRp++YiN7cOcZzzdTOp/Xx/SFgmAvgzZ574zmaLwTzN0+s
	iWpTOWqvPHLK7cZmcEF+x6DSZ8i1Nd39P4BaiXIYt/raNBB7qyk6
X-Gm-Gg: ASbGncsdGfX276DNgxAfnIA0f1YIaFDIUNZKYrPw4z3H0X9w5voo0nBKaB1sUVK0YUH
	OwBvEhny89rFmmtAjXqUtZRGbuBcZl+BOUIkvNyNpdek923WCNAD6ECX9Z0CWdZnKvnc3R4qZ+H
	Vecyf7wzbLstcZESwTXTHoD+MZKCMobUHPm55SKKu/pxBOWFXl88L958zlWYWhEEquR6w0/Yvzj
	EacT3bbEnS2A5NQXM0gf1FVhFC4qbfsFfYojiDcLuJYItJkcUjGprR3kxlMwIZfIULH/fxAERK3
	A0tdBYR+YuucLguH1dtP3RVHJgUXsfMFX0rOoKgXdyNxAGyymKTeIO5AwZc=
X-Google-Smtp-Source: AGHT+IH2yYVlH5R4OYQQsbx0L1fsjd6ylbWYVx6pl2giZCsE6+FEB6nEzzNoq7LJ9eixK0JAOpFMOA==
X-Received: by 2002:a17:906:308c:b0:ab3:9aba:ce7d with SMTP id a640c23a62f3a-abc0ae1ab4cmr359498466b.1.1740165015786;
        Fri, 21 Feb 2025 11:10:15 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm1027261566b.61.2025.02.21.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:10:15 -0800 (PST)
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
Subject: [PATCH v2 3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
Date: Fri, 21 Feb 2025 14:09:28 -0500
Message-Id: <20250221190929.31469-4-laurentiumihalcea111@gmail.com>
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


