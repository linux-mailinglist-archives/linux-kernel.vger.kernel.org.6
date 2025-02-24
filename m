Return-Path: <linux-kernel+bounces-530154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E414A42FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4305B1781E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F191DD0E7;
	Mon, 24 Feb 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDsum1ti"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6B15886C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434663; cv=none; b=G/p/lqTaKKKKvZH/QrQs5NgxRt6usnnBWVbZ9nAo4LDbuMv0QdgCDBW4t6pRG3pYIxVAWApQ0OsqVlLQC5kJUkLSccBwgxrWwgU11sYDMlMq3sxuykUbOhdeSkWtQryLMvOcVGKBy6KNBHYPWZwE2KAHmcI6cmaaIvzoD0TgJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434663; c=relaxed/simple;
	bh=lJkD4zwo8Tu+45Loci6rtrPBmzl83XKpiNKyeFXayy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgWo2o6IJC8H6xMkDUQiBOzW0XZURegw40/vebZsRjqLKuriEZ6CjvH9s8Nrkb8R8nYWzgjwZlZJ0Yx1dPA84owWEw5wIIAtzla94UxA4HSicVPHhw63PCBAY8aDHQ/XKlvoGA/W/WtLjezVAlWWYDaRScnDmy5Vyj10XuQZdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HDsum1ti; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740434654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KzttHuqwbO250SJZmkXY5X6iacccx0fS7kQMrYMCK/A=;
	b=HDsum1tiv3YaUTzCuEGY0f0iNnWNF3YkCKRoJsvAvPLZOXaHhRZ/Q1Wf0aZYIv8t/+uDev
	2+gzfBDjGTbPOg4bVCwJYvqPBX32P7zl0yq1HU/VZP1275Es9oEddZh7YPpVl9O7wFxBQy
	ewk2ywTaBya3+MtyMk43i8WPUEsLuhU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip: usbdp: Remove unnecessary bool conversion
Date: Mon, 24 Feb 2025 23:03:39 +0100
Message-ID: <20250224220339.199180-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unnecessary bool conversion and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 5b1e8a3806ed..f7a36ed59ef7 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -978,7 +978,7 @@ static int rk_udphy_parse_dt(struct rk_udphy *udphy)
 
 	if (device_property_present(dev, "maximum-speed")) {
 		maximum_speed = usb_get_maximum_speed(dev);
-		udphy->hs = maximum_speed <= USB_SPEED_HIGH ? true : false;
+		udphy->hs = maximum_speed <= USB_SPEED_HIGH;
 	}
 
 	ret = rk_udphy_clk_init(udphy, dev);
-- 
2.48.1


