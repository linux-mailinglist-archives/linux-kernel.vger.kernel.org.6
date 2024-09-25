Return-Path: <linux-kernel+bounces-339420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299A9864DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830F91C26853
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34783A18;
	Wed, 25 Sep 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZHo7fk5B"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2257880
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281861; cv=none; b=oIV7gD7pmlTw68UNqsjA0cP1i4dhRNY7XJRUWFvmDERvDTfKlgIlO6z6rfgjSVW+delTxkg+xgWIkuiiE29G21yOOhmzPbx/b3cZAchXte3ITXGoNXxy9Xik05CHFoRTTP7bV7tbPtNUJnL8dBlguQo1ITjRYFicS+cAH34zdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281861; c=relaxed/simple;
	bh=WLuLHgx2MT3+4N/TaNL5sHAmTNY9YxSr2tDwSWM1Wks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrM2b9FFOfu/ejA6TQ1g8LbzkeIgDzzhmQG2L5xR8uSPuOe5eJ+UhBJdUPjf9jeMrSOiWWf0QNLbQKyqg75xxZxvcIjj/3ESy1COuMQYbJ4eiSgHe9E9/tTVkw7hHG/oMDQidqH4sV+U6Ro/5fWLe/uRcBu2XMrGD6b7kHfSgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZHo7fk5B; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so739a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281860; x=1727886660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqS3WLQRtJuGZ7n5fqIngVYCyukIdr8Yi9XEikosZZs=;
        b=ZHo7fk5BBCCHxeLIzWbCsbVVRvT9Ogg3YO1U1LNcCts+dFwBxac64Wu3OfDCHoMAfQ
         0g0ehad/FU77j6okMhTn0m0jGcU1kLx4mNyAwbQAA7vT9LbWTGz1+0y6ewPQznyNtabj
         LC/3z8QrqLoHe1IY+HiJQuwkk2olcuLWP1PlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281860; x=1727886660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqS3WLQRtJuGZ7n5fqIngVYCyukIdr8Yi9XEikosZZs=;
        b=WdMkqrjgRAuwQKG/nLiiIZT9cWtuhiiXfdPR2UcV5K5GTBIuNNKd6H4Jh5eA1tOv6I
         ws1/KGwo8UJqWqNmOeVEHn+JoEp5n+x1/Yj2dcMSlSmilnrAuH8B014GJMAR000oo3mp
         Ve6G2XIKo91nIGc+Fh4hWpQ+TwN4vFh2MqpEdV2LF711hROnFrL9S+gV+TLpI7n5O9DC
         mPKHam5QHrg3MYSKxJcxQCS4z42TLIAb2gi1YCEh3LMUEQO+NnW0GvoDtu2wP5XjS9o1
         D+vkq9kluk/Qky7lXU06qalObfQFD7k6HlHy+uzeOqoHyIfgORWK4N8aCoNGWnlik2ej
         Vexg==
X-Forwarded-Encrypted: i=1; AJvYcCV+rN6EGBvlQ6kCnX/z4On6dbTI4jkg/7FOWDYj/st6o1aYIVI6YN1q067Y5rTde/6uw7sgki63HRzB67M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxisIgLkKUnATfGnFzVUWkKYqChWHfP0cVjhJpQyUxuGOKt+z
	H3lpYNYOOXZRre6QHOTHuCweBsCdSvmoTvpqUmjoJAYYgkdJXvEgDNvOWtN6poA=
X-Google-Smtp-Source: AGHT+IHkq6o5Ld2ygnxmPUAmwe4I6gQIsnCBKwiUvvIUWibnJ6eGpMuDVKGGABQBnTR8IJWaW9URVQ==
X-Received: by 2002:a05:6a20:d526:b0:1c4:dfa7:d3b9 with SMTP id adf61e73a8af0-1d4d4b08946mr4079299637.28.1727281859597;
        Wed, 25 Sep 2024 09:30:59 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0702sm26345585ad.28.2024.09.25.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:30:59 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 net-next 2/2] e1000: Link IRQs and queues to NAPIs
Date: Wed, 25 Sep 2024 16:29:37 +0000
Message-Id: <20240925162937.2218-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925162937.2218-1-jdamato@fastly.com>
References: <20240925162937.2218-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for netdev-genl, allowing users to query IRQ, NAPI, and
queue information.

After this patch is applied, note the IRQ assigned to my NIC:

$ cat /proc/interrupts | grep enp0s8 | cut -f1 --delimiter=':'
 18

Note the output from the cli:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 513, 'ifindex': 2, 'irq': 18}]

This device supports only 1 rx and 1 tx queue, so querying that:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index ab7ae418d294..4de9b156b2be 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -513,6 +513,8 @@ void e1000_down(struct e1000_adapter *adapter)
 	 */
 	netif_carrier_off(netdev);
 
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
 	napi_disable(&adapter->napi);
 
 	e1000_irq_disable(adapter);
@@ -1392,7 +1394,10 @@ int e1000_open(struct net_device *netdev)
 	/* From here on the code is the same as e1000_up() */
 	clear_bit(__E1000_DOWN, &adapter->flags);
 
+	netif_napi_set_irq(&adapter->napi, adapter->pdev->irq);
 	napi_enable(&adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
 
 	e1000_irq_enable(adapter);
 
-- 
2.34.1


