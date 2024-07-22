Return-Path: <linux-kernel+bounces-259315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3B9393FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02F7281F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6C16F909;
	Mon, 22 Jul 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="a5iY12aK"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D111C695
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675307; cv=none; b=dhkpaNZ2Mmq75mCn/78qofrr7Zn+9jLBGg6OYbbQm1wMU6O5ty2cXgQxOwCCXpi65724YdxBgTSfbkZsgvCsopvJiYcl/iHHKNyRVtSe7+7oE35Mjt9i3qNV1Vw1Ib1ynoiGUgnX0TxjPyUBCAAvrz00hGcbF3vu4HDPrjEBPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675307; c=relaxed/simple;
	bh=21T+7guqWFCcfmKQsaPQWLJG0mdfUYR6tiduUYWJzCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b/ZISWtijRTsMRuOIbqke5vIebfc+siGxwnaCMLNd3AxpTc7zUeNqAsSwFkp4mUPhGVe4Bb9ULOawsdYo1kN6ygL+4cyGEaiaiKubiKiDii8RiDbP6xo2UhJIaC7wHA/CLFcMO2dP9ehz/Dl7lXLxaS1NbIiS4XgdMSwZbQovDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=a5iY12aK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc658b6b2eso33442255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721675305; x=1722280105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njVaMbDcMaiQerRZ4wsTI9OpiF5HxfQBcNMiBdohBpc=;
        b=a5iY12aKKrQLX1yN5xgNlzmOlBMkt0DeiNeHH21gVGOZkMm9vg4Xq/Pw+UIQlCFRUs
         I0aJFmXwTR7+LVLtQ71bvj/oz0SisYDPBK+J4VkfpY17JaVob2MRlQzLY+YSc7D4OF7E
         zsi2ZVQCaTRsVKLe98+4AelHMQjC7AfPIyC4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675305; x=1722280105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njVaMbDcMaiQerRZ4wsTI9OpiF5HxfQBcNMiBdohBpc=;
        b=OQCiUjHMK8Va2JsMP+Ca5JYdvLsjkvNYQ3FfPc+0pWQMtEYAKPNsgVQWDJHXRTCyIV
         w8iPdw0sfdFz2lHw8d7Xyvk23zmi+ERN/FRD74EFoIUt+JxnwYabCgzjyJDWE/yl3fnA
         8pYkmIRbyLSfUrq2pxyrjNb+r6yUQ1M5uMcaqQd+M7/fKSqPBlvPR1MGULOvnZ6G1Gmg
         yzHLh7AMd8M6K3Guvr2Q6oF5443m9v6vBz1w7kkZtj3/BWtlyHSTQJl3y8QU2SF056g5
         0kQ1phFzDGfl888iW6e2zPYEzgy5hJYte5TFHO26e3zOPavzFmJ83hS35b47jfq8pT+0
         zOCA==
X-Gm-Message-State: AOJu0YzuPY+9rW8Hfha3TzKQbe+JScmmpF5Vspv2H4csLnmKYa4U7ucw
	EdYJgaB1FQryIa1in3S0MQgIjppIfiV2tOSLne90w5kULQCnrmK7LiyCdYmYdnT7G0viVC8NMkS
	QwU6/ooCSp7uXRbQfaX+N2WibMJGpGXNNWIvDIUohAzJ99iNejpHBj6eiZFOISLWPfpxDVA2ICN
	+lzakQTDEemwkidJidh760eXUDQOysv36b0CAYndaMeZs=
X-Google-Smtp-Source: AGHT+IEqkTQAT1FPq412tRLy/kyTwhtLiCNeKUuL42bstXUpr01mSeEs0TrxDjRg1iZSGF1MUfAxOw==
X-Received: by 2002:a17:903:41cc:b0:1fb:7c7f:6447 with SMTP id d9443c01a7336-1fdb5f6b353mr6705625ad.25.1721675304659;
        Mon, 22 Jul 2024 12:08:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25a841sm58350335ad.32.2024.07.22.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:08:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net] net: wangxun: use net_prefetch to simplify logic
Date: Mon, 22 Jul 2024 19:08:13 +0000
Message-Id: <20240722190815.402355-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use net_prefetch to remove #ifdef and simplify prefetch logic. This
follows the pattern introduced in a previous commit f468f21b7af0 ("net:
Take common prefetch code structure into a function"), which replaced
the same logic in all existing drivers at that time.

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 1eecba984f3b..2b3d6586f44a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -251,10 +251,7 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
 				  rx_buffer->page_offset;
 
 		/* prefetch first cache line of first page */
-		prefetch(page_addr);
-#if L1_CACHE_BYTES < 128
-		prefetch(page_addr + L1_CACHE_BYTES);
-#endif
+		net_prefetch(page_addr);
 
 		/* allocate a skb to store the frags */
 		skb = napi_alloc_skb(&rx_ring->q_vector->napi, WX_RXBUFFER_256);
-- 
2.25.1


