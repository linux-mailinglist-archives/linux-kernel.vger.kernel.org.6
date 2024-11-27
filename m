Return-Path: <linux-kernel+bounces-423393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB189DA6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C0B164A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869F1F6679;
	Wed, 27 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="alf0PTOG"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC61F4735;
	Wed, 27 Nov 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706544; cv=none; b=U5F/r0LQJxqZSgIJwA2/yexrg/uegMWmbxagequLq6WIaz/dwLv8OGUZ8R15BJp/byL5hsHWl2Z9kdPZsq5XdXynr2RxO88w0BVRCCEBVEXJLI6k87hYUUoFvmjV9N7EO9RWGKQgEnurI1WuAqrS4LnSYVx0Woue738xeX7djPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706544; c=relaxed/simple;
	bh=tSV3HOFFBdh9P0hRuhEtN0I2z+DLXZWaa6f95IsG/+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isW2YxrNZ7+vX4joUeo2Q8ayq8O/0HZ7X3bTPf8qosFzWaIXF2FaFTyRHk9HNz1sesw0wHkjZTIBZp9EsLp/Z4GMpxVERxlPtjAiSKWlCq8FoL7VkqLJLxqSrP7NdHrxoKFIY/uAnK9w7ac6zmg3+2xv/Et8N/lg6RbOVsHKFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=alf0PTOG; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e59944.dip0.t-ipconnect.de [217.229.153.68])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 4F0DC2FC0052;
	Wed, 27 Nov 2024 12:22:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1732706531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z708NEoaWXkhSvxJclBk16ByWS4EDMXM/K/P8Pjev/g=;
	b=alf0PTOGc7atMAJQWrUHPgC5mVf28NBqowXrn+bhkRczWrQGZNNrT9b+ZN535Az0W9CJ3x
	Y7w5q5Pozx6IUHOErh10WhLIqR77b5JnZKgUGPVey/o4UgNqdzuUXGljs3dPuFeqm50yYG
	KCTnLHQ8DYdHD6oWlJVI2fl3pVajcdQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [RFC PATCH 0/1] platform: x86: tuxi: Implement TUXEDO TUXI ACPI TFAN as thermal subsystem
Date: Wed, 27 Nov 2024 12:21:09 +0100
Message-ID: <20241127112141.42920-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Following up to https://lore.kernel.org/all/172b7acd-4313-4924-bcbc-41b73b39ada0@tuxedocomputers.com/ and https://lore.kernel.org/all/f26d867e-f247-43bb-a78b-be0bce35c973@roeck-us.net/ I experimented with the thermal subsystem and these are my results so far, but I'm hitting a bit of a wall:

As far as I can tell to implement "2. As long as GTMP is > 80°C fan speed must be at least 30%." I would need to add a new gevenor, lets call it "user_space_with_safeguards". I would be nice when the temp <-> fanspeed relation could be passed via the thermal_trip structure. And safeguarding the hardware from userspace only works when I can restrict userspace from just selecting the preexisting "user_space" govenor.

So my ideas/questions:
- Add a field "min_fanspeed_percent" to the thermal_trip struct that will only be used by the "user_space_with_safeguards" govenor
- Add a "user_space_with_safeguards" govenor that is the same as the "user_space" govenor, but on trip, a minimum speed is applied
- How can i ensure that on further speed updates the min speed is applied to? I could just implement it directly in the cdev, but that would be spagetti coding around the govenor.
- Can I somehow restrict userspace from using certain govenors?
- I'm a litte bit confused about the thermal zone "mode" sysfs switch, here it says deactivate for userspace control: https://elixir.bootlin.com/linux/v6.12/source/Documentation/ABI/testing/sysfs-class-thermal#L20, but what about the user_space govenor then?

Best regards,
Werner

Werner Sembach (1):
  platform: x86: tuxi: Implement TUXEDO TUXI ACPI TFAN as thermal
    subsystem

 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/tuxedo/Kbuild            |   6 +
 drivers/platform/x86/tuxedo/nbxx/Kbuild       |   8 +
 drivers/platform/x86/tuxedo/nbxx/Kconfig      |   9 +
 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c  |  96 +++++++
 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h  |  84 ++++++
 .../x86/tuxedo/nbxx/acpi_tuxi_thermal.c       | 241 ++++++++++++++++++
 .../x86/tuxedo/nbxx/acpi_tuxi_thermal.h       |  14 +
 8 files changed, 461 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h

-- 
2.43.0


