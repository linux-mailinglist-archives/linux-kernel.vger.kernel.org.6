Return-Path: <linux-kernel+bounces-562948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17CA63509
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504B8189039F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1701A23A5;
	Sun, 16 Mar 2025 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RpkTebEz"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0119DFA7;
	Sun, 16 Mar 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121163; cv=none; b=EJnxLAsqEqWsvYU3uePQrzBLa2XvPHVhIyiJcprawOqu0AaGnJKMq5gu2eDmi0Mm3yt4MK320r7eAyoXNOzYWQB96tRgGP6hCa9HPz9cfD2hiwGLlf3d0aTRWAozNh4BXGX7ujcMTAscr+5kWiDKn3CGVRglK0idWeUKQ+H/QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121163; c=relaxed/simple;
	bh=NMPLQeRvp17Mk+Yjw0Ym7i5U904LNwzrFSiWvvfOcsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffEEuq+j/eU8GFL+g0QMJjEHZjxxD22waN/MViaznT2uoCJ8RGAX2ZgKgXyokY4VZZNbQ6sMmfZQPl+MkL7PSZhRqsuJeM7wdxx5NPo89EFAXhcBVZlWlmYepop00RIusaIS3VLjtB7kgPmaIszas38eZmkHPNKtGUd1PgrrWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RpkTebEz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 664C846361CB;
	Sun, 16 Mar 2025 10:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 664C846361CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742120842;
	bh=DAFPVgIz17hFI8bUHedfUHl8J8FHc6juaD+ei7zx+wk=;
	h=From:To:Cc:Subject:Date:From;
	b=RpkTebEz3IFd8ugfP9npZqvS0rzPExAZ+VASvazmljBkLjnRFQ2qkdxp58EQxHOgz
	 iiRVCFpMKjS2I6TWW7ubCHyk+Oto8DMyFllmfBGVsvhc7rkkobyLvIGYydeVFiunNH
	 0V16ziOMUp0s30bZytxFkW5wskVlA9abouCARHlE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Peter Chen <peter.chen@kernel.org>,
	Frank Li <Frank.li@nxp.com>
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
Subject: [PATCH v2 0/3] usb: chipidea: ci_hdrc_imx: fix some issues in probe/remove
Date: Sun, 16 Mar 2025 13:26:53 +0300
Message-ID: <20250316102658.490340-1-pchelkin@ispras.ru>
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

The other ones perform error path fixes in the probe function.

Link to v1
https://lore.kernel.org/linux-usb/20250309175805.661684-1-pchelkin@ispras.ru/t/#u

Fedor Pchelkin (3):
  usb: chipidea: ci_hdrc_imx: fix usbmisc handling
  usb: chipidea: ci_hdrc_imx: fix call balance of regulator routines
  usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

 drivers/usb/chipidea/ci_hdrc_imx.c | 44 +++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 13 deletions(-)

-- 
2.48.1


