Return-Path: <linux-kernel+bounces-522016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB951A3C4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C46172D00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569271FECAE;
	Wed, 19 Feb 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bqce8OIL"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56891FDE10
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982227; cv=none; b=kE/PtLv2VAIOU5AjQwsZjyk8QwaDNLQYPpVjc4wKoeaFxj/RC1Qugvc+c9Q89nG7oyrux1FV2PDDEuq3/yvEETM0JqWeGC8LUgfoqMraWKsWrpKL//MXBtMk441jrSUQGikDXYwbcDKeRyE85I3S+9oIkRXcgrEpdcNMDRFEzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982227; c=relaxed/simple;
	bh=HoJJKf2KbkS2X5DYSjb3aYDsagjrOYDoT6ljyujy3rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUIsqoLbkG8VTdbus/TyMAqZ4GrZLRMpTNeaSgVtXvlQP99o0EPX/NP9opEuR8u0LuSgiZUVUQFy9tl4YD0fL/n0iTRbTXNfMuiNQb8dzLlgX2ra71GW7ZWUMwbzW25ZdKd19AQt5cSUeAt9eepzTUXuL9WZs2S3ZHA/IH2eYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bqce8OIL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f29a2c6a2so661984f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739982224; x=1740587024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flx79lLhyjNJ1uQQH7Feun8sDQLsABUenRP8+0wgvY4=;
        b=Bqce8OILCsI8PpzoDy81ejrnPJWbEoNqHqzCjUwno7EWC/AWHE4WuOMNPmd7p/tivB
         82wbgIBwOjA+F7o0RSHeAKBBLsZxM2V2S97UvRUrovjBek3zYWLW9Q7y7JlbvsUywaWc
         DaSTOodUfaPq2nRFk7kFmjSGIw24iiNzb6Vmn0zg3PWjiYi2n6C6HWLCUln298IqdIEB
         xVNWFX8MZvLRKaxJFE79TUbuc+X87bhnhbPPLCZNxIbY6NE7JYL7E4gah/XcYN3tZND9
         sZg7NQ0v+MjcI073kaxZw8mCpGqC8j3dMvWcXSJkYoICqW7LsY+qXzaSCIn4oWACzCH2
         Ak9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982224; x=1740587024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flx79lLhyjNJ1uQQH7Feun8sDQLsABUenRP8+0wgvY4=;
        b=sH+EaN6tkQjh7RiQZOemg5A0yQlGn+/Z71E1jWoYOopRvhCIKBMvE/pQY8G9el1M0q
         RdUjgz2KIRqxAFD08o3rnHeWZOw3X6ofYHxgcrr0b8FousU9f5yn49xBmEAGPh9uLkXL
         kOWNtRzTWgUMKoIBLDmD5Qt4mS0mCEFsUuDedQlx0xE6st6vPaEpqvSXN0JGc7I16tvm
         yJFcHDufUe2HpW+iOOm8FCjBkGWwQT4IOXc6XNYznfa5gQ2XPQ5SQ6/NbmgN5HIUKlRt
         rQgFPwf7BDkMLnfqHIE+njT8VT9CAG2+kcsILSv3Jv8bUTiNTundf4Yxvg2GTEpaE0ms
         JrKw==
X-Forwarded-Encrypted: i=1; AJvYcCXvA+2VdlnsP9H6TscsytoAzRyO/+Q/QUWay9ZxPHFVtt/bQDCFwkFpfVYVNGxktqzxC5nTk9sLhDjaWvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCiM3UXhMhWC85eSFsP3gBUUS7O4zqwSZ7bLMhRvlOR+M+h2P
	DvrJAuUnZYHbO7Jbvvnf+iAP0IQ7HwEJC7H6fLJUKxMECYwJEF8fed1AsVpqcZG4Oq2mx2FLfdT
	Sr7k=
X-Gm-Gg: ASbGnctRwYbkXajPhQ5aeMpKgDRTn04tJydcMBkKOsoLmtpHrof9saWFg/KV/eAoOJ2
	MRtSmTkDgdwSI2Z9hRwuor8s3M2q7LCoV84Vki+4JsMJv6uhHkYMJUMU7r+1HuU67ot4jqpGWop
	PYUT4iK45cBzcARdZfixyMD447UruGAkF8HYTKdVT5/jgrMXljp/YxBENUam6hBznwpicKTJnNM
	5i6zIMIzItKmzW6kHGj0hZHGjdbOrXeKjR7hccTU8cN5Rkjhz3xTG+8Uui6obUDjQrg6v2lbDxc
	p9KWFyvbFvRtriyx7MmMArjXlaQA3Nk=
