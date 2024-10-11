Return-Path: <linux-kernel+bounces-361355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0926099A726
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F32285032
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0C1953A9;
	Fri, 11 Oct 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLPn8PK1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFF194A70;
	Fri, 11 Oct 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659156; cv=none; b=JAMUqt9Ez+MeZ4cO9M0YgaEKk8xSCDtG6A2wXRFp5XZUDzeBV4GmN+v4GtkEgIAX6X2H/r2Xamz35bf88RK/qyKflHM3b2KNoK+xHEZdazkmD+0Xnxf4RS1F5kgGoRvAsfkBGJIrD6U9XC2EQOvGX4KkXSXyZDj3ifrxJmZDtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659156; c=relaxed/simple;
	bh=LGVhaUUChqajyskYrQm9WHiHcIjADKr0XAo1qvMtYQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+zaKY90lRe1Q10S7DXmFXBcK63EToBxipnUON/h53A7Zyc+x1NkR2dSIwZYd/9V/jYwZkqh7gNnYMsu7ti8Sgwa7i83Qas1jXTMzKA2Y1F42hcsnObE63qNESnyqkbhz560rKUviZxQkRNBj6hRVIS+EqIQVDWrhiJDoGlTTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLPn8PK1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9953bdc341so207697666b.2;
        Fri, 11 Oct 2024 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659152; x=1729263952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9RR/LNdmVk5RE6b8H3OC/NCxgwdW3Avob2obi0lAvg=;
        b=hLPn8PK1r97TwirxSiY0TxVdKfiHBEjjh2VEien8zkj3zoJ093avcXyOJqs7ZNAdWE
         +gKiRpDAnKw3uQ7zNT8x9wq83YaveqajjBT5RSUxJLecgog2ZytuY7jizK0TAf8xok0K
         XX0vEDF66fzVc7QQAds4J/fq5OD6Wj5a/kNy2ophRYZsQ4h98c5EHWmaxc8yeUlGmfZH
         uoadj0I1a2HH23RosmamnqUtvYa0lOT8VP/O7+4f0AohzmF6xwjfQFcnO/TpaxYoYxr2
         pkWDbfewzxnKt7AUZrYKjrqsK9SIYzQRn4HljaJBmmYp1cKIbZEXtFXZk4hxjDJsPosb
         K8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659152; x=1729263952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9RR/LNdmVk5RE6b8H3OC/NCxgwdW3Avob2obi0lAvg=;
        b=v0G+csXCcSm21coNgpwBEwxmsuIMYzwFubUcRYf5FXJlSXrsYOnGKQE7yEvPkLGUrD
         FHjE9Izch3oqWrlzANke2TD5550jhnaApZco5PbV6+Ivz3MikCJDPvWh9Im9P2h3jJPu
         S3ESL7inahMm8Q4a9Md4ay61fzXtA94KRjqZM2VlF10LMQWvDuIkYvDjCzuY/4ecPDMW
         7tll3IjWyqH+WrOrpDUbEQJwaXQq27QU/WU0cWsw8EFVAxqXCVFoCjR0JWsq7taDLFDr
         wHq0zgC5s8xhqCz4FTOETk655TOlmRrnpu0jKGSLWnqg57MjPC+t8cJ+oO4iE7JAm57S
         iHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUtRNEMt9uz82xbEKE3rOKP/nd1gaWaUMoiM7K+tjh6mN+s39wEc8d7lgvm3gEqcS3TMc/gxGjFrdwaEkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvhXKu3GQmL3d3shPelrnePNLXviH7FVFC5npUKmr4Jf7lti0
	eMUy+89uXaWELJagbCBR423jaJQDbe5uwVllXAEsPvpcvU5jWOE2
X-Google-Smtp-Source: AGHT+IHTn+VL0X7tyXuVlxpt/mf2ksJlWhyQf3mF1ncv60BdLFcR+sjHrNcdVKotSY87pp+ieGaa1A==
X-Received: by 2002:a17:906:4788:b0:a99:44ef:5e6c with SMTP id a640c23a62f3a-a99b9585dbemr205597066b.48.1728659151953;
        Fri, 11 Oct 2024 08:05:51 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:05:51 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/6] arm64: dts: imx8-ss-audio: configure dsp node for rproc usage
Date: Fri, 11 Oct 2024 11:04:35 -0400
Message-Id: <20241011150439.4027-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The 'dsp' node is currently configured for running an
audio firmware. Since the firmware requires that some
audio-related IPs be disabled in Linux, this will clash
with the configurations from the imx8 board DTs
(i.e: imx8qm-mek, imx8qxp-mek, etc...), thus making the
dsp unusable (since the firmware won't function properly).

To avoid this issue, configure the 'dsp' node for rproc.
This way, users will be able to use the dsp alongside the
board-level audio configuration as long as the firmware
doesn't need the audio IPs.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index ff5df0fed9e9..a60ebb718789 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -431,22 +431,19 @@ dsp_ram_lpcg: clock-controller@59590000 {
 	};
 
 	dsp: dsp@596e8000 {
-		compatible = "fsl,imx8qxp-dsp";
+		compatible = "fsl,imx8qxp-hifi4";
 		reg = <0x596e8000 0x88000>;
 		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
 			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
 			 <&dsp_lpcg IMX_LPCG_CLK_7>;
 		clock-names = "ipg", "ocram", "core";
-		power-domains = <&pd IMX_SC_R_MU_13A>,
-			<&pd IMX_SC_R_MU_13B>,
-			<&pd IMX_SC_R_DSP>,
-			<&pd IMX_SC_R_DSP_RAM>;
-		mbox-names = "txdb0", "txdb1",
-			"rxdb0", "rxdb1";
-		mboxes = <&lsio_mu13 2 0>,
-			<&lsio_mu13 2 1>,
-			<&lsio_mu13 3 0>,
-			<&lsio_mu13 3 1>;
+		power-domains = <&pd IMX_SC_R_MU_13B>,
+				<&pd IMX_SC_R_MU_2A>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu13 0 0>,
+			 <&lsio_mu13 1 0>,
+			 <&lsio_mu13 3 0>;
+		firmware-name = "imx/dsp/hifi4.bin";
 		status = "disabled";
 	};
 
-- 
2.34.1


