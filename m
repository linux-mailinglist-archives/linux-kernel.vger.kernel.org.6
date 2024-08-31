Return-Path: <linux-kernel+bounces-309976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2759672A7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60451C209C0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B8155E48;
	Sat, 31 Aug 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oltdpM7O"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071A219EB
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121488; cv=none; b=NWwvFtbdszAJ8hfN2FdO9ihmqzgQaSR7/o2qUHFcROM5x6pSkusNhudbYYMNk2lZyaQnd2UIy3/zgM4N9R9FMNxBloYAfQcQzLshVc6euu4v+GtDZSTPOM2sBKxvBB1UJG/BfTzhqhhqTW5KK+p/Yu4X6uNZLwN8sFmbyA+e41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121488; c=relaxed/simple;
	bh=tCs3u8U4oWN2NuA+AQctVtTJPmFCLiIYcdDvk/A+34g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auKHOoBmZMsIon/i7lYLSkKmZBhN5GS6jjVHVHjnltFRxBCIunmMTeQPGPW2Z3WdyAgy1CYPme0bNqKISXJ3MW9b+uHzVzf87TEQhZbkFYSp2uZ4stCV7hy2hZ3kXQ64M2JwQp0OErAmm8acEut7k1Kakn8cAs1Nnz4VFl6KjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oltdpM7O; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99712667;
	Sat, 31 Aug 2024 18:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121414;
	bh=tCs3u8U4oWN2NuA+AQctVtTJPmFCLiIYcdDvk/A+34g=;
	h=From:To:Cc:Subject:Date:From;
	b=oltdpM7OYAWn6Qe84sWLU5qJLde9UmSXKI7bZ/golEC3kePBdJzZVzy/HmoLlhKsW
	 ohDZQxIG67yHJtE/nbF8KGNR9aYyNLtlMXso32YbWyNkEJJ5L3HesdbierD7LaAqJv
	 dcdpa7mDCHaC7/hYjk5NttwUNDjBbM7IgBPNQY4c=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/7] staging: vchiq_core: Refactor vchiq_bulk_transfer() logic
Date: Sat, 31 Aug 2024 21:54:28 +0530
Message-ID: <20240831162435.191084-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series mostly refactors vchiq_bulk_transfer() code according
to Arnd's review comment from [1]:

> You can also wrap vchiq_bulk_transfer() in order to have
> four separate functions based on the different 'mode'
> values and have them only take the arguments they actually
> need.

I didn't wrap vchiq_bulk_transfer(), instead created four
differnet function, one for each mode.
This will pave the way to address his second comment:

> Ideally this should be cleaned up in a way that completely
> avoids passing both user and kernel data at the same time.

which is not part of this series and will be done on top as
arguments shuffling will have to fix the sparse warnings
that exists currently.

Patch 1/7 first moves the VCHIQ_BULK_MODE_WAITING logic out
of vchiq_bulk_transfer

Patch 2/7 then moves the core logic to vchiq_bulk_transfer()
which can be shared in subsequent patches

Patch 3/7 and 4/7 refactors remaining bulk transfer modes

Patch 5/7 finally drops the vchiq_bulk_transfer() as not needed

patch 6/7 and 7/7 are drive by patches, noticed during development.

[1]: https://lore.kernel.org/linux-staging/3d3b7368-93b2-4c0d-845e-4099c2de9dc1@app.fastmail.com/

Changes in v2:
- Directly return if service == NULL in 3/7
- Prefix non-static functions with "vchiq_" (appropriate driver prefix)
- Use typed argument for 'userdata' in 1/7

Umang Jain (7):
  staging: vchiq: Factor out bulk transfer for VCHIQ_BULK_MODE_WAITING
  staging: vchiq_core: Simplify vchiq_bulk_transfer()
  staging: vchiq_core: Factor out bulk transfer for blocking mode
  staging: vchiq_core: Factor out bulk transfer for (no/)callback mode
  staging: vchiq_core: Drop vchiq_bulk_transfer()
  staging: vchiq_core: Remove unused function argument
  staging: vchiq_core: Pass enumerated flag instead of int

 .../interface/vchiq_arm/vchiq_arm.c           |  20 +-
 .../interface/vchiq_arm/vchiq_core.c          | 321 +++++++++++-------
 .../interface/vchiq_arm/vchiq_core.h          |  16 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  15 +-
 4 files changed, 233 insertions(+), 139 deletions(-)

-- 
2.45.2


