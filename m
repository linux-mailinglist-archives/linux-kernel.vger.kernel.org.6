Return-Path: <linux-kernel+bounces-246835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928592C7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477852832E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB64404;
	Wed, 10 Jul 2024 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVJfdtaj"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14089161
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574211; cv=none; b=e/FI80/JMR+El5eECSQScV7AnM4+chVgmExmZIelYobHxobMrRQzErjXtixevW7/pOTW6n/eGTJ+uqQ6xuwuMMy/3KLGLgnMQkiHzCqXszQbEY3MIEi3ebigsZs5WVBmbs0OPN9RAVW6GCNxrAuWCxP2oQo6HKQ5AzCBcu0z4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574211; c=relaxed/simple;
	bh=dF8ummFcFB6ypCtjdDL+HubV30+FmK5Tq8qKI5+etxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPwWvtWw9hY4yjnYwRTh949yNmTwMnvlOXp1T+3oTGxQiNzfgg1XHtMNga1+pN4aqS1ha101+8g2zkxjyScvGV7umw9G7+GwTQTD1ZmaXJvoRmfkN6yWXck8NweSZW13rCZgWn5+gCmjDm6zOARnYhy3OOsVRWaPSTdmxa/1HGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVJfdtaj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c95ca60719so3554911a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574209; x=1721179009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3njM0FEW3UtBZycSVpdIBD2yfZfAl+1hpFSCVAeh3Y=;
        b=TVJfdtajy5AbiaQHrCvUubovKaGFj/o6vfCPuM0c480xbBwIlA67/3HAFDym//BWuF
         8wUcmKohJ7k5n9v875FkaXO7PZL6G7N/DEGlYaft9DBwzI/sfdQP7QRfMZTrGSEhC/ya
         y/d1lFIN/BysgH+GGnI8rYpjNAZDLqmWu2qpwbwPckM4eYoIZVsETcqqoMsRZvlLo29S
         WsFslSxHGzkqlN+vI9tRuRtSm7QU+FlpXxS3YQ01+tJVQzN7wblKElryeRJaAxRpY1t+
         OJ8tPwo+C8yiLhUQiCBMzJClj+V4yiZSkQfs66Gd/PgjRGUpJ7JnD1GCQx0olqSCecFN
         8Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574209; x=1721179009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3njM0FEW3UtBZycSVpdIBD2yfZfAl+1hpFSCVAeh3Y=;
        b=CMnTmMDu+7d6Gv4igHngbobaLMANqYnY/vGUbySJzSh++QJN0E3yy4PjCyt98HlY/C
         C9pAUDHqvQaC/1fMwoEbktpiHGamQCYxktcf8Z6/62GZ8IFHv16lls5cFnLJ5IzWRQuV
         4TmMLV3PXtxUmpSGlRD8jlVFslFAYHm8Aa+gPGVeeJPt0VI8IAf0gKuR+swIwjNhgOFD
         96tjoKbm/g3BLEs2kkrUqzTSV0ZnxrfP5E4Qw9Sk0RwRiMNWxuWWiyXqstYq39oc78G2
         kdDM9CJ2I/Zjb5EOsw5F3CVuldVNW9upAG6GJt1nzUbHK2WMO+JFbeYeYKL0sLgMslKH
         ppiA==
X-Forwarded-Encrypted: i=1; AJvYcCWRPRxAdDirSNhu1lgHRaqNIMpcaQHSAqyFUZhyxsim+1Pf3EVLVnXzJxV7wWLJK9xOPpDoT/GNyeG5H4hngKs3ZoEoqZWhrz7rWXyj
X-Gm-Message-State: AOJu0YwI4RidP3rblepdz7OD30vPlFUGNZi8Kro+nU3E99kycZbA0Cat
	cqcinGHhddpIfC4cVfJwasdZul/NNR6rQAbsTQUvHLJMIuLdD9Cl
X-Google-Smtp-Source: AGHT+IFj3ohK/qKnVGJPwpuwa41E1V1AfWL5q5n3zwa1A52vKNtv1TGwfj0kxHnRr8ppFOdgQZsKgQ==
X-Received: by 2002:a17:90a:fa8d:b0:2c9:6f53:1f44 with SMTP id 98e67ed59e1d1-2ca35be8b8cmr3206106a91.3.1720574209121;
        Tue, 09 Jul 2024 18:16:49 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95197asm10732198a91.16.2024.07.09.18.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:16:48 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id F398980B36;
	Wed, 10 Jul 2024 09:26:13 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 0/3] Add fixups for two-plane serial NAND flash
Date: Wed, 10 Jul 2024 09:15:38 +0800
Message-Id: <20240710011541.342682-1-linchengming884@gmail.com>
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

In spinand.h, add struct spi_nand_fixups as SPI NAND
fixup hooks.

In macronix.c, add fixup functions and update ID table.

In core.c, add an if statement to determine whether to
insert the Plane Select bit for the column address.

These flashes have been validated on Xilinx zynq-picozed
board which included Macronix SPI Host.

Cheng Ming Lin (3):
  include/linux/mtd/spinand.h: Add fixups for spinand
  mtd: spinand: macronix: Fixups for PLANE_SELECT_BIT
  mtd: spinand: Insert Plane Select bit for the column address

 drivers/mtd/nand/spi/core.c     |  7 +++++
 drivers/mtd/nand/spi/macronix.c | 51 +++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h     | 17 +++++++++++
 3 files changed, 69 insertions(+), 6 deletions(-)

-- 
2.25.1


