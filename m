Return-Path: <linux-kernel+bounces-275187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8C948195
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CB9B22A81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD2165F14;
	Mon,  5 Aug 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PyBQM30F"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8C165EF1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882675; cv=none; b=NEDa67bZeDoAd4i/DJULKer17Pmb3UfHMbBYb4B+NX64bnpnyiAGxLwC45XRLlwzMMqIl1i0wGb48rNQsbZzZV32/B+th5PVIVzpmBpY8R8sgyMZ5fsXORKrEQ0hCGrtSBsyzxMoTUfkMCpgp6DxuEs0zvj/d2ps64pBLRZidqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882675; c=relaxed/simple;
	bh=umTkgL20LJJ5BJ5TMY3wbVVZSYY4K2TQqLUKPlJzF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cftRp9IIvlRr2u5yLAKNnnjp/0oIqRAUlw7c+5k0b01GlFjVwuVK8Eu5uaDMAPVdUQtwjfTIAxMhCD4WzK+TJw7kT1MSKy9j4PemuSJhXRmYTSUyx9qM54lyOnObe66ffSqEdTRNJy76mKAjIAtootJzbOzV997pqvjT8CEMgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PyBQM30F; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39834949f27so49515175ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882672; x=1723487472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rRANtn5FFSQpIi4AkDQO6AI/rum9i8w5k7JfryoiRY=;
        b=PyBQM30FVh81u26deIUXzTEP3TayrqVtrQQwzT4xEK42fQcy9zzaSrbDc3ApfPGndq
         MrynKJ7NSvlx3oWczZFjM4T83VDLiaV/F9vpJorhb9MY4l2dIKpY74ZS9AN97WuRWhzE
         X5+NpyOn81fTFOeboNzsfb6DaKqYvXJwyHxzCj2+eHuW8dWluYuuHcxp7xK078TSl+Bi
         76Q8dz63/FXAjCIxDZcdE8dTadnnsOuh3LUUrhNHcOKYfrnqHka9J8zLmGBAY5usB0Ew
         TrNRV3XaM4t2czpUDKvc8+FUWSTh2JsM3oGY5PeucZLcFn23Lx4ZIBtd+tetMoQcDeda
         hRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882672; x=1723487472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rRANtn5FFSQpIi4AkDQO6AI/rum9i8w5k7JfryoiRY=;
        b=gQTy2HHnJBPl6O4SN90dhYKiaVpMJJdxWM09gv/YaaJPe23kiYzsvStvtU7a++mt6y
         Kel8Iuhdh6ogRYEFLyptY4KsotvQP5qOwI49ZxJQADa7FnSRtwDtGD8rdzb+04gH1DEY
         CFIAAQfGY6DV9y1C+V//dZvzyt4qk1X6HeI6JwArnX+aK5uPfttjQypx1aPx4iSTFeEB
         kUfM16plxMMlYdd6DWDVymoSSX47AmV80dc37SeMjmfAEZXFCiDx9kxoCtJsuIeEF9sN
         2n9JRlLMfHhssSRAt65zUd7QDv06H1RmbEfpB1+TG5jhTzOipJ3/AYsUX8q3GWOE9Qdz
         ZDSg==
X-Forwarded-Encrypted: i=1; AJvYcCWcEZpbvuR75UTPqnRBFRdTeLdVcFp/yUu4sEgYwG6Ha7pfe4Uv+1J5AOP9Z0iywUgN7dKw9HmTmVYlTvV4oPVtDKG0s7Ix/E369Te4
X-Gm-Message-State: AOJu0YwTXbGyaXsECzfPsSQbeuv23Q6nwK74bSh+jOPv/n7xbX0tlplR
	NS4wgeYDD1/0KKQeiwAmjN4D9ykAQzV3PNM//eyUvE/v7e9HBZFhx4h5qMn2QVo=
X-Google-Smtp-Source: AGHT+IHeeRmQwv4+q4ju/q0myu9Z6P6bR4evc/LRLY+BIe9M6etkllpDA/qldggtU/65E/yLphVmjw==
X-Received: by 2002:a05:6e02:1a24:b0:39b:3635:e3a with SMTP id e9e14a558f8ab-39b36350f02mr116839525ab.22.1722882672647;
        Mon, 05 Aug 2024 11:31:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:11 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Simon Horman <horms@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] can: m_can: Reset coalescing during suspend/resume
Date: Mon,  5 Aug 2024 20:30:41 +0200
Message-ID: <20240805183047.305630-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During resume the interrupts are limited to IR_RF0N and the chip keeps
running. In this case if coalescing is enabled and active we may miss
waterlevel interrupts during suspend. It is safer to reset the
coalescing by stopping the timer and adding IR_RF0N | IR_TEFN to the
interrupts.

This is a theoratical issue and probably extremely rare.

Cc: Martin Hundebøll <martin@geanix.com>
Fixes: 4a94d7e31cf5 ("can: m_can: allow keeping the transceiver running in suspend")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7f63f866083e..9d7d551e3534 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2427,12 +2427,15 @@ int m_can_class_suspend(struct device *dev)
 		netif_device_detach(ndev);
 
 		/* leave the chip running with rx interrupt enabled if it is
-		 * used as a wake-up source.
+		 * used as a wake-up source. Coalescing needs to be reset then,
+		 * the timer is cancelled here, interrupts are done in resume.
 		 */
-		if (cdev->pm_wake_source)
+		if (cdev->pm_wake_source) {
+			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
-		else
+		} else {
 			m_can_stop(ndev);
+		}
 
 		m_can_clk_stop(cdev);
 	}
@@ -2462,6 +2465,13 @@ int m_can_class_resume(struct device *dev)
 			return ret;
 
 		if (cdev->pm_wake_source) {
+			/* Restore active interrupts but disable coalescing as
+			 * we may have missed important waterlevel interrupts
+			 * between suspend and resume. Timers are already
+			 * stopped in suspend. Here we enable all interrupts
+			 * again.
+			 */
+			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
-- 
2.45.2


