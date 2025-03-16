Return-Path: <linux-kernel+bounces-563098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B570CA636F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F42716E1A6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A391FECD3;
	Sun, 16 Mar 2025 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RerlYVVs"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82281F4179;
	Sun, 16 Mar 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149171; cv=none; b=XTWPAvNAfLOjyYgoHsP//odH0URaR3ydtJFTX0fHjz34HdZeQp3MfCK4AUubICy6SXuzERMdJXrG2KqS8JZ73Gy2GOKKRTcn0flJ+HC0f0BhwxZbqk+Cumj7KPSRbbmy3KFXtqbvTD3rqe9FrHT2KEye3j/o4YBT8SPGg3NznO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149171; c=relaxed/simple;
	bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEaCOV7pnWpULhXjTWKMT+XNPjHPlaVe7ih7ipsEVwtu45FsErsyCyXaZbgi43zJxXMtd0t30YP4s6RQThQcPE9lqr2UrbNM6v0XfcN7KGzTi4YmWFnQ1lPOfKwuPnVSggb261zyxW6ilcQRbiKFSBUnLcPqc2CrwMpuESPaXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RerlYVVs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so832445166b.1;
        Sun, 16 Mar 2025 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149168; x=1742753968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=RerlYVVsGFdHE07ZpoOV/trJH8JRLpnhb158y5Z2cBkut2gZknzTSgfrsCp+6xwg+l
         60ruFH25K3RsUReOBRhkQ+xNKo0gE0EfGaX/HUoX1lgFuO2lthrO8BfA8BymaysgZupm
         46vcQLSNDiClAe3yChOhnfa5LOuDEcKZZY8YnqXq0fziuOF5We2F4OKO3hgr4PV6IJkX
         m6Ppw72qMjSumZf5UZN5ssp6KVzXuWcmhzndZths3Rsmx57ru31I5xX1lQPywjbLqLyz
         1e0UntJ27seczVjx97rhBpmecGbbqDjEVkGzDk8NbAD5TqiLBnzRrIrMdKqWXdpXgLFt
         n3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149168; x=1742753968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=RZ4WN3CNaEF1xz+uJdQUsGodqJ059x3RSgAKHfRUXLI+OqxuJGqYdjHTgprZezc4Ib
         CIYrHpHWiNpu0gB07wgMw/f8hTi7sM3mEWiaKTUqY+mwnORMYZbO3cBpz2bqvTJncyeu
         1DaZMfuBVQHx0TDPyKCJE0/nV00jeX0UxbWmJyfXF4as7nb6toXUVudaguO2DWGGN621
         MZPBspTZzuJDNfS+SJU2qUIp/3Iyi719K4QqLVYgdR7FsYSt7Fd+i9tShbksmViQl8JO
         hwtXqoxLpFcFH4Y203J0yEDfUyACA56pGVQpviFKWJnZ/CXhqrrYywQJdXZ6y9O2rjt8
         qjNg==
X-Forwarded-Encrypted: i=1; AJvYcCUHTdr3kW5lQlDEjv9blpBe3fXTFmcfV0N0MRxB8n5F6osSmw5MrmTm0+DjltQvK/znmc3yl4SIIh77@vger.kernel.org, AJvYcCXF8b5PszHREPomGNyVOawFSa4TMlA4DTNz3kM1pZxpiOZZ6AFROQcFDd0sco8+p6tPtn9IVyTu9f7bmFYi@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJqTtcrlSamKTHX1dPP7cr8/P8j5T02hK1Qm7RCn+tycPNjfY
	YfZEW4erjSYpgR2EuqHmw0yn+6SY6mRCc5y08BiJZcAo3c7Y4Q0M
X-Gm-Gg: ASbGncsng0m9aSaZptN4hHpzmDypjjtS0cMMQ0X789uxb0ifybgRjghO3W/xYGsUS8I
	V0jItJTsbgaeLTrs3Di8OYrZ89MMNVpAS7JBsa6VODc4XQaYAQf+qBtHuUFJlRgZ1d1zhkZiL0M
	ctK33u678QHmaJ8z70nYQ7LmBOgawjlWIUiCWSqGbJDSSHkU5TyZkDDfrfIiNN2+1JB6d3QT5RG
	BYPTV81kws4MlOVI/TJOnLvg6d3De+EZH8D4UCzFbD21yRASp2ML1VE/le9fAcKtVAPCa9ipS4t
	wu433p3VOGxWenyBgZLmOBV+73xPak+si7qkvt+GG8P+ES8pp6nsk0ll6BDGHK+qrRT8ca+1TVv
	HLMKea/MEkMH983Eavw==
X-Google-Smtp-Source: AGHT+IEv1VDRXxX1pGR0UQxt+AjO6mxGqoEmUs/RgC1vV2jOgv03SzF5RsrY2ijlnCEH58tY+1xEwg==
X-Received: by 2002:a17:907:d0c:b0:ac3:45c1:34be with SMTP id a640c23a62f3a-ac345c13c3emr673566966b.9.1742149167892;
        Sun, 16 Mar 2025 11:19:27 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:26 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:55 +0100
Subject: [PATCH v7 07/10] regulator: bcm590xx: Use dev_err_probe for
 regulator register error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-7-4281126be1b8@gmail.com>
References: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
In-Reply-To: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=1115;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
 b=/3MOGtkV9moDIs4AaSZwT7fVsK4xl03s0Y5kDJkIsdUz4faBuNZczOS0L4cRok9hGHOI+GH+S
 X4LtS4QORlRAtIjdZ33SCklSeNG7l9bJn1vFpknSR++9UuC2Jh0huxK
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Instead of calling dev_err() and returning PTR_ERR(...) separately, use
a single "return dev_err_probe" statement.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Added this commit
---
 drivers/regulator/bcm590xx-regulator.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 9f0cda46b01506080ae5fa709104a8df4d174a8d..a17311fa30e4d48c0a4925778d7bed486ac7a982 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -340,12 +340,10 @@ static int bcm590xx_probe(struct platform_device *pdev)
 
 		rdev = devm_regulator_register(&pdev->dev, &pmu->desc[i],
 					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(bcm590xx->dev,
-				"failed to register %s regulator\n",
-				pdev->name);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(bcm590xx->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     pdev->name);
 	}
 
 	return 0;

-- 
2.48.1


