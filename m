Return-Path: <linux-kernel+bounces-277280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA4949ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FBD286AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11104191490;
	Wed,  7 Aug 2024 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FgZNwb1Q"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BD15CD46
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723004539; cv=none; b=qMBQcfUwjBwXFTZQ3z4Z/nvmS7JcuGKCBuZ3D7sGuEUxE+6DOPxoq24RocOeNvWBwVEAyB8y8EUjhtgSGyO7G/HK9G1rIKumW4BkY5VTZ5ZUFI6CVE5NUTz8tlr/5YlIjt5oaDbkjODqyI4Uh0XGdHffTUHGsJggreB6Sl9SH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723004539; c=relaxed/simple;
	bh=OUDVZVpDM60+WJw/4nQN+i0/BS3Fu5cb1j+2laPnrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GU7orREkm7uzm63M8E/5kbmsupN4xXtcy2Q8otV2fK7JUtaVg+acYiHLU5jJBb29Q2rRlHLJgdbKVfK4Ulz7aY5gYlX+jaN3jMYqVgo71e3Dg3NNgmemBxtTgIew1W/M7pMhOUVkJcGvEimgDrYi6akRx/njZiE7daP5IPW3oyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FgZNwb1Q; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso1013119b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 21:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723004536; x=1723609336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODrrXCKFl27l0TdKNyRcbT+VPRTMv6P7XxyHAeczN1w=;
        b=FgZNwb1Qu/oxiem+m5FjFN8p0unqv9W0p1n4PM1be5YiFrTjmadoSW3o0lecs9Jje9
         SpqLJWVNY3wUkkwkZLvBFe984Pi4Bb5Ycw0KWoTd5dy77a8pV7ynANGMSBnB2ZGQwTfx
         Etnj8kSSoL4uhHs+iSJeXUmtcTBOcGJkzcZlu6Iw+hVgQR+El6ZaTDsKxHVvx8+Cnb3Y
         znTDKgF2FyHNHAzmTlP74o7HEd9h3FPkusuuSJ0c/sJ0diH7zRlxZ34xC8Kna98O2tGI
         lwaaAJGFBuOEGE/4FDrH8IFpXpOLiE+WlU+QC9VJiaNdDi+eT/h0eizw0KA1aKGVh5l1
         7RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723004536; x=1723609336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODrrXCKFl27l0TdKNyRcbT+VPRTMv6P7XxyHAeczN1w=;
        b=eenIsmeRCRU2UOTTN4JSoDPWRHfmLwx5HFqQ/gZMJNv86n8mj7nwW1lSIBL9TK8Mbc
         0vJZam+81jnA9bHdt4/+r+A2la/r+u7w6tce82ErH9qQNfnrPCKSkDvRHdCdN1ZPUCv4
         rED0HcMQgXMzmcvw8QsFicO6RlftM95oevxUDptjRzmCuMTicV+6f6o0GYFj2GCaxdHi
         GoJn7QL3HQ7ay/pplHTFCiGRoxsYCDvrLVjVuStwBlwmR7ZjIafRJqU4gAEDOAcotopO
         FN5a6zAI8s/iQ/Q7mixVWvDEBxhNZGapr9QJ1k4ve/amyM+lop7u+tkl5K2zPgewfgpE
         TnJA==
X-Gm-Message-State: AOJu0YzVcFpTnFTNVAzRSXWME7DVJn3+tFQrQektcleME6skUnUG6Aew
	xFfAxCcu6J6g1fgMtFe1BwHAEpE5WNOBfQlHuZjbpkbxj/BZGLt5LPKLHWgN3rG/weeJtj3yGED
	o/hC3Zm0e
X-Google-Smtp-Source: AGHT+IHo+QNBUmRfFn/4e0S3w4ZD7r2yxF/jnyAMK/mgIKa3pyo24mQ7IvIDkoO38jS2ZwactIBmLw==
X-Received: by 2002:a05:6a20:1596:b0:1c0:e540:7336 with SMTP id adf61e73a8af0-1c69953c6d7mr19039259637.6.1723004535952;
        Tue, 06 Aug 2024 21:22:15 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec49b7csm7630532b3a.63.2024.08.06.21.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 21:22:15 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] serial: 8250_platform: Fix structure initialization warning
Date: Wed,  7 Aug 2024 09:52:10 +0530
Message-ID: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use memset to initialize the uart structure instead of universal zero
initializer to fix the below warning.

drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_probe':
drivers/tty/serial/8250/8250_platform.c:111:40: warning: excess elements in struct initializer
  111 |         struct uart_8250_port uart = { 0 };
      |                                        ^
drivers/tty/serial/8250/8250_platform.c:111:40: note: (near initialization for 'uart.port.lock.<anonymous>.rlock.raw_lock')

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407310023.h0JgJG1C-lkp@intel.com/
Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index bdfb16bed4f2..d8c3c169a620 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -108,11 +108,12 @@ void __init serial8250_isa_init_ports(void)
 static int serial8250_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = { 0 };
+	struct uart_8250_port uart;
 	struct resource *regs;
 	unsigned char iotype;
 	int ret, line;
 
+	memset(&uart, 0, sizeof(uart));
 	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (regs) {
 		uart.port.iobase = regs->start;
-- 
2.43.0


