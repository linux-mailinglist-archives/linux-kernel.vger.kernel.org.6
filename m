Return-Path: <linux-kernel+bounces-528295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E42A415F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352423A9D66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601B2405FC;
	Mon, 24 Feb 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g69gmnio"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3D1A072C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380894; cv=none; b=Rn4nvotp86vqmyEx6+z7nZuNlsfcMnaj6VTV8wjnxK5a4C6rL5ObQ1u9unSuVqspjtzyfPI4Pt9LUBdcnOTDDO6Frcrpsx9kGl6W86GgfsIZWUbY9oDzDjJj/OLN8v/llKvMcKXCqjQBK3aquKdUMPFXusLnHP7gOOusqLd0gGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380894; c=relaxed/simple;
	bh=D4wLLgrYQC2p5XS8UXuh/JEsZVCdzI0S58liw4qrKEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXf3lS+wDfdIcWcHGGlsQ2uMoNo28o/0znBggvEMHTstktJV5HDD0759XLkoJg1oDhd+909q80I/KgzvayAwVeJSiAXrON0PucqEVRipr4lQAhPaTa16q9PPnrV7b+eBYEGZViyrxuLfnmkmLylKK7fB3laRZqg5X+yiqakhlyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g69gmnio; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f44353649aso5916437a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740380892; x=1740985692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxr0BX9H2rSmbWDcp3ROXus3wNk/eFLtrEBXawMvsMk=;
        b=g69gmnioI+rbq1PrHwpr2lWC6IPS5kKvnTYT8gR/GeEEq7e+pZUAukBu61AZd57sxk
         Fb7iNUwWWiMC00uQIO6/iRjRxjuniVdFmhzFuT/yWBtB8dpVAc0EqjFdY40sT/4Yl/Wz
         DIyX1NAg+c0U3sOdk+YhbuJs8qjEgYXNQtHD8neLQxZGwsoeDvFw66yTooPARapxnvEA
         3HGUdw+WDYW5jfY+8T4i8A3KisoxRCrOlUlu+1U+Q98Sgx0kImuJPmPexfMqeHTO0tiU
         MOkkZxkEk1YjiRKMW7chVVX86uY6PE7nhQ1Tlrr2RySf+xVmTLL3quCQ33ra57ogKDdv
         LzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380892; x=1740985692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qxr0BX9H2rSmbWDcp3ROXus3wNk/eFLtrEBXawMvsMk=;
        b=qAxf9Dka2Qm+87swAehc2/HcMg7c9282RD9CGIlTN1V2hZ7HYi6+lsOWhrZWViFxpI
         7hkihSIU66Ek3uEnoOOHTX+nwNtOSvSKnax8zkNkaJZ6PevUe/icQNLdGNHzgyV/bfDC
         fMiEw/ksQ3lh6wMcs4lervAlPDjeufwoSGHWDVyLerNouTmL144UdCVHcVptTRSBggGk
         LRSledERfM6KI2Dz3wYjcVoaadR91N0WNclrrMkLJqCfiAIGkVh13w3zMfqckIXB64Ig
         sPAPOsRnKgzNfndGc4K4QvTnPPoO2ePtqfypAyUYLjozQ/JMiojbf+BTfy8RM+s1A7so
         yRqA==
X-Forwarded-Encrypted: i=1; AJvYcCXCJpbcJr+sX7bUxGPWZTxIQohCAqaPbp9mA2mbZSTauULK+UNf4FZiBQUqwsVZLSPSNHYpwWA/I0JE/iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfsSZkeCT583CIW/GqMNbFnCznvDNMYq/XCkmJgvhZawmRYYd
	1YmcQQKmoa09YO4qF0CswoYQz0Iz52Sm1hvgVZvXeya9CFE9vjk5
X-Gm-Gg: ASbGnctbCsYQqPwGRo8d7IVNTb5kbA5LWOLOgtk/wzACIp/69UM72d16ShiE2AgqBS/
	tOgdyw2uFAbotqAON3lXGF/UCdE3fKTbCdIB19ghQF4UTkF2/oxewDkpARD618qvDz9JDPoo90i
	2HlLZd4rCf+ZStKS1PV48GuyaRg+hY82hMM0RIGWquP7xwWW0xk5GDZa/BabPn159jVEUdUtuun
	EvOf5xJXxSOWG/8U7BVzJ0JZf0SbfIxtNDppfh6eEbujQGVaVm+gOu18z7zrbjN4zNhw+jF15g1
	7EaMKurWiHVffO5fORmKxO2Gd6EDEcw4bVpQDZZtNmXXfPZHQQ==
X-Google-Smtp-Source: AGHT+IE12ag80ZRwCsA8RWfy0RerhyEUSGbdICvUoSLmgC26GQaUksr40TeMICBEdVbulyqrGW+PGA==
X-Received: by 2002:a17:90b:1f8c:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-2fce75de292mr24578360a91.0.1740380892356;
        Sun, 23 Feb 2025 23:08:12 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb05109dsm5741070a91.15.2025.02.23.23.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:08:11 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id A2E84800D4;
	Mon, 24 Feb 2025 15:18:18 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v5 0/2] Add support for read retry
Date: Mon, 24 Feb 2025 15:03:47 +0800
Message-Id: <20250224070349.446739-1-linchengming884@gmail.com>
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

v5:
* rebase on nand/next

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
 include/linux/mtd/spinand.h     | 15 +++++++
 3 files changed, 112 insertions(+), 17 deletions(-)

-- 
2.25.1


