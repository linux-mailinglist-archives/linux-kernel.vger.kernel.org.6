Return-Path: <linux-kernel+bounces-297947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64FE95BF83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D1B1F2466B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3BE1D0DC5;
	Thu, 22 Aug 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9PKdujN"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18521CFEA7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358496; cv=none; b=XAgvJazYbBoCqfF16X5/e+jwhxQI4fBLKqSrwpmKgI3XatlXK1jnHmMgd1BENBnd5LcoLKpd5uOVW90lbgq7hO0ZxIFJcTgyahWkkM2XtrmnF8322EXbFmksEeS2JqTnwIpeF9n90rUMp5hn7WpwiBHV/WGpi504W1frnDmGvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358496; c=relaxed/simple;
	bh=TRdCqKPel7q/1MHoOydkP58CnRkHirDzfH7Lx5kMZiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SQ1r1EPWW0ohMtvzV9qma8wrUJ53FXE+mZqy7K0gW89+dSB57h55aUYII30Yi5R6LE0zDJy6AXNZIaa/UFB7Iej0wLYPr/pDxa9MbAbOYcNQSMvCSctPAD5V6xLs3TuUVPdXqR9RaMrJKJ9CXZFp3mQnXBkReaaKWeZwjzTjbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9PKdujN; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70944d76a04so835010a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358494; x=1724963294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOL/fNnXaWdoKAkeEncC6MoPhHPgBP4rm3mSsYbtP7M=;
        b=F9PKdujN8pcox+LQ3oPwwlm4OP9z8p/DVlt/tyeWkdvPlqOvCwHltSQRiUu2SUfbj5
         /0Rr6uFeY98zm8kOz56Ye7lwqfuDuVsExYC3RJe26NYmnwTPMsqZelbPWFpGqBjPONc3
         iS3OCwziluxJ1tG/QMS0oOhiwPphVvfK7/suFLDhgPACR2M4YW7UhBayulkRWfpB7qkM
         71XSAIVAR/qqMXpSLxy+2YreE+HZRfmLuByPrWXOWX63plJQua8FKiYLqX+JGnnrV3wD
         h53Ew2KJ7mYXvi5EVgifQxYd+6A2zcrJK02RMKqsFNY4tWR++BU5pMe9e9crpNg3GWbC
         gVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358494; x=1724963294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOL/fNnXaWdoKAkeEncC6MoPhHPgBP4rm3mSsYbtP7M=;
        b=ryn0hrPbP8upKo6FzK4tfNCToHNC+j8B2+GHteiAnjcspmFXf7Hk9ju0KewLLb8waf
         jGYuzwynoFjuc0o8d1qI2q/vkTTdlR48Kr8JfM0fWIJR8yB+3V2eaCOpBjMhf1ReNbbR
         sQ4VNY1T3xs2CYMxIxl5/k7/fMBkh3RW54aSY+dYymB1eF+0VYww2VjHCYidZm+MjDwT
         G5Vu8sQsRcmZXg/ECI5+U+5G8GOE8mKulRddtwHjH2qx5I50UBijKB2AiYu/Q+67PkqY
         TzvR3wVQwpa+r9ZMTASRCqSTGVx/yqgnr0YdeXbhhAyLuPl3/hBCx+jwoQk8+t6hCZz9
         Wmjw==
X-Gm-Message-State: AOJu0YwTQWHV13QJMltOtBoqRTyn1wlRtGyDjbuYIxcaINhqSRYlGVpQ
	rdoMTUqsrAu6EYXEQj/skNrxPkLQXx4xMTLP1OZOFdWNy0LWG+2JyT1kJC/F
X-Google-Smtp-Source: AGHT+IG+b8+rh+weNuQzr3aYdIHNhytmbEf+tbNYhQ48GtEiG9O5RHQ6QpprH8GqE1FOdKK6MYyXgw==
X-Received: by 2002:a05:6808:210e:b0:3d6:2bab:16ca with SMTP id 5614622812f47-3de2a2ca587mr84006b6e.13.1724358493701;
        Thu, 22 Aug 2024 13:28:13 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:13 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 0/4] shut down devices asynchronously
Date: Thu, 22 Aug 2024 15:28:01 -0500
Message-Id: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the ability for the kernel to shutdown devices asynchronously.

Only devices with drivers that enable it are shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Changes from V7:

Do not expose driver async_shutdown_enable in sysfs.
Wrapped a long line.
 
Changes from V6:

Removed a sysfs attribute that allowed the async device shutdown to be
"on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
previously "safe" is now the only behavior, so drivers now only need to
have the option to enable or disable async shutdown.

Changes from V5:

Separated into multiple patches to make review easier.
Reworked some code to make it more readable
Made devices wait for consumers to shut down, not just children
  (suggested by David Jeffery)

Changes from V4:

Change code to use cookies for synchronization rather than async domains
Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
  opt-out of async shutdown (when not disabled), with ability to control
  driver opt-in/opt-out via sysfs

Changes from V3:

Bug fix (used "parent" not "dev->parent" in device_shutdown)

Changes from V2:

Removed recursive functions to schedule children to be shutdown before
  parents, since existing device_shutdown loop will already do this

Changes from V1:

Rewritten using kernel async code (suggested by Lukas Wunner)


Stuart Hayes (4):
  driver core: don't always lock parent in shutdown
  driver core: separate function to shutdown one device
  driver core: shut down devices asynchronously
  nvme-pci: Make driver prefer asynchronous shutdown

 drivers/base/base.h           |   4 ++
 drivers/base/core.c           | 108 ++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 4 files changed, 90 insertions(+), 25 deletions(-)

-- 
2.39.3


