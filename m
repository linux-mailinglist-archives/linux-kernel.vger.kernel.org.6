Return-Path: <linux-kernel+bounces-351718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A9991547
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2255128367E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1813CAA5;
	Sat,  5 Oct 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj3bnsmP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF42F5B;
	Sat,  5 Oct 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116805; cv=none; b=jvpHaJ1pogfoUeJfvAQhnu6ulkp2tw4t8puJcvd1Js59AmlvDb9KBlglwnpJiGkajCsUy4w+z1XQTm+0Q7MMAPkLnCIfrqqSZM4IDAAKiOt6AvCWb5j37sh/+YZxqJMPXHSJsa7fc17bcCUwVJxgsZHC6gnYxsYJOTfbGJuoZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116805; c=relaxed/simple;
	bh=CqvSXv+kw1lJsFncORG3aC/DUAq+Il/gSaDXXsnfGPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ChET5M+yDiVNP4Q/OHxSJrfy+jGjyec/oqD08lSA6obWyjvLes2ih02f4ZTUHlUYwEVVmJvz/WUiJ3ZoyAfJI22Z7oUHnrcSWWYWM2ae9Ud9GMhH+TFR5VIZ4C2mJzv2xHfM7SEDDN7xVJydCMhlpBSX6UrTjuXu8LaefANhvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj3bnsmP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facaa16826so26379141fa.0;
        Sat, 05 Oct 2024 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728116802; x=1728721602; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O21fpPaGduNtCtZbd4f6GBxz8N/84MWfeCB1WFj1ObA=;
        b=Qj3bnsmPMau92Z1AZvHXaecnnr2o5S9QPZx8v3z/Br0eZIvszmW+qXtZEmn9xcjCiy
         RIrWpu95JJhyinf9N4S0vbPnoPvi/Wn1vPyqQg1ExOPMQZFq7tg/FeB8BMPvd66kjYK3
         9/HX9X1ukafheZlk+W9duY1sV0b+7afNLtWj43Ltoau8DN9AdiiTfGnnDzOT7HZ0KTt8
         GDd7y5Ef1C3vwdjicmMYhA6ovx7s77+fvvUUsaPplYut/wkPBri2TdjZWg9vH9L7+81N
         3xajbNl3FxPLMLw+LgOKrxb6b3hWaJX8TxfhELlLK4dl2yrvVIO/W0JUMffg9PZa8t9C
         pCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116802; x=1728721602;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O21fpPaGduNtCtZbd4f6GBxz8N/84MWfeCB1WFj1ObA=;
        b=wtUnJDcefwFCcAQjWSDIFklVqQ5eIrUIHTq+horWgS/q8MNlP8p9NzpD4tX+a8AcPZ
         paT2bLbJZmXY3esBUItiPgNrwPcWpH4J2JAoL5qQgA0p6JRWjv2TXXCY4B7z9/Avl1GU
         Jy1sz8Gnn6ORLWtZaie/mebC4jCh/xylvTsqepQGTqjssn2RxjpK0oA05Ms0KVUbxYNy
         u6nD43yz9rwaXAkWu6Ma93gi5KM3ZSXJOMODe+L7KSLknOdiBGn/EDPE2L2BrUJp9JCe
         RiqNDU2nNfhLeiVOzJDT4WRsaSNsZ83HlPKx/Xdi3kZjpMFDm1qkoy8iy7T3A89uVRrG
         C1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhBAXEQ60e6RTZQfoFIcoOFlZ7v4kql42vAtHZkEmp6EJvM91AUv1FESrDvxF6/lqKU0MPK0ZMK7X3pZn@vger.kernel.org, AJvYcCXA2H1lPwa1jLl7c+l3d4/xca788WnV1ZGt2cN/ytPr63cSVGc8diZWTnl3PwOci4zKXq6PREXvNmxc@vger.kernel.org
X-Gm-Message-State: AOJu0YxNW339eZMpckBwsN9c/dl0xIHmzlG/KVtOCez8XDJLtwVR1ZBM
	iKDKgj9tnNZfmN6jtK/nvw6mA7V1ckRTStTHY3my+ytv7jRTWzw+
