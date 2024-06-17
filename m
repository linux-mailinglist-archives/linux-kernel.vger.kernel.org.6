Return-Path: <linux-kernel+bounces-217296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C390ADED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99BCBB23EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD7195817;
	Mon, 17 Jun 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOj33A3x"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08766190052;
	Mon, 17 Jun 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627327; cv=none; b=OI55oe5Zj7yH0ALaE2Kki/Hg8B7eZhSlkP2ezdGue2Nsz2k4thCWQH2iAbDuJnkfHYv2blkNGBcZJkGzh9275DySSP0tgo/Q+SBDLvWuE7girSvDhy+WHV2TiOpn9EE+S789W8xm7EM+m0S4/fTGOK3F0CVWy/6msm40VhLZZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627327; c=relaxed/simple;
	bh=acUhcgcE76YHRT7EWreWL5lmF3NgLUrREHXNwwfcifk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZDMwNJQcQQWW032SDx8344GjFKHh4LgEgcW3hIrT4LrW4mAilSiJdhsTqjYQN5poeP82Ll3Eb2SkqMxc9F3NhGtJXoNP3Wru8K18Z/xuHG62cYca2XM966biYAaosTcSRI63Njjskp+GLddr+NKE9HokxArnmVa1Agie9Ik9uEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOj33A3x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f65a3abd01so37194285ad.3;
        Mon, 17 Jun 2024 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718627325; x=1719232125; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcuZ4Z7Ju5cfGFg1cV6UdejBbxf9VioHEUYBDgDrB0Q=;
        b=hOj33A3xoQrSzPhqvKutNOfOm2Hf65ZWDBBJtxciHgL2plHqDAwoS+zs7OJWOt1D1g
         t+lFI2EQuyOjLuSNQzexpQ2/prTv66JFxMHdkgM50Jjd+aX78sE9WKXkpb7EAf/fDYWt
         DltyB7xgfVz6iZPFFNTeL3LBazliRpVHmdwDiat32VUxP4GTAHfoVDr9Iie44ZI7aEfF
         u8gFhof3NVybNg83HgxQQihNfj7/WFKqso5DhyQAjL8SQzIuIH7GCfbvQPpqxWdaDNnn
         XY+zHifbrF3AGqlGY3mIr17MJ0tD8mUUfF8NTescKKPTuMzZbaeOVXjtDnWtxhM5T3jn
         QB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627325; x=1719232125;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcuZ4Z7Ju5cfGFg1cV6UdejBbxf9VioHEUYBDgDrB0Q=;
        b=bWJz++0MXAmo7riQ1ZZbKuRqvzCAo36RWZBUr4pZxEXqhOUYLl4bKBWWlpZFBYSfaa
         ZrhJRddk653rOu530iy/CnIqDTc/yZbs2A9XT0N/23TLOzWo480HfIimbtkPfU4vearX
         rSIX6Vfcy2i4hqsyzzg5yps2hBCBgLYf5sqOOT7OAJw+00cOUn+CZWLlKgvpvP5HQY8I
         elluLFsYV8DzsP5ElTFP/4tJZg/qY+CW7OzcP7lQnjtg3jlivT+abbwIKQglayorfcPO
         EKD7VZlC9shvl/a84LOtT47j+CXOTRBJLQqNtdqMap38nDpd5YDw9msKx3YC1Q+8aH6p
         Lm4w==
X-Forwarded-Encrypted: i=1; AJvYcCVeglM58WYcbSInn6HA9KvxKGTxT3/NbfF+1Jk8rr/jz1CfCPArYcrsEnzAcNpiXh89ahzYMHP7HBh8WP6mhgO6Li4DvMA/R3NVccClojkqqTw3KIZNwVC4Hvw4f+NlzabHwzWuRdr5Fw==
X-Gm-Message-State: AOJu0YwIO5DNd2SIyGSk+Xnjm2/ue7Cy6+78xacSjXb6cZYiWRPVEI0B
	RMqkrjHSjoFiek+QPrCmPnAVVbhjWsasecDAfjNo8yQXm5RBIMei
X-Google-Smtp-Source: AGHT+IGyHRNgKJh45646E8uYDC+bSaH38nJT4cO9mjlRduQPYsbfvtwjmjWJ5wLl0K8+U8Yn5Y07nA==
X-Received: by 2002:a17:903:18e:b0:1f7:1a9:bf07 with SMTP id d9443c01a7336-1f862805ed4mr127085835ad.52.1718627325155;
        Mon, 17 Jun 2024 05:28:45 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f855e55e0esm78221295ad.26.2024.06.17.05.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:28:44 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Subject: [PATCH v2 0/3] Mediatek MT6358 dt-binding documentation conversion
 and fixes
