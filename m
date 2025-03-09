Return-Path: <linux-kernel+bounces-552968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FEDA5819D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EFD1680CB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1EC18C345;
	Sun,  9 Mar 2025 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pkPlGYgs"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F6188A3B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508612; cv=none; b=cLn8ckC1Ovr8Tiy53wMdkUqprI95CjOnuAD1jL1NdcfPZ6iiC5yazpS3x3ImS7Yo781fabSa6TJ8BOGNS4QkY8FiZCimYIS2BHCXnwHWBcIQ0WyAdjBDPQYXFnGBPXuItov466dWWuMpkExfQys+qQmMdaVntpIozfcgF03y6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508612; c=relaxed/simple;
	bh=AdePxRkljki58MxaxtSa3w6thvP25nj3BGuStrfBLcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Inx/1QamrzR2qUXNtuvYXe/Gy6+lRmVDY1MQ1Sv6UL8y8g+47GIf4EsUzO/4q1k5me6R8zjGor/L0ZLO1T8XaZaNlbdkLGmE96kgoo3EN1GkFS8G13fg2bRhTRCMG3JHGGZMh5qfl9zOS5WZHA0HoVfQEcAMcvtV4+xZP5YS4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pkPlGYgs; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rBvGte4vv0ogTrBvJtWOU3; Sun, 09 Mar 2025 09:22:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741508535;
	bh=/6lFKfqaWFI3BulJkt+DFvsuCO/g2wx8Ki+YPYJ96Tc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pkPlGYgsf/2sNYgil0P1NmpofZmKMFU/QAMi2gtj+JxjP1k6U92qHILz2AKb/08iW
	 xKAyWuVq3kFEoIaE5Df7TEV5BqSRbKKfv9+2h5Wl3v8U2hRTvQ88LA5GDqmipHHCYk
	 j63t45j59mgTWm2FGKK49R6HBD5l/VzsIfjYlG5E2yv985befwlplGJujtu/vw64kY
	 AXou8+3g3gKLBdvDH8WAe0cXaHtyLz8IMVheQH/ZTodGHS1X5NWQl4N/QGo8k4SuC/
	 ROKxPsQOYft7ITMPZ6UxpYs5zKy6Dq0TYYGT+7roFmOi0zan89mOO7gEtQBhmhabfK
	 zd9LVDIcAWhdg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Mar 2025 09:22:15 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre Ossman <pierre@ossman.eu>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: cb710: Fix an error handling path in cb710_probe()
Date: Sun,  9 Mar 2025 09:22:05 +0100
Message-ID: <25de6764b32724eac554d48d17d23c50bb862693.1741508504.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful ida_alloc() call, it should be undone
by a corresponding ida_free(), as already done in the remove function.

Add the missing call in the error handling path of cb710_probe().

Fixes: 5f5bac8272be ("mmc: Driver for CB710/720 memory card reader (MMC part)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/cb710/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 55b7ee0e8f93..394fc2488029 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -250,7 +250,7 @@ static int cb710_probe(struct pci_dev *pdev,
 		err = cb710_register_slot(chip,
 			CB710_SLOT_MMC, 0x00, "cb710-mmc");
 		if (err)
-			return err;
+			goto free_platform_id;
 	}
 
 	if (val & CB710_SLOT_MS) {	/* MemoryStick slot */
@@ -276,6 +276,10 @@ static int cb710_probe(struct pci_dev *pdev,
 #ifdef CONFIG_CB710_DEBUG_ASSUMPTIONS
 	BUG_ON(atomic_read(&chip->slot_refs_count) != 0);
 #endif
+
+free_platform_id:
+	ida_free(&cb710_ida, chip->platform_id);
+
 	return err;
 }
 
-- 
2.48.1


