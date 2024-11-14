Return-Path: <linux-kernel+bounces-408593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C69C80D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F5D2812A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59FD1E25F7;
	Thu, 14 Nov 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6tVWuqY"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF239158DB1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551786; cv=none; b=pvaGUAv1/AZag1WM+a2WAQ4lw4F6qyKutmb8saTeY9n8gZnHyhGf5bwEn/+vKT8noBhXTKsb/lWNhSOOrHswuydFYpwy1zycw8wE06fE9xNvJYvmoLIqrtDkkUqQQzdtdVCfPmudhJHNS4D5HKjJaX4qhqlgl2fiEU9Rcyd9wzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551786; c=relaxed/simple;
	bh=vhnac5ykOtLxwn0a8jhQTKw3nKr8q18K++YmbSZdc18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVS39+DMA+5JVYGqIzdUdPE/yDE/0IC7I0dWCkgdGbuA4o58/yREDpdFlQ2hWL2DrTfcX7tbyCoydXnM9kzLBUFxNAJ+wf5vDjCGCjw9TgQF9DUTUVQ/cay7CO+2omwjMU4aBItgjw91WX9UNfUxFf0tNOEP08PRXtlCIr0C16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6tVWuqY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c714cd9c8so906175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731551784; x=1732156584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhwqgzUVn7pcG4MKg/BtaexQK/MTCdR7gEr/Dxxj6Xo=;
        b=Q6tVWuqYccrois5Rq7r34685WwQaWMAupVzUp8cs0zeiNnt1rMA/JJ//uGa6RU/G0e
         eggMuiP2A7nsrdjNnHnZcswbL+g47h4fmrWHXgfFCMag42V35EEaNd+Dh0mtYAUoYaxb
         An3nGI5KtxNEPqsPhyvVtBcmR2t6QKrZC362OvmXA9AfXgrXbUwu8T3fO3Njv04RSqs+
         Fxj7Xjtqb/jyXSR0qXsdtj9xKd14/yVI8xKqnCdlj+UdQtDh88PSDmyuzSw+B4WyQI1X
         /xXzlCqwJ9JdrgbfhbMYFG4QwrwDxE6vrs5DPlwEv/XzOq5BMOnk9xCMQcItWZse6GwB
         hM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731551784; x=1732156584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhwqgzUVn7pcG4MKg/BtaexQK/MTCdR7gEr/Dxxj6Xo=;
        b=SnUIQtVtB4dEfihue56ubskRWGffXVj6AQ4Q1GcUzqJW7lPyMUdsZr/WsmzYco6WAG
         /kgyeVjI0Hj/eOFKyYkMd/3ltpq8MJ6AQWuOZtf40ZUNiozJx6lrITbU+NBJni1jtvhq
         GN14Mm7S8tuwf396obLtKkEmuxinl2IQeWhQPi1rRytIFU1LmSJmSZFHVPaJGAnmMbBz
         HC67kDGYIvs7s7z2hKgrFrsBXHomvbp5DeqcLwPAqFyrEfaU3+WQDxrqWb61hQ9mhWQN
         MJ5SwGLNwzMGStu1Yq6MylEBZo0e9+HIydICukmM7hbhQTKLcqYPfU5XkEw3eZ4EKxkU
         nuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDnCjwbiNJBt6mpWIOmUJbujJptNRv8YUHFVzfvvAH2m78IVbYB421SjYeazM7+uF/GQ9w/N+SfGL+CUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1xseMn6dJn84ta1iPBo2BzZgq3hisTuOuTQJRvfaEp/i43V4
	j+bdfVM3sNpVq7pkk+Qk5ZgOOkfZKyN9CjG+yr60or+zSoOMn4+S
X-Google-Smtp-Source: AGHT+IFOKS15D7LMG7cATcxDBoEqPFsSRpp5VgwU9luVW5gGWLg0ttPwwMat9IjnpQHdcRoio0ERVg==
X-Received: by 2002:a17:903:2391:b0:20c:a1a3:5373 with SMTP id d9443c01a7336-211c50f9e59mr6220795ad.55.1731551783855;
        Wed, 13 Nov 2024 18:36:23 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7ce984asm480245ad.167.2024.11.13.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:36:23 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 3CF1D806A6;
	Thu, 14 Nov 2024 10:42:49 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 0/2] Add support for read retry
Date: Thu, 14 Nov 2024 10:35:26 +0800
Message-Id: <20241114023528.181583-1-linchengming884@gmail.com>
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
there's a special read for data recovery method which host executes
the Special Read for Data Recovery operation and may recover the
lost data by host ECC again.

For more detailed information, please refer to page 27 in the link below:
Link: https://www.macronix.com/Lists/Datasheet/Attachments/9034/MX35LF1G24AD,%203V,%201Gb,%20v1.4.pdf

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


