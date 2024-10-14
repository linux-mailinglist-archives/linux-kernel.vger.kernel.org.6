Return-Path: <linux-kernel+bounces-364326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67699D282
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A002F284106
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68A1C8773;
	Mon, 14 Oct 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P8cydSdK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11D1C7274
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919491; cv=none; b=HQbmhHZ80nRoiVUA9Cygf6VBj1LfrWQCHxOJXBps24QTLAzXrSxqQK74MXqTM8o5Ve8xgfjUoZXSCUIqXzJ32jNJ2vEQI8GgxuOYsmyISAnt4tnBgpncq6TXPHyWyuSrRK1ciJ0SHQT8xVIk5jyC/+/QsREUDOOeQ54926aaNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919491; c=relaxed/simple;
	bh=P/Am7rBXsNK0N5iJJRQ1pvU7nWegi2LeVq0ySNH9P/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmMciGDCLgHMQY/jXF6QY/LtlW5RFNnA71LbC6bU4ZG7YbvI1dmmVk6s3TfsTXGLRXr5EHFmxw5u5ZekDOavFYwS8QIskpjnhkRtbQjm9AYKRx6wfnZtD4geu3tYWx4BNJXakQjcP59Ga2Dht6aCZ71wNVcc1j/LFxdpbyj9T40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=P8cydSdK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431291b27f1so18899525e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919488; x=1729524288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYG5/yu0pXXht36spug+Xg/mIMYx6ohdGwedIw0qEKE=;
        b=P8cydSdKH7YH+49CQmSeXUuixs1Bq8hLrSa6uZzF9L3AkD+D/kb2zazrWvDlJr8VcD
         Xh1o//zO9/2dP1xD2Sr3rqHwhqFoXzGD8pp3tcPUg9H45BUn0TvtTc748rEkQkOG4vB8
         35U7KOMPLG6HrSUS76SoJwf6eVSfOZawP4EDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919488; x=1729524288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYG5/yu0pXXht36spug+Xg/mIMYx6ohdGwedIw0qEKE=;
        b=YxuXSgTY0LVd9Mar8+VPqgve77BkzqQf+gKtniudFBP4MUtpWC4ghXOCdOA6GXZUry
         3V3cHeavX2gyVwIAbQ5GbWrfgCCzbpsm1b94nMNDig5lib3alD/8xQvDatLs3OaWhhMQ
         6zq+JaDb6aN3oxTBg5IHlVdzih7JrmlH9bpGbogi47BC1N0EF32/is+1khGhQYEcP7gh
         W7cNmcHkj5LI/lWk+02FUaJJtIj82NSLsaRloWqwCac1JQttl8JAE64ukersMU64f2mO
         uoP2wZ2o78FgqA9hxRCS5p71c5fEMD+cNA2Kn+hFQVnjC6AfpQ/hygb1qYo2/yw3qUA/
         M8Tw==
X-Gm-Message-State: AOJu0YyQlCxY4VlSW10NQqB7HZ6CBLYrdsiZnWajgw1iHvyNSFyBOND3
	Cemw7jtI+NVinpuPRX64ojD+RECL2J55ckxal2u4DWO7alYSvIEtfH8fh/LMT2iudTl+m9o+b4F
	MB2s=
X-Google-Smtp-Source: AGHT+IGZ3IYG7ZvyIsW6OHsWJAHiVpG6rdtl5YUGeUbVWbREtsc/3WlQVldg1bZQLb44Iu2gdNXasA==
X-Received: by 2002:a5d:54c2:0:b0:37d:542c:559 with SMTP id ffacd0b85a97d-37d551b6a0fmr8141214f8f.18.1728919487917;
        Mon, 14 Oct 2024 08:24:47 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:47 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 4/6] can: flexcan: use helper macros to setup the error frame
Date: Mon, 14 Oct 2024 17:24:19 +0200
Message-ID: <20241014152431.2045377-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch replaces the code that directly accesses cf->data[] for setting
up the CAN error frame with the appropriate helper macros.

Se hai bisogno di ulteriori traduzioni o modifiche, non esitare a chiedere!
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/flexcan/flexcan-core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 790b8e162d73..ca620c8f028c 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -828,33 +828,31 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (unlikely(!skb))
 		return;
 
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	CAN_FRAME_ERROR_INIT(cf);
 
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		CAN_FRAME_SET_ERR_BIT1(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		CAN_FRAME_SET_ERR_BIT0(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
-		cf->can_id |= CAN_ERR_ACK;
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		CAN_FRAME_SET_ERR_ACK(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT;
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		CAN_FRAME_SET_ERR_CRC(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		CAN_FRAME_SET_ERR_FORM(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		CAN_FRAME_SET_ERR_STUFF(cf);
 	}
 
 	can_update_bus_error_stats(dev, cf);
-- 
2.43.0


