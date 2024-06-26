Return-Path: <linux-kernel+bounces-230625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2C917F89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6656B26468
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4C17E47F;
	Wed, 26 Jun 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuMPnmzM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5A149E06
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401025; cv=none; b=UOsorJAnsUAz9hqTiBi8zOid/TEELTRDjxvAMqboGv5HHdvS8N2QQ7FSF6fLpzszpjHM6n8OIcPKL1qWV8HJsAYdC7xfBvWUO0rm//ogFOER2BTnK4C/O0s1ITVwG7d4Yj4B4D0jM4Ym+alf8H1f0uIHCCnfnQO935y91dsiJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401025; c=relaxed/simple;
	bh=gyRX6BMRwTjp9tbvhfodRaMKXdFu348jPN+T/jpCZZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pbdepDH1SN0TB0J9qekG8YQkAyx2dwxNu65MECrGv/s1iHJGT7iZ5XTXbz4vyGag/rtptzkSVsW3xAXUJRp5eqrEu2qicpCNE9hZZl5OmNFaTJC+cUQpcANCpjD8gsy8DBNryFDGbOfW8qdhrzGeSw0ihuwBbxsjjLfaMGFCNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuMPnmzM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724a8097deso453181966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719401022; x=1720005822; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=frMExdgX5J/6cErWwE6EPmWiqd0cDZ3HICLci2k31yU=;
        b=QuMPnmzMJZIcZ5BumjUWv4yyVmhUxNLzdj13GzE86p1KFnV+kub+NB+Pegq6/FqwTt
         /Nae+iJ6v667QX6mE1E5TtOAtUOVFZoMTDK8h+J3/W4dy0gMvLSL0kqI+NWoMDBo0OXX
         4yGqGCF927raz8W1wWKLvjTl2JFhJ4jPh5SwNozjhpQDN0rZXmGX6nWbur4AUZCFLy4E
         NfvTT6FHqxNm424bTxQBzmXXoUhKxn7a5u3ddiHwtdf8sEScYOoHAldH3nZZdSIVcs5I
         yj4Ir1C6f6eIwdjJmmgoIsaw7nwHbXo24xmryIc0/9w3E18sPw/0h+mHUddZsbnxy5mE
         oahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401022; x=1720005822;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frMExdgX5J/6cErWwE6EPmWiqd0cDZ3HICLci2k31yU=;
        b=TH62XuIPSBieMC1iigBZsj1cEpp0krsVYn13HoxYVxwLEtWyY6yrCDFXoXhUYIQdDR
         CI44RDvHyXg7q5Z1grFnbpw+dspm+D0tkctiVFCRu58KbhT40H3v+gPcsPbEpwBXkdwj
         iAGNq35VUvnAOIkUOKO6ljy/xLNGHxhzklYPeuc/n2xrGidl0PvGzwUcn/bB6dCOqyXo
         WEUqn5S84O7BZVHtsN6Yj+iGsQ3VO78GitYNaGnZLF22uHJLkQBKPdtMY22zK/DFrtOx
         i0hpidvQ5p64UzUTrmMHd96pmQ8X08XUDK9BYgGclMFEwMAR5rsiYPnvefMh+eBFFZ8R
         ysrw==
X-Forwarded-Encrypted: i=1; AJvYcCXi1GCnP0FaH/GrboFfJt8QZODoDi/uWCIDmggoBdfyNnpJK/Ru9jAoi4EIgfdKiM39SFztf3sPh+LXq5lamdJe22oUcW1MyuCvt1i/
X-Gm-Message-State: AOJu0YznwzaM6AoWRQ9erIispEVDn4diXZ8qfPBXaXz+wUyzWyo+mMxe
	rajdFjQ5rjsT/EHGsvKMXFxYpF62zWJ+oa5VoYorP1K7Dwtk8QKhcbZ+S20XzH8737I3RKSaDTL
	I
