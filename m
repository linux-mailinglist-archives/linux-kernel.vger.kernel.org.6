Return-Path: <linux-kernel+bounces-395317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14259BBC56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006011C21B99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3306E1CACCE;
	Mon,  4 Nov 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="griVJbZl"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10451C728E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742624; cv=none; b=K7zvaOE1u7BLdWFfhH3KeoKPAqQ7QUPjcPj/fdTE7SYIooG3voMIZLrKHajqungOU3AWGXKrvmiiYhjVx6098/gq3cAMFhqP4ApYiDOsD2GeY7u5z6bQuuBQaPqCgzp2qCvqJD916PueA6PhP15MIKRegJtHT5sIAMOQtkcVFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742624; c=relaxed/simple;
	bh=5mXa1ND1V3waxOlI1xXyCccMxl7SRmuhcCww4LFlQRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfFQjFZy+pvcPfqWUE0zhbOslAQeIdEp4Egxsnppgou4t6KiJhMM6P6PNDpv17YndgiUUQyVKq57F3mISHjscJojHkcjXQ0ICcdkhMDCrz593d5zL7iFQrzMSBm8v73EDCvZq8I5xz2G4rzeMZLumz7+tPbr7C4n3co1hTkY+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=griVJbZl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2629153f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742621; x=1731347421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUmBX0B8evIE4Q0UWEXCCXfctNNwNil7XTvRbb1SpDI=;
        b=griVJbZlIq0o4YGDUsMnfv+40Y0JwWDEapjRjrfoqKDswdDvLvFN01yejbH0h89lIy
         vtaiiFfBDL2hEDJmo2xbiOZ/5p4JlNgahyaB2jOuMKEMQaE6/LUZtKQIWchT/upjAc11
         +/FGrFUPV9/bwMim2q6bxrBok6CCXMvEj22byQkIUqGdLItlKIZ3lxf5aL8otafjvztj
         88m3QXM8nriqonvhxkQ70h7hNGqxDUDc6W2H8Pcx+dyoFEACIv0E6hlver3KqKbsXfyb
         xwrTJ/LHmdEldNg0hgmHCsU87isbk4tGbHqTUCpz1sz9QjnhbyUtoTM8LDOBkaKFR4lM
         RpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742621; x=1731347421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUmBX0B8evIE4Q0UWEXCCXfctNNwNil7XTvRbb1SpDI=;
        b=hObxLiDfQfCqiOtBi2Fxjh0Q02xQbD633C7n+wtDg4dlT9HDttajhw+c/pdsMO2kv6
         7E6loGqMXrQyPLDUejfvLQlbP3YiMy7xTaHumvWRAxXi6KtU0xrg6HXOrKRIQH18m8Im
         26TzZiE9ldAldBjUimUj7Hs2JTajKqJBk4thFtDgfaVH3tsYLdtEYdBie2ilgukxOC4O
         r7oc3xqXFWvs4A1Pkz/NfC7Ae/C1DQ6Q0Yw+vsbpMq2rpUfn5fW0bkYgA5bn9JnEcsFY
         uVtBl2GH8NrzZ+VN7b13lcXXYDlEbgjmvcL5rcPCcDD8ekR8DXRwOpRUA1uJUWvLwvaw
         Vqlg==
X-Forwarded-Encrypted: i=1; AJvYcCUDnYYqEGqo5q/fKFV/Sk32jQOg18Q3PIsZQAoMjTcaip2Tc5eZDfh6t6J8p6kRbbzzCnj3hvGDhQHbW0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawpHT0Mc4KQUMhOLsel4eqv1Oj2mrAuto14BQQmGu6lZB98Bb
	/12iwGYCXB6/RY1Q1h93PuZDhD3RqRjpDP93zfxZOAcD4hkNJMd9
X-Google-Smtp-Source: AGHT+IFnZNVMMDOAohnCb1dfed8YI8GbSIY3HS8oUEDhEPTqH6n4mqB+1D4kjzpaanKejXCQEdiPJA==
X-Received: by 2002:a5d:5c01:0:b0:37d:461d:b1ea with SMTP id ffacd0b85a97d-381c7ab30b1mr11347722f8f.48.1730742621060;
        Mon, 04 Nov 2024 09:50:21 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:20 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 00/12] staging: gpib: Patch set for gpib staging drivers
Date: Mon,  4 Nov 2024 18:50:01 +0100
Message-ID: <20241104175014.12317-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a bug fix
Patches 2-4 replace custom debug with dev_dbg as well as
            using dev_xxx for pr_xxx where feasible.
Patch 5 Fixes the agilent_usb module description
Patch 6 Addresses a checkpatch CHECK for mutex comment
Patch 7 Changes dev_xxx for pr_xxx in the agilent PCI driver
Patch 8 Corrects some errors in Kconfig
Patch 9-11 are code cleanups
Patch 12 corrects some GPIB behaviour

Changes in v3
Incorporate the lpvo patch 5 into patch 2
Remove commented out console messages in patch 4
Add a separate patch for module description -> Patch 5
Add a separate patch for mutex comment      -> Patch 6
Change "spelling error" to "typo" in commit message in patch 8 (was 7)
Clarfiy commit message in patch 11 (was patch 10)
Add a fixes tag to patch 12 (was 11)

Changes in v2
Add staging: gpib: prefix to subject lines
-Patch 1 Use kmalloc_array, remove blanks in commit message and add Fixes tag
-Patch 3 Delete commented out code
-Patch 7 Fix Fixes tag
-Patch 8 Split into 3 patches 8,9 & 10
-Patch 9 -> 11 Clarify commit message, delete blank line and add defines
 for max primary and secondary addresses.


Dave Penkler (12):
  staging: gpib: Fix buffer overflow in ni_usb_init
  staging: gpib: Replace custom debug with dev_dbg
  staging: gpib: Update messaging and usb_device refs in ni_usb
  staging: gpib: Update messaging and usb_device refs in agilent_usb
  staging: gpib: Fix MODULES_DESCRIPTION
  staging: gpib: Add comment for mutex define
  staging: gpib: Use dev_xxx for messaging
  staging: gpib: Fix Kconfig
  staging: gpib: Remove unneeded lookup table
  staging: gpib: Remove GPIO14 and GPIO15 lines in lookup tables
  staging: gpib: Re-order the lookup tables
  staging: gpib: Correct check for max secondary address

 drivers/staging/gpib/Kconfig                  |  14 +-
 drivers/staging/gpib/Makefile                 |   1 -
 .../gpib/agilent_82350b/agilent_82350b.c      |  70 ++--
 .../gpib/agilent_82357a/agilent_82357a.c      | 261 ++++++------
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
 18 files changed, 551 insertions(+), 521 deletions(-)

-- 
2.46.2


