Return-Path: <linux-kernel+bounces-359615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B8998E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A1B2650D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2019CCFC;
	Thu, 10 Oct 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR2PiQCD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3C19CC0A;
	Thu, 10 Oct 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580323; cv=none; b=fJNBaVyoG6ooiu0KTkwLWsnsoq5JjoRFSEsrldGCgDeKybrDPSYTKRBnddQUvP/RKeX7B3thfdpe40wYfLM9IMLKIQ8obFuBtq+XGKrVdI3pIu2jCcNlpLanFLeqAczlmuRPJPvc60Ji/iHyKBK2Q38TKlFcG0QsctjAk427neY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580323; c=relaxed/simple;
	bh=+tZ0WZhlkSS0O5LQsA2Zhy12Oshwn7a9xwYnSW7Bi2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbTISLZF0qpzp/WCBuTPmABApO6zGah1mG2LAmcdBwRzoRFceVe9PIiVjwK3aItKO1nmuksuYyUv3xxG3FRgEkJxw3oRlQT7fiQW22xgtDWrWLEUBohZtBApToohDVTKLP+VM8SGIylRnJ9swxpaHGVcjzjPVJnmt94oJH5cHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR2PiQCD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dfc78d6ddso1074054b3a.0;
        Thu, 10 Oct 2024 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580321; x=1729185121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew6P9VD3bUbnWlUZQh0TrisKJPF+NxIhwQ05c71NA70=;
        b=jR2PiQCDDIAy+I7S+rn8/ozXj/bpPk0SNFkgBR/dbTl1tpNyHyqJ6Nibtm4cASxOGi
         OTAqMPzyltPDMK2HvCnGR0bFOlK4+Ifyx/TrKm/O5ZN94G3OCx+4br73dI8pc6eKmTPU
         qNmr/Uhlg964Ozl0jRb4ugmbi47ZPFrZaGjppUTrSfUtqFrPR+PqQ40lv8MEkDG0bbYH
         Hehi4xxO1/nxT1TLNh7J9rbawb+xgr/vaTczhO0SBRXJTxOjwb8C19o72Y+GX4nSCCLT
         DioZpM5K8NgsNA4p9u8QvBKQDXjPZxE0SpOw+0yszaJ+ZXbU6PJGn5LUZZSIsIzUlf2L
         M2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580321; x=1729185121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew6P9VD3bUbnWlUZQh0TrisKJPF+NxIhwQ05c71NA70=;
        b=EB7Tvnq5Po9ap4TAttLjasObVKu3ZBwiMH+m0txg813G0/OW+PrUDusbTOn+wjJcGn
         JcuMQABU1UQVgHuxkdelER81db0wbc7/2b7hn9fBsBAhM0FGqp3vJYQSBluIQsQ88KLY
         0LB0pR3VJUM3E+rpNwmQm+QOVOOnUaK75W9SLWjzJzeGSoeNdesRCFPKAy8rMjROEHzp
         sX3pdwOIa+P+HcYGcg5In41W2s5HaIwwU1/JU54+0YOBHaOLGDWfzg1dDqvT18AVyU6z
         sFKfWDyi4f6QPAu6LyckoGL0etpGE6aWI6u7y8NXXbY45e8QQE1oI9yNDq7DkQnUjTgt
         QZoA==
X-Forwarded-Encrypted: i=1; AJvYcCUO1FZev4lF/a2Xh1e2AspibMH7k1vZ+jVaeWKT5oWj+nvrLA0LEwoVGTdE9O2Wzj8Fqm2KqsqTVsYZpNZs@vger.kernel.org, AJvYcCVLqNkMkk0wXEWVNLgJGuMj8mrbtGGvHtNVttPeyr8uiq6EALnIcGeVcC/KjLFT/Ak5SWJcHd+6Tqf2@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUeTn4ELlcH3EzE0U9N2+cfECZoQVPfEBtildv3SAzltGOdx7
	g1FH9TJ4xCwE1vXc8vKeKVtcRXWL+/9lfnVbivoE6mpWmweC/zc9EO4o+cCx
X-Google-Smtp-Source: AGHT+IFoe4AiBwF4qqm0EwKF3j3qdjAMpwNSuyGy9YP4hjUcQPxBCEe2tbcL+cA0HqjjNPR64AfJ7A==
X-Received: by 2002:a05:6a20:c890:b0:1d6:d2c7:ac59 with SMTP id adf61e73a8af0-1d8a3c001c2mr13205513637.12.1728580321344;
        Thu, 10 Oct 2024 10:12:01 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5d3sm1251245b3a.198.2024.10.10.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:12:00 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2 1/3] ARM: dts: imx6qdl-apalis: Update audio card name
Date: Thu, 10 Oct 2024 14:11:26 -0300
Message-Id: <20241010171128.107819-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010171128.107819-1-hiagofranco@gmail.com>
References: <20241010171128.107819-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Update the audio card name for Apalis iMX6 to match its specific SoM
name, making it less than 15 characters to fix the following warning

fsl-asoc-card sound: ASoC: driver name too long 'imx6q-apalis-sgtl5000'
-> 'imx6q-apalis-sg'

making it compliant with the ALSA configuration specification [1].

While this is a breaking change for userspace tooling, it seems
time to implement it since no ALSA UCM or related configuration files
currently exist and we are in the the process of creating them.

[1] Documentation/sound/alsa-configuration.rst

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index edf55760a5c1..1c72da417011 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -191,7 +191,7 @@ sound {
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		model = "imx6q-apalis-sgtl5000";
+		model = "apalis-imx6";
 		mux-ext-port = <4>;
 		mux-int-port = <1>;
 		ssi-controller = <&ssi1>;
-- 
2.39.5