X-Google-Smtp-Source: AGHT+IHvW+WAEMQNdEI8mLtII7nfsPXedcpq9Mrv+72ZhOqHO8uUwUfrKdn6zf1EXLVjN5UzVdLU1Q==
X-Received: by 2002:a05:651c:544:b0:2fa:e658:27a1 with SMTP id 38308e7fff4ca-2faf3c141aamr29513671fa.5.1728116801700;
        Sat, 05 Oct 2024 01:26:41 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b3a88esm1857711fa.125.2024.10.05.01.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 01:26:39 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v3 0/2] Add support for "on-die" ECC on Davinci.
Date: Sat, 05 Oct 2024 10:26:10 +0200
Message-Id: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACL4AGcC/12MywrCMBBFf6XM2kgmfRhd+R/iIibTdsA2JZGgl
 P67aUEoLs/lnjNDpMAU4VLMEChxZD9mKA8F2N6MHQl2mUFJVaGUKPzomISR5GyrdKurBvJ3CtT
 ye+vc7pl7ji8fPls24br+FxIKKUzpjCGsrT67azcYfh6tH2AtJLW31M9S2SpRY904bU+Pam8ty
 /IFZWSS9tAAAAA=
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=CqvSXv+kw1lJsFncORG3aC/DUAq+Il/gSaDXXsnfGPA=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnAPgrYTsA2BzoXfd9pp+nFvsQj3hIfmLSbixzL
 UoLQ2LrPnSJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwD4KwAKCRCIgE5vWV1S
 MgHGD/4ofv/+FKJBL196TJCiSAGhfnr77Xe5Xh8MuZKlF+dfgWD9Qk0L0cC6USpIPpiTUKK07zj
 RlILRt9k6KcPKmhu3ySFS+7C06xoOamLyScM+8Mp/GK7oDHmvlfHBntsk4dD9QIZxmZ6tu70NTR
 Y/IRwUBdbth11PZnyNa7rxzAK7BGKjMT6BnSpuwYK04UicJCeXV+cot0GyRL85r9lf5MN6nHWGm
 F4Grf1rXq1/qGhzFnf5a1K5a/bJnKn2YUhqq5M1NaUF4vyvUDM+gEG9zhE8WRXlVnADurS4Rhlj
 Lpa4AwyJSFDubowUUrTnk8LZrTCbsxCmdZ2HD28FjVg4c0s3oalZgwXFVMefrLkucto/NDRubyn
 kL3qcuNKUnaQSNjZOIs/gjCF28dntBycvH85I5jHkOYD1B2EWYhB8nnPTuOvUDqYTdc7mjFkRn6
 KTgFTvSt2b7rk00eeqNluPYKfel2V3M0VqMlA4CoAlUGh0r8Crcn77af1ZSWadP+oSEvZih8y0d
 JnFQOhamTlFuS+4LD1/v8OHZpKV+0r/M8OZVO51ynhh7V3Qv1MrFEKd68MLGst+hvkD6ANP3jOU
 c2Y4jsX1APQwZMWwFa6Hk63rMVe1P83IQDyuxO0XCwXrPiUv/FLj10JJi7ZfjIqEoqyiZmVCLE6
 /pww3acaGW4dDaQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v3:
- Fix formatting issues in yaml file
- Link to v2: https://lore.kernel.org/r/20241002-ondie-v2-0-318156d8c7b4@gmail.com

Changes in v2:
- Convert dt-bindings file to yaml
- Link to v1: https://lore.kernel.org/r/20241001-ondie-v1-0-a3daae15c89d@gmail.com

---
Marcus Folkesson (2):
      mtd: nand: davinci: add support for on-die ECC engine type
      dt-bindings: mtd: davinci: convert to yaml

 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -------------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 102 +++++++++++++++++++++
 drivers/mtd/nand/raw/davinci_nand.c                |   5 +-
 3 files changed, 106 insertions(+), 95 deletions(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


