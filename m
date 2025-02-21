Return-Path: <linux-kernel+bounces-526583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968FA4009B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6E7AE516
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD4254B17;
	Fri, 21 Feb 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGqx5dfC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98B253339;
	Fri, 21 Feb 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169006; cv=none; b=Fya93sZpj6sr7RARRXUrzMZiMtGcrosnm6W+9tT9RuXVFVAeQhwPf0tIWiQADdlPCbT3IMwFunbYmzENcIo/+/Ixna5W4/42AQWT8M9u8eewvtdjNUWHEbrzg6tB4ECTwFs5oUtumtsDRFNFXXmSZqsrDSnfXfTIi/W+qnZvuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169006; c=relaxed/simple;
	bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbX7RGWrgYxCu1hAg6Ttule0sNZBaQYdA5rF7xoysPJjF1QJT9DyStR9jbBcyLIds+hWxol0AQ+dxtbebhYYzGMwA1MxAW36a7KS/mxYscFL85AuAEXucstw5Xjc67u5gxGQ2lxFiA1bju2t0y9prcbbGOpgHf2caonKK+5E8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGqx5dfC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb79af88afso468547266b.1;
        Fri, 21 Feb 2025 12:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169003; x=1740773803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=PGqx5dfCGPQfyOPWVAFPuZauJ2EDwn79Z0p+73UUqM1B8+23uf2k1Umk8rm1lfPDFH
         rXiSkxp1nh8XiH7rX77H8vFClY3XkfLgNaY8qFglEwgCsjbkHiWpvqG7yBItoVpgiIbb
         24V8nTKml7DhvZ0EVHGM37Fda9A3ONtj0utxvG4Rk8lGdJF9ANuuJk22nxGJDUI80TbU
         8z6N5UJQph76BNjIIJ/OmxneoiayNmL0pLeCkWPl2xMYEvejTnYRxgzb0VdKObXXgKTO
         gfDr9t1X5ASUh5d1cqrcjVk6+D0leK9c4KYbAxy7oGhMVyygu2qJqrFGq6+rqZiQ15U8
         ODog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169003; x=1740773803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=JCH72ohJmnd+6/lGacI45kGfK3lcXT6ApVphTZ+a7mu30XfnmcWTc1pzquHr4cGU3t
         GlsYMD3Z1sxWmb8FyFRyB4E++9wA94RUQpSgB54GPg6eG/oXgxECxc9re8lOcT005tSn
         flIMaLL+myLW52BDeY4mpRfbpz9dj8LgpGucomkamFVBtzOSj/hyis6n964YiBLuxNkL
         ACj7fJ3gu8rwDvDPqalaxRT81qEH+gKWuV1f40Mjf3UG5dpaWnndlrltbuxj8OoxAKC3
         OKGGOJ1Khg1yF/S+A2xF2rMNhT82xULUdGNOHDi21+fms/ELLkuaSiWdrFkzVpvYsH9S
         Po1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzI4/wMJiGrREYRei+eh6Fu4XAld1SUfUt3KlJqPCAeGNKHOQO1+rACRsoVjuQXCTkHdvl0B3CPSb+@vger.kernel.org, AJvYcCXKr4VOeadBOxeL4PKc7QOPkgs+IcD+Rxn6kOQm9X+QRpClOsRay+jNUk2vl3OdTevcDcTUzkG0tgfAmRDj@vger.kernel.org
X-Gm-Message-State: AOJu0YzThNkIz+mckFNnLnsbEoNVZQroVefYNLkS2ADhyrPJGZkZbha0
	jyC+BWhJ6a+BDzC9gn/nKSbNCUydeUsdzjKnRibHxKbUB9gWkgdP
X-Gm-Gg: ASbGncssnVK2B2SdMmE+25l0NTcBPZ/JWc+xygBswHAN7eUehTJJBWUf5mftWTnTcTE
	wvU+b3+P4pi8gMCrq3TgzE6pgOWkhllLJyS7iHk4/AoPzWrc8gBq5bgBA6sd2UFMHLDnl3EXtT/
	wCxnGnCDOcJRqQibHV1ooLFRlw6Q2xknKa9e9Vdw9oQljgAOJGmPJlfzAtwH05f9/Nk7YrwLSKu
	tzXt6hpIW04LuLIC08bNsQLZKYvjbIGn4PS/DENEaCldSnx7MByp66CK9xV2xT9EAFHgSFZxV5G
	+yqJsrzG8wPFgcQGnRJgPYcTrCnpZOFSHR7UsQ/mh8xH3eYG+2h4ayrEDm82QVWqYiIGjWBK
X-Google-Smtp-Source: AGHT+IH+uvFHPhjJ5Xj1KehQoD4CHZBTb+pHyDr5HtvV//y3lys5Kp1ula0enz7XNu/uAsi00fXMyA==
X-Received: by 2002:a17:907:728a:b0:aba:608d:4a22 with SMTP id a640c23a62f3a-abc09a09707mr482919366b.21.1740169002909;
        Fri, 21 Feb 2025 12:16:42 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:42 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:28 +0100
Subject: [PATCH v5 6/9] regulator: bcm590xx: Use dev_err_probe for
 regulator register error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-6-065f516a9042@gmail.com>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
In-Reply-To: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=1115;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
 b=gNFwFh1u1kW6rTOgxhdsSw4umldZ5Jr+kBAMTgdwKzpUGpkSzfc4BWBKh0PHeWgRvRw3YoV5j
 wfUEF1jy5j0CW1oRBLNTrfil2Danx2WT1Dr2ucwQm8kW2dhiCCMJXKa
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


