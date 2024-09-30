Return-Path: <linux-kernel+bounces-344529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF398AAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFF91C22D25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968A198838;
	Mon, 30 Sep 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fERpkYR3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DF194AD6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716427; cv=none; b=ZdFXl7X3h19SbbziUXqfC5wdpZDlyFDEI+FHs6xdF2SXbrytfVh6rFfk/Nekt4YWAFw+9f6V8gUvFM+zIHaixf2HDQ6o1+WsURoMNd6HZa723rXiM1cMdEkM3mOPvW1dueoaqF6NcRJ24yVPl4cl6woqVni4TUhBBFcXH+tUtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716427; c=relaxed/simple;
	bh=f7Cj2/U+yVaVdu2hqNKKlOammxUWM5mgCCb0WgxCu5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3wec0AQXO0CTtlqXlTc7Aq0vRjBRb/eYljwo+dzO3HJ9RXkjklILuP0eTbZZfiYCPSK0EepsftFnCXZQV2ebjJqH9PAS6YTkpCQWKXu4kLFUQiTu+KDXmm3zWlgzn/rCrC24aWDGwtjDRJ36wR/GNLzlfLJyX/WSLmTjz3qsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fERpkYR3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0946f9a8eso3266336a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727716425; x=1728321225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPUm6eje2Kvy3MAxOTLFjWIkhuhnGj+3QjJ2qyMtpaA=;
        b=fERpkYR3Sryndof/eypd88H2bf5zE6OTIO/MLKbPwBwOacBwMWHsk3HqL6dmPiUyiy
         qiN5+weeeUzKHKgiff/z/n4NGjMbynI6bEmFK6VmXfQTbrx1O6Qt8yHKuotmzAP4FaQ1
         o0+Sd6Ss7lQuhhGL+VwVxjfMD45R0aHXANENU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716425; x=1728321225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPUm6eje2Kvy3MAxOTLFjWIkhuhnGj+3QjJ2qyMtpaA=;
        b=CnBEHM0EWgiBr55Foh6k8a5vZHnOh9uABo6VHGfzKPCOWuVSePUa9FkY0YIUvZJCWY
         DqnVGRvs3qJIv1H6f2hCVPIEDiZnonV5cq9qaZELwucW5BwdEeYVz3gkrrm2nRue2tC5
         tIP6MUs1FWw4lRMnndn1wAlqEHbU/nJa6EVbjkLcsb7oBq+soeLD/BE+UZje03O3RVuG
         U/sY1DTf/+7vQXKrYal1ObcIuElunqoKEnWbqK75rYNIij0eFYNbVIIOp8O6JOUXB6A3
         Rs0E6nRPwXmePgPPIDsBimmOrEHHYsvKAsZrD7EtbLapdKEy2hAeA/ue6KqlRo0nGRNv
         UC0w==
X-Forwarded-Encrypted: i=1; AJvYcCX/3JckBxxqbUkLD3Mt71HzAm9hJFnhUd8rAVwkvy+3vwhg/Bd3MBVmcvrDU2PrdkRgPj007b2Jqatfzyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSLrUjcwriVBy43ST/j+1niVrsOfAMN6+QjRMPpmjfPYtm928
	F+4oo+K9/cRIHQocW7NPd4Kwq8sA/XTBGH+kC90x9xq9XYn7Ul5qlFEoFa3AWo4=
X-Google-Smtp-Source: AGHT+IF3215cZjc1t27AvJmRsUf9qrcGNxs33koPNcRKrDRfVAz8AEkAj2Xp12L+lnK7vjo12L7FCg==
X-Received: by 2002:a17:90a:6982:b0:2bd:7e38:798e with SMTP id 98e67ed59e1d1-2e0b8ec8c9dmr13624875a91.28.1727716425530;
        Mon, 30 Sep 2024 10:13:45 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e15976sm8188364a91.41.2024.09.30.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:13:45 -0700 (PDT)
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
Subject: [net-next v3 1/2] e1000e: Link NAPI instances to queues and IRQs
Date: Mon, 30 Sep 2024 17:12:31 +0000
Message-Id: <20240930171232.1668-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930171232.1668-1-jdamato@fastly.com>
References: <20240930171232.1668-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for netdev-genl, allowing users to query IRQ, NAPI, and queue
information.

After this patch is applied, note the IRQs assigned to my NIC:

$ cat /proc/interrupts | grep ens | cut -f1 --delimiter=':'
 50
 51
 52

While e1000e allocates 3 IRQs (RX, TX, and other), it looks like e1000e
only has a single NAPI, so I've associated the NAPI with the RX IRQ (50
on my system, seen above).

Note the output from the cli:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump napi-get --json='{"ifindex": 2}'
[{'id': 145, 'ifindex': 2, 'irq': 50}]

This device supports only 1 rx and 1 tx queue. so querying that:

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


