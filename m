Return-Path: <linux-kernel+bounces-377647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8335E9AC1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46F91C24AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF875172BA9;
	Wed, 23 Oct 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tcxhkOBX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774C165F1F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672564; cv=none; b=AkUIvWzwqSha/kkgq1C2zO8pquh9wlDQeU3C9SzFizxOts9X9zMGfLRgwSS61pLaX3Y8/Y+NHP5y2DN4Puw3m9jInWINfsm/WuD85FVf2hr5vcwIBxS7u+PVEZMNZ9bSFUPCtxYwqnjz1+QtIkkRFPUrHsRWUEGGW5XD6zCIZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672564; c=relaxed/simple;
	bh=C0ofzRLHUjnO1N29L93VIpCDVoP5kG3rbslvEMd6Yls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0k2uZUKVaUEz6pTsJGj6B2CGgUH6VawMvhDzNnFts1lU9nxlWBFsqg83eDNG2Ta/S3hAEFXUMQGOOFvBhm15P3Dkd5UBrS0p/ydZ3Z1V64EBGQECdMUFo3lwbXZiUwIetqTVd6WhbqZZaE+eCshkIWprD3MF+nCKbAuEhShCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tcxhkOBX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d41894a32so420690f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729672560; x=1730277360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zb3NhR3iOWSFx2LHTN/vlZTx5Yzwk+aCcenmMYG6qoM=;
        b=tcxhkOBXdrOr9TRlJ6gbTWQeg3l/dq6A22/lf7YzRX9msmUVfxHZStMlwYv0MG6+yK
         QAqx7G4V6WqP9RkF5cjBd09Q8vTG62ziEb6gOeZc0th+uImIoZznIQJSfOvX15Q1V/6O
         V6kKETlXmHc7iL+jT8DPcmB7QiHYs7jqjPpweoMmFit07SRcMHkyKkCwOKXsjZig7IMc
         HkLnNlzGpT7KTNEOruwi4RaGiPLVB/+N3cTrqiHQE4hyeoFn3B5BtFHSMZmqXD7YJKfh
         XoTJKfer1QbBnJvTfAP4DIL6XHEpI+VzAIFLrRMGVSEn7DymzO0Lap6celLXVcdc49ZC
         pwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672560; x=1730277360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zb3NhR3iOWSFx2LHTN/vlZTx5Yzwk+aCcenmMYG6qoM=;
        b=rpKm1cxocu06EjUgrUxOU7sikyxgs0x/upKUwI/quCC7NLLYnAv7maSaVQZlNufAmI
         tY/p82i5qFIRE7K83Hcyj3ta5V6Qv1V8IIs2ylzFG5FETJJKNIt5mu7DzYH/tZl/CJmx
         Ge64pkNMRoaXV+A/xLPX4n/Hr6bDE9Bk2ZRrg3iILz2ANY0pXxlBNls9wEJsgHAEqJQk
         nJVgWByhewLuCZCqnvU1UVeHsWnN9MfofnEM7tN3qS3pCUTiuH+8lyLZs9I5Kkj5k+g2
         2abPK+v1fhtaCIFp1mfuQg0xfiK6zi5BIUmS9rAm7Tc34vnGdNm2sGwiy+BID5LDyO2o
         I2Sg==
X-Gm-Message-State: AOJu0Yy2jrWn9PuRuimwASgoLlOTW8yuwiZtAsd3M8RSiTrz7A1WKTax
	Bs+FoFX6K9+1Y0XC/NF4Sp60dGRkrzUiGg8bsMr/vRIUMcDqp9xsYdmoEpmBsCU=
X-Google-Smtp-Source: AGHT+IFWVcJDijZb3OwIOwIt8AYR5eAsFE3GY8DX8Lse58wemtB27SFLO/TB7EwfetuLQFYX3zFIUA==
X-Received: by 2002:adf:e951:0:b0:377:94b:4f51 with SMTP id ffacd0b85a97d-37efc62c8e5mr1006798f8f.22.1729672560604;
        Wed, 23 Oct 2024 01:36:00 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ee3f:9900:c4e6:69d9])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8435736f8f.73.2024.10.23.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:36:00 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 23 Oct 2024 10:35:44 +0200
Subject: [PATCH 2/2] regulator: doc: remove documentation comment for
 regulator_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-regulator-doc-fixup-v1-2-ec018742ad73@baylibre.com>
References: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
In-Reply-To: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=C0ofzRLHUjnO1N29L93VIpCDVoP5kG3rbslvEMd6Yls=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnGLVtxcYbNnO59vrsvGB+mxT8/ZfIncALv+eoB
 LfW4hyfdgqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZxi1bQAKCRDm/A8cN/La
 hQ6OEACsE65onvt50y86aGuQZpkTRHE7TAS32//RKXMFI6lFHwKen80B+5pMFweFCXtyTgqo/4H
 fJzMhPEXFDHBkMQMjo0wWcZUY/5BR6MplviVA2/fKPHG1xCaJbpspQWVeW7RcvNW5Zsl4R5LiTT
 Y6qd3faMQn10ZcUMd11y36jDyrunKqiUv8skVBKyTG/Pgt7fL/gtYg0uVcTrMsZG/5NOzmOIEOE
 M09mgChIAkF4S6wtvQIaPRKsXfohA2eHurO7oBMA1pbAsg67Cs9TO7VvyGUIeUHeR7GeI/L3EKj
 hkT+MbngSbNQzWIh8X8ouFnXy7KsfWtMzo9Ou1nR79JoSw0Wp3+5QCPeduo4eVaEWvBCSWy5Uu2
 vnb4DAIwFQ8JdcJrQZODJmhw+c/iAFDUJ20tKG1tUn9eWQ1sAaXQjc2FFiBBrcvb0iDVXREh4/o
 SJtUrTsQKPgO3qrxw4LU4hnK5ZHTCeChY5e0MD9eteomCrs2zjNiYmK8c24t6gc9yN4B9r5DzOh
 4Pm7t2PWoExPUtfOcdLKuosNsWfcX778qH7jXohLU54KKzAh+9qLsyfnWG+uUgmpkbuqjGY96mG
 X486KQLI9ceEytFv7CXXO8hrkvUc8bfXVAPzUVjqWq0Iw6QrAHpEhxh92hmOx3e9Ud/jVsgSa4L
 nYXT7pBMnoYly8Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Remove documentation comment related to regulator_init callback.
This solves the following warning when building the kernel documentation:

./include/linux/regulator/machine.h:290: warning: Excess struct member 'regulator_init' description in 'regulator_init_data'

Fixes: 602ff58ae4fe ("regulator: core: remove machine init callback from config")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20241023155257.0fa7211d@canb.auug.org.au/
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/linux/regulator/machine.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index d0d700ff337af119636bf993114c6d2247f6b291..b3db09a7429beeb64a413a0ba2f785a4c877c018 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -273,8 +273,6 @@ struct regulator_consumer_supply {
  *               be usable.
  * @num_consumer_supplies: Number of consumer device supplies.
  * @consumer_supplies: Consumer device supply configuration.
- *
- * @regulator_init: Callback invoked when the regulator has been registered.
  * @driver_data: Data passed to regulator_init.
  */
 struct regulator_init_data {

-- 
2.45.2


