Return-Path: <linux-kernel+bounces-377759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C199AC65A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C91F21B84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD816130B;
	Wed, 23 Oct 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrX2D31+"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E217B51A;
	Wed, 23 Oct 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675584; cv=none; b=LLG5BGiZHVEbwMzYjL2CtTBVaYg/0KYDv3/K7SdfXY6BZ6WZU5VoUTo/ylOTl/NjzLrk9mc2j4nJMizEJANU9ytQWalsfuuzk6dutXUPveKbgqYdb+iQwy4Zv8d65E+6Uaxl9o1BbiJWm6CSX5KJ8hptyP02vTDdwj7U+5pnXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675584; c=relaxed/simple;
	bh=fJX/fTC3VkauFZFAlzEkBGg7s1aCG/bBgJYXdLFB8YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p2HtWlwu9cE/2uDcbZSBlWRJEFBg61UFBFQIHIf+LrbmaXijUYUGsbKDdOpGgx0mZwvbA5JS/4ca9h/iCqXN4+xwqNNSXjrmra6SeOXT2UKuvDvJroHuRYzTbmpEVycSZz/RPkkqEfpCJfLjXi18szexxrdtwRx/HqAxiXS16eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrX2D31+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c7edf2872so5118385ad.1;
        Wed, 23 Oct 2024 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729675582; x=1730280382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqMTUrlhS9c2NaDPYna570q7ZTXS8TJm8rks4GyeT0E=;
        b=GrX2D31+0ZWyDFswD1r0DtNFC12IjJqXS2MJId2iavnbbU+hd7BQvfBaQT9/lmUqza
         yuSiTlCZjsUTej0Ij3fqG2cAxw0YzLrj3yz7+vtWZsGrvqAuR/+nevkLDE4e9CMM7roC
         TS8HSPyMEvckK9Aqr99TvlabwDCSZp7KERR+Tnv2p3q9+hkXQJNIxp+EXQG+bimVN2gi
         ZIBUIND4j8gBXzmsWFg1LkSHLUZAtlpjlmyO+FZSS+hZUdo/Q3EuCwgJ13t38XL6yyly
         CFUnyO4PCvxhKydYrJ4QwagQDqdpr9AB4lNVGG/OEuS9Rr7M0OxaVO3VLrD2W7Zrj3NJ
         RQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675582; x=1730280382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqMTUrlhS9c2NaDPYna570q7ZTXS8TJm8rks4GyeT0E=;
        b=PimOLQw5ip7IYnd5M2ckgWLH2Skx9FpzyALvI4RhN37dcHR4Fc25i1jcVvUWHYCyo2
         yfDHw1Qw79WcvDx7QthONl+3FzHp5+i3X5+SSQcgJXjeXBLZc7kC8cJGp9kfTCzrvySj
         U9t+wUg32Zfp6njE4LbjLcHsRUrdqnr/SkBC/XnmTNgeMAURy5qMaRa9BQveEogD0qGG
         xxzco9GaC9E0Qz1SzHhUWLzgJlYD8BOBH61HYRcL5zSNuqmeUM56Cp6Ilzmr2Caa1khb
         utYwOqjDK2wn53JbHvPv+lu7eLB04m7IX2nz2nQca+jaC+DyOrGsjfc7d3aleQHHOAKR
         TcOA==
X-Forwarded-Encrypted: i=1; AJvYcCVtiL3aSyJRRjfOae9CzaRcYd/nuBkxmqFWdcg70izZmcHe0hjFRmCTmjNWot/ifcb4q4lwKOcaSB69@vger.kernel.org, AJvYcCWeRry39Tn4u4MD76YjNOST3e75kaFuBV05ktyngLVsIX1s2te7JezmtuLoWhKI89lwtO6J+rwiEDKzMfHP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yXQn4G0QqznpDWSeMLT2OsktEJTEY3t/sPwkyW5RSXP6gZxI
	Aj/CbXQhl+Wd0895DoU6dubHD5UpppjHky1es9J6gXEu7NRwA+mG
X-Google-Smtp-Source: AGHT+IFfo4At+Jz5FFc0TuU6S0hz6vT2tNATHOeyiCdyh2kU4xwiqLCx7UFSkT/v7yeJ2rOtQj9TRg==
X-Received: by 2002:a17:902:e74d:b0:20c:9026:93a with SMTP id d9443c01a7336-20e970c63c8mr103663025ad.19.1729675582581;
        Wed, 23 Oct 2024 02:26:22 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd376sm54041635ad.132.2024.10.23.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:26:22 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nikita.shubin@maquefel.me,
	arnd@arndb.de,
	vkoul@kernel.org,
	esben@geanix.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: [PATCH v8 0/2] Add support for nuvoton ma35 nand controller
Date: Wed, 23 Oct 2024 09:26:15 +0000
Message-Id: <20241023092617.108021-1-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the mtd nand driver for the nuvoton ma35 ARMv8 SoC.
It includes DT binding documentation and the ma35 mtd nand driver.

v8:
  - Update ma35d1 mtd nand driver
    - Rename to nuvoton-ma35d1-nand-controller.c.
    - Use switch case instead of if else.
    - Move some parameters to be set during initialization.
    - Fix the ecc.read_page return value issue.
    - Add enable/disable ECC engine before and after reading/writing the page.
    - Return IRQ_NONE if (isr & INT_DMA) == 0.
    - Move the HW ECC related settings to ON_HOST.
    - Move hw_init() to probe.

v7:
  - Update nuvoton,ma35d1-nand.yaml
    - Remove required 'nand-ecc-step-size' and 'nand-ecc-strength'.
    - Add 'reg' for chip select.
  - Update ma35d1 mtd nand driver
    - Update space and comments style.
    - Add chip select setting from DT.
    - Add switch case which supports various ECC configurations.
    - Set reset before NAND controller enable.

v6:
  - Update ma35d1 mtd nand driver
    - Remove extra blank lines and add comments.

v5:
  - Update ma35d1 mtd nand driver
    - Remove unnecessary definitions and comments.
    - Modified DMA API call sequence.
    - Move the ECC check out of the interrupt handler.
      Check it after reading a page.

v4:
  - Update nuvoton,ma35d1-nand.yaml
    - rename 'nuvoton,ma35d1-nand' to 'nuvoton,ma35d1-nand-controller'.
  - Update ma35d1 mtd nand driver
    - Rewrite the NAND driver using the exec_op API.

v3:
  - Update ma35d1 mtd nand driver
    - Release IRQ handler.
    - Remove unused functions.
    - Remove '.owner'.

v2:
  - Update nuvoton,ma35d1-nand.yaml
    - Adjust the order and remove any unnecessary items.
    - Add 'nand-ecc-step-size' and 'nand-ecc-strength' to the required list.
  - Update ma35d1 mtd nand driver
    - Fix coding style.
    - Use 'devm_clk_get' instead of 'of_clk_get'.
    - Use 'dev_err_probe' instead of 'dev_err'.
    - Remove 'pr_info' and 'of_match_ptr'.
    - Remove 'module_init' and 'module_exit'.



Hui-Ping Chen (2):
  dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
  mtd: rawnand: nuvoton: add new driver for the Nuvoton MA35 SoC

 .../bindings/mtd/nuvoton,ma35d1-nand.yaml     |  95 ++
 drivers/mtd/nand/raw/Kconfig                  |   8 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 .../nand/raw/nuvoton-ma35d1-nand-controller.c | 932 ++++++++++++++++++
 4 files changed, 1036 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c

-- 
2.25.1


