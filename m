Return-Path: <linux-kernel+bounces-217289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C590ADDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FE3284F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88EC195975;
	Mon, 17 Jun 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZWusv5Bq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eY95p1T+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB76F06E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627048; cv=none; b=hHFEYVTPvUI1/f7K2DZHSOX8wpDDMSvqRHkilj9qF2fYz03ld43FKEunCu5WXRiGnbOnyVsaVBTPLESfbAtLs4Lkh24uBVtV+YwYeLAcPaCyBrQO8cWsqlCPF9spmNvBbeH+wek8sYJZDVI/1HcEj2d/rS6Nrimtt/un3ovJikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627048; c=relaxed/simple;
	bh=f6mUuW5V0+nUe6WiIsHPLIVNrPCv/YBwWG2prgdq6MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OxOf2DkUU2cTgJU1Qnm8PGmuGcTlyqpk6l5B9uGYcx8CGG9NjPNkeEJ8ae1TnFUg8dlehbTdURF7MqCBJZvfzf/3rru/6TI/Vm2bnAtGdS/dhMG6DVWB0sXLPBGwGhwUNelGZmJ6HHitg1CkUaPD6n0glGRPyUEzv+xCKmdq6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZWusv5Bq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eY95p1T+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718627044; x=1750163044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BsRvgrK//WxMzwVtEgbuej3Ablp8Xs0HlqHrf1unNxE=;
  b=ZWusv5Bq0+yH77ldv/kpiNANwHY8JTz31xFej++cUIalXKDYtTh5O1OP
   xuJHuybtKlVr8AVsgkZ1h8+aRcElH9SVmBufjNqrTlzVc35gBdPNev8J6
   86BxYNAuLGDdX1tKWV8pXV6Blozc8jXiFRo+GxEuPk62QGw7hWfCzwd6R
   SFT8Hf82AqiTLHv2zG9V60xxSiYbAoJvJ+DuuGs0FwM6eJ+B5jnc49wGN
   RNj4xHc1WmW9Zt5Gi9VJjPGvSdMkUpJUgch8pqjBTFADFNJA0N/0fB1Vw
   eVI/pPxOr4JQP9yYmsuuW/0HqmjkPGCzPltGsCX7Ig02/z2lBAcHa7aYe
   A==;
X-CSE-ConnectionGUID: h/vS4stERiGJds/CUXx6tQ==
X-CSE-MsgGUID: Nynav7+MQnCWGkG1N0HQ1A==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37427048"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 14:24:02 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DAF41654C3;
	Mon, 17 Jun 2024 14:23:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718627037;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=BsRvgrK//WxMzwVtEgbuej3Ablp8Xs0HlqHrf1unNxE=;
	b=eY95p1T+jJ2mWMKILCio8Jy4Fef+64pWJvlXN/eRG5aB5b4ZEDIOg87gy7OfVsd2CAGgDG
	JDRDqBZExRZH/9YAlFcmezNbKlziLQN35IcEP7KbFnX+RoQIPeJr4QtGHwTN9R5jnCvR4v
	iRtXhpGQnrY5X+8WKve62CwfzpxLznaVW68H/RC67saoksSXIBgUVweIgDK0tmv9CAbfJc
	fzGKPnqXy8M9AGF5/L69qplDCQSLKucwX1+IL1Olfj0qqPy9vT+yy6AgZ4xW7kaowT9ZV2
	O3iQj86tvcYfg3noNXOEMeg29quP/pQ27xNL9B+M/rmhxfrwD9HFRMH2X46krw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Mon, 17 Jun 2024 14:22:57 +0200
Message-ID: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Patch 1 adds support for 3 new TQMx86 COMs. GPIO support on SMARC
modules is currently limited (not all GPIOs can be controlled, pins use
incorrect default directions, IRQ configuration is handled incorrectly),
however this is a preexisting issue also effecting the TQMxE39S and
TQMxE40S, not only the new TQMxE41S. This will be addressed by a future
patch series involving both the TQMx86 MFD and GPIO drivers.

Patches 2-5 improve module parameter description and error handling of
GPIO IRQ configuration and add support for configuring an IRQ for the
TQMx86's OpenCores I2C controller in the same way.

Changelog:

v2: improve module parameter description (new patch 2, adjusted patch 5)

Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (4):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: improve gpio_irq module parameter description
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 111 +++++++++++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 31 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


