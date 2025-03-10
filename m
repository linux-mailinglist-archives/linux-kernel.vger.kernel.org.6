Return-Path: <linux-kernel+bounces-554121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8EA5933B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E57C1638E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB3227EAA;
	Mon, 10 Mar 2025 11:57:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1322576C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607871; cv=none; b=GAUgxj9SuWc98AQ2rtZH0Gelk6PyJjZikAeTPY8zdkAa+FVBM3p1/7jzghRM/Xtp/EXmAUbodh4CP/fD/bmYErRZ6KvOojuIE+FmhYc3NBSktYKuj9KvYDTE268xEgqro2rerPDtmG18K2KsBXVLTW0sKvudBfWLapiGUOWOD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607871; c=relaxed/simple;
	bh=aV37oTRU8VRfUqEf+ExcZrqvLFCCYjE0cXRZe0IG3ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AuRFNPfZcKqt3ur/Eddte9CYXNElseSM1FodTLZHGKP54WP8an9VnnSditGqD8hFeltyMmWELMkD4/4GZfUgBclg5IJl8vGU0oBf9tNvMFrz3AZhCWjFMugg4C9BY2K5tMdjoKKFsmq8z/23IM5iPxmFy5ZcgWJEPyENCb9oozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1trblL-0000S3-Cn; Mon, 10 Mar 2025 12:57:39 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1trblK-004zZy-09;
	Mon, 10 Mar 2025 12:57:38 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1trblJ-003I1A-37;
	Mon, 10 Mar 2025 12:57:37 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v3 0/7] Convert LAN78xx to PHYLINK
Date: Mon, 10 Mar 2025 12:57:30 +0100
Message-Id: <20250310115737.784047-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This patch series refactors the LAN78xx USB Ethernet driver to use the
PHYLINK API.

Oleksij Rempel (7):
  net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC
    management
  net: usb: lan78xx: improve error reporting on PHY attach failure
  net: usb: lan78xx: Improve error handling for PHY init path
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Transition get/set_pause to phylink
  net: usb: lan78xx: Integrate EEE support with phylink LPI API

 drivers/net/usb/lan78xx.c | 816 +++++++++++++++++++-------------------
 1 file changed, 400 insertions(+), 416 deletions(-)

--
2.39.5


