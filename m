Return-Path: <linux-kernel+bounces-393984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C152E9BA849
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A349B212B6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341D18C015;
	Sun,  3 Nov 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIyt/Fb0"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0B18BC1C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669191; cv=none; b=VhjdBY4Bl39nX20jYGR82+eiXh2NYOV77g3DBFMaP9s7mGssQaxDB0uDYlzADBYeD4X8ztUWgHJiUEab63k2DJDPMD5mHQoLSqT527o7sBfdNaIyzvx7HcP0vY3hlEYIkYaqA/+5pbtXHxJ8yBnXh/lezHGm0hagimvE7bTK+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669191; c=relaxed/simple;
	bh=bdpo+Pfuv8VyaA8KGzos0qW/9dldwTJy6W19+kdX1P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rj1QLzFBPH4r/t0nKhnUxwTp+5HC38lkNso9wo7BHqbSDbzJNrsamQIbavuQ9OwoXsj4RPhY6QgoZKm3+cAE5lLrkIes8CQ6WL9UwRsrpkV6L4mrAdgB5wDfcDcWnamw/PBxfMKuKah8YwM2ryKsKAwaXm5ozVB3oij9Qy4fa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIyt/Fb0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so2396428f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669188; x=1731273988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAjOK4V/qUe0b0tbcpJU9G58SdnMJIladw6oPPznhpI=;
        b=kIyt/Fb0wlvuZjojsP/to3G+j3/vXEvY/HTaaeUi9QPTO5SOLBNdLlO5DPWmi0cC34
         ah4+2txsj6LzbYTgvlhcWQTp+91toLgYNDnKSBv2sYR/pr0c1fvEZ9U5NDuSVkN9pCAm
         hk+8NluuCVTN1141SOGI0dR04TLH0kxqfWIhi4PCMMi6AonO55sMl+W+l5hEJqThJQRm
         Cm+valw7HAF+JwPqK7yaCspoJgzOWhsozi2S53VAc6TPzak//VFGWbAO6r6wiLMgU81K
         Bw2L7I+YX9O21Q9po1q/qvmEWC3mJgKZDFeGq9lYeEzEwVWyDvt4zmP0KEdf3F04yOXW
         AHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669188; x=1731273988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAjOK4V/qUe0b0tbcpJU9G58SdnMJIladw6oPPznhpI=;
        b=gqWgqeFp7C5ydnF1pFjUQHmeJslYM6x4geuMYddrfSkFNhJAMc6S0S8c7w5eoMgoNT
         6rLYLiU/QW+74o3C7mz37rkPtHWBapZ+sR03N6QCVVr1SKykMO+l6WK0h1wY7quYuzPc
         37U2Hz/VCp5LeZfGQPj3+JLWaCH9QAs6y/E77E9eXdITooSBKFDX9AX2BWL1YKxE+7tf
         t75CsOovWMXzoIwn0Ui+mkBa8iuz+a043gI180nZwv+202R2URRzxKLHsZ/qkVWXtFmz
         FSD5ayCid7zWJ3wzpe8slDwazOIguWIPdo9P5e7wkHOLxvzQ3VjjI9wdZgcPIVTRk1jn
         LhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy8kfUFRPMVlQwCe5Z1SEeMVcEi6lEXXroWAsRCJl2tla/KZSb2vxvBvRbvcQX+Wxmruml9WX25HIKtnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0h/NouKB5hBS3JTGY7wmwFhxFYb04fiDE/uiAfwCAEMsc4pS
	DWa14Gi6h31YcPX568NZ7i9ZWfxM8CSFr1e0basnRw+d/fplFDPT
X-Google-Smtp-Source: AGHT+IGJF0PDNQojlT7F7yvMf7/bZNReM6S/xIsjIvLh/BNRX4JsZrc4uTCEvdgrTmkwgPJy9Z2v2g==
X-Received: by 2002:a05:6000:1566:b0:37d:48ec:547 with SMTP id ffacd0b85a97d-381be7d919amr11235642f8f.29.1730669186572;
        Sun, 03 Nov 2024 13:26:26 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:24 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v2 00/11] staging: gpib: Patch set for gpib staging drivers
Date: Sun,  3 Nov 2024 22:26:06 +0100
Message-ID: <20241103212617.13076-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a bug fix
Patches 2-6 replace custom debug with dev_dbg as well as
            using dev_xxx for pr_xxx where feasible.
Patch 7 Corrects some errors in Kconfig
Patch 8-10 are a code cleanup
Patch 11 corrects some GPIB behaviour

Changes in v2
Add staging: gpib: prefix to subject lines
-Patch 1 Use kmalloc_array, remove blanks in commit message and add Fixes tag
-Patch 3 Delete commented out code
-Patch 7 Fix Fixes tag
-Patch 8 Split into 3 patches 8,9 & 10
-Patch 9 -> 11 Clarify commit message, delete blank line and add defines
 for max primary and secondary addresses.

Dave Penkler (11):
  staging: gpib: Fix buffer overflow in ni_usb_init
  staging: gpib: Replace custom debug with dev_dbg
  staging: gpib: Update messaging and usb_device refs in ni_usb
  staging: gpib: Update messaging and usb_device refs in agilent_usb
  staging: gpib: Remove GPIB_DEBUG reference and update messaging
  staging: gpib: Use dev_xxx for messaging
  staging: gpib: Fix Kconfig
  staging: gpib: Remove unneeded lookup table
  staging: gpib: Remove GPIO14 and GPIO15 lines in lookup tables
  staging: gpib: Re-order the lookup tables
  staging: gpib: Correct check for max secondary address

 drivers/staging/gpib/Kconfig                  |  14 +-
 drivers/staging/gpib/Makefile                 |   1 -
 .../gpib/agilent_82350b/agilent_82350b.c      |  70 ++--
 .../gpib/agilent_82357a/agilent_82357a.c      | 266 +++++++-----
 drivers/staging/gpib/cb7210/cb7210.c          |   2 +-
 drivers/staging/gpib/common/gpib_os.c         | 142 +++----
 drivers/staging/gpib/common/iblib.c           |  22 +-
 drivers/staging/gpib/common/ibsys.h           |   7 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c    |   2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      |   4 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c      |  41 +-
 drivers/staging/gpib/include/gpibP.h          |   8 +-
 drivers/staging/gpib/ines/ines_gpib.c         |   2 +-
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  69 ++--
 drivers/staging/gpib/nec7210/nec7210.c        |  34 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     | 378 ++++++++++--------
 drivers/staging/gpib/tms9914/tms9914.c        |   8 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   |   7 +-
 18 files changed, 561 insertions(+), 516 deletions(-)

-- 
2.46.2


