Return-Path: <linux-kernel+bounces-344530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1250798AADB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD3D28975D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986261990AD;
	Mon, 30 Sep 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OJWeNjGG"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB4197543
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716430; cv=none; b=IuOpoE3XvLAnGe8FIScUh+ERKm4jCSfKS2N6H2sdJJ88w9qm5Kz5L7I/vD+kZh/j1Ls7JP3tBzQa7rOucjl+eOvp04gB+NbY0R1IsAjMurzicWnSMKsUhNp+jJRVkM3zi9vOvc+rpvnASh1udRO3DiexSZQRTSaKXxxUYyw7sZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716430; c=relaxed/simple;
	bh=2xa6XYG0SPNb7iMHOnnP26hIXHl778Eq6W2s/KPH+VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugkZ9WZOt+gl+7t2VDxHPGSiNxPV/UjLMzdlBJcGUM9+tXhRMI0j1EJF99WZ36/VTuroQLQR7SrOgfszKBBPKVxnBWJcehPKVfBdBjmMTo5UO3bc27OOh1WJr4iQGt4dDv6hNLgYDv5l/feCPMwP8SVwRqvhDIFiKZEqpmryT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OJWeNjGG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e137183587so826561a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727716427; x=1728321227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ1HUt9ENykPQZXpYaQgVfbtM27YTqGTHhgABDKn1/k=;
        b=OJWeNjGGM3gnngAec4YIQqk4TRw2Y1ldLB84W4mPKkRRJli8kB4zfFxZWvAdl9Tzur
         woHrmLa7GIFXAa0+d0OfmFfEDmYwBhoU1F8UoMfxcNNT6CRMSNv+TzbeyQAU2o7cUtaS
         NJ3T01pF1cHIZkj4vfOFMr2OQQtIwb7KT6y9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716427; x=1728321227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ1HUt9ENykPQZXpYaQgVfbtM27YTqGTHhgABDKn1/k=;
        b=l8vFvmaRYY0aUheEBPWb4+wwGyAl+RAIhzYY8VDzgc53paJXMB+n2hajo97G2hSb2w
         D0rpYcJtHCsVFJv+MC5Wicu5i+6B6j1oNARGjUHGH5ezbhWsNc0to48ShCNUYIypU3ph
         UCyK5EEIja4/Jy93+UOauwD7bNrSeJ83I9dzrKiESFAAgD1zdI/IoAf+RB5O3+z4rg87
         IfctGG6j6PFhaXOe3B/af5NyVkD97AcRSTcIMGT7AcR7U621RJXEGfscjXrmckVs6rSj
         IIDHIk+aBaXwJT8ma/AUrExROu1zQLGkTy+0K3Wq9BnFdxLfhNn1QJURnjbw+74xPBZA
         7S0w==
X-Forwarded-Encrypted: i=1; AJvYcCUT2DT7yLDM/wOzJkMVqzrd8brunJ7Ex6wV/vwJioyJB/NUa04n85QRRfgLQWTD/SQTrD2Eiemu1DBosGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPbYsmxIiBRLAf6scFDPkVP2huMefm0WXHNEPrK/T+suw9tbL
	hlnCXCMeqIfuET0U4lnh3fKz4g9HYsW8Sbk+4bOn8Y5POGVzHAutPLvwP4TDXNo=
X-Google-Smtp-Source: AGHT+IGLGN5zg7ydYpQJLz1NT2ZzACaDI+w3M4axykF9rqv6YOBBltCrn9UGFtfPniilSXVjpTnvtA==
X-Received: by 2002:a17:90a:3486:b0:2d8:89ad:a67e with SMTP id 98e67ed59e1d1-2e0b88903famr16567956a91.1.1727716427128;
        Mon, 30 Sep 2024 10:13:47 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e15976sm8188364a91.41.2024.09.30.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:13:46 -0700 (PDT)
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
Subject: [net-next v3 2/2] e1000: Link NAPI instances to queues and IRQs
Date: Mon, 30 Sep 2024 17:12:32 +0000
Message-Id: <20240930171232.1668-3-jdamato@fastly.com>
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


