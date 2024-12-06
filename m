Return-Path: <linux-kernel+bounces-434890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46F9E6C56
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E1A28EDF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1A1FBE81;
	Fri,  6 Dec 2024 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="F4fZ6994"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D581DF978
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481282; cv=none; b=Tc/BAG7cN74nS733/tdo6tIRF6fZNp8Kfa6s2oAQc96GXA8lJZYjunOhGKVgHeVF/ESDUDeqlleMPGiBDxI20xjBQwikrY8Y8a1haE4XJYduYxM+bk44vVSfSEE/nMsBJKy1o4OxKvAiHR2N3KloeJwO+m/MSruZBeAWRYaFMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481282; c=relaxed/simple;
	bh=olbcW065f6WIq6C5jahpB40fl7ao/tQY3pF5eqxc7V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWRuvd+0Retm77FuRtv5nUomGymFrnuRk4DuTRXgFneCS51y0lTmJ0Nd5AfcJd8489xWQq246thuxmcAjZFOjjHL05IfwvgLUOESOL7Xx6DO7TrGwHyf3b+40srkt/JQdEY6JImFa34/okZIrtV1zJisE4dphoZqgFn2eA5bvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=F4fZ6994; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KOB2lRuRgc5c5Cx+z4l+rgFqNRL2xohrcJNSDIsVogs=; b=F4fZ6994jjC53bMEsZmmff8qaP
	XkcpOrjvd5t5eRx/0gGyTrmiB/ozlNgkaYWj5MWvwqVe/V6b44E1euanIUN+qVBUu6VoyquYqYYvn
	qr1IVUw4Oxx+0xKtqVUfacx/n6JW0d1fvJKJLUiKo+4W9erAc3F3V3PC3Dogcoh0swtHzdXdcwoSA
	yVZRDDAsbNKcSots0IUIW97JgxrQb2xPDOof7mJuAHMp8Pqv/2ipMFt17+JCtYCYypF2WCTqVWfWM
	487M+75KLxZFBtvhelHsG0nA5co64GQXnGXYr4mQemcx3h6ZslrdOFj29C4wF5nBcTNfFBw7p1mPq
	709sjeHA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJVfH-0007XU-GF; Fri, 06 Dec 2024 11:34:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	cristian.ciocaltea@collabora.com,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: [PATCH 0/2] phy: phy-rockchip-samsung-hdptx: don't use of-alias
Date: Fri,  6 Dec 2024 11:33:59 +0100
Message-ID: <20241206103401.1780416-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One nice comment addition and removal of of_alias usage for core
device functionality.

Heiko Stuebner (2):
  phy: phy-rockchip-samsung-hdptx: annotate regmap register-callback
  phy: phy-rockchip-samsung-hdptx: Don't use dt aliases to determine
    phy-id

 .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++----
 1 file changed, 51 insertions(+), 13 deletions(-)

-- 
2.45.2


