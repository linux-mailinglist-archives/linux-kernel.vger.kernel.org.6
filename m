Return-Path: <linux-kernel+bounces-428087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83C9E0A06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A0C1619A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF81D9A54;
	Mon,  2 Dec 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmefZUaN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12851DC074
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160790; cv=none; b=frM9GNZmwgPDyiLTt93ojXjbXJUFUw1HeH+2MbzhnTrhUDURq1Rtp7vLklHsBjYLyv3rMx3Nu4k2NVnH2Yr7adfjO9tq54tgMZY0Vaj5WPKL+3xWLwrnMZ4G0NTPQmbcvXJiXCG/ISRfbc2F4v/2RQCn2bWZEeSyic1GuwsS8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160790; c=relaxed/simple;
	bh=09GWm3NPgrh+ao6MyuAlAXhT7IU3BvGUhq/z4ZdrWN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOxW8yRcNv8lgGop3nddyuSRePxuWWv6kUQSRCAyvwYhaQ3nycbQeibuxg1vevSwpR+dxap4yhwnlFvxVcyfFWGdtj+VBJ1TzIxXE7fe3djP+lMJBVDYfZPHBorO9CML8a4ZCSX6/GY9xeuCx84xjBcRfWD3QLXhw1u4x9D69io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmefZUaN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso3649996f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733160787; x=1733765587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9UepKrEEs8M1uTay+TY4ozxAVh1Q3ubIpqMJm4iDlM=;
        b=kmefZUaNKmFeHnz0BAimywhs2IWAexFO5Yf3iAbWPsiPTRyDH7pAsRqTZxFSHcFxav
         5a/27oBCJUJ9WZFGLAg8Nc6tJC5Ook5D2MU6r0ahRnYk3y/fPNqe0gzlvxYuNDhUY8Sd
         QHd693C40P/h3Fq0X9B6dvyf03ou8jFVtuQzvhprtwUcsGA/S85cUCYLgV2wVzpXpE2R
         z6lV/GjplANslB0YvGorO7wi2HmRVGX6SmtmMx8ATsbP5tDYSIzd/WAuSBMarkzDBx81
         xi3NuL3y35vAlIh4NS8jWzlQZQGYNk5TpIIRE8Y+SvaTVR39MSI/5fHCmGBUj0OvfIoQ
         7enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160787; x=1733765587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9UepKrEEs8M1uTay+TY4ozxAVh1Q3ubIpqMJm4iDlM=;
        b=QYBSiv7JJrBEiw9i5e220/JiFw6NCBFy6IBYmeLuGfG13fD5JRlT52S7Z3ThKkYULO
         I0AQUQgdv5cpH+mFx5u4SkyFLOwrfqzz8+LnBZkFgN1YoJXhyohvgFcmAQ1oDzhPip+0
         Qfi1VOj3os9RUVZjw0lXwGyZpEzweplfvcMHYqNfJoCYEFSI5cm9ZBRbLGrZCGLgx+M/
         2scrpCNreoiGnRgREuzJXAEBVYXrddyIrzAsEqaz6yNcAQcA6pDAUcMOO9JqBvJd0stw
         N7ek5Q2DI8aShttC4Kck3LKWta/GYu8oogJxuPRxHjmfDCkROnj+ZXIPutMH+tyw+nb8
         Dkag==
X-Forwarded-Encrypted: i=1; AJvYcCU1pswsyYtYf0xl/rAMyPnHq6cplPOIOOLJcrW+3ejoPN/k0HMT/kp2lpEnkYSGXmJhV8qlGt8HQrU4+lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya75q3V0eRUMhXQXzUkWtLS5QtK9W0gEhNsS05UdgRNfyid9m4
	mLArRY23L1gAfmhv9Tta7zVi80j4nZIrakbXpgeASZe8K3WuiHd0
X-Gm-Gg: ASbGncvptrN3pJuplSYBPFgY8jjwxm+JaxZUdHGzGo0fvxNejZmpfIhl3RDrhtKKeL4
	JzTdiRZuJSBWjNqahnaDxGq79zKb8ruZy2SG7Vd23WJmgop3kZQr3MDJah7kXo92IvZ6e/QS6fy
	msKV87sLgJqg2ZODx7DYpIIow/994pkR61+Dfyl3SVUF4/qWZtPiwmntmuvgpsRhndRv3F3ixnf
	wp0jNRA4Rl82IYbNM688qq+BRhVMoQnjI83+QLvlzN9dS/8oy3PFFKPb5ZY5clqj5pC6StF/pCS
	y+QdZcrlKg==
X-Google-Smtp-Source: AGHT+IGU6TrGjJrZxC949YpDcF4EFU17N6Vqpt5++NRblmB2X+oGB3LAKLP6YHuEwmTMXaDUxAM/kw==
X-Received: by 2002:a5d:59af:0:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-385c6ebb8c7mr22949983f8f.30.1733160786923;
        Mon, 02 Dec 2024 09:33:06 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dec66e0esm10595076f8f.43.2024.12.02.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:33:05 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux@roeck-us.net,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v2] staging: gpib: Fix i386 build issue
Date: Mon,  2 Dec 2024 18:33:01 +0100
Message-ID: <20241202173301.6462-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both drivers cast resource_type_t to void * causing the build to fail.

With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
which cannot be cast to a 32 bit pointer.

Use ioremap() instead of pci_resource_start()

Reported_by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap

 drivers/staging/gpib/cec/cec_gpib.c   | 3 ++-
 drivers/staging/gpib/ines/ines_gpib.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 3dc933deb401..a1ea4d9e370a 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -297,7 +297,8 @@ int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 
 	cec_priv->plx_iobase = pci_resource_start(cec_priv->pci_device, 1);
 	pr_info(" plx9050 base address 0x%lx\n", cec_priv->plx_iobase);
-	nec_priv->iobase = (void *)(pci_resource_start(cec_priv->pci_device, 3));
+	nec_priv->iobase = ioremap(pci_resource_start(cec_priv->pci_device, 3),
+				   pci_resource_len(cec_priv->pci_device, 3));
 	pr_info(" nec7210 base address 0x%p\n", nec_priv->iobase);
 
 	isr_flags |= IRQF_SHARED;
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 9d8387c3bf01..b5f8ea57fd9d 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -780,8 +780,8 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 
 	if (pci_request_regions(ines_priv->pci_device, "ines-gpib"))
 		return -1;
-	nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
-						       found_id.gpib_region));
+	nec_priv->iobase = ioremap(pci_resource_start(ines_priv->pci_device, found_id.gpib_region),
+				   pci_resource_len(ines_priv->pci_device, found_id.gpib_region));
 
 	ines_priv->pci_chip_type = found_id.pci_chip_type;
 	nec_priv->offset = found_id.io_offset;
-- 
2.46.2


