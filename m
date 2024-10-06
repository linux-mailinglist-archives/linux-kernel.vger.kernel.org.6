Return-Path: <linux-kernel+bounces-352383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA41991E62
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE49281D26
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188A176FA5;
	Sun,  6 Oct 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOpAM59G"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDB170A3F;
	Sun,  6 Oct 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219970; cv=none; b=Um/eO9ya2icNyHPu0NFLCELa6gwVUrBU0IEi0qZr7dyaVMZIWn8MxgU+QL3v7MQrNBtFBYBp+uhpO15l1j7nr9/L3Rla35lcz15ujdKWhWL0Uj01EBSiA3IutIMeZOdF+0qMirAOqLtOC0zTVbZHHq2bN8iBOpaob3HUJ77i7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219970; c=relaxed/simple;
	bh=ghsLtM0pTCsjVShmbZaKihMZoOQLife8+lrCa1ftocM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o2PWTJzOPGefe4etCogvnpzYPR8MImIx1wjBWjsjfjDWJEW9kA+Whirr72BOxa77Dy594kjhonFGonnngRj5vXKHaY5Nq+1SQN1sRFYaNEsFoH367WhGlzBBY0elsK5jYGl4/mgkYFUXZzrlxeIiYt4USvKNR3gzc3Lhx47wuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOpAM59G; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-537a399e06dso3670917e87.1;
        Sun, 06 Oct 2024 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728219966; x=1728824766; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCcZz9kdtfMEP9gzd1Dde8CK441Z4S44KrNH914zWQA=;
        b=WOpAM59GmRs2pGZhGXk6yoKv1pHgP5fVpTcpVMWp7gE3XkzWcacSTKTO2PpBmvhLUH
         q7Pf9hTF9xksx8kGtFC3aaR+xxv+RN0JtVhYEwrWsXvCagtoK54ng0VdHomiGMBB3Keo
         eB/FXWz6BHF2ELmU3nqYDxkYLdvWIzvohe0fWZ+AerRLw1wL2azudBV5+Z1umQKSE5jr
         JdVQ+LNtf2i/UfiBGsm/mzGHnmcN5jQoXNj7K5z246iv6YSpaSUUv/+MG83VxDWW+3nY
         4YqeaxFIuggL7Ukr+mOc3SsMIq1pDMhUQY0XfsVUruMWLArsA80CyaeTZKRwMnAbnq14
         SCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728219966; x=1728824766;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCcZz9kdtfMEP9gzd1Dde8CK441Z4S44KrNH914zWQA=;
        b=PXdbM/FKYgzQ5Kz4wegKI5MsVbdAo3hjz1qkxx/9PXzfaJcxyhZV7b2SPo4V2IelLG
         +KnN00qyTOYXlBHvY3Rz6vrigBw76q7B5CzOTSoEZhV6mNPQiWyW2J9v/T5yGFNc8Y4r
         GcIsXD3PY89AerRDkyzr7Z6QRQYB1B0idyOF9Z936G7E1xuv2e2ywqXvrJusWNm1EqYC
         b3zum+E0gEvsbiM2dR0obrclgHtJQ6W6zRjirUu/neVMs5gw5S4pDCm7Hg+gi1WoYsgH
         /QgqleSsu22ZlrnW0bxnKNAK25kqvd8CdVuMhk5MJRCNziLLjIbtuSSixQwdxH/JGm4W
         Vh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnmlz1IAGFKs/+hUObE2IPWg7XI1xXRdrgTsjSHCh8HfqGcQA+M/H1IxDWzJXKQnHuyh3CAGKlUaRu@vger.kernel.org, AJvYcCWsOzJAu7TUDH6LI9arVqW2kNNYDL2f+bMaV3RD6Ksi3qmHZSrZMk1Lbk15Wwf5PrAhmqJgFenZPeZfmt0N@vger.kernel.org
X-Gm-Message-State: AOJu0YySQ7OZAKLFBPomAMY9qUOTuZTljUVRYFmBfFO62c+cBeR70454
	srISIMk8CEpZ7//S82nPFLnod505NiVuhyNyWD03/29ogACa0qbgxBXrPbGC
X-Google-Smtp-Source: AGHT+IE7ir8o4cWTVBT0eg+WMbzZaxX6cQc8ByXueTcuHKSKXe/X63JB/yfxgYkQ0h+8EibvR3ZeDQ==
X-Received: by 2002:a05:6512:b11:b0:533:482f:afb7 with SMTP id 2adb3069b0e04-539ab9dd601mr3908904e87.39.1728219966177;
        Sun, 06 Oct 2024 06:06:06 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2904csm512749e87.304.2024.10.06.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:06:04 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v4 0/2] Add support for "on-die" ECC on Davinci.
Date: Sun, 06 Oct 2024 15:05:45 +0200
Message-Id: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmLAmcC/13M0QqDIBTG8VcJr+fQozbb1d5j7MLpqYSVQ4dsR
 O8+C4Lo8juc338iCaPHRK7VRCJmn3wYy5CnitjejB1S78omwEByxjgNo/NIDUNnW9CtljUpv++
 Irf+unfuj7N6nT4i/NZv5cj0WMqeMGuGMQa6sbtytG4x/nW0YyFLIsFewKShKcM1V7bS9POVRi
 b1SmxJFSdW4xgoAUHav5nn+A5wxjpQGAQAA
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ghsLtM0pTCsjVShmbZaKihMZoOQLife8+lrCa1ftocM=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnAosqO1hp6WkL2wUfK/sEBFv40JZaYb3nufEcC
 dYzCtnQXoOJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwKLKgAKCRCIgE5vWV1S
 MmWhD/0VPUd1y9HkiwZx6DH1BspK+8svEoOP1SgHpOn9YL2ibIrZVxZjAow2ErycSLDAOXdl2JN
 lJoSXzgIanN/eGkI6CqaeIdCB2iijSR6nVbt/F2TQkyNoZAuDF5xAPoFC7uQ3TQjZ5u3yl3E+rv
 sfgYhv2ixsI6oIegsjtUluuJognI9Nw9YE/ySASl3nCDuBROL/49rrAYZ/dTzsdo3VauitekGUN
 MF3ZMbpt/JqGLemE5Fb4rLSaibH7hTm4apfGbvUFCmedg2Fd2v9N08xze2lyHeFsD2d+FrftaE1
 t/uf4604gt8Bihu620WpH4Ihlcdx2/gOzeeVUIlXptwRk5ifb1X5VGolr4ZNLgcFp19L/QiDSsf
 oRcjJW0siTTcRQwhx4iNFko9Qg3N9KZY9FJVtg3K7Apb6gdzyoO6uskK0FUDsWEMZYup2gNrA1A
 Uj+fyNQPViWKAUGm0lIKj9gx30+rJRp+TmvZ24lkcHqaIHvVwvARHb2pRjf3nbfl36+g2nRMofy
 UbV5lsdtcV/e9t1w3rd4KDaN6XB67IEztOzxFDDqwz0VFp4rBMUcFhx8Sb9DqwbG6qlSfMRBN3V
 NAk/Pe2rppQolPlu4xv7i4fVGDvXrNLW7LMEtEOf+cj2yog4ifYiUa4sdrKSwZWhsMQ2YSRtkrO
 EszNyQ3ZeUfP7/w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
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

 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -----------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 115 +++++++++++++++++++++
 drivers/mtd/nand/raw/davinci_nand.c                |   5 +-
 3 files changed, 119 insertions(+), 95 deletions(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


