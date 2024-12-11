Return-Path: <linux-kernel+bounces-441682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FC9ED271
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C4289431
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCA1DDC13;
	Wed, 11 Dec 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlLEDeZZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AB1D9A6F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935500; cv=none; b=TtFWrIRoNdoXxfGjmXUeUUtHrWCfyN5qzTdLY+2yizIh2K0Uw7RwHVmeeX5nxU5FMMGtKv/zgd7JscrCAiNp/E5J7NkyNV+rHIxK4nMrLM1CLmdZHIyPwOc89fhdKzWYT06GWkTfZlNty4gE3OWdfUbZOxEFHmtevrpZk6vxoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935500; c=relaxed/simple;
	bh=vikcd8r7ScZCxNhv+OmusSOW7Hh8BXCcQ9OyvL9igoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9mDciVjjtQWAA2oDNpXlqRT0K1dzzC50nnWDSkC9c9ivHu54XVzMa/Lv1JqU1G/y3y8oNH93hMC8gkp8pNhpgyHYmhIO1xFrRCwhlt96eUS3udvBOLXKHFUE97kB2uonB0dBiUyCbpwemPnun3f0LEtQh2qe9zndvicRArg/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlLEDeZZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a2033562so59789195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733935497; x=1734540297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6Qqu0nEFq5zDjW4RPJaEsHcxHnClrN0XqD2UdNAltY=;
        b=MlLEDeZZkTcyCDRtziZOl1AEEj+Qo21lENrGRu1XZ8TvBGUEPUZ/HGqGvAMGdAYl6L
         volwrLNp77oBlfdcexsDlmfgfcSFFEb+BOJwoU2Ey1lMtDCNXvkWhfO912HPArnag4EQ
         gcBL/WYR8wxt95IyBhcqhFSkQJp+DNdyHxD/Wl7upvZCovbQJ5XG7j/LTjgcpBw8q3G/
         MyFUGB//2dA/Ju3AFLoJghGLIT2t5P0oo0T45jh91wyszkEsFCU5nmuGuu+fMinI0jUv
         +9UpOc70KK/In2FVXfQqFaEwZ13h8SXagCllZO/ojDRegB8o1t01sCVF/TNRbDW30OLI
         GyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935497; x=1734540297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6Qqu0nEFq5zDjW4RPJaEsHcxHnClrN0XqD2UdNAltY=;
        b=HG8QpG81tE60iBYxvTvMfyvOIySCOliDrDWDEntnNUy7b3iAFWBczyqGVsOYm2ATo8
         kmM9iYxxcqZAcmvl3uizuQVTCwmFjt4xxTLZn43QVc6N3zhzEbfCp9kzEuDGeX66zCdq
         4B3+r3uSi6NXBvBtQIfcyUNZLNu1oORCy0hXCzkiZ/va2UugvYimI5ZOdM2Cboc9+iEN
         TB8/3mLiuc2aB/TZvdIxN43MKyYX9Dj+4C0eFyeyL/VU3tdErSEyth9C15N+Nc87gM5s
         5CDA/5zp66tZbpobijv2y0NqPu9WRtuDMVNsdm7Hc4iFtUwlMLoCr/cs2163lsrnFEb/
         OppQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEA5/XB7tfkBGOEBij2ItSeIctuV6Z0UDCiGOidKMyED5ttZPUbB4qltLNhxu/T4Qcd96dwoPr6UkpT/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgdOqJPUTytEfCfIhYykbpTzVSU3TLjq4coT/VcTBrO381I9R
	oMGMJ7M21JB+eXkGy6wzKw6qb+OdB107Jz8rarNeCwn28qCAwQYk
X-Gm-Gg: ASbGncttPFio4rCEfqcDYmLWceuRwF9dtme03T7xVw76RqX6dInB0d8qZ8RnNsp6nil
	K68CM8dwzfS9Mq5Nd0XrfcZ2K6xyKcHvXkD1Fwc1rlGg1HEJV2vIRRgbP3QKIScUThPcuT4EMMi
	l594P4zZFeEmJL0UOVqjD5RD9tHXd3xOpCEk3xsBDmplrfXoqkEIWEfvtZuGeEggjSXlxnmxeLX
	bvumPpW3gNou0nHVUSXwlzhwbpPUn/XsnQVi8+luXwSwOGQPk+kJoeDdABSRgv4yS74QkkyVOi+
	yhMERPkUi5fnKw==
X-Google-Smtp-Source: AGHT+IHtb8YXfS+3OJUaIz2+dOdJU4ffLMCPGWuDmWhDzBy2fdggeuYKtd6THPiFxztWcEPU256ldg==
X-Received: by 2002:a05:6000:a14:b0:386:4a24:1914 with SMTP id ffacd0b85a97d-387876af3d1mr239766f8f.37.1733935497063;
        Wed, 11 Dec 2024 08:44:57 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dd9sm1637501f8f.69.2024.12.11.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:44:56 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	geert@linux-m68k.org,
	Dave Penkler <dpenkler@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6] staging: gpib: Fix i386 build issue
Date: Wed, 11 Dec 2024 17:44:52 +0100
Message-ID: <20241211164452.27464-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers cast resource_type_t to void * causing the build to fail.

With a 32 bit build and PHYS_ADDR_T_64BIT enabled the resource_size_t
type is a 64bit unsigned int which cannot be cast to a 32 bit pointer.

Disable these drivers if not 64BIT and PHYS_ADDR_T_64BIT are configured.

Link: https://lore.kernel.org/linux-staging/2c6c7e9d-ca10-47a9-82a7-a2e26b1f51ef@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
v2 -> v3 add changes for cb7210 and tnt4882 drivers
v3 -> v4 disable build of drivers when X86_PAE is enabled
v4 -> v5 add missing signoff
v5 -> v6 Non x86 builds were also failing. See discussion under Link above.
         generalise the build dependencies to exclude the drivers when
	 the physical address type does not match the arch word length.

drivers/staging/gpib/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 95308d15a555..36a29b52ba30 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -50,6 +50,7 @@ config GPIB_CEC_PCI
 	tristate "CEC PCI board"
 	depends on PCI
 	depends on HAS_IOPORT
+	depends on 64BIT || !PHYS_ADDR_T_64BIT
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -64,6 +65,7 @@ config GPIB_NI_PCI_ISA
 	depends on ISA_BUS || PCI || PCMCIA
 	select GPIB_COMMON
 	select GPIB_NEC7210
+	depends on 64BIT || !PHYS_ADDR_T_64BIT
 	help
 	  Enable support for National Instruments boards based
 	  on TNT4882 chips:
@@ -85,6 +87,7 @@ config GPIB_CB7210
        tristate "Measurement Computing compatible boards"
 	depends on HAS_IOPORT
 	depends on ISA_BUS || PCI || PCMCIA
+	depends on 64BIT || !PHYS_ADDR_T_64BIT
        select GPIB_COMMON
 	select GPIB_NEC7210
        help
@@ -176,6 +179,7 @@ config GPIB_INES
 	depends on HAS_IOPORT
        select GPIB_COMMON
        select GPIB_NEC7210
+       depends on 64BIT || !PHYS_ADDR_T_64BIT
        help
          GPIB driver for Ines compatible boards
 	 Ines
-- 
2.47.1


