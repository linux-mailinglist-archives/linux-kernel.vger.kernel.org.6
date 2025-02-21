Return-Path: <linux-kernel+bounces-525482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80591A3F089
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1870C189C40C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809F1F4299;
	Fri, 21 Feb 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT38rU2x"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F81202F8F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130663; cv=none; b=fV6QJOc4eDmjJYr/bZxyZU1djwnML3Yx9pSahT1NbOUodRiBIstzAezDcYZNP56awjzrWqblVZC89Ks3oMWvnd2FrusmPENscX5xeDWnZ2MLkfId8fGxc74tb8A3nei/enlCX3vHMJmtDeX9J3j3ml3AYO0FJYx2/R1mQCJmyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130663; c=relaxed/simple;
	bh=ORSz/yeNFgVR2woTTTjZ9lchsO6kKpCFtqIIVpoGGfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFpsBS+5+CD0KbdWtwJki4UDvkJpqAlZq5cYDHxQAZuYiIN5WSXdj1pE29BsdV+W9G5F27icDLIMIiSvgY3iE1Yxkm/81vFq2l0yo1uLJUnzWDx28wGe/iil13qWdosX6VrheFVutffZRa0M4SYbx//YMhgTutqaynOKQw80tsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT38rU2x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220f4dd756eso36920095ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130661; x=1740735461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnMo1WEwQ/BmVupvZbzAM+bCOTzLXXqhIMeYEqG++fc=;
        b=DT38rU2xNUzEz8Jk+MABvfcTcT+CB7s3V+KWe6Ft/dHFHvePWrM7vAFpQtJyduSTwH
         lgTTyRHXDH6dgIAHv4/tlwQ+nOTTIIwxpT2djBB6mfF/1+0MMUY1WkV6GKuGSr/m2UVn
         R6Y7JHPRLPU+Qw7I4OXuyLStV4z4PCkz38GGD56AYp7RGJala+tFhe0DHgYdSKUDaXAx
         +xGMc0C6SJlnCU4c9f4trRzQEeHovP/OGCuiJ+LiOKF7KM/SS4+xR8jCrbE9HrLKJNvN
         1n7/ipoBhz7vxarhMP5anPPQHb7qnsjD71/729K5GTUpHQZ2d1cQ9uPy/9FQvt0dgcEe
         62Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130661; x=1740735461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnMo1WEwQ/BmVupvZbzAM+bCOTzLXXqhIMeYEqG++fc=;
        b=BHZCX6c2NuEcZ6gxWlHvUy4FKYBg98uP3tHd3RTPmgGVO+/2I+Icey390m8l1HY41b
         2rJA5RoGFO+UwjfXilb4URPfdTcRSfzjE4LCePiO2zB3FuMZkV4FXgcOFqJa4nK8lfTj
         o5Y2vBJmkOi3kdLkoS48iHCs4fw+Cc1ooqr098nK65S3jdDfEIeZSmaVwKyrMaEQnMPM
         73otGuCJTpmZUk+7qZMCae3xqg8bXF3QSms9H4v7qbBQG+VSf38wZ1leVl17Sc/TeQ/P
         6l7f42yFNmvJwZTE/reZ5KajuV+P+xf6c9PJcmEsO0lJ/BzPausdI9wSaN7xMK2fI4n/
         9mmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZTE3z4QmqCJHgLc9n8k9wfAF/MSCryxHF2t9DUoANa/CZYNYtnsrMRcLgULplGXChnKXyrcP7Ch4+1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+C3pXINfzZw/SmL1sazkgafodMLFvMh/8MMaqzs/RDyqZP7ev
	Oe/q/2LLH4/f4XOaNy5zTqnyYEgXATjcq3jOs5zezlna1vrnz159ia3qxQ==
X-Gm-Gg: ASbGnctYuxj0TdjJbESCCLRsU9ad4upJbGfA47VciK66cZQFqDbDkZKn54kirrAtcR0
	IULjeIsrc62vo/a97TfSvKvAuNxh0NADVisC064tvAixJg7dljWIH0/I4WepZq1SuGyyOSHGlFP
	S839lUNl0da6oncovJlw0CmUvXQjlTnXE8Blhz5D6HOHQ9yCNLbPdebqEV97DzhX7s6UgApPIwI
	w43onbvWqEDdhUqoM8oY252QYfBbIJPuG/zBkbyQnp79dOfvIxdOtwMr+2oS6Ph8NO6eKSFRa/Y
	di3bOCE+3ieB+XlXWMCQbwb6ov1YKCUEq/48UYwn7EDtKbPx7A==
X-Google-Smtp-Source: AGHT+IFMGGM864UQUgG10ghybDKw9ooluRG1HgWZV1ZIVwKCndiDqk7V/e+nltWImTE2xNzNfDJIog==
X-Received: by 2002:a17:903:2f06:b0:21f:2ded:76ea with SMTP id d9443c01a7336-2219ffa36d9mr41553025ad.36.1740130660877;
        Fri, 21 Feb 2025 01:37:40 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm134261835ad.74.2025.02.21.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:37:40 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 4CC56800B3;
	Fri, 21 Feb 2025 17:47:53 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v4 0/2] Add support for read retry
Date: Fri, 21 Feb 2025 17:32:58 +0800
Message-Id: <20250221093300.430994-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

For more detailed information, please refer to the link below:
Link: https://www.macronix.com/Lists/Datasheet/Attachments/9034/MX35LF1G24AD,%203V,%201Gb,%20v1.4.pdf

v4:
* If set_read_retry fails, it should back to read_retry level 0

v3:
* If set_read_retry fails, it should return an error

v2:
* Remove fixups
* Remove the function of init_read_retry

Cheng Ming Lin (2):
  mtd: spi-nand: Add read retry support
  mtd: spi-nand: macronix: Add support for read retry

 drivers/mtd/nand/spi/core.c     | 35 ++++++++++++++-
 drivers/mtd/nand/spi/macronix.c | 79 ++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h     | 14 ++++++
 3 files changed, 111 insertions(+), 17 deletions(-)

-- 
2.25.1


