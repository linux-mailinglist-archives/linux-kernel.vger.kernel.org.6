Return-Path: <linux-kernel+bounces-275109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D59480B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4275A2828D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25E15F3E7;
	Mon,  5 Aug 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W17WbSBR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072E2AE95;
	Mon,  5 Aug 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880140; cv=none; b=kK9bi483g7MPNGBKD+i/w3RPPiaapET9WtzdUjkrzO3LwtYgKB0lJYqY6+ncrniKQREEy8yQcuVU0tokD9RdwaESclC/OqpE71HJrwrhNQPgpbT7GtotiiRXJOCdliWLs2FRUsZ/nUAx1QiUoIsCIfyAyYzalDErSZ7Srn0nAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880140; c=relaxed/simple;
	bh=llFrI7pvte/r84mBKKHnaJ2age4typJ3eCrZg47lo38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gG8PW+pgt5fN4iJyeDHc/TfFgUahpBKRcnrWXa+l695g4lPieoMraHX8ze9yIR4Np/OaWuH8l98mpXMpZC7OxHj+UGnsVFl9oJX2fUhTl425hTxsQ0kKu6K/zxM8R6hMcRXSAGMoHfA4M12lk/g84B9ybTIHl3Wf4+ejRwzMKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W17WbSBR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fed72d23a7so80526565ad.1;
        Mon, 05 Aug 2024 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722880138; x=1723484938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn4rsXYYUAtI598UTIBkOn7PpCHc0T68WG9CUGnshMk=;
        b=W17WbSBRWxgeH3Yngh/JcykH3e4nYeRPP8eDsPmPbGX+uuGH6EOOPJz1zaq6SXvtZL
         xiu/ZKAmTyBwzrb9vm23NGkJefZ2su06RLnp6oT6ORLJnUOIjfU6C5D61HMtIlpPNy0C
         0Azb0g01uRrH/6BgjClB2zUBhRfgDi3uTxdHHhWU/z4Ued6x/kNd2dQb1H61tBPve0ES
         AmCvc8oKqvR7HkiyjcoDZfwCSkeBYEWYcppR7c2Hnvb+Ho9RGppEpJXk/jRdh2gUvhQX
         rGDGGo8TxVZtQfQAm3ObdQLJT6Qu+FD/bec1UBD4MuJGyaf0mJBC1/vnoTjfLMi0XchO
         8uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880138; x=1723484938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zn4rsXYYUAtI598UTIBkOn7PpCHc0T68WG9CUGnshMk=;
        b=hi2Ceas7TgdUZChT3o4kYMe+wzWdmYizCRRYXGhBfZ2kCZ8KWx9sOlvwP0Qridf7xY
         cYPuBdZT2cdXU0I3AIAWk206qvckYWFef3Xp6RZ9OtZTVFnDxwGmHIA6f2jzQSMJ1HcZ
         IsG6qTRZ66PhcOnVhX98uRCG1vdvpP8Y06/wkvxQih5fhsOKDYXVmOxhhNtgCXDvNWcl
         4UPo46nMc4O4LQWtyFQs+byohQ4iozyNLZ/Xa7LCUEW+vQChH65tjbJLleMyI83gbbWk
         08YNwhLCdMAfjJnnsqZCABqp4Uzf6f5QDSSIiFTAlutrYesFLd5ApF5bZR396qGMk4cV
         oIAg==
X-Forwarded-Encrypted: i=1; AJvYcCWMMIkf8OzEGbLybgUvExnJyES4m/ySMwbZ3wgldemDuYPsyM65PRpd71w9sHNpuQq5aN371zmtYN+1tWLhS1i3RJU9WQerbhVR+woA21zQLrCpLq/OoWXN9xSVrPTnUmV/w9mXrKZWBw==
X-Gm-Message-State: AOJu0Yw5GLwxSsY6rGnhFM1/yk2CK5pcWUaLH2hWf0jIV3QJ9aNBeu/q
	oEPe1ROTcqIEYqWZNPF4+SDRHiGOzDQPlL9BS2RQvcQjaW7Cr6jL
X-Google-Smtp-Source: AGHT+IEIriqBf4CCVf+NnuVLOxRFwo4euNZOJIjez7hPS7Rm8hIVN0671My1phGGrk7peFmNy9R8nw==
X-Received: by 2002:a17:902:ecce:b0:1fd:9a23:90c4 with SMTP id d9443c01a7336-1ff574e40e2mr133971405ad.65.1722880137802;
        Mon, 05 Aug 2024 10:48:57 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19eafsm71442335ad.53.2024.08.05.10.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:48:57 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: [PATCH] arm64: dts: imx8mp-verdin: drop limit to sdio wi-fi frequency to 100 mhz
Date: Mon,  5 Aug 2024 14:48:14 -0300
Message-Id: <20240805174814.1944742-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

SDIO frequency was limited to workaround some instabilities, however it
turned out that the instability had nothing to do with the speed but was
because of an issue with the USDHC IP that was fixed in
commit 52e4c32baed2 ("mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line
auto tuning for SDIO device").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
index efcab00c0142..cae06cb67cd3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
@@ -75,7 +75,6 @@ bluetooth {
 &usdhc1 {
 	bus-width = <4>;
 	keep-power-in-suspend;
-	max-frequency = <100000000>;
 	non-removable;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wifi_ctrl>;
-- 
2.34.1


