Return-Path: <linux-kernel+bounces-402841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFC9C2D77
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 14:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBC1282513
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280517BED2;
	Sat,  9 Nov 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6ix1yoy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C41BC3F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157604; cv=none; b=bhOD+RHzPLfB4IMo9z8hFydhoyFSiYXMNyZzCBWh6rcZdUPZ4PCDlsF5wb0+FevR9zluFYVKGeGsakRttvbG6bfeEXiPXStxcVAYdfMn+BSlFijC8s4KLtgSbs6igpwAtpWNVde9a9/K0tRQ9ef6xE6mF22DSWnyyK5zmMiS6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157604; c=relaxed/simple;
	bh=mm9K2xz6Oebcgou/IL/b/qlatzpNrubhgk+71MJ3grM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aLisNHconYS6T9FFCTXTi3IAbTbueN3ytQLO1++0gDcE34cAmev/83Ig3pqfh1cjloYm5mATguUTvlXi8auhY6qBvY9oxfzCWffCcSHITeiyMQZqZSBl0PP4t6y00rC4kuWC37R49H01AkGXWSKcqbP2FRseYC35SnxL3VBF6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6ix1yoy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so3751152a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731157601; x=1731762401; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1LH9F4fl/SCwwpRhotRkshccuFBLM0AoD3ZbJEdUKs=;
        b=f6ix1yoybhecFqFxNols857G2M/MecvV4DZw8NiJn8EHoco4Vx6qUwLn1ERhb4qTiz
         kgLvEXFgQ5Oi5lmoLaomImPvoRW4pfkPW43bc16wLpbNH0MCO1iYwnzZ/0xY3O105cvq
         SF3XCTXz7QZNFDFbY/Jdzv4tWdKUnbx6URjc4yXoa+Hlners6IDfhdmbWSIECfBTHgzp
         C5IcxYAC1iOcpPYwbelQmV7dBwWJd1ybagQFsA6XFEyO86+l8nOaSPwZdNWVrbTTiod9
         nEF91q+GBNIQ+npHgEMP4z2wsYsmgk1QtRG+QtpfzScXN16gU5K0rW5UctiWlUMoTZmd
         Hrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731157601; x=1731762401;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1LH9F4fl/SCwwpRhotRkshccuFBLM0AoD3ZbJEdUKs=;
        b=UZ5uW96SAS5kP4nYVuuSiKZcO8nDh5eatO8uUx0OSXHcKYYZTa/5R7ixOb+fchwmCZ
         L5gWbRZL7bBSDMs9qCkZufCWx6t/nEcGcXUqdcRWVuFpTEJQh/RLq3W4ujl58wCyMSnf
         IiEquXjwq9cd/iky5FSbc0DXu6DBAEr8UDKHoxBuOrb//6DxSow93po/oPC1Qz2NR5Kj
         zyGKLrY87a3YKf9p0jh9msPeAbTYCVfzduV2jd35Dw5Umf/OaiHmATA/h8J1H45WPhRh
         Pw/rhWt4sqVERHFyzYytuRP2bazGPpWKtXuIqRhRotwZhZ3e5AkThyR9UblLdXNYJVGm
         Rqrg==
X-Forwarded-Encrypted: i=1; AJvYcCVoUzIsOAgbMti8Fa58p45Te2p35CZcXpxhKDdptr3DZkRT/+rrKBiGaRnCv64nlnCAthrGglOBSzh2BsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsKee3LoI7q7x/CHxQ/JnoYlqnoSG04vJHUUGjwxLtPWsqamA
	AM9rIBgJmKUi3ePZoEmXGcrvyunK066/r18zrotufD1rNyJn4eKhNH5ZhwqS
X-Google-Smtp-Source: AGHT+IFwskzHVlYtfLNHpgXDc3MAep1lUrE6+lpwhYGiO61NRE1vLY6Sz72u6wFh36h6WeJiN8oRYQ==
X-Received: by 2002:a17:906:4f96:b0:a9f:168:efdf with SMTP id a640c23a62f3a-a9f0169008dmr189961566b.6.1731157601093;
        Sat, 09 Nov 2024 05:06:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:e0:9868:f700:d4f1:16c9:67f3:ed1d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb83acsm2972516a12.51.2024.11.09.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:06:40 -0800 (PST)
From: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Subject: [PATCH v3] Staging: gpib: gpib_os.c - Remove unnecessary OOM message
Date: Sat,  9 Nov 2024 16:05:54 +0300
Message-Id: <20241109130554.3652-1-m.omerfarukbulut@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

It dublicate the MM subsystem generic OOM message. This patch fixes
the following checkpatch warning.

	WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
---
v1->v2:
	Changelog text wrapped at 72 characters
	Unrelated changelog text removed
	Trailing spaces removed
v2->v3:
	v2 patch wasn't about what changelog text specified. That
unintentional mistake is corrected.
---
 drivers/staging/gpib/common/gpib_os.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 6b12404efe7d..6eec8ed79a3a 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -2093,10 +2093,9 @@ void gpib_register_driver(gpib_interface_t *interface, struct module *provider_m
 	struct gpib_interface_list_struct *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry) {
-		pr_err("gpib: failed register %s interface, out of memory\n", interface->name);
+	if (!entry)
 		return;
-	}
+
 	entry->interface = interface;
 	entry->module = provider_module;
 	list_add(&entry->list, &registered_drivers);
-- 
2.17.1


