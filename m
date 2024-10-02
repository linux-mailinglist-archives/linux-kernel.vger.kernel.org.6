Return-Path: <linux-kernel+bounces-347204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115B98CF6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C02287DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C8197545;
	Wed,  2 Oct 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtbZjfob"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEA195FEF;
	Wed,  2 Oct 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859724; cv=none; b=ljpZ518uq8asYCZUvPRyR+h7rDpa5Rrhdq58s137q369iqOBbYBVCT6V+utHSz5PG7tabKvVGudtKErua0Kjc0jpyxB5Dj0271JGc+q1kLPPg+y/zHWlOS+nRQEDgnFKuPHjGBI5MXZQYq+9HS1O0f/j77xV9JCPhEwvFJNGuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859724; c=relaxed/simple;
	bh=8meIdJc4caNICYlngTOBCzIaijDqIpYkF0ZnEQI5slE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C0AYPcuYlQ3Fdz2h97kYaooIgTwKGPaVozxZlwT6e/O+0kUukn2ZZmdotGMSX5RtD1JVqBOA1+233I6seoHoWyvZnEG/+aBa+5z7Sypu75zIsmqb1A+cm8Beo4iX9feRcR97AL16VRU3ou/+m6f/Q714kGA4EkM9gYOXBR6kTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtbZjfob; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5399651d21aso2729015e87.3;
        Wed, 02 Oct 2024 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727859721; x=1728464521; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mdt5JpVP0bgRi2OYH9kKycUQi9eynDQkDEKQZICX4Co=;
        b=ZtbZjfobM/0+40LOTvLt//SRYvEQRVOciHCRKZaPBq59pq+usQZql2VcXksqMi0Dz8
         yNntyELLHbntSOwRP1Zvb5Dg5VaKfTwowb0ydTwao69Rd2QRBTSB8FMAO5ecGofxjWnq
         29lhwv2kP/lLHdzLOBX0QfKDVyRAgSCXbIrnY8fs8Xr19Wo6BD1tFgUPHTtgIUAw2QXH
         jp1sM6es5yA2CPTyDeXRzgvHKpbNQ9Zkb/UEg8FtkQBbZMkfNDklMrw3osiPlhqua0B6
         bVsPO8CrIHIMEpfXOt32Ng15vhtLtsksOuUMG3cENeo7X/MuF0+a5i3MsDVeXIY3rVw+
         M7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859721; x=1728464521;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mdt5JpVP0bgRi2OYH9kKycUQi9eynDQkDEKQZICX4Co=;
        b=BW0jKtKT5cXsGfRiy3grP84KKkDWggZmxCcroZE3MszfKVFfO2pgDqNH3+oMrogyGs
         dg+9aAueNg/OsErDHIVlSgma6LYW3eFAG9TlxPE3fnDRGY0TkkApi8WaFTSvcXiaZ/xO
         8TUWz/265zFPSdwzfQMWHqkHVrru9BbX9CNwxuj5KqsAIB0cj56YyuVrzFgW14KbcV/8
         SaYaRahKC/hulvdiyoKX1Og6M9lRHivhkIS4MKGlR82OsuaciG2W/yagXNKqI13HLyOJ
         /bFNlzsFNIhHGxrXJiJtntv14krpTQu7oMvJuoyiVEm0QVV7gjd96wFXTLZpo3D3b91p
         0GSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkbdK0UhLDvBHNmsaKZYs8QuHxXJT16gDBWf1UepnVHJw0fphjltAlQEYPAWbFIbpoPGuUFweIQPga@vger.kernel.org, AJvYcCVyXL8WdYt5ry7atByixYTLYk878684+PKduEa0u6nONdHDzc6y8ry5xlnPR0qNf+7NhU9bINxpflCsX+r5@vger.kernel.org
