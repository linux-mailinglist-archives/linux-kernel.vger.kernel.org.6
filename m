Return-Path: <linux-kernel+bounces-357655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCE9973D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF561C233E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E41E1A20;
	Wed,  9 Oct 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pvLZARE1"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76C1BE869
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496522; cv=none; b=jy3LJWk2ul5GYFJb+NKhppwzWnH+vIPBu7lA7Y0ty631lgyyb9DVF6UoK1ok9zlpMeC8DeeqmCBWWpsICckL0W5FMkYU9HvNCYfsgcJ1dfDHJUIBK5Mh4GXZV9JHYMOjCOQrAciAY4u5XzudOUNpgVrDRs7OcidKIgq0cx6zPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496522; c=relaxed/simple;
	bh=+KXC5+/RQk1GLo+doGP/ldq3RJbVkY3JcfRB1YrEzsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8BtHB0cu3crBryY5PvWFj9HBjcn8sv6h0fxIAHltn2Hv1g5xTA7cF+9vTTRtg0j0le061f9s0OLC9BbvScoCJekQkb9QjoPOi9TfPxT1Y+KPp7ZUN1As61Cc3yb661tpU1vXht8VlcX+4p2x3PvYldmmtFAES+3bhVYhEz0tYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pvLZARE1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e038f3835so102003b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728496520; x=1729101320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox0A4aFXFoAY48o8My0plGAbE+nAuK7cgMCjcB43jYs=;
        b=pvLZARE15WaplPF9FUNLOfUBmGsQ/5eeRKW6+lwOA2yc1WwHxLq41nij2JlpiDOJBe
         D0w5rhqhcznfbEwzvo4IIqeittmcHNLikhJF9Ha+btkgAaYXp2y3BR3+p4rp+nPqDdjn
         u/FQot5zZieap3EmuYkwrQMJs1NflGXeu1WMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496520; x=1729101320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox0A4aFXFoAY48o8My0plGAbE+nAuK7cgMCjcB43jYs=;
        b=HlfVXn3y9LQ41t703Ikqe4tiND4bGNbVABpARXWyzgS+u/fzfgcvE7WTYoJls1O2KI
         HAHyAe7FJNeannLiZJ4loO3ah6339K6oOITsD9+iXBIJPlT6LBPuPRSF6uWv4ZQnr79z
         WyDf+sTOSLtdfgmDr0RLW58dn+b1xCj0dbF7gBnOJh/g+BtegwmWmfciHRP/XPRWxcCn
         XEUMC01JdKl1pkhK8sM3yCBbe7dXRsfbDYKFvYn3xy8TZk10SOS+phA7Je3SPPBgge6e
         aIc7MMFCno3azaSxpXjazInmAy+XGDjii1uhdf1snwNpKw7yw72BhOOYjPe2aEw5wfo/
         L9bg==
X-Forwarded-Encrypted: i=1; AJvYcCVuc23n8LqiYtZIM3xo/HbRZWpT39T0ug2MN4ROwB5m3SO0mfITEDbNBByS1btuc5UH5mf77Dgrz+EoYk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxriJpCB42LNyX8MQl58GwBtU1xyDzchWaKwe9cUbW2xBm7AZtX
	CEijeWV5KYCREPgxzcHWjQYyRirdrZub04CXRzD/cC8GUF/7BqFSoLc+/xjCD7A=
X-Google-Smtp-Source: AGHT+IHnnx9FcOwDh3XGIUV14QQ1i/u8PP17M+iakKmWQMQfG22QleKXOKdIGNsIu5tG336OJpcbrQ==
X-Received: by 2002:a05:6a00:853:b0:71e:cb5:220a with SMTP id d2e1a72fcca58-71e1db77b92mr4807295b3a.10.1728496520023;
        Wed, 09 Oct 2024 10:55:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc86csm8044685b3a.27.2024.10.09.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:55:19 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v4 1/2] tg3: Link IRQs to NAPI instances
Date: Wed,  9 Oct 2024 17:55:08 +0000
Message-Id: <20241009175509.31753-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009175509.31753-1-jdamato@fastly.com>
References: <20241009175509.31753-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances with netif_napi_set_irq. This information
can be queried with the netdev-genl API.

Begin by testing my tg3 device in its default state: 1 TX queue and 4 RX
queues.

Compare the output of /proc/interrupts for my tg3 device with the output of
netdev-genl after applying this patch:

$ cat /proc/interrupts | grep eth0
343: [...] eth0-tx-0
344: [...] eth0-rx-1
345: [...] eth0-rx-2
346: [...] eth0-rx-3
347: [...] eth0-rx-4

As you can see above, tg3 has named the IRQs such that there is a
dedicated tx IRQ and 4 dedicated rx IRQs, for a total of 5 IRQs.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump napi-get --json='{"ifindex": 2}'

[{'id': 8197, 'ifindex': 2, 'irq': 347},
 {'id': 8196, 'ifindex': 2, 'irq': 346},
 {'id': 8195, 'ifindex': 2, 'irq': 345},
 {'id': 8194, 'ifindex': 2, 'irq': 344},
 {'id': 8193, 'ifindex': 2, 'irq': 343}]

Netlink displays the same IRQs as above, noting that each is mapped to a
unique NAPI instance.

Now, reconfigure the NIC to have 4 TX queues and 4 RX queues:

$ sudo ethtool -L eth0 rx 4 tx 4
$ sudo ethtool -l eth0 | tail -5
Current hardware settings:
RX:		4
TX:		4
Other:		n/a
Combined:	n/a

Examine /proc/interrupts once again, noting that tg3 will now rename the
IRQs to suggest that they are combined tx and rx without allocating
additional IRQs, so the total IRQ count in /proc/interrupts is
unchanged:

343: [...] eth0-0
344: [...] eth0-txrx-1
345: [...] eth0-txrx-2
346: [...] eth0-txrx-3
347: [...] eth0-txrx-4

Check the output from netlink again:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 8973, 'ifindex': 2, 'irq': 347},
 {'id': 8972, 'ifindex': 2, 'irq': 346},
 {'id': 8971, 'ifindex': 2, 'irq': 345},
 {'id': 8970, 'ifindex': 2, 'irq': 344},
 {'id': 8969, 'ifindex': 2, 'irq': 343}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 v4:
   - Updated commit message

 rfcv3:
   - wrapped the netif_napi_add call to 80 characters

 drivers/net/ethernet/broadcom/tg3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..6564072b47ba 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7413,9 +7413,11 @@ static void tg3_napi_init(struct tg3 *tp)
 {
 	int i;
 
-	netif_napi_add(tp->dev, &tp->napi[0].napi, tg3_poll);
-	for (i = 1; i < tp->irq_cnt; i++)
-		netif_napi_add(tp->dev, &tp->napi[i].napi, tg3_poll_msix);
+	for (i = 0; i < tp->irq_cnt; i++) {
+		netif_napi_add(tp->dev, &tp->napi[i].napi,
+			       i ? tg3_poll_msix : tg3_poll);
+		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+	}
 }
 
 static void tg3_napi_fini(struct tg3 *tp)
-- 
2.25.1


