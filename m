Return-Path: <linux-kernel+bounces-412025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558B9D0283
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD64B24E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F1189B94;
	Sun, 17 Nov 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="b1BfGZmD"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFE17D355
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731832352; cv=none; b=ZQBXfG1xy+8VynydSmjV/QYSRhtLf4V/6lQQ0vPKrD1lx/+9xa+o7a3sUgCHjy8g36EBq7ZyQZVh995uL8hyEc1kwvszEgWFxEfKRuxaT6mqpPrIpMUFLTYKvnKGazFZQOQr6RWztT2O/hbro3wa2GIE31EZYmg/LhdrzP81EPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731832352; c=relaxed/simple;
	bh=pXHzeI/Gx2PAexegf0r4gW2+PvbHef/a8bLDzBEMcUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvarjBL7JdMi/ILm9O28BxQjYyiQaKDLAPJ8RAcqN8IvqBbY8MnnTVxE490nl0WO+sZ0U54fjRkwr2ySoWsorgT9cL3S/PT4g7qAUU9nTWToo0y/uFS8NXCZ6XeN72Xb0sR9KtzNRS/wPzmh5aqOU/CfCJLWYe0C8+kCHueVGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=b1BfGZmD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3822ba3cdbcso1204785f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1731832349; x=1732437149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q0LK28/34rKJsS2lihgn4HkLUleE9PLjRqMKlX+v/M=;
        b=b1BfGZmDod6e095bPWQ9M3zTw/NUjvdCLJsyqYrF04QvaqBd/j0qAyY5Nt8yERbOgz
         DhVtgRDjOsd6I/GUycGA6TEAC1W9QCV17ZJ+ZJcibsQhV6xRjtL0v74FhT4iFJ63ddEf
         SCFHB8z/K/MMHnvYJtm7P4a/4bVQiqU05OGv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731832349; x=1732437149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q0LK28/34rKJsS2lihgn4HkLUleE9PLjRqMKlX+v/M=;
        b=gSgcCqKyakohMw8LJ8Ayu1AtwH6qZSFe670uUG2aJ6YbW9yI2IxHDSRicys3nPz+7M
         Qrbf275cb/Yx7lIbOZCnUm2RfKApwoJ96dzjX4mGjxNqCmGzCrx3HSigNooac6bJvNpk
         0XWSaOzxRuzgsexc2QuHa9u+mDlkr0z4uKH8xYKx5EOL3GtXWJ9BxIxoU2YKRFv0gis4
         tjYuGCvQZ0SIHb/UXAsE9svEbdaTyefFehd8gGyrfU1G82HPcuOxnWiWj6dzid9Vkwt8
         hf0j9NlJ6RJnwSPsrC6UdemG/BL/Bhw/W5h58wZmTKhRmndPRA1AyAyu/t0IccxH8mHU
         6exA==
X-Gm-Message-State: AOJu0Yx7OoS2p/IH2SRzLgrffQ3/QGq+ZuXhh/mr0dxAf5/rNdk0jkmp
	fuQ2f6jEI6SulXGNHZhzjwe1lx36zFw9Ka4SyexRUPmD2/xGtTT4Tv+3mWoiCupuzB5HqU9w1BN
	SguQGnQ==
X-Google-Smtp-Source: AGHT+IHM7o1qWLNYc3YaZlzqXtUAiKZiG8gYjY+V6LbMmsOL1mbBrL4607YU4H//0FQWLlmfScB+nQ==
X-Received: by 2002:a5d:6c6b:0:b0:382:6f2:df7a with SMTP id ffacd0b85a97d-38225a33468mr7001293f8f.34.1731832348703;
        Sun, 17 Nov 2024 00:32:28 -0800 (PST)
Received: from able.tailbefcf.ts.net (94-43-143-139.dsl.utg.ge. [94.43.143.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm9466919f8f.83.2024.11.17.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 00:32:28 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: linux-kernel@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 4/5] USB: serial: qcserial: disable autosuspend for QDL configurations
Date: Sun, 17 Nov 2024 12:31:14 +0400
Message-ID: <20241117083204.57738-4-intelfx@intelfx.name>
X-Mailer: git-send-email 2.47.0.5.gd823fa0eac
In-Reply-To: <20241117083204.57738-1-intelfx@intelfx.name>
References: <20241117083204.57738-1-intelfx@intelfx.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a port of the corresponding change from the qcserial.c driver
distributed as part of the 9X50 SDK, tested using author's own EM7565
device.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 drivers/usb/serial/qcserial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index f1b0ef9935bb..b2ae0b16bc2b 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -257,6 +257,7 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 {
 	struct usb_host_interface *intf = serial->interface->cur_altsetting;
 	struct device *dev = &serial->dev->dev;
+	struct usb_device *usb_dev = serial->dev;
 	int retval = -ENODEV;
 	__u8 nintf;
 	__u8 ifnum;
@@ -289,6 +290,9 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 				retval = 0; /* Success */
 			else
 				altsetting = 1;
+
+			/* disable USB SS for QDL */
+			usb_disable_autosuspend(usb_dev);
 		}
 		goto done;
 
-- 
2.47.0.5.gd823fa0eac


