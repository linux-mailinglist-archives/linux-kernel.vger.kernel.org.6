Return-Path: <linux-kernel+bounces-400029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD55A9C07F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F02B22FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B5E21263F;
	Thu,  7 Nov 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IotH8Ip8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16072212632;
	Thu,  7 Nov 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987255; cv=none; b=S3gIcUld9BbTcKSVrX9KjDLgRdu3UYKTHX5h8h+u+0bE6NEIrRY+pT2tYmHn+NyuGsk656rZJMdkJw4f/hcocAYnGE79ov8+4TD3tbr3L4eyDNWPR07Wcne5JojafuNolCB3+9JLIInxDv8JC6GscuwBnnDc0yvZ//BRz4y3YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987255; c=relaxed/simple;
	bh=WJ8sjTdsEHCnUnC4snAJGRK47JStvms0dYfAUbD7xRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rix1vheywFrqYaLqQePKPFieXwGSxK/MBbCV/RuNTrRPxVvbV7SSsdX+612DfqNgphlIzduDoEHKvH3lIXF5FUvCJI2Y0tces+NTqpmb2Fy6pJJGk9FxM9WlqgBR1VDA3qZi7mf0adwf4OQbLaibRCY4OiisHrPGW7uJ2029cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IotH8Ip8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so15460391fa.0;
        Thu, 07 Nov 2024 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730987252; x=1731592052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vV/uqLIwRRvbtNIiu4DCWvHhI+US/wd1+j/rWmR1oUI=;
        b=IotH8Ip8B5pd77ZtwMXJDlaCWoMAdZWJ1oBgJJXCFUDS3hoI8SPnKbUAjReRKK9enU
         KA9HN3JYslWPU+zUExfZDz9rZFJlY8pDUGk+KRWyLAE8tu4/bu9V3NwvgkVIMnkXkzFx
         CrXgD7dqh9Khnqf5R/soSQTcsggAl8AR02WKeA7cwtYFOdzVhepKF/dY80hWupGO/XBw
         M3FJjLAGXZSMOa1vyUdszi5YoaFqvnAg5Fcea79CKEeaY3MprKaybLNzVD0zD/EneQd2
         4+7QrE9kcCz7xV9t9NqaOomXlpakpmL3MNRtb4sm997Xg5eSR9lJHiwb/38ji6CagNRx
         /MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987252; x=1731592052;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV/uqLIwRRvbtNIiu4DCWvHhI+US/wd1+j/rWmR1oUI=;
        b=V8c8B/RGZ2N6NGKI2WSbDDRmu7xXeQwDzO4b7xVvBptjiB2WYKYUQtJuWkX3o+kFEh
         Pwm7I+SnWrVLbZP4g49oDnMV4cts+SiDf+wAx83ZdGOPyD9MeZqc0FkdNwI3tnNWlfq8
         HoKkYDUlJbpru49YWYLafDqeHuEO4V1CTGksDyP9sVG17RFLk3EAFXbGhqRlSl2XrNEb
         ahacX+TjejujrB6yGGKLSVHYycb2QjB5ah/tRz+8A6ERtvJ6+KWIk67Um6kg0Xt0haY6
         CBPYZqY7v2MXuxZI6n6vS8aLbxO8XGn5ebglzP6XCmS8Fz56vL80fdXlti0s8KfhzTPQ
         48Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVHOEkl1VP9y4vPfsq3pnOGOPJ+g1d7GMCN7z7T4WR2+iFWMu9NHUISa9QO5pFG4WG9qEdw0i5tqrR1@vger.kernel.org, AJvYcCWwWAWNWiDdgOLXm+hRan67HqszazxK/PtDQBlujB5xK08vx1IQgJw858xBuG2WggSLb14bF8nhy2CPBOE4@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQ3QnCQJOq+nmeVeVC8H6i3criEqGM/dqTFej3UE+GIdc5PNQ
	6feP3doZ01sOOO0ahaG2XBXELNs3D236JKSdyUqJgUzwqO1a9FeF
