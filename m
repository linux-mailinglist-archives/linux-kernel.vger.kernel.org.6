Return-Path: <linux-kernel+bounces-518123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BDA38A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1091712F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41A228385;
	Mon, 17 Feb 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIOK1RQO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C8226869;
	Mon, 17 Feb 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811656; cv=none; b=PAYa1K7rBmT4o9PrOSz9SpLL4ooR5SKvNsM8wdmIfdtaVO+8NBUt86pHas9kBgXMxQfgZbonvGLlbw1XGbtKsQ2PasDOmITs5NRWlzWfE7PeAAJmGofwQwl5XhA4vGSK//cQnik49uEIQQlO9+y3UWqQSNK1Nu7mYSjp1V7cBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811656; c=relaxed/simple;
	bh=JHzcxwkGTQ+OHOtDsXcrrca2cc1Rfq1hPqll8mFwPvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6TVdf9iJ7HWhvt45EHz6z/Y+cLl8poEOTESog8mpnXwhzkzx3i741GXohIfMSP4G+G1lItteuH5aRv4RHTavZduvpdNGS+zZuPDsJ7kxCRrj6OV5CcfGYFk0mV09erIJ7h5Ubi7V9hkQ2ftyf6jr3cUtQloXJXW0Ad0OCbRZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIOK1RQO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7520028bso267909166b.3;
        Mon, 17 Feb 2025 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811653; x=1740416453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqaLFrErmA8TuMfUKne+UP0vowW73z4ybOt+Ip1qbmc=;
        b=PIOK1RQOTvaxvy6hI02eBfBM2nvHp3vrmfvO0DhQliUkoyG6JmZr3hf18BdFdn8h5o
         auT0ajfbQf0ey10e8vfoV7dbe2KtImg/dbcAkxV3DKGB+ZkgbV6BtnLcv0EZGm7s7+vG
         k6241oliRZZh89iElmrHhXWVlwPK3+XTLD4mh4RuN0MPYtdUVy/1DRLpWoDI1h3rVI0X
         SRkkzPl2gYz8xbuDRiXzDGxlG61BEUXMpkYDh9JThdIGq3t3r/ptaqXAEH5qtvurx3e6
         ASZrXcuoDqiH4AvKb8iAR0lSmyI5uFUgU/fEifflru7WokDBcUHqo8FOUNHYaN2x9lZI
         D+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811653; x=1740416453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqaLFrErmA8TuMfUKne+UP0vowW73z4ybOt+Ip1qbmc=;
        b=UnJVHqmdO6FRfnXqown0/j8xiUx/g+1Sy/BOiBkNU7fUewduOv803WhaUPGS/kHh9N
         CMgpBd+MqIcfyRU9qNmTIOLQ43CHW8yFsbyybrCw0znLtQHLaI7F5N0I72VLJFLWuRNw
         rBhejg2I/0oV+nqMP48GjbbwMfGtxbOm4eDCT3m8l28VRC5m0ERKHECZeVCCm4AkGnPD
         1g5JatrsKEo/Ni/qbZs1WK9drB524x4ZFhe6QniYtMYUdDN3DGqyccMXgXN6tSNip0Xp
         KY1FGCza0CZnDnMEGpiKoa0E3VG8WlJPBqfI3h1ZwR2TFGgDb7HlQBInDTqiIAzyx3bX
         hmgw==
X-Forwarded-Encrypted: i=1; AJvYcCU99z9ZVr7LDstwSSDWyJzbPBYFqOdZMyz94fRtLL7FsEDH3X3GMqkvmHHj0bpFLApopAxaZ+HIiU59@vger.kernel.org, AJvYcCUkmVfF/jA5CHZtQYgOVSGII2+cMNXJ3WifWd5Vbt8LgCfqyXnRRCZyg7ymVg7ted6kffxlnFH8SfBmC+1t@vger.kernel.org, AJvYcCVMm4ZRtbs6qKuKSbm3GrtDtk8pDu5YZPR4cJ98OKM0nXhtg40jv5L7Zfq8bvQd9yqaDS60rcRXVNM0@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKnLAojxHPweTMT8kff8qo5Q1EmyFdpaME8kBa16M5s+FcBT1
	UiqJcu6TbHNahawtZS0nDRL1u5UnD9IWXRR7asmfLC2qngt+L2AE
X-Gm-Gg: ASbGncve6jlYgFFYRjIfOHgeQmGkiXSKJK8oIKGffd95XahkxmjO9jbm6BdVjQ423Nn
	iR4B37zg3mbbKRdRbDsYFTlvX6VEpEoMsOpde5Ov/HyZFq5imbYR4UWP0Eiv8+or3BBstjBK/jS
	oS4WVXgMvJ3QBYu564EDkLF6rxX4Vh7ZPtyTNX8X3OmJ8XJ88cPSpXGa2Dh2C8MpLKGKlOeLmEf
	r9Y35YsBHPiemjnVx4L8E8vsF/fNb2k2wkpHvMQF68FDN3DFecC6CyfUKP/6u36KbavYrBtNWmE
	Z/7VYFIp2z1+mAMpCvGnNVuUZxP8tv8qDHvsUNSz/KKKKZKG7rhrOQ==
X-Google-Smtp-Source: AGHT+IHrNiu7Mfg0Om2Rj3jVA5y5sNcTyvnjB9HoCWBNScTUmN+dS44zo9eg//XHmKb0LBd6UmiAuw==
X-Received: by 2002:a17:907:1b12:b0:ab7:bfb1:99c3 with SMTP id a640c23a62f3a-abb70e323cdmr1177370066b.53.1739811652549;
        Mon, 17 Feb 2025 09:00:52 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376aa2sm920570766b.103.2025.02.17.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:00:52 -0800 (PST)
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
Subject: [PATCH 4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
Date: Mon, 17 Feb 2025 11:57:18 -0500
Message-Id: <20250217165718.74619-5-laurentiumihalcea111@gmail.com>
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

AUDIO_AXI_CLK_ROOT can't run at currently requested 600MHz w/ its parent
SYS_PLL1 configured at 800MHz. Configure it to run at 800MHz as some
applications running on the DSP expect the core to run at this frequency
anyways. This change also affects the AUDIOMIX NoC.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
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


