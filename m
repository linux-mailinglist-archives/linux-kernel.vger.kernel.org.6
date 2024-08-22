Return-Path: <linux-kernel+bounces-297199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9131395B46B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3E3283E99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA21C9452;
	Thu, 22 Aug 2024 11:59:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85613A244
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327994; cv=none; b=gfyQPIdl9Jx8M6HNe7KPzg97ApPDcnTdXsLXBSeRwmZl+k/cMnyq/CESy902NZZQVm8lCeVHH2ITOfCnukXmp9ECSxYQeFuE3fWg0TuFhU4VdQCPDWXgmVq5ZxKYHQx0+XHnWMX0bhQti5owEo9Ru62UmyKAAg8VyO4qPYHqFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327994; c=relaxed/simple;
	bh=ifZIL4p+x8sjQzuIiUtGafg1V5DS9QctREj8LGSkcBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0y3azFM3G8A1OoqDV3qy57fccvBYuPK8jmxDPC+oay7KSpd/UTPcqqTbIQbbV02KN4SwnZQJZdzVkKdcfGV1KE6xYg9hUor10rlW47znwJSRlg3tXhJSYy7CTKQolO45o2UMUbOrOB5j66WearapyACAVLqi9HxZxBOpSRQxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Te-0005ot-WC; Thu, 22 Aug 2024 13:59:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-002EyQ-3q; Thu, 22 Aug 2024 13:59:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-005oph-08;
	Thu, 22 Aug 2024 13:59:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/3] Add Statistics Support for DP83TG720 PHY
Date: Thu, 22 Aug 2024 13:59:36 +0200
Message-Id: <20240822115939.1387015-1-o.rempel@pengutronix.de>
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

Hi all,

This patch series primarily focuses on adding statistics support for the
DP83TG720 PHY driver. Along the way, to achieve this goal, I introduced
defines for various statistics to ensure they are reusable across
different PHY drivers.

Changes are tracked in separate patches.

Oleksij Rempel (3):
  phy: open_alliance_helpers: Add defines for link quality metrics
  phy: Add defines for standardized PHY generic counters
  phy: dp83tg720: Add statistics support

 drivers/net/phy/dp83tg720.c             | 324 ++++++++++++++++++++++++
 drivers/net/phy/open_alliance_helpers.h |  14 +
 include/linux/phy.h                     |   6 +
 3 files changed, 344 insertions(+)

--
2.39.2


