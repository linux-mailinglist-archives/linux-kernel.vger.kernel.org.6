Return-Path: <linux-kernel+bounces-304407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE48961FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F121C23A23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30669156863;
	Wed, 28 Aug 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG3SYcIA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B42F1553BB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826224; cv=none; b=kFu8IsgNZ5hzVfDZVKU76wDHn4UnVRfApJIxJycuUQ1V0vPzTkxuO3BLpd2ICdCPt8nF7WWjEOVdgeJnYL2/2UlINBlaYPp18vb6Q97JGD46Kd1WNf51S8MayobMI69h4dtKTu+cTJVmF5WRbTyzT1NzpXNQt70j/oOAxFvFcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826224; c=relaxed/simple;
	bh=5tTKRvSzr4tfq8I4/yCTPG3+D1Lu2R6BBUl+8V0XsNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECnnmHO8TGTpBl+c5Xe/Nj7Sm2sK3xncrqlrzifraXK2OeDIm2mrCBxR4SLCnd6myGOpNJeL+bRcpj09kXw4o1YTVbgWlDrq8UbckxPofe/455y7gqqnSwM3RlCYnMi5epNPGJrh5LQ+Zjbf83AtxhvDiCM4Obfy51vgCWmoo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG3SYcIA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-204eebfaebdso8724715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724826222; x=1725431022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbT6GeRNW9OmI6+S8780JOyiYLK0JJiZnO9Ssmk8qEE=;
        b=kG3SYcIASF3bWSvjlj/T1dxX7c/CLZcmKvxrTQP2cq9qrj4YH5QXlTDlWEuz3DFJZq
         O/0bJQD8NFaJ0LatQPLusg0jK0qwpyK5deDrx0UO5etDytQaBE2rQ100jS998UpBK0Cn
         NZMDh5k6x89O4EmnUn5tiCLpYoNlHQLyqo/t1enA8gymG1voS0IKxoxe5zTMoZ4Ju8Nh
         3Sa/s2A6+vcw/INENHkLnkhYZrN1+pWnpWUkd2kxk/bC7wHAYb7yGT8t3FVkQoDrcXW7
         U2GQ0MQlYoWbuiggyDq6/uehhS0Ru4Cs6Ny8bit0hQHx5OO+yJUFCBHPi0ItwG8DHOhx
         CDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724826222; x=1725431022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbT6GeRNW9OmI6+S8780JOyiYLK0JJiZnO9Ssmk8qEE=;
        b=IOQtMV+uN6JnK4KI4xi6xlDGpDHemSIiYunzfvZdoiBtZKmWTxnHzIndbx8bwFj49u
         +En4s9XALqpO72xMIka25o7JEVcSe9kp5yuuKzx7a/ran+tZ30uBn/1MQ4vnjnS12nv9
         T8lWTexNsTpA4nPYTs9xZxuilPR+4cpSsED7kcOToBsgZLyhDStLQKhWN7gGeGPiB0Ru
         adtMYP9CRXiDASIhd+q/+4wY7fUg5vga8xJNXOhdv5lbM8w0cL1GyDgejOAbYZayjriq
         KoypR7uCtaJmDbzqYk6r2/Y0O9Rja6aaV63WMyhnZUL62/4g2LIszR2l0bx5RYLAOUqd
         vSuA==
X-Forwarded-Encrypted: i=1; AJvYcCUknB1ZZwD+W3jz0qPt+JdAVEpGOP21qptJCujL7Usq99BFx1gBCzJ978qbV3iMUPfzEDac4FXzeVAieig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSkEd7FKsL3qMlklYaqAMrs3wi2pUws/Lmt9i67Z2gUdhJzYs
	3myxCxpJSHT6Jey2qs5Q0cKD8bRFtUdwGfzB+nM5JU1RuVjk3XEk7OuXiQ==
X-Google-Smtp-Source: AGHT+IHfNNTWMaQVLaBJdN3ixLypGpw4Amcpc0VO1I7SugKYFoaXVlGwK60OLul7emNqm50/iY7aUg==
X-Received: by 2002:a17:902:fc8f:b0:1fb:57e7:5bc6 with SMTP id d9443c01a7336-2039e486f6fmr217848445ad.23.1724826222315;
        Tue, 27 Aug 2024 23:23:42 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae7b1bsm91822785ad.262.2024.08.27.23.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:23:41 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B30E280379;
	Wed, 28 Aug 2024 14:32:19 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v3 0/1] Add support for two-plane serial NAND flash
Date: Wed, 28 Aug 2024 14:21:30 +0800
Message-Id: <20240828062131.1491580-1-linchengming884@gmail.com>
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

v3:
  Add flags for the Plane Select bit
  Remove fixups and corresponding function

v2:
  Squash patches 1 and 3 and come before patch 2 

Cheng Ming Lin (1):
  mtd: spinand: Add flags for the Plane Select bit

 drivers/mtd/nand/spi/core.c     |  6 ++++++
 drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
 include/linux/mtd/spinand.h     |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.25.1


