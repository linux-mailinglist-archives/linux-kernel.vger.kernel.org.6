Return-Path: <linux-kernel+bounces-198165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADA8D745E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64A51C2091E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0629CFB;
	Sun,  2 Jun 2024 09:02:54 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDC286A6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318973; cv=none; b=uZTcFCkglNGS3RB4tz6wpO5iEzqBY6nq9nCxDf5pFip5e6c2gsGMw373648TEv4GxpazPJeV/dYiUzzaGXfqFNiPoa2TghyiuWo7UQ3NjiafF7gEGYwG+oP+9SjqYL5/kx4Ad2KE62RDjTYPFxdtOJMXEK4WBYPnJgPPQAV0k9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318973; c=relaxed/simple;
	bh=kvjM+fA8m/X7nFchC9GtlIpylkN/zyU5xhYjmg6++aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbPiIkQPMI8M+whz0ksXaTfPAb2y7geQMW1Mj1XlDiQiBc3X1YIaG8yrDU13pzSJl8jQhjR3KV30m2R3RxhsoNbEF934nhRFIaeIOLzXKtu/JouKwg5bygjo2cGNAIbhcxPsQguyob2Pn7WxS22VGgxtEEdkXl8zwONAn87MHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id e0b351d6-20be-11ef-8e3d-005056bdf889;
	Sun, 02 Jun 2024 12:02:48 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	Li Zetao <lizetao1@huawei.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-input@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Mark Pearson <markpearson@lenovo.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH v1 0/7] platform/x86: Move to 2-argument strscpy()
Date: Sun,  2 Jun 2024 11:57:53 +0300
Message-ID: <20240602090244.1666360-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move to 2-argument strscpy() to make code shorter and have an additional check.
No functional change intended.

Some cases are let untouched where it looks better with the 3rd argument.

Andy Shevchenko (7):
  platform/x86: asus-tf103c-dock: Use 2-argument strscpy()
  platform/x86: hp: hp-bioscfg: Use 2-argument strscpy()
  platform/x86: intel: chtwc_int33fe: Use 2-argument strscpy()
  platform/x86: serial-multi-instantiate: Use 2-argument strscpy()
  platform/x86: think-lmi: Use 2-argument strscpy()
  platform/x86: thinkpad_acpi: Use 2-argument strscpy()
  platform/x86: touchscreen_dmi: Use 2-argument strscpy()

 drivers/platform/x86/asus-tf103c-dock.c       | 10 +++++-----
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 18 +++++-------------
 .../x86/hp/hp-bioscfg/int-attributes.c        |  7 ++-----
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 18 +++++-------------
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 19 +++++--------------
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     |  3 +--
 .../x86/hp/hp-bioscfg/string-attributes.c     | 12 ++++--------
 drivers/platform/x86/intel/chtwc_int33fe.c    |  6 +++---
 .../platform/x86/serial-multi-instantiate.c   |  4 ++--
 drivers/platform/x86/think-lmi.c              |  4 ++--
 drivers/platform/x86/thinkpad_acpi.c          |  6 ++----
 drivers/platform/x86/touchscreen_dmi.c        |  2 +-
 12 files changed, 37 insertions(+), 72 deletions(-)

-- 
2.45.1


