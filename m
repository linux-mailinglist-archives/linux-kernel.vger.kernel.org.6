Return-Path: <linux-kernel+bounces-275189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4694819C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B141C21D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E9160873;
	Mon,  5 Aug 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i/lLdj71"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78546166F35
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882681; cv=none; b=gPTd+MWRXDJkz+nYIJLOPv9JfHJR+XmwMsPrch+/qWEubtgFBhXmomsx3LFYX+j7rxpF20PhLiI8r4YgXCxufJ3SLy7IMYXOtAQM8Gm5M4MVwFoZBxILkPluwF76AWQ5+cjHM0vCw9cbsjNGZC2MjNYQO+ka6FKp6gTzmOk0LdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882681; c=relaxed/simple;
	bh=EbgGe2gsLdH2biBweP1nqPyr3Zg50Y1HA4LdIiHtm3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWp3/cZadGDgRfFx5bR0zl7na98CPaund5ksyFEZFEiNbAwBdrdy+oKEUqpl2N6kbL8Qnc4G6xuElX1HsdD7pQFq327+STsm9JA7kE0zxEZ7e8JYsJWOkzbjNIkOoKCwjfeRceZTMU/nE8XmIMtB5/7LP/r6a92cWOtv7yn2Jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i/lLdj71; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39b3c36d3adso6972845ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882679; x=1723487479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POgjzXRrZKTYuk9IJwxX6t4KWtvdb6O1DoH7Fypmtpc=;
        b=i/lLdj71LDY6I/w47n1L5qsJ0hwunKsDG//hiUHjMxXXt5VfKmEUB1KI9naXh4xYyn
         P5NGl+jVpm7yJIcwJE2xYNSIlAocwSV7N+sWWKfZPXoevywXlBs6GrDWH4ZVkr3lvXRX
         g0yHGKFfarFwVLSW99vgu6kHDMBfjy0sa+qBCOTP2aePylQOKgeKK+FyE7tu8RnIDHAm
         SSMvYH6sj8YpER/xUkZiXa12nBJzjzm3lkdrncR2a6kN4DMchqjomt2SjAebasXWfMKf
         NCZk1mWbQ3SX+DcSJva5Ng19jcVvYgIT/5MTmjTPOhP6G2igDu2ZT2ON9AWWIB2rGq+o
         0MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882679; x=1723487479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POgjzXRrZKTYuk9IJwxX6t4KWtvdb6O1DoH7Fypmtpc=;
        b=U8DkCZbGIAoGB5kgkekuWsVtQ+EpURuY81lLW3zbhwvWxXAuwXGxjQoSU7gOG3tQYV
         Ztiq36x//WtUgguPENepyAqMtxuNWftGBipNYh1kY9R9yIET1Z494xwtoyr8QTuVU9Sg
         7X+KG0yd25PE0p3U2sopNbxtCyE3sXbTTJQaSxPvtNHTk2shoQGJsbpPg4NpI0tn+n8t
         cuPLDvl85PQD1jh4pYolHqkio0R8lRC2kBtNojbxfcKvLxm5lkcxBoD6JpYp9sP6p17k
         2yDkz/K/+Nq1570Gbb394PlBhbYfvAqGI1J4F/7bRA7AdRaGqjzz5cJkoB5TcXUsNVQU
         V9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrFYl9zCx3RjLSNoB7y2XkV4vDcjif+Y5Lhh4N11ub5FUM7BWYLrzX0ygLW6aTF/XFzLLX+h9c0CCkjNn7YmDEjw2siDwv0URFdFPA
X-Gm-Message-State: AOJu0Yz2c5zUFOGIkpdZe9C9zfuxfcu0X8QC3ActkdnWWjom02nixd6o
	5wATv2i5Ldp/I96kPmvn65Os3src7Qs4hw1a6mewUfQQVZ8aN1xPwtZ87Uz3brk=
X-Google-Smtp-Source: AGHT+IGMnS1rb3UU6bj+V6bpqO+qUs1ylLOBvntJW8Xy8XScEgNEkHRyzpbGdB5iBFzFgK7uWf5xgw==
X-Received: by 2002:a05:6e02:52d:b0:39b:369e:ae4e with SMTP id e9e14a558f8ab-39b369eafedmr78788705ab.2.1722882679509;
        Mon, 05 Aug 2024 11:31:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:19 -0700 (PDT)
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
Subject: [PATCH v2 3/7] can: m_can: Remove m_can_rx_peripheral indirection
Date: Mon,  5 Aug 2024 20:30:43 +0200
Message-ID: <20240805183047.305630-4-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_can_rx_peripheral() is a wrapper around m_can_rx_handler() that calls
m_can_disable_all_interrupts() on error. The same handling for the same
error path is done in m_can_isr() as well.

So remove m_can_rx_peripheral() and do the call from m_can_isr()
directly.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fd600ab93218..42ed7f0fea78 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1037,22 +1037,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	return work_done;
 }
 
-static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done;
-
-	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, irqstatus);
-
-	/* Don't re-enable interrupts if the driver had a fatal error
-	 * (e.g., FIFO read failure).
-	 */
-	if (work_done < 0)
-		m_can_disable_all_interrupts(cdev);
-
-	return work_done;
-}
-
 static int m_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1250,7 +1234,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		} else {
 			int pkts;
 
-			pkts = m_can_rx_peripheral(dev, ir);
+			pkts = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
 			if (pkts < 0)
 				goto out_fail;
 		}
-- 
2.45.2


