Return-Path: <linux-kernel+bounces-213310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8E90739B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8560E286F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93878145B0F;
	Thu, 13 Jun 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dVtQKdED"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7B145355
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285059; cv=none; b=gmU+maQXmAGk+B559Lc0dRPROr4oEuLUGdDW35ummg0HtSHtknTBWuEWd8rBTcWnfss5TdxGYCDxoZrO2XhviHIQod2sv4JY4jYaLWJvKWB6CEXtmUtSSRUjN+3rS5kyyKnr+u2mvHvMYA53pVAxgFJDhlLFbznvqxdW4R4/Fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285059; c=relaxed/simple;
	bh=rnldv7833XODCkkhE2IoJHX1ijFNhpuCcMgGUEpMC7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTXKi4fTnyK0Rhd3q+RkCsEgvnrhlD4toDylGPXqq4hB7Sl4OYK2gY3JxZnCrdMlXGAXprsTdIVKO7tSuEVEttmCEUYWIlSC9NLqbSBlzF2UjWc7PLzVPEWDb2TNGZfyt0G4D+Hbi0Mj0EK8JFwKdWFMz5QUt/bu2dE464I619E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dVtQKdED; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso11844505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718285056; x=1718889856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ3mx1HRwERqoH8XmiCBcC2qPne8ED2LI938/bq1eLA=;
        b=dVtQKdEDmWJhRc5J5qjUfL8DaZXdrdqZeBSpMsQcgTx7OhEmPo/A/H3GERSIrzUhf/
         NvmUs54kkXt7kLERWqk0cpe1owPb92fIwOzjwe9UmIvo26vaqB5Zb4lzPA7ymOLsW8MF
         Fku+erMegf/wSDFxSV1YfbHgtvGOlwxVIziNuwNrkyvtfdeh/pPBL3OQLGBpo0ITpOdT
         0JBJqfrWrUixz8Yhuj7X22XXxL4PXu2e7PC+pFl/J5Mpk4yLdGdTddFAmDFshUq2iwQm
         tDvREFDxXWywgDSYN3g716Ty8pdbe3ms24foPqM+bXE17693EmOsBJTShs2T07q1S7Au
         z2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285056; x=1718889856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ3mx1HRwERqoH8XmiCBcC2qPne8ED2LI938/bq1eLA=;
        b=Otb9+vhBspdiEFIn12rWmtYXpN9sWtDmCYsYYOGSAqF3EulqRwA1uyjD9HSag0Tu9E
         UHT0ze6axgdZl5YEKQ7zayF1r2/utXSdnlneoTodUdIAonDv1m2BUYinc8a1lSg5Yz7k
         xed+o+BETlbcGg40+CaAHsdQdcYXjFL0ggZIqmF4/8nlzNNZb6O+h9JCkZtLryogJRl9
         4UQm317NutVp4K+FmJ+Lqbnk2kYcuKGWCz5RkVyxWF+anQKD+ezOwVJEg82YkzOtersk
         x3AFmugtOUZmshFvMHF6PtSW7/Ytnc0gKNtKrJ6yvjnHQSEDgBmMEH8gRnbDnn6/hRHX
         jx8A==
X-Forwarded-Encrypted: i=1; AJvYcCUnZNx2jrE8REmAGdqMnn0NpVD6NqHDOUzfCCnOzX7kDFmW72w8IkZNzBngAbu3usNwVTAaFX13l5GEpadYLqttgZo+fKQM3ST7fj2W
X-Gm-Message-State: AOJu0YwD47O4L51GuEwOHc7Sxl1YpV/Jv7ZESR9WLLGVZ4cxRFVP+HGv
	uaDPZg18/qb7E36c7G7qOsiq7E9W3vMVaGCo1ZKN9gC/9aNYzxEITDAyfDixVjI=
X-Google-Smtp-Source: AGHT+IEJg/QKxM4h1Il+pvifbmJ54eJISJ780cLTsOHK41otmROyNxfcRHscGOFu/oRAa2gn49Gm7g==
X-Received: by 2002:a05:600c:3d99:b0:421:dd8c:35a3 with SMTP id 5b1f17b1804b1-422866c2561mr59775105e9.26.1718285056346;
        Thu, 13 Jun 2024 06:24:16 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c6esm25086225e9.4.2024.06.13.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:24:15 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: thermal: Restore the thermal-sensors property
Date: Thu, 13 Jun 2024 15:24:07 +0200
Message-ID: <20240613132410.161663-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613132410.161663-1-abailon@baylibre.com>
References: <20240613132410.161663-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thermal-sensors was defined in thermal.txt but when the yaml binding
has been defined, its definition has changed, dropping support of multi
sensors.
Since we are adding support of multi sensors, use the original definition
for thermal-sensors property.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 68398e7e8655..fa7a72e2ba44 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -93,10 +93,9 @@ patternProperties:
 
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
-        maxItems: 1
         description:
-          The thermal sensor phandle and sensor specifier used to monitor this
-          thermal zone.
+          A list of thermal sensor phandles and sensor specifier
+          used while monitoring the thermal zone.
 
       coefficients:
         $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.44.1


