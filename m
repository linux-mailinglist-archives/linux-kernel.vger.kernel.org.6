Return-Path: <linux-kernel+bounces-324111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252C974801
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352F61C2546A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4E27446;
	Wed, 11 Sep 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fk/uFrpl"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA7C225D7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019912; cv=none; b=TJI16eaYzipjsaNbBB3WLLnJB6c/8xbwpV1qeP6O65H+hDZGlR0q9QEsLgfZTQRiq6+9hGvM41QVh7xdZoCkyISAulWAPN/Oj3DFD1qyUW3yRj4aijaD18syX5PE94yeej6Tfk2jdkTTArUGYRkS6pwT0fFttVmox9i+kWZ7+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019912; c=relaxed/simple;
	bh=0EFMw3SRkvYMgNTA7vSI8wJ9KODSpg0kCS9jWVoDcmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXGRFKOYeIw1ByxHElTMfpv9laFA7CUacMtIfTKearUB8WdQWcbbH0iQrt5UIySpK6B+KPBX11CyXaACOjORiLmFZzHzw1oRXX4qLv5UxrfppB1V8Z6ujc6NkHZrXVxNLIucA2XFDlUlnwiXHoXvNCnMEyXLTotrs5dH//nabPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fk/uFrpl; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=J6AXG
	gTxHDU2guXI/u7d3q2TLw5oNU6irbtQtNAV3lo=; b=fk/uFrplVHi/4SGiYsrCX
	igCN4lDO63uqq3f1s/FAQKXHMjIpKdYa6NWchDq3P6Wy5s3GBX5go3M1zqpdx3ix
	IvZIq8xMqKRJEKYHUGWoQNuOBA/R9+Q4tiUJxgqyxyr/ur9Xu6MyNfWy3ENxNVic
	Cf+Lhnga5qRG+zMTiUMpP4=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wAHDtws+eBmy2yaDQ--.33363S2;
	Wed, 11 Sep 2024 09:58:05 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] fs/ntfs3: Remove the unnecessary 'if' statement
Date: Wed, 11 Sep 2024 09:57:54 +0800
Message-Id: <20240911015753.49513-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHDtws+eBmy2yaDQ--.33363S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrCw4fCF15tryfWryDCr13twb_yoWxArb_Ja
	42kF4rK3Z8J3WI93Z5Kr4YgrWqqFW8tFnYvw1xtF95Cr45tF45Xa4qqrs5AF4ag3yDZFZr
	G3srCFW7A3W5CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_db1UUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxlXamVOGP6WDgABsf

The 'asize' was already checked to be less than SIZEOF_RESIDENT.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 fs/ntfs3/record.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 427c71be0f08..0f400366231d 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -268,10 +268,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
-		/* Check resident fields. */
-		if (asize < SIZEOF_RESIDENT)
-			return NULL;
-
 		t16 = le16_to_cpu(attr->res.data_off);
 		if (t16 > asize)
 			return NULL;
-- 
2.39.2


