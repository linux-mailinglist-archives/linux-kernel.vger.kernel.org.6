Return-Path: <linux-kernel+bounces-316644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB096D248
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDEAB216B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CC1953B9;
	Thu,  5 Sep 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QZizFzOc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA7194ACF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525393; cv=none; b=t2mqiEpVO8e7T+oJylP8Fs+wPbEZH2FhakByFuSRuAIWZRxnpn+ec0Q7Oz4WeW2JeOFhMdmBkTmVpNkIplYpoNF5EC2Dj7n0CKtQUBWZ1bqGy0R2FRFZPvYkPcuLfVsWjdlgGeIU2SPFLLrRJwmK+hWQbN/NqB61Yq4l3YU09tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525393; c=relaxed/simple;
	bh=gVM0XX9Umwe02JqDTo37mjuy1LRAybBpAVyRtLijO0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GvAlUUUKSxmLwWD9ZimmKg+RdAhgSvTQAPSnBNIDa/WZTdbYUzMOlg3OAAnxnW4VrCg6igB14Qvf9xK7aWlfleCAmqlv+jP9O/KfChgidcsdRUEeW5KUul6OxZj1uAWZ3e4HgBhjkpzyMIco1Tx8nfZcr32VrGP7z6nuF392iTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QZizFzOc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725524909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QGbYTu2hqsFggew3uw7+862rMPLb1SOuJtmtRUbdkcQ=;
	b=QZizFzOcelRH+iBInyBr3yjcET0dYugZ0HXQiTXga278uMJ83t9l5ZWHMqzGIfNmmm8ZgI
	4ZzUaZ8pByTw0FYX9ReO40DywXxUrutj0NaWHV2KfoxJfh/+bQcFIRqtRuDe7RhV7IWcK1
	Xl2Nst472A8tQ6oy3C6eSdLD0qxFJiQygaOU8ttWJktgfR4pO7F7MmG8sGovVaMRxR5snS
	1DXOZjFaTNdd8rCNKKAY705oFiS93+75CVGYqYucF50I+KtCyjdl/kiIYzEKy/bvjLHKBX
	rdxSnOrqZGdfqilmfGmqlDnnlR5ga2t8qtdfnf62oYH9/uRgi2JbJbPLCBA5iQ==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Improve error handling in Rockchip Inno USB 2.0 PHY driver
Date: Thu,  5 Sep 2024 10:28:21 +0200
Message-Id: <cover.1725524802.git.dsimic@manjaro.org>
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

Changes in v3:
  - Collected Reviewed-by tags from Heiko for patches 1/3 and 2/3
  - Brought back one empty line as a separator of dissimilar operations
    in patch 1/3, as suggested by Heiko [2]
  - Dropped one backward conversion of dev_err_probe() to dev_err() in
    patch 3/3, as suggested by Heiko, [3] and adjusted the summary and
    description of patch 3/3 accordingly

Changes in v2:
  - Expanded into a small series, after a suggestion from Heiko [1] to
    use dev_err_probe(), because it all happens in the probe path

Link to v2: https://lore.kernel.org/linux-phy/cover.1724225528.git.dsimic@manjaro.org/T/#u
Link to v1: https://lore.kernel.org/linux-phy/5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/linux-phy/4927264.xgNZFEDtJV@diego/
[2] https://lore.kernel.org/linux-phy/5307900.6fTUFtlzNn@diego/
[3] https://lore.kernel.org/linux-phy/6073817.31tnzDBltd@diego/

Dragan Simic (3):
  phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
  phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
  phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 56 +++++++------------
 1 file changed, 21 insertions(+), 35 deletions(-)


