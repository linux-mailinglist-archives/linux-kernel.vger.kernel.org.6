Return-Path: <linux-kernel+bounces-308303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF17965A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB991C23112
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC416D332;
	Fri, 30 Aug 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auy1iR6n"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477D16B390
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006052; cv=none; b=YZDZ6IDEdQRsXkCLwcUXFw26WcQvQDXaDW1rXArxSa8vjBnzP8FteeInSGXJoKL0zQNUo1BkuGpfT59ActmUa/tfPESem3j7NgxJbIjut+cE+nYaLF39SibS96g1Tk2+Oauk0h9mQbFsLOOjXKTkP7Y2p09k/BDOnbFxp30KlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006052; c=relaxed/simple;
	bh=YucLZiKtcTOQ2LZLPspdYxYZ3G8B0cZuu5cpOrrY3uQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P+r0y3iNLZygJHtaspkc9z794ZY3iaxb3dVeDjFnCkYTfpFbMQhtdZXYFu0j1TOLgmZqChzJZ+NXJRA1trzzzneij3FsjBymRdF4gdmyd54SFFKThAgr3CRNMOnhhqNySZZd4mLRmwD4RTHrbd5ygiXLmAFo4tILASkyFswQu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=auy1iR6n; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53349ee42a9so2093031e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006049; x=1725610849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNNx6R/CTj6/etPLMLqRbZQLDDYvh5RRNyVtz+9vczA=;
        b=auy1iR6nAgN4MAMiDIS//8NevZ1DQ9es4TNVR5G2Jb3GLvoRM5eiVqRFEfrJ91kxmU
         IdgeoSuJyTumklTkobPkw+luRyvX/fdQ1gZSMd0+pvdk9rgoUMKApwxz0rtEs3Xx6fEb
         8FgKlGjRg1dV1R02O7uA/Y/iUp9p1VQ2rfnCKat+jiKju+b7/Rlpzujmbqk1gaS3cCkz
         zi22oqW1Lp9IeOXMMmE3rvbxYYdhi6ZZbJHoaKBF/K6nY8/QYaBY2KbOj0N7MRCiend1
         izCJygK78o++GOYj679cgaSqI4PLYnuMdd9rPDmC/Jk4+K9WTWQrX5DBVlAmGAAbnzvo
         lq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006049; x=1725610849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNNx6R/CTj6/etPLMLqRbZQLDDYvh5RRNyVtz+9vczA=;
        b=YREZb4CDWAkQ4FTkE+9fyll7U1Lbj15iRHlqJvo84YuvrlBNI+q6OSfFBlKgFT6Eny
         vq/zoPpZ11awyl2DPic1KJqh9OeKUTQUB6aO9D599D2x5PVhdBzJhyyDu1CiGBoFTHCr
         /+RlEMrvwVTf/OLumyUuFw8/E4AjUFU4fjlJPBo1TEj6dRhGLrJ1eHjwvo/Iuf1Vvz5R
         qtnLngFYCh9YyyNmVj0kRiqXz/caR3e9sszI2YNM5vtrS0AqneNZZIZn6N3thzz2CBD+
         CSYlX8JsgI0cRoU47hoTGDICQdpx9ahvkXmOtnNNjakbXjQp2dAZnweTxiMrkY1A6tDM
         xBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5Wvwl9OPYa2E+fwp3Gw/N3Tjm05iIDie7XtSm5/2/ZvLUrq+QSSabAZ0WCy2Q38qlv4a5g97TVoa7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nXRxWzUYpYYItaireL8jOpjNjHxATs95ovM7j15aPZT9fKVi
	Reoc4nY6I0WGRM9PofezhswmSHNcwzO3uJF9D2JtnzEXsPMSNt5RXzHg9HK/FFE=
X-Google-Smtp-Source: AGHT+IHGG+kYAl7eRrAUxIf40F23jCJzii6dmVx9hrJqP30xeomNshfKUkKgkv4Nshm5utOmgZzdnw==
X-Received: by 2002:a05:6512:4014:b0:530:daeb:c1d4 with SMTP id 2adb3069b0e04-53546b1920fmr784708e87.12.1725006047931;
        Fri, 30 Aug 2024 01:20:47 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084e00asm482623e87.271.2024.08.30.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:20:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] phy: add NXP PTN3222 eUSB2 to USB2 redriver
Date: Fri, 30 Aug 2024 11:20:44 +0300
Message-Id: <20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANyA0WYC/23MQQqDMBCF4avIrDsljkGTrnqP4sLYqQ6URBIJF
 vHuTV13+T943w6Jo3CCW7VD5CxJgi9BlwrGefATozxLAynSypBFvy24rL4hImyUc87UbI1mKI8
 l8ku2U3v0pWdJa4ifE8/1b/3v5BoV6taq1o26091wf4sfYriGOEF/HMcXvrYvI6cAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=YucLZiKtcTOQ2LZLPspdYxYZ3G8B0cZuu5cpOrrY3uQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm0YDeWPNA1ymm+x1qxspVMU3+Q3+Fx3fQb25KX
 4Q+J63WS2SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtGA3gAKCRCLPIo+Aiko
 1Z6xCACpSleZDi29XNNeLJF0ITh7C8B2OkfchPfTrm6NdUvhBEjxCYDNGMX3ZhwcSIrF8un6aE+
 J8KHfMlNPvxDcEp8fAXNlIaXOeOz0dfLeyqHEFr9r6cg9QBpLyRTx/gtVTa7RkkB/7hxxeck91x
 5WT8AlsiA57Eg2Smn9wAliucD34zabwPJ5sFFsLhA//fAC/0poK74gegTk5o2LjNqlTOckXSuaF
 Np1o5MQ2hP+yua/DpT0HK/fQ4Zo6Ln6QvRRg4gLdsl3A2PNnkg0ubw76WbKB9Db++ifmB9oVZZO
 5mbCLcBLnA8qJhvN9jqqDeRBgM1CzsF9KPhW6pi6NZttt2C6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
translation between eUSB2 and USB2 signalling schemes. It supports all
three data rates: Low Speed, Full Speed and High Speed.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Switched to devm_regulator_bulk_get_const() (Neil)
- Link to v1: https://lore.kernel.org/r/20240829-nxp-ptn3222-v1-0-46906bc4747a@linaro.org

---
Dmitry Baryshkov (2):
      dt-bindings: phy: add NXP PTN3222 eUSB2 to USB2 redriver
      phy: add NXP PTN3222 eUSB2 to USB2 redriver

 .../devicetree/bindings/phy/nxp,ptn3222.yaml       |  55 +++++++++
 drivers/phy/Kconfig                                |  11 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-nxp-ptn3222.c                      | 123 +++++++++++++++++++++
 4 files changed, 190 insertions(+)
---
base-commit: 195a402a75791e6e0d96d9da27ca77671bc656a8
change-id: 20240829-nxp-ptn3222-30bbb81e984e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


