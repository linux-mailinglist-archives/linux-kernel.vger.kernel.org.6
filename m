Return-Path: <linux-kernel+bounces-550846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36FA564F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B4C18958CB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B6A2135AA;
	Fri,  7 Mar 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4N8GxbI"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B68213249;
	Fri,  7 Mar 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342689; cv=none; b=Oqd4Uz2JpbDOkqWGTOaoxbmlUV7zhHlviv68EvTtF/WSPordDx3wr8zKrawWWcO4zWq2VmOs+xr4w75MrSuFoqR7YNwan3+Av69nV+cS8Yp8Tw40DfCzGRcDmcc2tOSmt9zMwNws5SSOsJyMjmLTp+JmKhveWA3SBFfOW4Wbf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342689; c=relaxed/simple;
	bh=VuUdpkHlmMFr7mbOhennh+/tErc6Jkpp5XmmJqVRPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3j0rb3/iznb5E16Qd2XJAoPHXBNm7J07oVBAchYX+78QRgu72rYsjYOfStkvoy6IFgafgHXIn3PqO7px1giGgIFZoFVJADgIAQn5X2Hp5wsMsoglsvaihaQKqLuGmhcWyUwCVOOgQN60Z/4A7zo7en57Tp2Z+2KDLm5fBjrqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4N8GxbI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39127512371so1035854f8f.0;
        Fri, 07 Mar 2025 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741342686; x=1741947486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3zujwTDTSnOftF9d4bbs2FCsfJL0He6fFCsD1C9TNw=;
        b=J4N8GxbILYqfAZe1jkJlc2HqsbtBw048yA7x0etI0XsYomeBQgLssRT3zTNeSpuzlE
         aImQfcOb+3O+Xgw38unUVwkN40hdebihLOVj69X4kUETpvGee+lSOPjB/e+J7L71YTlM
         jXpO/INPR1M/jBNz78cGhoiTOTAp1jkOP01aIoTfxxAWijw1K5cRl8LuzTr38Gr+jEwM
         cTvmk/OIF6Db+buY5KZqulEq3oAM2rVicL0XfeeYHdh45sg7B986fWSkiGzvaYbwBclV
         Fbp4d3IEBLrAsz/kbgBiC4BfFky5jRn5SFK2Y2Nyza4JxcB2UYTyNyc+5Z9mB9hi0nNC
         RoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342686; x=1741947486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3zujwTDTSnOftF9d4bbs2FCsfJL0He6fFCsD1C9TNw=;
        b=OplpikSc6sa9/kKkH7S34yyWsdx2ayluYgol8QTds3Q8hWGq6HVXq2Lmyri069l9R2
         YTmWbm342qROu7BWap5q2MM535+gJnjHIvz0eA/v3FVGgB4lAgkNGz/GOKJMBFCARdLD
         CMM1nKCMeTVWGYMMNPx9F/fc5t0tmEsAPD49FXBgiHMwARv2ytZsNGq9+prW05hY+L5C
         AdlZJE7vynpJm+HzZr12eb6oqjfBNMfxuavgQSAbRrNRyygMGoRBSBdjSTl5oPh+Tilr
         64XYuLY5OSMYrC5EwZ/6JLNLjN5S8ovOCiVxVM0bTVUa6R0fdNoNQyVmwsexfTzwp/eh
         sGHw==
X-Forwarded-Encrypted: i=1; AJvYcCV3afQUH6m7JHA024MMewo9YNTUGhhcsFG4AMsK7wUQAKw+LS94clt7iYYWUx66BPZtbZkKDlcJWxDC@vger.kernel.org, AJvYcCXyHMFla59A7VArduuDen6lh0099S/x34ZzvDS0/Spb0hdcQ3SWr8NvPje4Xas2RXH2pXco5yIJkqEZHNMz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bN7vlR217gXAql+HBxsu851w7zBbli6BMiDWn3QJXAJS3YFu
	u3mOetIFdvGBhDOq+Zxum6HSVfyt/3W7LQovVml86MloUo/XdIj7
X-Gm-Gg: ASbGnctPVv2AKxMlR0Am9cQOoF/gFih9zj2KAGc9+Mp7Z7bU4mLziMY7S3apZCg17V5
	JpmI6fJdGEyw1Ae8vyPo+psxu87ZVi95jCIGDx4U5eYHbuz0yFeBrc8gD3hMO1boRa23Eb9I02Y
	ahH4550QyTohCf/KTt8pf+w7fd0vcOiWCzMxN6f5Yn04FZjdYdESudb/w+Jv+v2Kx/pQtiUd8W+
	F7cJrsBoS1Smkc8LnrB0ov3/IIaJfOBzDhFvE7NnK5BsuD/mY9KVqztJ6zYYA3a0iaQd6EOgaml
	ZCHvGMwhqvHpquFKIB3MuonGOJAPm5m4/1hRv5QDTBSpscc2eO2z8c9g3yZkBlse8MX36mDcvrL
	4kxjsxmmU+Co9aL8GQHd/qTY=
X-Google-Smtp-Source: AGHT+IGm5hWJ5tWDkJ/PuMrlbEjX8ZelRicivEZmMFKj0WGovJlJZMjjCvPcqwJRfFTKZqrD3ik87A==
X-Received: by 2002:a5d:5f89:0:b0:390:f9d0:5e3 with SMTP id ffacd0b85a97d-39132d671b9mr1522906f8f.1.1741342686055;
        Fri, 07 Mar 2025 02:18:06 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103aa5sm4900262f8f.94.2025.03.07.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:18:05 -0800 (PST)
From: ernestvanhoecke@gmail.com
X-Google-Original-From: ernest.vanhoecke@toradex.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 0/2] ARM: dts: apalis/colibri-imx6: Add support for v1.2
Date: Fri,  7 Mar 2025 11:17:47 +0100
Message-ID: <20250307101758.27943-1-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/touch controller,
which is EOL, with the TLA2024 ADC and AD7879 touch controller.

Accurately describe the new hardware.

v1.1 of these SoMs is still described by the following DTSI files:
imx6qdl-apalis.dtsi
imx6qdl-colibri.dtsi

The STMPE811 touchscreen controller is no longer disabled by default.
The STMPE811 is self contained within the SoM, therefore, disabling it
is not the correct default behavior.

v1.2 is now supported by a DTSI that modifies v1.1:
imx6qdl-apalis-v1.2.dtsi
imx6qdl-colibri-v1.2.dtsi

For each carrier board using these modules, a new DTS file was added
that includes the v1.1 DTS and modifies it with this v1.2 DTSI.

The original DTS can be used for modules up to and including v1.1.

v2: Fixed the "From" field
v1: https://lore.kernel.org/all/20250227170556.589668-1-ernest.vanhoecke@toradex.com/

Ernest Van Hoecke (2):
  ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
  ARM: dts: apalis/colibri-imx6: Add support for v1.2

 arch/arm/boot/dts/nxp/imx/Makefile            |  9 +++
 .../dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts | 11 ++++
 .../nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts   | 11 ++++
 .../nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts   | 11 ++++
 .../dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts  | 11 ++++
 .../nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts   | 11 ++++
 .../dts/nxp/imx/imx6q-apalis-v1.2-eval.dts    | 11 ++++
 .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts  | 11 ++++
 .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts  | 11 ++++
 .../dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts   | 11 ++++
 .../boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi | 57 +++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |  1 -
 .../dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi     | 57 +++++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi |  1 -
 14 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi

-- 
2.43.0


