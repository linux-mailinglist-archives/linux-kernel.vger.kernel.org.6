Return-Path: <linux-kernel+bounces-300907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE195EA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B9F286E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D913213C;
	Mon, 26 Aug 2024 07:27:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5312D773
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657232; cv=none; b=E5zo0j7uqMy+mEoEG69ETcj2D6w8x+veCUFBtt4E8W61yGu7nSQ+/Tmvh5GKT86DARUxaIFWrvdkCdlYerw3WU0sh47v/zvUD+z2glHveH0SriWwSGmn1AxqJhWuRbo/MmWLusfESQKjk3Fl8VRlnPVnMdwKjK503zX9v0GZyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657232; c=relaxed/simple;
	bh=RPce0U/YUpPYjEp4lRO4eYswbyRtkfoz8XO+AxXbLPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPFwrAQ5RA3CP1XRlAdUqIJcl8pa9DxZal248u948VwgFGE5E9c+sE6ijhg4e+RPZ5naxUu9GZi2EoeJh44w3zepo7cP4gA/LBX8aGSX332vVoHC3ycoENEePUJmPwrrvt09JtFWlqil3zZTT5Le1Cp7YBYNRSLCElHoXBKt4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0005HP-SI; Mon, 26 Aug 2024 09:26:53 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0038Eo-1E; Mon, 26 Aug 2024 09:26:53 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7o-000hSF-2y;
	Mon, 26 Aug 2024 09:26:52 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [RFC PATCH 0/4] mwifiex: add support for iw61x
Date: Mon, 26 Aug 2024 09:26:44 +0200
Message-Id: <20240826072648.167004-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series adds support for the iw61x chips to the mwifiex driver.
There are a few things to address, hence the RFC status. See the commit
messages for details. The series is based on wireless-next/main.

I am sending this now since people requested it here [1], but as it's
out now feel free to leave your comments to the issues mentioned (or
others I haven't mentioned ;)

[1] https://lore.kernel.org/all/20240809094533.1660-1-yu-hao.lin@nxp.com/

Sascha


Sascha Hauer (4):
  wifi: mwifiex: release firmware at remove time
  wifi: mwifiex: handle VDLL
  wifi: mwifiex: wait longer for SDIO card status
  mwifiex: add iw61x support

 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
 drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
 drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 81 ++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  4 +
 .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
 include/linux/mmc/sdio_ids.h                  |  3 +
 9 files changed, 205 insertions(+), 5 deletions(-)

-- 
2.39.2


