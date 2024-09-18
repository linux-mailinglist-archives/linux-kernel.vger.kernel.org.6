Return-Path: <linux-kernel+bounces-332874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AA597C018
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81A72832D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6C1CB50B;
	Wed, 18 Sep 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQNiYUvE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90421CB332;
	Wed, 18 Sep 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683750; cv=none; b=QdC9dr6RPfNGQuUO0F6IifgmM23hYYeazDPkhB8uCQl/W1LFWwQ/CbW/8XMzS6tsYo6gdJHWc99tEN7OPHUwUp1fV43enOyOW2s2/c62t5vPJRJj1u/hAZwxYVUAaXrCs76Kln6MFXMb3y7pdvI07usx6zPKd1aZ4U8Fq0CE5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683750; c=relaxed/simple;
	bh=ecm5qBuobUxfLm11/z7zon/qPnxquqho/PMLTb6i/18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ay+V6bK9LXf7hN7QsbioEEJ/ySPIRTYgxn2Ltv/bzuEnegIU1KgBZGp2hIZUMVM+4fHmp/eWrKVTLjk2DP8IeuKp71u9j26jaTfO3yJBTK9nSwaRIdGLw2JmslaFEz7X4SfVlnBNQVP0Roesqst61wsglsQPajFe3hk0h5XcSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQNiYUvE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-535be093a43so9020689e87.3;
        Wed, 18 Sep 2024 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726683747; x=1727288547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b74DjBwDaiguwxZN4WPzTGxSSIqR5dICOz1TwKaf1Qk=;
        b=mQNiYUvECaNFoT5Lw1ie10V8ETT74QZHyY7/QZ5ULZaJSiSUzv1EAzZL1INtDxJtkF
         O4An6nxZ/vfjH+NQW60TVg283IdSWgKNMNzDzhE3mQACsApDoplBENoezrgiKaNXdWN6
         b+eGvB+AZVeYrn9bpkNPPcEeXM+CKZHFg4UEbNf6cEi42p1UCHeBZGvnWLN+wM+9m0Ud
         SY9ZQ+iaWEGqV7kQ9Z2ZfPhoD0wuVS95IdDnVe9F5FkYQmLRgv+cr/izRNDRGUQjQ1/0
         FYa+n2dtKG6Utv0YSUokAhSHtcLQPR8vcjO0yLVYFYT/6zllpu5HSA4QArWQgSiD3xp4
         6Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726683747; x=1727288547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b74DjBwDaiguwxZN4WPzTGxSSIqR5dICOz1TwKaf1Qk=;
        b=vVds5u7WFaJe7NxzISiiB2+o9HHmPNKKO/7fRJ+QpZK5pMAOOMlF7MExX5nxIpgPOW
         6yg6aouclwN6ag71mheQYPMlP7/eD/rp0J4JT5QzPB0D0cMim4HS33nNc/TueBAgAK9D
         C3krCRWVfhgesR1dSRIHVRuvVJsQynVyL76g5Obi4hAdb9JpeMZ24sPbsbDbL/bxY88Q
         7kBljwlybzbO1bn4YyAfEWAoMmJXAFi+BbIVd+NhLnIMu6gOvqFHpdwHlcypKufinET6
         7Oc9LYm4QZdfr1I3E1T2zuAR0ToKcwWk9GcSch+eZr0znsz5li6KEIC5T/P9KI8P28l6
         eQvg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ofWJrBKE2ySq8OyMUsuCYGrMRwkduAm95ptXeLqoZI6KpNyPhYZsQHRKSQqFBWMaPZmZQUc6cFar6zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTaQGJizzTR7qMJqtNAHMJDXgEQH0apwTh34h+VD3Gp8Z6TMg
	3HWxQExefrAjp2Vjom50+hCtjdL0qS0aQ+hzW4Vd1A3Rug17rfvL
X-Google-Smtp-Source: AGHT+IEgDcqWPZk6PODNPj/XhOHH/yFVmMsQL7IfvquOxjcmWF5SBcsMwOEuGAebdORj5/r29Zkppg==
X-Received: by 2002:a05:6512:2345:b0:533:4689:973c with SMTP id 2adb3069b0e04-53678fbaf3cmr10878410e87.23.1726683746810;
        Wed, 18 Sep 2024 11:22:26 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm5200146a12.23.2024.09.18.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:22:26 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8qm: enable dsp node for rproc usage
Date: Wed, 18 Sep 2024 14:21:17 -0400
Message-Id: <20240918182117.86221-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Set the status of the dsp node to "okay" and assign
its reserved memory regions.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6c..7ee69ce7b193 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
 			reg = <0 0x90400000 0 0x100000>;
 			no-map;
 		};
+
+		dsp_reserved: dsp@92400000 {
+			reg = <0 0x92400000 0 0x1000000>;
+			no-map;
+		};
+
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	lvds_backlight0: backlight-lvds0 {
@@ -640,6 +661,12 @@ &sai7 {
 	status = "okay";
 };
 
+&vpu_dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.34.1


