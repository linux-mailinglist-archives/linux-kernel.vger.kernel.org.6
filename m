Return-Path: <linux-kernel+bounces-265275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A882893EECA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519E81F22035
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210D13C821;
	Mon, 29 Jul 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YgTRHm69"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F313A896
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238928; cv=none; b=r1yB51BmVepnr8DBE4YtqB5biBHi+X1BOdBA7oRrErhYh0fKzPnT4tqs8J15oT6YxSnccM8/d87hunDYkHODGv4cV8jvF+rNQvhKpDhLoMjShgMWFfraMSihSDgQjEfa5E/Xn0zj1A5L6h+X1ChYrU6/P9cxyErJhIuvlB7ZQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238928; c=relaxed/simple;
	bh=S1cCoD9bh4B+uAgxd3LHWOod0JD+NDzz4e7CSw0w4ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdfpjKeK2QoDMrT7rV/WeVOdljsy0sMWtxVSmUpB7M7kpHsz2WK0PcKzk22dSQL2vhYGHULM6nxlKP815lg5GNjxp4rqSaLeyjFKSSH1IBgHJZUVa2qm/gQpXESuABhJ+Z0J3NbCL2Dc7WEj7fdpY/yufKPLS5HnflSAwOx1zZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YgTRHm69; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36887ca3da2so1119748f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238924; x=1722843724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAIaWbMrpjXJfyBx3wUp/7AwV6TpyTkOy0qtsR/TmP0=;
        b=YgTRHm69cQ3RzTf7A06JCYYsqe0sXca4iCLkql4OrU8Mi5/7XZCrrRBTvya3QLyZ6y
         hsEGljbEa53K4AJg5YnrbPKZaYG1iC9RkAlcag+hbLsW1Scm2TUahEgMyK2FM2xh6KbK
         +f9mJNCPt3qgs043xveGMj57KJ+bKtMIKYIGvN1OeytYuSOiAjzro0aTvDfWZY6cvHpJ
         J+Y4QJVYkE2fCvO3n9zvzRQhtF/PFYrHtIKQIAL597a7644PMsziFHPZHmWbS/VLCYjM
         Q/RQHsDR6pkJUtvlK10zPVXkmyTg+HBFuDDYSd9FlCCcOkJ98QFn+Zp/1OrMBxLQPHOp
         E8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238924; x=1722843724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAIaWbMrpjXJfyBx3wUp/7AwV6TpyTkOy0qtsR/TmP0=;
        b=MlNxdPGxLBP/5e0ScdxRJbQ25jC0Qq95PJ06NxeCl46nzqlrjkjerMOVfDJRCe4xyZ
         DzD1aAHhMJt8pSNPXJtKM56K5Jp/yUnKIrrdQwoGGVRhM9lyrTgdHUnq8aBr+voJQlRA
         Fv0OkjZDyCFxmeXCGoy7wSA6BMVsMvjP3cAb0Mtp4EmdOy8x1O/92+a5IaaVnOzL1Xhy
         leI0UevZ3wJlLuMm6qfnG2MzQFQLQ99hL4/p7a96FW4PenzaM7zbCPyKADGFOowEjsZJ
         pyz4RKY/ZSZO9dxwNkBLfqqZZIcmJAUyL22UQxJr+M58X2nJVDDY/VX4pEWSGKQwnRvb
         5ocw==
X-Forwarded-Encrypted: i=1; AJvYcCXHnYLEIKKMfTf071UKpu8hMftQZgzRY77CPExJ/YAK/CDw4/8C/Uz8ql6en+biOBYJaNuW0rhjXyimThesiZjIWVFNG77bE2KPXFBW
X-Gm-Message-State: AOJu0YzETp59BZLni3OJYpJX0ePqdO1Mpya441ujv8j7Lq2KZ6KIXPls
	RN2+8r2Bttt+mnPxGEBZ+LScTAOGQaBTiaEZawVckkJQQTI64bfdLFaGQFEvMBE=
X-Google-Smtp-Source: AGHT+IH5VOb2By5fvQgwUidv6itqAL+m7XZx78fWcb+U56lzBj0h4lRoNhgztytGNkLGm+Y+RWX3Rg==
X-Received: by 2002:a5d:69d1:0:b0:368:71e9:4ee3 with SMTP id ffacd0b85a97d-36b5ceef41bmr4980043f8f.18.1722238924576;
        Mon, 29 Jul 2024 00:42:04 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:42:04 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source
Date: Mon, 29 Jul 2024 09:41:34 +0200
Message-ID: <20240729074135.3850634-7-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729074135.3850634-1-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 8c36e56f4138..f0f6b7650233 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -153,6 +153,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -165,6 +166,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 };
-- 
2.45.2


