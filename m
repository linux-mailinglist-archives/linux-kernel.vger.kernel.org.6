Return-Path: <linux-kernel+bounces-269734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA4294363F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F6C1F23835
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F316F297;
	Wed, 31 Jul 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8pspgt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47716F0E8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453256; cv=none; b=X0iSprk/knbE/nAQ/0hQc++Y4VSqvdtSkuemhbas7u9/zTRcmdCxkhoDTbQaTnvVYOJyW2s9qthmBoP7OFJosFI5wGfC1rkYS3Pa7/h+Qf+uVEabZjo5trbGpPNf+mqM+p620BOQqBhl8RyPCwfP2ew5LYAgX8yypClzXJukEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453256; c=relaxed/simple;
	bh=ukYI81uokU0BeUwLmOS4D2F7xXqpS+znxKl1c+2meMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9vT4I+wfP4xd0LQInWRXY0fuSXIgGSJssxkm77JRwb9WvAb22UEA16ayUR7hqPt6B545BcGtISKxbOJ7m7sj9LynSCNetMKVTqIOw0myH/tjMg5NKhI0oJH0XccPO3XvpZA2tg2LnmH62Q0+jNsG0E4t2TQnKc5gyW3pT7WLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8pspgt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3A4C4AF0F;
	Wed, 31 Jul 2024 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453256;
	bh=ukYI81uokU0BeUwLmOS4D2F7xXqpS+znxKl1c+2meMI=;
	h=From:To:Cc:Subject:Date:From;
	b=m8pspgt7W2gbKhsOsQGmqzBdH11VC2v7GYkGwIUcPv8JBrKmw0zw+ebsn1b174T2L
	 iRrapwnXNksDnITIlRBULpE+MHPef8H4GCIUEuk1THlg8pZFL1qXxBe84mWn+52cZw
	 1arhglWORDbPwqnTihpVdSjQXhva5h593MX+vj9KeAd9pJPPX/JHG4e2yEdpbMY+e2
	 2OOPxrt3hvBmWmVxwt42iNGFeWKWN96lhBTYMxcWfTFlsf7jqkDjHPuBeyRmKcaXMv
	 3lKaVE0adICprVohWDcWjVMpDG7SB2uF7j5kP7CTKqIV6Y9QAWx2/6loG3XMQEzzeV
	 YimlvggdmFp/g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: Use of_property_read_bool()
Date: Wed, 31 Jul 2024 13:13:00 -0600
Message-ID: <20240731191312.1710417-22-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_read_bool() to read boolean properties rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mtd/parsers/ofpart_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index e7b8e9d0a910..abfa68798918 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -157,10 +157,10 @@ static int parse_fixed_partitions(struct mtd_info *master,
 			partname = of_get_property(pp, "name", &len);
 		parts[i].name = partname;
 
-		if (of_get_property(pp, "read-only", &len))
+		if (of_property_read_bool(pp, "read-only"))
 			parts[i].mask_flags |= MTD_WRITEABLE;
 
-		if (of_get_property(pp, "lock", &len))
+		if (of_property_read_bool(pp, "lock"))
 			parts[i].mask_flags |= MTD_POWERUP_LOCK;
 
 		if (of_property_read_bool(pp, "slc-mode"))
-- 
2.43.0


