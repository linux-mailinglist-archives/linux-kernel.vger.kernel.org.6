Return-Path: <linux-kernel+bounces-543895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0FA4DB48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B553A608D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC441FF7D5;
	Tue,  4 Mar 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezjyld/P"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081631FCFE7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084927; cv=none; b=VeLz0/QnZnGSuDUvIB3Lsg4vxv6Vg6QMkh7OvIpLR88IMf/H5C32PpIh+IaZ6TY4KLPiYrkd3Qcajg1UEIf7Ok3ITCs2oDGFfcl3GyRNEFAjoSHWSkFYR20dC7fBE8uPnU+yJ5nLJZ3iTlhENVMTALuYyQ9OsilKpZjzLTae/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084927; c=relaxed/simple;
	bh=oVGnr7AhMY5erBxqjABx8O/86uJFOwPvuIi+4qeKs9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4zLD6vzfTLjTx+x1wz5U+VFK6i46Fm9WvvPJnlVNlGpy4DiCidVQBauVo7heBoXFRUF985kxkjwDuzQV5fUhA/BTyldD53AE0i934wa+w8Zd5iG/O9cL1jwNrxToodVScsB038uFZzQjVlMoYeKX1pwsgXiSESLkhoMwrXFdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezjyld/P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bba52bc1fso2148005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741084923; x=1741689723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRLGX0BSFbSkbyHv+vppZ4+v0T0SuHCAkvGOI/AsUU4=;
        b=ezjyld/Po0DBBS33OGbpPq2KWd5zp0hrut2NokITOhhYkq1a2+1sHwo2pTqm9rXipB
         fNEk6XCh9hWYsUUXkinZ6Haf27GFmHVijkdoxJ9Dv6b5EQDtIHFXQA/OjNMLKrr/H85l
         8K5xJUpiEE9yj1N1wL8hyhz/yPVELfrhlcl1oBGVqc/71zHklWt+doZHIOQNf+/232df
         6YSMJOF04oy2vH18VW4spWfYLE/X8HVSvVYffwcnXU4F0DeCHvA0wNC3csakqip+MZZc
         FmHnGiOjSHnatY7VV5lQ5L0hWszK23GiwfBHIagC1S+QAi0MYAltBbRk68HWL21e4ZFX
         WSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084923; x=1741689723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRLGX0BSFbSkbyHv+vppZ4+v0T0SuHCAkvGOI/AsUU4=;
        b=EzIs8rX09FP1QJLRLXlbUhL41+s5emWC4BYA7wVfwl+WwA0l5gDKBFnbpH9Qywu0W+
         AIwoEyH9l8obnoj1YhtGqWHCwOD5Cq4GrouNExejgpjWY540T975P7Ns60DDvlhB/Pz3
         W8+5RhRXXi48W8Wdir/CD7ODFF2h3MDzP4BMFg2CP0jTW2FMYce06uzR8ajHqdJ6N3/G
         Hp2+u2xWZfrnPZ9WCNkk0ZoV39JxGqY8dcatIawhv/srh22HON04K1F2dXE10E4Zc7C9
         dj/nSvE2BJ83FK7DJjH6C4sGpywyl8/Pga3EXslwSvy1/FA06gsx8ZHhGHs+NJyGnSeI
         cjyw==
X-Forwarded-Encrypted: i=1; AJvYcCVUU//hWhV6Zi18TiSC4CdhcsefErHb30Anbiytf7W3rIJ1o75qyQ5RbtpNj9zuFlCKlnC3FGhfH6mA1N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdx2sJ8gNY+Xtrl7B75ybpuTov+tJXtm9PCcY0E0OQlmRT4DUv
	UZgamcm0F/OPUpZqmkkaNdP/0eZHnyKs6nY1zprNLy3Sl2wsTU2E1qNMI/oLp1VJXeZFYY2wNXR
	vf40=
X-Gm-Gg: ASbGncupBIPnwWwdP/MNYZVlSKCB3fdNrShpP+e7wuDIPpB/vROUNMh1nfkOHxnOHiN
	XvqmsFlRzaYJQ0dXwacOqLRHrDHTT55NW8VbEKPLGsBEh5/CKK9iR9WChHTVHtfG9YfzIA0qHDe
	F2PSmtd8WjnWTOcxFz0Zk/F3mGxcAoM1Ug0VRtMUb+P5Swq8zpfeugz1B3A/vmDkGtFA5EObJM9
	CGzNWJRIZakfXR3puBvFqj5WhXAsOWlOgQdQP3RBT2rM/UR6Pr64c5sja3liM1XuVUccZViHpt1
	ZJ7YQ9bLZ/QC8DaGMfzmpvbzN8TxjFiCTP5ztkYH5IiIXqLHETIBU9t08ig=
X-Google-Smtp-Source: AGHT+IFu+lUWQUJTNva4ATWrG4BJPlHZWRTzwg/XUajrbEnxSw1V0tjsJYbZeKjxr47p60rztgJf0A==
X-Received: by 2002:a05:600c:1d86:b0:43b:c0fa:f9e5 with SMTP id 5b1f17b1804b1-43bcb969548mr7400795e9.4.1741084923281;
        Tue, 04 Mar 2025 02:42:03 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b792asm17202257f8f.53.2025.03.04.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:42:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3399 ROC PC PLUS
Date: Tue,  4 Mar 2025 11:41:59 +0100
Message-ID: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree bindings for ES8388 audio codec expect the device to be
marked as compatible with ES8328.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changeset depends on bindings patch being accepted to ASoC:
https://lore.kernel.org/all/20250304103808.75236-1-krzysztof.kozlowski@linaro.org/

Please take it to the same or next merge cycle as above ASoC binding.
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index e2e9279fa267..8e3858cf988c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -112,7 +112,7 @@ hym8563: rtc@51 {
 
 &i2c1 {
 	es8388: es8388@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		clocks = <&cru SCLK_I2S_8CH_OUT>;
 		#sound-dai-cells = <0>;
-- 
2.43.0


