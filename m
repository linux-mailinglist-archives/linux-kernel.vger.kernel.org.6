Return-Path: <linux-kernel+bounces-333998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5897D13B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4B428681F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938B40849;
	Fri, 20 Sep 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/QHsMWw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8D374C4;
	Fri, 20 Sep 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814276; cv=none; b=ltdXaoR8Z7/F/yigb6v6sqniKdY6fMlSNjJkC/hk1lx+1n4ZFWIrmK8v20UaRjJovsO6xHee6yZw2zO5RBjI/CkwKOOvkeJ6D5g6zr8foWttsFAHPWESwIQOJzB2I2YCuisWW14NOpnEH5Lhae44Kft2W4TYDsSnIAJeIP8Ievk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814276; c=relaxed/simple;
	bh=i7QjAZpJYAbbqAfZyVx24pkpTaum12kaTr79nKgc2UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BoOtmKAS1k2Ch7q/YUck8KylmZskR53u3Ndq5av57iTMCJwJlh2jqpKfJkhDdpBzexK9rTjdxiZDSHEMNt1Z0aHhT7uybQV5ExfZN16apKu1g5+Rx40fAaYUykgbBtULq/vTrrFfWVN5k369agja27Kv3h3uPeEVCIZiTyptiSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/QHsMWw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2068a7c9286so17907755ad.1;
        Thu, 19 Sep 2024 23:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726814274; x=1727419074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPEFOYIvo3FjR008iP8F+SdxzrmnQtEYwMT9hZJggmg=;
        b=W/QHsMWw13DI/APH5K+TMc0oX1rO9CCrHcHesEHRD8SzLvVtjZz60el9HpugPdtGpd
         Z06AuRlU8tAdDkFzXGR78wE9TY/WBvJpcJxfeACyMNnRoo3gWv5dlzHvZrev5hikOHMw
         7uGttgNCcWqSHdfgoIeO5XTbfZ6X1+tiPNhP3YM1vikB5RCoJjax/de+4/Db3AttBuXW
         osoVru+/NtKieo8FPEAHdnejS8hQPkXhMoAFgnvQoXDhItZyIdcNqa3m1oMidORwCrgf
         tSK8n9xHz4ETFS9Hm1jAZG821EVE/0QO0/iERCIWx32gATj8O2ZsQd1vV1/TJ6WRCsOz
         7clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814274; x=1727419074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPEFOYIvo3FjR008iP8F+SdxzrmnQtEYwMT9hZJggmg=;
        b=dwsf3tVIIhtUd/ownlV2zXnKQJDXRqizHA9nSuZOPatoMAVec2ibk4gYQYHVDP203M
         h5tL4ymeXebzGohYo18RBO4OecnFxzMmQSh7Z95ofoVteeRtru18M4EsrdYe55Bkt9/0
         tiSfYmCPUVAi9NImnxn3z+2MAlNjJMF9DI7yHs1uM4BvRZ0ITNaZ2LEcyFp1MkrO5T0R
         vRY7BaizkGsnZoAhMKT6ROMXDxeqtoCreN/RFdju6LeK8Lv5Q9r3OnldpnAV7WSE9dyq
         GurxYwflY0i/qSHa/Tcq3bcOKL124Q+OLUturAFyivqszUG71cNo+V0xvXyGHNJrSg/3
         cvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOq9DtKbkjke/siSnTHb6qyzAX5sGpRNNigb2DuVEK8dcbxyZvg3iGPd+mN4I/+8YWoKMx86sZqNdm@vger.kernel.org, AJvYcCVxmRaInq53I3JmaU21Y7Zf3Av5vvSjt05i8csHBrlbHNzdvxF4os3kbk/hnDK6hzWIB2Vfl/E6k8eCal2z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5f6xndncO1FMqU1EDXO4tUtcTtV48MhXR2DRHkIMwvSKTcl5B
	e26s73mHJuPnebXwvtzmTa//KTiH5G7ln+nworv5KjG/IF2ePv7i
X-Google-Smtp-Source: AGHT+IH2pNyRmZlCTiO5AdEsu4duxTuz+8tetbm/Mof2B7a4gOt92o/iYRHwA2XbP1ZjGmsjde220w==
X-Received: by 2002:a17:903:40c7:b0:205:56e8:4a3f with SMTP id d9443c01a7336-208d843dc46mr20946725ad.61.1726814274316;
        Thu, 19 Sep 2024 23:37:54 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d64dfsm89106425ad.134.2024.09.19.23.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 23:37:53 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	esben@geanix.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: [PATCH v5 0/2] Add support for nuvoton ma35 nand controller
Date: Fri, 20 Sep 2024 06:37:47 +0000
Message-Id: <20240920063749.475604-1-hpchen0nvt@gmail.com>
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
 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c    | 886 ++++++++++++++++++
 4 files changed, 988 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c

-- 
2.25.1


