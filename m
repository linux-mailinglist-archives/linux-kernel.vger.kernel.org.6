Return-Path: <linux-kernel+bounces-323687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51379741D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C19E287BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3B1A08C4;
	Tue, 10 Sep 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="kggCf66T"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0E23774
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992194; cv=none; b=jqoNHzfYVJlCyf4Unt1rod8pKuo8YedlixuPgrzYF1q1kxd8efPuQlPrWuvlyvinzbs2MoLJh7u829yYnZ9Z/Cqoon+4D+0r9LcDMU3GgvKOm4KgL3jRdcLn8TLLkT1Mx6XMr62TifPIDpbK3tx1B6rvi8oT/P8LyfS/pmr7JoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992194; c=relaxed/simple;
	bh=gs6ozKmkV4DOqGglcXxj7eNEfU18rvJHYc0HRKSfwqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqcylQFzyKtqw6G/QaOi9hjvhqnTLikdyA8hMz3S9Gh0iRiavqtg79H9cTi7umYTIDb9c0Ssb7wzA8/HxTcPMsSQl6ceFurk4DbbF9kSOqZ8QS8tfOk1cUJxQH2EQFPQ4IQMJ4SEUsHIriqIGWBuGCIkyZjg7YRyr0snfdDbAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=kggCf66T; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39F20BFB36;
	Tue, 10 Sep 2024 20:16:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725992181; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1wNGNIuAk/AXTrhPAQa4D1/tOWO9z0Y3QjayfxiKaz0=;
	b=kggCf66TgpN8gtLN3sgYQyGW6NLZ8YT1BpB53128e19RzDW1WbDZRqpYWSSpjfUYzftAO2
	2kXnl77ECB3WkV94x8+YmnuXy9SFbtomIal5lI9HHXh7rpdOTaFl8Cugegc3n9OS/kMoXz
	Zfs/fPxMxsEoDpLBtT49vJ73/h7ck9+bkboe4LfyoL3cuzluZg4DOFBcWsZHj/rkFDrizJ
	/py+6FNtlESawWgspQgAgFx9P8fyWh0a9X3GhbN/QVfdUMM92Thextg90L2bJ6wEjeqV/D
	s/gRGWqUYIC/uabB2SYTVqIjY000wj7G5T4NMSYt91SMwV816zQ4W7zJ3Px67w==
From: Frieder Schrempf <frieder@fris.de>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Frieder Schrempf <frieder@fris.de>,
	Adam Ford <aford173@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
Date: Tue, 10 Sep 2024 20:14:51 +0200
Message-ID: <20240910181544.214797-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This small series depends on Adam's series here [1].

The parameters have been determined using the script here [2] and validated by
trying the modes on a Kontron BL i.MX8MP with a HDMI USB grabber.

[1] https://patchwork.kernel.org/project/linux-phy/cover/20240904233100.114611-1-aford173@gmail.com/
[2] https://codeberg.org/fschrempf/samsung-hdmi-phy-pll-calculator/src/branch/main/pll.py

Frieder Schrempf (2):
  phy: freescale: fsl-samsung-hdmi: Add references for calculating LUT
    parameters to comment
  phy: freescale: fsl-samsung-hdmi: Add PLL LUT entries for some
    non-CEA-861 modes

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.46.0