Date: Mon, 17 Jun 2024 17:58:23 +0530
Message-Id: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcrcGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3dwSM2NTC91Us7S0NPPUFFNzE3MloOKCotS0zAqwQdGxtbUAdnq
 XsVgAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Kartik Agarwala <agarwala.kartik@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210;
 i=agarwala.kartik@gmail.com; h=from:subject:message-id;
 bh=acUhcgcE76YHRT7EWreWL5lmF3NgLUrREHXNwwfcifk=;
 b=owEBbQKS/ZANAwAKAXiEk+OPlULqAcsmYgBmcCvy7VPep82WO7nrdwh5FthU+b7H4HVzXvK5Z
 7Q3l8k7UUiJAjMEAAEKAB0WIQSJkbnrkCGnamD0k/R4hJPjj5VC6gUCZnAr8gAKCRB4hJPjj5VC
 6jBtD/94FNnjYYjItI/I7RseHUXUaSVxhFsCe3JKdMxEG1k6nTKfPSTrOwy25+BAjKQP/XEZOdr
 1Bnq2SbxdPmDnLvvNK5UvQ/uZI14uruWTHW1oNe84VffNFLpdXKI/olbCfvcBSLETkWYQilgpGr
 5HOIjJwhN1VKwX8HgbjNaPmqL5SCl4EK99+kULsSjkYrTcIEhFRN4xWjw3R7uhc2BjBwIqE4JR2
 38QvlEzvqV3Mwg0hI7qpmuTXyV3I0uQctf+UMniLr/vrziok9OTf7xz1WTsoHpZDFdAYfCSAC+Q
 2IGUsTfR4ob3UD5ImwDMzkT1KKPASu8lBiJDRcxZStDlJfYOV46dmUBLhGw4uVrfix70GKCvJcm
 lq/r0V6wNW9wtnsShd2RHrsJfIqDIH3tsYA26GsUKW8ch5zRY4mHy+f/OQ8OXJAoTVn51ewsPSs
 xKYwM3IUtUFRfKnjxE8RFmGuttECUmJYGac/FanVGoGockGiFOcmc26N0uxglaXts7fOJCizPNE
 jhc6Me06o3p6tmN0lk8cCJiVPwufl4WdAJoFdWt9lLvSi4svTVAon83kqleWVJa/MnvqP8rptcm
 3vvSQw8R1FzbUW2gtBjmyosfYYKFIaseI++xRsDM/EcLS58ixgR37AauObraOq1d+381XGu9rHQ
 SBQk2pYq4ti1EoQ==
X-Developer-Key: i=agarwala.kartik@gmail.com; a=openpgp;
 fpr=8991B9EB9021A76A60F493F4788493E38F9542EA

The primary purpose behind this series is to convert the Mediatek
MT6358 Audio Codec dt-binding documentation from txt to dt-schema.
Additionally, it fixes the dts for some mediatek boards which were using
this dt-binding but were missing the required `Avdd-supply` property.

I have also updated the parent PMIC txt documentation to 
reference this binding. I have not added any new examples as the older
example already has a codec node.

I have tested my patches against `mt8186-corsola-steelix-sku131072.dts`,
`mt8186-corsola-steelix-sku131073.dts`, `mt8183-evb.dts`, and 
`mt8183-pumpkin.dts`.

To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>

Changes for v2:
Fix problems with the `compatible` field
Add missing required properties

Previous Versions:

v1: https://lore.kernel.org/all/20240518081621.63386-1-agarwala.kartik@gmail.com/
---
Kartik Agarwala (3):
      ASoC: dt-bindings: mt6358: Convert to dtschema
      arm64: dts: mediatek: Add missing Avdd-supply property for mt6358codec
      dt-bindings: mfd: mt6397: Add reference for mediatek,mt6358-sound

 Documentation/devicetree/bindings/mfd/mt6397.txt   |  1 +
 .../devicetree/bindings/sound/mediatek,mt6358.yaml | 51 ++++++++++++++++++++++
 Documentation/devicetree/bindings/sound/mt6358.txt | 26 -----------
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  4 ++
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    |  4 ++
 5 files changed, 60 insertions(+), 26 deletions(-)
---
base-commit: 617f9a0a70e8bc27ef0343f3abac1faeba07cb71
change-id: 20240606-mt6358-e6fff7ed5747

Best regards,
-- 
Kartik Agarwala <agarwala.kartik@gmail.com>


