Return-Path: <linux-kernel+bounces-432435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F099E4B39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC671881281
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31716D531;
	Thu,  5 Dec 2024 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hof/BnBh"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25971FB4;
	Thu,  5 Dec 2024 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733358990; cv=none; b=KwRbu09ziIOPzUnAD2k0iqwLb1hDR/sQia3N8YSYYmjl08k0nDU48woX37KQdCu+0CuW9yThOWJcbaHs8uYf7sKwEpJ0CV+Pbdzg0P+7rN4GNUjV9wQpnbSS78BNgTqF1wE8HEjsKYlktkeDP0FZoB1wxEWZ6QQMUwEDwsGy8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733358990; c=relaxed/simple;
	bh=c3IGFIcYrs5POjUJZJ77cFGRuU9qQ7oV+pzI3UzIk64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtSSMR5sTgak+W5y95t1jG1zb2KdJTnqapGzq03dFVQdozyzz91YC40MG8yCFllxAsG9/7mswRZjQrHYUEFJddGFsXNd0kWV6J6rcs2wmTbgMzpdPqZBftISKzGhf613zsK2AJYJbC7BsRSDrI50ZKrXbxVxsB0Zn4W5P37U5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hof/BnBh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd10cd5b1aso289375a12.2;
        Wed, 04 Dec 2024 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733358988; x=1733963788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uhuTedbxWiR2mVtb5z46bMDrioY6oWpuEBDEuGxtUM=;
        b=Hof/BnBhuTj/qbR/66YkpwDczp42U0mUtdoCawh2Uo5yEhl3KT41Et6FBldVqZhWhS
         BPL2BO78hb6dkUJnOVpzlmLDGjgt6b8G5BW8WVfQ2zM8ZfztleahH25m8VoIIdVgphAy
         IBnu/3t3qldxwTujFq6M8Zv79HMmTqeGIICQCt/Isx2WC0EHFILAVam14L/IqVF60Bjc
         NtJQ716RzAu3nFHGuSUaVMGT8PtmWUKIKfT4OgOEIIqCG8lOJEtf/LPFSvtDiLCjWF6B
         GTq2t++xElk3LOpygHO2J9Aw/cg8fDFVXAjx40tB8C2FnUq5SpX2z8hyQxtEMakvd7e+
         CPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733358988; x=1733963788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uhuTedbxWiR2mVtb5z46bMDrioY6oWpuEBDEuGxtUM=;
        b=Wt98rW3zFNsCPcynDI6YVNwxEvcVVuBHaFLh0arUq0sNB3obNDpNCYxW57++yjW1/8
         LheCQZLT4zWORQjZZtf5pjDuNl3wEvZXTwFv8J0k6+YAaqEMlaCIhBnenW3MYDWdSdVk
         C5rWrKyK0LeT3CC4a00vwjid7sNX2c+GQj9G4MID7kFXxr6LimjR4c/3TAq0VuqHyoc1
         fxBOOsOpWZAeDSaw85EAu5Dfl1iIS3w9DCFilfUHpz3uBTzSB7a8Pd2/gvPQyd3ksw+Q
         PGgsGG17rLZ4kh15N+7t/KVKsaOc9OCIHvZoiezUt2xYdRUHuPsCt1Mr4QNzbQ1IJkQZ
         rV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCURJwm7mCIht/VV5U/Hg27DYWiOzwrlou3tT3/A1ClxuX4px0XIbk9hdSRmfUgOKwUid1/3iPpVEfuSUS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYOnL+ilY/M1G9x2sJvp6xKcbFMc8SMey/+dPwfJZbxLc19hf
	c62JxT/Gs4vLtWGBPWwhTPpZ6cmoA+4mtL/Y/RCuULAL6Jvaxc0zPjbIAVtU
X-Gm-Gg: ASbGncsJUdCWUP5sO+pEs0yQiTsGftU60zjtJBUjMLywACEieKXWUb6jBxZ8AgGSIMH
	lf8OxAs1b8ajiKbL4KZRmrEJ0Of/lUOiLxHFnwP3WOGRRfH+5UStZd6NO49fFu5HRvomAOPeezz
	Ze/wPOiR8L2r4G/clG8X9j1OAom3yRXC0Df2FWK4gofToTsTrheDM/ECtDJyxxiRV2Rivl3UpCi
	/zH7W2LBW0QJRIvycX78DaCckZ8WeULYE+e3lJej63lRTepZNetQrEUwUlCYyyYPqcR5zQvypA5
	sW+0vcreUQ1aRXQCPmk=
X-Google-Smtp-Source: AGHT+IHPrhJIlSA36m/yhzrjjRLRsSmY9cvhvedQ3vfHRYCV/a0uaYbpIw+2wyg73IQBm/k3vy8yyw==
X-Received: by 2002:a05:6a21:6d94:b0:1db:d8df:8c4e with SMTP id adf61e73a8af0-1e16bdf9bc5mr11013325637.12.1733358987842;
        Wed, 04 Dec 2024 16:36:27 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1569b2b6sm148768a12.14.2024.12.04.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:36:27 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	w_armin@gmx.de,
	Kurt Borja <kuurtb@gmail.com>
Subject: [RFC PATCH 00/21] alienware-wmi driver rework
Date: Wed,  4 Dec 2024 21:27:35 -0300
Message-ID: <20241205002733.2183537-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi :)

This series are a follow-up to this discussion [1], in which I proposed
migrating the alienware-wmi driver to use:

