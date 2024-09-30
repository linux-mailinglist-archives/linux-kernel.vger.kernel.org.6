Return-Path: <linux-kernel+bounces-344544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C95B98AB19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACE5B23EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A41990B7;
	Mon, 30 Sep 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="K+o3B4Yu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B64196450
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717301; cv=none; b=izTjoMh4VkbuclaM5SGi8HttXjhomdgR0KB0CFyFnB2dLQTv7m88s0vROUpYDNRK9oRA4G1uKuOdnBG+9ic6n4PVZDNY5oECMn8L9kHE/8QqnL/MY7WDY1BuKCT9CA0xbIJf948B7kC37heRIGfdOWa7xkVjDuU5GMWhXCvVXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717301; c=relaxed/simple;
	bh=EvagdvQk7pijmnwXLz3bhcZFewXIisy/DAWva52qJgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJ4aUg8OTQlzacYnTuDfOWtbgFoMSJMWP40X31t2rKp/8VCBFntADy36UQMbGHuHk+US6n7UsIzvt1U1cH0cdeseX7A7qxwYSCVkiz51WDo35FZj/yKPIY97VdX3U0MefBD1HMQLdkhAWHuBzyQ5NTf6s+niSL7nhZY4jMc1vAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=K+o3B4Yu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b58f2e1f4so14955915ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727717299; x=1728322099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPBDWr7FVH15AZXA6BilugzDrkwTM0+YLN4z6XqvEkA=;
        b=K+o3B4YuSUXicxSTJUlccVag8WL6vaih1AbECyJy7A3eYmR59/aacReo6ahKruQG7C
         SeF2bMOzJUrozDb9JkPHCQ7CpbZp4Fx/ga5KVerwa8mHmS5G4nvSJ7azbNhJe4Wx++Y0
         Y2WbErmCk+QJ76C0hoGw+lR02ueVb6TMUz71E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717299; x=1728322099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPBDWr7FVH15AZXA6BilugzDrkwTM0+YLN4z6XqvEkA=;
        b=YxTxEXxCRxUJRau4JB8BNAAbNm7iMRQrCxIOJ8WlE9J+fLAdgNW0Y15F9nSXlFAGeb
         s6gq6Il8rjPWk9yUik7O05dE0jwf2Jpt4xr/OzmHVzPuIGIVRPBhaao6ue+baAr19YAE
         2KRMPUqXLsakHQRahv4FWYfU8FpGFxjcriKUUb+xIYShZ5+kqLCZnUcRTnNx8YOpCgET
         Z/ifWw/36Co7zZMVlPBbM+i7Jq6vW9o6/G3E0trikLObtSDBV0HIgJWZLQ6mc4uDTx8R
         GQHmDli2fC/vHW+Hs6gLusbsPg5hqd9NnGcjekFKtePZtONja8SLl2wc6CW0lF0+AlXh
         kZDA==
X-Forwarded-Encrypted: i=1; AJvYcCVheGKC3dZ6weC8CRctfTrR4ppr9K7G/Fiid+72Wa6JKSpd0y2llNzgK2SdSdY1riP4Jpy551FMGsUtoYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsQHY9b816IInmezCZkRPWmL0zEqxc4tUQd5VhEXWhobZCMde
	8XdbjH6j1Gwikbp5/f+LVa9EG1EQXoSpW2swo1afyogMsiVxpzVC95ddXSH19SM=
X-Google-Smtp-Source: AGHT+IE5ENTzo+dT9zKouKtqRvlreBmlWUNDjWLfEY6LjfhA8A9XX+o0gQY6waehLUspJDHC08roOQ==
X-Received: by 2002:a17:902:e88b:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-20b920e9453mr44876995ad.35.1727717299036;
        Mon, 30 Sep 2024 10:28:19 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60de3sm56939385ad.41.2024.09.30.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:28:18 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 1/1] hv_netvsc: Link queues to NAPIs
Date: Mon, 30 Sep 2024 17:27:09 +0000
Message-Id: <20240930172709.57417-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930172709.57417-1-jdamato@fastly.com>
References: <20240930172709.57417-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to link queues to NAPI instances so that they
can be queried with netlink.

Shradha Gupta tested the patch and reported that the results are
as expected:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                           --dump queue-get --json='{"ifindex": 2}'

 [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'},
  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'},
  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'tx'},
  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Tested-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc.c       | 13 ++++++++++++-
 drivers/net/hyperv/rndis_filter.c |  9 +++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 2b6ec979a62f..9afb08dbc350 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -712,8 +712,13 @@ void netvsc_device_remove(struct hv_device *device)
 	for (i = 0; i < net_device->num_chn; i++) {
 		/* See also vmbus_reset_channel_cb(). */
 		/* only disable enabled NAPI channel */
-		if (i < ndev->real_num_rx_queues)
+		if (i < ndev->real_num_rx_queues) {
+			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX,
+					     NULL);
+			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX,
+					     NULL);
 			napi_disable(&net_device->chan_table[i].napi);
+		}
 
 		netif_napi_del(&net_device->chan_table[i].napi);
 	}
@@ -1787,6 +1792,10 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 	netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
 
 	napi_enable(&net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
+			     &net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
+			     &net_device->chan_table[0].napi);
 
 	/* Connect with the NetVsp */
 	ret = netvsc_connect_vsp(device, net_device, device_info);
@@ -1805,6 +1814,8 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 close:
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(&net_device->chan_table[0].napi);
 
 	/* Now, we can close the channel safely */
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index ecc2128ca9b7..c0ceeef4fcd8 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1269,10 +1269,15 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	ret = vmbus_open(new_sc, netvsc_ring_bytes,
 			 netvsc_ring_bytes, NULL, 0,
 			 netvsc_channel_cb, nvchan);
-	if (ret == 0)
+	if (ret == 0) {
 		napi_enable(&nvchan->napi);
-	else
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+				     &nvchan->napi);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+				     &nvchan->napi);
+	} else {
 		netdev_notice(ndev, "sub channel open failed: %d\n", ret);
+	}
 
 	if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
 		wake_up(&nvscdev->subchan_open);
-- 
2.34.1


