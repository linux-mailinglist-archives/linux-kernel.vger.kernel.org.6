Return-Path: <linux-kernel+bounces-339343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15F98640F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54090B23DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CAA13A865;
	Wed, 25 Sep 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lIHx3dJY"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443A53376
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277920; cv=none; b=uN1r2wCKSheOvxhr4zvdp53lRGEE1/7w2uDDX0T/sY/Y7MiIpWTTZxNcQuA1lwZwswfdRGt8SyM/6PNbnax3OIeJLXYLpQ1rQ65xBI/uUeWIULhcxUmKeGjRvE5rJ9rHsbFTDi6szSvdUq8zs9y0Bz+RlVYp8wrqjzvPRmbIudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277920; c=relaxed/simple;
	bh=/ZmUMys4DtorXcnR1Qb85Qe9XFVHtwDK3x2Oba/L4+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxV1XvAdBGtKdAKLA6NS8AwDJDYGJSvGZzNVJu1c7oZsiO1vrttn/TMYKP+KFoabir7iugVhDixzrltJP4/BLnfUd7o63jyGwhEXqU2/GM4MkcFLOp9ZqEHMYIv1OctJBFBBodsK5x1rF/utoPhbMDVuc1mT0PDk0KDEBwxuVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lIHx3dJY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c54a5fbceeso51446d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727277918; x=1727882718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orIOabJvqf20M5UAV+7ODryvOD0sVY9jQ3+6D8aBSg4=;
        b=lIHx3dJY0s4/GfALNOr6YSNqLkyM6spHclF8dQDKNchnezjFzYLzTL73cx0yAgsb9D
         AE9ELp6LeCArE7KfwVTuAtxzYxACkd9ItWSeO6TWFGg+eqpKAmgLed8anpSSrkNVwpEP
         PV84MmoPZpnA+7I746Am38hr2ZvrWeJSTdzDmiOKp1G2itUflxAT7xodCLT0Hd4guTOq
         D9cFd0mIzJ7n00xytQlxNH22DzzGUsHhZuHzXlUOo9D5ueGvfpwexvys81PcAuqy0cUP
         +w0ANwdPZ4aL/cotIVc3jD2ZDVGYTF/Frmg5X2rLKgBO8JwE7XxVaqYA1OvDzpI7j+1M
         lvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277918; x=1727882718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orIOabJvqf20M5UAV+7ODryvOD0sVY9jQ3+6D8aBSg4=;
        b=Hy9gMropqSRThQ5P3w4x9hi6rXTk48OyxaL4WXDlk+kKMosEgVm3il4D4xEh+FfWBj
         59mHbWbouiqS3vY+n1J3eWypPXZASYEoR0GkGVYdnNnpO1Stn/llJ+3gIPpljqBR7uwz
         EJlC4/uRU8QqXv4SoElBtUkTb3tcGkYc9WKuWVmc2Yl3ekzNG6FWTL92mX2GIN2cFTQe
         iSE4vXzy7xsUz4Ts7ZvIOReMhewrtLkRTOQtDLdoXrSjzzP7UhRI4i7awX5+j3lkSKsv
         +XJr3nwEB47vAcrkM9Sfhygc33RqAXKP1T4aVuEN6qEgjpx8j5zN/if+yTymHKb/z3Au
         u8+w==
X-Gm-Message-State: AOJu0Yz8aA0LXFN9/vkBlyvysXeX40isPBp0irOPCunZVPoE+Br8+w8G
	g6JVSNL7IYZ65gldyh02m48q9U2iAD77CcR567TvemUZxSJaSTxlmzTi/dawnvM=
X-Google-Smtp-Source: AGHT+IHiFngUSnA8bK4RDalu/gI9E5kd/laZHZZZkJO9IZtX9rzd8lIUxM/bxgBqoO1qdJ3dIV5NXA==
X-Received: by 2002:a05:6214:3287:b0:6cb:2ad6:78ef with SMTP id 6a1803df08f44-6cb2ad67dd6mr16130356d6.4.1727277916341;
        Wed, 25 Sep 2024 08:25:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb254ead6fsm4583356d6.26.2024.09.25.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:25:15 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-acpi@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	gourry@gourry.net,
	dave.jiang@intel.com,
	haibo1.xu@intel.com
Subject: [RFC PATCH 1/2] x86/mm: if memblock size is adjusted, update the cached value
Date: Wed, 25 Sep 2024 00:52:41 -0400
Message-ID: <20240925045242.3735-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing CFMWS, we need to know the current block size expected
to avoid accidentally adjusting the size upward. This causes a value
to be cached in a static global.  Update the static global if the
value is subsequently updated.

Print a warning that this has occurred for debugging purposes if
blocksize is changed at an unexpected time.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..0db7ce11e5c5 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1424,6 +1424,7 @@ void mark_rodata_ro(void)
 
 /* Adjustable memory block size */
 static unsigned long set_memory_block_size;
+static unsigned long memory_block_size_probed;
 int __init set_memory_block_size_order(unsigned int order)
 {
 	unsigned long size = 1UL << order;
@@ -1432,6 +1433,19 @@ int __init set_memory_block_size_order(unsigned int order)
 		return -EINVAL;
 
 	set_memory_block_size = size;
+
+	/*
+	 * If the block size has already been probed, we need to change it.
+	 * This can happen during ACPI/CFMWS parsing, since it needs to
+	 * probe the system for the existing block size to avoid increasing
+	 * the block size if lower memory happens to be misaligned
+	 */
+	if (memory_block_size_probed) {
+		memory_block_size_probed = size;
+		pr_warn("x86/mm: Memory block size changed: %ldMB\n",
+			size >> 20);
+	}
+
 	return 0;
 }
 
@@ -1471,7 +1485,6 @@ static unsigned long probe_memory_block_size(void)
 	return bz;
 }
 
-static unsigned long memory_block_size_probed;
 unsigned long memory_block_size_bytes(void)
 {
 	if (!memory_block_size_probed)
-- 
2.43.0


