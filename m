Return-Path: <linux-kernel+bounces-420093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B19D7509
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E115E2871E3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5824C6EF;
	Sun, 24 Nov 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq94EPkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D6E24A951;
	Sun, 24 Nov 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456637; cv=none; b=D/DnxfCB/+w9JdYIln0k3KRpClRQvKx6hLn9bUp5Rkzo5hR1iJrnEN7gsVCUxpoYmQrZHwOH9VbT65R2nvW8tmLzacCiXgNS4T9lLROOZSi2KW2BQ/otJHx3VzS7MA8IN25zMUvfNjcDmnYsUpbh2jG0qZRLYzTBxYec9TKJ8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456637; c=relaxed/simple;
	bh=CGETTyCWoXPdn1YRwd2zWw1iVkn0FqNHobWiAX6+d5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMz9iA/RIcD9x5UMfW1kl+pTDoPkn8j1MbbAbdYVr1gLRmMu9dX7WFAnVLzEVrLfeb9ujx3uEhXEZ3JlXfoMaT4tAH9eitSe5xCMh/zOeobJ7PnvvyK3otSxfPhRNVX/LFAZvNTtuFuUB3F9iu3MCZAeZgseH7wiNHLM/d4AipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq94EPkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC7C4CEDA;
	Sun, 24 Nov 2024 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456637;
	bh=CGETTyCWoXPdn1YRwd2zWw1iVkn0FqNHobWiAX6+d5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq94EPkAXwmW0wh911Z3OjnQ9/m8LN70WrUCfChpPIOfRLfl+PJeesAv+3lAinJi7
	 LceSUgkTbnmanc5w0McDVxAEg4bdrfCco3kNOXKOjUEP65kj0qgDAjeVKUwcBVjAjS
	 asE5FTaOuOrmV6KQAmngC/JnBmzNNLSiTGlfGkCHaf/sCVBfgzT2fFB8RozaxE+Yy8
	 xjW+BKZMOOcVzjftqYbyAiCx/oSUzBX/FWpgAkz5Td/8zP3q/Ts+UMdskv+LtkdXNB
	 r9FCv6U2rAMyn/8rs9yeW9rZ6zEB3HkZLFCKI22QfAkbzfkQZnRLbgRPhMfw+IBX5Z
	 X8aYv5+RJNZXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/21] net: fec_mpc52xx_phy: Use %pa to format resource_size_t
Date: Sun, 24 Nov 2024 08:56:36 -0500
Message-ID: <20241124135709.3351371-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit 020bfdc4ed94be472138c891bde4d14241cf00fd ]

The correct format string for resource_size_t is %pa which
acts on the address of the variable to be formatted [1].

[1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229

Introduced by commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")

Flagged by gcc-14 as:

drivers/net/ethernet/freescale/fec_mpc52xx_phy.c: In function 'mpc52xx_fec_mdio_probe':
drivers/net/ethernet/freescale/fec_mpc52xx_phy.c:97:46: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
   97 |         snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
      |                                             ~^   ~~~~~~~~~
      |                                              |      |
      |                                              |      resource_size_t {aka long long unsigned int}
      |                                              unsigned int
      |                                             %llx

No functional change intended.
Compile tested only.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/
Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Link: https://patch.msgid.link/20241014-net-pa-fmt-v1-1-dcc9afb8858b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index b5497e3083020..7e631e2f710fb 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -92,7 +92,7 @@ static int mpc52xx_fec_mdio_probe(struct platform_device *of)
 		goto out_free;
 	}
 
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res.start);
 	bus->priv = priv;
 
 	bus->parent = dev;
-- 
2.43.0


