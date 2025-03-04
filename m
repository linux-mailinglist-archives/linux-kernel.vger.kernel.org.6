Return-Path: <linux-kernel+bounces-543278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896AA4D3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189FD18981F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC51F560B;
	Tue,  4 Mar 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgkJEx3d"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B21F8BA6;
	Tue,  4 Mar 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069262; cv=none; b=QW3Hii2pWsjERV8lLRB9GA5XiE0j09h0CtS69ymGBSsoOpuUIj3rVBPVrCBPINe1Zgwpwdb1KDJmn8QPW1ppI56iKn9u3lChblJC4AYQxi1ZKBtuK9FBQeEtx+16F42JYr43GnGnal3iVFjAuk1NFyEsEiWgzF443MIRZu9VTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069262; c=relaxed/simple;
	bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0SGlHaUW1E9lnjojkhrjLfnKcsvJix277GKvsTXZaaUiUzZAoKfaAPKcisGcN21WTvmeg/sn5Hlimdawr8eYSKMeK41NnsatoExVLDeZHQqqiaCaaOW3tQj1CuHmGqxdExb6eg+4880kGY6jdftuzZAGL6afn0lI3ByF7uBG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgkJEx3d; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2145774a12.0;
        Mon, 03 Mar 2025 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069259; x=1741674059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=HgkJEx3d1Xz4ETVvSNzS8gruRUqJEHNwO9RCfmnMpTN41tgiVN6fHwKRH2hHhhZbR9
         Qd3ixlgffifjU/NwwYsq/Ul61hfE1J67QM4k5tOSAb+vwo3AtU9btg8OJ6TRkZOxH10W
         lDCkp+4yKjGYQm+LcUY9R0H6xbwsjUvj8k1sajuxZZXlrFG+tvYTd03qklLEoq6LX915
         I+1W6QUzzeACeSU+eka8yQChs1iXKriKdNAYZ4xru8M7mj1SZiGJG8bzgOc57Je6IMpE
         ePP0xia1biETRCfrPrN9rxtLrsAocDV6WCkhMEoZ2QHdn0ubD7CVZwrX4e3jtfdwxKfK
         Z/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069259; x=1741674059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=Cr6qTGDQCeYee7zOs7QMVy5aXZ3p0KmOXI+833cTsGyB6lB9BbWFExDdVxkcBoq6xt
         33xf3eZ47sYvdTxwmxmafjbKmGKbGtDPSuKktt66xSAmzil5rM7a/g7MCNYNGtgzLNLA
         RluAVUQglLi5OVVmmdohE2KYnAl8iXuoQjGTuLgHk/Qnta/b4RNURVX7Qeecd+O+Velx
         Ek+30PIxon3s6eULg7fN7WDCCZCudTRYdb6NjClJPsT+9Zg6ewgqeCszbS2bqGqu6ROZ
         i9slGVVdxOP02BGO6ZfYYPkLUp8HhAedU1R1oYIlRh3PHStInYLJUcxiIPETKjwR4U8N
         x4vg==
X-Forwarded-Encrypted: i=1; AJvYcCUcZ3ZglMmuRdOrHbDziY39/AexZCpg2rnNKlD0Iq4ktkvgKwHAe5R7r08dJ4Mfgk7Gmb7d+lxFCnyC@vger.kernel.org, AJvYcCUlXPZTNRtb4bwy6JUQnK9uZssPknSjFgppuFjh7O5iaQICfPbllJ1GOI4et1rzQ/c30U5DCXO30rhTcJr9@vger.kernel.org
X-Gm-Message-State: AOJu0Yztu8IHfGchPs/f+m6YK6FlDATTE4PYUUlaDP2b9lnaRAH2+skn
	cnRF/gz8HQN8QJgMpRqNO2eGkpGfifkjwy7fr3/KKlGTXpS8Y+nI
X-Gm-Gg: ASbGncu2YKTTz64aUPnCpTX6oweTA+JBO+dWSEklpC5ppmA+zkmtzFe9pfCHvf/Bq9k
	vE6x6H5J0EAj5L0jyXwwHR9A49GpLoK+jzGdEOP0GO0jdwA6KWKNv0D+aEeKb2AwMPax7+vXFCP
	CLaop5HwH1KHKknzsHRxHfqjIBf1yHv5VRke5AfXDYSncurOSejZi18N+IpWrV+Kxu5pJ3JqAtQ
	kKJ6VqNI4J7mMKNUpyr41FERhgqJaMZ92V0VtG7vQnYFshrJN7wdZ//UXKlSY4Qicw/1KgDbtu4
	Qjza6DTrqjyG32BwxMQ/CRH0aQEiAdod2MgB8qaCqPwOSdXbAZb9qZSX3OTTZbaGzY28sq0OsrB
	22da5jAY3q+to4dY=
X-Google-Smtp-Source: AGHT+IF7k65RuFpi5vcMQUt9egy+xwhpGTj1cng+wp5sw25dBvunYDYYpr0mx9G5nQvOMdoO58Hq8A==
X-Received: by 2002:a05:6402:2747:b0:5e4:d6aa:82ed with SMTP id 4fb4d7f45d1cf-5e584f09047mr1884443a12.12.1741069259446;
        Mon, 03 Mar 2025 22:20:59 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:58 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:38 +0100
Subject: [PATCH v6 07/10] regulator: bcm590xx: Use dev_err_probe for
 regulator register error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-7-ae8302358443@gmail.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
In-Reply-To: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069240; l=1115;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
 b=s4Ry2k5Fl/z1tcHti2oR4JD7kL/AUosoXm9JepTzRP7Q0GbcI+ScfcP9E4YGPzG2k3Ox0cbLI
 i4E9Y2Onm8WAdS6a9fnsc8eTjIXJSJENAFrBVrUnz7zzp6ZJ6rlsOZi
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


