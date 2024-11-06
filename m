Return-Path: <linux-kernel+bounces-398224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C09BEA62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FB61C257F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A511D1EC014;
	Wed,  6 Nov 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GMXE5ian"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668291F8F17;
	Wed,  6 Nov 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896692; cv=none; b=oLRDrzY47zCQqOegcCEr6goV8J5RSSBKc2FJ8dt3FczBtNeM814LZIu1g5wDNB5Lm2Vz2mum7x0IdySLflt8PZtKFDdMcZrh1fJgVkJMnS27BaY7UfIBygpD4Yw8XGWUzcDl+Io7D6RmEJL9D8rf9sJVVsmGV+qcGh97Lu+/2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896692; c=relaxed/simple;
	bh=ymMAQaOrRi1hxUYECglBapM0q/P6RwP60Igv8aTMd3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msX5Ggix5r0ViRTlEVmSQcn2AFBwJqaMkjf46iEfj7qXYNRiooLeyI31ojCPmqmNAacNHv+irAgzJwIzGSmuu37bfjb+5lopksCKlXR87gEfo//9Lvh+wGKtJDsgfv5M9y3/pPx0eor1soN0PirV7phZqOuiwwIIpgU46qrY56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GMXE5ian; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ta5KNS21UEn6OXLlp807nLSpRRb7UzRnrUsb9sZkcIs=; b=GMXE5ianbRdR/UjEa6+5nNK/8X
	DmuFbVFNKg0C29lqCkZwI6X0pXfhZ8jqcJPmaKgF5Sm9K6aoBaJdbkF9m5b00hhUlgBleaSIwFGvq
	XXmBDEkM1vursvBqLN3SvOKu11KOY9tBu4tFkXYrSLDqUEDD20joQYNAvJkXaP98XMAKJAtOzBAmY
	++0J5y/cBmBY8mW64OYszATX0FgnUsvvG249uG9Rh070tOJDheXyMrizJ1dq89+/m/Hn10nR5iy/N
	ajnDT1lkTFmPaVdpvbhA/AMgS5d0GsYqYK5aQHrengHvqnoPNHFvgsUKw8IqVr515zFaemesZUJkg
	XjCYtdPw==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t8fIV-0007A8-HI; Wed, 06 Nov 2024 13:38:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: rockchip: add and enable DSI2 on rk3588
Date: Wed,  6 Nov 2024 13:37:55 +0100
Message-ID: <20241106123758.423584-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the dcphy and dsi2 controller nodes and adds an overlay
for the Tiger-Haikou Video-Demo adapter that provides a DSI display.

Heiko Stuebner (3):
  arm64: dts: rockchip: add mipi dcphy nodes to rk3588
  arm64: dts: rockchip: add dsi controller nodes on rk3588
  arm64: dts: rockchip: add overlay for tiger-haikou video-demo adapter

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  98 +++++++++++
 .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso

-- 
2.45.2


