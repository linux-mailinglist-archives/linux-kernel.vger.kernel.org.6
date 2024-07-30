Return-Path: <linux-kernel+bounces-267604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25D941343
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA60286175
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F41A072E;
	Tue, 30 Jul 2024 13:35:58 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A61A01AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346558; cv=none; b=OXZ09j5a8Fx+oQOnMqgdVjGq9APOsVIbjC7V2jZflpXN+RtpKC54X1mkRec3ctWFs/+hu7zFpesgzAKOVCH6FzDOeVraGidePre9N/h02LgZJ7jqanK9jUraxf6jUyS16S+VqCArEuF1Uv5PV9FB4McS/kLPkr5/0QAekQwvdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346558; c=relaxed/simple;
	bh=8ZKVgUkDg1H9qoLmR9WGjhmiqAIJWR6xufVkeSIkI6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e48NHiPFVC9hLmOXDZIVVNnLZhjLaAgGVchBW8laShT0NQ89eOQ2JPCGMY5+l6f++mq5Kep4Gu73vuAsV1BcFK9TEQU4TpzrTKzCJROMengUy7l0g6f0sMa4Gmh1HQs4VcDs6OSIFfX134jFq4LkzO7xZSLhJUj8M7nKIuTBhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:520d:93ad:ff6d:335e])
	by michel.telenet-ops.be with bizsmtp
	id tpbo2C00330Ayot06pbooH; Tue, 30 Jul 2024 15:35:48 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYn0f-004Akz-4Y;
	Tue, 30 Jul 2024 15:35:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYn12-00DzGt-5X;
	Tue, 30 Jul 2024 15:35:48 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spidev: Add missing spi_device_id for bh2228fv
Date: Tue, 30 Jul 2024 15:35:47 +0200
Message-Id: <cb571d4128f41175f31319cd9febc829417ea167.1722346539.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the of_device_id entry for "rohm,bh2228fv" was added, the
corresponding spi_device_id was forgotten, causing a warning message
during boot-up:

    SPI driver spidev has no spi_device_id for rohm,bh2228fv

Fix module autoloading and shut up the warning by adding the missing
entry.

Fixes: fc28d1c1fe3b3e2f ("spi: spidev: add correct compatible for Rohm BH2228FV")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 05e6d007f9a7f617..5304728c68c20d3a 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -700,6 +700,7 @@ static const struct class spidev_class = {
 };
 
 static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
-- 
2.34.1


