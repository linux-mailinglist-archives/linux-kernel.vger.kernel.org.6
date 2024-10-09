Return-Path: <linux-kernel+bounces-357659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E619973DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF51C238C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490831A4F0C;
	Wed,  9 Oct 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyxu2X9v"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C73183CC1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496676; cv=none; b=malfjWYOTgl+JqJxGQLCX/Mo5dCEepF/ViMNvC9RFLdGJxx9nf9MQ3ZAfA32ege2SIi53xV8pO6V2EVJRS3uKnoHQK7QnDKoFZLdrlwteBkxVziD+0AieATvWGCl8NQZGf38bdah+fHDxGBrFMX+nOkpUpoCegfB0LkXBjsbINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496676; c=relaxed/simple;
	bh=rEKwnShINlaJtTLMDchQOv3GYkazVeGX89HlDoEbU38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRWvUASyhqJW4XBbi9nSB8554OlsiWo3cGlE5UZAqbOFdtfZdwao1A7+kwbseiFU0OVnrllva139DwMw1DqRvshnsZ+bhLhRCU76ocu7n1EMKDzTgSr6POBlXLKwvjljLzZ5z6XQQVA2USr6Pfyyn/Qn3vAystOi8+yIQNq6B4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyxu2X9v; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e5568f1b6eso25943eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496674; x=1729101474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8vdUqTwAeQy+DBjPCY8gBIxE4oT4FIOu6arJHu9ptk=;
        b=Nyxu2X9vmsOgKv/bo4NH+HqybelT1S35qwUgsLstsQWkqh7C9So6pxEKvfYX7fmHoh
         9Zb0A7tDDoEhRy/LGfxePShTzHLhYgDJWqkHTmn6PdNUSlS1p6JyIs25VrylY7LdWuaf
         Q1g8WJxKEXdluKepQ1zmhWso7rc17YkhYXbHgZEYRXQXKbWLy8Vsn2N51NjsmYYYEnEq
         f/No4CHIbsnl7MlTI1Vth7wvrFDI2ZOEb8lS48QwQfpOxytpdUnCYGw0x7F113SzlUFX
         vjEo6qhoCgQNjZHb/1RWsqy8B7eZTpWyeJhlG+jHf3Nogcjl/6g0Argd1VxB+W2ITPNx
         nNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496674; x=1729101474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8vdUqTwAeQy+DBjPCY8gBIxE4oT4FIOu6arJHu9ptk=;
        b=AIL38Sj1RdMhkGsGs8QdanscX1V+lN/Ue0HoUcv2QI2hZWCbopxG2GZfFgsfFeoBPw
         I/Mp7YBqpaqhUvB/DhFS2mVf7Eao2O4siVVMICuO2YkC2EBJHRZfnA7jE34cHOuoRDD+
         08A8KOmGNMbhEwOT1YHH4obAYGVfqNx/dKe21fHRNldj2M5WalZs2eGYWzX8atVIHMe3
         MqshUeKsSdpCh3PwH25ZNCadI+vtKr5PG0XzOKi1xK600ckJgmiBZb/z4/BhZcXQEp7S
         mmqlU4V/3vQSldQQrn9GiLKQ5F12YgdYcXwcJILSMonYMf0GEwbONYDeY6R/PuLin7uc
         q5DQ==
X-Gm-Message-State: AOJu0YwPj35gtZy/vgta3GI8x6nbQ/BLrjnsUq59BaoWdJBXbKM29MTG
	zqRpboe/MhNJBZlRckCGez7inQjPtNJD9VUcwXlzm9kmGbSyBw4aWsubNRed
X-Google-Smtp-Source: AGHT+IE84LUL0LOcNOeXvoKlVeV0GFii2lBodn4kkLieI5aprfMaZbaKqPhVzXLAGZl2YkmHz7QHsg==
X-Received: by 2002:a05:6820:16a5:b0:5e7:c504:1fba with SMTP id 006d021491bc7-5e98794421fmr2401442eaf.0.1728496673825;
        Wed, 09 Oct 2024 10:57:53 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:53 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v9 0/4] shut down devices asynchronously
Date: Wed,  9 Oct 2024 12:57:42 -0500
Message-Id: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
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

Changes from V8:

Deal with shutdown hangs resulting when a parent/supplier device is
  later in the devices_kset list than its children/consumers:
  * Ignore sync_state_only devlinks for shutdown dependencies
  * Ignore shutdown_after for devices that don't want async shutdown
  * Add a sanity check to revert to sync shutdown for any device that
    would otherwise wait for a child/consumer shutdown that hasn't
    already been scheduled

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

 drivers/base/base.h           |   4 +
 drivers/base/core.c           | 137 +++++++++++++++++++++++++++-------
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 4 files changed, 118 insertions(+), 26 deletions(-)

-- 
2.39.3


