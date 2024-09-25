Return-Path: <linux-kernel+bounces-339419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A329B9864D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A801F2587E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557E5A7B8;
	Wed, 25 Sep 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="I58TttfG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D43A1BA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281859; cv=none; b=T4d8MoTn8GOt7PByMugsrjcp+RLsFORJVLRfk1Btnor1JB06yZoR3yz9G6CB1NRo89Q/QDBf+GlnmyXFRaX6pM3nWXOm3l73dhNmFpOZjUInBtUayXnU1DDdnT0JgH1Q13yUdAZ86BegWPX9O6MM0R4M746K34Z/sRcCqgbet1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281859; c=relaxed/simple;
	bh=uRjf76+ialIXRhrRcRnhdzxrLmruMKeJXsltkA5bYqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tv09gzIXzyjPysclEWi0ibCvBo1n0dzXZuOnTN/GIX7KgvfKxGnsjPK+tOrckIUSI0Z/d5SCbqaNVgKSS859hkPqp3m4J/lRb4BUlyw2RnR+mbd/wFKpFDcDGb7lL9qbxLSRL9zYZiDalKZze1xKvSbPH1NoyG8TgdkG/FrzYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=I58TttfG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053a0bd0a6so70874205ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281858; x=1727886658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
        b=I58TttfGVOvcWuCV6NMNty8vqlocq56VdEEdYqRmO9ngoGPU6fF67cSkL7r2LahVJL
         Nt4sm7LxltzcxpA1vduFOvsI3WEEGhc88eA2s42jgZxyyWrVOod7QCE0RIIXR7w24MDM
         YjPklsDQGRyuhrC4w7NO0Xem36fGLBtiibnDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281858; x=1727886658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
        b=AelKtoT6tWO40QzMuJajowsSWkcODZOa1+gmXKCIZMVjlWKgaf/5NfSThZQ6tQHIO2
         u5rlLbrUwV6c//fERntEKhltbGeit+z5NfAKqAApmxpCYSDePALqVqYA+6EQxU/Lh/bk
         jlsnljgkBEjsPib/2LMJyUi7O3dV4gLFee4lUHIrEO1MfDQR2x627zW3/9HN5Pql3c6f
         lJNUPJZpot2DvGbLnSsUUKsSrrphO+OzKD+lNhS/jkcynha4afww5Wra1YzvEKEFBn4Q
         iczDyjqSGmtCe4J0E/VIQ/tnpdP728ePP76IaZwfm1JPnP0UxlSzGFl7u+YEuBoVkZh8
         q6FA==
X-Forwarded-Encrypted: i=1; AJvYcCUt/bPYOvj78Lf0gqJmfStj087NF0KXe+lK3kDu0xKV9MQjWKT5cwt2/xJalluSQf1v6uY5ukf6w5ZFq64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZQb7Y1R3RYSFUYxkRlCvyXmXakCKT0bygzLOt/jcpuoROhGl
	s8qwv27YP5DBVkWFpVx0MINQLk3NYe7raMQ3OdkKdXc8FZKM8QfT61yOsJHj/t4qafkKkqaHsdK
	p
X-Google-Smtp-Source: AGHT+IEM3gPUtOxfd/W3Jnyzn6mZZ8mH6XO7SpWmV1e4jRBezuatggwjJ5DEzXqm0y0ZQlMXfIHvmg==
X-Received: by 2002:a17:902:ecc8:b0:206:ac11:f3bb with SMTP id d9443c01a7336-20afc5ee705mr34902965ad.47.1727281857892;
        Wed, 25 Sep 2024 09:30:57 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0702sm26345585ad.28.2024.09.25.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:30:57 -0700 (PDT)
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
Subject: [RFC v2 net-next 1/2] e1000e: link NAPI instances to queues and IRQs
Date: Wed, 25 Sep 2024 16:29:36 +0000
Message-Id: <20240925162937.2218-2-jdamato@fastly.com>
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

Make e1000e compatible with the newly added netdev-genl APIs.

$ cat /proc/interrupts | grep ens | cut -f1 --delimiter=':'
 50
 51
 52

While e1000e allocates 3 IRQs (RX, TX, and other), it looks like e1000e
only has a single NAPI, so I've associated the NAPI with the RX IRQ (50
on my system, seen above):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump napi-get --json='{"ifindex": 2}'
[{'id': 145, 'ifindex': 2, 'irq': 50}]

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f103249b12fa..b527642c3a82 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4613,6 +4613,7 @@ int e1000e_open(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
 	int err;
+	int irq;
 
 	/* disallow open during test */
 	if (test_bit(__E1000_TESTING, &adapter->state))
@@ -4676,7 +4677,15 @@ int e1000e_open(struct net_device *netdev)
 	/* From here on the code is the same as e1000e_up() */
 	clear_bit(__E1000_DOWN, &adapter->state);
 
+	if (adapter->int_mode == E1000E_INT_MODE_MSIX)
+		irq = adapter->msix_entries[0].vector;
+	else
+		irq = adapter->pdev->irq;
+
+	netif_napi_set_irq(&adapter->napi, irq);
 	napi_enable(&adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
 
 	e1000_irq_enable(adapter);
 
@@ -4735,6 +4744,8 @@ int e1000e_close(struct net_device *netdev)
 		netdev_info(netdev, "NIC Link is Down\n");
 	}
 
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
 	napi_disable(&adapter->napi);
 
 	e1000e_free_tx_resources(adapter->tx_ring);
-- 
2.34.1


