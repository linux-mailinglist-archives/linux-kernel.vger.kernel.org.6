Return-Path: <linux-kernel+bounces-575502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E629A7034A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C7B1692C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D7259CA2;
	Tue, 25 Mar 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VuaB9wZk"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607E1DE3D9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912004; cv=none; b=JGlXai//38XPdOr2q74Wh89EpsThp/zMbh48CaJ/ogajSHSnAlFVkcs0PB+hjpfv4wckR28nxrPQen979s+m0vqvSTlptNIKnuBbngqrxqj/fB8Ar8JteWlmpRHaTcAuTD0tJO9TCOvsPl9wjBgowEFb9u937dkUM211gA8udes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912004; c=relaxed/simple;
	bh=D2seTNqsA+k60CiwsBqeP8HOf191uyBjDvtVghGiw5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPJZk/bhkrF0u8V7ROz90WEZh6Cz5y/y0JCFq3CHacTiurXewLlCz8f/yFu9CuyHW+3uCrAqVK+fIUjfjYNuvUabH6tHrObR3aCuP+2FJsG1oO7EYAoFsXTQ6el+VJnJqkXF+QzDNeCI6eW/TXDSwQLi58bdHuLOrGjltJC6nWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VuaB9wZk; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E9E93F698
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742912001;
	bh=z1YltY4DUAOKhOrYaqFTN+9X4KCj1NX0eIOCMrmZPFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=VuaB9wZkFSrFKLMp0YLB3p7Lg8565jTL5BN9n4l/tnb+EAf4DUyOElgbjrlSwhYni
	 oIVZDA8aDuonS2/hirCOE8nHiql9r+RBnsF+vuSAcYtyOLTu1VnjglygYl7wXWEwsA
	 KyUKtUF7IXPGiK4Nf20xQVn+4jzHlguk9+6SmfVg9Ls4un5sqXGiGQaJDi+T+KL1MC
	 tKmEQhYlPW6stkt9wZSkosTL6Krp1rUdIKNHDrXR4FU2KEyKHcjkSErIIoftz+wYHu
	 ADivB5O8ugMlXU2B1PQ7R37FGOFHvqDKR7eIfSjs5VVO+DpM3NqY7p9E2KyPPxXQAb
	 MPcpddYBH8NHw==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912d5f6689so2963596f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912000; x=1743516800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1YltY4DUAOKhOrYaqFTN+9X4KCj1NX0eIOCMrmZPFU=;
        b=rjsp0NReWtFuNGISJ+fo9IX5MKQh7PIZ07Tterlng1ALiK1isQpvTruzbXaXU6a0+F
         vhwXDpFUFk0pN/5dVfUZJnkZkMyZUvWxvHgDGqTdO3IY/mK2Sfzp0MYC+1Ugr2LGkqyA
         BId6wReZgBTgM9S0uq0tPrZO/mttT4NdK+KDcRCS7i6J6JoBsp0O1s8iHgY/7rPe9NRc
         Rn0NHYuoOyoPCbW25SFExLKKXJmrLBlV4woAoMMutxTalnO1zg+8In/1Uupq++vesdrc
         M4Ta+w3/bYoikqzvbyKdlQYhsTdi6isAB8MEnGudZ9vU1VB5nv4J/BPfeIk5ievOzeEm
         cMaA==
X-Forwarded-Encrypted: i=1; AJvYcCUntCA7MwSWUBA0SjeULhfnA4BpRViXL+5fif9z5PRPzNo+L0ofdWPeS1hU0EG3qvzW3PatFPN/v0Hpv0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmRhxEmM3+JgfMsVHe/lPyqIkLnGGykNMvstrIYfTYV7YuYpd
	b1v7JJyKMCWj/Nxorup+4WFj0EfLwGWdJTE53Ofq8lXOHxFGRth3xJEV0UCU5WTemlewvwozonG
	5XuipYHiKR1mnV05vzQUS2IqvnCs6Gi10CZI0k3SXJxrNvAnc7YBcHT4C4v2BML94kKIiUSlXtt
	MYRw==
X-Gm-Gg: ASbGncvCgKysgYIv7fRdgIn84u96ftB5shMQcx+ZyfN4fSrMFu+etRHb9IlSLJMzCP+
	JGlOep6GxKbsgWUB+7GwwlaAmBHq2OzDj1y+vwoxUPz612eFXYyVxLUNZ4Z34TGj61W7kHAbH+C
	eQeQYUfW8amSkD2HTvHlEkORZ1fJuCrlXxOgYDh3oRSOqXBZ/hhJqwlAgVGqC+8N3gH3YdgqmCJ
	y6SHNWq2u6X2X2YYm8nq+9HJy28v13xipNgk8iRzSSZrSBL573VVKW/Yb8FOQXDVV/keE/4euoP
	xYX40alrV6LW5J2N9IWw9aOjcHogoA==
X-Received: by 2002:a5d:64c3:0:b0:391:4bcb:828f with SMTP id ffacd0b85a97d-3997f903714mr13947092f8f.14.1742911999489;
        Tue, 25 Mar 2025 07:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI6KEgZoCtSliU6E0BwKfVc69vn7sSR/m3U6awSJRdbl6af8gLXmNSZGr1/IgpSiG8Z6CDew==
X-Received: by 2002:a5d:64c3:0:b0:391:4bcb:828f with SMTP id ffacd0b85a97d-3997f903714mr13947058f8f.14.1742911999075;
        Tue, 25 Mar 2025 07:13:19 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13532091f8f.29.2025.03.25.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:13:18 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Min Lin <linmin@eswincomputing.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH 4/4] riscv: dts: eswin: Add HiFive Premier UART pin control
Date: Tue, 25 Mar 2025 15:13:06 +0100
Message-ID: <20250325141311.758787-5-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
References: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pin control for UART0 and UART2 in the HiFive Premier P550 device
tree.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 131ed1fc6b2e..c278695dcb2d 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -20,10 +20,56 @@ chosen {
 	};
 };
 
+&pinctrl {
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pins = "UART0_TX";
+			function = "uart";
+			bias-disable;
+			drive-strength-microamp = <6700>;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		rx-pins {
+			pins = "UART0_RX";
+			function = "uart";
+			bias-disable;
+			drive-strength-microamp = <6700>;
+			input-enable;
+			input-schmitt-disable;
+		};
+	};
+
+	uart2_pins: uart2-0 {
+		tx-pins {
+			pins = "UART2_TX";
+			function = "uart";
+			bias-disable;
+			drive-strength-microamp = <6700>;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		rx-pins {
+			pins = "UART2_RX";
+			function = "uart";
+			bias-disable;
+			drive-strength-microamp = <6700>;
+			input-enable;
+			input-schmitt-disable;
+		};
+	};
+};
+
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
 &uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
 	status = "okay";
 };
-- 
2.43.0


