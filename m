Return-Path: <linux-kernel+bounces-310006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B159967302
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A7F282BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F117BB3E;
	Sat, 31 Aug 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVkL4KKl"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EE17557E;
	Sat, 31 Aug 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725128704; cv=none; b=Q3Jz0/+3Tth43XKVkQlRLBgNuAKiPH4dHxdpRdesPSvnhLsxfFeJONki/tjTRF1Rw+uQE9HjXRDeZ2qFtkh+oqvVDTJ8oH4fW0CU+hl9m6nqFSk79F9si+kqbBXfxAdx7jfmbxioz8gN4AJpJWdUn4hpygyM+BdfQCcRG2lmFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725128704; c=relaxed/simple;
	bh=zli81JYvkdHfl2NmCNxnnSP9GJ3ak6qbEIYGnp2B15k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpPwHaiePH1fNkFMB1a8KyG7zvBtaYcv3wZW8uZFScr67j9iyL87DCTMXZ/+v4r1JLEN9gxra4AaET08oEKShc/PP0BhuiU46dnHAX8UagCQqfOxhHj66dc63vWBY6yf8/bp8N2utMPCuhclHQ5yUXqG9NQ664PAVMfxTzNfOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVkL4KKl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8afdd62e8so56395a91.3;
        Sat, 31 Aug 2024 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725128702; x=1725733502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/PZpfVojtroG7VabE6LFfz6wJPwzCtMCKr2Q6D6vNs=;
        b=SVkL4KKlNSyDPnuO8xwFCGZU+a89AZXUpzAG/MI2udDpv3y1GjOueo+XZSYUwpxSCz
         PiIpZJZZNXALk4/D6rLvqbVEpTC4PCUavPz0jlSclxr8ro39qJxpLppYPlJI2Ds6vQiy
         +5E7jJoZTvu1C4NVOac6iBtIvTZH8b76YzY24RaZl0O6Eb3nFagSNdwDCjMvyMUKe580
         sHFAN9IQkBs6wbDxmAs90EEflasatYFYnEWaCmOn258463h3ZrwxCEs/Jwll4XFW72Ai
         bkhTbjdXTJ3UWo6X1Vv8zt3XJiS590c3C0w1YB7u1Bm5OvmMJTiORiad6iomxixa4mM5
         AD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725128702; x=1725733502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/PZpfVojtroG7VabE6LFfz6wJPwzCtMCKr2Q6D6vNs=;
        b=GqNtC0ApMUPYOGZZNv32f6fZx4l/T3lJ/jjJ07E+lEWRYKC1XpgIDBe0N7JU5xu0eG
         6YxwNsGdv1FStLOM0NrSoSEN13DkzUJKLj2Rcccfu7M7Oo7lcZs26ssGXWBUzXv8twa4
         va33toyrhYYiA3uKszNTvFAXG9x2UGbw+O4TFuJNebS2M9VEkl9qrmfctoJX7L9GSvC6
         AfUa68d9Be38BQ2x3DURxMHn9oBSKniS896GnziTQQBbuB1Ay9lFAsGw06K1OKf8KTps
         VDvXQiwGwAjfBR33vgjHeT/XY5M/MhjNSxUfjx2aB+oaif1hBLuq/h+Ey8hkStlVvCOb
         BP+g==
X-Forwarded-Encrypted: i=1; AJvYcCU7crGj3ae6DzZoVSy7UBUE6nnxpuB3zTq6AioHO/UawU6SCQMcztOHWPo1CVak0D3CXBeZl//tGlDfGn/E@vger.kernel.org, AJvYcCVmfS+2PpKUAq/3u85lfMi5HFUKb2tBql7XjaJrZENC3DSj1EqVCZwvxaZ3HioqwkrQITHgejsQlxFW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SAHHWwUWybAiN2MHHT0ZKOSthgojztVWZyKfN2QJVXgWieiD
	E7QzNPisEun5hc+/poCBsEt/ZLHBhp4b9y5W6ealn/u/GqkVeUZPinKxnx+a
X-Google-Smtp-Source: AGHT+IHShkB09E72giDT7wzh9N3BM9UmeN3Y3RgGpXHPBtad5tpbFtPO9ARbXYO2pYEQgnrbdlFunA==
X-Received: by 2002:a17:90b:11d1:b0:2d8:8254:b913 with SMTP id 98e67ed59e1d1-2d88254b9e0mr2679779a91.4.1725128702127;
        Sat, 31 Aug 2024 11:25:02 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b2725332sm553855a91.34.2024.08.31.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 11:25:01 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Tim Surber <me@timsurber.de>
Subject: [PATCH v3 1/1] arm64: dts: rockchip: Add RGA2 support to rk3588
Date: Sun,  1 Sep 2024 02:24:24 +0800
Message-Id: <20240831182424.758816-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831182424.758816-1-liujianfeng1994@gmail.com>
References: <20240831182424.758816-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 also features a RGA2 block. Add the necessary device tree
node.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Tim Surber <me@timsurber.de>
---

Changes in v3:
- Rebase commit to next-20240830

Changes in v2:
- Sort node by bus-address based on next-20240604

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 97a1a68e94e..d97d84b8883 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1143,6 +1143,17 @@ vpu121_mmu: iommu@fdb50800 {
 		#iommu-cells = <0>;
 	};
 
+	rga: rga@fdb80000 {
+		compatible = "rockchip,rk3588-rga", "rockchip,rk3288-rga";
+		reg = <0x0 0xfdb80000 0x0 0x180>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RGA2>, <&cru HCLK_RGA2>, <&cru CLK_RGA2_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA2_CORE>, <&cru SRST_A_RGA2>, <&cru SRST_H_RGA2>;
+		reset-names = "core", "axi", "ahb";
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
 	vepu121_0: video-codec@fdba0000 {
 		compatible = "rockchip,rk3588-vepu121";
 		reg = <0x0 0xfdba0000 0x0 0x800>;
-- 
2.34.1


