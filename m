Return-Path: <linux-kernel+bounces-431519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6E9E3FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32574B2C827
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5120ADD3;
	Wed,  4 Dec 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+9+s9rM"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F617187561
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326580; cv=none; b=H0dWUFLZ1l9rifWpVkrO7sssvxjYxI0CgFnRDxGS/Lmpsn6hHF852rkslx0Beib+21XzK8pxL2z8Gpv2mZZybr16mUfEY6+7jwfjWN9e9DHIgY3RoGsAlhdIJOJ6oCOFoZBGrbDHBlypyHuaVAAndRVPJGjh+K+EI+3wCON8fW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326580; c=relaxed/simple;
	bh=SOg4U58pctz73sCbUo9T2j2IOYdIASzSlvdlUNsaXHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FU4UhQZ8BYQ8BuDCgTe+4TBsoSkKkKFIFg8p1Av6+04VW11I/j3SRyBbjEHp2S7nnT0Log8H02m5CakcwQ+tvdw64fRHtV4vF+6Hzo7X6X4xGialsSZBGfO/hc9ZtpLFCRAa2U5oGB8NyZiTISr0Da59fzQygmCtPJR3Ca86xkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+9+s9rM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385df53e559so4102062f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733326577; x=1733931377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zclw9J11Yaq/On5xckpqjl4TPnhtbhcGF/0oEDc114s=;
        b=Q+9+s9rM9zvYjRAecWRK0QPwSuygvY7bh2I94EKOIWD0JJw4eYOOlsuP2PP6rfj5FD
         ZNJH8ULzBZg8enb0dqVZyXk7vQPaKiv5TNKB2KBt4pe5pqg8kLWr7qwetad8ferGgBYD
         DTJeQdUJpvhiZtFd2Hk1naa00XDeM+r5RsYa4nsGE9pvTj/WDQrXkQtAq9bP0q46VMXb
         6g8sA8Ts5r4xZG4GV3h+8qa1YUOy5TGItkZHqpLDlqHu57jhSOWX08n1VAAp8AwW+o9k
         5klWW01UrMoKMQH3E+tegTVEqer+3v5xbGsb04GhIdyQ6vVmSbojHverebUUt+n46XEF
         37Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326577; x=1733931377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zclw9J11Yaq/On5xckpqjl4TPnhtbhcGF/0oEDc114s=;
        b=Zduw10UY4qgs+0dmvvo3KUksjEcaUzHQsoq/aptBOn58PJZfvem8U1QYuPn9IgnLYp
         E2BvboBb7UXA1G1vuazfr4m0Jefa9HOSowbDT39Zwv8rn+YA0G4lKerv4dnUiub0bq0a
         oHgPVp3CKj6l9qzVFPioF/6Q4ItnL87bQIMvgkpg8/LjF5z36/aAHbJ44QGdpAQrXDrP
         Sx4lXLrLCigMSPffbdio6WE2Hl4IJquiHbqzlQ9yvs2LPiJadCsN8yh9PC3sAlytEEHA
         Wzz+F2h5sw8NACKJBgbFzpiaDWQ8TUVKAYoKZb89jPYwhj6mT9i0+UvV93w+/ufOPizQ
         b06Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAstaGCIRpH2y/dzGYlKZhEA74rP+9RfK1P4ycvBTW+Bmf5kPkJXzDYrxkR/GnqzMwwZdKIJhuFvRDclY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvoWAzRNRpGqBQkHrBvRg0eIVxT3Xz4Y5fDyTNi1D9Mzffxewg
	//yw5nZaYY73RkLrK9/M2FIcfOZhqRau2oUnrtfwMtpvATY7Y6O8dRuy2puW
X-Gm-Gg: ASbGncvp2ZXIP+vgwyybhTzAcwgPryYOcMvep33uIPQBDFnObq2J1ICcqOgINC7LILj
	1Hv6B8HY5NZAv3zxHmIjeNmy+JbPMewxDj5PibN/vsBmokfYUHcViSr2XTgISjocr2h//C01+t6
	P4cOWaQ/hqd1biMRkEfqGfHjQGXVzHaFdkdMHomT4AJg0VMRzWbaW1bGdKuFNIjhaT0bIKvmuOn
	tmeNd3yzpIOAttwd/a8vhPAz+imWSqqXOkeU4n3lBOHNbHa8eE2iXArZ+AucsjHn9uDUmYcdUxM
	+eS5KVIaKw==
X-Google-Smtp-Source: AGHT+IEkTfaXH/Z38oXTKSr37ArhtWR8oYC91y2lJwJ5Q1vNBAtYyQtIDtg8OhhBBlD800tMKVZ61Q==
X-Received: by 2002:a05:6000:460e:b0:385:ee59:4500 with SMTP id ffacd0b85a97d-385fd423b55mr6331141f8f.39.1733326577501;
        Wed, 04 Dec 2024 07:36:17 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b6854sm28921025e9.42.2024.12.04.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:36:16 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4] staging: gpib: Fix i386 build issue
Date: Wed,  4 Dec 2024 16:36:12 +0100
Message-ID: <20241204153612.22867-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers cast resource_type_t to void * causing the build to fail.

With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
which cannot be cast to a 32 bit pointer.

Disable these drivers if X68_PAE is enabled

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
---
v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
v2 -> v3 add changes for cb7210 and tnt4882 drivers
v3 -> v4 disable build of drivers when X86_PAE is enabled

drivers/staging/gpib/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index a9b811165f6b..a62d7d36ea85 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -50,6 +50,7 @@ config GPIB_CEC_PCI
 	tristate "CEC PCI board"
 	depends on PCI
 	depends on HAS_IOPORT
+	depends on !X86_PAE
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -62,6 +63,7 @@ config GPIB_CEC_PCI
 config GPIB_NI_PCI_ISA
 	tristate "NI PCI/ISA compatible boards"
 	depends on ISA_BUS || PCI || PCMCIA
+	depends on !X86_PAE
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -85,6 +87,7 @@ config GPIB_CB7210
        tristate "Measurement Computing compatible boards"
 	depends on HAS_IOPORT
 	depends on ISA_BUS || PCI || PCMCIA
+	depends on !X86_PAE
        select GPIB_COMMON
 	select GPIB_NEC7210
        help
@@ -174,6 +177,7 @@ config GPIB_INES
        tristate "INES"
 	depends on PCI || ISA_BUS || PCMCIA
 	depends on HAS_IOPORT
+	depends on !X86_PAE
        select GPIB_COMMON
        select GPIB_NEC7210
        help
-- 
2.47.1


