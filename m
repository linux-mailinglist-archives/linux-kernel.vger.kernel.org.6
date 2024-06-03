Return-Path: <linux-kernel+bounces-199261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B38D848B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D1F1F22971
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6F12CD9D;
	Mon,  3 Jun 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kldPoN9r"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053221F60A;
	Mon,  3 Jun 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423310; cv=none; b=qtjDFN51k0Jx0RhGVcnqszsRMgfaKwik8cGpwrHWndrCVlmIiIYoMQvEo+lAdOhcgsfLy5Ek8fvGjV7mi0X78Pb3tUgXWmJwMxVe2pBJibKBhaX1VHthiww2U5/jBCrzo4mZk1QNuocuDcxnbRmZUDq+QUCVSTR3WRWJGOf6F8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423310; c=relaxed/simple;
	bh=1eBfmTHL1QaR8pbVnJDmzCh9p4iP+N0vXh+zBPtMsd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2ntk9ExuuGkG6lS7nbMTy9OTMUd60dhW0FcI+B2grdqrzzCck2xUxL6hU7K9aW1nNaEw/7BZp1h3D2merO5bHsEBxFcQFuhusi+HPXwB2UnkRKHIo4iB1hROblDYrGzqoVDCEeUcz9lmwHJJ8ikZWItiXfqC9Bt6z3ITM20pW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kldPoN9r; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so4867523a12.3;
        Mon, 03 Jun 2024 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717423307; x=1718028107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cud/6aqJnRfF1FRYIE7dZy35PpEncKlSngXb7y86szE=;
        b=kldPoN9rEkRIy/3D3EyceyuYIDe+4y3pH2kH4mYiXL6HNlk/SuZZwhPas9Mr3xUjpt
         HOVS0DadAJiNbfj76hG/YZsx7Quag9myesY3xmjQlH/qXX0UmCohYt9b+ZBHIws59Nx5
         zcSa5IaLHoEEzpEMceKLQqe4PKMe5zhGoTIKg3fPz4GsZDYuBL0mePNBFu0PZI3XoIBI
         9ZQomoGtT42vlO3NPBNfd441wkFdH7+Ly1+Q0W9h3yQGpJ4BsuA4QaJ1bKlSewNpdZlG
         mBfsphrAL0BgMOBydSTXKL+3+fpIDaearPXdoeqGbVPNFgYU0QWFT0A0kJyqafJ9SROG
         Fvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423307; x=1718028107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cud/6aqJnRfF1FRYIE7dZy35PpEncKlSngXb7y86szE=;
        b=GbIv0FWtIegRa4CjWAnhtdLwprNf3SBrGPwt0Hp9oLgE8k4B1/PdLRQOJkj5DYqACL
         4CFuZYhMgyx7dioJuhfcuho0DYyezrO6P+gb/ayswVhk5T+h30rdwCmn3hCVICeHvk0j
         GUnfH3CLqMIlv1VkofSCovu/T2Tv3M2sDd1XtLxnNBkfQ+4xYzNYkBGNhCrfRIZuPoVM
         YabxvoBh4fatP0/RS5zi//Dhab9mSPDb30nYfpQRiNJadkJrbGUhRWARdsJgWceKZr90
         gmZwTk3mra12WJ0Lv8e42TN5mLsMK6B9Xo3HTauJyY1GRijQ2FXrg/Eg6kzUCCtTWuTS
         Yqww==
X-Forwarded-Encrypted: i=1; AJvYcCW5JVX7WvjhkHJKPEfcxk6LFqW4lGBobQHCWXiuFxn7UCBaZ9BHFbFTgaeVHoaKhPsHCQBBPt/w/1f9jV/gvp99Hza2H+WMbXMstf+IFI4zOnAhMSJ9Pp9MYtja0QxV2dyjqNqB7cSROQ==
X-Gm-Message-State: AOJu0Yy1jVRQ9ftio67rQXrfzgAroQ6laggx7wymwrq47TG+8gDy2R1/
	BWpzx69GHA0m+rrWqvoeelCcjYp/srVOECgkR6R81C3SaZ3GsvDV
X-Google-Smtp-Source: AGHT+IHYwq7JslSgiiWPjfYTfZvNj/Ldq8H6hHi/nPS12CQ7DKy5/4mkKUOWlx7SsorXuBkZ1VLOwA==
X-Received: by 2002:a50:9f2c:0:b0:578:3336:92a with SMTP id 4fb4d7f45d1cf-57a3622b9e6mr6527527a12.0.1717423307034;
        Mon, 03 Jun 2024 07:01:47 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bbddb6sm5438541a12.38.2024.06.03.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 07:01:46 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: imx8mm-verdin: enable hysteresis on slow input pin
Date: Mon,  3 Jun 2024 16:00:45 +0200
Message-ID: <20240603140103.3845905-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

SODIMM 17 can be used as an edge triggered interrupt supplied from an
off board source.

Enable hysteresis on the pinmuxing to increase immunity against noise
on the signal.

Fixes: 60f01b5b5c7d ("arm64: dts: imx8mm-verdin: update iomux configuration")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 4768b05fd765..7a971b235283 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -935,7 +935,7 @@ pinctrl_gpio8: gpio8grp {
 	/* Verdin GPIO_9_DSI (pulled-up as active-low) */
 	pinctrl_gpio_9_dsi: gpio9dsigrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15		0x146>;	/* SODIMM 17 */
+			<MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15		0x1c6>;	/* SODIMM 17 */
 	};
 
 	/* Verdin GPIO_10_DSI (pulled-up as active-low) */
-- 
2.42.0