1. State container driver model
2. Modern WMI driver design
3. Drop use of deprecated WMI methods

Of course, this was much harder than expected to do cleanly. Main
problem was that this driver "drives" two completely different devices
(I'm not referring to the WMI devices, which also happen to be two).

Throughout these series we will call these devices AlienFX and AWCC.

As a preamble
=============

AlienFX exposes a LED, hdmi, amplifier and deepsleep interface to
userspace through a platform device named "alienware-wmi". Historically
this driver handled this by leveraging on two WMI devices as a backend.
This devices named LEGACY and WMAX were very similar, the only
difference was that WMAX had more features, but share all features
LEGACY had. Although it's a stretch, it could be argued this WMI devices
are the "same", just different GUID.

Later Dell repurposed the WMAX WMI device to serve as a thermal control
interface for all newer "gaming" laptops. This new WMAX device has an
ACPI UID = "AWCC" (I discovered this recently). So it could also be
argued that old WMAX and AWCC WMAX are not the same device, just same
GUID.

This drivers manages all these features using deprecated WMI methods.

Approach I took for the rework
==============================

Parts 1-7 sort of containerize all AlienFX functionality under the
"alienware-wmi" platform driver so WMI drivers can prepare and register
a matching platform device from the probe.

Parts 8-12 create and register two WMI drivers for the LEGACY and WMAX
devices respectively. The code for these probes is VERY similar and
all "differences" are passed to the platform device via platform
specific data (platdata). Also AlienFX functionality is refactored to
use non-deprecated WMI methods.

Parts 13-17 migrate all AWCC methods to use non-deprecated WMI methods
and the state container driver model.

Parts 18-21 I splitted the alienware-wmi.c module into the different
features this driver manages.

alienware-wmi-base.c is in charge of initializing WMI drivers and
define some platform specific data, like operations (Part 10 for more
info). alienware-wmi-alienfx.c has all AlienFX functionality and
alienware-wmi-awcc.c has all AWCC functionality.

Coments
=======

This is still kind of a draft, but I did some testing and it works!

Of course I will do thorough testing and cleanup when I send the
non-RFC version. I just want to get some comments on the general
approach before proceeding further.

I think this is quite messy in it's current state so I apollogize.

@Mario Limonciello: I included the reviews you gave me on [2]. I
included some of those patches here, and dropped the ones that did not
make sense with this design. As this is another series let me know if
you want me to drop the tags!

@Armin Wolf: I don't like the amount of files I made. As the maintainer
of the wmi module, what do you think about making two independent
modules, one for AlienFX and one for AWCC. In order to not register two
drivers for the WMAX device the module init would check if the "AWCC"
UID is present.

The approach for that would be basically the same, and I think the
series would change very little.

I would like this a lot because I still think old and new WMAX devices
are different, but I couldn't find another example of where an OEM
repurposed a WMI device.

@Everyone: I know this is VERY long. Thank you so much for your time in
advance!

This series were made on top of the 'for-next' branch:

Commit c712e8fd9bf4 ("MAINTAINERS: Change AMD PMC driver status to "Supported"")

~ Kurt

[1] https://lore.kernel.org/platform-driver-x86/6m66cuivkzhcsvpjv4nunjyddqhr42bmjdhptu4bqm6rm7fvxf@qjwove4hg6gb/T/#u
[2] https://lore.kernel.org/platform-driver-x86/20241120163834.6446-3-kuurtb@gmail.com/

Kurt Borja (21):
  alienware-wmi: Modify parse_rgb() signature
  alienware-wmi: Move Lighting Control State
  alienware-wmi: Remove unnecessary check at module exit
  alienware-wmi: Improve sysfs groups creation
  alienware-wmi: Refactor rgb-zones sysfs group creation
  alienware-wmi: Add state container and alienfx_probe()
  alienware-wmi: Migrate to state container pattern
  alienware-wmi: Add WMI Drivers
  alienware-wmi: Initialize WMI drivers
  alienware-wmi: Add alienfx OPs to platdata
  alienware-wmi: Refactor LED control methods
  alienware-wmi: Refactor hdmi, amplifier, deepslp
  alienware-wmi: Add a state container for AWCC
  alienware-wmi: Migrate thermal methods to wmidev
  alienware-wmi: Refactor sysfs visibility methods
  alienware-wmi: Make running control state part of platdata
  alienware-wmi: Drop thermal methods dependency on quirks
  platform-x86: Add header file for alienware-wmi
  platform-x86: Rename alienare-wmi
  platform-x86: Split the alienware-wmi module
  platform-x86: Add config entries to alienware-wmi

 MAINTAINERS                                   |    3 +-
 drivers/platform/x86/dell/Kconfig             |   25 +-
 drivers/platform/x86/dell/Makefile            |    5 +-
 .../platform/x86/dell/alienware-wmi-alienfx.c |  531 +++++++
 .../platform/x86/dell/alienware-wmi-awcc.c    |  282 ++++
 .../platform/x86/dell/alienware-wmi-base.c    |  525 +++++++
 drivers/platform/x86/dell/alienware-wmi.c     | 1267 -----------------
 drivers/platform/x86/dell/alienware-wmi.h     |  141 ++
 8 files changed, 1505 insertions(+), 1274 deletions(-)
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-alienfx.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-awcc.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-base.c
 delete mode 100644 drivers/platform/x86/dell/alienware-wmi.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi.h

-- 
2.47.1


