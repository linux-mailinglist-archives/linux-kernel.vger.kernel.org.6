Return-Path: <linux-kernel+bounces-231416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8B91987E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0331C21AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B81922D6;
	Wed, 26 Jun 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEkQI2EY"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F99149E05
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431230; cv=none; b=ck3R8TtajsSibQQRH+4BpjdTHeSoCT02Iqb0Ej5QpbFQaK1eMFelZIp13X2jK3FUFLMab3kLjoESllHidPedhkQYb5Wlj9ccqBLfzy7IIT1gt0sYx9pFYKI4VkGaaXk70Pk95VpxfoV7/rvrtg6UeafJ8IMgBmJA/4DNpH5J9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431230; c=relaxed/simple;
	bh=Kk/sdOY0AWIjXOD+1FiI/rKZwQGT/j7oWsDZLf9XTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f31lCQ0UQcmecWIfRDHyvsvWpS1qxLF6FSpKh0IFtp/KQCTiJyA/zbs+pyaYBfsg+zh1fCGpx8zE2xiyYitp6ne/NPzsW28+/8PFRlHtcBFfITCbrDwR+q//qiTOy1Kvi7qRQv6raBukbN2KHfzl8fpu34SL5v1ZK5GVP/yLffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEkQI2EY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79d5495fe01so56857085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431228; x=1720036028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KlRYq6p5LkP029bKZx9mVcz2J6oFnFhtgLKInBjC3M=;
        b=PEkQI2EYRp+swD6pK1NRJXng4RntKUhI1zNeRH8udOZdrGAiNuldM01nHDjo7QWeXo
         6+Am3C5gu8Ekugk/jXKt1Gf0UdrfXdw/6+RoMbidQxlokMuq3XMAwHqekxDNZvM+VmNP
         37+SptF4XzR2dZxrXhJxR5gaTXKIzH2XlkzCaXT5HnWZPXkxV7rL6r9gVTrqeeFeJxED
         pDJ1HNYJIPtyG76banRFQX/iM/ruCwkj232lqiw50XeoARNhOU6VAZIJxxI3UkxoO4ts
         oT058Faw+cVrUjYdJRuPEd+m5aCkO4UrUqizzS5vcBRjs1tYT2Si9+71l/k+7kshERKK
         NeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431228; x=1720036028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KlRYq6p5LkP029bKZx9mVcz2J6oFnFhtgLKInBjC3M=;
        b=QRhn3O22nvI6FZJBjaTzLgrpuA98OI9lceaIxlkkIawxtFMSC5+AqzzAcOfe1XZTmt
         17eqOlsNYAA1SNoH/53F+PFBoNhBuH54mACs7R4pLa4ydkEhUi87V5cw0vaOma6GXqz6
         kq8P9niLHlgptx8eNu/kP1SN28vrE9wIMnZhTeB6z0pN8zPyPdAizIB7Csa0aroXA4q5
         q+YRAkIUhUNwK2tqcZiQImNlhQ6RlBQBDzDQjDZDMWuuEp7X6wXuafzVKo/bWBpl1rLu
         MUi2M5G/y5WCxJwYr+Og0uQ6gXkOWu3wPS2l7zj6ZnRAG+rGW9qKyQPRKTGAuakRVsoZ
         2nkw==
X-Gm-Message-State: AOJu0YyUF1yXB/GPr/Am7dda1WdhFUeqCTQRe6102S9QlrrYrEnTy3XC
	rVsEEBmPfJ6+/em7ny4Y+GtYRgbRNoFbu87+AVn6rT0nwjGmBNw34enStt0S
X-Google-Smtp-Source: AGHT+IGnBEWNgvDQcr+Fw7YuGmUhVCJXdSp8AWzbPtl59HfE9luhHi13VAdgTrBgWgPn6XmOPUb2Mg==
X-Received: by 2002:a0c:8bc2:0:b0:6b5:40c:f108 with SMTP id 6a1803df08f44-6b5409e0ba3mr125914316d6.37.1719431228257;
        Wed, 26 Jun 2024 12:47:08 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:07 -0700 (PDT)
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
Subject: [PATCH v7 0/4] shut down devices asynchronously
Date: Wed, 26 Jun 2024 14:46:46 -0500
Message-Id: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the ability for the kernel to shutdown devices asynchronously.

Only devices with drivers that enable it are shut down asynchronously,
and this driver setting can be changed in sysfs.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

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

 drivers/base/base.h           |   3 +
 drivers/base/bus.c            |  26 ++++++++
 drivers/base/core.c           | 108 ++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 5 files changed, 115 insertions(+), 25 deletions(-)

-- 
2.39.3


