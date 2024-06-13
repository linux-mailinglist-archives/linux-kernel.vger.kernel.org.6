Return-Path: <linux-kernel+bounces-214042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1840907E60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF611C2269A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ED814A62B;
	Thu, 13 Jun 2024 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3HKDcdv"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1A145A11;
	Thu, 13 Jun 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315853; cv=none; b=ZKgvSFHwbKZpUmHkM6hgN/IfQ9DLRqLWc6sA0OZs62PredSn9RNXf2n9uuoJkaWbEREBNeFje8qBUj7/T5UsdVA9cEAgWTGT4we7ORRuZEFMXiO6e3xaEtre7URJ+V8aox6h7UakBQAaPbBc9KQlPMqSIhiUhBs1oaLPHWtqXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315853; c=relaxed/simple;
	bh=3V/7338jp67od7cu+kOPTYkCysA1/BAci9WSQHsUlEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rgl7Da8/ntinni5qb6fb7S5CxZQ08J0w2eA3WDV90xZ5/csbKrnUHrbCBfNHAJP8EG625SQK+FUWfMj30aW3Y6iTYc5r3gMtFXGFkVlxiaXbtQhO4Ia4dT1xAxiheNk408rTM+6eNM2XawdsKgcAWlpKQHNpohRibi6KJgGfQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3HKDcdv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so1673009a12.2;
        Thu, 13 Jun 2024 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718315850; x=1718920650; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Srockrd4TWAIr2NvGJ4jjCz5NsXjkOxmfb8MBOetxt8=;
        b=h3HKDcdvp5sgoDWlG8+P3qTsZalDsFJ7xSCgSgx0eFbR4klehltAS+6MXEihyuyqeC
         HSkE/6Cm92treK6k4nFI85ddzG8bVpBlf1yml6dn9LrTq7MaEUg8si+UK0OzCgXkxUQB
         4qwFeV+gQRwRi78/2QXuljUlsuffh97ckmbCKN4VAYHRx4T/vRok2wChoVqoASGI++CI
         beUi5kuijqza1hzKrUQije4yvXsaZl4wyYs9F2rdAm9vhr36VRP1UmymfahTD2WAxEju
         pllhQSOKaNZ/Zuj7XmulJuAcR73ra0JQ6/AZhUltEcuZ+6kTG+qgiqLLR8XSn3SALeIL
         Igrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718315850; x=1718920650;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Srockrd4TWAIr2NvGJ4jjCz5NsXjkOxmfb8MBOetxt8=;
        b=mXdfIO+LMXmIl364dEN3Vluk5IGosOG7GiLLx3MpK7G0N3kR3OYrxPs+82uK+Fldg3
         UytiE8xizeI0lTwSg22ltcui8KWUMDLN4Xy1e6iqdmEP3Tp/U29WW37K5FQQogllsuBH
         TOpX1MMHl9d4M+OdxCm9geIfirCupMPk9at8ehOEQsYSQTBbjkDfQ6/66qeSjfRNiZVH
         TQlyiijtVKznKDjAS6tsqh2xrdMYanbQobKdQf64eqx/fiZHz9LBhSQ3Gq6PYfMBTCx1
         4fencZYkR+nJIz5pCSNURpjvL+8YNxpE8zlBeybcQhz7gxoIiq84KtM3ygSMFb2VHkcJ
         z6vA==
X-Forwarded-Encrypted: i=1; AJvYcCXRheQ5VMx1/qNyVmK5pbmqnL5t5mB2tEIoL2zQUo/ehKgK1zfEpzIK14+VZOlr3EaQiZ8+bkGATR/t6tQyZ9D7g2pyXA+Dr12DhMr9
X-Gm-Message-State: AOJu0Ywt+/8qFZH3iPFxalIxp3qWcEVsL6rPJLT9UdpxPp9vM4bKDGES
	LU2wKdUAxHXBc5jvFyc6QhGmwyr6V4DLninvpeeVeJUu6EnVkOlb
X-Google-Smtp-Source: AGHT+IHn01AdUmN6xxiNDM0C/T273A07MvSQ7Sl6A8jAy9uIOMLs9C09dMtNjHL6xPZ4k0t8S/nujQ==
X-Received: by 2002:a17:907:9689:b0:a68:fcc9:6c1c with SMTP id a640c23a62f3a-a6f60bdc4d3mr86099466b.0.1718315849519;
        Thu, 13 Jun 2024 14:57:29 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f416dfsm112391666b.164.2024.06.13.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:57:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 13 Jun 2024 23:57:25 +0200
Subject: [PATCH] hwmon: (pmbus/mp9941) Add missing bitfield header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-mp9941_bitfield_h-v1-1-681afa8aa498@gmail.com>
X-B4-Tracking: v=1; b=H4sIAERra2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nj3dwCS0sTw/ikzJK0zNSclPgMXVPL5OREC+PEVCNjYyWgvoKi1LT
 MCrCZ0bG1tQB+xX3IYwAAAA==
To: Noah Wang <noahwang.wang@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718315848; l=1389;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3V/7338jp67od7cu+kOPTYkCysA1/BAci9WSQHsUlEk=;
 b=r5ZC/uW7Wh1ZE6r0sgrh6jGJutNNmQuY0fUkhsODtov8buhDr9ZHbh/bI4ZJ3bfw/NHhBkouW
 8C+msojM9ctASfUBCi4KL4dZZdw9vzE0DL9sScPCXEsR99a+p1Mdqms
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The recently added driver for the MP99441 is missing the bitfield
header. Without it, gcc fails to find FIELD_PREP and FIELD_GET.

Add the missing <linux/bitfield.h>

Reported-by: kernel test robot <lkp@intel.com>
Fixes: c16fa6967781 ("hwmon: add MP9941 driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This patch fixes the errors reported by the kernel test robot about
the MP9941 in the hwmon subsystem. It does not close the error report
from the BUILD REGRESSION 6906a84c482f098d31486df8dc98cead21cce2d0,
that includes, among others, this issue. The report attached to the
mentioned build regression actually covers a different bug.
Hence why no Closes: tag was added.
---
 drivers/hwmon/pmbus/mp9941.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/mp9941.c b/drivers/hwmon/pmbus/mp9941.c
index b7b0eda5b552..475221b738f5 100644
--- a/drivers/hwmon/pmbus/mp9941.c
+++ b/drivers/hwmon/pmbus/mp9941.c
@@ -3,6 +3,7 @@
  * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP9941)
  */
 
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_device.h>

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240613-mp9941_bitfield_h-59cca83ae233

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


