Return-Path: <linux-kernel+bounces-256084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D99348C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41751C21A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74A763EE;
	Thu, 18 Jul 2024 07:28:03 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE02CCA3;
	Thu, 18 Jul 2024 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287683; cv=none; b=E63wViizIzlcNUUZny7WcA0CJPi+fnVBE2zQpjRXBOZ4TzwOIOdBbXe4OA6R2nUFWlVmAxLtXdx6gRAG4sCRkIX/qTVck6+HZRk/g80QtA3u6SRp9MPuP0kbI5gOlIv9B7k3JFbTCAVtKbbYlnsETehYhJ1N4epUKPyCXcFy5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287683; c=relaxed/simple;
	bh=gHcKbXQeJUtqj8PsttSiotzt+RzsgFPOEOQgP/h40hE=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=NfrvH90SbQcsKx9iax0Reg6If/1skZsQf3Jb3xq0XbJ/lA6fcqTvmHQTtqf3g0wLZPMw+U+EVQb3Dw/Ztd3uD0Yld3ajmHPtIp6q53pOWd5yOHjxX6HyRgNKZNIoHsshA5iwYAev+JvyT3+4DBMYYsl3AiDTjL9OFe/eW4kQXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.. (netacc-gpn-104-115-214.pool.yettel.hu [::ffff:91.104.115.214])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072DAD.000000006698C3FE.00180BA5; Thu, 18 Jul 2024 09:27:57 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 0/4] platform/x86: ideapad-laptop: synchronize VPC commands
Date: Thu, 18 Jul 2024 09:27:12 +0200
Message-ID: <cover.1721258854.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi,

Sometimes the Yoga mode control switch did not work properly on my 
laptop, and sometimes even caused a platform profile switch. It turned 
out that it was caused by a race situation, the lenovo-ymc wmi notify 
handler was running at the same time as the ideapad-laptop acpi notify 
handler, and the partial results of the VPC calls in the two were mixed 
up.

This series introduces a notification chain to receive YMC or other 
events, moves the EC triggering into ideapad-laptop, and then introduces 
a mutex to eliminate the problem.

Best regards,
Gergo Koteles

---
Changes in v2:
- Skip the already merged "platform/x86: ideapad-laptop: use cleanup.h" commit
- Based on the WMI driver development guide and the dell drivers,
  introduce a generic notification chain
- Use the notification chain to send the YMC event from lenovo-ymc to
  the ideapad-laptop module
- Move the ec_trigger module parameter to the ideapad-laptop as well
- Mutex changes go into one patch
- Link to v1: https://lore.kernel.org/all/cover.1720515666.git.soyer@irl.hu/
---

Gergo Koteles (4):
  platform/x86: ideapad-laptop: introduce a generic notification chain
  platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
  platform/x86: ideapad-laptop: move ACPI helpers from header to source
    file
  platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands

 drivers/platform/x86/Kconfig          |   1 +
 drivers/platform/x86/ideapad-laptop.c | 282 ++++++++++++++++++++++++--
 drivers/platform/x86/ideapad-laptop.h | 142 +------------
 drivers/platform/x86/lenovo-ymc.c     |  60 +-----
 4 files changed, 275 insertions(+), 210 deletions(-)

-- 
2.45.2


