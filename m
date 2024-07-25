Return-Path: <linux-kernel+bounces-261984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F115E93BEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDA3283D86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147F198821;
	Thu, 25 Jul 2024 09:21:29 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166681E;
	Thu, 25 Jul 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899288; cv=none; b=axLTSr6JpztdcgaXzWy/W0AfFF2D9dGXvyN7egSj54ySshVGvDpZI2yQdpjLjlY7L0xv1FCWY9jQ+Kf6wuw8BsibuDncBZluNaILCPTMgo8W48HEVqG0D+y2BmxggMslVVoWlh30DgBnaOgEoCPsM119Vj0iN5ESQHiU1xXbGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899288; c=relaxed/simple;
	bh=WKtd/flgo3bItka/YxIm4R4RSxCucfVmVzb08YKF3n0=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=SiIrwc266hKr2d4L/mKzlXd1/z87ar/T9ekwiQ1dx9QU4s9/+d5v5iuUiO4WJ16oCarMfSfssbneINMBxJSxI+QXxflPGsjmNrvnILh2sqJxV1Rksh1doZbVpLDU/eVH0VEpKagVThVsR+sYxsR/UAFcjSHN5fLItbvzPxbRrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68624.dsl.pool.telekom.hu [::ffff:81.182.134.36])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000073A7F.0000000066A2190E.0018F377; Thu, 25 Jul 2024 11:21:18 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v4 0/4] platform/x86: ideapad-laptop: synchronize VPC commands
Date: Thu, 25 Jul 2024 11:21:06 +0200
Message-ID: <cover.1721898747.git.soyer@irl.hu>
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
Changes in v4:
- Handle the return value of devm_mutex_init
- Link to v3: https://lore.kernel.org/all/cover.1721294787.git.soyer@irl.hu/

Changes in v3:
- Use devm_mutex_init for vpc_mutex
- Link to v2: https://lore.kernel.org/all/cover.1721258854.git.soyer@irl.hu/

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
 drivers/platform/x86/ideapad-laptop.c | 284 ++++++++++++++++++++++++--
 drivers/platform/x86/ideapad-laptop.h | 142 +------------
 drivers/platform/x86/lenovo-ymc.c     |  60 +-----
 4 files changed, 277 insertions(+), 210 deletions(-)

-- 
2.45.2


