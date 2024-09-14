Return-Path: <linux-kernel+bounces-329244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6B978F13
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD42855CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D013DDA7;
	Sat, 14 Sep 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ImkbUKGP"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD24749A;
	Sat, 14 Sep 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301927; cv=none; b=rC9f6Inq5rVPDMO1VfPs4bXknHNB2O9UGB34m8svRnZ8LatmQpVVeuya6H67d37V2ca9GBLZGhm4UGrSN2UOB84W6QqzlX9XvxjTVYB7H19Jgb+8j+2zHDFXUUzfbiIvDnuUY9fA6qBOOKkSWrZnaT2D6bFPUP2ohianKpeRGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301927; c=relaxed/simple;
	bh=L07XC14LSxTMqqBlMb28DyLc/42mEnhITXcHp3SX0ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA4J5/DIgz2i0NhOlsioxoCeuQ+q0IoQJOcY3ZqnQmLtrvCkAwCTqm5N4jsvXLgyep5Q3VgeVpRzGeww+yjK41Ms5oQier+B74hq6lpQ5fkFMh82j/SRrSFLvkwOBdiJKtV2xc0R8w39XQlJBTJu/HB6KfHlRoIyhNUyXMgLVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ImkbUKGP; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A35D40007;
	Sat, 14 Sep 2024 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726301917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A/NMzLz8Tuxq/gt5dPNpj6i4kHuPhRrw0hNedu0YR04=;
	b=ImkbUKGPiXQbqZnvZeefqE2T+XlO2xqBLvMzz3ERKEgEJWWoHmlKvoBW5skj91waHHidgv
	/FEQzgtpvoMZo9T9Y/V8u2LGvlhVQ8CBI5nRGcqIGG123RU7DDzNtE9duTZAzHcZ6LjHcW
	pvwxS/OWtZG0Q+LQWyRytZcmvrkqz6gD9g3V8QyOCRBvhOuCGo91vV0VsPF9nNui35p1+V
	Sg8y37iBy4OrvXlaocl4HH5SR84ftgMrzCvg7zLObpdybaqRVTZw8E9MvL9E2yuosmMkrM
	5Vp7tkKhRk4v3TSskKkYMqjYQPbhneUaoRT9obs82MhbcvNie6V96euuw9LBdw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next] net: ethernet: fs_enet: Make the per clock optional
Date: Sat, 14 Sep 2024 10:18:20 +0200
Message-ID: <20240914081821.209130-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Some platforms that use fs_enet don't have the PER register clock. This
optional dependency on the clock was incorrectly made mandatory when
switching to devm_ accessors.

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/netdev/4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr/
Fixes: c614acf6e8e1 ("net: ethernet: fs_enet: simplify clock handling with devm accessors")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
This patch fixes a commit in net-next.

 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index d300b01859a1..3425c4a6abcb 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -895,7 +895,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	 * but require enable to succeed when a clock was specified/found,
 	 * keep a reference to the clock upon successful acquisition
 	 */
-	clk = devm_clk_get_enabled(&ofdev->dev, "per");
+	clk = devm_clk_get_optional_enabled(&ofdev->dev, "per");
 	if (IS_ERR(clk))
 		goto out_free_fpi;
 
-- 
2.46.0


