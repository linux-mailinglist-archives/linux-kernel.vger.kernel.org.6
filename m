Return-Path: <linux-kernel+bounces-389594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D098A9B6ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F42061C218E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACE1EB9FD;
	Wed, 30 Oct 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BQ4PR7io"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363C1E1A23
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323745; cv=none; b=Ioqj25Lp0AeBVe7dE7w+Pg1es9tExitErqfiugUoizMl0kmYFPuG0DPT0hMURkF2nhuubApTmCcyabWcqt567ZtQxZjYHcyf6YJt8QoNTzMFmYqHSfjXBxmG0C83MdAsxcCjzoPWIHSlL61zwk+qXwgIxh02a24hpMbyJb2t9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323745; c=relaxed/simple;
	bh=wxnxBHu4Ed5Na+Ptb3g/4nCkQ+VCViGFxWYmFZgvbUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4tZSwxS7Oobsoqn/MCEr6tY9x43lv0IeiLa6gf2EyTnSLMQib47BZpFgw4HEiKTmdGm1LWJ9I3+NFuJTh65wLK/MPtZNm5aTYT3xd+mlzolC1ZEXn/rJ+tLJaJZWPVoxMznqICJivucWyo6nnwVlzDujo9gUlIh5fzvKOAiGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BQ4PR7io; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so199970a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323742; x=1730928542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6BztmXiZQ2WeYemOXUBT7pafeMZTwAZ58FA85PlJ1c=;
        b=BQ4PR7ioptgTgfwN0wmD5WADaO7EDKfpcu4M6BDhNEwChYxy1og65DiOcBBgRH9T1I
         K3Wfj6EV67KC+YV+vDzahpNOM0vvrFRjOOsOVn5Roi0I4IMcH+C7zWvYHWfxTDJycUZW
         Da+8aIRT3/lk/8Ugv3e5nHKxnN/kT4er2wNeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323742; x=1730928542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6BztmXiZQ2WeYemOXUBT7pafeMZTwAZ58FA85PlJ1c=;
        b=PnyZKf9OkfxUycjyoIMNQqI+4SDCOKPpH/q7buYujQ1A6ciFoHHeyAFg+idfYq78nj
         YK9ENLoel8Z6ALAVe9PQaXoOeEshfrFtEk2b6Lp6StpkuAcbZxFn3Gj6zOM+3xLxmiXn
         7egQu1Qu84orA+Xf+hU4kjLKO3nlaoLn82UwpIxqcuRlxn3DwvkO3qq1+IYsrSifczE6
         Scyv0gFvYi+HMtmg241U1H0uXMoCETILysCqz/rGxAVMTR7qhrQgzTvO6xhjLQzIR4Sy
         t6pYEqPgC2FVdiN3yWzWW15arXbX0Egv2lB+/HgOytoUQNOcGFn6CWL1/DJOZenv+r0z
         A2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo+znDWR01Gj5HhwaG+mx2Z3BqPtdk6tyU4S5tuIXCKgw3SBEvEcGHf95oqvmHft8cmNczEIWnclH1Q7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWTdrmeIWXVVOrGDpTsI0B4jXkrb+vqyqcfErr/JTBoU3MhNY
	pF4YFd56HPGqhKYLWXJkcqFsmJoSe9Ylp8ketGDnk/ikU4Da9HsIpjM9Fhw3Tg==
X-Google-Smtp-Source: AGHT+IG7EblohsImkgjfBUwOMph15MUH5Nmg3VYhDviXXVfX5hHMHxIMh6cMmhfuonlZYFXq5qcMxw==
X-Received: by 2002:a17:90a:ac10:b0:2e5:5ff9:bee1 with SMTP id 98e67ed59e1d1-2e8f10a8920mr17943216a91.29.1730323742381;
        Wed, 30 Oct 2024 14:29:02 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e92fc008b5sm2353937a91.52.2024.10.30.14.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:01 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: dmitry.baryshkov@linaro.org,
	jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Thunderbolt and DP altmode support for cros-ec-typec
Date: Wed, 30 Oct 2024 14:28:31 -0700
Message-ID: <20241030212854.998318-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Heikki, Tzung-Bi et al,

This patch series adds support for alternate mode entry for the
cros-ec-typec driver for Displayport and Thunderbolt.

Thunderbolt support is added by adapting an RFC Heikki had posted
previously:

https://lore.kernel.org/linux-usb/20191230152857.43917-1-heikki.krogerus@linux.intel.com/

A few comments on the series:

* The cros-ec interface will not accept any VDOs/VDMs so we simply
  ignore any configurations we are passed (i.e. DPConfigure). This means
  the sysfs control of DP lanes won't work.
* ChromeOS has two modes of operation for alt-modes: entirely EC driven
  or AP-driven from userspace (via the typec daemon). Thus, we don't
  expect the kernel alt-mode drivers to auto-enter modes in all cases.
  This series allows auto-enter for displayport but disables it for TBT
  for this reason.

This was tested with a ChromeOS Brya device using kernel 6.6 and built
with allmodconfig for linux-usb.

Thanks,
Abhishek

Changes in v2:
- Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
- Pass struct typec_thunderbolt_data to typec_altmode_notify
- Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
- Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
- Change module license to GPL due to checkpatch warning
- Update altmode_match to ignore mode entirely
- Also apply the same behavior to typec_match
- Refactored displayport into cros_typec_altmode.c to extract common
  implementation between altmodes
- Refactored thunderbolt support into cros_typec_altmode.c
- Only disable auto-enter for Thunderbolt
- Update commit message to clearly indicate the need for userspace
  intervention to enter TBT mode

Abhishek Pandit-Subedi (6):
  usb: typec: Only use SVID for matching altmodes
  usb: typec: Auto enter control for alternate modes
  platform/chrome: cros_ec_typec: Update partner altmode active
  platform/chrome: cros_ec_typec: Displayport support
  platform/chrome: cros_ec_typec: Thunderbolt support
  platform/chrome: cros_ec_typec: Disable tbt auto_enter

Heikki Krogerus (1):
  usb: typec: Add driver for Thunderbolt 3 Alternate Mode

 Documentation/ABI/testing/sysfs-bus-typec    |   9 +
 MAINTAINERS                                  |   3 +
 drivers/platform/chrome/Makefile             |   3 +-
 drivers/platform/chrome/cros_ec_typec.c      |  56 ++-
 drivers/platform/chrome/cros_ec_typec.h      |   1 +
 drivers/platform/chrome/cros_typec_altmode.c | 362 +++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  48 +++
 drivers/usb/typec/altmodes/Kconfig           |   9 +
 drivers/usb/typec/altmodes/Makefile          |   2 +
 drivers/usb/typec/altmodes/displayport.c     |   6 +-
 drivers/usb/typec/altmodes/thunderbolt.c     | 309 ++++++++++++++++
 drivers/usb/typec/bus.c                      |   3 +-
 drivers/usb/typec/class.c                    |  33 +-
 include/linux/usb/typec.h                    |   2 +
 include/linux/usb/typec_altmode.h            |   2 +
 include/linux/usb/typec_tbt.h                |   3 +-
 16 files changed, 830 insertions(+), 21 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
 create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c

-- 
2.47.0.163.g1226f6d8fa-goog


