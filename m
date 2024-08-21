Return-Path: <linux-kernel+bounces-295060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB0959631
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4217B1C20C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2A1A7AFA;
	Wed, 21 Aug 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lApmBPWw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0C1A7AF0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225901; cv=none; b=klQsQjOLuPL3pYIbfwwq6hH35OmuXCXHLxceNRiZzICbnYZUgTg5KpcElAhiMMXPEf5ObcsO0TpBAf06oKy/OHDhcIVZN26Qj7ieOBKy1dwiQTxwUcy6Dn1x6BqcmcXGSk0F7IymELco7R3DfAgrPdAm7mwexRYOdpfVgyC0/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225901; c=relaxed/simple;
	bh=Wmd+TaNUkGUDmCYisKSlXf/BBZkzan1IalkC1kxOuyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFvnP9ZSnXxTcid4Iv1gwWvvlhXKrHR+Ytba6wPPgR5Wn8ngCKzJnT919DVxOgb01MvPymyY6Aw3hssW7M1Ws+MB9GmnTvJfodQqtRo/DObbtFi0r7aH0ZZbECMusOwNva48dIsBYjo14qFjnTKqj9Zx0SDdfTcyETXOG/9XuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lApmBPWw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724225882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRzBb+guxB9XMhkJIfvjYWWTeQw1F4QkWpzvZuQPj7g=;
	b=lApmBPWwevQr3QpBhIXLHUfbQ67JF8AsLszdll8Oi6lZJ0Qnhx2y2tHwmuZ5ZVFtgWq4nY
	hbZKI7raryz95qdJSzCNtVAsI/ZJra0mpt9PpFEiwC6Vf6G26I91A75DnRaGomC/zlMp2F
	gf2M7XW8tSVd2UjXPkieIbi/GmmY4SBP3qn3ZHwYeEvFmYecYcj0/qA+yPKPruNS/sJMVa
	T6MK/tB0DErb8mJHLXgja2UY3A0CmDMk9qTo0QqN4xs87CnO+Qqyd0lmv5NcstdYbrIvSr
	3agqyD2cYnADzqPyKrUQ0FgkO5+OXXXGNssliUcQf3RB4j4R97NV0KCfqg7nxw==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Improve error handling in Rockchip Inno USB 2.0 PHY driver
Date: Wed, 21 Aug 2024 09:37:52 +0200
Message-Id: <cover.1724225528.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a small series that improves error handling in the probe path
of the Rockchip Innosilicon USB 2.0 PHY driver, by returning the actual
error code in one place and by using dev_err_probe() properly in multiple
places.  It also performs a bunch of small, rather trivial code cleanups,
to make the code neater and a bit easier to read.

Changes in v2:
  - Expanded into a small series, after a suggestion from Heiko [1] to
    use dev_err_probe(), because it all happens in the probe path

Link to v1: https://lore.kernel.org/linux-phy/5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/linux-phy/4927264.xgNZFEDtJV@diego/

Dragan Simic (3):
  phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
  phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
  phy: phy-rockchip-inno-usb2: Improve error handling while probing

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 63 ++++++++-----------
 1 file changed, 25 insertions(+), 38 deletions(-)


