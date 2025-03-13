Return-Path: <linux-kernel+bounces-560431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9DA6040E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD503BFDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941B1F7075;
	Thu, 13 Mar 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="lxTsu9VQ"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBB1F0997;
	Thu, 13 Mar 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904055; cv=none; b=DHWq8QgCz8UoLdBLtWnUJp6zqu2fYoeGE47QmejanRblGN3JYVmCawf5txminq9rB7KUbooLQxwMHcsUZEVj0tAaHDw7TT533xgAbsnEC78YbaEPtmcQj7FJfvRxdV8g0MezGEBi/HKp8KjEPg0DoRaJT/fuXKQCQShUyNBkSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904055; c=relaxed/simple;
	bh=5cxPn/75m3XRR+E20jeNhdftA5AT4gdrF6Cdsp/4FzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkKmhcnm+IZLXnkY9tdu/3fVFuCXxIfagqEB4Bynz98I0cvHrtfsHW8wWloJzL38i87IWmQK+OznPk7bJ4Ma+5M/ib9KYGg2B/mKiFB4jkeo/0N6QjglgMRE/XmG75o7m6dsCsBY8agkxthMjTf5uDti/wGLzXLT5v2iPkAekCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=lxTsu9VQ; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id D5C972FC0189;
	Thu, 13 Mar 2025 23:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741904049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zUy9cl/gW8z3r11PhmsWB7a4yo97QwH3OIshsRaBcIc=;
	b=lxTsu9VQs9tN2c6pky2GVWT8kWcJtrMTqwsNqw/3EfIsd+Zd4/03sYtDMMfCHJ2LV8uuDj
	y4iisw6YJ1Veiunj5K/6z7jl+3iyjLTVRED798Z4Zl4KCh7YjfdkOM1lqYQKyPsp3ugcOP
	Zqm1k8ww2DwA6cKOnincQKvjkiy74aM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v3 0/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN via hwmon
Date: Thu, 13 Mar 2025 23:09:56 +0100
Message-ID: <20250313221407.644349-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static assert Ilpo suggested is still missing, but it is fully functional
and tested by me.

v2: Coding style fixes
    Different safeguard values
v3: Coding style fixes
    Add cover letter

Werner Sembach (1):
  platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN via hwmon

 MAINTAINERS                                  |   6 +
 drivers/platform/x86/Kconfig                 |   2 +
 drivers/platform/x86/Makefile                |   3 +
 drivers/platform/x86/tuxedo/Kbuild           |   8 +
 drivers/platform/x86/tuxedo/Kconfig          |   8 +
 drivers/platform/x86/tuxedo/nbxx/Kbuild      |   9 +
 drivers/platform/x86/tuxedo/nbxx/Kconfig     |  15 +
 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c | 591 +++++++++++++++++++
 8 files changed, 642 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c

-- 
2.43.0


