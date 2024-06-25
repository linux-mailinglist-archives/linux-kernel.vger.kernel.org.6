Return-Path: <linux-kernel+bounces-228812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDF91675F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2404AB255B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCC16EB78;
	Tue, 25 Jun 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j8arj/u/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9E16D9DA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317690; cv=none; b=qiBHsobhKY+P8zZ7KwLNtDHQyAAxIuWsD3BpYu7pC6XMEstgDpCHLd2h0DlB/v2c5hL0oFzytHYEt/L6GVQHOkFYhM57O5jWfnkBcv1R2oSE6kAQn8rTumBvjDXgNRnH7zgIVZbmFb+aayLaOPOLnhgp4S5UGPj7j3QRiltCieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317690; c=relaxed/simple;
	bh=d+cxdUc/kawXknja28l908DWiM43QePkYourTSwGSCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ab7wN5H8nj8hjzpbwzPba4lsRLaaPbytyY4bXT/yAt4qRNMNJ4CmjplpQKhjZj8OWTTvv2LFcf71nXPlXTbO9E3vVzldTYBLM/ctmHxhavWQOxnAZg1Nt8XdURpP4CYNo8M55NB4qSdzj8e/hYEB3U1mbA1V7gbHlO/5RNz+kYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j8arj/u/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3645e9839b3so4213934f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719317686; x=1719922486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSaReodlEhPLrYROJulVi8oEC9WlvggFVpDF15BFghc=;
        b=j8arj/u/PgfR3VVw60l7In0l1XMmp5o3JLdEnP+w0Mvx01+zcQsS3r2NgqaBbCoRsr
         RCKbSynZAIlzfX3TS2Vp5C0bcQOVRYj2X9RnochMvFjel1xWS+q+w8C57jwvQoRDRYbu
         +v5K2pttdStEVOkgAborIYvd/P3Zbvjo7FjFctSxhFUS/hgRLO4U5QLFuFzVk1nU+pYw
         zNUXmJFiw5rqkNURJzE+McjmU5xFObWPS4wS8/cWOu5yrzN+jkZu2LUkhV1ED7Rd3BSV
         IOF6WoiJnev0u0rIGRG5ZULpO4O6qp7JiyF7jRV8qUgoSV4lNHHKGw5ooO0ZiSTTZUzf
         YxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317686; x=1719922486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSaReodlEhPLrYROJulVi8oEC9WlvggFVpDF15BFghc=;
        b=WFqBErPNiypuWOf/A2l7sZIrDV7QAMxiPyJiKu/8p5ELgfw3uJTaEauzO8/cZlKDG2
         U9VVjgQf7pDTr43/carq5oUgGmVeItA5ggjSv4XypV+61RcN1zb9jcyjR0jhNNO05ma1
         ar0uR8af4T5JRjvMPqY5HnTxng4BA1LULpR2xWc4UvvvvYPG1vYWMi6PCcpOqUL7L3b5
         /gPbDwWeo046u820LMbX9Ufy6yatZ7iJVjYkuzYcYgCefo7pspZD9W6+0Mqtj/wpRnTf
         Q/sgkKsKlEhkPKPm18R2PQoso+QlezxOp/uI7eIcPFu1Eqf+8LczXcSHxvwTS8r/fNEn
         qTCg==
X-Forwarded-Encrypted: i=1; AJvYcCUbSajz31oK5V0IbIarMjFyPjLPJQbuovCVeLhpP5KifLm+XWQ8MpUNhgV+1EINAER38NzpWr+Px5L+ofBZaavwCjPRp9eTHxOHn7A+
X-Gm-Message-State: AOJu0YwgKKdNfiVjlJThS2p33QKIfJiqx6d4YjmLNF/EgurYawdpJv0e
	8vbgTqPN0EF4YkNft9wZUdnUALAAJSHMzSrUzmzQRkCfAgMiCT7HXadD3GmlM4s=
X-Google-Smtp-Source: AGHT+IEYBeG/knw9uoE5gl1YMNW1sVyFEHk5gBsye8670o9+6zQy6z/xZPkF9T+W23ZQtZ/7hVx1gQ==
X-Received: by 2002:a5d:4112:0:b0:362:41a4:974a with SMTP id ffacd0b85a97d-366e7a52149mr4911034f8f.66.1719317686218;
        Tue, 25 Jun 2024 05:14:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b32sm12798437f8f.92.2024.06.25.05.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:14:41 -0700 (PDT)
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
Subject: [PATCH v2 11/12] arm64: dts: renesas: rzg3s-smarc: Enable i2c0 node
Date: Tue, 25 Jun 2024 15:13:57 +0300
Message-Id: <20240625121358.590547-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable i2c0 node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index deb2ad37bb2e..7945d44e6ee1 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
 		serial0 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -66,6 +67,12 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <1000000>;
+};
+
 &pinctrl {
 	key-1-gpio-hog {
 		gpio-hog;
-- 
2.39.2


