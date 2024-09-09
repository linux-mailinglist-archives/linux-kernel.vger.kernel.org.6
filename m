Return-Path: <linux-kernel+bounces-321038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B711E9713A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759AF2835D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C71B3B00;
	Mon,  9 Sep 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpjlhkhJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98A1B3737
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874145; cv=none; b=T+y16LmVtK6jKOf9iz6rpoE2A5ERM9vnQRe1hXNF5c3dNLS2dg4+9hmiU7iHJ+UzWW1DHm2Vyo9vcgrqUljIfiDoby8e2zjTizmqA1cWX02aRLZpkOpWeBBtE61C5uy5qt8dWbtP1GBM7sNdpyvodEoF2WnqvhlYYq/d3LHvSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874145; c=relaxed/simple;
	bh=4QpZ1QsM2RrmfjI8P+601nkSXJKLqCCNusuRAt47GKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8GYx8tB3xssIN8GqUqocywRXsqgcc3upUVY+/u3elN5SvcHyFUuj5JcmZz4YVb60i/P8yMTXZJVhCdhsW2NMgpgFgx9BqaaouRApqxVIHqUA/MtjV1dEyL5AoqsDQrmymACqVdM+ELuviEKx87ReUCx+HzrP3soWWu8H5khl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpjlhkhJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20573eb852aso34032435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874143; x=1726478943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufYMBg9rYDJ/MRvcfwgLYFZVNK9eVr8z78byql8J+6I=;
        b=cpjlhkhJxyTA57Qd6R+R0Y5V4FCTvWmF7i0LWhWMLZjZYG/NWjaNm0w42rOzfVVQku
         P/whC1OGtqK3A9jExnlZRq1tzG9gLI3HXK9Ze52ZI8Qc2V/jwDhyN0oqsP2ONYWsfvRV
         N7/Y5v0BbWtl3QLUsCTayKEEWbGMVVfNjcRKArCip6AyWJKj1FjulvL3lTpVu2g+MzqL
         kXb1RW/JlZqmXOdzeelBi49/97Y/jL8xH+tQAEdsunoTGJNUeNAesuIPc8ObY6za40rb
         6p13fd+i2dVv+5wBZJzzGEOio2FAIaoId3v1ZWgQXJg52wzaS1Hv/W6ECKiNzH1fBXfs
         tfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874143; x=1726478943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufYMBg9rYDJ/MRvcfwgLYFZVNK9eVr8z78byql8J+6I=;
        b=JqeDQjeynJEzGM2M7/ngGeunGE1f3RAp+5Mfdwv3Llok9L+6D/aa2js/dGQSztQ3IK
         fHVfqqa92JaO64JP0ck53QvXX7q9K+h5s+cXYjWOIbLTeUfP4ARPodviQvEVVJXZxZIE
         8y6F9r7dLvN69/fUsm5CRkh4GJiPLVrkaIFcf3mbXbeznXj/b/BoDM5f6xzvlZ/ebScT
         E1V29Fxs1qdEtD9JgYs/0nduekh+1Iivr17ZXweelKQ+p0LcIwzhDxAM1UAM1k1AVOzZ
         YVM+XGOcox1yUiCEFpYODRdcGSMqmLL4g32vZ58G+B+cKyd1esu2/lKh1JGq70k3oHks
         Q7KA==
X-Forwarded-Encrypted: i=1; AJvYcCVhKr+k1QxI3eSBATyWCFyQrA15gRwjRDpItmu5AKpY917VuDm3eqYgQIUlN7dYFiN1aVqG3Wbf/LQp4pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5PbO9lHPJXfHGVgADhLhSwvlxoh6+Ns9xZRRdgQqIqc//iwu
	quU1VlgMK8ffK/RPlSnOf/oSYCAnoGaFUA76IYFcWtJfpVBfpxDu
X-Google-Smtp-Source: AGHT+IEP7o1/p8nkYZjYIgBrnR++Pzg0myiDU20VDe4aF86wA0+UK0CQ7McMvAb15/gLizCv1ThFQw==
X-Received: by 2002:a17:902:f54d:b0:206:b618:1d96 with SMTP id d9443c01a7336-206ee75720fmr152957265ad.0.1725874143208;
        Mon, 09 Sep 2024 02:29:03 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e34f32sm30420185ad.109.2024.09.09.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:29:02 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id AF40580152;
	Mon,  9 Sep 2024 17:37:20 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v7 0/2] Add support for two-plane serial NAND flash
Date: Mon,  9 Sep 2024 17:26:41 +0800
Message-Id: <20240909092643.2434479-1-linchengming884@gmail.com>
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

v7:
  Rebase to spi-nand continuous read series

v6:
  Fix the name of the flag in changelog

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


