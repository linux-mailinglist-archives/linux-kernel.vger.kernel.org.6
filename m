Return-Path: <linux-kernel+bounces-224517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA091237C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A5DB24EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F617B514;
	Fri, 21 Jun 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e8GGMkk+"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745817B439
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969024; cv=none; b=H6EysfG5RTX9RmGjwSaE87jeiY1LDP3w6WAm5wa7g9ZOAi2vXxWlLnWMEXNl3FGd42nbrcCEvciqOnf/WdBFCvcOsl3opQTgntQe/sJmpJ8QRpwbrtf7h1l2x8pIR1bIJBTkc85U41FUf4suWU3X0yuqs3XD0ZduQ+Q2ZkCqLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969024; c=relaxed/simple;
	bh=n02VnI1z3Lo/vCVvdYX3gNJ/na1w3LKQu6cqOd+GMII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxMqy4NeIH81GQZUu5Vz6YgiaibWDztA5S4tUgkuoZD4BDdaGvL9cOg4P9nwKYspe+3UtEqkE4ikpwdqUUurke31V4cNbHXJ+Cyp745VV8mRrmOO4JLKWgRQh0M+PWbg/cuOORjB87f658YA0uUJ4q6orzzBbP0My02nRHWGUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e8GGMkk+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f7720e6e8so226089566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718969021; x=1719573821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veIrjSKIW0msyP1BPKwCOv7rRYyO3ebgm2ScapHwacw=;
        b=e8GGMkk+MEXMMx8ecWdrmUcnfitLVwhwuDlqjvGYpUyGhaWvRXyN5hdsYkLxR7tuV1
         IuxOuTN7n8C/W6q8+nERUdyT7V/jcGADm4gRzAneS+IkzEAxyJSSciw2rwOxAi3LmpzY
         ajVubbLI+apSF3iG7ocIzwYsbcVXO9EB1er0xxTY/3JmfhNZQYeGC5yEUZGQJffmVGI4
         3Ymvez3WGcJ1juZQ0TVoJI/ywBLAmc508wv2kQE0naQuF1ni/bTnnCRYx+NcpnGHaHj6
         AlqSrHwEmsKSxrXxk+caxlBNtZAO8qJPJgJL5mKPq9kypOiiK7xqbY2H5MVCSy43L9NN
         cOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969021; x=1719573821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veIrjSKIW0msyP1BPKwCOv7rRYyO3ebgm2ScapHwacw=;
        b=mKqea3y7fe19/OJRiy8KpGDjGn9dCAMV1IM6h4sl484CmuLuu0MnCwMch72JF+e6rL
         09DSoIXZEIudMkox8oXBfaF4zMl5qRJ2rEvcqZsMHvX/oeXAPheyP3+7SAL6TyI1Hh9U
         uBEfHm81UDD88AekkJ+UM2FCQoiCex7ldrICHtDGAdNKCdhNhi27ceCV5NiYjRJ3yEGI
         ss9pKUtUfqdDIlDeuHbXd96zapD/lfgzUwF71GnAGotUOMfvBKZy8K7CLSixAvXQW4xo
         caDOpFZ5Rd7NrhnSv+n2VK3K/ay0PgwVlMyBu2tS9dTmgnLYPs8F8Ct7oXF4e4C8Wet+
         v/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYnQI0VbX2DHbkPp32EnahTVlKeZ4k4Kmr4btg0id+oMxjuuS+Lga0sZHX3PJm/AqeItoElxO9U2NmgPi8/+JkhD5k+WBIicxlvenA
X-Gm-Message-State: AOJu0YwO+Tav7WAT/xqRmyHh8yy98rAgQcEdBM7KRFXe/Yy0bP8OmHDK
	YuE5T0jyajcHeP8Hu+q+bwyQlciqeinmkE2ToDW0KJQNAWuMzvb+wcfGv7FATsg=
X-Google-Smtp-Source: AGHT+IEEH1uXQ9SWBQpZ3LT5PHwfn4wvDC947Dj2o3fom2F9AP5MXqF9KQPaa6c5ngH5rqOd6vpGow==
X-Received: by 2002:a17:907:ca1b:b0:a63:49d3:e1c5 with SMTP id a640c23a62f3a-a6fab7d6a8emr476914666b.64.1718969021696;
        Fri, 21 Jun 2024 04:23:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fd0838345sm64498466b.99.2024.06.21.04.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:23:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 12/12] arm64: dts: renesas: rzg3s-smarc-som: Enable i2c1 node
Date: Fri, 21 Jun 2024 14:23:03 +0300
Message-Id: <20240621112303.1607621-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112303.1607621-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240621112303.1607621-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable i2c1 node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 8a3d302f1535..21bfa4e03972 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -32,6 +32,7 @@ / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
 
 	aliases {
+		i2c1 = &i2c1;
 		mmc0 = &sdhi0;
 #if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
@@ -150,6 +151,10 @@ &extal_clk {
 	clock-frequency = <24000000>;
 };
 
+&i2c1 {
+	status = "okay";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.39.2


