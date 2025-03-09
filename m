Return-Path: <linux-kernel+bounces-553271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C129DA586AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ADB3A7D21
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68D1EF372;
	Sun,  9 Mar 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="LdezAKXn"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B41EF37C;
	Sun,  9 Mar 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543111; cv=none; b=Kru1/cVfjDeiHZFlAGfQzFO2BrdKOpvm8Ey8Owc0wqJdNr1O3C7GZJP7G0psDaH51eu85mAYiA27lz5tfjzuJ3E9U3kukTHqzGLTaCzKk9aQpTayPwGvDN5PIbLy9DcWkfk16XesD5OMntf8BVg7zrMkwTEtKdoBqoifk7bWyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543111; c=relaxed/simple;
	bh=kArOFI7FPnkV4jdFU99Aez4xrDjX8jRSZwANywbid/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arPgMVOuHspys7inDhOjAW1fQzBr3O6nJAROckHHWZGNQT+rj/Yz9BRqXcT7WLUcWCWh3CRoZirCNwjlKptDpxVDta6x7vOm5PqHBLXjsYTc8fsKEAbJIRW+oDZpNTwvLGEDa1zIlTlgAswESzqlTCa+0YCBsHkKadaoz0iRu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=LdezAKXn; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id DD20140CE1A3;
	Sun,  9 Mar 2025 17:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DD20140CE1A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1741543099;
	bh=WMRJuv06yskeeA3N2FREcGl3rAVnw087RmlIsDnyn1U=;
	h=From:To:Cc:Subject:Date:From;
	b=LdezAKXnM6uqo8zZeSBU08IipMfn7Z4N3p9s9pD6rx93OF3s18DYt/mh/hQuheFLV
	 4ACmDtWsWC55CGc9v8H6dexjP280RrCC3tHUa2IhwxMNe/UDVpawjya/g/x9cezdtg
	 0SXsdM7R2dZ6W0o5xEFisfN5NUOqahYb0Ajdq7KU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Peter Chen <peter.chen@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Sebastian Reichel <sre@kernel.org>,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/3] usb: chipidea: ci_hdrc_imx: fix some issues in probe/remove
Date: Sun,  9 Mar 2025 20:57:56 +0300
Message-ID: <20250309175805.661684-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a rather recently introduced bug leading to the
driver oopsing on removal in case of non-usbmisc devices.

The other ones perform error path improvements in the probe function.

Fedor Pchelkin (3):
  usb: chipidea: ci_hdrc_imx: fix usbmisc handling
  usb: chipidea: ci_hdrc_imx: disable regulator on error path in probe
  usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

 drivers/usb/chipidea/ci_hdrc_imx.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

-- 
2.48.1


