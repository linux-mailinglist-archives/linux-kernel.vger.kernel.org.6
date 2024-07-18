Return-Path: <linux-kernel+bounces-256122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971E934966
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E84F1F22B06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80677103;
	Thu, 18 Jul 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KizPUkSn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603042078
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289307; cv=none; b=mjxDNcu7q4E9nqTlcpHhfrDklKDTwTp0Tu7YB3JB6uu0+q5w/Ru8nXo2BZE7N+4cwen/IEkrolQ4q9j6M8Lsq4kDzxE3xWdQrjNbdndWvSM1utF9RvZBxaBO0sbytQX/jEnRec+IsqIXzP565l6f1lA3FCTeOrxACMAxPz0PvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289307; c=relaxed/simple;
	bh=d5Q4s4KdiwKVZCeMG8tsoDS/u17yAjv7xbwNDFlgqyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEYXfJkwrMgqZv5O799aKkZofXglPsPIaUnutbR9usKDkWK+jKfB/kCjigbDje/TUxFAMBru/QFKnPcFJC+O5YEEQDeAP54xxJA1l7mGfZCVR1PjOgyOyuXlKe24/gd9Gvlhk/X6iqysiIYZAnMu9QWCulQjU4ZxbC9tDbTBC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KizPUkSn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc47abc040so4024205ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721289305; x=1721894105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZA5IPLmrPdo1khB/bNRcx/2WhOlf5P673XgW+aShrs=;
        b=KizPUkSnG1ahN7ofzsqmaDIVY6enVhGBTsMuzkPTSTxW87BZNypiACLgl0wgtw4y6J
         dijYmM3tGK8U7hwpNPEgY1wTm4BbLR7FPdNG61+c6+nA/9ZjaGpUg2y0IRiEpuR/JtNX
         sRRDk3k2MNpb7MEFWlTtBL5JJu6Dq8GplCvNVLdWDsHZhJ3Wy7uQuaegSvOr3Vn9WibJ
         OhcYzE0RwRlMRfCjwrOCsdNhEy6XPAabz+ZYoiVeD74EG2g7eLoTjm2QoNBr2sOKboMf
         jJh5KrWfI3+5GEZdeOpQBZF09nPVmpBLDhjWPaj5zY/7Eoqe052yuhjYanWKbzTY/FBz
         kHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289305; x=1721894105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZA5IPLmrPdo1khB/bNRcx/2WhOlf5P673XgW+aShrs=;
        b=XWQBl73rHjOgfrE6xPDH32ODMSWiPWA63uookiP/Vj88VJMHcdXNDWpNsfAXNmdl1M
         6wePCGPs2SpgYXDqpzpds2rNxEv7UEIE9xnutqZLfwM6IY4NOenXMPY7VrM4MYX7ujuO
         xqB361K42Owvl0VKW411DHPB+gZAJ+xIh41PpKWAApYwUgtMY2ZCaXVPHjQSqAEmyRDH
         pKGm0MWXA3L+6zXwY4KX96oTwHhO5cm0/2Cua8vSt07qVgidxh63ykQJ8P0fSroOD3no
         qiYLwLWgqEhyllB6A9XpY71pFobdqn6/Tp5Qv4zs+W1mQBSQjc6cNvoaPF+KzNCRlwDo
         mncw==
X-Forwarded-Encrypted: i=1; AJvYcCVz2KGqM1anm52QAtfdphzsQtbA5R/FYR6pnrxngDg3vboDaUVJcH32G77n4IeSVaXNVozY7Aub5lslgk32pw96kAOFqOH4iDiV++vA
X-Gm-Message-State: AOJu0Yw54K9tydMPNeXas+6sYEeuGwKKjs0qoLIauBvnoXLGdjYELwBi
	WlkNAysw2romx4qEdn++zJwJB6q21d0okT+Bo6eh1LCvAd95AQLI
X-Google-Smtp-Source: AGHT+IEbsSUG6Tl4S9fs21p9y8/LyN8sXplN/4SY9rbtGmpj7qnhhT0h61oCSCHp1J3h7zx1E0OpUw==
X-Received: by 2002:a17:902:ce8d:b0:1fc:4b4f:68aa with SMTP id d9443c01a7336-1fc4e1361f5mr37321515ad.1.1721289305522;
        Thu, 18 Jul 2024 00:55:05 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc62e57bd9sm6187295ad.39.2024.07.18.00.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:55:05 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B9F5580483;
	Thu, 18 Jul 2024 16:04:15 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 0/2] Add fixups for two-plane serial NAND flash 
Date: Thu, 18 Jul 2024 15:53:54 +0800
Message-Id: <20240718075356.488253-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Macronix serial NAND flash with a two-plane structure
requires insertion of Plane Select bit into the column
address during the write_to_cache operation.

Additionally, for MX35{U,F}2G14AC, insertion of Plane
Select bit into the column address is required during
the read_from_cache operation.

These flashes have been validated on Xilinx zynq-picozed
board which included Macronix SPI Host.

Cheng Ming Lin (2):
  mtd: spinand: Add fixups for spinand
  mtd: spinand: macronix: Fixups for Plane Select bit

 drivers/mtd/nand/spi/core.c     |  7 ++++
 drivers/mtd/nand/spi/macronix.c | 66 ++++++++++++++++++++++++++++++---
 include/linux/mtd/spinand.h     | 17 +++++++++
 3 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.25.1


