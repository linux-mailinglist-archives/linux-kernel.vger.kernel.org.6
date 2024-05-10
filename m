Return-Path: <linux-kernel+bounces-176113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785E8C2A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E161C218C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95944393;
	Fri, 10 May 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBUGftx1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F13CF4F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366614; cv=none; b=AXfqPVsEqcZQGwL9AuPEfX+/mFlAHPAycPq2MRBJev+C3tTa5wbOXFwPlA4j1hAwLja/h+TkR+7P/0sEZw4QB0O3f0wU8bx4aSldh9jckVvJUzK/pbUzJ0fwqWW4ask5iYM9Sm9CiZ+uTzgUjUAATrdyxSxjuGJ24ZHA+rLDZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366614; c=relaxed/simple;
	bh=Mox5CygbAp0hbnlUnK+vjkkchP3v4sLYbiSX1PaNIXM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KeiD8eUfo3IIYm9VZCq+txMJ0jgbl0tbjkn0WZv9t7W8vfxbcFid8xCghrFkn+0BQbGcomJwQo7GzcrZqNrIQgZIf7unnYdwBeRS4KoUBVUK27Yxuqa8gX66W2TE70jW7p5QDxvTK/evlecXCm/5zIpYuI2OvZz2jCMMo/Qgo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBUGftx1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4601434so42813237b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715366612; x=1715971412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LpXK4QtSXraUQ+jRpkogOhgYroQ8dBMsRdFzLXDbwtE=;
        b=cBUGftx15pUhg4NtQIUT6AIsOC2WXipxPcc8yTzbT4YToYXznSt+RvlfGwjM+GXi8j
         2EYCSvEt2L9bqc/tE02kb6waZGFZ76n2bPFkG/sf9KprSfZ4i4aB5HciE9396gvqOzXc
         J6tHLAtUCIBARxKcM35MrN9qVw+NMVYRZ2kDAevudML9WwsfRXhYtvuBxV+fyRwT3115
         I8ZjYhk4ibxIMf2enTUG+6x1ys/EpAvK3u+ZmwqjNjT6fQxYpEoMViuDZL5YYP+J7S6a
         nmMJlJMNVcES9ebQt2pS6pTbIF4UDFcVGRO1ZQDXHGkMEtyQw29q6u8WXUD8133DdmsP
         Rg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715366612; x=1715971412;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpXK4QtSXraUQ+jRpkogOhgYroQ8dBMsRdFzLXDbwtE=;
        b=H3+Bjg9OZBE81htS60HcdzJyJB5/oQhiSOPuzHhjeVZ+baP9kAyQidpr+mIJNWIH6N
         DekqR8F/8h/TQ0mhI7g2oE+unD/LhCXYKHJHdKaMAUb+Kh7WKyIw34VOQCULuhQaVjS9
         wRLLn7viTUE8t9PowmucVUEgtS2mymz0Un/U7UfHsEA9rayod2FhDQcymthUWoWYcO4F
         TcBYBJPAMlB8XADdZfRzmVWt5+/GXPNjiQFWsTBptUMp0aLe4KVOhIqQ0+8NO6JEvdLE
         4buVl/rbh7IscxhziUwZnKZxWCauppgwyTS07w0ZQlGsZveQ2zw9AV06s/k9RUFwDkgf
         Xgvg==
X-Forwarded-Encrypted: i=1; AJvYcCVIVQvh0+02+HtyRS83teKdsMTgddohoBVoiH+jYMA/HaZfg2R7wy1dBrrd21XphIUr2r36RqveiMLqjxcgC80mpOmEfRDRWWJwfiug
X-Gm-Message-State: AOJu0YxzYBWkNup1id4z+ilZr8OHrG/uf/p63vSWf9RNi5Z0tdkccft0
	Vmy3CRIqp21kn5Ju0LCGZ41Gvdg4DKrgCAq+cVhnr9FBsYm08TLHqyPfhahEbrUWB+UhBvj5gEX
	/+g==
X-Google-Smtp-Source: AGHT+IG+48erkgdEz5uPmVNeCO4BkSFDKeouCWhPs6mrrdcIsWoSJL3hL/YwMVrHxyGIGd/WSyUsaAjFvsU=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:3802:b0:61b:e2ea:4d7b with SMTP id
 00721157ae682-622affa5943mr8898277b3.1.1715366612088; Fri, 10 May 2024
 11:43:32 -0700 (PDT)
Date: Fri, 10 May 2024 18:43:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510184324.2944101-1-jthies@google.com>
Subject: [PATCH v4 0/4] usb: typec: ucsi: Update UCSI alternate mode
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

This series appliess some changes to the UCSI driver to help support AP
driven alternate mode entry. This includes...

1. An update to the altmode sysfs group after registration to make
"active" writable.
2. A change to the ucsi_partner_task delay when queuing
ucsi_check_altmodes to prevent it from running before other discovery
functions.
3. An update to always define a number of alternate modes for partners
and plugs.

Not related to AP driven altmode entry, there is an additional fix for a
null derefrence in this series.

I tested the series on a ChromeOS v6.8 kernel merged with usb-testing.
That build had some additinal patches to enable a PPM in ChromeOS. Let
me know if you have any questions.

Thanks,
Jameson

Changes in V4:
- Updates to the commit messages.

Changes in V3:
- Returns typec_port_register_altmode call from
ucsi_register_displayport when CONFIG_TYPEC_DP_ALTMODE is not enabled.

Changes in V2:
- Checks for error response from ucsi_register_displayport when
registering DisplayPort alternate mode.

Abhishek Pandit-Subedi (2):
  usb: typec: ucsi: Fix null pointer dereference in trace
  usb: typec: Update sysfs when setting ops

Jameson Thies (2):
  usb: typec: ucsi: Delay alternate mode discovery
  usb: typec: ucsi: Always set number of alternate modes

 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/class.c                | 18 +++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi.c            | 18 +++++++++++++-----
 drivers/usb/typec/ucsi/ucsi.h            |  2 +-
 include/linux/usb/typec.h                |  3 +++
 6 files changed, 36 insertions(+), 9 deletions(-)


base-commit: e4306116b5e93748b3eaa7666aa55c390b48a8f4
-- 
2.45.0.118.g7fe29c98d7-goog


