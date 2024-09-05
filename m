Return-Path: <linux-kernel+bounces-316383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98796CEC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6351F27363
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E7189537;
	Thu,  5 Sep 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCGqJ5DG"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4D189518
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515747; cv=none; b=FzU9BKdq1DGjBIcsBqrOkIIurfeBOmapxcmBM+nUIOWRUDNvHtTRnPBGuFh+jSExXSV1a4opgEUEseg3EdmOV3gc21CQdnUjtbr9aKmqEE3hPRWYv9iSFPdsLN6QX7D4+FM3agwt7N6bascoH9n2ysnItRmy/VoANFUnUpWKoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515747; c=relaxed/simple;
	bh=r+O25lbenDA4blhu0GCQw2Ny9QaC74UojDf5x2Y8a04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4K7yRfTF/kOiCY1i8R3kh4Kq+Kbw1zd2QqR7Lmfzrk36Z2c/mGDuRRqPvOC2SOJPNsSQkJEQjvfg+0QLxiF20mLTEqiOCayfg+8nRzSV5awgoz/aNmxaDam4XrUGQGUlMqASC8IPhxmULA6uwX/3nnXRdGl2N0v3+fXdlg+PBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCGqJ5DG; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70f6118f1b5so319752a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725515745; x=1726120545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSftet0jyeDp3g0N3i1N82jvf3t0TCZia8ty4jrRx70=;
        b=nCGqJ5DGofaJTIywJPxuh8BQn/eLJJrFZ5UCxovSUA9IoYPwrsg7v2OAi2q85xYxQT
         09L/V1VaNuBtG2A/VkH/Zxyrf8OHJtPDXjrPy/mtohgQOPfAh4iAxqAxO6gEjWI87Cqg
         WoNdYhEbx90lSg9ESuRiODRDoHaGUaMGB0cokBZ6/4ANb0MAUz7ktCVPfuU1glLQZ1nf
         DtGTu/o3rrl9dA4fjSVDwgKK+3JBHp+DXvnPRzuwu+r4sObiZxlJpHaxa9+j6G9nSoJD
         uf/lPHhjK/+dQSBF/M4nlT3P7v2zNpNwzLCQvvLf3yElaTlf9b5eQz56ju1sSJEHWs3J
         K89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515745; x=1726120545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSftet0jyeDp3g0N3i1N82jvf3t0TCZia8ty4jrRx70=;
        b=wU8Kc69Q5OzYLF1vMZlAyw0H9AIw96YhGs68wsCUsdHqs45WBw9clrsaygaclqyyDC
         8bvjkO5tYmOh94aQgBDf1vtfMWh0hTYXRsYSjd7aIHd5uyCeC0IL1Vu8K6OLY6Or6xqE
         adsHsE58eM20vinilpDnqrU61YsgyfhiYf4cfZS1jF4bc1uMnk6ez7OMRk8IUFQqDQVu
         qZuKn6nMAAJjOVamBgMjUE7xXJXvSdxJHPe9TQHRAjDk08eW1akgeegVRMJdWFiOZssh
         fH+el5K0F48sf5X3zyJmWYsAPqv7pLP1czu1z+WdPHrhjSMeQtl/ONX7taMnq5CPzqa3
         kgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOu0T3Hx/JHvBd8OA+z7bNp9Jh8aMCWpGSkpU8Xq8QyeFhy5W+YY8WcmlhHbt6VLOOk+ZcHFJKy3BfiR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJa/4xmFRG5E2aXkkMzkLMQCRBdlgAGRl5VVZ8wxCQX+7qTbyl
	qJh2TbILW2pznG3WnEV1UdoKzNspDFmlxqtfXbbwm3Q1dNxBNAywI16bJA==
X-Google-Smtp-Source: AGHT+IFgDBRriydFjCDDQs8m/0UwuGzvwBinkyFHX1pf+Jb6S39y4pyCR146A00VM4ENmIWb+n/slw==
X-Received: by 2002:a05:6830:2906:b0:70f:6f81:d274 with SMTP id 46e09a7af769-710af72597dmr8262352a34.28.1725515745168;
        Wed, 04 Sep 2024 22:55:45 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd85b36sm2564072a12.4.2024.09.04.22.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 22:55:44 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 23C30801B1;
	Thu,  5 Sep 2024 14:04:09 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 0/2] mtd: spi-nand: Add support for read retry
Date: Thu,  5 Sep 2024 13:53:31 +0800
Message-Id: <20240905055333.2363358-1-linchengming884@gmail.com>
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

Cheng Ming Lin (2):
  mtd: spi-nand: Add fixups for read retry
  mtd: spi-nand: Add read retry support

 drivers/mtd/nand/spi/core.c     | 33 +++++++++++++-
 drivers/mtd/nand/spi/macronix.c | 79 ++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h     | 17 +++++++
 3 files changed, 112 insertions(+), 17 deletions(-)

-- 
2.25.1


