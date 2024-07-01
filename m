Return-Path: <linux-kernel+bounces-237063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A265991EA87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F032817C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066B171E52;
	Mon,  1 Jul 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aBqJaTWG"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A369381B0;
	Mon,  1 Jul 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870927; cv=none; b=Uv4w/UKSLUtzpEhu1W/VIlgaJ7gO5u8tyRWOoXgVNx6X7Im+gF3/2XOY55fDF0+6IKJEfGiojmxhoh4mp8IOB79Ik47sFuBuEClvNoahPmsJb73GjtA029jbuNp9EAeR1fZi7xEOOsBJX43XsSGn7hebC2gbbO9Mre0Htr/yIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870927; c=relaxed/simple;
	bh=12SMNR8u72TiXsL5dbes5zwak2aSWavSiGdXAJ5ILBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+2djPu2QNibfmU76RUTeCbfz/XOBaBY3/4RbzJ8TZQ4gkeCLB/a/H3R9vgtnNEF8zhdYECPXXOekrksDh4M6/wvovuwMnM8asIidbEmtJPSsyW4R66XmKcBiodNcUxQHRKGvxA3VCKlKx9M5RUqfxflOu00kiKg/n18STs5h/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aBqJaTWG; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de [178.202.41.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6AA4B3F29F;
	Mon,  1 Jul 2024 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719870921;
	bh=7SgtLkEbMZdsVyzJEgqQiGZAzy/v6DItnYAfbS/lrRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=aBqJaTWGTRW12FKKDFBFeDcTLYamxiq8Xa0hBXL6OFBZVYx6A0s/5nojiYQy79O6C
	 h97b1B7aD8MWK8yl4jfGJN+y4XBRk4OmAut+kDa/PxqOChWh8/LewYd7x0XgwuyxVl
	 CirgaNiPFx9hxUF96DjxsdT+akz1yICbx5VKahKrd5yUJ3s+UJPM/YeBqEuEymO6Wd
	 VFvpPi7T0AnMb4e6SzMFyUOC/ZIR54qsywhvzIdvS75+0/Vgr/trXLH+NQWgNAuFeU
	 4UIysD+xeXz057YjXKHZ/353ZzcYuLhH4pDd/R+IbKLUpzVNS+36Ukf4AulFtMFAhu
	 z5+TsV9nQ0Qwg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] libfdt: check return value of fdt_num_mem_rsv() in fdt_pack()
Date: Mon,  1 Jul 2024 23:54:41 +0200
Message-ID: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fdt_num_mem_rsv() may return -FDT_ERR_TRUNCATED.
In this case fdt_pack() should propagate the error code.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 libfdt/fdt_rw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libfdt/fdt_rw.c b/libfdt/fdt_rw.c
index 3621d36..a307701 100644
--- a/libfdt/fdt_rw.c
+++ b/libfdt/fdt_rw.c
@@ -490,8 +490,11 @@ int fdt_pack(void *fdt)
 
 	FDT_RW_PROBE(fdt);
 
-	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
-		* sizeof(struct fdt_reserve_entry);
+	mem_rsv_size = fdt_num_mem_rsv(fdt);
+	if (mem_rsv_size < 0)
+		return mem_rsv_size;
+
+	mem_rsv_size = (mem_rsv_size + 1) * sizeof(struct fdt_reserve_entry);
 	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt),
 			fdt_size_dt_strings(fdt));
 	fdt_set_totalsize(fdt, fdt_data_size_(fdt));
-- 
2.45.2


