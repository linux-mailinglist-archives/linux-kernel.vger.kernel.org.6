Return-Path: <linux-kernel+bounces-434934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B039E6D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58C0282EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1D206F3C;
	Fri,  6 Dec 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IGUkLjZj"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D28206F11
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483665; cv=none; b=QYyyNBZYldieyaJ1YcRqfrTNQG3ZKCjNVxEYe7VGmTgqlkoS7i/XJpzAyOOVkqpAP71bd8PSWRIdrOrmuxfHLQwPMBl6WnxZ3Gvhc84b1hGiO9JL7riY1gv9NChLkRJRzgnD0mCVt6Nncdsf9os1qh02VLkslHRm6JjJQ1o0ZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483665; c=relaxed/simple;
	bh=a4/gsQVtR7MVHM1KJuAuPMWGtk0F3Gae6xSRbB+vIWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IFpBnMGsrLlPP7yl9Do6zCVjOBGkV6fr84xuiYniHPijtCKd6bVid99/YmH+v917L4zD2bIuzcEwqI9AcbPD3CrPBHVgXzgDMt+45Ibud12YzEhDA2M2NvRZVvrFMB6IJOpdisY4wjpnHbrPuwnAA7DZmg/cEZDuDqdYYS6LqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IGUkLjZj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa62f0cb198so197914866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483661; x=1734088461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9Dnr8lBPRV9hwY5+L6VmdONZwzLphVT7+zA8FZuSvc=;
        b=IGUkLjZjdXavSltmBn7WJKCt7ZmfqpeDzq+c8eJyOQNUX4pmJzPPgbOzPqDCz+QuVr
         0Ee0ApCmiF9L5o970PXWXaFksLDbsPONJoXANY1yjBKK15S8LoRwv4yaI96oTxeBqJo2
         Yr+gjDZ2FhW1Kh/GXVTV7lOFJ5gypIS301DAgBcVqqqsEkmOy52N31+BTOmEd/w4lLyV
         bSuerh/gR7UOtBdU5HxbeKm1lP8vXbSByk1US73myzpL1FAp+lFZ5EzLpOngyAbGRIu/
         VC2PirSXVrkC6aPm57d0vKHq/bjE+wVAIULPleREHmFcG5WpkgNHfVv27jaeWKhyDKH2
         hA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483661; x=1734088461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9Dnr8lBPRV9hwY5+L6VmdONZwzLphVT7+zA8FZuSvc=;
        b=gMbjtJzm8UDkZY05XR89qY+G9yGDhb6uIzoTQaqRBAWOQr5N31aSzKCRQlpLyKHvy6
         09mUrqaUeMcVvD/nTQh4DkmXyWMn41YMqyeYoKYk8/9tJRktWPVWyir2IcoKfFEWzlKC
         kWuW+dkl5fnC2O0vgfnsmQiMq3wymCIaVpTpWsVHqj5Of+AtzViEUyCr3SWwisjxPHJa
         BL76+GRuUpnjNWnUts4ssKmvzK+vsnUab7qvwDIv5Y7lU9ETLolCiNwo0w8il4sWAjqO
         qLPDyvaqFudwgSejVlTp2K8oOU5hpzjOEwYQjsQoq9bK8WxbQf98KaDYZHxXQBVQWzpt
         5LxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS8RAv8QcBFtt0xV575mgRDoL6qtaGWtXjA9poJK83YQSExNuBZYciht43wtBLXsGDBdpwhBJ6qniR/D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uQCVTCCOgIB5a7AXJl71I791sFYR5L/PDDGgwJB9v+OohL47
	78qfXUG3Qm1SdKu1CFtXig3GKjAOGsIi8vuadztXONkL4mpe8uC9U5EYt0VfJtY=
X-Gm-Gg: ASbGncucax/DK39QSvmbxsVN/5yT7j+IZ3mpp6B28qoB1rnIfAThFM7aJ5nxIlpYXIY
	lrwtDU6GTVdxVva7qSONICbKN86ps2ox6CGayuz+59i2JX9rF32oOH+pwjmqA38SsFAN3jlQdvN
	96twW2kg41tU7JHSw2n2JNKnoiO6oWMi9LzRXWJr5E2G1dQXsV2/QaVfZhVyYNqJFOPVqVx4HFB
	KhBFDP/jZ4wAhKpuYcf2mKT/OqHmyNJATcEEpfmvxv7D/7ZjZeeU80dd+n+CbX3TgdmcjEwcNgA
	p9+4
X-Google-Smtp-Source: AGHT+IG7gJqc4CGdANniAawsf3QrNvInv7nJ0Q0Fqm3FfT2wXTQhceZu1E4SlHPGcY841V3MyHiZiw==
X-Received: by 2002:a17:906:4d2:b0:aa6:2e07:5cf2 with SMTP id a640c23a62f3a-aa63a2086e0mr165912666b.38.1733483661317;
        Fri, 06 Dec 2024 03:14:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 15/15] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Fri,  6 Dec 2024 13:13:37 +0200
Message-Id: <20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..57ebdfc858eb 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -94,6 +94,10 @@ vcc_sdhi2: regulator2 {
 	};
 };
 
+&adc {
+	status = "okay";
+};
+
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.39.2


