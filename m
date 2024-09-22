Return-Path: <linux-kernel+bounces-335295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A797E3B4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7691C20A76
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F07A770F0;
	Sun, 22 Sep 2024 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgDN9V9s"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD62772A;
	Sun, 22 Sep 2024 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727039722; cv=none; b=Ufe6Vx7FInnjBGrLy+YTloyxpexYiCBoOtWvU/4gjfGm9xOmGg9kp6AcUCkBHIxYReyWfWcZyn0pwf1Czz9bLwTuvM2rIShVsMkfczJnr0dhoyXlg5RQzAPN36aebP2VS2LIvoNu+tkw5iWG5OxY7XEg/GaeZ6cbBI/+xkLvJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727039722; c=relaxed/simple;
	bh=5ny3RQhMqihFsV/JC/ZyRl5/+LubAaXlCXt40/uDcvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/ZjmMEgkHjBDCixI/xpb5RL2z2OjDF/KzDxnEQG+wENImOXQqln5C2cRyuEohBWXtu82jDAENdJ1q5oCXaqlcXwJUqaqs3xULMfsjtjKtPsH/NNKd3stM8nufES1wK+6gNVK4F+yxkeZBgjHHLuWdthyLiFQ9OGP/JSRQ06+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgDN9V9s; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso1396113a12.1;
        Sun, 22 Sep 2024 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727039720; x=1727644520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eB/6pDEBZVxEyIJkPqartZ804jEkBIA1WpVHHbVXKkk=;
        b=NgDN9V9s1TuBuFGbEcfVDXCzSKqaGi5SwT6A+dURCRnl4fXUxe02KzCcrjm/AUir6c
         OP78W2ofEc+m2bvdjw9mi0MrzDHg5mfAGuZYr8ApoeJxzMoycw499FimlXCh26YqAkJg
         /fINtWX9oniM4yPJZhpGL9F9HH91HcsbeXaT9Gqf7CbpDIQ+6PHjjux5hj/Jmy2doZCT
         2ueTCnhEUo/n2XK3OCN8h9gL/6zfCJa4vckozxxkYcqrLJPvm+94yDMcpnfPoq8b09GP
         9vI9+MURfk80LE7EsZ4Zc+hu+q/yIKfQpvXKWSYT7Vge8pOZZ81cpiof0k8kYAfC+aMa
         HqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727039720; x=1727644520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB/6pDEBZVxEyIJkPqartZ804jEkBIA1WpVHHbVXKkk=;
        b=eyEEM4iPkno0JuS3BN+ieMr9qDDn6JtOytueqLSsXJS2qjs9c7F895NUVujg7CjehV
         demrdP6dOpW9CXZD3RBE0Ww2bHZ9SflRUWa9a02Gk1UoBjC6cACBS6kPRUPXuIvJ5+y+
         RBxJ8+3xxxDCJ3p3ipZvs2MV3nMIdzPZ4AIUy+jxnbQwbRKXYJwgoDzM95d2NAzB1M9c
         +MBcaKAFktSGh2XTPea29VdLnLYOC/BmiEs5skeypMG9MiMcku+8sx20NQX/LLzXBAVC
         TYUcOO6JX+hjcpxyPK6LbVKpvqB3FmfmdUCatIV9v/00R2TTJy2ky9hT0bEg/fMOg6Le
         C8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWHRB5DIG+VlLqrNc1CWkuu9F1FlZBwsrjvA0yc66mMxtdVWSdQKu7wjq6fGFTMAEq4/60wwqo6l13YyBM=@vger.kernel.org, AJvYcCWzYhp5bsUTLfeZuDMIpkUltw9E68v1KeH1SBV7t9xvmowq+yAE6j2+o1DUtFvLFZ4lBNEC+VHppuxe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxno2dPzBAC71PRSIp10Yc7qTqxd950CSu8WZOQ1g0tx53j0hF
	L2gmeaOESuXa/M+F4yDL+fUleHYalMQ4cQ/XQy7TGIUUuN5LdlJv
X-Google-Smtp-Source: AGHT+IHM7cYSwGtP4K0/lsVfMIUY9Vk7/2U+K1cWYPkDk0P26jIWUYPlr5eYFeoe68Sk1THt6ZuZSw==
X-Received: by 2002:a05:6402:34d6:b0:5be:fc1d:fd38 with SMTP id 4fb4d7f45d1cf-5c464e02e53mr7561779a12.36.1727039719457;
        Sun, 22 Sep 2024 14:15:19 -0700 (PDT)
Received: from localhost.localdomain ([185.136.103.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89f7esm9444006a12.66.2024.09.22.14.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 14:15:17 -0700 (PDT)
From: amin-amani <didi1364@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amin-amani <didi1364@gmail.com>
Subject: [PATCH] usb: serial: digi_acceleport: Enhance error handling by checkpatch.pl
Date: Mon, 23 Sep 2024 00:45:12 +0330
Message-Id: <20240922211512.49273-1-didi1364@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Separated null checks for port, serial and private data.

Signed-off-by: amin-amani <didi1364@gmail.com>
---
 drivers/usb/serial/digi_acceleport.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d1dea3850576..d858358f94d8 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1309,9 +1309,14 @@ static void digi_read_bulk_callback(struct urb *urb)
 			__func__, status);
 		return;
 	}
-	if (port->serial == NULL ||
-		(serial_priv = usb_get_serial_data(port->serial)) == NULL) {
-		dev_err(&port->dev, "%s: serial is bad or serial->private "
+	if (port->serial == NULL) {
+		dev_err(&port->dev, "%s: serial is bad,"
+			" status=%d\n", __func__, status);
+		return;
+	}
+	serial_priv = usb_get_serial_data(port->serial);
+	if (serial_priv == NULL) {
+		dev_err(&port->dev, "%s:serial->private "
 			"is NULL, status=%d\n", __func__, status);
 		return;
 	}
-- 
2.25.1


