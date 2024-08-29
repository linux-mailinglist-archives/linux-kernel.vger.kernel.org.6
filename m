Return-Path: <linux-kernel+bounces-306070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9359638C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3691F23FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0580481CE;
	Thu, 29 Aug 2024 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFHVS4Rr"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD40DDA6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902055; cv=none; b=W+2NVnMsBuCuv+o945vux6gxfo5dYJ1KJBYXVHJT0maqSloUmHvc05txdfZOafT/i1amgoEMoDMSlYJgWm60DNbd9wZ+L1N04ZMrEaUcZH7Y3u08ni2PHhaZZlhadqIev9tgQWQZFx+DMhn80thazfk4+p/H/8XIypHUy3PxZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902055; c=relaxed/simple;
	bh=ixOXdSdfG7xmuTIqDrgefGhALWsZvDWZhuVE51pswac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sz2ovmPuyXaUDb0Y8f9zQz33X4D9ewjGcmXL6UIECMdkhXF6yOmg9U541d5LNnCsrA4zNr8fEjqTA5zD0h/wov3okVuVbQvn47kwmJZScKrra18hdvK//l5ykx5NVRjtrL/+sLakehkagDZGgvztbSdXWK1mxTGjVVCru7LwMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFHVS4Rr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201fba05363so1577265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724902053; x=1725506853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tybh8CVhDkPj2cvU+MZ6PTR03iHRZDg5PD1f9iPVBVg=;
        b=PFHVS4RrKYajZYjrxMMbGmw+oQUNTmfnardp6mMxPA5l1Lc+v93F+ubsA7V/J/iQIt
         N28ssFcNtCYdcMXiOtG4Zh6YqJOCEknhljmIwmaLs/+EZYgtfFxLvgu5Vz8KXugTLlFu
         xNJEhzu1GqrI0FbcL3kKGrxOtS4Uxec42+BVnGHOHzyvGg0eWKZJLrGQv9jsXZxrAR06
         aAZox6338zrBWWqzrBgB/Zxy3Nl/QIXHNxMrQJUOSA3+WHizQpuQUy8APmdXjOGsp2yp
         xjKptbzDb89N0Upxn1Hg4xV/+cECDA/eWzihUp0pXZpqqbpNJxbD8eVykF0GdQqLYp0Y
         1qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902053; x=1725506853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tybh8CVhDkPj2cvU+MZ6PTR03iHRZDg5PD1f9iPVBVg=;
        b=B68qSFv1f9zdsRLmVSsLp0yTlSSTucSAK5K8Tfp5qz074x2YPjifluyTZpY6NEia+d
         uJK+W71Oq+YZ2PzIhfoBEk2vZFUBdm0L0yI7EpGqp825tQGbqRZMPsA/c/BNXx/7wDHi
         FghC/COEnxJi0xKUSl9k4FpXirC9O7RUhoFxFXbQPnElHnmYcuUXUujNXZX0ysBIYKHI
         f2q7SsUb+n4esL1o4s1utgATVG3bEZV7FaT6yDzalC7W9ohb8T6ivkVEdDbbPLdlfq0X
         /RfHv7ibtW1/DvFj3HDt27vOYOM7UFi0lDNvpXaQTXDxReEEo9C77mrii4xAj2Xc27zz
         Mzvg==
X-Forwarded-Encrypted: i=1; AJvYcCUIRikerOGwT3JiKJJOKCFLlFbvygaDmvtTqekKYHp1wEGspCn4ZISS23Ne4bynyk9bGjOLW46DHxgLw1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IEv5g+EvPwniyGicTd23CdxGv8tLP6j8DiHg2DwWf9l/2Il3
	dHj3ELPsAG1hU1E26XkptTQmYvCukPfsKe+kOet/4JW7XIeuvXKh
X-Google-Smtp-Source: AGHT+IE+fXT1LArYY0xb73qOkbVg/swIDbkDa77Rnw4eTW4g7ihYlNY/Ourh4JnvkXNm2qu3Mn50bg==
X-Received: by 2002:a17:902:d4cb:b0:202:32cf:5dbe with SMTP id d9443c01a7336-2050c4a1977mr15126595ad.58.1724902052793;
        Wed, 28 Aug 2024 20:27:32 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051553703asm1947855ad.181.2024.08.28.20.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:27:32 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 33629806A6;
	Thu, 29 Aug 2024 11:36:09 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v4 0/2] Add support for two-plane serial NAND flash
Date: Thu, 29 Aug 2024 11:25:15 +0800
Message-Id: <20240829032517.1517198-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add support for Macronix serial NAND flash with a two-plane structure.

Insert the Plane Select bit during the read_from_cache and the
write_to_cache operation.

v4:
  Separate the core changes and Macronix changes

v3:
  Add flags for the Plane Select bit
  Remove fixups and corresponding function

v2:
  Squash patches 1 and 3 and come before patch 2

Cheng Ming Lin (2):
  mtd: spinand: Add support for the flag
  mtd: spinand: macronix: Use the flag in Macronix driver

 drivers/mtd/nand/spi/core.c     |  6 ++++++
 drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
 include/linux/mtd/spinand.h     |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.25.1


