Return-Path: <linux-kernel+bounces-261476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0900C93B7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C1F1C23DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7E16CD12;
	Wed, 24 Jul 2024 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ris97wMu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897577F15
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851934; cv=none; b=RT9quMWSexDxI7lrZuPtabTPt6FCvLou0mbZ/+eOT3buSdLqvaR7YRZn4MKycNj7f28Tg4RUDYXfar11RJROF2G2VYhWZwqzushJtckFcSQJk8jhUrBzGnTsqaZ5n46cFpZ3HK27E2vAL2kzVgzLXhtFCqXflCSV0YG2GYlLYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851934; c=relaxed/simple;
	bh=xZNaBbB0wMmjiseP/F9qcbYJ9meuTVdSqqwGwt5bznA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JtqV7QzS0+Aep13mRb6po/wFFeTzqtIglq6e77/18aNpWFdW4g6eUsKM2TWW/D9rBXK8C1VvuYvccrsFSXprDEG4gbKpjtaHJgHid3z17AibtFJmV/D5+vg3YhcSDQdBXbvVT9nvLk1iop4AoQsATBON/itf8C0u4vJtuG+KpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ris97wMu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65b985bb059so4652337b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721851932; x=1722456732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4/ugqCbJcMZV8LtDMnezqnGhENpKQU606cq1ajIu24=;
        b=Ris97wMurHv4MGDptXOsGUgLp92rA88IXmnvRaeNPghuoexw2ND1aDkoMBFBkpcIAY
         gCnOPnNi8vHSxWSmvWOdKhFBF4olU5/voHu8U6u6KtcBcD+OE8fpk6btCWL3b0Q7HHzk
         yOKs2YaGZ82UZC7G+7EljG10EkKYdTdFlW4gFuMt0EeD+EkpdECTy7Hz7Nef6zj1Nlrh
         /W95lMU/Pr3zgaCW11qUD1VHC1M2oKbNpA6wcaCMyN+bwcDjOKmNgByiKJlPXZ0CLqoD
         VgBrdaDUFPphjhDmo5bQ32xi2Cgy02f04TZXR/UGF+YhR+xULfoc1GSUQKd2iB/ZioSN
         eLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721851932; x=1722456732;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4/ugqCbJcMZV8LtDMnezqnGhENpKQU606cq1ajIu24=;
        b=WVkZW6cA9svj/qDc79QuYgi3DpzFcK0my3rt3e41yvG+8XegSMMkPbwwRApnCpsTuT
         8slme/BRaZ5H9Sqmci/4bA8cwXiW42QluG1Mkpd30qWw6InYBe+lrguZdtzW1cHA8F1J
         e53JPHx2nEu3lJiQNm0YHHaGX64cuJgAB78XaikxgyTyqpVJjR0QHR87Ai3VHggIQgbR
         b0l8Z0dcEglypOOWGIlG9P2fZSu928zvIDHDhr3jpSHIZETSKBc6qTxxYA0aIj6aqXXl
         EinCj/bihrRx5J1JkKE9b9NZT9RZYxFVbGDWippHMVxREfr8fCjd0iHtpkmlrcO/toLI
         gw/w==
X-Forwarded-Encrypted: i=1; AJvYcCWa/3yTfK/mwKqYaWzJQcIRK+lH6+dlz16wSvEXhFMJAIM1UqoJj/WnadbNuSFhOn6TYZYvAt/JA/W+2Wre3lUGhJXY90CwVtbwJ0cO
X-Gm-Message-State: AOJu0YwKF21PkdbSP+u9WXueyKK33vocXnglMiUXdTOVZvn+v4FL00jC
	4g2lrQKQM0dslJU7RwimENnp5CwY+3Xs0qLMPkeoL/MBE+Mn8Y4hznQkbv6Ef0JrreXhxclR9g5
	cdQ==
X-Google-Smtp-Source: AGHT+IEnsnl5YB0mUp+Acl6SSxpP7PSPhMVzcdrqmwjoQ1c+9zPBYWJw1W6sH/wyS03q6il8DI8ifb8yAws=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a81:b043:0:b0:61b:ebab:ce9b with SMTP id
 00721157ae682-67510ee954emr11317b3.3.1721851932227; Wed, 24 Jul 2024 13:12:12
 -0700 (PDT)
Date: Wed, 24 Jul 2024 20:11:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724201116.2094059-1-jthies@google.com>
Subject: [PATCH v2 0/4] usb: typec: ucsi: Expand power supply support
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

This series makes the following updates to the UCSI power supply
driver.

1. Adds support for the power supply status property.
2. Updates the driver to distinguish between PD and PD DRP power supply
types.
3. Adds the charge control limit max property which can be used to
request a PR swap from sysfs.
4. Fixes a simple SET_PRD typo in the ucsi.h header.

I've checked that the series builds on top of the usb-next branch and
manually tested functionality on top of a 6.10-rc5 ChromeOS kernel. Let
me know if you have any questions.

Thanks,
Jameson

Changes in V2
- Uses DRP bit in source PDOs for setting USB DRP power supply type.
- Adds SET_SINK_PATH call when handling an update to
charge_control_limit_max.

Jameson Thies (4):
  usb: typec: ucsi: Add status to UCSI power supply driver
  usb: typec: ucsi: Add USB PD DRP to USB type
  usb: typec: ucsi: Set sink path based on UCSI charge control
  usb: typec: ucsi: Fix SET_PDR typo in UCSI header file

 drivers/usb/typec/ucsi/psy.c  | 81 ++++++++++++++++++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi.c | 15 +++++++
 drivers/usb/typec/ucsi/ucsi.h |  7 ++-
 3 files changed, 101 insertions(+), 2 deletions(-)


base-commit: 933069701c1b507825b514317d4edd5d3fd9d417
-- 
2.45.2.1089.g2a221341d9-goog


