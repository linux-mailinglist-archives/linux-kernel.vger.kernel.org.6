Return-Path: <linux-kernel+bounces-296172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3B95A6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC9B218CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BA170A22;
	Wed, 21 Aug 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmbqE8qv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD816FF3B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275890; cv=none; b=euW8v3jq9LjTV/ShlH7SI0/dySL0xFmTyQ9ujdHX5tUyUb+yZZpDFpljqCUWSEYISbT/waPk1YI0x37JUsOKaib+vZtgI+3VKQtJoT4H5kU21m0N+Rb7lHzqlB0LBLJPBuK3tTUllRwgrxI61Yuko0yqmsE/TEgK7u9LexGjAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275890; c=relaxed/simple;
	bh=13Gb/RMl6q3swlRFNwPCffDQHdXZXtufKiZG1cadPNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fb9L8GqOzYsdpAMB6Dhy1K6sgNx7hlkX6KCmmlGKEvDsaVe2NAsHRy+yvhTcWICAkxNXLLIu7M+g2FLvjyVZ3DObvtcUOmz6PkiV4xRGu1v2xl5Vo6Qm8SsECZzEOE9oSlsfT8YCNwRxG3GHrkO116yxNx+Yy7rk/xuGO45gO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmbqE8qv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a94478a4eso227713566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275888; x=1724880688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyaVmd0NKFFDt4jDA5xpNFtWFHhwLK4nU/+8+CzA/xg=;
        b=mmbqE8qvPqkZ13xfSoGu/fD4FKpD7OLQdqeQxv67/APDO09wYJk80HS92uWE8ZgSBk
         1A/0ajciJMUjJ4264LoiF5kzXpcFRS5RseGUDg4AwlCfbPySmOuWI7O5AEHXnVS6U+vc
         oy0ZWJ9xWJUH0hE3LzIRee92cxNV2v1zW26eWKC/tvy6T0lnLiPH4Geo+B0YpWCzRhZn
         9BANXtZHy0Je6mOu7Mdz4h9RQwCctU7DFPcKdLfU3Xyx9B2q8I0gdFnl2FU7uw/tLqRP
         N9UWjOXoI/jIbMK5M1ynjIVNv1MbQD+NanCnXmkhMVIq6bY5Gl24tq1IsSVvM81nA7q6
         SXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275888; x=1724880688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyaVmd0NKFFDt4jDA5xpNFtWFHhwLK4nU/+8+CzA/xg=;
        b=pdteCkhnmhTzYZWXzPXyZ54krvvsTuyZIA1EqDMLmMyf5iPY/LX4/7tFMqkv4Cop/V
         9u+bSnrXEQLL7QaEPP5fo9LlLRSqxuAfYgkSQWOVrWDSc4pr49efcKY5l8owFXvqQxzx
         bLF7aOMWd/t7ogYR4frCqLHwdw8JaRWtwpkk8TewMRC57ZlvBF/lcjHP+amcBPJHw8zs
         S8QJ40r9wx0wBQH/op0gdTBXVQoiDGPi1TL2sZsKhh14jiCLcjidT7IlXrHjuX6/ujiD
         DZw72Fn/cGjWxIWiV54AOr/1jkEBIt4GJL3oEe80f1IL8rOakNdTlNt9cuEg/7/tUVKz
         5eeg==
X-Forwarded-Encrypted: i=1; AJvYcCV2xjSv7CzOi742EeBwXeOG+52qEmI0hcYQGcRobZ/DecxMbMgEVBb9kkhzlYu3YX8xkRyZuwBZxJPPXIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqseLs8uwwiyIpsEtPsSgY3zwbbdMqGR1a6UC5L6/nIboQHY0v
	uIKpCaxulpjSP70oMwxmXGFKTx+i0Thxmk2h0KWLd8pxuOrasq22
X-Google-Smtp-Source: AGHT+IFLKTY9hGauEHRaP/JAEHEXViE3iNpe4vmfGq6Pa/xlFaqwEsIPBdIvpVqlkTOmzokW2Gkpgw==
X-Received: by 2002:a17:906:5d5:b0:a86:8b5f:65e5 with SMTP id a640c23a62f3a-a868b5f6870mr64815466b.12.1724275887356;
        Wed, 21 Aug 2024 14:31:27 -0700 (PDT)
Received: from luk-pc.lan (093105062173.zamosc.vectranet.pl. [93.105.62.173])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a868f21fe5esm13755866b.8.2024.08.21.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:31:26 -0700 (PDT)
From: =?UTF-8?q?=C5=81ukasz=20Patron?= <priv.luk@gmail.com>
To: priv.luk@gmail.com
Cc: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dm: Implement set_read_only
Date: Wed, 21 Aug 2024 23:30:41 +0200
Message-ID: <20240821213048.726082-1-priv.luk@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This lets us change the read-only flag for device mapper block devices
via the BLKROSET ioctl.

Signed-off-by: Łukasz Patron <priv.luk@gmail.com>
---
 drivers/md/dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 87bb90303435..538a93e596d7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -410,6 +410,12 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return dm_get_geometry(md, geo);
 }
 
+static int dm_blk_set_read_only(struct block_device *bdev, bool ro)
+{
+	set_disk_ro(bdev->bd_disk, ro);
+	return 0;
+}
+
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 {
@@ -3666,6 +3672,7 @@ static const struct block_device_operations dm_blk_dops = {
 	.release = dm_blk_close,
 	.ioctl = dm_blk_ioctl,
 	.getgeo = dm_blk_getgeo,
+	.set_read_only = dm_blk_set_read_only,
 	.report_zones = dm_blk_report_zones,
 	.pr_ops = &dm_pr_ops,
 	.owner = THIS_MODULE
-- 
2.46.0


