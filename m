Return-Path: <linux-kernel+bounces-197578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9078D6CAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832F01C25690
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1C82D93;
	Fri, 31 May 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjupkh34"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5A78C7E;
	Fri, 31 May 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196763; cv=none; b=oQa35uIwYGoPqXeDai9/ZB8EOdqKJcNRzEl/WR9w9UohhvETUpSU0V6HGIT7pWjBhNN/8bGM8z4Kp7AuHhhnL2KgvOql9mIkDNPGTlFHSgmcdEx61LqyJr7HEE+xYVroaXPJey0XXmbfKioxJ3aBbC8FPHCCqwukEBobRKTynXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196763; c=relaxed/simple;
	bh=TIsWJeh3m70aYzbKOi9bIfNfJaoI5bc853i5lFFqwgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tBsyuBqNsDSGEeFJN5eNTQggC6ib4eJM1QVPWynkw8APJ8SHfHVPm/9MCEZHY4Y2ZwwxVpe9cvVbJHKLn8mbyT5Ok2GBUHGbCjhcIgVUNMS+0aaqkIgwsmBprCAOw+6faU/xqCu5GI/Uy4h9aSIwcwJSwmyPwW0J7OknNJy7sig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjupkh34; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7022e0cd0aeso2409997b3a.0;
        Fri, 31 May 2024 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717196761; x=1717801561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8ETGRPieCBeHLtuMZ+PmgV5BFojr+dada8jfzEK/Fis=;
        b=Wjupkh34jDcJgnquqFZx1n8ciecM6t+sp15MgGVU6QHGguZ1eaOJRiy/MMSK1T4RCi
         rpNbMYi5J5ko1J67+JHzdWhAwudnpsVM9Odde6oUyoi7YNC+XBWoiKPxi8AqxyiTMh2M
         WhRN0qj4VLxzhVFKesy/JvQMo/uwNppEfBMV47fTgkB1qHcd+Vmgqwq3D1gXULVfb8c5
         UhGsZdR/1kWGpbN3biR2dGRLzEkjwgatg9LBvUdoxXN7Huz7CTmW+MrKNVOSQNSYo9x5
         wwL2AFmDumdOtEt27REaUDJ6Qq5NPnlFOGv+NkjYkRY6CG4NLNGoS9CPM6VXjuaas/xl
         4ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717196761; x=1717801561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ETGRPieCBeHLtuMZ+PmgV5BFojr+dada8jfzEK/Fis=;
        b=fTka1YsBQ6t+c6MEdlbSRrvZ7z8pXftmDnCdnJw/yIc/HRurNMl0Tr2oMAWVRYVh1m
         LMTWIbD3jSXzRkIeT0YQsHNkWrm80npUPqiiklNWk23mAzEHmR937fed0wp1OxEnGG1h
         vwM5KCpJCBsinuT7HX3/bGgp5IPSCAWLQmI1FdXxLNyYDad9c6I62Xuyuq6dyxGm3ARv
         lhvyQ13XjoMzCRkuhrdPAuqeBOWpV57bnG97awNRgODxH6Z4/LNeoIDcF9O37Y1GO42s
         0Kk3V4+9ucc0GsuZ+Sy7pKoXopvBDma9mPsNP96+dso7fQXvMe2uwqGe0nEneNutUtEG
         LIqg==
X-Forwarded-Encrypted: i=1; AJvYcCWXAtlCqsQIjUO1PW1jcrF0dHseJC5RtzBJEEhwhxVXaJi7vpM2kmzv/C7JYzvHH1wt0pe2IkR9+aVH6MnC2Xa6DUbsNjP29fIhxeAc
X-Gm-Message-State: AOJu0Yz/XRlbLy/wPt7ikBwwT9a/J7Sp8zHri8dybDqYHO5hbxc5PhkP
	anuhhSdsIwAbHwQL6n2D1VspGfCyGBzbxOjfCA6VRz0gZ/foV6TofeiTlw==
X-Google-Smtp-Source: AGHT+IEbNQ0b8BcYApQnkYWaK0+QPLcDVmIhyD6XK1KZFhRywwet9FgVe5lziRuJ6+SHI0WQRWao9g==
X-Received: by 2002:a05:6a21:33a3:b0:1b1:f321:47ff with SMTP id adf61e73a8af0-1b26f1ba296mr4245968637.17.1717196760928;
        Fri, 31 May 2024 16:06:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27ad126sm1989269a91.1.2024.05.31.16.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:06:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 0/4] hwmon: Add support for SPD5118 compliant chips
Date: Fri, 31 May 2024 16:05:52 -0700
Message-Id: <20240531230556.1409532-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for SPD5118 (Jedec JESD300) compliant chips supporting
a temperature sensor and SPD NVRAM. Such devices are typically found on
DDR5 memory modules.

The first patch of the series adds SPD5118 devicetree bindings. The second
patch adds support for SPD5118 temperature sensors. The third patch adds
support for suspend/resume. The last patch adds support for reading the SPD
NVRAM.

Note: The driver introduced with this patch series does not currently
support accessing SPD5118 compliant chips in I3C mode.

v3: Drop explicit bindings document; add binding to trivial devices instead
    Add support for reading SPD NVRAM

v2: Drop PEC support; it only applies to I3C mode.
    Update documentation
    Add suspend/resume support 

----------------------------------------------------------------
Guenter Roeck (4):
      dt-bindings: trivial-devices: Add jedec,spd5118
      hwmon: Add support for SPD5118 compliant temperature sensors
      hwmon: (spd5118) Add suspend/resume support
      hwmon: (spd5118) Add support for reading SPD data

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/spd5118.rst                    |  56 ++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/spd5118.c                            | 648 +++++++++++++++++++++
 6 files changed, 720 insertions(+)
 create mode 100644 Documentation/hwmon/spd5118.rst
 create mode 100644 drivers/hwmon/spd5118.c

