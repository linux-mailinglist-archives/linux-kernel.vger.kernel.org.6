Return-Path: <linux-kernel+bounces-334539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85197D883
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55579B21A15
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68117E900;
	Fri, 20 Sep 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WKJbGZJR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FED170A1B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850850; cv=none; b=g7tv2e/jKqUHaAKmZHxnImkfoSB3cXpdfN5Qz+wUJ3GUhxC7M81pyCF0boSKzV2ntJIKHAhMD9l96ATak3xllWyZBwU0d+gFH9eIqtZPRZWCr/SeYHGfM4rTo6mh3vo2mXtsQ7vH1k6x169v4GV+HTXGS/GF7EnS9Ih0WaFAgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850850; c=relaxed/simple;
	bh=2mrpQYS0durlIiTO7A9inQC+gazq8OIpoYV9W4sUykQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B/6J8n4XvGduLfcuLOQ9MWfcQOfTWcG+dFOIm0eI64iKVa0OxHIx7lc8CQuXIyQPoMAagVvOXWuDBa+de7Xy5knFIlqmAEUjYdjJywqpeDl/YPXCEZ7MLH6dSXH5H3+bWCkRMhUxdvpW/PXv8H+2Gi+rvQ90DUWJlS+9clkfRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WKJbGZJR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb2191107so18399805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726850846; x=1727455646; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDzaQlV6GjyEQTNCzKM3UkvH+Kbl13+ehOFDQrsAvdU=;
        b=WKJbGZJRmZbYQkB6LE/u9NWfJ6rqLdzPGhrKQx3kxnbK70qWR0rL1l7L+TqGOeHWkb
         QyclYFV8miyAdh+8U2M6O7JPr86NH8VWBlllq/QfgJhxGvIQLtoBey/LZxNlqzIK3AcT
         zA1HnpkQBwqlKL18XndQDjEHuDAJhTAkj549eNuXcjhTj5MxNdOdbD+BuWJZWg65CYsA
         JeaAlJDMAZYsudG+ITxbsy3bOdmsIpjs3PXmrWououUE/7gPXjr5Meklng7G56DK2gj8
         GGQlN52KizwRSc72DrTUBfF9sdpK4cBo8nceG65KBZxuZylUpz1X5g2hhO0JGH5IxQ79
         HzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850846; x=1727455646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDzaQlV6GjyEQTNCzKM3UkvH+Kbl13+ehOFDQrsAvdU=;
        b=tJvH7BHRcQeUaEEyKdKE2+sIJU7vK5KLULp4cgn/OjxsQp3C6JTYP9t92ca2US+6ZQ
         8izsEP5c40+5tWZSlT6dMtGWFyKPQ1uvsNu1RqYaG73N8Nxhj7AbkTy7TvGn8vFgmnsB
         L4XdQLGw+S6BKUsjGWEypxX5MAodQtq0LASug7U+9VIKubxq3y9KlFAesfljigK6v878
         7esqc4e+lsJW3tXC0ul9NID+q8yqAeUu3MOA4xSA7JH6MJ0FTIlACmpNKvb5Z5TgoBGg
         wSlTnQ2zT5Tb4meVNst+EB/PMh/94Txy7MsSJVkVJh5PQrLbyq1IvqBNa0AFqIJi/50v
         vovw==
X-Gm-Message-State: AOJu0Yw8XXKXoCK7mzCLFThy4rrsq4OkVlQKT9pY3IBW0HJSEQNM1/eU
	5qp/SgagMQLuqR22PQGq+b9bfenm4/4wR4AodRgtwmareYEPPXlY6H0N4vgkL+4=
X-Google-Smtp-Source: AGHT+IFjMc3vzunF6CNv8y3iWUpN3w06uz+/DgSL39Gi1S59RRBgBrAtij67Jp8U4eWzEAk8s8rVkw==
X-Received: by 2002:a05:600c:a49:b0:42c:a802:a8cb with SMTP id 5b1f17b1804b1-42e7c16f939mr21203245e9.15.1726850846526;
        Fri, 20 Sep 2024 09:47:26 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8e69:83a7:a29a:ba83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e7804476sm18172250f8f.90.2024.09.20.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:47:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/5] hwmon: (pmbus/core) support write protected pmbus
 regulators
