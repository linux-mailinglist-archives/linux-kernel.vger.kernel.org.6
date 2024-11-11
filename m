Return-Path: <linux-kernel+bounces-403821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1239C3B44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CC5280E69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366E188717;
	Mon, 11 Nov 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyiqCCNB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F317C990;
	Mon, 11 Nov 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318367; cv=none; b=sJdhkmyLpVB9S8Qm6iV2cL0f34mhsLb9kiYLqZJdvw4YvRv41Ob8M2azOjscCCpNLyMSs+LdP7LiqiCtEQMee/eX/pgoh/Ofq5c4w0hIhTmhmyH3zkCQvuFQ0IunKVoTdfc4GDODOujwygNdwABepVX5aoJMuY9ffOe3OgXl130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318367; c=relaxed/simple;
	bh=Zoej5bs/m8hJTMD3G6AdGwEKkQ5iouMMeKxD1Smvb2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXVUVBK/7TF3LDUsCTDTu9kpqUkuCN+SGX3jqz1J/itTAnITXM7RcLwWQx9UCC8RXPDgbHXd6lKh5fcU8DbkAwrjIHQv9/6g+1p9W6qVvIA2nDgoMFntfOwKlWYMGuRlULh9B/SAYWaOiXeWl1EbW3GoFGUV3S4kw70HZJEM73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyiqCCNB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf6eea3c0so41527915ad.0;
        Mon, 11 Nov 2024 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318365; x=1731923165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=OyiqCCNB1jy7a81dA2JaZDvYUVKn4BSrIJlryQDyx4WHht2AkW0H4OdbwyNJ2bYwHk
         edMrLwtGAW9EZvi97xodPqP3n+B63oY+KkrwEbkd521fhOZNwJpiw3wsUoWDtQWHtaoy
         77Z8glK5sUKrdRznmHRwoC1RkLyG1QDykmDLZH9IKWVj9d7+eamP0W54vjmjyR8jCx0I
         7sPwCrE9cmqoJigHAgev+sBIYHBI4X6S/bRy73Z9fLGA5ccwEQND0Kvk/Hu1odybYPMD
         NBXWI8PNfHFqJ3oSdL+AKlSc2gUzxk6Zu/igUpc31FebxUUe1LFSQpS/BEerpeydj+qo
         BiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318365; x=1731923165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=vEAdq8FidasxXozYcXkR2vLonbALyILErluJkuaWsoUltChHiPzwfRnpm9/C51zsXn
         R4Yp6f6YscROqpE1PVOKblPAFbFGVywiO6MHvLZPVud2rPeIL2/E2n/x46uq9XYeGh4q
         Q6rSuWLUz5De+EkfjazOPkuymmZEXMNo0YVJ80a4IhWMN8quODfWcaOIQDqgtq4gNR1t
         wXn5AjT0mYsUelLid+2hm+e9xH8R0Uw90972gEWmXHdslkE/JYXRJeDLhrswgjB6GyaQ
         eN5v8HFgkC8XciUyCpNiPfVRubx7uja6QYsg/cIydFezykpTS56NLfdM5lu8hZ0QW/Mx
         o7rA==
X-Forwarded-Encrypted: i=1; AJvYcCUfdOMdpios/wqmIrlgXKRM11lcZEby4DhXt4QFhEzZWaXAvxjZCKuGLX1hzJAz9cx2kK5FGjYyDTYTbGB7@vger.kernel.org, AJvYcCVe4Ab1Dm19BGYBauClzG64EVE+cSw1v6TjgrsuGPPkjSuJzprn1bAPv13FxluYFfaCLuNnDpg1aNCz@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBLGmbmJqM27DCRKdEO97cuDdbwCBItDFsVrvjeFx95X3R3Y/
	jSVG/SnZfuMixYPpeC8wQ8LCuiSzPV9P+rKBOmiP702vqvWnL+Yl
X-Google-Smtp-Source: AGHT+IE1c5elCHCi3OEQodIARSHjGMgZMZMY65tQlUc5wZSO5OedFsdVLtGbaV9F3x5W+AiCReKDzg==
X-Received: by 2002:a17:903:2b08:b0:20c:f292:3a21 with SMTP id d9443c01a7336-21183507b88mr163069235ad.15.1731318365569;
        Mon, 11 Nov 2024 01:46:05 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:46:05 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: dts: aspeed: Harma: fan board io-expander
Date: Mon, 11 Nov 2024 17:43:49 +0800
Message-Id: <20241111094349.2894060-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fan board gpio io-expander to check fan board status.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 9d7e7208562b..58eba5fb6262 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -218,6 +218,25 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <116 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","fcb1-activate",
+		"","";
+	};
 };
 
 &i2c1 {
@@ -273,6 +292,25 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <114 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","fcb0-activate",
+		"","";
+	};
 };
 
 &i2c3 {
-- 
2.25.1


