Return-Path: <linux-kernel+bounces-563423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E65A64191
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F1216BE78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54935219A89;
	Mon, 17 Mar 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngW7mwQo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D47440C;
	Mon, 17 Mar 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193240; cv=none; b=PJlGpda+d78JYUTMkZooMgSYlINAkUmkpPKSA/VnFb7NVaRCWQxoJ37TxUzxI/Lt44GLtUZbxruuVcqjtpPMMzoxTWWxYyyMCuCZStTy9/tq7u37jNn7kQuD+tLaeom7BgIROj5PDccm+NN3IRCcE51kSwqM6ojH4Eag+UFiZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193240; c=relaxed/simple;
	bh=wYw1uh9zfWcBXAdw8nD2Ekouog7ewxgVXH1hcRKpKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHm1b4ugMIapWyWk8ft1h4hSs+Y6E7hHpePNlOFpObtwPzHfhQMT2K50IKz0IVskPzJfdNZ9nK74TP0VMLboOT/5q0vyOd41vD2v/52NOJ9WG+6TmK80ESI5BTTNsIRUQY83U6PhEUmbWRT2U9rtzqVzBbHRgrL+8Zl9HrO0aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngW7mwQo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223594b3c6dso77631195ad.2;
        Sun, 16 Mar 2025 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193237; x=1742798037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=di3S0+LuekJWKwlJTMRfcHb5hngKcTJb2WX7dDJf3+8=;
        b=ngW7mwQo1ts+DAB0vOEwQWeJyOikkPmtjblrEKcNplTLX34khYRzmWMwe3ltBvdM+V
         7Qzfz3BU9bYO5+EuMiPQ1IT6KrpDVBouCLKsojpTDWZs+Vld1ixSEwB97NoxLeYSiZvb
         wYpatq24jt8n7ak17vScfBMegu4WH1NyfTE667c39F/IEkop5iMD6pd9wuCZPVYGJzes
         FGY8gm+40xYjr2RL0EBBJFeGecLUb4L13uDlkcLcIUm1zLNYi001NBlOGVnjMDoLu8I8
         r3P/sT2qs0pgnZwsoRv2qQiWQQGWrKyZx/4hUedzLgP8AtiiHrPoDBSgg1ynB1YjkGgm
         lQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193237; x=1742798037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=di3S0+LuekJWKwlJTMRfcHb5hngKcTJb2WX7dDJf3+8=;
        b=N9dfxytPphT23r03sinG2lO0vpQcR2JKPVlt40+kRIInwJtBhcWY2+Bv12mb70lJaL
         6+RQ+i1AiTnJAvpeSxCISOgccD4Ml5jPB1kksl9y3or4mNpSA3KoRRv2bCDYHLxx2B0r
         qFuKkdbJINW05rJkctlw48f5vqR/HHAMfa709ztmCUBYnDs8y8zrfDlAMRg+7LvG0qAw
         iieRSOVC5jaqWCW0yByC/+ujYqqLnkK3Bxy8jzOKDM6oromO9vJuFSfmMdYVwff/Nl2n
         35ZjEtYjIj0hc5GGhsH9WuPOaTF55iwbNP4mzS/R3GxbMwoI31ZsHwXIr53nIZYocozm
         clIg==
X-Forwarded-Encrypted: i=1; AJvYcCUcWlSkp6+JLHKrbfc+3csiKFsrI1H0wBkicrfFdChtWY/6Cspt++SccbtqGMHNl1v2xtBQGiT6QmpuxeL3KeDhwvQJYg==@vger.kernel.org, AJvYcCXcuYQtBQrEcr7bnbxZhxxTp7WJHT98EUrvjt5jpkYfR5GbvoNFzgG0A1EZ70+BcJez5mvseT0ZCHI=@vger.kernel.org, AJvYcCXqGIS/Do7xpj5FSMYIc4J3AOTHY1MRRE+sxT0oJkZsT/5gclsMIaqJXIID1hSdDl47TTuvI0qbVbdvfSDN@vger.kernel.org
X-Gm-Message-State: AOJu0YywjCG2cqZx8isrDhAvA+1fAZ4fNn8nqzgTCVBz/iDcZLfoeUyN
	1id5jhkQ+8ChSb+VGv9HCqXiQVPxVkVvpzs7A/dcYSPzO2V8IuCd
