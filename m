Return-Path: <linux-kernel+bounces-532572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8EA44F64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB681885DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA120E31E;
	Tue, 25 Feb 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWIO8p1R"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445518DB04;
	Tue, 25 Feb 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520849; cv=none; b=UfEmZwYYbwL7YFE8W5DXjYX/E1ExSqIvGw+hFikdDcGLzJuZC9Br7vGOJJQZSMOGCxL7pxq+oH+ZHaoy3Vzl4NEQ3X5CmmnP0RYi9x64x3Vbwz8as8YNy5Oj7fkMba91vblE5ivhZXstiS0HY4tn5lJnIULmXwI8KF0WHV843bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520849; c=relaxed/simple;
	bh=RNm65QYAVgpRA3ro29fG8ikUByn3M+cakGh4NEAcs4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdVGStEyuo0Z3NEpDO475Cj5SQf71YNPFIx1hXVwx9ZqFs9y4IWV1DBui2hum27n3XWpwQGVV3GeUrxNoE02HK3Hf8tesFab300mbgZVXy2wKJ/iajx7MTe3lD+/F/SivgCR3Nl8u4saN4jLVkhjaLn4/CVa8IvQXpdpsf8HTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWIO8p1R; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220ca204d04so102424125ad.0;
        Tue, 25 Feb 2025 14:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520847; x=1741125647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkgmoiPvcQgjbdtHJ8zqyvbS8YBHxv17CNJXQL+7xas=;
        b=KWIO8p1RxoKC9AvGbttcWDjhHCzPQ2AVdtP1HdROHYpjPRkS7jnGaThUXXRfEZW664
         r4XQXYB1Zzn4/9fP6c4h0apP6yTJWr3odFTEKYDM19K1qsHoU7PVfW/MlpF7fRyg8T7c
         bChtHyhhI3pOOjOWhO4sOGybRLZgJUacL6rFmLjmU9NozFQYEkCTLZrYZuOAr8c8xm7L
         piH/hCPIi14ACXtVSbB/VQEjK/Pc2U+x7iCoOICrEgr404G8R9pl06TfhLmoZ18oOxVB
         KoVLw+akRad2dhjfkLxFcE3y5WpGk/R0X9HeisLXar1Z4z/XWzdejfuRjXkD/pE5e9WK
         QG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520847; x=1741125647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkgmoiPvcQgjbdtHJ8zqyvbS8YBHxv17CNJXQL+7xas=;
        b=AIRKAn4+ZN7dJtszlNLtLeBzcu+Kef3S93Gw+1GmwGKZuli4c+jDpXdEYXLyXAO836
         AvaQMq4eVoEAoZCLvItDLDq0yAvSqP2bxHA4s7dwQFO909GM2h/+pmuZ2bG/uJFOV/nf
         XiIpSKnIKz3iw6X79lnAb6dGJ3vc94wmhqBNvnOEG9xIk0x7KoWvL5yuhw1oJaiQsYvF
         0dxbGiG9RCPLiItRlML5EcDqI5RyKfHKUMRLxTIRL6GkPNUgmjEqVLjPBuPi2jjsGjsh
         q+vFlO4EZ3JOZkyUwtRAxxaTZTalPv13boMKLBnvy89cSCfWJ+PojDyTM7KYBnvSBvU8
         AxUw==
X-Forwarded-Encrypted: i=1; AJvYcCUTLnfHp6zEApMcEgX/jKnd9Wf5ktUJPTQhml8T/tgD9Mu3C8wdauyy7QTGLgLWra0765APEHyVmSUTy54u@vger.kernel.org, AJvYcCVFMYa+1d/n1+MHvZ7Z1OEX8/6zk91C2SUJwtySwViZH48yFT12N0D7eAdNPabSXSEqNuCHEQ1rhjfXsPbf+Mq9coSPVQ==@vger.kernel.org, AJvYcCXpM80NaqicqOhNbpS23lzt5tol2m6EW7YCFML6KuYlHzg2iZ6NV+MCyyJZbeoD6dRMTTE4xNDVz/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pCYOHquRfKIi9eDK33ZjkrHquELj++U6x7X/nB5M7FhSFcjE
	y2lP2vmHOOat3D471kVLV4lUU/iBRjVNi3n1YJexJaoWA75kRtGL
