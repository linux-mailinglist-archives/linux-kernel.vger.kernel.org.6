Return-Path: <linux-kernel+bounces-275191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC19481A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F911F23314
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD15716BE30;
	Mon,  5 Aug 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KMWVr5d8"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA216BE00
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882688; cv=none; b=se2VLW3g/lwSkdfQWOyCW7wghMsR1zMP/2UIAFEktlHmzQ5xwDviIL1KRfjA6Elfk4lqABYcNYkSDcaBh8rCeAOdbVk4lIgBLt+UYP8ICv/0PFkcl4ky5px20lQwT5C5vx9RzYaQd+fJVM0YmndnwLruyNB7RtajkM/hpHLJJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882688; c=relaxed/simple;
	bh=9IXfsH20XvSwQIie4Zhn+/T6EtzkHPcaklqjFILszaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb5zgBRJGcr5OSU5e5vwTUwILKXPoEtcCAiAl0aXPAqpJqPivprXtgz0glMUleU9bAK/Wara/xx6h6tukzQ6DO8ryOtkH4+S7qpw1U8cPlwSRl6euhx2OAowN1oTEmD2rn0ZUFCkVToDTBdbpNV/IkTAJxA8/3OlJHBl3PH7fCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KMWVr5d8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b3e127718so6205445ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882686; x=1723487486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxGzwj10hbPoGUDFHjUigzECxz7Emr4gq2Vxs8apx1I=;
        b=KMWVr5d81ns6yMHyjRDRzC7XAfkhwW6RNwK3aFys4i0PYzoF2J83ubhqAyGUDIpqG3
         PVmjeYgSRQasIIWr4BkoR4KPL4Jstl952HDmY1oQqWjdw0nU1Bqk7pu7KBuiKv27PCuH
         LskDYJgnUXASids/YPfIAqIJ3sXzg3K1pPPm9hwC1ju4tCH6dCqSsYKO/uynJ/jaxvcs
         y+EZj0c9ScBL1NofsUypnFM8rrjYp3FIu9mXSikV5NJczi/qhlg8GNcKdlOL7wt8cDvG
         aOaKSDdLWs2R/YltMPEQ9DIM0Q/IeL2ah/Yt48zPo0LLw681Km2ImAuxkJgGT85tOjtV
         +kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882686; x=1723487486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxGzwj10hbPoGUDFHjUigzECxz7Emr4gq2Vxs8apx1I=;
        b=He3nrVaJKA89+jr3v6hnUM1PwT5LmxwnJwIxDIAHeOP16LB+tMnZKYmYdPn6lk0VZU
         aOS+8jsxtpdjEd5JV6coSrdqsB4xeFGm/Ux1cPG/5VCaSkMNg1kGgiEva03X9bzMzFd/
         gxLg9EaGWHd9SdbCBeIAkYvdaWw01g65dWyiPQHmYFeCeFEHsBjQTfzsyb9pJcNraQe/
         zwGJ5kBtsqFFAfe4tOSR8EbDHCYa82Rtruo7Xeb3LQx7x3oZ7aSZ51FgqtTs8UJ9s9y2
         fG/mUlCkEZjgleeOpglEQLR3AgSgwUUWGWqZ+LW0jKi5xf/oBqUipufftrMpsKKxQKns
         cN0w==
X-Forwarded-Encrypted: i=1; AJvYcCVgXEmr0X1hd2G2nhd7EtvmnbvO/h+ZEkQVvLlIWhvrCKONA4WDBAR0/LvjQVxB/Oj6Gwzi87tBFldIbtVHkg02NcRpKVAxheSjCnPm
X-Gm-Message-State: AOJu0YzaR0HSxAFZOgPpHd0A1LE2FQvfcVBc1toZSKwUINz3cHB9yk3Q
	KljDxRU7L2B2EFhq0rNZfT3HdrJCDyia0Sb7dzGiImJxHG1OaH/e8IycZEvVvtA=
X-Google-Smtp-Source: AGHT+IHbUX5iMkWxY0jz/xH/juQai5lNjO2y87fBuXrzbN7VDYTkNYag15NCr2K+gsamtX8MhFXyAw==
X-Received: by 2002:a05:6e02:218f:b0:39b:2ca4:e391 with SMTP id e9e14a558f8ab-39b2ca4e898mr107173745ab.1.1722882685753;
        Mon, 05 Aug 2024 11:31:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:25 -0700 (PDT)
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
Subject: [PATCH v2 5/7] can: m_can: disable_all_interrupts, not clear active_interrupts
Date: Mon,  5 Aug 2024 20:30:45 +0200
Message-ID: <20240805183047.305630-6-msp@baylibre.com>
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

active_interrupts is a cache for the enabled interrupts and not the
global masking of interrupts. Do not clear this variable otherwise we
may loose the state of the interrupts.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f2fc862fb21c..7910ee5c5797 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -483,7 +483,6 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
-	cdev->active_interrupts = 0x0;
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
-- 
2.45.2


