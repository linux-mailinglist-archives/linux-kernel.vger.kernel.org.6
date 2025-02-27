Return-Path: <linux-kernel+bounces-535666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81051A475BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646103A29E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919D2206AE;
	Thu, 27 Feb 2025 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjWjdJOQ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20B21D5AD;
	Thu, 27 Feb 2025 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636118; cv=none; b=In7F6+90J1Mc1bpXX/b67IMUhK0TfORIpaF8MgQ+OWm+YjNHTyuq/Sta8VNwaMaOc9IZVL3QfcSDetVCDltIQtKxQ7l1D6fH68o0Nquuxf/DfEvnOQtPoadR0UwyWXTQna1jWrMVAdfoX3FPgclyNNw8duJ/Al4jnM67hY/BdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636118; c=relaxed/simple;
	bh=9Q/5fhQklB9IJmrBT5IrEVLkeSwQGbC8hw42rvNgFTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IDZxGAamJ0MbF6Bq/e6Gi6tT3yq9g7QPEhev9he2lCdtvj+ZfUoRtvFjAxfbISPySM5Dmp9nz9SDCkBGpphhq/4k72r4RuKvncZctOojHic4Dt+07hhB4wUxzBNSXqWFN3J5lTuIJ+7n/hsDc2uGnoZfWUVUNi7Qgyzn4qZwh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjWjdJOQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso929842a91.3;
        Wed, 26 Feb 2025 22:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636116; x=1741240916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfcsKyxsqqNF1ObsRkAL+Fr53iDPz5SE+sP10CWPKmY=;
        b=GjWjdJOQGgauSlbvCKMHgfeVoYodh9GyfzUYB+qNogTapeCGtEqQiNPHlQ86gN2XSL
         xUhH5bpQwi4f69uaovbF6Y13Ieo3Nr1jIJoj7mhO40O+2xAXF7/KAKzQ7zxb2pfeoMLm
         0dCAlghl35LtnJz2GvJ5ACIW2v3Dqsw0FX65RwZTIGCXZRehBMRfwPjTImEnzSphqMjf
         zpMtZPhm4/inQFooaWU0/yW+zqVddpF0+tVd5HynuCh30v9F6clMNEXKghPZdDIA2mpA
         8yTvSXozU8t2x64DWZCf9wDcj3XTU5x7Oviq1THvlfNVPOkKn1DAdx6co7BNM5yGeQVJ
         IJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636116; x=1741240916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfcsKyxsqqNF1ObsRkAL+Fr53iDPz5SE+sP10CWPKmY=;
        b=ZQsTtBhfRToD3EHnsCBlXVmQx5ONdNng550J6gf42QCt/cgMIn7Ce52xngnJyjWQjT
         UamAdKLuh0VRidSlReDk2hMYDRCQW61FH1fV64T9NSo8eE5Lvfd+PyH78vJvH9zkoEUI
         ZwhE/fAgSrtq4P97N7BUrB5dViFdiHn9ar6UlRVb5F55OziY2LFxwu04idTqMarKSHRT
         dEi6Aa9SwIQVh6+bT9m4iV0tJ339fiVvPG6cFX5RpPa1ewjbOK5Rs5PcpONe/IKz6ibA
         w9WiduFei+ru101ewwc+uvw19Kl39ZDuXCYAY6qY3RRJedWAz4R84El6uayuPJOuQtN8
         8Xig==
X-Forwarded-Encrypted: i=1; AJvYcCVHKamOXkIWKe18Q/1ewuDjdLCjpsTdHM/tAxOot3ZDFmEz8XqJCT2F+0CIi5t3HXzWn8oXgkVj5+Vw@vger.kernel.org
X-Gm-Message-State: AOJu0YyWx3rCNIBg8kpd9a6gG9boj5XDww45Xp69j7PjL8jWJHUr63EU
	d9cwM9jKc6JWxiXFhs9T3+8sicFmm1vYFW74fcnlMEjIGqYKgfan
X-Gm-Gg: ASbGncuWQeNZ2JSMJ0+Hp7L3neA8YDBhLFzgQDpBOiH2gL4pTGG4Lz9WirRLFeeVMGN
	lXfipCKpt1zx6zrojB5BoQym8I9GaUIjg+KxC3h7JbW0iY3CudIEGNJ8xhIZnuQ7Xq7F9NIxFAi
	/kr1hWuklbUXBe33/h1tH5mZ2FSza81GxxayhM+6P8KjO23OGGPBJvN9vu1Bmk6OZaSVbOPkAIB
	xGjiyOf2hhfVq/L41iAy5WoLSE4xfRpMBokFIrFGtnQomD1Cng+gYuMyrF15jCpeq/TnGGFstAK
	6zWVsN5jlYN08Boz/gQVOWummlAmPMoRBuW9
X-Google-Smtp-Source: AGHT+IE958nyxT/MQ1RXRPl3RO6BV1mQ+QuBOyNiN7aTAS3Jr7cbgeA5uuT5xa5jaBuU3GsTGvI1Fg==
X-Received: by 2002:a17:90b:1808:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-2fe9e6cb035mr4296027a91.18.1740636116626;
        Wed, 26 Feb 2025 22:01:56 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm2728177a91.0.2025.02.26.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:01:56 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 4/5] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Thu, 27 Feb 2025 14:01:30 +0800
Message-Id: <20250227060131.2206860-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227060131.2206860-1-yschu@nuvoton.com>
References: <20250227060131.2206860-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state is SLVREQ. Check the
MSTATUS state to ignore the false event.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a0c6d8053a25..952afc75f6e4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -59,6 +59,7 @@
 #define SVC_I3C_MSTATUS      0x088
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
@@ -617,6 +618,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
-- 
2.34.1


