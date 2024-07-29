Return-Path: <linux-kernel+bounces-266021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D193F956
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254D71F23050
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620A158A1F;
	Mon, 29 Jul 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VJYq2tcX"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF415697B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266829; cv=none; b=csy4QwOrp9ZcGutZJCg2utCEkBjhdVovh4aKqCFuk2sRAEAdP0G/uARbtTXBsrmyrIMKRH3GFaBiZ1fsSDZBZG5oXawBlSnGnCfA4cvXkoyUhw9EF2Jun1c7pvfWMpN4rKenLJyiOuQMIBl6rP2l03wl1ecJo25mH8T+qSj4ZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266829; c=relaxed/simple;
	bh=EUzQAcMeIXbUvWPp/TFgPYPoqnzPkFmvgt8VJ9w9N6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5pMGU7KQ2ZlwALYoTDrFHtGgcWkGFhH66VfCS7KcjvryuBriYDTu/g+a1ePkVSku2CrSfmLEvosRnrfuKEzHw9/FTyuzXdsWsg0PXfca4yxyaC/9G+g9TnYlm8E+MEGE2x17k/5V1O240ca5s79+wz85xQr59jNU+rXJ03UVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VJYq2tcX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d2b921c48so2497029b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722266827; x=1722871627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdJePI/ro3lzopvsSRF6ibNI3e6YZR3IDZVsnQc1RAc=;
        b=VJYq2tcX1hncU2L3XHAdLYZFlFyGKnU8ns6HNQUwHKjs0T+Z2kpagHkyrixbPmlBgd
         QbUcg41gZntVNnkA8b3M/wzfVMGwl+CQyFok4Vk4KIYQt2F3NCCHb/O0j+mHs55BHQ6h
         zWKjSdokwsXSCt2L7ZE3oNk7OeOqyKhg14BdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266827; x=1722871627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdJePI/ro3lzopvsSRF6ibNI3e6YZR3IDZVsnQc1RAc=;
        b=W2fPSyvmv7oFSkm+y5adt0+pXoDQRd6BlPt9iaypB87L7/WZlhBSGdC3fRxr1mF4oX
         6U6usEVCt+bP2FdJHQb579+SALov/y3kH2fUITsVWudUm13qSFywdVnlW4mqK65YDBts
         hUekrVEi+nSuNy24NG3lwumSKd5F+IfcMd3HwgiMS1kA5u/sMnDHS4hh3iASG6RYC8NE
         ifoi5FTq7OkyKP9JI40rp4fccXXwP2AW2Ud05G7A1ya7X6Lf7JoGrw76sZ406VVYM7hu
         15HjIudbRxeb3yoLYm/vVzRoIqIcaUDqHgJPyNTBPVsI89SeWnNRa1wkMN4zpa9oyV+j
         IeWg==
X-Gm-Message-State: AOJu0YxIG2h36fnxm0Jkvbi6wZ01I1RhQ56qog3OpVLTM4YXGb16Femt
	9JCfwky+mWAI+Fuf+sJ2mjSILod0qGPkkrrJqgw9nE1fubYdGT5PMVlKdJQCSzxZuc3EF8efcYk
	QNgnzJlvJCcS8HGfrf+2ai4nmwnJRyRO7vcMgPcMT4aHqCihgOzb3g4zq4Bq6sbIDW5fnCZhVW1
	4ZhbzZ5VVhJjvjdJCGXMWdYgveR8whFTjYXs1evOjzANHk7A==
X-Google-Smtp-Source: AGHT+IG0a1j3+SwbSmvGiaJIJjPIa0q+99nCgL0bnnDAjSn1qKIpbm+DTpKgqIsAoP+zXIujRWMPqQ==
X-Received: by 2002:a05:6a21:3948:b0:1c4:9e5f:c645 with SMTP id adf61e73a8af0-1c4a13a36eamr5586175637.40.1722266826625;
        Mon, 29 Jul 2024 08:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7115a1sm6947079b3a.46.2024.07.29.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:27:06 -0700 (PDT)
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
Subject: [PATCH net-next] net: wangxun: use net_prefetch to simplify logic
Date: Mon, 29 Jul 2024 15:26:47 +0000
Message-Id: <20240729152651.258713-1-jdamato@fastly.com>
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


