Return-Path: <linux-kernel+bounces-450048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F39F5A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDDF16D399
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55C61F9F77;
	Tue, 17 Dec 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f24lHLjk"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2E1F869B;
	Tue, 17 Dec 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476813; cv=none; b=sNJeufZaKKvZLfBel9gG/FefNCSbZh6T/R7eqkmMOekFI7Tq7gpQZ+4iCidOw6I4SphvZ0hmIumsuv+Qag8sP/vI+emYTrnK6nTYlfSqWuKxau4Zm1mweGuBofHMnJKilBapx6ayBzmJge4Af6jSj4UYroylOviXCFxTx8TAr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476813; c=relaxed/simple;
	bh=+cUdF4VZjQdMulNbD5JiXungrYErRr8AvXdUYS54UQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1cTxH0z/hJ9fN9djMJBVu6NqPp4Fh5gflQtjn3qiyc/Kqhypq1+gf5P8QE/5s+AMus5gHYeY/L3I78qGulitL6H37m639omeCK9PJTwfIUJRhCEATNpCHvmjm7Ra262Fkl+OlFB3KrmeBs+PCpO1b0ymrn3SUNr5A8lpJceGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f24lHLjk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166f1e589cso61042305ad.3;
        Tue, 17 Dec 2024 15:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734476811; x=1735081611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLHrYooVAsN5numrmbqy6VBSKz/Pcqg/+vPoU0gAXTY=;
        b=f24lHLjkt3fP+pwkW3m2smTKcbb/Xsc6UduQU2PZArtkipnq0Sy9M8fE0YBkaJ9s4B
         9jIWf6BpMQnNt9ANLFnYTiumi6ju0PUGoS+yR1OR4arCwfAH6Zz7bbOu7PuJBHgbcyEC
         polv+sSRwgh5CEcZytMvM+1Hnn8Et9UD0w5KjjeS8RQphgSgFJY76Q5QKt1c6aF+KFm6
         pdS8Fb75Lffv+aiRNjmjrbxxqo3QqTcFJKBG5wb6vfqsNRgv7FHsAGB7DlD+k5y6l+eu
         a28kJcNzAAd7abxLPIfpyinCS9Hv43z7/yQBXskWbkmAzxBSjO226mEPfSFWQKkZeBG1
         yirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476811; x=1735081611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLHrYooVAsN5numrmbqy6VBSKz/Pcqg/+vPoU0gAXTY=;
        b=CmEDf0ZdVojcEtHCNch9yD48R+vIHq+k8agzKowf/NuSmbc4gG5AMqG8ZUxo8Vehne
         mbWvtD3N/TGUDB5eWSC29OeUWRd7ZnDJL0VqgQCVXFP5E7qna3VJLabwb58B5LKd3dWn
         O1Y+JnPUFc3a6jvGNZHIXevqW3uAvuvVRKAQBn8pfqbCR0pkBTcMMFRJlgjjSqitUwja
         qX+vFLiVIX9lKth5LCHZziNHdTVcCWa301f8BvC9G07eVcnzs7bCaTpRxBFH5pwTLcyt
         x4FdNWG7232xmf/yiYKTYMOynCn60NK3vjcMNgBVz4LSVIbihJvfh/QuX7EOOSyCHUON
         5PIA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0EzEZT0+Q5yYkvCok/MLMn2oho2mukrVOY0jgrUQ/W0yWVLmg2kEed0vc+/q5OVMFHG7WtSmuVYbAz1Z@vger.kernel.org, AJvYcCVVcFathApeLlqUub4+3BHqhs12SKiMFQ9MxIS0z19M1mFFd6XO/QBQNXV6OqROaStoP3VgkzvRFYzCaPxI0Pk+/FWb4g==@vger.kernel.org, AJvYcCViHiaAt/uJVDpho7skAVC81rK4oC9lMWh/ZIzgpkEV8B3pYlg3wyKS53mBjy9Hme4P7LSd6we91Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VFsmLbhWBbeePfR1Ih2l0fW0OWaGzQiA6MasV2b4NOMcChiJ
	oNt4BXK/d6uRZQa+Ib3dhlwu+HFIuv5+3LlDw1y+y76IoVEkHMse
X-Gm-Gg: ASbGncuJCk2sumdDwwG1O1rV7f/9vALAfnxEKzfIQS3liJM14OXPMX69xF50l2Se+C9
	rD7w0QrzudjCjV4nzGv6O2ZqfINxwAw/I6eDdKFcBNCvGd5LFimSd0EwVQJseeXHw0fwtKaDgXc
	fSFTyCKWk1GcGfXHqvit7FwMPOatc11wGuQ0KO4HyfdpSFxJ5m7PWBY/cqBkOGMe/PPAV4o/11X
	iVt1iP89A2Sn6p4WAjpiAW/X6IB1Z2TnOLjcg93KKnA5AbeCTtnV5Wwn8HyBYz0tK5Ex2anDkYp
	ZLQ5VqVYSm33j7TTV4n+FKCK2mHewU3LcQJLMiBwjMYsozLNJhSNd58=
X-Google-Smtp-Source: AGHT+IGQhQ8MCrpvqthZB4yeso+hSopb/9FK4blCtwu6dsUxI3TUsJSYDD9JS2Lxo+vc4ubgSHO1Nw==
X-Received: by 2002:a17:903:41cf:b0:215:63a0:b58c with SMTP id d9443c01a7336-218d725f629mr6737215ad.46.1734476810881;
        Tue, 17 Dec 2024 15:06:50 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db58cdsm64536765ad.38.2024.12.17.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:06:50 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>,
	Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] platform/x86: Add Lenovo Legion WMI Drivers
Date: Tue, 17 Dec 2024 15:06:44 -0800
Message-ID: <20241217230645.15027-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for the Lenovo Legion series of laptop hardware to use WMI
interfaces that control various power settings. There are multiple WMI
interfaces that work in concert to provide getting and setting values as
well as validation of input. Currently only the "GameZone", "Other
Method", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, but
I attempted to structure the driver so that adding the "Custom Mode",
"Lighting", and the other CAPABILITY_DATA interfaces would be trivial if
desired in a later patch.

This driver is distinct from, but should be considered a replacement for
this patch:
https://lore.kernel.org/all/20241118100503.14228-1-jonmail@163.com/

This driver attempts to standardize the exposed sysfs by mirroring the
asus-armoury driver currently under review. As such, a lot of
inspiration has been drawn from that driver.
https://lore.kernel.org/all/20240930000046.51388-1-luke@ljones.dev/

The driver has been tested by me on the Lenovo Legion Go.

Suggested-by: Mario Limonciello <superm1@kernel.org>
Reviewed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (1):
  Add lenovo-legion-wmi drivers

 .../wmi/devices/lenovo-legion-wmi.rst         |  79 ++++
 MAINTAINERS                                   |   9 +
 drivers/platform/x86/Kconfig                  |  35 ++
 drivers/platform/x86/Makefile                 |  21 +-
 .../x86/lenovo-legion-wmi-capdata01.c         | 103 +++++
 .../platform/x86/lenovo-legion-wmi-gamezone.c | 233 +++++++++++
 .../platform/x86/lenovo-legion-wmi-other.c    | 377 ++++++++++++++++++
 drivers/platform/x86/lenovo-legion-wmi.h      | 271 +++++++++++++
 8 files changed, 1119 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/wmi/devices/lenovo-legion-wmi.rst
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi-other.c
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi.h

-- 
2.47.0


