Return-Path: <linux-kernel+bounces-306384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB07F963E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83706285C05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8518C030;
	Thu, 29 Aug 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUPBTci4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2518C000
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919680; cv=none; b=WdMcUDpFBGkkrvlQ7a1elkiN6Rv0bGF6ImemFRSLk9658PrWw99kCs2yoWXB08VMp1vvV/Be8gA/Ld5IXGVlHJmkrKgPOOZg/C20PDmyEUKmk0jqKVme5xJeWUmzzyqE0MLSX7OwQSG8AF9FEot8jbv0tdiGuoJ3uKmtv1FIKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919680; c=relaxed/simple;
	bh=K04IwqvP4QHiJEyRnXObSNOLM29xMbSAUjAHbtkAsYI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G5zJhelRNTjhiHFC2KpRwa+mo2JVm9KhrdACBZMsFd52R70jzZyKEMNA+YQJoCJBd87JXnSZLpQIOXIAs+cfXKqhxto3ogvEqZczqaDSGBimK8uZJRt5tRDFDtWILgtNuHcYhqrF7fvtkrb3hd5pHrGi06CTiGZewiwSc4MG86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BUPBTci4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53346132348so455144e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724919676; x=1725524476; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFe2h6mCzOZVtHkC8fLtufQDeRDZfA2dn2/r0ffaHpg=;
        b=BUPBTci4WQ5xBMLDPt2ESwhL6Frxnj7OUK6Ac6rqWLc46k0c/XeZedQTt16AitvD1t
         9uWp3KAbyqIlYiAxn8KBSCQjoQZc1fdgLrYnKaOGUxD5epZcFmxiG5KQQM48jzXZIFZY
         kadRaAgT2Sxi/upvaDq9upyq+yxWzGEUKf/9dK9E2DeEcmlLjG4bQNliQ8R76wC1H3cX
         tuGTkmjqyMeEvZGhhBOTqZ2U57TFsMYncyOOJFrFpZzsUF5mQ/L3Wz47jpQpicTM1yyI
         wbnCc0fjlsIE0XOjQwfGvYrAIt6SMfDOHKZ7p24X70lDmPh+4c/RQ0x/CEIEu4iDXD28
         ZC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919676; x=1725524476;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFe2h6mCzOZVtHkC8fLtufQDeRDZfA2dn2/r0ffaHpg=;
        b=pc4gBfn5gqpml5Tudf1jzgPSaI3YEnAyRhfgDesYnvuExXrY+Jlpxqz8zSUlPZGs82
         zX8mZvEo2ubb3uJnfd1xlbxkpz8JF0+4XJ6q3fcvVN4U+CLja81lyNjS1Fdnx0LzHvgN
         W81vyDWcBa0btJPgdhb2KKlE3no6j8jFBRGElEM1U58kdu3arZtCGNiN+IhPJyoO6G/F
         Ot9vHBM1kaOTzTP+8389r7N1o2Gl59GFeY2wf1LjaEZYi0oHAw4dPdv1Xb1VwSUMT9ph
         Zi3nOtL7qku7drnzxsYCQXY9RDC7x3VOWjJMl4IO8zvuNy3Thf1GDi+/UShHuCfIEejo
         R0xA==
X-Forwarded-Encrypted: i=1; AJvYcCXpCpFfshybrESKUxw98Nk8j0n5g3/U56Oi1MWPiE5G1+ss1qlvxmMnGk/USwmfE0netdMARu9XQ8W0Rqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFy1IH2MmEpQwu81yLDcoFNzvg+hgsST9hIcsHQdOlGG+YSM6Q
	cLqeEc6dgKpg2lu4eQGPYeMi1nbIc+qd+FIvzwWzka3ufQ7oXMi0ga7x2HmYya8=
X-Google-Smtp-Source: AGHT+IEPILolNaXIOtWPkvXuhIpXtzFYlASE1vDaxS6koISyxcfo0zqXADbPzOyD6IgDr8l2GxgKuw==
X-Received: by 2002:a05:6512:1047:b0:52f:368:5018 with SMTP id 2adb3069b0e04-5353e5b8400mr1383456e87.43.1724919675693;
        Thu, 29 Aug 2024 01:21:15 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac333sm90243e87.70.2024.08.29.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:21:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] phy: add NXP PTN3222 eUSB2 to USB2 redriver
Date: Thu, 29 Aug 2024 11:21:12 +0300
Message-Id: <20240829-nxp-ptn3222-v1-0-46906bc4747a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkv0GYC/x3MQQqAIBBA0avErBN0dKFdJVpkTTUbE40QxLsnL
 d/i/wqZElOGaaiQ6OXMd+hQ4wDbtYaTBO/dgBKNtOhEKFHEJ2hEFFp6760iZw1BL2Kig8t/m5f
 WPumVoaZdAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=K04IwqvP4QHiJEyRnXObSNOLM29xMbSAUjAHbtkAsYI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm0C96KQtgq+QiXli2xwJUwFJy8O7goNK1HIODP
 lY3r0kLuBiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtAvegAKCRCLPIo+Aiko
 1ZMnCACDncFx7nCwNWfmvqHMShy3DZWvjWLncWqZDdAO1QUzJKiblMhF+iGdU6GZBmgsByotc8Q
 JMy/HDJ6vKDhZgisrtSOUtduyBZeqVrGKsA+THoHnXLLKN/+v2CZX2rxIf4j/02ihV/WM0fRlNu
 SjyDO2bfO+3fI+PEZChomkscaXBHIfr4sqlCvdvBPjCLAw9we5ZcN5UxiUlE+zv+lEo0ESehC/s
 1zCJyYiCoOZ327Na+V9X7uCm081EMRSxz42mtCBDZQ0iJmsP/tqon/XrNXcb6vHdVXLH38pa/Hs
 hcZKkszSDJhRFw8kRw49dLrXg7OMTydk4dLXHX8ATT5l09tK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
translation between eUSB2 and USB2 signalling schemes. It supports all
three data rates: Low Speed, Full Speed and High Speed.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      dt-bindings: phy: add NXP PTN3222 eUSB2 to USB2 redriver
      phy: add NXP PTN3222 eUSB2 to USB2 redriver

 .../devicetree/bindings/phy/nxp,ptn3222.yaml       |  55 ++++++++++
 drivers/phy/Kconfig                                |  11 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-nxp-ptn3222.c                      | 119 +++++++++++++++++++++
 4 files changed, 186 insertions(+)
---
base-commit: 195a402a75791e6e0d96d9da27ca77671bc656a8
change-id: 20240829-nxp-ptn3222-30bbb81e984e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


