Return-Path: <linux-kernel+bounces-341222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67140987CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0441F229C5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB46166F26;
	Fri, 27 Sep 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owrogbzn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC7EAF9;
	Fri, 27 Sep 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402876; cv=none; b=lRff+en+7hpLqVKNBCBocsVC6vdvxE/vQOF25PNR4+BTn43XqGBgIhu1FKpUa7ltscKpltnPeX3ehhvirpaDkTboAvNwPOXRB2SIY9dbDa8jVOtoteL44z9SWTGbvYD9PEMOZUqvv66xN4gW83KDVLobYfn6BmEBTQbLiaa7oUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402876; c=relaxed/simple;
	bh=ODAULKlGeqZPjHKOPSgWJJHk/9T3V8RKIipOAzU/J78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qiIRv1yoyT43YLzY1Ld0Ds694+A7FwlMSb6jSfN3VL/wKEN5K65mnP/RzPNF06aB6pOxyJby+/U2/PSUeJc6lcHuof8E/msbmuFc0zXz5W9hZHGu9iEz/DpLTJWXc4gz2HeIO/a3DH+IXJ7jEuU1ULjKBTWztrQ7X5HiKaHtTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owrogbzn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054feabfc3so15153645ad.1;
        Thu, 26 Sep 2024 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727402874; x=1728007674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5bbGVPh6/6c2QiEue2t4qR20oS5dvI/1sc1D2hHOCY=;
        b=OwrogbznYv1emPKfcCo927l9Kld0YfGxBIZHyH1nkb5R629GYUp3Wf5LKgtVBnL2iP
         Bu1SQpTUO/v8ICY9XDoyHbAXqYS70Hpr6IQ3R5OtTaYwjJs1bJvK5AANFISXvbhuSc2Z
         oRBKKhqIHHxVmLmewYkvZC2RiFKpCnuWIk2seElNH+TAnaWPuhddobwK61uyhTDQl48j
         li2202hbL8HeJuXQWV0VfK1VZscdCZH/YZ9FkyEGNsKQQsfSVU8t6UriAdcSAza563HX
         ZaERpFzQJCtrrZU+sQvP8VFUwPybF/uQU0sSo30Cv1p65ZOhPb1lyGrjzNF1ywLMUnRD
         dkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727402874; x=1728007674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5bbGVPh6/6c2QiEue2t4qR20oS5dvI/1sc1D2hHOCY=;
        b=X8K8J+5ND6/Q03td2ujiXHfkAwc66GJ+JEuymWkQDJLvPxZEYU91t1ZFiOKqP3lthd
         Fl4SI/34vMI3fCaw644dC8HPYJ/iXTlB3hsKZ1srA4Pwv+7xAgaKc27Z73jiJG/RV8hq
         JS6WRKxgwyU4NF4WTFCLIReCN80j6Blxu6cyXBSj3GJHuKWkgeXx26k0sR2/ndagGa2s
         91f2lXKek0brQSNXVifvvEkuuhUE7BISghQ/ZJ8W8kjk9h5aUBERZRgBFlO0hq6PVz2g
         MLQo72qHndDIzHYWRZJz9izjKg3mVq6RPENVHgnzpWHlztc8qaSvSFlGxpJVFgDBfoqp
         aeNw==
X-Forwarded-Encrypted: i=1; AJvYcCUJWRW5MnRPTGGYLNB/8t7gnMDkMNiwQCtuoyTIsylk3kKspOpXtNQXVopZVbceXL88uhrZ+9Bhf/bLFuCh@vger.kernel.org, AJvYcCVDTl4rRMQPiO6au+6kvSywPS78GDccHnzxh33yRGF0Px/FK8TOKF3F+sAo91PqNzT9Oi2ySFt0odNM@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTeYkaC4aD+YGHkJA63H7jvbRNqUig3EzX9XzcIpHyZdwkwVd
	wMKnB/hymWsMmH2BeBl5pB4lHv9SynQB4C4Q3pmXzAgCDoL6BuoV
X-Google-Smtp-Source: AGHT+IFLx9maQwPxVGEd7pa7DuoT1tNIhrd8T1DIxF8JHJzGqlpTKvr5gywO1ZB2ijS0NWtgYCWT4w==
X-Received: by 2002:a17:902:e850:b0:1fd:67c2:f97f with SMTP id d9443c01a7336-20b36ec8c9emr20448605ad.28.1727402874441;
        Thu, 26 Sep 2024 19:07:54 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c66e1sm561022a12.47.2024.09.26.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 19:07:54 -0700 (PDT)
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
Subject: [PATCH v6 0/2] Add support for nuvoton ma35 nand controller
Date: Fri, 27 Sep 2024 02:07:47 +0000
Message-Id: <20240927020749.46791-1-hpchen0nvt@gmail.com>
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

 .../bindings/mtd/nuvoton,ma35d1-nand.yaml     |  93 ++
 drivers/mtd/nand/raw/Kconfig                  |   8 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c    | 862 ++++++++++++++++++
 4 files changed, 964 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c

-- 
2.25.1