X-Google-Smtp-Source: AGHT+IEhC6iR33eZ4lfH/xse0Rl2l82Dcz6hdxKltt3wqF0Dap5B4TG2pXRT6K+E3wxcui88TP6z+Q==
X-Received: by 2002:a05:651c:985:b0:2f3:eca4:7c32 with SMTP id 38308e7fff4ca-2fedb82fd05mr190609691fa.38.1730987251737;
        Thu, 07 Nov 2024 05:47:31 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d80f5sm2276591fa.105.2024.11.07.05.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:47:31 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v7 0/2] Add support for "on-die" ECC on Davinci.
Date: Thu, 07 Nov 2024 14:47:06 +0100
Message-Id: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrELGcC/2XOwW7DIAwG4FepOI8JG0hgp71HtQMxpkVakymZo
 k5V3n2kEhrKjr/l77cfYuE58yLeTg8x85qXPI0l9C8nQdcwXljmWLJAhQaUAjmNMbMMiiMldMm
 ZTpTdr5lTvj97zh8lX/PyPc0/z9oV9umxYQWpZNAxBAZLzsf3yy3kz1eabmJvWLFVWBUWpcGB7
 aKjfjBHpVtlq9JFGeujJ42Ilo7KtKqryhSVkh98ij44+PehbZWryhalDFAwRGSZj6r7U6D6qrr
 9Vq+8spEAh9Sqbdt+AZNSmrCoAQAA
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=WJ8sjTdsEHCnUnC4snAJGRK47JStvms0dYfAUbD7xRU=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnLMTjRhoFLSc1KkTea75CbUx52FGWIca8jGOUh
 0Q/vRra0rmJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyzE4wAKCRCIgE5vWV1S
 Mh7EEACUOTW2UOgo3EXokp3j2lSn1V+dkGhtTDeUWImo2wEb1sycObdGPel8gSlhFkPDHn01bMr
 oiSMtL/aubKsmvJQUBbtlSxjVdrEnEtWb9GnSoi3weGG/QQpZ1SiwT1ze9Ut1aV4ijLqDIk3ddM
 uEcSpN/mtO5B8TUhjLLSgyhqUQIpFnZe1qbk/uf0D9ZifWjzqdOUldGR+jrunKlbJpcKx1P87P6
 pEmlKd1lcmdtjbHXKd6l2tXnL5D7ynAX5j2n7snakuvrpHbjJ5Ihu13PfcLtmOWnGukRl4I/QvO
 EfO4EPASrK6MCmPciRTvIRAys/9gvakWTWxxmAcJ/wN/C3NBx1XHUeno+qWo8LFZDs91c+yoaRZ
 vqANAQNoO8kFqkC2Y1L7SllTfHeQqjAq/9rlrki7IzghHtT+zt5sIP3JehcrFkMlcmbs9pPYccf
 WtTS0HemX4MQzC2RaWofyWkJpKwdVEoDO03ZY3MPyaXlqXJq+7uU3POkBikru68BAM0KZO6iKvO
 CyikwH9U20RJExmh+68oNHxzqynnt4wxhd5kOSzKQh2gADfZJQ/7h+MyScrqDQ4RJ9hm/kKmS0z
 R7eOqaUVLXvaMeetgEnzss6OB2jsOYjRMgg9HHR0appS+WBNeT/Wejnn0+BIT1xo38qlu9zBAPJ
 sz6qkoXmCuk7M6g==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v7:
- Merged description lines
- Dropped #address-cells & #size-cells
- Rearrange reg property in example
- Link to v6: https://lore.kernel.org/r/20241107-ondie-v6-0-f70905dc12bf@gmail.com

Changes in v6:
- Rework the example snippet
- Link to v5: https://lore.kernel.org/r/20241008-ondie-v5-0-041ca4ccc5ee@gmail.com

Changes in v5:
- change "additionalProperties: true" to "unevaluatedProperties: false"
- Link to v4: https://lore.kernel.org/r/20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com

Changes in v4:
- Silent errors in `make  dt_binding_check  DT_SCHEMA_FILES=ti,davinci-nand.yaml`
- Link to v3: https://lore.kernel.org/r/20241005-ondie-v3-0-459d9c32225c@gmail.com

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

 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ----------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 124 +++++++++++++++++++++
 drivers/mtd/nand/raw/davinci_nand.c                |   5 +-
 3 files changed, 128 insertions(+), 95 deletions(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


