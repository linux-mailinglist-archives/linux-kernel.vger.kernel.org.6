Return-Path: <linux-kernel+bounces-532265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1ECA44AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971353A7E79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58731A38F9;
	Tue, 25 Feb 2025 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="G9OtWPrL"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6A197A67
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509151; cv=none; b=O3PmKX50FiiyL7F32eDF4wVHFNOU0ON43JWsusQ1lUoAvga1PPDO/jS7juaECzePe4/XJvVfBuffgWHHZERBfYIS4Ihki5PIm3BsOfY1nQqz/16/Gic16O4/87gLtjsbQiKrqo8rxcELWbWdGLEBt/7MROBOZZJdEIc41I0GxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509151; c=relaxed/simple;
	bh=YPWmqXUd/37OyXTVUvElFJ7iKhtg7tcYiZ7KtVOKsBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mto8cAi4x9U146KR1yqcNm22l89jMIP3/b6Rkzsa6nN/onXrQSczuelsCdsbQe0zpF9GreVIQBh/zuU9hQ0MrQI/jDNwWFja2+ZkLk7T3fUHT6rWfGxtChRPIAJx3mU0rlV8iqfdC8T7dvXQL6mSAuER+G0VqhctdxzuDLxzhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=G9OtWPrL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R66Myrb815a2WZP3G5g/ewvPF3fMxnEmoDEZgjpJrTg=; b=G9OtWPrLluyK+WuGj3VYHd03s3
	li6/pRdI8d8UAw4ZSnrwZP21VlE5jNT27KKQ0TIA4gekQmSCB/2Bo+oY8AbOodS93wDstP054jpqA
	0lVscOWVWCpVRCFEhu+GmteTSxkdhHi6s6eZFzwQEb6vn/QgBRhE2gj6ueXBSEMjpxUjqglpfa/Pf
	O1f0dSQ8qV/A5jncHQlSbLteg7bDVtdWYOb6oN8t5T5SYNRfzxaMl2OpJJt29ssRhq0Vr5TNcz5VN
	D5xdCu9CJEFqU2zFYjB0Zo9yJxZLtncpwejbN9rGjRu4xBBDC1l4wlMbdKt45LbN9T4FpSaX5kumd
	dRZIIahg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tmzw7-0006r3-Ar; Tue, 25 Feb 2025 19:45:43 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com
Subject: [PATCH 0/2] phy: rockchip: usbdp: improve typec orientation handling
Date: Tue, 25 Feb 2025 19:45:17 +0100
Message-ID: <20250225184519.3586926-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reinit the phy if it's already running when a type-orientation
event happens.

Heiko Stuebner (2):
  phy: rockchip: usbdp: move type-orientation-switch further down
  phy: rockchip: usbdp: re-init the phy on orientation-change

 drivers/phy/rockchip/phy-rockchip-usbdp.c | 173 +++++++++++-----------
 1 file changed, 90 insertions(+), 83 deletions(-)

-- 
2.47.2


