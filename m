Return-Path: <linux-kernel+bounces-339405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B99864BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6611F25256
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF904962B;
	Wed, 25 Sep 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpFlmMhd"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4943ABD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281518; cv=none; b=k6OfzLw/5zfiD54ALAJ4aalrTZL6QMLkGGOnfdTbY2Nf0Ze0glaPS4IejYjV5vZbOWCO5d6lPMCLSe+01YQnbBCEhcvKwRu8fnAexxvdj9S3Rmbq9A7H0cN5rH0k1d/u9gk14KHTNM7nOvGAHs7/bHI4fc5EPzAU8mI4g8Wl2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281518; c=relaxed/simple;
	bh=GJue/+u8mABPlZVbGPZ2WTyeSlPF0P89TcjTAJEqBcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpTYS4Rjz/o2RFx7yeS7hZEOWwE+ObeHCO+vtuyiWtokveFQv9AVY7q89k0QnHcxxV9QiZJFxTESwnHnrhnTo2g8nUmSw0Kq5+kiAckU9t9+ra1qtL5/sS7hvUhJpxfxdTPCfW1SzMk0S5k2o+iKvUqOrhPrFZ2Rj4z9br62kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fpFlmMhd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso23441a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281515; x=1727886315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3bnx6Zh4mamf2M1m16i5ArTu3cLGPl0b4fDr+jRputI=;
        b=fpFlmMhdV9AEeZC87aGNhyps4mmvf5P2owCvckLe60XCWi2l7h0zPzb5RfCwEL6D2z
         62Ggz4l2wOtvFMlxyt8iZ3HpN+bDBFBAE9yGtEgrLOASlVw4Wfuk+TvqXVsDWd2dzvGZ
         XzcyXXbcZT6kM60IkhleDRZfkgd5xrcRH8iUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281515; x=1727886315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bnx6Zh4mamf2M1m16i5ArTu3cLGPl0b4fDr+jRputI=;
        b=ks+odYWlrGwsnfmonR0Lu0ZN81TelpmpCqYFNP9l6ScJQieN+ImfRrKzeZKmP+BjNc
         yoFwudY12GzUR2EzbL2DoXwIeaU7OmLnk1zGN3arOgB0Y8RWedL9dV92OPFpAidyL4S0
         N0nwjkTbcuSt9xbPLvag2jhmMMAELmmMWYfmW2i6twl43rL9EaCCnevVb0K/ODglLBzI
         ysCLHSgGwYMzBfX6WNJmfEbzvK7UZZBDJVG6Jgpe/ZsLYY3RpbvpwEQXDF/hCHVDDbAR
         z2R1qT15HL2/2JooJ32fzu5Kls8mAtMsIBt/pTlkUkifa9mfVRaoMA+5BzbU4uxtBXQG
         pVcw==
X-Forwarded-Encrypted: i=1; AJvYcCUo7lMdNP0bRrxIMfFh4soLwce7BiSds7yw23Ch3sKyPnMbYk/o1Up8Hy4D6GlIlCOftnoT6zI+nx5iKhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmg28C8ClZvAawi8SWYzd0PurgOVfO/fWJuYb5IrkxkYYgIxL+
	WkJI+An/XRvvZpnVr7MgAhDGB7+QiVZ8pD92Y6LpfMIvRPaAvKo1GqM0NfgO8g==
X-Google-Smtp-Source: AGHT+IFmomGt1zx36Co4VLTbp3ZotqkB//xP4LtEBzby9ndEonhFlY1+uOXpqHVO3DCfXwK5T6IKOw==
X-Received: by 2002:a17:90b:3510:b0:2cf:eaec:d74c with SMTP id 98e67ed59e1d1-2e06ae5fcf1mr3879528a91.16.1727281514917;
        Wed, 25 Sep 2024 09:25:14 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e06e1ff886sm1728377a91.31.2024.09.25.09.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:14 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 0/8] Thunderbolt and DP altmode support for cros-ec-typec
Date: Wed, 25 Sep 2024 09:25:01 -0700
Message-ID: <20240925162513.435177-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
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
  or AP-driven from userspace (via the typec daemon). Thus, we never
  expect the kernel alt-mode drivers to auto-enter modes.

This was tested on kernel 6.6 with a ChromeOS Brya device and compile
tested against linux-usb (with allmodconfig).

Thanks,
Abhishek


Abhishek Pandit-Subedi (7):
  usb: typec: altmode_match should handle TYPEC_ANY_MODE
  usb: typec: intel_pmc_mux: Null check before use
  usb: typec: Auto enter control for alternate modes
  platform/chrome: cros_ec_typec: Update partner altmode active
  platform/chrome: cros_ec_typec: Displayport support
  platform/chrome: cros_ec_typec: Thunderbolt support
  platform/chrome: cros_ec_typec: Disable auto_enter

Heikki Krogerus (1):
  usb: typec: Add driver for Thunderbolt 3 Alternate Mode

 Documentation/ABI/testing/sysfs-bus-typec     |   9 +
 MAINTAINERS                                   |   5 +-
 drivers/platform/chrome/Makefile              |   3 +
 drivers/platform/chrome/cros_ec_typec.c       |  55 ++-
 drivers/platform/chrome/cros_ec_typec.h       |   1 +
 drivers/platform/chrome/cros_typec_altmode.h  |  48 +++
 .../platform/chrome/cros_typec_displayport.c  | 247 ++++++++++++++
 .../platform/chrome/cros_typec_thunderbolt.c  | 184 ++++++++++
 drivers/usb/typec/altmodes/Kconfig            |   9 +
 drivers/usb/typec/altmodes/Makefile           |   2 +
 drivers/usb/typec/altmodes/displayport.c      |   6 +-
 drivers/usb/typec/altmodes/thunderbolt.c      | 322 ++++++++++++++++++
 drivers/usb/typec/class.c                     |  34 +-
 drivers/usb/typec/mux/intel_pmc_mux.c         |   9 +-
 include/linux/usb/typec.h                     |   2 +
 include/linux/usb/typec_altmode.h             |   2 +
 16 files changed, 918 insertions(+), 20 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
 create mode 100644 drivers/platform/chrome/cros_typec_displayport.c
 create mode 100644 drivers/platform/chrome/cros_typec_thunderbolt.c
 create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c

-- 
2.46.0.792.g87dc391469-goog