X-Gm-Message-State: AOJu0YznaHpyq4Wwo+enJ+cDYqpzPsE7LuqEcUI8sTW6Ctcr1bjZ3e3i
	l3ZCa5JsH+MP/16VzVkZ9yF5zGJBiPZ9GTWkIh7zjXraNqrbtNZiiu6hsatd
X-Google-Smtp-Source: AGHT+IHfKTzoRILZlEbPbQNY2zPqg62hxRIoGve0tiIWH1a/ccCzD0zQzlfsvl94cpRVs3mhRYZlcQ==
X-Received: by 2002:a05:6512:b1e:b0:533:40dc:823e with SMTP id 2adb3069b0e04-539a079f87cmr1141569e87.48.1727859720451;
        Wed, 02 Oct 2024 02:02:00 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5e35asm1846796e87.85.2024.10.02.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:01:59 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 0/2] Add support for "on-die" ECC on Davinci.
Date: Wed, 02 Oct 2024 11:01:29 +0200
Message-Id: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkL/WYC/13MQQ7CIBCF4as0sxYDtBp01XuYLiYwtJNYMGCIp
 uHuxS5d/i8v3waZElOGe7dBosKZY2ihTx3YBcNMgl1r0FIPSkolYnBMAiU567XxZrhC+74Sef4
 czmNqvXB+x/Q92KJ+679QlJACe4dI6mLNzY3zivw827jCVGvdAWM7kPGaAAAA
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=8meIdJc4caNICYlngTOBCzIaijDqIpYkF0ZnEQI5slE=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm/Qvztcylyg2i9IvFjGRswRfM/IX2KS02h+LNB
 cuD9qV1WnKJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZv0L8wAKCRCIgE5vWV1S
 MkuJD/42ebdEUeBp2YdpxxLBblcIaVVFjvLxieaagA8+Xa+A2lY85zFkOuMU88rXYuLgBuy5Se+
 3DvMIA3t7bDuaJ4kiSiGyabi3y4QNonJTsPZ74UTo/TV9siPTmbKSyUe2TLOT2py3u+uQRv481d
 Ye8EdFmi5V9qeR/T4WSvCUNwreSz2b8bDPm+AZFEEHEiBf4U6j/exxUwlT7NdmMqBKTs9yaZ5vh
 xhjsE5YFIaI+aRWRHahH+N6Koc48c2J0xGTZMqN0JDTNu1JA1MSP1kn61X4dYKSu8vGuPTB0fkC
 FK+KT2bfCqiXDEjQZjMuRPhR7u1jdcjQ96z5Vi4/M1HOxewRE3FFwad8Qo/ROZXu8uj9g1QNIYa
 Y3I2H+iHzwtwPK+2LAYZ9fnV2z4vcdw+1K7FJj5f3kGLR18dNKk21i+UD0oUS8YLP+FPJH6PXxf
 n0mvXbXZAbMZYXKA+ONUv1yXcWQW9e654Xomj3sXmoyw3hGiqtiJ4ul8DRX555u1h94owkJANqs
 4Guh8AOWo4Dd/TtKJO/YxBciPBq2I6AciFJTfuW7bgWBMToxJKYPwLH9wpjr0LNMrvCC+ahQLsA
 Pp2K6tl61P6nuCAPrBjE/uQHr+4vKmO5/RykdhZbpYQRL0ik16O4ubRXuiEyZB3wWDf3FusnPq5
 T1wZ/bRGZJs99Yg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
- Convert dt-bindings file to yaml
- Link to v1: https://lore.kernel.org/r/20241001-ondie-v1-0-a3daae15c89d@gmail.com

---
Marcus Folkesson (2):
      mtd: nand: davinci: add support for on-die ECC engine type
      dt-bindings: mtd: davinci: convert to yaml

 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ------------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 105 +++++++++++++++++++++
 drivers/mtd/nand/raw/davinci_nand.c                |   5 +-
 3 files changed, 109 insertions(+), 95 deletions(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


