Return-Path: <linux-kernel+bounces-436871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4739E8BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD252811E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE52214A9D;
	Mon,  9 Dec 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOyCZka7"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A2214A88;
	Mon,  9 Dec 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728282; cv=none; b=oZulkA+9pMTVS3JOFhKbNEbXeNSGVBu1SGMDSfS/gZWL/5BbBiETXtSRsRtYmD4qRv+zKq0NR3vVl5nm3dO+L1Fmzwn1rQnj1x+ZraH5HsmvPLHz49YRUJThgavs2xyOf/MsUE+N7x1/BTL0GAj7dL3Dx4u1n9FQWqyxaxRvE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728282; c=relaxed/simple;
	bh=kIhpS77+PmzxzYIzqCCI7kx+lIXbjcJOkqEy5FW0s7k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=U4F6Xd80+vO61eEWPZFc38GB3IghVRu/F5zLxSH8PKmb4h6TMQpBXx5InRCZiLW3bfcSqbbpKi9LSJSSMiuhKqrvYbNtEGOh6glhc2CgMc2QiBFy80qtGCkK9DWtmnCsSyhSuOWzMwJcZhP9mcNqJcedmdHOy7ZsKZUFPDYFQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOyCZka7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb34c20667so724615b6e.0;
        Sun, 08 Dec 2024 23:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728279; x=1734333079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXCvGSQBhoZb4HfsO/a7NHa2iM3ytg+7BazDpU9q9ug=;
        b=VOyCZka7vhB8MvTD9f7sn9IcJnNBt783wBm6XMn1Wf6D5Z9khIxeJm45c4EThyis3f
         WP3REGw8dNP7QF1s3iOTiYCTgCdbwplRPZumnru0xH5+1A13Gra0nnDMObJkKo69viqe
         41OYzYzkO47jZZHGlFsuz/9FbYaWGq2UgmpNZ8c0OeRCYjC0J5USPS3ZcMmW9Ex4292U
         PQyzGbidKfWYGcKhBdGDZs8iHI+LcC/RstrTkpZlkZK8XaSe3PofSFoX+UanmHrZ2WX4
         UndATxYO+IMGF4tEEvOfpOJvgEl0INCRNGw3XUk81yGz+8nALdAb21uxByM0IzjDt3Fd
         Mqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728279; x=1734333079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXCvGSQBhoZb4HfsO/a7NHa2iM3ytg+7BazDpU9q9ug=;
        b=abDtWTVJE5u1VRlocUBcFbQwSCHUYVEqsOXxA8297bA47UPunXB0iPuJBI3htY75W3
         ZLuVXeys07etQf10ylPex+dUTsDaz33pRWnEoTHBi7ovGssYeEgN1dwiryjQFQk352Ag
         HmjvnvVpB+QWFfVxBoC8ya7U53i0/jxPlq+BlUyv4Fp7sOzBRTqiJoh1PcR7iJXtUpwN
         Y9ibYGbXf3UORGOA2Vdu/rcNUJQ2Aa5lCrROWiZM259bE+SCTPdVpN48mvGZpKHXVLiV
         DHkF9VCe/oKhXukY2akQgdNv7Re3mrdxJWGNKo4OTsP8F5+kYjtaO0reFHPHq1miDzIu
         B0iw==
X-Forwarded-Encrypted: i=1; AJvYcCV5V9KRgtevPY12X0x+npAkRuq0q19uJ1BCjDUMcmIxJ97DwsMiEUwWhltDsoftj/XC5YAQhW5VBnOd@vger.kernel.org, AJvYcCWZzzG+GZY7t2fsc+GTW0LcndERAMxekVNFqr+ll9L6K0WUX/gYauksFQ9ki0xhwcphaGcYdZ/37WAIXbS9@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZHLceOaoUfVPsWHlGC50u9RTfJhoQ2DYk9jpnWN+dcNsbyu7
	TCXw3NDgSKrNA7iCPgxZVOzOMQAyfTfyqMMhctzIYIHH683ji/Fk
X-Gm-Gg: ASbGnct9+AYr/r4k7HHR/68IJ0ZBVhGqECsa91oaUcG1p+bM/Okjq7gdDQT8HVF7K+k
	omiHvlwZi6zp76HufT3MkBeE+Ff2CfltBqN68kQsjhYqOVzrzep+aLWr6Q/rY6u94uIkLRrb9Gq
	Ow7n8WpDmZZ3aBuKa+G5oLygdIizY/gpDYV2CdrDO+NkJlCJTOm7reN7u2sG35sykS1viH7ADnj
	hm6WWqiv91PWhxXWDOOz26+Kdw+QJxlzHJqKMgkfSzZU/vELupYvIo2az5G
X-Google-Smtp-Source: AGHT+IFwsqT7VvH1ZQKLkcly4Q3Eht2MXjBzxc0eFSNqVIH3M+ua4qIPPmMIpviBVPhw56Hs9UWc8A==
X-Received: by 2002:a05:6808:1522:b0:3e8:1f5d:b7f8 with SMTP id 5614622812f47-3eb19c1fba7mr9768212b6e.1.1733728279562;
        Sun, 08 Dec 2024 23:11:19 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2bdb73d46sm293812eaf.13.2024.12.08.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:11:18 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH v2 0/3] irqchip: Add Sophgo SG2042 MSI controller
Date: Mon,  9 Dec 2024 15:11:10 +0800
Message-Id: <cover.1733726057.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This controller is on the Sophgo SG2042 SoC to transform interrupts from
PCIe MSI to PLIC interrupts.

Thanks,
Chen

---

Changes in v2:
  The patch series is based on v6.13-rc2.

  Fixed following issues as per comments from Rob Herring, Thomas Gleixner, thanks.

  - Improve driver binding description, use msi-ranges instread.
  - Improve driver code:
    - Improve coding style.
    - Fixed bug that possible memory leak of bitmap when sg2042_msi_init_domains returns error.
    - Use guard(mutex).
    - Use the MSI parent model.

Changes in v1:
  The patch series is based on v6.12-rc7. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1731296803.git.unicorn_wang@outlook.com/ [1]
---


Chen Wang (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
  irqchip: Add the Sophgo SG2042 MSI interrupt controller
  riscv: sophgo: dts: add msi controller for SG2042

 .../sophgo,sg2042-msi.yaml                    |  63 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  10 +
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sg2042-msi.c              | 285 ++++++++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.34.1


