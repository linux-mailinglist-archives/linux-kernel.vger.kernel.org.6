Return-Path: <linux-kernel+bounces-181267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B598C79C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004AA2842EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFE14D71B;
	Thu, 16 May 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBkYbJbn"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439C14D714
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874577; cv=none; b=ky1nHcbScKGukGFYco2YePgVVoJwJeu+xVgzUycghjQk6k2vQRhZlT4vJFWyNtao7oadC4cOn/5DZE91WOgK0Gnne551ZNtTfRzBKl1ZIgSJ0yZJSOlCJfnowCavxyD7AIm30MYDCF9qvHDb0vpU7ZB17OVrkdPYCYZax6wpbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874577; c=relaxed/simple;
	bh=yk+EoJOxQvksEAev5AZpxeCIM2ulBu2RSgjkPWEiAbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgPv+jIgWlgoZp7apAtupvJ88Tua2A8Dl/vtK9r/yL07wIKlK8NKM0KhtONYdaeVMOKB+TPSEBplbmaNy6MYKTkvw/VCSb9IajMTJnLa2slMIJkgxfxbUC/5BiBnHNaotAYPfutrWUi5U0JRnlkWiwMWqh8GGOgcrbsP7ZTRv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBkYbJbn; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c99d0521cbso223259b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874574; x=1716479374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZODEtoePHUvziuRfhdaaoUIRaMRicIhK6wIEY1B51+Q=;
        b=jBkYbJbnO+Dl91VNnCHKDryJZ8q/i1Me3m8aH+2aZTHeegJ0r+GSZ4AGPRlLDdZJWZ
         qq8nirE4cdycOU03+tOP9V0WbZPfhkXajwQrIldYmI4t4+4CZ69OZIiX9UWhoJG3CJI0
         TJ7TQFJ3T0OstfmK2uAs6ck5CsCQxu22HA0WQ+IxiqPuVHa2QBOhXVamCdZda+PPpN8H
         QllqgDFzwIdumUe4Zet5WcTSh7E5CeZI17u/bAnPhLH0lKUOstlYFS5xI9e36ysK4UgF
         fyYS0+M+Q/F7t0MXTaFcS/nUA7ThBmKAQkIPXQaWV4HN44MQDevXbdbG3TGyYhTp3msv
         8IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874574; x=1716479374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZODEtoePHUvziuRfhdaaoUIRaMRicIhK6wIEY1B51+Q=;
        b=iBP4wzS8X7oXXqyayp8X+qjWUCYkGYUYlaJ1nj9WF+0o/aMmoTgHsBIcIbryYaCLHd
         YG1bSyhXsocIT2V/UzJL77iDvdCsUEFb6L/J61YIulHzUdkWi96P07+a9pf3fIMtuvX+
         BUfUyQo45DuPrFmquDwtICncycHAr3IdTbgglZA3CAXU7F4pyZe0DDK8lVZ4UcM+L7K7
         BXmXV2hViD0dvv0RxyY5eDUeRYpH3aPP2ggRcC0yzmRFKYlCcA+Ewiu8MiJOmD7vCuDK
         erkqeJm8UT5hgSrRtSXzgVxYxI5Jq5Et5tMS5PnaQEKtWt1QjDZ3CkZaYXFSvpj98z1k
         cH4w==
X-Gm-Message-State: AOJu0Yz5PWju3eoBZKEdEbCmiUOsnz52/hhR8ZMjljA0NoNG3O/rXjW+
	Tl7DPeSfew7o/nTk1UMUq1Ojjai0o8lZaHa8KWdeogBX2ry19Alc9OydEZP7
X-Google-Smtp-Source: AGHT+IF6t54ePxZMF2EPjr0HgtmTRNEuOe/2crHF3bicO9KN5F/1a0XF86D7UMPfJp9Y8ddQhiMDRg==
X-Received: by 2002:a05:6870:2f11:b0:22e:d13b:c13d with SMTP id 586e51a60fabf-24172a70ac7mr22479435fac.18.1715874574490;
        Thu, 16 May 2024 08:49:34 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:33 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 0/4] shut down devices asynchronously
Date: Thu, 16 May 2024 10:49:16 -0500
Message-Id: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the ability for the kernel to shutdown devices asynchronously
(this is V6).

It is in "safe" mode by default (where only devices whose drivers opt-in
are shut down asynchronously), but it can be "on" (where only devices
whose drivers opt-out are shut down synchronously), or "off" (legacy
behavior).

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

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

 drivers/base/base.h           |   3 +
 drivers/base/bus.c            |  47 +++++++++
 drivers/base/core.c           | 185 +++++++++++++++++++++++++++++-----
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   8 ++
 5 files changed, 218 insertions(+), 26 deletions(-)

-- 
2.39.3


