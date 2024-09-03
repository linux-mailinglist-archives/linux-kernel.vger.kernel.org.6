Return-Path: <linux-kernel+bounces-312153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B59692C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D2A1F227CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58E1CFEBE;
	Tue,  3 Sep 2024 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Pg2VNCf6"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03121CF287
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336540; cv=none; b=UjL3iG+BxvuReCNl0p5TNDLjq8UYpFzMo5X6oeR/VOt3i+HZ6IfiiF+EkS2xnFxe9SUy2p/NaAQZ69L/4R4H11vUj/TCqzBv0z2T3iu/1tE3Y633CMsLvYJJLpF74ksdzK5P7AXp1lq6j4zXcu/BUucYF+2IdabuUa29DfaH8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336540; c=relaxed/simple;
	bh=nuMvhK4B2YL1JqNj2MIqtLUPJEThULLYeQBNub/zOuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BI2dKL3fUTt3SzfQaUztErFv2Z6DqQCcmQ0vB3VaFECl0OV/y61nNItAc62SBnxek2P7ml69DyYvAMCEakHAN0fG2qTFsDtrWVnZK2a3io0JQ+PG1y49ES1F0gfb3PSM2Cs5OZqRt/fX5HoPBYMbr4HhJl8YDrtoYkU0uE+V01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Pg2VNCf6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3df0c80286dso2583200b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1725336538; x=1725941338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/oLJOaGdN8OJwPD6NoJC1cI8myFT/cKMaiS1JkV6LQ=;
        b=Pg2VNCf6FZWxK32xsBNPiUlm56gpjT8sq82A0gaab9kXBU3vQ5xlL0f0tzGxq7YSxl
         G0ZoXWxlvzPWH+SDuomlgj3I212F45KTfngcRiWqDe22vcHMt5Yj2ukF4Ietdw/aJy+d
         Bty0X3YPVXyC/6kbH8mmk8fUfdCmtJIMpVad4/5fw7rIT9zEXIF9Za63VHRX+8Ag248W
         WD4QdH7UClkCzBxngrpfAeo4dGu25p2GA8KOlYcFlKyJMeMTFembIq0QOZupTKJ327eV
         SHdhVvd+TU4CJ2mYZBPp4SfxmV+72aDRtIBGFM78FHKVBiYFZYBDbqNSwYIE/W+jcpqN
         ZQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336538; x=1725941338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/oLJOaGdN8OJwPD6NoJC1cI8myFT/cKMaiS1JkV6LQ=;
        b=Pd71jkZ0reNpPsUtXHbmx/JefU820tyKgMgCJHQz9/qOFnC4y5N1CD/gC104HsDz77
         V5dYBtz222Mnx/vDi/m1oMHqiYiPObR+iAWmgDovRPhn8rqTTvKE+xrsLJtGw+1RPjZy
         UCKWe7vLsNwIowp/NfyZLsi02mfoFyirfdQDK4XQC/8I7vYLalIsKC5aQYHBcfEc9ZeQ
         z/2eizO3VIu6mJsF8Cz3G4FPOEHZ05AuvuY+brIzpc9GGaBtiEprA+Sl4epfNCGr4i8E
         jdI1kUZULwSM1qXosbfkzeGSHrvLea5pUCCROu8rkKh8DAI1KJKLF0u/Wb3+DgV1wh94
         iV5w==
X-Forwarded-Encrypted: i=1; AJvYcCXaZSpU/1dBzhQFIEcAg1YkLVqlLdhpQD7UXMiBX8q4ZTkfdcraQRFwkWdULMn34Z87maT4uXh5fmi+aFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7K+laBMjhX1x591vDV/wrISrOuEHCpgEAUGYxFSXd+HQVQVD
	y3xqNssNEIPB1VClCBdl0excNHH+GCPuFmUh3qA4ktoK0ueiQDi6E3Kks5QndSw=
X-Google-Smtp-Source: AGHT+IF4Vcbt1Npkx/U99wloObm9G5U1BlPYaDyyX/50VU3RDtGSJuZqS+ffOtv1ZRWb0VgYf78IAg==
X-Received: by 2002:a05:6808:2f15:b0:3da:ab89:a805 with SMTP id 5614622812f47-3df1c0cb8a9mr14135311b6e.16.1725336538055;
        Mon, 02 Sep 2024 21:08:58 -0700 (PDT)
Received: from [127.0.1.1] (75-164-215-68.ptld.qwest.net. [75.164.215.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef39sm7532701b3a.122.2024.09.02.21.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:08:57 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 02 Sep 2024 21:06:59 -0700
Subject: [PATCH 6/8] riscv: dts: thead: Add Lichee Pi 4M GPIO line names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-th1520-pinctrl-v1-6-639bf83ef50a@tenstorrent.com>
References: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
In-Reply-To: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add names for the GPIO00-GPIO14 lines of the SO-DIMM module.

Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 530648ad64f6..276f7e8a2c9b 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -41,6 +41,12 @@ &uart_sclk {
 	clock-frequency = <100000000>;
 };
 
+&aogpio {
+	gpio-line-names = "", "", "",
+			  "GPIO00",
+			  "GPIO04";
+};
+
 &dmac0 {
 	status = "okay";
 };
@@ -60,3 +66,36 @@ &sdio0 {
 	max-frequency = <198000000>;
 	status = "okay";
 };
+
+&gpio0 {
+	gpio-line-names = "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "",
+			  "GPIO07",
+			  "GPIO08",
+			  "",
+			  "GPIO01",
+			  "GPIO02";
+};
+
+&gpio1 {
+	gpio-line-names = "", "", "",
+			  "GPIO11",
+			  "GPIO12",
+			  "GPIO13",
+			  "GPIO14",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "",
+			  "GPIO06";
+};
+
+&gpio2 {
+	gpio-line-names = "GPIO03",
+			  "GPIO05";
+};
+
+&gpio3 {
+	gpio-line-names = "", "",
+			  "GPIO09",
+			  "GPIO10";
+};

-- 
2.34.1


