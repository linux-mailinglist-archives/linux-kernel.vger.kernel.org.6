Return-Path: <linux-kernel+bounces-418787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFCB9D65A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DFDB233F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CDE1C9DC6;
	Fri, 22 Nov 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U16nzsOt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC119F462
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313821; cv=none; b=SyNNFPgNoz3pdRpozcrytCjpcr491KAMU8VHT5z+k8pU5oyWdfOYIrE8cBq8LHKHwBwCBmI95EjI4L6WdXyQ+28nV+v8YOAxwPINs43f2DmLJz7L8BwgPht8l7OLnMo/v0xRW2AFZ+nXrs09nUKyYf8NaWvJY4QByWTBNcZTlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313821; c=relaxed/simple;
	bh=bJ5akgXBwoiUhGjbtM87dqu6r2AImjKv44f50PKcNNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXcorwvRusjP9hROlVp36ggjSO7kfvBRFRsDYlBJnIoVNjmYdx2XemBmedFEWH2Qx7QbBNqTmI5KqSi+mw19/FYuRVLL+sZbkufTZLf3HNCQXQYCz9Q4+mE7fYV61w7DG1NNjBEiFdrRF1ZpFqcowaxteG0/h1d9+QUjTST0F4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=U16nzsOt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso3171184a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313818; x=1732918618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da17qF15VPZTU2YSYHqLzMcyFK3KqWPtGcD0XFwPoOY=;
        b=U16nzsOt4XpL++sydhwST5W6HFxEY3efaLlkPhLsTK809xbURx2OBDQzeauZc+RlG7
         1fd90CVOsCo5kGPFpbWa5pbX57s81hjzCMnegwm9J9EpZO6r5RE5HbrcyCwpSd/aUmww
         XLy0vi/E9L9JcMmSSz+UoISG22msb4CyOKdto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313818; x=1732918618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da17qF15VPZTU2YSYHqLzMcyFK3KqWPtGcD0XFwPoOY=;
        b=ipE7I/1VAqCxyS9XjFwkEvHsB3TrM7maXmVYuG4n1QdmUsZcNuPxUaZvhpO71rOp2Y
         w3gnpyA6LkOeHeCeA9JQyFolL5Qnmi9uzbIjVqPWNI2LRWQoGVjedAZv7rRaQUpQpFHO
         uLkqdMEXnPIr0HqHHJMSwgP20loNUXkVQ9VMHhmvy7UsQnW/A5C4yN1OaUNMlhdiZxsb
         c9D2juQ3OwwPyQO/LJVKlhkWNW+APlaUuQg6ccmMBbC0HEytk9sa/8f882lfgJxxbxA0
         AFnHEt2YJzFZHMwpM5bUvPnAKjzISjw/Hi0+0gqoKT/3A0kw4rO5XXqTknwGUi64Ch2X
         Pceg==
X-Gm-Message-State: AOJu0YxqX92bpQFimtqRUNsWvK2o5VFt3OOdT4lTiS2TqZlyWRX7f92e
	RfSbmaWaPlzrjqFdhLq/WS8ob+UcIMap7UKzDWCExJtvX9dIQtfXK7aTjKcEC7D+CqSn1Eu5jXo
	S
X-Gm-Gg: ASbGncuIZJgD95YIfbcQp7eJ8Jzjb+y71DxVpb8bM71IBPwOQB+6sUTyRDO4ElvNH1R
	rGlDFGd+VnFPaDuYObN38JB377Zaqr1GX6z1E9IBbIcCwNvG0NlBk85J6r5LZv4Ffh11Z3SI/u5
	L6XsAuvKARHug+PJ4m6NW43XRDSLmNrm1JXVGZ5uzRsfvbmlfBJtSIJUx8kkIeYmLCEovldZzZ2
	+cnEBFnvi1a0gHuYD/XPZ4bdpnGO9QGZy2VJ4DkmZdv40W/qi8EwLsUb9cJrrRwlhQCVUFodibu
	1WpKgBiQ4NmKu0epPdgIylvMdi9UEfr6zEATPsnsBeYEOTmDDb5xtk0PCEnGabNe2lV+XIvwCQd
	08A4bTv/Acf6cYTm7
X-Google-Smtp-Source: AGHT+IFqavb84q465UWZ6gGwXgO+FxfrEo4gdscEtW86lZSTJTKpRR6rT4g7qMsIZYvAutdo4gpnMQ==
X-Received: by 2002:a17:906:4c9:b0:aa5:cec:2785 with SMTP id a640c23a62f3a-aa50cec28b3mr343858766b.25.1732313817919;
        Fri, 22 Nov 2024 14:16:57 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 03/12] can: sun4i_can: continue to use likely() to check skb
Date: Fri, 22 Nov 2024 23:15:44 +0100
Message-ID: <20241122221650.633981-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Throughout the sun4i_can_err() function, the likely() macro is used to
check the skb buffer, except in one instance. This patch makes the code
consistent by using the macro in that case as well.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 17f94cca93fb..840b972498c1 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -570,7 +570,7 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (skb && state != CAN_STATE_BUS_OFF) {
+	if (likely(skb) && state != CAN_STATE_BUS_OFF) {
 		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
-- 
2.43.0


