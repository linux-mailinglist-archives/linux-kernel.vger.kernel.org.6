Return-Path: <linux-kernel+bounces-308517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC97965E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC201C24E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1D17C9FB;
	Fri, 30 Aug 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/yZZ28h"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257B17C232
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012318; cv=none; b=r644VDX0Y2cF6W65ch4Nmoh5eL9Be0FKciwqCnPkUYgYeTD6UNisXq87hc2VJWNnnvMQC79dyGvdglZUxZVYSauQqFBPxSpayJ46zHmqnv1OisQkydkM8HGT//5UBMv9rA8vQNsrDjT/WsRX9rKkx14ChuufWC4UZpUtE5sfn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012318; c=relaxed/simple;
	bh=4X+ZpCTNMKlFSAioFVIu9ceaDitneQotzzdSMbwVI/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JF8n1Ph3rSRIWsmr67romX+Tq5Sx7Z0m8tA46pklstBnsQDfBNzq1qGQMSclZZAu8DS+rNN+2LE862woDpD4OqbLO1s8mKc+IqfeUiCTx9QN76jG2B22xQJupRHLyoFPbvBMZTHa4KGDoMlaYKAlinmLq5YbttitidD/t26SFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/yZZ28h; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714114be925so1325953b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012316; x=1725617116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEwk0Qv5fctwHCGMCXlw1m6zjuEjxBtsPH0+hsyXZqM=;
        b=k/yZZ28h0DhmN6qqtOH/HFt/bSMyG3e4u7DravyZri7vdhO/tazjsIbq+ZAothpY9K
         kag81WFRpzRYQKuH0Eh0p2fvixTo8iYhGL9u6vegFxGaV3XUknleROOpUaBC2TJ3RMv2
         /HuFgkTT+8aH9f3LkMWjRCE8X9fdp8iS17ukzBovopdT/b4KVBeMD2uppZDePrBLcO/7
         r7s0sv/jPYvOJPZqbigDZ2db1RBxdomLg68KHXYnYexrH7mKbEcdfp7sIlFQSchGWO08
         kSCXg0iquDBIDZy+oHGwMEDviCdIorBm8spBBFfw1hecHLXwiyFJoZa7sowRID+mgz7l
         Wt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012316; x=1725617116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEwk0Qv5fctwHCGMCXlw1m6zjuEjxBtsPH0+hsyXZqM=;
        b=nNOESaXrg+tFbPE89kc5ddBzhvVFXgnuXZzusgnrNAMqLdfTM9RvT7G5UBRVVQp90n
         YS9KoW0coXtcQJw/LMwcNJzfAwfL1RnbgnzIQsZSQKtjLFh7fZd6Vgtq0uPHixz4YoNS
         OT6NB6omz6tWTatFYbvRgQuGDuRgdXkERRr+m3lE5EdKFOwl7YIvuATJWCW8urKFbZy+
         QmzFlXD65Oy0V0SwUBSTSdsL3AqG/DJYtY46jN46BTjKP4aVZiq1LJYoteEps9UZGAvu
         yCzF10vB4UQP2Dqt5jWsXAzMpIJGv0sDbABGWF0OFWG3JcVwcUHcfqxivekfxXj3YUjn
         ed7w==
X-Forwarded-Encrypted: i=1; AJvYcCUj9E2RSAdqxRcmJj9zhpLft/NFMUcgTiWli+i2DKxjK7qBHteO8+oEHG0H0XmVcfm+8k9v+RzanTcOy+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxai/hUM7r6zGdyVTPx3+K5t/zNJlGN42en0yufAwZ2UI/dx4aP
	QxKoJmR/2BXu0x4ebt++qW5lOQj7FkV4wDLtUdkybaNSplIK5CDy
X-Google-Smtp-Source: AGHT+IGb5MwPW/rJmnq12eLqUueFK0ah3mtlvAzl0l8OQ1FUegVcXsAx6K5ubVt70MG+YaXfW8UtDw==
X-Received: by 2002:a05:6a00:3e10:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-715dfb988bamr6911269b3a.15.1725012315500;
        Fri, 30 Aug 2024 03:05:15 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55771ccsm2421702b3a.43.2024.08.30.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:05:14 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id AD4C8802C7;
	Fri, 30 Aug 2024 18:13:49 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v5 0/2] Add support for two-plane serial NAND flash
Date: Fri, 30 Aug 2024 18:03:08 +0800
Message-Id: <20240830100310.1553675-1-linchengming884@gmail.com>
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

v5:
  Update the commit titles

v4:
  Separate the core changes and Macronix changes

v3:
  Add flags for the Plane Select bit
  Remove fixups and corresponding function

v2:
  Squash patches 1 and 3 and come before patch 2

Cheng Ming Lin (2):
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: macronix: Flag parts needing explicit plane select

 drivers/mtd/nand/spi/core.c     |  6 ++++++
 drivers/mtd/nand/spi/macronix.c | 24 +++++++++++++++++-------
 include/linux/mtd/spinand.h     |  2 ++
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.25.1


