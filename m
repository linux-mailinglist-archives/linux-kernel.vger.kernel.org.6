Return-Path: <linux-kernel+bounces-217293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22890ADE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346911F221A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7537195962;
	Mon, 17 Jun 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Lo2RxjUH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bKNTKMK+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83708195982
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627062; cv=none; b=W4JPMvsa7fmQDau+3NYdH7hP1kbvGcRoA84d6GibUouqMx3G/EfQL8NyDVZtPTsjbZp9dmPGM7Vh0wgocDB4aXOhMqto7+FrD9HJP/+2yxZ79v6+33cxvkBFyZsvGi5uXj72+/HwrAeQxkhNnDuWggKybpkaaUga2PrRjW7iT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627062; c=relaxed/simple;
	bh=Q7pgEmORoCr4lAIEZ2vvubnl2xt+O684UNiX6NHUe+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9ceNGCT08CQl+PTLwol/IAThrRHvm0agngmMCjRkploeNaio8I92e1VAqDTp2erAOLYIIIXk/D61lMYHjVjCEI5GNYKtzzRYcCmRUixs4xunWZfK4BKKVHI/+nZ8yqrozrub7TDH0TZUxQdM0I3SLhPkQol2we8jc249iVPn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Lo2RxjUH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bKNTKMK+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718627059; x=1750163059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5OJFiuCWTwOE1SLuw5Yy/LFx6aQ4PkzuXRMX1a5ZLg=;
  b=Lo2RxjUH7arNWDLQkJ8RAL/jEIVSJccGwzeNODrKgMsFyFSrtP7R8sm7
   AaLhXjMq13v01Y1LrOZysBWFaQjlsWluafe5YjH29emnVDM+CyoxWAl7k
   alBK1Qs/VQfyj78Q2if+uwxHHLaLt9rMh0QdPlGwX1EJe23cc7fqWNq3u
   svSRqfU4GncBI0ZsGVuFM/PIkTGVMUYw0FI+Dx7MSqai7eCfa3/xDvZ/8
   NOUAB0O9Ln9bQ4a5Rm81CEjkqHAXJUOu2CoGtsJypdlQqHgQ9grmv1O1d
   8iqpWEjZYvbzGdArC0/K6k52xlYA8ttq9Rj/LlrFqcKrdJpWNhJc0W9O8
   Q==;
X-CSE-ConnectionGUID: SaLoz0vQThaNRufEfcEkdw==
X-CSE-MsgGUID: jsFjyQ3PR/eApCPwkPJv2g==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37427061"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 14:24:19 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2B69165A5F;
	Mon, 17 Jun 2024 14:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718627055;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H5OJFiuCWTwOE1SLuw5Yy/LFx6aQ4PkzuXRMX1a5ZLg=;
	b=bKNTKMK+mS7lxLoW5JDks21wBhNNHlR8lpGuI6nGe01JL0wclwCLKSMuVmzJpFoYW0nJiJ
	kJzEInDt6KFn1eStnQM6RDZ0iLIx9Tdg4dVq7s/lseDgZvahA1gknFIQG9yl/APpuUBreH
	DKjXimK4tx4at5M0yE88+1Tv1In3YJwBTnIeocbm3Eytd+t2fA9CTnusiKK5QGQb8+TCXV
	kX1n9wV5YApTM4T3spSGCNbvmNreEgiL+FmY2BMtmt9d7p0Ld5NMHDAj/BwPhXT0NxoZOd
	B8ypkaETx9MyBcRJ3yNqE5LDRfI1YhPXySDFmYZ5i49vyLB27CjfvkyTEZkthQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Date: Mon, 17 Jun 2024 14:23:01 +0200
Message-ID: <38a69a56697a80486067f7817d4d0ed3bdea4257.1718626665.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
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

v2: no changes (was patch 3/4)

 drivers/mfd/tqmx86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 5aa51ead00a28..7f9ccd83278dd 100644
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


