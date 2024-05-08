Return-Path: <linux-kernel+bounces-173071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F388BFB1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96AE1F23386
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA69823BC;
	Wed,  8 May 2024 10:39:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEF81721
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164754; cv=none; b=H52BCK7BbFsooHIqCGLoGtL5ZJPsb6qG/J9S7KwjLbjNn4cqSao2pP6C/5mj1phVNc91rCmodOG0d5ATblWsUGVtqhkk4b4Pejv3fjOTR+R3FOkRPPqBMkcmAHE3QbZzWloSGt4abImPj6VMhzLYD73s+qRcKjIg3ej9nE3sjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164754; c=relaxed/simple;
	bh=shiwGSUaYs6M/v6Nfu5vlAB62BF0UdPHl54Nvv1gzsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1W4jaMsP/2idB6+jXSZundqJiO28V5YkZeDc+EKqsNKL4GDqZ+uCNfnzoIdxvC7HZqnp8925U15+50XAdNgKU5UYkZsY4IxiGrXXL+yM9x/aTyiPOJre5CUuiNY+HbEvUZOjsXQ7DceALJhgx5X7sLYzVXFjhWVbP4pOa7fbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehV-0004BH-8n; Wed, 08 May 2024 12:39:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-000G0F-GF; Wed, 08 May 2024 12:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-00HLTP-1M;
	Wed, 08 May 2024 12:39:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 0/3] net: dsa: microchip: DCB fixes 
Date: Wed,  8 May 2024 12:38:59 +0200
Message-Id: <20240508103902.4134098-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch series address recommendation to rename IPV to IPM to avoid
confusion with IPV name used in 802.1Qci PSFP. And restores default "PCP
only" configuration as source of priorities to avoid possible
regressions. 

Oleksij Rempel (3):
  net: dsa: microchip: dcb: add comments for DSCP related functions
  net: dsa: microchip: dcb: rename IPV to IPM
  net: dsa: microchip: dcb: set default apptrust to PCP only

 drivers/net/dsa/microchip/ksz_common.c |  46 +++++------
 drivers/net/dsa/microchip/ksz_common.h |   2 +-
 drivers/net/dsa/microchip/ksz_dcb.c    | 106 ++++++++++++++-----------
 3 files changed, 85 insertions(+), 69 deletions(-)

-- 
2.39.2


