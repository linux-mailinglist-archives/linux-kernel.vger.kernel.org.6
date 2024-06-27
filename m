Return-Path: <linux-kernel+bounces-232645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE391AC41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAE4284DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443019925B;
	Thu, 27 Jun 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="EmUsvlBW"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AD199244
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504344; cv=none; b=C2eRgMJW4rUupkkxGh7CL1yV4skFMRYzPQkAKpIJ+BkX90XYJZPoL2XLcBArI7G/LHoklDbg7LJjLwxItWGucavmoQKJ9X5g0lgjyzU4R90UBQn7T2TjTNddEFIIayhvexr+cPaHSwkw5WqTplCKvyrpAlIOwYp3+5qwl5ssJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504344; c=relaxed/simple;
	bh=t8JMjJ76rZOb873b3fDyoyUyWSpHdVrcU7ehVUjnDz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KDnZZHAzSmXfYb9SlIhuN9yrgHxKBxjQm7CdM3WKR4BYHGYrxJUV6Nz8EakKU57x6DansmPqSPcAcx6o+1T7vOQp01RiMOdfPztpM6gxurPYHWHjk44fbn+k8Q9qWEMhjTfokMfc1G2xZAbTPZJRjzIwBb7mhecoT0HdhTrvi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=EmUsvlBW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0134F1C0003;
	Thu, 27 Jun 2024 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1719504336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QYwKfFuVfEDPUbH/nDNtXwE5eA7qz9E/MbTLiVp289E=;
	b=EmUsvlBWgEiVANm8K9Fi8pD1RXmP27VRkftq/qwSAjmLaeyy/wMms0/7wVmkDrXK3j3MgB
	I02o3Dp9QZkDbA+sSYADmZEQclrTEL8bNgBfveOdOo/7EmnlXdH0ZMxEVxSGYuszTgNlPL
	PKwB1BJRkH/3lanNoYwsBSMXU24JltgxdK+D7VaBfce0Lj1Aqy3nehxtw5OC3/IHvNzR4F
	c6Lm9QLrHMWgak3i+A03bFqOzmb3xa1GFM1VgQUWYATogSWWAFN/5ThZA6z9mGTCvQ5mVb
	BFEwI3bl56V72rSZnpn/3SAfX6l5KQkAoktdVNaxSULOHevrUarZ+jXbfZvLzQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v2 0/2] M5441x: Add NFC support
Date: Thu, 27 Jun 2024 18:05:27 +0200
Message-Id: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMeNfWYC/4WNTQ6CMBBGr0Jm7Zh2LAVdeQ/Dgp8BJhFKWiQQw
 t2tXMDle8n3vh0Ce+EAj2QHz4sEcWMEuiRQ9+XYMUoTGUiRUZYUfqYwey4HHNsah7pNjdEr5sR
 0q0zKlFuI28lzK+vZfRWRewmz89t5s+if/VdcNGq098qaXGVNVtrn5gK/5ep8B8VxHF8rSPP8u
 wAAAA==
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Stefan Agner <stefan@agner.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719504334; l=1121;
 i=jeanmichel.hautbois@yoseli.org; s=20240608; h=from:subject:message-id;
 bh=t8JMjJ76rZOb873b3fDyoyUyWSpHdVrcU7ehVUjnDz0=;
 b=VNCOj7wadn5JCWvm8OagpcjDUGBmF5ihMkyIumXpLLsXZA/gvFqHr/GYymChR49vwqMW9wWcn
 on5g/GPeG1yDg6dJ21SmbjJlMApqGfaNXsjr9JoxdwSk0Qsm0U4kwB5
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=oMZuYhJzT0j5MI73RlNUVYaA8VdWpFR/Sao0JKz1D2I=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

The M5441x has the same NFC IP as the VF610. It does not support
device-tree, so a few changes are needed in particular at probe time.

A new variant is also needed as the Reference Manual states that the
NFC_ROW_ADDR does not drive CS.

Tested on a custom board with a Micron RAW nand.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Changes in v2:
- Removed uneeded ifdef
- Split the m5441x definitions in a separate patch
- Link to v1: https://lore.kernel.org/r/20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org

---
Jean-Michel Hautbois (2):
      arch: m68k: Add definitions for flash NFC support
      mtd: nand: Add support for M5441x NFC

 arch/m68k/include/asm/m5441xsim.h |   7 +++
 drivers/mtd/nand/raw/Kconfig      |   2 +-
 drivers/mtd/nand/raw/vf610_nfc.c  | 102 ++++++++++++++++++++++++++++----------
 3 files changed, 85 insertions(+), 26 deletions(-)
---
base-commit: afcd48134c58d6af45fb3fdb648f1260b20f2326
change-id: 20240620-upstream-nfc-mcf5441x-82e23b45e286

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