X-Google-Smtp-Source: AGHT+IEa5yUal6fX3n5FNuTvLbZYHVVC/QfeHUBv7+MfqIIfSjWm36oAng/9ZSNJ2cF0Ue8daF85Hw==
X-Received: by 2002:a17:907:270c:b0:a6f:b181:e3a0 with SMTP id a640c23a62f3a-a7242c9ca27mr629044066b.27.1719401021814;
        Wed, 26 Jun 2024 04:23:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe03b4528sm497772166b.206.2024.06.26.04.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:23:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/5] ti: fix dtbs_check for some syscon bindings and DTS
 node
Date: Wed, 26 Jun 2024 13:23:32 +0200
Message-Id: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADT6e2YC/4WNSw7CIBRFt9K8sc8AlrR15D5MB5RP+xIFA4RoG
 vYudgMOz0nuuTskG8kmuHY7RFsoUfANxKkDvSm/WiTTGAQTPZN8RJNxIW/IrwkzYQoan86g0oJ
 zOYxmUBLa+BWto/cRvs+NN0o5xM/xU/jP/k0WjgyXyySF46zXk7o9yKsYziGuMNdav30DErS9A
 AAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gyRX6BMRwTjp9tbvhfodRaMKXdFu348jPN+T/jpCZZQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme/o3OZoK1xl6KrfeHdtFr76N5ZUXNO56zifi0
 leu3xMk7zqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnv6NwAKCRDBN2bmhouD
 12SmD/wIkl867xQCNtoObqomzqU/87HuWhHHQoIo3IdY0/p9jFQfvCjOFwZ7eh2ENxDirWDR3fO
 Fx/zg1ivIezBHuKqcFur5AXYLseqB4/EPaXo2LUmB+e0CoZC77Y+Z1ojc9dhx1LUayLnjNUJ3fy
 +TWu/SU4TOLU326ZrY26w7NklsqXc9LAKCKN+L1UXL8NEsmnwTnMRL53rS/1HgAxuniHdokcTSv
 olg27JyF2LDrRpf1WekVNzm43N+o4AzHaYpMIas5DfiEpa9T9krOA3la4s+hHEIEn98ccP2qm8k
 Ngl/VX2oO6yp+mjmgZX8NfhVNXH4iIbvnUrxUD9g0OYKc3NghxXyEkjvmNm3vUosAZSFEnYwmM0
 QQhGNRCITHzPtAciogkNPYfd+Q+TYLEeYQroePt+l0iIvYij8twKvupu5LqZU9G7H3Ve8nVYTSo
 +EWydNZVVchnFyp6o1gyD+JWc+FFBJN2SqkE9NxEfHumPVSg1WDYVsRSLKtnMNJOHCDt/WYN59L
 pfpuh+EAPOO1b2f42fJTnQnDTsbMhYMDA5mXb2g6gsMdlTdGZHe6wHOEL9fYj8MYtuQ8+aoJrg+
 5qBdK1/qP/PWIVBRH7TEYiRw4DH4ZSHjutnA8BcM33ESnA+gWDpzZyOsKSg+x2GLS1V3E9yDsg/
 CE6yRZLFPZuYf8w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v2:
- Add acks/tags
- Correct Kishon Vijay Abraham email
- Drop R/W from title of bindings
- Link to v1: https://lore.kernel.org/r/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org

I am in the process of fixing syscon/simple-mfd bindings (to be posted
separately) and found set of issues in TI looking independent of my
series.  Please apply via TI SoC.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      dt-bindings: soc: ti: am62-system-controller: add AM62 syscon
      dt-bindings: soc: ti: am645-system-controller: add AM654 syscon
      arm64: dts: ti: k3-am62: add dedicated wakeup controller compatible
      arm64: dts: ti: k3-am65-mcu: add dedicated wakeup controller compatible
      arm64: dts: ti: k3-am62a: use a specific MCU controller compatible

 .../bindings/soc/ti/ti,am62-system-controller.yaml | 77 ++++++++++++++++++++++
 .../soc/ti/ti,am654-system-controller.yaml         | 60 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |  2 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  2 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  2 +-
 5 files changed, 140 insertions(+), 3 deletions(-)
---
base-commit: e032bb82c315d2317a80506195d16ce4308d8cf7
change-id: 20240518-dt-bindings-ti-soc-mfd-ac211578d7a5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


