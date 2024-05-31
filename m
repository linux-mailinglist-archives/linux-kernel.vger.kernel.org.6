Return-Path: <linux-kernel+bounces-197445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E08D6AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E829C1F25B94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8C21779BD;
	Fri, 31 May 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU/OVnt4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35080219FD;
	Fri, 31 May 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187632; cv=none; b=tg+vn2yWyeuq/1E2s785QMY39zJI83NtAD16lToZfZ8M2mzQSZLl1PVEzOF/aymWaYcR5OPktpDrojzFWjvMolhE79LdsSNjpNg3jNqO6BCbhT2J/VchPL9McWfG6LMlIc2h7hPCzBBE44ALNChPQBES6/mOgmx7hn+FEltXPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187632; c=relaxed/simple;
	bh=165fXhoSFy7gnvxl7/fNUY60TTAeItlwLCL3gFs6htk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a7jnw91B3efgWGTyFBvoRRfVfRgOlB9CfywRblZImfGEvZUdP/2KvTiH4xFxwMUYxAFGM9snyzP90zO7QDXtMjauFEoIQ+TUGQN5kfAhMW/Yu9/NKuMucQxXu2VS25+a3JzGgyVN46T8+1LFd9kQIwWZfd0oIwRevFumPM22TH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU/OVnt4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f47f07acd3so22261385ad.0;
        Fri, 31 May 2024 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717187630; x=1717792430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9AQ2FmyRQaYL0b07166i1h8j3ECpFVUwMiyq+R27jwY=;
        b=XU/OVnt4/IAQPtvKIp09r3LZQFjDCuuFzMFF7990Gxn/kx/8RLsiDPHJN8Ph0vDrFm
         gqYRpLx28QWpPRtnxyRa29LZVB4qlYD9n7vvHcXmMz706OTfAmnodZe06rV3yk1iZA8s
         bFm+DOhtSXU6WLNQRwSqhWX8IVB6P2FWuKe/frHTQvdCGxf0+cxMWj3CUdVbwvoLFGz3
         Od9b61H03AsPl5oc6phAuOSSeR0nmHGGqS1On5+zPI/VXEhi4z/p25CA7tDvF/n3St5y
         5PTTx5+M71DGQL0kCzjfMS19uIoiCOSh4pEclpoPTus7OvursHPo/Sr4w65gbTkWyK/C
         xmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187630; x=1717792430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AQ2FmyRQaYL0b07166i1h8j3ECpFVUwMiyq+R27jwY=;
        b=BlQ+5KRGfIJNNZfrqdxV9X9tJusfgBKX+B69SI+ghrhGD5IJnDlhoyk+T4EO8AHlLX
         u5pgl90CMGpkUynzvMU9y3PqgCqre8PtVKX5wEFKc6sweJbpzMf8l7+jWzWplvUkFh1m
         8Jb90GFjoY4xXEd+XElGqNaVY/xIC9CWL7KOxBedDYWqmqCNt8WRH386n1N1MilQiYhr
         fEpB/LGhB2KISrT0iaYk9Ij7+xfx+pxoBFrdXEac8NfAYm1nM9kcJHFX+66CJ3dLcROW
         zkQVSne92lEPEiviRazCoGcEcjdYf3NMQcDxjXMwI7QevbRxWY0QThwJnZnoOIezTJQG
         HT4Q==
X-Gm-Message-State: AOJu0YyZ5OkLtPbxei1VFpixg9o86i12Stz/iU0j+GNhb1obc3kXRsgC
	WkpLvvfOByeg/RJsTqhJj1ka7tned06nIJf0c4aJBIK1NI6Cvi3RcGnLUw==
X-Google-Smtp-Source: AGHT+IFIRN9VmRiNY9hdjCUOtQa7ygrE3U1K7TR2cmnyerWFyLEyRJkN952fhA3R7fTdIgZBz4sSiQ==
X-Received: by 2002:a17:902:da92:b0:1f4:7ee3:704c with SMTP id d9443c01a7336-1f637019284mr34658175ad.24.1717187629888;
        Fri, 31 May 2024 13:33:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232ddddsm21052285ad.15.2024.05.31.13.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:33:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/2] hwmon: Add PEC attribute support to hardware monitoring core
Date: Fri, 31 May 2024 13:33:44 -0700
Message-Id: <20240531203346.1396055-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several hardware monitoring chips optionally support Packet Error Checking
(PEC). For some chips, PEC support can be enabled simply by setting
I2C_CLIENT_PEC in the i2c client data structure. Others require chip
specific code to enable or disable PEC support.

Introduce hwmon_chip_pec and HWMON_C_PEC to simplify adding configurable
PEC support for hardware monitoring drivers. A driver can set HWMON_C_PEC
in its chip information data to indicate PEC support. If a chip requires
chip specific code to enable or disable PEC support, the driver only needs
to implement support for the hwmon_chip_pec attribute to its write
function.

The code calls i2c_check_functionality() to check if PEC is supported
by the I2C/SMBus controller. This function is only available if CONFIG_I2C
is enabled. For this reason, the added code needs to depend on CONFIG_I2C.

Packet Error Checking is only supported for SMBus devices. HWMON_C_PEC
must therefore only be set by a driver if the parent device is an I2C
device. Attempts to set HWMON_C_PEC on any other device type is not
supported and rejected.

The first patch of the series introduces PEC support to the harwdare
monitoring core. The second patch converts to lm90 driver to use the
new infrastructure.

Tested with ADM7421A using lm90 driver and Devantech USB-ISS.

v2: Use sysfs_emit()
    Return -EINVAL if the parent device is not an i2c client device
    Added code needs to be enclosed in "#ifdef(CONFIG_I2C)"
    Added Nuno's Acked-by: tag.

----------------------------------------------------------------
Guenter Roeck (2):
      hwmon: Add PEC attribute support to hardware monitoring core
      hwmon: (lm90) Convert to use PEC support from hwmon core

 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/hwmon.c | 147 ++++++++++++++++++++++++++++++++++++++++++++------
 drivers/hwmon/lm90.c  |  56 +------------------
 include/linux/hwmon.h |   2 +
 4 files changed, 136 insertions(+), 70 deletions(-)