Date: Fri, 20 Sep 2024 18:47:01 +0200
Message-Id: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWn7WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyMD3YLcpNJi3fICXQMjC8M0U5Mk87RUIyWg8oKi1LTMCrBR0bG1tQD
 hlaBFWgAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=2mrpQYS0durlIiTO7A9inQC+gazq8OIpoYV9W4sUykQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm7acYTDjHdY2+lQrqA+9U5haYmGZr1chOY1lL1
 aO4bPhYN1uJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZu2nGAAKCRDm/A8cN/La
 hZw4EACkpf8HJYhOshPUQ5iG3WA6Is9QFLS8e4Mm8lqstFfgwI9dHMifuXloyVeh5EF8prjJG5H
 gjtogm35QpfuWatiMzVmsHZbR2a9f780GoY262uC+oGDIAspSUcfJG1z74iUwx+LAgF3yRTh/26
 MuG2ban6Yo/+UYW0k/LFm0P7ZiTY4LPqAYXzxmU5fRxw16s5HbwHowlzAPnQYEilgjTOadIlZEQ
 Ye47ALUMeLgkzKg8abEY8foP4wnYc8wcYoPjLebgrYu95RzXxVERFjx0YGxdj5FgZRd/Xt5Ue1W
 zlh3gQ5pC9/fm7G1ljOGxHCm0eAEAbzGhpn09qDcZ8ZlCCcORC3NS3Qk8cEyTAAt3ao9YIOBUzS
 3mQ4864Y9j7SfGovZnmASItmFMvZoCbN6motn4rpT/a+MDboAwxdkSUPTYWUktp2wsVrZWRY3XB
 /ujjQ7JV3U56EGlGOkt5zw2ZeTiSSUqObhAHCkQ/GNYk7yoxvbc5GJmIIliC6xm5y9bYXI+I2uq
 qG0kA3sMiCCHSpQbXWVHS8S4IPlDkS31Gv1qgUPRi4JCmQXHSPYAZQ0oztPY7NVd99NqMmZGoFR
 G3vzQkD8+rwWFeF8eL6NpS4ZxhHt6nikp2xdXO+NdTzNMISPRIy9J4/1Vg6UFgQ9rfo42ValMlp
 LR67zgVzvhchu4Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Some PMBus chips may boot in write protected mode by default. If the PMBus
chip is protected, it essentially becomes a read-only chip. Writing
protected register will be ignored by the chips and a communication fault
raised.

PMBus chips may also provide regulators, but protected chip are not
properly supported, since write are performed regardless of the protection.

This patchset adds callback in the regulator framework for drivers to
perform runtime init, such as checking the write protection status and
adjust the regulator constraints accordingly.

PMBus then make use of the added callback to adjust the validity of the
ops. In the future, PMBus could even use this callback to adjust the
constraints based on the supported registers.

Last, a module parameter is added to allow to set or clear the pmbus write
protection if necessary. These are 2 simple mode, more could be added
later.

The patchset targets 2 different subsystems. Please let me know if you
prefer a respin with 2 patchsets, one for each subsystem.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (5):
      regulator: core: add callback to perform runtime init
      regulator: core: remove machine init callback from config
      hwmon: (pmbus/core) allow drivers to override WRITE_PROTECT
      hwmon: (pmbus/core) improve handling of write protected regulators
      hwmon: (pmbus/core) add wp module param

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 drivers/hwmon/pmbus/pmbus.h                     |  4 ++
 drivers/hwmon/pmbus/pmbus_core.c                | 83 ++++++++++++++++++++++---
 drivers/regulator/core.c                        | 13 ++--
 include/linux/pmbus.h                           | 14 +++++
 include/linux/regulator/driver.h                |  2 +
 include/linux/regulator/machine.h               |  3 +-
 7 files changed, 106 insertions(+), 17 deletions(-)
---
base-commit: cd87a98b53518e44cf3c1a7c1c07c869ce33bf83
change-id: 20240920-pmbus-wp-0281f54b7fe2

Best regards,
-- 
Jerome