X-Gm-Gg: ASbGncsRuX+3LKDV0ipmgCHJtQIpJYbAvhzn5pYPaIxTnAXAv5xOg0aFv+LZhq222/V
	VwNKbvca0zLDfvwzXIzZutaY6HsEpSxwC/xgPWRtMt7fBVMJwOVEA/H1Y0vEaS4Oj9mh7hSHFry
	XMAysJWYSZb9rnpySKbQja7NF74fwX28/xSoz/cn0bh4sVF17N2ZpeRD1UO5tj1yCV68m5c8TuW
	tRVPa+DK+kJFOhHjydbg/tOZiM7/yXDKzt1IC+tNC2/YBFT6iiMUBtxc2r6ARXesZLy80rEIJI7
	TIpNomzLCidWcIa6Oz0zMw+Ow0OowiO1ICbDrv8QOiZs5+0Pya1Loh7NEadeD/u4xp1DZWeGUzK
	sYlvwzFX60vn7ZnSL55piDatXwDyA0P6vtZY5RRTHuF4=
X-Google-Smtp-Source: AGHT+IH1X5sDD8u2//7Y+nkzwhr5lAU0ZPraEg7yAKiomLEysCfNzF3qllGrQr4Q9+ggjvpFqMOE2g==
X-Received: by 2002:a17:903:3d0c:b0:223:5241:f5ca with SMTP id d9443c01a7336-225e0a62b11mr131840735ad.20.1742193237251;
        Sun, 16 Mar 2025 23:33:57 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:33:56 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>,
	Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] platform/x86: Add Lenovo Gaming Series WMI Drivers
Date: Sun, 16 Mar 2025 23:33:27 -0700
Message-ID: <20250317063337.352966-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for the Lenovo "Gaming Series" of laptop hardware that use
WMI interfaces that control various power settings. There are multiple WMI
interfaces that work in concert to provide getting and setting values as
well as validation of input. Currently only the "Gamezone", "Other
Mode", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, but
I attempted to structure the driver so that adding the "Custom Mode",
"Lighting", and other data block interfaces would be trivial in a later
patches.

This driver is distinct from, but should be considered a replacement for
this patch:
https://lore.kernel.org/all/20241118100503.14228-1-jonmail@163.com/

This driver attempts to standardize the exposed sysfs by mirroring the
asus-armoury driver currently under review. As such, a lot of
inspiration has been drawn from that driver.
https://lore.kernel.org/platform-driver-x86/20250316230724.100165-1-luke@ljones.dev/

The drivers have been tested by me on the Lenovo Legion Go and Legion Go
S.

Suggested-by: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
--- 
v4:
 - Added lenovo-wmi-events driver
 - Added headers for every driver
 - Fixes requested from v3 review
v3:
https://lore.kernel.org/platform-driver-x86/20250225220037.16073-1-derekjohn.clark@gmail.com/
v2:
https://lore.kernel.org/platform-driver-x86/20250102004854.14874-1-derekjohn.clark@gmail.com/
v1:
https://lore.kernel.org/platform-driver-x86/20241217230645.15027-1-derekjohn.clark@gmail.com/
Derek J. Clark (6):
  platform/x86: Add lenovo-wmi-* driver Documentation
  platform/x86: Add lenovo-wmi-helpers
  platform/x86: Add Lenovo WMI Events Driver
  platform/x86: Add Lenovo Capability Data 01 WMI Driver
  platform/x86: Add Lenovo Other Mode WMI Driver
  platform/x86: Add Lenovo Gamezone WMI Driver

 .../wmi/devices/lenovo-wmi-gamezone.rst       | 203 ++++++
 .../wmi/devices/lenovo-wmi-other-method.rst   | 108 +++
 MAINTAINERS                                   |  17 +
 drivers/platform/x86/Kconfig                  |  40 ++
 drivers/platform/x86/Makefile                 |   5 +
 drivers/platform/x86/lenovo-wmi-capdata01.c   | 136 ++++
 drivers/platform/x86/lenovo-wmi-capdata01.h   |  29 +
 drivers/platform/x86/lenovo-wmi-events.c      | 132 ++++
 drivers/platform/x86/lenovo-wmi-events.h      |  21 +
 drivers/platform/x86/lenovo-wmi-gamezone.c    | 380 +++++++++++
 drivers/platform/x86/lenovo-wmi-gamezone.h    |  18 +
 drivers/platform/x86/lenovo-wmi-helpers.c     |  64 ++
 drivers/platform/x86/lenovo-wmi-helpers.h     |  24 +
 drivers/platform/x86/lenovo-wmi-other.c       | 626 ++++++++++++++++++
 drivers/platform/x86/lenovo-wmi-other.h       |  19 +
 15 files changed, 1822 insertions(+)
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-events.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-events.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-other.h

-- 
2.49.0


