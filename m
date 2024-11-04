Return-Path: <linux-kernel+bounces-394709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D739BB311
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53D3284037
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A511B4F3D;
	Mon,  4 Nov 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gApjbdud";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="c04IgRFQ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C41B0F2A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718848; cv=none; b=BSuZkxD44MqMsEm1i+GMKwOUTux9D5i57tgdqbC5yH3R8jZJH6vC17Ws8ZTeaeVVtBEPYDG2q1xY6n5BdnI88pJjAFhZEYGU8mmjVRdL8hqqsTmuDnfFevPz2X+xPIjcfdGB1XjGLgyRcQ2X+kOb5MYV49xEsXoNNoDOdiZDzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718848; c=relaxed/simple;
	bh=Ol1y8mi/oPDooyhIzj0dh+kbkXTzlG5y30295I0aBZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9yyNVF/NuQWP5acVfujQWF3DYLz/lTKc0fLcplqJ1vkia26kH5jTGYTFpyCt346VjdzuKhBAZ3RlemGFq7M/fgigmj9mQvTFHhvw43ym0ya+GSaaIFp1OqJGSFDp4IGbsj9goexBdqWYbu1EugjsT65bwl49v9ly10BbqUqnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gApjbdud; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=c04IgRFQ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730718844; x=1762254844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/Uc2z43dnHV83Mvg+6SBN8Ls2mY+7tY2PtsECwrTxs=;
  b=gApjbdudDPgTilhTJyuu9gHBBt402mvHzvlflRG80Je0nKCVg932jNUP
   ejj6UtPvvFkmMcJrOYaddGHTpdM3tGi7F3sDbVgoxM4EcTOF74mRn8hoj
   HyU78oSvjfox41rHmzZKn8GuOezLi5f9YNEoXEz+cV0xk9vPjTJHOTRWh
   2jiHGnPK9U6MevTcwzpA19/gEOfsHy7npJBpi1zRMtIy8dQuH6t7++Yjo
   YGEpXckyn/CYPwLDwE3wmJs9PskUtSXRcMdXbpFrv59zKBWsMZW78E3vX
   8vysLgWdWq2w1dYMVPjk4ape75FbEcQv21khvjWMGHrxcXFdsDw7Ki5/Y
   w==;
X-CSE-ConnectionGUID: Zr2THyCWRmG3584bJQuy6w==
X-CSE-MsgGUID: FngT7AkQSpKZZre3APNMvA==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39829935"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 12:14:01 +0100
X-CheckPoint: {6728AC79-16-5736D786-D50827BE}
X-MAIL-CPID: B2CB541A2DB8849C714D5A63816521A4_2
X-Control-Analysis: str=0001.0A682F28.6728AC79.00AD,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2FC0167D2F;
	Mon,  4 Nov 2024 12:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730718837;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=L/Uc2z43dnHV83Mvg+6SBN8Ls2mY+7tY2PtsECwrTxs=;
	b=c04IgRFQm12eSfB3CYuzfSAKd2XGAv4VQovAZwmn9gvpOabUV/UhL5MBgAP09DuiFJAVuo
	Kge069nzFrDFgMqhLQafllDU5co4IatnFS8u08RATy/vEdnfe3BmQArMeOXS4czP06sRIf
	At1G5L4rLBgPpWhKAZkXBpL4xnI+KYjyDZsTxotdruIdRn9TUQmFj/CNfJ1qQ8oXMEMhNp
	qgx2QnvD7b5NIKtwqa0DaIh2tOIg/mAuGQVa/rE8pha5UJcGKLkoiTBfUZEHsX2TrdNgql
	zFUOhEgM/oMNAr7WsJpX6ZTHfqzBSef337ziNfimvEqlr8ZIexIK4GYtS91xAg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v6 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Mon,  4 Nov 2024 12:13:28 +0100
Message-ID: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
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
v3: replace IRQ 0 resource entries with empty placeholders to simplify
    error handling (patches 4 and 5)
v4: remove tqmx86_irq_to_irq_cfg() function (patch 3)
v5: move placeholders to the end of the resource arrays, use defines for
    index (patches 4 and 5)
v6: remove obsolete comment; refer to I2C controller as I2C1 (patch 5)

Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (4):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: improve gpio_irq module parameter description
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 105 +++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 34 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


