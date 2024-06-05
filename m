Return-Path: <linux-kernel+bounces-201834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D131A8FC416
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B749B28EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59218C320;
	Wed,  5 Jun 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jOk6yNC0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ydim+jt7"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0E18F2D9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571086; cv=none; b=KWPqbG6eB2gUSYTdtJQQqtSoDQ1VS1W0JR+IADdGM4BOPBYm+wrQAxHZb+RDse5fk+Cqn4n6YA0FhHJbhW890HQXRHkPQve0XyWsA9lMokGNB4G/tt5vrx4givsU1IpTTAnWFkbb3xQ52d4iMnMWTrt93MQor/FrdW2eLVfhdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571086; c=relaxed/simple;
	bh=aA3gzgfxZL7ODPzMLLZcULXmBm86Hfo91sSHuzsGWZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVHfTiM44zajmPQdKUqShJHAZz6CZCHPEGYhVI0Q4DLuccoJ2jp2GySuDDBUanOsOUpcJzTI1HvPmcOEOXPl6xnQWaY2xUTr17sbvXl+7cnYj5JW3SIz+r0H3W+bBDsx5JPX1z2fK+I2XuSn0V3w+HKeMaDWBReRRWMkjli+zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jOk6yNC0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ydim+jt7 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717571083; x=1749107083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tny4urOKP1hG4GyostbdQ0tj+3C5fvmupwv+Tji7RE8=;
  b=jOk6yNC00M3Zq2uWC6G1wGTI3hrQvUDuRQUeNXVefx83mbDqpMYGzNS1
   Wly+sBEYYZsvt1KFpct+gx/AAOt7kNdJRO1wKJh3BXr32xJ9Chuqp6+mr
   530QryV5f394oaRCIzmT+KZgQg4sDr5FsJ/WPXyAxdlDwcXz2UNLlig/f
   +mQvewLl5XU/skCprG0n0XwS0SagBWW9nIN0rGsctRikXpKmluLluPVNa
   8SCwrVc4FW+g5d/HWxdgn/FN7AbhPanp7fhttCAycpenja9ExJZ/zxvLN
   /sbU0GyUAXSmcjvl5K/BkYpm3vOovsi2aq609In7NtlMOaWDBqfiqwl/b
   Q==;
X-CSE-ConnectionGUID: oMdMGqVETyKaZS/Z5gcyIw==
X-CSE-MsgGUID: MxYZKWRsR4OICf8qWKnHyw==
X-IronPort-AV: E=Sophos;i="6.08,215,1712613600"; 
   d="scan'208";a="37226798"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Jun 2024 09:04:41 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A26B16F8D6;
	Wed,  5 Jun 2024 09:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717571077;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tny4urOKP1hG4GyostbdQ0tj+3C5fvmupwv+Tji7RE8=;
	b=Ydim+jt77lc2GCS79Gq83lvss+v0OFlzt7CZfFYQ9d1RgPBZkYtfHNaTSECeo+y+H3yw06
	FELqAZ1b7MkKQOW6xq7T7Jqq/SJFpw8L06oNoVXJrOg3RdP505v5N23e+8zJrsngUP3H2/
	qIl1F+9BWkyXl39dlUyHZrI4zFfwfh9bJh1Th5SwRQsvj1HPPTe9ZGxd5TcoccAuA/i9BZ
	9fr+LPMPirw2vbauw/jEDxZZKXPHvTET48J9SGlUOYZJu/7vj/E2EevbAR7j6rNfCV9rM9
	/ADa/rqrD/UVFIN3xWaazCx6cs9o3RvsH+zXFyvEOM/bdp1XdbMcsZZc5fxBcg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/4] mfd: tqmx86: make IRQ setup errors non-fatal
Date: Wed,  5 Jun 2024 09:04:02 +0200
Message-ID: <bfeefbd89ee5a889c4ad0549f6a60f132b332d6b.1717499766.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

GPIO IRQ setup can fail either because an invalid IRQ was passed as a
parameter, or because the GPIO controller does not support interrupts.
Neither is severe enough to stop the whole probe; simply disable IRQ
support in the GPIO resource when setup fails.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 2a4ce114d5905..cf27497245322 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -259,13 +259,14 @@ static int tqmx86_probe(struct platform_device *pdev)
 		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
 				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
 		if (err)
-			return err;
+			gpio_irq = 0;
+	}
 
+	if (gpio_irq)
 		/* Assumes the IRQ resource is first. */
 		tqmx_gpio_resources[0].start = gpio_irq;
-	} else {
+	else
 		tqmx_gpio_resources[0].flags = 0;
-	}
 
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


