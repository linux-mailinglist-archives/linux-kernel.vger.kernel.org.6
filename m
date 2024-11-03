Return-Path: <linux-kernel+bounces-393828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D199BA5E6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF93E281834
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B516DEB3;
	Sun,  3 Nov 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9emNXeV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B4A31
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730643737; cv=none; b=h9AzeKAtb3LC0sUP8htvT/CqW/QiNAlN0yUlPXcsUxYVH3rt5R3mfLGiyS3FiiQrE6KNcsA1H+ISkxVK1b4lZxCEFp41A6AiwBmfWdfegQPHu27UqYZxgpn4e5KKsPeGPy7SCdHqfqrt61Grok8nksuK7AEVagW9a62Q9HVNEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730643737; c=relaxed/simple;
	bh=ckCOOZmXYZZiBziMAwQNlxAEDQFG5su6cdwslQrp9QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUdOFpmyd02+lg5pMLFUVmPnu3sNm3ez2Ufl9llQxJlKEUr0GdhZn2sYwBQzmYsyAzV4u7ppWUbhF8ywCov3rsUfP0aaAVkxcW4DTztv7QDHPV6Y7otlNfHC+wLEY8F4YSr92Km2DYAftasqsGf+H7Ah3srVhsMbmvrMjZpM8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9emNXeV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdbe608b3so33494025ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 06:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730643735; x=1731248535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9U7b7nW8Ll63MkV0o/e6AOsrC3EgGRqpsICJyXJSdk=;
        b=U9emNXeVI7l+rYKhmbO1j6XtGpke9cWESyYOlcGN9FB/bDJAVfSf5s47558qv52kah
         bXtWxAwPms3RLV+RxHL7ILuVZy322JXaKaZS00UJiFjJTFWToQTduC6yo7bkxjLtJ4dg
         HjyDHN8uLCqD0sRhlWxDQBHTHOqP1unyIWWkjBeT3uieHtEPIJ5HEG3x8LTRyQpLD90i
         tkbQ+jtcGBwTCl/9RYAS5NHhHY/L+1Zxj3H+pUn8+QmaCJpWR6CQOFA1wKSjXE8p0cOk
         9vQNDDSlfoH2sxI0vx5H6DHQFbim/aWYZU3hV09bOS8xxUAZXFR4/4glqepLh09H+moe
         DaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730643735; x=1731248535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9U7b7nW8Ll63MkV0o/e6AOsrC3EgGRqpsICJyXJSdk=;
        b=CJ4CBOFP0AqzuDJ5kea3KX4bCu9SC+UTX174j5+BLM2ZXL7zOjNZfKF3ImkdqS6GqZ
         +tK/gFv5JddMSNoDTpMoG/MDOMLLijPzY+O7rYrQWw4dTx/CGvUS/9oq+8FUcstd1QLy
         5wHUEusME7eIb0a47AJc0qmGl4f8a6kowOhnaISvtSgoWyNdPiUsYn1TkKXiYVUXx3qq
         /Tlsx1npX9Nc0HCWI+jJQURip2npZvED+cDcKJrpSS3wYy7T0UolwD6jWuS1aShfHzws
         /+C2AdzuvVrIhQodPK61YAv6sIHsR+VVYMtu05YE6WFqZaDYYiOE3w5Dk1aWPOC4nRix
         f3UA==
X-Forwarded-Encrypted: i=1; AJvYcCX7/caCYTqOPcCZia8kizA/MWppuKKy5e6xkUBMVit/n5KZMFkRBlGdqss73agmoevlFTguWuGxhA3Xpjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHn5B9AAdB9WXjh7PeywK+hWpr4WAgonhFgzp+crVhyYxqtRWo
	JZ4sNNbv/UNpZA3aljkWcMkEv2FAu7YDxXBoc29hThiv7u2S/lyf
X-Google-Smtp-Source: AGHT+IHRls55sAYe2GadwHaPZlJt79tpTzkiYauCPfPPnDHp1yZo7s/hLrcNk44tqJwlu6Uc9E42zQ==
X-Received: by 2002:a17:903:24f:b0:206:8acc:8871 with SMTP id d9443c01a7336-210f763de46mr235460365ad.31.1730643735101;
        Sun, 03 Nov 2024 06:22:15 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([222.94.41.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057069dcsm46482325ad.74.2024.11.03.06.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:22:14 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: tudor.ambarus@linaro.org
Cc: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	hhlee@google.com,
	roccochen@google.com,
	Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v3] mtd: spi-nor: xmc: Add support for XM25LU64C The device is produced by Wuhan Xinxin Semiconductor Manufacturing Corp. (XMC) and found on some routers from Chinese manufactures.
Date: Sun,  3 Nov 2024 22:21:26 +0800
Message-Id: <20241103142126.3406-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data sheet can be found here:
https://www.xmcwh.com/uploads/954/XM25LU64C%20_%20Ver1.4.pdf

Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
---
V1 -> V2: Removed redundant Signed-off-by information
V2 -> V3: cc more maintainer

 drivers/mtd/spi-nor/xmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index d5a06054b0dd..83e83c1c1266 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -19,6 +19,11 @@ static const struct flash_info xmc_nor_parts[] = {
 		.name = "XM25QH128A",
 		.size = SZ_16M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x16, 0x41, 0x17),
+		.name = "XM25LU64C",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	},
 };
 
-- 
2.34.1


