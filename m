Return-Path: <linux-kernel+bounces-209571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703859037D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3E61F24D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C7176ADC;
	Tue, 11 Jun 2024 09:31:36 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98683172BB4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098296; cv=none; b=EHJY/UdivLj5cayjPMUxG6WMtPiDaZcD/g38GQNns5ngecrdw2WGQ+0ykAEUhGlAN5YllnXGanQibQM+cZIzE2OiRbtMOG73wdhlqPzNEsP6vxLfpYzQyMguTPPpgOYJVaob1vMgDJ9hh/2luTyw4pxZS4u7ieFg06M8Vr3+a14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098296; c=relaxed/simple;
	bh=gPE9ecK322dZPly/Tq/DdkWYuVy7hgxwgVaWhEWbTxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmmj1fS/y/5+PeA2qmm+qOTwtd0BmD6SN6C/FrxlKcFdTOW+9cPqKw9vlYtM88kL42Tv/JtrPO6RpTDI8+ARhD0ZLHXdjhAO54UN3Gp6yKjbfTuZHEZFIPXEWnJb37NsfDzk8sfcJD4efjAUG44dEC4sSda4ri8B5ptYw7xCDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 61bcbe87-27d5-11ef-80ea-005056bdfda7;
	Tue, 11 Jun 2024 12:31:31 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tomer Maimon <tmaimon77@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: Shan-Chun Hung <schung@nuvoton.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v1 0/4] pinctrl: nuvoton: A few cleanups
Date: Tue, 11 Jun 2024 12:30:21 +0300
Message-ID: <20240611093127.90210-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Nuvoton drivers to use pin control provided data types
and more of device property APIs.

Not tested.

Andy Shevchenko (4):
  pinctrl: nuvoton: Convert to use struct pingroup and
    PINCTRL_PINGROUP()
  pinctrl: nuvoton: Make use of struct pinfunction and
    PINCTRL_PINFUNCTION()
  pinctrl: nuvoton: Convert to use struct group_desc
  pinctrl: nuvoton: Reduce use of OF-specific APIs

 drivers/pinctrl/nuvoton/pinctrl-ma35.c    | 116 ++++++++++------------
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c  |   1 -
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c |  43 ++------
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  29 ++----
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c |  11 +-
 5 files changed, 71 insertions(+), 129 deletions(-)

-- 
2.45.2


