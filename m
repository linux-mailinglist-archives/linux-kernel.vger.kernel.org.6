Return-Path: <linux-kernel+bounces-343543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF3989C52
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A19D1C21367
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624317BB3E;
	Mon, 30 Sep 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lzh8c/h4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02B17E918;
	Mon, 30 Sep 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683938; cv=none; b=HN8rU01ztTmT8utFKY5qp5et9YYVGON+deBWDXFcDipuPg7JZwT7gtPNEAuJ/tKw3kVuE4N65yBIvH0TAAh8QCyg5FnDpuuNRNmZC7dLTpoouuYd1TAuOLEKdIdjXJkTrjcYRIRr+ORhNWmd9QJQvmhNBgD9IDATWU+tUvM5cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683938; c=relaxed/simple;
	bh=k0inenRsQdLM8kjq3Vtb89hksJy4Iy07Cnuk6LFCDH4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ufjvljBA+7ehiRes86GGxooop+EAS72QUkbCY1MwgjgnkwkqsvVB1IGptccfbk5ZGUPaFar2oHwqzcoaqlSKlI+srQx6p2WQeDrRZ27yzfZFDGDJ9hCezqmvXdHi4QQofM0B6OTSPohYIe0OwrRh4jWcC2vSOfQbU0if5nT/ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lzh8c/h4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A309620C8BDC; Mon, 30 Sep 2024 01:12:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A309620C8BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727683936;
	bh=Uo3K65bEBS5TlGxxZy7heiLcFXhjzPHT12XW0+LyZ0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Lzh8c/h4vo1mETkUnpofDZKY2W81d5W3M0vHZNE/Lj1zUr3LdWAQSuMdSVd6iRQVS
	 EWmA0EyBpgXjAYoqVmdloZXBKfktWjtIBNgKTdPXqCTH3BJS7Fw3sy7cAJf7dpRqdi
	 NyhtlniDpSIaeh6Pth72CDZzD1SGP9X+LhCwdpKg=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	mikelley@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v2 0/3] Disable Suspend-to-Idle in Hyper-V and Fix Hibernation Interruptions
Date: Mon, 30 Sep 2024 01:11:54 -0700
Message-Id: <1727683917-31485-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

It has been reported that Hyper-V VM users can unintentionally abort
hibernation by mouse or keyboard movements. To address this issue,
we have decided to remove the wakeup events for the Hyper-V keyboard
and mouse driver. However, this change introduces another problem: 
Suspend-to-Idle brings the system down with no method to wake it back up.

Given that there are no real users of Suspend-to-Idle in Hyper-V,
we have decided to disable this feature for VMBus. This results in:

$echo freeze > /sys/power/state
> bash: echo: write error: Operation not supported

The keyboard and mouse were previously registered as wakeup sources to
interrupt the freeze operation in a VM. Since the freeze operation itself
is no longer supported, we are disabling them as wakeup events.

This patchset ensures that the system remains stable and prevents
unintended interruptions during hibernation.

Erni Sri Satya Vennela (3):
  Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
  Revert "Input: hyperv-keyboard - register as a wakeup source"
  Revert "HID: hyperv: register as a wakeup source"

 drivers/hid/hid-hyperv.c              |  6 ------
 drivers/hv/vmbus_drv.c                | 16 +++++++++++++++-
 drivers/input/serio/hyperv-keyboard.c | 12 ------------
 3 files changed, 15 insertions(+), 19 deletions(-)

-- 
2.34.1

