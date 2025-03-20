Return-Path: <linux-kernel+bounces-570497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F0A6B16B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6850D1897EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817721D3FB;
	Thu, 20 Mar 2025 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwwM0iKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED415C158
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511878; cv=none; b=nJB7br9oJlzuD3qbwMWjFbo4r3JjQPhDAbn0gVp/BRAfFbdxRSHtPEp5l8Of5PD5u5hMfg/iPd3QMYvcyf/VKhGQ/d/mhMXG6kNHCak6bGgZqhwWISTlr/ZoR7QWQVw2H9GT4vJQnzQinZtatT6CK7cRUnmH7kH7vzzQnWRJjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511878; c=relaxed/simple;
	bh=Lha/2v4/99WRRqn+EErsa69RBL6tgvybSJRRwdSrAIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j5kl4neVP28my8ZM1TUgUHRGKxS/I34mmNdVAH2H0kXmK9a80QFDqIIKbNTRGAhrJCP3w72ZbJ8O5ePnKI2OprjJd03VoogLESiROzNWP9VYOdGjD5gS9FX++U4Wee/4V7R4n3eoYHc4zWOiZ4Snlxtjz64/2HU23wEGNu+x/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwwM0iKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5C5C4CEDD;
	Thu, 20 Mar 2025 23:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742511877;
	bh=Lha/2v4/99WRRqn+EErsa69RBL6tgvybSJRRwdSrAIY=;
	h=From:Date:Subject:To:Cc:From;
	b=VwwM0iKEhRYz3EN6IyWVqKG7KHgeX6tyc86fD9IsQFPR3ao+Vr0qfOd7sCSKUneKM
	 Ncfic+3Zius4uxlzUrLbY3PoDOfCTsL7Zcuil/TXKuW5Pw6JmCAZGFZhs89tJ8mfg8
	 hNwZzTMbMMiIHjIuucPHXmstmfhuCFZ9W8i7n6Ug2WacBecwH+0VVApyFSod0VYx3B
	 v1KOMakchXvLle9PYoRWBZ5/hWuaofKycu3UGSH8T1l1PLNjjT26zeWhSFvAOClbCF
	 Ylusb6XfW3WqnsKEaF2nL4a0ffNjniTxxz9U3+mUwaUw28B5zl7SLKH/hvI5wkHU+A
	 t1uj4+6JOdPkA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 20 Mar 2025 23:00:34 +0000
Subject: [PATCH] regmap: spi: Don't use spi_write_then_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-regmap-spi-write-read-v1-1-31666bc6ebe8@kernel.org>
X-B4-Tracking: v=1; b=H4sIABGe3GcC/x2MQQqAMAzAviI9W5gVUfyKeJhb1R7U0YkKsr87P
 CaQvBBZhSP0xQvKl0Q59gxVWYBb7b4wis8MZKgxNRlUXjYbMAbBW+XkLKzHbiJHlp031EJug/I
 sz/8dxpQ+0pMnXmcAAAA=
X-Change-ID: 20250320-regmap-spi-write-read-8b2c2aecd027
To: Arnd Bergmann <arnd@arndb.de>, Petr Tesarik <ptesarik@suse.com>, 
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Lha/2v4/99WRRqn+EErsa69RBL6tgvybSJRRwdSrAIY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn3J8DOH6OMDtzsqfq7QJ1U0hLffs0ZQUyHGB7Vgku
 M6CQvCKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ9yfAwAKCRAk1otyXVSH0PvZB/
 93NhCtzAMBgnQw+dWvqn1lvq0vlkOnr6KBzornmQozHE53O339E2UdhSvEbJFtygMKcezOkSZc6HpL
 sI3vwlpQ1tBHyKyAUXxHuMdWdt87J0tO2ooDoeeccqU7TpJG//E1KHjlQYpbL03Sv/XkxFnCWY83CW
 vuXUMV8p7RUjf73+PwHQ7VcvvH0lmz22CY2LkUzL/kJgl0ZciBaJtgNOIqe3yQPx8EGANZ3Vb4aqoJ
 tZBXD5PksN2nfW5mk4WN5qAU+muL4cpwTuj6vjMjtXrXbsQls5yEPSLVABOR7wRyc5ItXdrLI4cd/h
 dh+0Cw5N71gSOO3yTdYx/V7Bq7JCIq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently SPI reads are implemented using spi_write_then_read(). This is a
convenience API which as well as constructing a SPI message from parameters
basically the same as for a bytestream read operation also bounces things
into a memory buffer to allow callers to use stack or other non-DMAable
memory. Since regmap should already be ensuring that everything can be
DMAed further up the stack this copy is redundant so switch to using the
underlying spi_sync() API with the buffers provided by the core directly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 14b1d88997cbe406c8900f5032d768fc7484e99f..6a3dbc217e890d25a392fd3157f9ed89188afdaa 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -94,8 +94,15 @@ static int regmap_spi_read(void *context,
 {
 	struct device *dev = context;
 	struct spi_device *spi = to_spi_device(dev);
+	struct spi_message m;
+	struct spi_transfer t[2] = { { .tx_buf = reg, .len = reg_size, },
+				     { .rx_buf = val, .len = val_size, }, };
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
 
-	return spi_write_then_read(spi, reg, reg_size, val, val_size);
+	return spi_sync(spi, &m);
 }
 
 static const struct regmap_bus regmap_spi = {

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250320-regmap-spi-write-read-8b2c2aecd027

Best regards,
-- 
Mark Brown <broonie@kernel.org>


