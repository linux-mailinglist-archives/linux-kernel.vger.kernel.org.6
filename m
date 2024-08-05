Return-Path: <linux-kernel+bounces-275192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392279481A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79593B23713
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267C16C6AB;
	Mon,  5 Aug 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jdVMrfqB"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E516BE13
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882691; cv=none; b=X5XMGNj+Syc0eJwyqgZyCNQDIJu8PuW4V7rQ3b9xmRJhciku3c1xXzywyV/ss+SzFgdjolb54Q194Cn+n5WhJUK938DdKSawN6pL24DH4yVDdpGQEBKok5lMdZ6ZyiexvAjn/j56r1nvFiX/OFgCglI6gmB5yZNKWki56nAUcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882691; c=relaxed/simple;
	bh=J1n8p9ZiV4NPzCCG4igoxgIPW/lPHOV2bvu8WbY9M3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqJSNuLjitGFwwRLnCjPdAwYQqXkzxutXIFNy682uz3mAtGiyZwzJ6qN72Wn74G9vF5vRlf/jsihheCnX8WojTpg5H4VC4f8ua9TMDl3Gc3QpdJzFS2kK5Dbzxi6fAF/EdR92ajuJO1p7JzruGjyPFQNsLIqjzHFgIWHiwwrOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jdVMrfqB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3737dc4a669so47362415ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882689; x=1723487489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+HPjuz5W8Yx1DVIjzCZ4+iLii+dpzxtWHgPSNE/Bhk=;
        b=jdVMrfqBh500qkvXX/UaWRDgiM6YyHIoH32SOabGtu+JLyRa7+eocaSpSb8pddaMvq
         nBLjwVZkzqebwaUjylZA+nKCy6E3xA3/JmOY+yI/Mky9vbTh0jFUalpMXrlJ7UrWOwr2
         CDQ/7cntU+SD9lRAsi7bz9CxtcFYpKgfd3/J+Y+MIeHF0StI+bb7mdAVVO0MCukdcIEZ
         SYuUaTaeT/86+s+fD8mxyDmZDp6Q615EjDU/rxPR2VITH0miHlSjD39UR4oktExVgWxb
         jaSVTyVD0SpikPotCYlFZwBeP4WezB14RxRAK18+rPreb2mfjFHJhCnCUhnFtOCM2REF
         HOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882689; x=1723487489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+HPjuz5W8Yx1DVIjzCZ4+iLii+dpzxtWHgPSNE/Bhk=;
        b=XvQjjDpVqr3n7tD69vsgXa87Wgc/SqqiAa/lGFF1y2DvPubFk/8roxejdXzRq5g0IC
         c7ukDJbb2AvudX/mS0SpoFLY/yQJrmrS9NDlapqcre8snaMsRExJJr/2LNnWJ3abU5iK
         /GwGbeK+HM5Ab1QANE86Uz2J+sg/x16YYNu3ztdSofrVDMImnLVCJTpP/OkweMO0Za51
         hTfYN2gzEJ/EbtjhcBkMacY1t3Cf0BB5lLKUEOzR4WyCHzW4jagvSbI0djyvAR00OVDE
         xECryyNGUi/itWy5hukXdYjt9f6SVhpvUuTHYHjF500UQxKpc+SM9uR4PutrAneWfGuN
         lsZw==
X-Forwarded-Encrypted: i=1; AJvYcCWQbB/KmncHFxugpZfQhn0JZda5fumitXNcXif8QKx3k9g4+9jpesRv8WNAOtfw3XvuCrzqPMMVKF8MeLKBkXPZUIwqTUpopIbXdw3B
X-Gm-Message-State: AOJu0YybbSWMXzemIhi3NQjTKJYhMbdINK1pIOhY/7uGonQ2Vyb2ahol
	f40VPXb3KRID2DYkBl49iGmw/KFc9QinWNALgFUYno6TglroZE5AezA/sLD5IR4=
X-Google-Smtp-Source: AGHT+IEq6598CGYDXwUJlEvoWxu+/g6kFoPjvVucBrR7owowbQb3f7jYWmpb4FTOuABE7Ovcpsxrdw==
X-Received: by 2002:a92:c988:0:b0:39b:393e:28ca with SMTP id e9e14a558f8ab-39b393e29c4mr71466915ab.12.1722882688825;
        Mon, 05 Aug 2024 11:31:28 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:28 -0700 (PDT)
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
Subject: [PATCH v2 6/7] can: m_can: Reset cached active_interrupts on start
Date: Mon,  5 Aug 2024 20:30:46 +0200
Message-ID: <20240805183047.305630-7-msp@baylibre.com>
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

To force writing the enabled interrupts, reset the active_interrupts
cache.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7910ee5c5797..69a7cbce19b4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1541,6 +1541,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
+	cdev->active_interrupts = 0;
 	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
-- 
2.45.2