X-Gm-Gg: ASbGncteNKU6BXNNyP/kH8rJfOuH9+bNUTgarMKoWMp0w4rCBlW9SmeoVjl8QqUrJX0
	dt3iwQMYXSr6Pf12GzG8ufwDqXP8bCd6pMRDnQ0cgQnJXitizdFGrUvgS2AJ/S+eNxqgU3dLe8o
	4oy5CNQ7C/BA5s1NhkpTWpwXseow1RwoIMTxhUifn1m2dO98KoEQhJu4WkU5k3Zw8+4sJ/UsVWD
	0lnZ+81zPxc6ix8YbH4JSLGK3UA5e+k06LGyqr1q6U7bPqah3Lcy5ZPxevTn8Aj/SXuCTdxB5Po
	ZFzNIqVjkRvERPB+sKHJSlJ7gy+/Z4Bd8BjyqW8JaE1DZejlUu6Gz+UdCYn17O4BoTx6mKQKNQR
	P3RBtkRl1mBIY4rnWueIwlBOGW+N41ansE61Eo9O9r1Q=
X-Google-Smtp-Source: AGHT+IHSoH5gEHhmrQME0JdH9Y25pdCOtj/IncPehWT7c2sPue0/sW23QAmFGwFjJFvspX0JL0qXew==
X-Received: by 2002:a05:6a00:1808:b0:730:f1b7:9bc4 with SMTP id d2e1a72fcca58-7348bda7ee6mr1404731b3a.4.1740520846936;
        Tue, 25 Feb 2025 14:00:46 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f912fsm2114122b3a.61.2025.02.25.14.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:00:45 -0800 (PST)
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
Subject: [PATCH v3 0/4] platform/x86: Add Lenovo Gaming Series WMI Drivers
Date: Tue, 25 Feb 2025 13:59:51 -0800
Message-ID: <20250225220037.16073-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.48.1
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
https://lore.kernel.org/all/20240930000046.51388-1-luke@ljones.dev/

The drivers have been tested by me on the Lenovo Legion Go and Legion Go
S.

v3:
- Added notifier chain to Gamezone and Other Mode drivers.
- Added component framework to lenovo-wmi-other driver with
  lenovo-wmi-capdata01 acting as a component.
- Completed all suggestions from v2.
- Checkpatch produces CHECK complaints about the Other Mode macros
  reusing some variable names. This don't appear to create the condition
  it highlights in my testing.

v2:
https://lore.kernel.org/platform-driver-x86/20250102004854.14874-1-derekjohn.clark@gmail.com/t/#m9682cee65783ff3a9e927f2ad1f55c4cbfc37615
v1:
https://lore.kernel.org/platform-driver-x86/CAFqHKTna+kJpHLo5s4Fm1TmHcSSqSTr96JHDm0DJ0dxsZMkixA@mail.gmail.com/T/#t

Suggested-by: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
Derek J. Clark (4):
  platform/x86: Add lenovo-wmi drivers Documentation
  platform/x86: Add Lenovo Gamezone WMI Driver
  platform/x86: Add Lenovo Capability Data 01 WMI Driver
  platform/x86: Add Lenovo Other Mode WMI Driver

 .../wmi/devices/lenovo-wmi-gamezone.rst       | 355 +++++++++++
 .../wmi/devices/lenovo-wmi-other-method.rst   | 142 +++++
 MAINTAINERS                                   |  12 +
 drivers/platform/x86/Kconfig                  |  35 ++
 drivers/platform/x86/Makefile                 |   4 +
 drivers/platform/x86/lenovo-wmi-capdata01.c   | 140 +++++
 drivers/platform/x86/lenovo-wmi-gamezone.c    | 374 ++++++++++++
 drivers/platform/x86/lenovo-wmi-other.c       | 549 ++++++++++++++++++
 drivers/platform/x86/lenovo-wmi.c             |  77 +++
 drivers/platform/x86/lenovo-wmi.h             |  94 +++
 10 files changed, 1782 insertions(+)
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
 create mode 100644 drivers/platform/x86/lenovo-wmi.c
 create mode 100644 drivers/platform/x86/lenovo-wmi.h

-- 
2.48.1


