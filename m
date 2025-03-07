Return-Path: <linux-kernel+bounces-551326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31279A56B24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6223B5C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58921D3DA;
	Fri,  7 Mar 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo8sgSCh"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684621D3C2;
	Fri,  7 Mar 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359831; cv=none; b=QuImsDmOaJua/tyRk4eTtwzrfxOsSJel/45c804t0ocZkenHdOrUXtmaoGNEazfEaZOU26bzf2xjQwZq2eno2Qz7i78ZxL4oRT8gpdPYRWcegcCGPm94w5B4wBkDETLVVHTc3egjFguKU+eJPhVg0MEFM6s7yzdQTp4Ixj9z4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359831; c=relaxed/simple;
	bh=JWnX24bQXGvbdkcSpP8hZ14PW+ptSaxnMNvypsvsyfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0JmEXwuATGAfJwORNXm+FU4No5AZp2RkzamrlMzttFEj+fwT1zGKqp7iSyo+UHPITgNY8ETBoVgiVyujuqTQAKKO684kUO7Df8IHylbtW87JWQw4BCmKwT9gDlywgbQi2iuWTU1ODQYWfgpUzKI0y0++MikPAE97gK4q9F5r6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo8sgSCh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234e4b079cso35130535ad.1;
        Fri, 07 Mar 2025 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741359829; x=1741964629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mjltdXPvzAGYWJCjNCh7/tJsigIQN9ooLcu9BagrtF8=;
        b=Qo8sgSCh/Ri2cEcjiIZpfYyfbrMm7vQdoVHOkK5NbUWoimAq28ItOBS8iZ/XfjzFut
         JGF2fs1TWe3jx9B4GsXtygrv93yTkzYrbUVsHKeoAqJTGL6AjlePqM7j5R4fZKTFgQwQ
         AHQGqpA3hOBO8x9DftsjzHoOobti0brx5mxPTr0li9l0VoXqh/GdHGazlCwaiPbRaxaq
         fLxSk85zV8o8THkS6O8LQR3SN53rVHLIe0qmEe1C0NmUNumrOFD51gXzfaSdm726tR5N
         h+UIjlhdJh167vJb4W/Gk2e1TcWmVtRSkb51xZCFhiVY5CBTlStXJAof2kNF2py4FjO4
         abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741359829; x=1741964629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjltdXPvzAGYWJCjNCh7/tJsigIQN9ooLcu9BagrtF8=;
        b=eoWmFfwuwzx0X+GT/AwadM4ujcguQkOIM8jfzfZwp/9b8+fPEsU2Qep/znQtYesyBU
         FzqHKlqoOcnbV9B20khXZvtKey6ygjZZsp1z4VTlm5NbyUI5HJoA/ZJ/VstZ9yyDOIZ3
         VV20Xgb6lsRpjvdzNESmKHUrtxvLZ7Sz7bx0m0yt9CQPpghXsE90WMOr8SHrYWTfUImk
         lwLGYt7RMFSfvBVjeCoksFY5P21Q4hrskyRRV+dQKcTeCEdJpPVM60ueG/qgVBIlacEx
         h+/eKzMjKQXr0C/tkrqKecpd+4Cap9ZPxL8cm8R0YG4r4CK2CqdR1JlYwIv/X0dxPeLi
         /Ojw==
X-Forwarded-Encrypted: i=1; AJvYcCXX/fi/pVeauI3sHN2B+vIRq13aM+FSYmDWCVI1C9xARoveJQOHLiPOZTCDggcqORLloE10kVGNmXaHk+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmNV8HIhYfSwbTnrMG01v394CgyALjasOB5J6WR7+d/OuJffn
	hbDm1QUQruiSno6QRnVVgdZ1NSzJI/UZZKM475mh2H/HJcoTV2NhpLMfbg==
X-Gm-Gg: ASbGncs9fkHiHQXlH6GBiSvKwfi1LQwukTjdtTrHj2TmYCYtZzTILKiFFdtZh0k3E6F
	r2ioGx4bbYGWep6NQx66lxBvUjQIBGksxLhbrjfBdLZVMSebseic5gNj2rrd5c+/4v1qv+lxS/z
	2xgPKhgy3tt/45/6QpfUWAfAr233lDiUFo2DU9/kdN6leO+cX4DEbm5THloX+1I/ByuyAdA0J8W
	S1vbWyH4dA6EkdIvOsQhoymia5Gae20rvIVHbcVjwJLg1hDe3ObX3KagS8px60qHO89VC4JXZLC
	gb3IeFXYt5ogWYtSj+5cBEsKMtFI5nQRouOS9wXftYo9cpx4ftoY/oQiyg==
X-Google-Smtp-Source: AGHT+IEWDM76vDq+sGetR3TYHlWMMUUHGBnS2ETD1Absx3BChqLC/jgHSoWtZYIjx/0SwmgYZ74fSA==
X-Received: by 2002:a17:902:ecc1:b0:224:1e77:1a8b with SMTP id d9443c01a7336-22428c0d609mr50555265ad.51.1741359828739;
        Fri, 07 Mar 2025 07:03:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7fad8sm30961195ad.119.2025.03.07.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:03:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.14-rc6
Date: Fri,  7 Mar 2025 07:03:47 -0800
Message-ID: <20250307150347.3784204-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.14-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.14-rc6

Thanks,
Guenter
------

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.14-rc6

for you to fetch changes up to 10fce7ebe888fa8c97eee7e317a47e7603e5e78d:

  hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe() (2025-03-03 06:04:34 -0800)

----------------------------------------------------------------
hwmon fixes for v6.14-rc6

- xgene-hwmon: Fix a NULL vs IS_ERR_OR_NULL() check

- ad7314: Return error if leading zero bits are non-zero

- ntc_thermistor: Update/fix the ncpXXxh103 sensor table

- pmbus: Initialise page count in pmbus_identify()

- peci/dimmtemp: Di not provide fake threshold data

----------------------------------------------------------------
Erik Schumacher (1):
      hwmon: (ad7314) Validate leading zero bits and return error

Maud Spierings (1):
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

Paul Fertser (1):
      hwmon: (peci/dimmtemp) Do not provide fake thresholds data

Titus Rwantare (1):
      hwmon: (pmbus) Initialise page count in pmbus_identify()

Xinghuo Chen (1):
      hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()

 drivers/hwmon/ad7314.c         | 10 +++++++
 drivers/hwmon/ntc_thermistor.c | 66 +++++++++++++++++++++---------------------
 drivers/hwmon/peci/dimmtemp.c  | 10 +++----
 drivers/hwmon/pmbus/pmbus.c    |  2 ++
 drivers/hwmon/xgene-hwmon.c    |  2 +-
 5 files changed, 50 insertions(+), 40 deletions(-)

