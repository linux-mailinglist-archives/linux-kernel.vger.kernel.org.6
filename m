Return-Path: <linux-kernel+bounces-428050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B19E0975
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C430280D10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647B1D9A41;
	Mon,  2 Dec 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLy/OGbq"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DB1632F3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159257; cv=none; b=XQUNzUe7U01dfjpV6ImTpFUDi9dhtf18ywxlTQByu3+xf4RcZJebpGI7o3hcqP4ZWxSP46PcOtCasjLKclpYkXVN/rG/FkR5g96gglF0viYs4Qha6Cri7gO74VSslQ4ikiEQXTZwqto1gYHolFP2lo/IbMQw3HRUeMSl5lMTI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159257; c=relaxed/simple;
	bh=xoGeQFsGXFdenO6BztFVvAvCo4/fpYxbZKwlNh4KCC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2lnXtKqFmJjtL/JoKcYvzoprz8nqBKl/Zllc9iZtUfuhwv4c42VM8G2Y0/vQCHyMGorrXqedLn0DOyp0W3Xm7YK6KUx5W8n0AtSq001yRmojgg44ZSA2MrcdZJeo+Fl2i7xs+1ddkC1fa5WwkdIlpD72W5hzKBeaSu/PEi1lzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLy/OGbq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385df8815fcso1996426f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733159253; x=1733764053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VD2cckSKTuny/Z4/W//PuWPqxulyYqdgQLc6S9jdIVI=;
        b=JLy/OGbqqYR4QZ2qVqqdWfOoLNTlWNCsxwAvz3y9XN+/95ewQK6UPcKospc90OQVEq
         gHOYa/4B1dL4CKMoSNLwFp/4rRVPUzM29Rft+T2CRcVKuenjLn+vmmmzJy20OWyGFxIU
         sIJoU/flG5stphyEdDxIELlSuOKZtUV1KM9gvbzcxOUaalgb8zadFZ9B8tRzCq6LnmY+
         8Kvtb33AHh8+H/MYQV/cNZApWoNGAgbRsn108gv1rKFU0v7BVGsDbr9a8F56+TX2wK0P
         4TYfteDFuh5Z9y0mO8LfYhbrAcI5gpCSlX3ISLj8t/JK2m45dzW4NgimFTFlF8aCaSrw
         A8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159253; x=1733764053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD2cckSKTuny/Z4/W//PuWPqxulyYqdgQLc6S9jdIVI=;
        b=KlVco8ox1He0yCg+jDeNvSVHY6pVo5EekiqyaWB/1GoW67k1bA/VY5k0TF1pkFoUND
         qLpSZGrepkmtndXZ5HdVG/8OAEFr/tIzp9QcDg086CMtlo2+WIeXM7pOKVDAjEiUJ6h5
         slqCKTDp8qmDUGOMhy0exlHFU8fin/Z/eQlnIuqKKjNeD+mB//Rf2Xz4dtt8T2w8+TDx
         2H9z2+fWZ7hpqZwhgvzFaLjGsYufC15RUdCVAdqpw+Qxvdz3qFZM2NAfXDgh0EKLk5Mt
         90Ij/qPqCGHe4/GgsG5bZfznuA/ZEulsoPwvBJhz2PLSCMB73nTN803iVDM1S6gnZMJq
         kplw==
X-Forwarded-Encrypted: i=1; AJvYcCW0E/FfSmLIzRmZpdE5XeSqZ1VmZgBi5AuuX1tiMH9u52ixVgNuhQillraewqCaMbTIo27MorPGONS/O+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sx5x55BhEhy6Nmy2Tq1/BPXcQhI61iPJsOeBOD8pHV34Np4N
	oLqbSrIV4Fg9i22WAVnwsQg1IW+VlTH4UGC15fh4GbHagKCM21hx
X-Gm-Gg: ASbGncsXJnX4NNMbRPvqeOMHi6SrLY/2v1UthyImhCJC5Rv/uzuceCqFh1ki3/6azWu
	HITv0qnJHzYqeO2nSqQupHlAwXSVw7QjpFe8DD1Riyqy3RZwa5+8nEGwu+g6xOj8aixUZZ1OzQ2
	TYcvZ1uvLctJ2ptrQiWGxIANi2eX7IuxY0RrdPKVBQ0mw/CMvzeWYr9AuBg/FVnOXTkJPqeEI6A
	v1XJzU8/DmovLasMejrT786aXh5fvzCNliYl74or7o2pzquBDWJtJVMs6ulIuzBQullmUXN/QuQ
	D2e5Xc8QJw==
X-Google-Smtp-Source: AGHT+IGAlHAC9hMBIXCdazq9ZUSG21hrjoyyc0/QSMt57xsY9IH+cW4PMIBIR6n8gMAu9psUqWPfEg==
X-Received: by 2002:a05:6000:4801:b0:385:e3d3:be1b with SMTP id ffacd0b85a97d-385e3d3be6emr9133421f8f.28.1733159251424;
        Mon, 02 Dec 2024 09:07:31 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385de98d618sm10434034f8f.90.2024.12.02.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:07:30 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux@roeck-us.net,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Fix i386 build issue
Date: Mon,  2 Dec 2024 18:06:13 +0100
Message-ID: <20241202170613.4889-1-dpenkler@gmail.com>
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
+				   pci_resource_start(cec_priv->pci_device, 3));
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


