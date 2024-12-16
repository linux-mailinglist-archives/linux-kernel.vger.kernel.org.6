Return-Path: <linux-kernel+bounces-447248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7969F2F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84D9168371
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1B204C23;
	Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VJYpRBf/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FC204593
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348786; cv=none; b=GspnnDmALvTUbtl96M3bLjInnttBuKdnJKYGN12nvIzb6Y4Qs7PhxXkrat1EK1V7pGFxYJvgHViwpmvpHdtO3T7MroMNXC/ukIngl5Dbo7tgEN5FOla3hdZikA1A9SUsUc/L9NDEt0Hx+w13jnmO6n4hpsniRILfXfaM0/A65yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348786; c=relaxed/simple;
	bh=t7pJU+zOrMxzGznZZK6jgbYcDt86FBsy6BKBXTbxQIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KC44ynL0SKPTgu7OyDYM6TTWbhjjjYNLpd6jlDtD2dx4Aw+GI/HMump4dx5msbPG3T5ZMDeHxK7fb2X9h77YOB4VJNZc59it1sOFd1jAFWsk3l5+6R4Nvab/oAPGeM8FPYa7k4MF/xUKmoUZGg70AUfqJJzuS5UEtXzeLX2jt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VJYpRBf/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348781;
	bh=t7pJU+zOrMxzGznZZK6jgbYcDt86FBsy6BKBXTbxQIE=;
	h=From:Subject:Date:To:Cc:From;
	b=VJYpRBf/mX/RFpDGf4XRAp1JTtLOGdmhT2o6UYgpZOzzA7Cqn7c7htV0UJc8Hwtww
	 XKcH2ceS4A34mCOKimcheEJi6JAdcVAUZ04t3x2+boN0vifXz21EZ2b+NdfvBb6L9H
	 y+SUyVU3+8Ate1SDLIZM1NBTL+dvL1qN3Aa6QzZo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/9] misc: constify 'struct bin_attribute'
Date: Mon, 16 Dec 2024 12:32:55 +0100
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOcPYGcC/x3NQQqDQAxA0atI1g00URF6lVLKOBM1i44lGaRFv
 LuDy7f5fwcXU3F4NDuYbOq65gq6NRCXkGdBTdXAd+6IqUf/++QY1+wFR83vUIrhRz1iMt3EHAc
 moi7w2KYWaudrMunvejxfx3EC1Jd04nMAAAA=
X-Change-ID: 20241215-sysfs-const-bin_attr-misc-drivers-721114a2b3d3
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1424;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=t7pJU+zOrMxzGznZZK6jgbYcDt86FBsy6BKBXTbxQIE=;
 b=pU7PD+Em4rbI5+JAE+WiwYi6iWtXa2pUQImMJ077OagtWFVOYt1hDrO/5tWFOC+dXBky41atT
 lxw8VskRN1KCt53uR9b6JUCxs97fEorX+/8M3HgSmCOLbquDKf3bWmd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (9):
      ocxl: Constify 'struct bin_attribute'
      cxl: Constify 'struct bin_attribute'
      misc: sram: constify 'struct bin_attribute'
      misc: c2port: Calculate bin_attribute size through group callback
      misc: c2port: Constify 'struct bin_attribute'
      misc: pch_phub: Constify 'struct bin_attribute'
      misc: eeprom/idt_89hpesx: Constify 'struct bin_attribute'
      misc: eeprom/max6875: Constify 'struct bin_attribute'
      misc: ds1682: Constify 'struct bin_attribute'

 drivers/misc/c2port/core.c        | 27 +++++++++++++++++++--------
 drivers/misc/cxl/sysfs.c          |  8 ++++----
 drivers/misc/ds1682.c             |  8 ++++----
 drivers/misc/eeprom/idt_89hpesx.c |  6 +++---
 drivers/misc/eeprom/max6875.c     |  4 ++--
 drivers/misc/ocxl/sysfs.c         |  4 ++--
 drivers/misc/pch_phub.c           |  8 ++++----
 drivers/misc/sram.c               |  8 ++++----
 8 files changed, 42 insertions(+), 31 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241215-sysfs-const-bin_attr-misc-drivers-721114a2b3d3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


