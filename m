Return-Path: <linux-kernel+bounces-535300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47DA47102
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58113B6D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443617A319;
	Thu, 27 Feb 2025 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bTP2q3ej"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74D1465AE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619367; cv=none; b=h6sHDBfG5lNw/SGhv/P+TPTzclNn9VwMQCkERMG4hB0wEMmSw2Ed6uVdyGZU3o7F4xhAFKCAOFjynexJy5qlNUQ9i1629/qn1H7o99m51GSO+mxd6Jm4lPiZBA2pv23Grg66DVIP2V+gtRbpgI3Qbo55K/1MKYH2/uWoro0q0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619367; c=relaxed/simple;
	bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QabSyMBlbaIVMq+hgp8dHo8jOtRJ7K9L/+4izjaEYK2msC3rovhW5X8AqSgz1BZYfzz83TTyjdNglyqKBjQOAhKLro4BDVy92A5xcsltuUCufS1bJ0+xj4KfgeuKyOGOhWSXQr+ivi1mtaQQSBpnep1swT3hyQmq91j5Xw89Udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bTP2q3ej; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so4163505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619363; x=1741224163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=bTP2q3ejhb5ibCORIREbHYI9nyChOFnaEMi0eBVN2ckldF6QRuo2sWupPHZUikBy+y
         KR13QfQir1inq4BQaZz/MY3Csu6uius3m0tgsu/AK6vG1eOgAwKEtUHCv2joqQxyQeAF
         P/c1en4KP+TpmP6CtgTh89N5f0g4gNQ1hu0e0U0tZnvMa5WnKhjYtD2GWtxsvJWoubuD
         P+7ND9MNK+k4HqE4CKs6DHyKJNONXHxRq26kzNZwfqoRF/Cz1f1VtfksLbG51paa8KGW
         4ZjiUIe3BqX0xmV+Jg4XgQeb2NrRo+NWy7XdyRkhGbqILg26djCbvum433XVbdtT0vR7
         FLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619363; x=1741224163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=jF2WeuHQ58Xi8pgpTzSxpohwWS+TVSofV/leuO3W5BTdpyI2jMKahdibGz3AMgaKif
         p2Ceq55M4eriQWBeWjHiY+SXYjZ0tD85fhA2pdQhx7o4ZIrvuhlRTKaiHYseS/oX5SUE
         CcluoDh/M9sTd1Qv7VuZYCas46prAwFrR970QlZZr/3XNhi7mx9qk+7rNCZS6q7+SJYJ
         pdJ2KGO1KaqNGP66NbWuPpEUXcxeGlhGyR+I3HFLc/NP0D+AV7dsYE+s4dDhD5/3HmLB
         svh7MYKWFl8eg3D2DvJEh/zjbJG7P9LfDZ8z9n/q4iIESJ85/Vt/c6dadvbAScfTAQS+
         4mRg==
X-Forwarded-Encrypted: i=1; AJvYcCXI2ER9+Gdpe90hZzUI+DkRYkhqhOaRNbxbJIHsz3Xyr8q64Bzw5f3lgml4M/au8O5HeulYbHcuyH5agA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3C+ogKYhTAobDYrZExEVdLkZfl+9n37ry8gyHhBTb1ulb4SYm
	DglFs1hQLFxoAfS5/BXX+O5QVldx1MePWe/DpEIcHdXyvdqre74IdKsq/CagZpuT5/gRdf+ILDX
	O
X-Gm-Gg: ASbGncvu2v6/fbyQv6/39o6B+a4FQwLjmMGujl+SJTEnp4Ad+3b9248svaHqP6u0iJk
	oRXoGNMBJlcWz3RbZ6vGL26dtEx/XkzOO5rOvC28YkFapJR3bw4rs79F7Llowj2QGbqKDkEyp75
	23nQh6Cwp9zwXzYSFavJDfF3WXxrRzxHMdr9IptK8/4Lvx2TdUdakKORXXGjjakNQVHsioc138E
	tUF0pTYWfzCKEwSSCPWR7A0XGKvxe6b2+lvEC8Sh5AMpztS8lZfu4wpfFktMhk4stbAWkBf/RSw
	yVOuao8Djkokt1ir5Mbb4KH6kBIyEHw6WM4haw==
X-Google-Smtp-Source: AGHT+IFRLUDD/JOdpbzWNvpECDdSlVrGNdcjVZwvbaHqQExjq50/llPLnt+vZkb7y+W8izkVyRixtA==
X-Received: by 2002:a05:600c:1c90:b0:439:5a37:815c with SMTP id 5b1f17b1804b1-43aafab940fmr90711725e9.20.1740619362692;
        Wed, 26 Feb 2025 17:22:42 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:42 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:30 +0100
Subject: [PATCH net-next v20 05/25] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-5-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75fnpsyCwFTnzjcBjb1zy8QSEzHE73ta9V+W
 Dp3cCEdgjyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++XwAKCRALcOU6oDjV
 h7sdCACdPdoSPcr38UMh7K0g661h4eBRoeGspDeqtmchcLTRv8cCBfP7WBIYcWdyWyBL0taQ7FO
 rOeiOO7VTqo0kAHexONFd0NGl0AEUp0rGR62JaNzyw3vLD/n00r2JwghQdyvQj6f0vJ9Xynh6F0
 1inzICvNLx4cdIrEhUPE9fFlupo6B3lWUbZG2wBl/jV9LEt9qvYS2txHMSDrwGNHN5tGPlMyU2U
 YJMy8yYNFXbezA954w0FrV98WOCcUiGUWYSh4fuhNPBDn9KDI+7dIj7akHqxH8r3EeVswCDSQWt
 c9fZdtgL9Pl45gESZbfaIheLDXyD1KFxhb1Glc2McwRN5lUa
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.3


