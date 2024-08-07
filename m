Return-Path: <linux-kernel+bounces-277373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B729949FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF269283C38
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D41B32C3;
	Wed,  7 Aug 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B0nU2MyR"
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A11B29A0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012128; cv=none; b=n7qQBKSB42f+u7AnSKkG2GFdemZxgO1XaPNYpp0N7J/n9f7ovm97HiQykSgOeyYXdIrPkVxAThPqWCJj/ZVro9Ddnahcmz0+wEif5AqUef8SfNyesEPVDeCMItXE364t1zUMl7uZwKHp2kSSq4bVyG9in067BeIQW1mf71/B6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012128; c=relaxed/simple;
	bh=ilBp4mbpWbt8P/is+bSZyTJdtYmg+2K6PWzsUAJQ5pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaCI60c9aqtAl/pNiNQDJkYKxRuJbjGn1LY4EH0x6yIjzhrgyFgvOVRJHLYfOkOv7Z8G2sneTBEbFi0JxJPIkCzKHKCZ09O6uZUlVEAWEBtqkYOAwCejVrfOXqexjYin9436PwkFN9Z0lhWELSx3IRggGLVvt8b7fFxXznzB3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=B0nU2MyR; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3db1270da60so895011b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723012125; x=1723616925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3Cnd6mFtbJSGETFPCDN577bknl11oPzpBdGoJxqsrA=;
        b=B0nU2MyRN8MH+8mz+VOalxkCqQtFv7AvEjRfgBVgI0QFiLC7rxgb82bTV/LRiUEybt
         JmuE3mq7RowCETbb7Xw/AmjaGQXFWFXGKQSwZ/kSDtO3l0CgoPPNoSStJLEjP4qwekMm
         cwsKRW76QC4mUVPLRqsdqZCgE5BdVEkCg6A4LdweHKLSd4w8Aw8x0ICI99O3oQh6GEn6
         UmEFVWN15+dTypkATrd6L45xZjhzdKBUjUsUWDEhfFXsZoTBp+WUTeikhgtofqRKOofJ
         7ncv+CgdsLMz/pdP9I/V6T6JiskLz1MqN3VaYNXQxtatRYcHflYINg7D3iXYlk3D/HQ9
         TvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723012125; x=1723616925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3Cnd6mFtbJSGETFPCDN577bknl11oPzpBdGoJxqsrA=;
        b=rJw7W+h3bg6SGvuWzCfj3oEWwzs7j2eL6QkMMeiQrC6po3f34t9WfwIqAu7acXXi2D
         X1wXwWpvUaRSQ01qlrEGuMYvg2AG5NJsk56rb2SI97wohKUHJatw1irO6CfejLYZ3KEb
         UNco3pu3tu/ap7weGpwkG9xgUvNhpaC6Lvn5wrY695pxnStrlvFN/CfBbcnJ1k+uik6e
         TOKUxspDBwtxkCQhyyc50LUoLPDr4Rankx9Q9Wcbet0ZI7EvSuyaJov7OHBfV5rXwQ2p
         BPXqO/3ZKdci/q03eRsPY31fiiq8YBrObuRND1ePvxAmwN7trhWK862Miav06/S8h9RD
         4QLA==
X-Gm-Message-State: AOJu0Yza5B1d5aRejn88ZojQcsnz++DMC5BISb5854WWed27o3D2wqAH
	0udeXnzhAW8ABT8e7IF4Hk6AVE45ECKQLZZJ9U+sxTkFeZmh5O9tmbDPmggjBnxBsSm8dqG090s
	fqZa4P8rB
X-Google-Smtp-Source: AGHT+IG3+LYLTW06u/7CE9JfA6rsragN66yfaT4Kj6PNe9WVItBbqMTO8KeQtcDjSJembalV746lYA==
X-Received: by 2002:a05:6870:fb8d:b0:260:f5c6:e9ec with SMTP id 586e51a60fabf-26891d22d97mr21093052fac.17.1723012125203;
        Tue, 06 Aug 2024 23:28:45 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec416b5sm7794916b3a.58.2024.08.06.23.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:28:44 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Sunil V L <sunilvl@ventanamicro.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] serial: 8250_platform: Fix unused acpi_platform_serial_table warning
Date: Wed,  7 Aug 2024 11:58:39 +0530
Message-ID: <20240807062839.1738705-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LKP reports below warning.

>> drivers/tty/serial/8250/8250_platform.c:271:36: warning: 'acpi_platform_serial_table' defined but not used [-Wunused-const-variable=]

     271 | static const struct acpi_device_id acpi_platform_serial_table[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

This is because some architectures don't define either ACPI or
MODULE/MODULE_DEVICE_TABLE. So, keep acpi_platform_serial_table under
CONFIG_ACPI to fix the warning on such architectures.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407310047.PIoWlrZZ-lkp@intel.com/
Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index bdfb16bed4f2..168e635002aa 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -268,11 +268,13 @@ static int serial8250_resume(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id acpi_platform_serial_table[] = {
 	{ "RSCV0003", 0 }, // RISC-V Generic 16550A UART
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
+#endif
 
 static struct platform_driver serial8250_isa_driver = {
 	.probe		= serial8250_probe,
-- 
2.43.0