X-Google-Smtp-Source: AGHT+IGKoVneTQvKJC5CNmJtYrFVOs50kNrFcO6oV1uqtn6asl3HDOg8xjQNibJEhGg4neAkUWVmNQ==
X-Received: by 2002:a5d:598f:0:b0:38f:20b5:2c80 with SMTP id ffacd0b85a97d-38f33f2cbcdmr6538286f8f.6.1739982223890;
        Wed, 19 Feb 2025 08:23:43 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm18442417f8f.99.2025.02.19.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:23:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 19 Feb 2025 17:23:32 +0100
Subject: [PATCH v5 1/2] drm/msm/dsi/phy: Use dsi_pll_cmn_clk_cfg1_update()
 when registering PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-drm-msm-phy-pll-cfg-reg-v5-1-d28973fa513a@linaro.org>
References: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
In-Reply-To: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rob Clark <robdclark@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HoJJKf2KbkS2X5DYSjb3aYDsagjrOYDoT6ljyujy3rA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBntgWKtcucSVVrV+JpQB35XSs5L2SAmKtx22d+5
 q+mpsfbjMaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7YFigAKCRDBN2bmhouD
 16gmD/949j1pjmbpzNX0ZwnPqFTYiEuKoDTSR+KqMSaBI88QYFyOIlLcJTY5hCT+xCVAAhqfnk1
 vcUGlcvzGISUvAVQGIUiSo/Db8E4CYSgM6PhIvlT1MespJwLYvFxyCUC7qojzNhwhHP6qYJdmyH
 vBOtk52PjNUMQ+H6+fYw6CoTXDgsGw7vcAu1g8v588Aaw+3pb9mAZvsO8UJDhIeqctuqmUkAE23
 V/qy9NvSpcHgknXJo7QbukF9JJABXX66dlxU6MKQ0k9OZ5dhuBZVAF/Me/eS1cokF5OT9LxJDof
 gxNeclLnZzq7dhGNbmGv1EB46R8j6bvnP0a5e8S6RA9xgf+wVOed7VFpY6GZPLAAE7EHXsQ5A7j
 +9CJP65N2HHB1Fap3vJC1ffg/Fod1phdQfLGe4ug/5uej5kwZSIZMWxdqmF4HF4JbIwIhcj2aFa
 4IIwjbS0cmzT5REOARFcRszKjlKrjohPr/4rC56nNW5DnmqbaAox6jC3u+7z6at4VCy6FGGxbUv
 ObCQx3xVVW+JKR17q6Uiqfta4vKcL2UhfdX8HKWdDM2UKV5HXXRIOtPDGpfIp9H0qYgOMhcg5mC
 rN6jplRFeSTYwqenJUHWzaL5i+zSoVdcHVXD9ZhMY9gDbj4l5ukslomn2zApoGQmRl5sLyfZrhO
 KZ3TrCcPn8mxoAA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Newly added dsi_pll_cmn_clk_cfg1_update() wrapper protects concurrent
updates to PHY_CMN_CLK_CFG1 register between driver and Common Clock
Framework.  pll_7nm_register() still used in one place previous
readl+writel, which can be simplified with this new wrapper.

This is purely for readability and simplification and should have no
functional impact, because the code touched here is before clock is
registered via CCF, so there is no concurrency issue.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v5:
1. New patch
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 8 +++-----
 drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 798168180c1ab6c96ec2384f854302720cb27932..2fca469b10b33ac2350de5ab8a606704e84800ea 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -736,11 +736,9 @@ static int pll_7nm_register(struct dsi_pll_7nm *pll_7nm, struct clk_hw **provide
 	 * don't register a pclk_mux clock and just use post_out_div instead
 	 */
 	if (pll_7nm->phy->cphy_mode) {
-		u32 data;
-
-		data = readl(pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-		writel(data | 3, pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-
+		dsi_pll_cmn_clk_cfg1_update(pll_7nm,
+					    DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL__MASK,
+					    DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL(3));
 		phy_pll_out_dsi_parent = pll_post_out_div;
 	} else {
 		snprintf(clk_name, sizeof(clk_name), "dsi%d_pclk_mux", pll_7nm->phy->id);
diff --git a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
index 35f7f40e405b7dd9687725eae754522a7136725e..d2c8c46bb04159da6e539bfe80a4b5dc9ffdf367 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
@@ -17,6 +17,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="CLK_EN" pos="5" type="boolean"/>
 		<bitfield name="CLK_EN_SEL" pos="4" type="boolean"/>
 		<bitfield name="BITCLK_SEL" low="2" high="3" type="uint"/>
+		<bitfield name="DSICLK_SEL" low="0" high="1" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00018" name="GLBL_CTRL"/>
 	<reg32 offset="0x0001c" name="RBUF_CTRL"/>

-- 
2.43.0


