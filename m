Return-Path: <linux-kernel+bounces-225403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17977913032
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA78285BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB017E446;
	Fri, 21 Jun 2024 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yjKw0Zra"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8017D8A5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007933; cv=none; b=upxhEfQnCihP1pTXTJDGYIXKrdObhbcy6qTAlM/ntssi32zBa2yk5ZOwRXpETBcJvJOvXdIeTfmTwspktgpi/BZ1KEBm+iJD0Rmw1AFs/0T4I21+t2Fgq+YcC4mXyX42OQ3lC/cQAPr5bWZkInq1t/exreVQgzBaja3xgtG+KOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007933; c=relaxed/simple;
	bh=Hd804EsqY+6I5Z5ZLAo38Drm9L7SmEuPKrJEaQ0erYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alknj0Bd87vrA9mLbyVqZXJ8wTvW5/40+c837ADDZ09dadCks62owiSlb1HedEkrbY/hLe3Jy1eAvgBYZ9m3KnlE4lS8tK1R7HM01GKBEq33Gv0HIDnrUR2xC1fydb4hX5Gl5fX1eUa2I+gGicg5uKNdP1WHybzEfbyY4qrCNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yjKw0Zra; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1b27e0a34so1177582eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007931; x=1719612731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPjR6392Ufeq3m10Ix6LPhMsFgNag95fnEsJNBcmUuQ=;
        b=yjKw0ZraxFDCM3heKm86yXaHUFpFnP/o0iyx62sZK/8RlX5dVSKbzkvkOpDSuqxGK9
         MwpX4UABDps++X/h5AfalUpCP23LoOTdmirOqtmxAGraLUbAFe1yHjo08+PJW7BAQTTj
         ji7kByeIosrnFMGo65A0YN0f1e0mV2z46va70SDeVbNd5CvgLoUH9mkemHYW3nFBMPGw
         kCoaoeuq4jnNt1jK5RM0DNzR55KxTH3hfOLRjyW9MwMRRCd1sazXU2IYk9LRia77V3dX
         AF/G6bYQKGvgNwoUHC+bTOnaIbyAcQ4FaOY6muGWTeJrjEQqglmhnxPG9f/WSqHa0l2x
         65NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007931; x=1719612731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPjR6392Ufeq3m10Ix6LPhMsFgNag95fnEsJNBcmUuQ=;
        b=Aahoe5Xf6s5JLFeM9mJInSV3EfJ4U62rfZJuOPgXTThMVcpDXLO9bQneiBYXJneOsL
         xde8vn57gcfGO2uZza0cZLDMz6DrQd8VLVEP+AP2RhI4SjA7maZtlFagIbrx2QicTzSX
         LYbFrJyLKD3CWqnQTp1ioteg6ahePCxykNoFbKy0O7c9kSEhAVoHaipfqMH016/JvhvI
         A3gutwu4eVW6SMPmS9Xt9lfGQxjIKEvb+vniNZ1R0TkEVPXYA30XzRCSqw0PdAkX8o9u
         3B6uVCVBz07uod0UxVT78bBp3kgdwvIP+zj6t3qe5CW7flYAEFFLBjJybgrVf134qIA1
         Pnig==
X-Forwarded-Encrypted: i=1; AJvYcCU8Jih7iWnX+pTRlLXi7JQm2dqbVSiWXn0UspXwsmSSbamlNy2/bSlwHkz4YF1Tl68ptuPbyyxsOlWhpZYwvwQahlKxEtRSwxRbkXo6
X-Gm-Message-State: AOJu0Yz8EjEMqpvlysaF/Ph3c3agiQeLhj5ouYskDwIH4IFodgj0kGQP
	uUA9xKv6eLcZpiDNyLKym6IWFdXkjgcsXisH/NtRDo8BCjkvL/G+bUN7Ep8KM/E=
X-Google-Smtp-Source: AGHT+IEZFPUw/XU0YHoyLTOHieCDVAaUFIHc6OhfOtS4ST7uXP3bkvHoDIBYZQsAHj40tSg6bAcgew==
X-Received: by 2002:a4a:8685:0:b0:5bd:c0b4:cf67 with SMTP id 006d021491bc7-5c1b8b70a84mr8390692eaf.1.1719007931232;
        Fri, 21 Jun 2024 15:12:11 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:57 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-10-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.
Error message is slightly changed since there is only one error return
now.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index ddc6c262f801..bd37d304ca70 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -857,15 +857,9 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 	return 0;
 }
 
-static void ad3552r_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad3552r_configure_device(struct ad3552r_desc *dac)
 {
 	struct device *dev = &dac->spi->dev;
-	struct regulator *vref;
 	int err, cnt = 0, voltage, delta = 100000;
 	u32 vals[2], val, ch;
 
@@ -874,30 +868,16 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
 				     "Error getting gpio ldac");
 
-	vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(vref)) {
-		if (PTR_ERR(vref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(vref),
-					     "Error getting vref");
+	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (voltage < 0 && voltage != -ENODEV)
+		return dev_err_probe(dev, voltage, "Error getting vref voltage\n");
 
+	if (voltage == -ENODEV) {
 		if (device_property_read_bool(dev, "adi,vref-out-en"))
 			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
 		else
 			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
 	} else {
-		err = regulator_enable(vref);
-		if (err) {
-			dev_err(dev, "Failed to enable external vref supply\n");
-			return err;
-		}
-
-		err = devm_add_action_or_reset(dev, ad3552r_reg_disable, vref);
-		if (err) {
-			regulator_disable(vref);
-			return err;
-		}
-
-		voltage = regulator_get_voltage(vref);
 		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
 			dev_warn(dev, "vref-supply must be 2.5V");
 			return -EINVAL;

-- 
2.45.2


