Return-Path: <linux-kernel+bounces-253656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17F932466
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A588E1F23FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F51990CF;
	Tue, 16 Jul 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfCxZGq5"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D99198A2A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127248; cv=none; b=te8GwP1feK/V7pxJoNODg3ZerfDZrfbRb5UqHJ/7hUMMfeLJbEibchzWNFu5unfK3A8Vy/vRCZNo4xF+cju4wLOkRbT9sqyEizvy3Yn1lbMU1PcZbUEgnLmlihWpao3sihK/RApeyu5pWiTT6tGebHnFONKhcNo4+oxmIz8+NPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127248; c=relaxed/simple;
	bh=YorhGRO2chbUqTcT71uR6rwxbeXoVYmksfD0xmDIhMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCy4cLhIJGmZQ4Wr6C5Rgk0zkNVl+S8VySR/Y4pApoEBgBjjz9pGGIcMUlvQsg9Mwjcil3I7OSuSdiUn799wXj2dieJn72HoPt+lkyKij8ou7i45EQFykUCGqMnZvjVzRmR0anXwKNERY2HE6soYN1NjakHpniaru/ysF6qvzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfCxZGq5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367ac08f80fso2888345f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721127245; x=1721732045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3idFFwXVZ1sV2FTSSvkS/EtQq1D7aCpjCrwW3Fvciew=;
        b=HfCxZGq5lq2lbTie3dsQlx3iTLFCeGvqD72gP2LPS5jgtngPzzmlOOGxdIViIchzRc
         eEBmi2R9//730W2EC2sRMLH3O+RwV8u1pSH2Llyj5k3BylH55ss7jEE3wKOTEs6Vc0rT
         aa4Vajz9IN+MW+jlXTMo75U0kh2g+cyLxTr5vpshZgz0AbeMNwaJpyVwDpvOyyNLGnq3
         CSRZCD+YB75TIiiwbPwdKTbnRlCp7yA3wahJVBf8mTK+S/+ABf4tzPFdMBTmRDKfXSQb
         lZU1ROjtzdIhZwJN+JTUSDRR38EfL2cbh7Je96mSpJc5cYWFppxwpXZm308EsncnF/UY
         hzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127245; x=1721732045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3idFFwXVZ1sV2FTSSvkS/EtQq1D7aCpjCrwW3Fvciew=;
        b=mVjIWHbUF/6mL1lp2YTtd1sXSMa4PvjqN56o4oOoVLYI791f13CrkDm+31lQeo6h5X
         6WoQXf49ZDBrGDHFdEE3Vcri91yfbJLWH3b4PAyKhlr1YJx2OO8wrtBVhlyNOOk/fJId
         Tt9ZJUot31KOo9KjWN9M27iCyJgDFU92oIqrwjIWddQ5/mxsjwLyrrRB0YFy1f5O1xSL
         fInzAiNvatbk1K8j4YRXNdx0FrGS5Obr/MI8n1Du894uZAP/EH2Ku7hEPhuErTYYoHO3
         kv/+LDfeHT5Ar1qeJ6sr6zNcEKkGYTpP+xEoTK6w7SdBfK7Vn+Kh4eyAVuxf45mh/Hl/
         JXcw==
X-Forwarded-Encrypted: i=1; AJvYcCUn8n4jLLDGWOOPe/lGkl4ClfyQ0NGnZoTccH2xVajFd50NYSuF6zgn4WgV6CyuaHq9TPyJt5e1t+qfePlVMn8ZdgBcPWYfTBHBm0/L
X-Gm-Message-State: AOJu0Yz4uuRjFWul9XKjLheOJEAd+Ulp6YEynkPYBSfKjb1ZlplFGSTF
	FMQwqgB5LqzSRkFz7PF+hX4gE1FB+/ywSy3FRZGy8K3fsq2Zl86kSy63gRZlcAo=
X-Google-Smtp-Source: AGHT+IHdAGXPdAISZGBpSXYAAJ4HcA1uS0a/b4dYpiEL8XWtam09tsYzhfrfMH+0AVFZTTTypTvWew==
X-Received: by 2002:a5d:6410:0:b0:366:eeda:c32d with SMTP id ffacd0b85a97d-3682614f7bbmr1154936f8f.31.1721127245325;
        Tue, 16 Jul 2024 03:54:05 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbafsm8608295f8f.51.2024.07.16.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:54:04 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] Convert {a,i}pq8064 SATA AHCI controller bindings to dtschema
Date: Tue, 16 Jul 2024 11:45:58 +0100
Message-ID: <20240716105245.49549-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The following patches convert the old text bindings to dtschema by using
ahci-platform.yaml, whilst also fixing the device trees to actually
adhere to this schema.

Thanks,
Rayyan

Rayyan Ansari (3):
  ARM: dts: qcom: {a,i}pq8064: correct clock-names in sata node
  dt-bindings: ata: qcom,ipq806x-ahci: use dtschema
  dt-bindings: ata: qcom,apq8064-ahci: add to dtschema

 .../bindings/ata/ahci-platform.yaml           | 42 +++++++++++++++-
 .../devicetree/bindings/ata/qcom-sata.txt     | 48 -------------------
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      |  4 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      |  2 +-
 4 files changed, 43 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/qcom-sata.txt

-- 
2.45.2


