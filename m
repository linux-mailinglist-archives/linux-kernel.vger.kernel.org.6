Return-Path: <linux-kernel+bounces-210729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 744879047F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0BD1F23279
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20986391;
	Wed, 12 Jun 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaFQLcvU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94219F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151431; cv=none; b=E8SiIS3zdGNwrqlJsxv39+M8YeeU7Pu+u72AdxFcxn6mAXaWYrEWTRPbjSwx8h2fqfYawE8SXH86H93fnH8Feif3+2RPnFFW4t4jdbSVF/FYk6WH95lbIF6/HGibs+5S1Mrk4ARDaqqGPq672TBKh10sDo9XinO4Hlwpl2Crb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151431; c=relaxed/simple;
	bh=/5CStUD3+h5vLHrk8rbpKIF6eAbRF4CgImyTE/vqojM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bj7sHWg5h5A6J0JIKaJWZHQu0SYollexBs5Ic5bKDEkgF+JepYW+Mg/1TIGw+i8fn3DhbBCOMDJjKNvqXzweHVRiZ9SiCef7IZ/DJES+EgI7APOXNu6aicssbH14g5JmEutXCe3wEtvDCO5FHPABLf8naxhROQpiasR9WbwMcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JaFQLcvU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627956be166so122393947b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718151429; x=1718756229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NOJsof7BEpZN8Hpp/vHtOuty3r3bM9rd+pyvN7nHOJo=;
        b=JaFQLcvUIcMZ0z3XkemQNaWk4yyBXW9wNM//vgLx9gjtquHce4tNbpkQlown24GPrh
         jzPndxXLTpOSugpLwcwR3P3TFwqoCmwdfDHxQTIY3Uo0IrL3b0mOiOohWCxP6mTggkFk
         dcOm6MTCsPo/jzYMA7ycR/9wtWVaCRe83+TWzOxlRdBOz6YVx0sK3O/QH5bY/xYKGTDa
         Lux6gxmA1wu2xGzZQK97O+5MD1I7izEtCR6893Uu/MTqApmKYqTZwjdgwthtBRAa3M5k
         FMPdHqIopXmvHWkyJHDZJYa3fvgN1u6tVqFKFipWaTh1eh3vIQDy67LZwmIwkq1o20ol
         myqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718151429; x=1718756229;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOJsof7BEpZN8Hpp/vHtOuty3r3bM9rd+pyvN7nHOJo=;
        b=jHUIGoMXCZORi5miJEi0Xp3ib+a6qsulCvT64hzL1TfNB6/DCiduYyYzKgdIEYefd1
         Wz3glM1/qJIoJZFM+x7wHlvxbeQBqU5SspfKEBBcFyr8XDQLyC9UTanzt7kUXH3g008N
         RLhFkkecjYyn/eix3/kiCF+xxpke5pRoiGGONohx+AiGPUL/TQvxvoyHraOgHXuxI9eV
         uWCc6PnZF/ImcQnA6PWD1FachaIKJnF6//VuEF3sLiArnm14liJlKkabgQStgwErVzXZ
         rDtCZPd0fqOcEE0t7FrhrtQt2wSLwS3v9xQQx2cQcB8z/uI/rhQTcZwEbw23L5vesT0r
         Mm4w==
X-Forwarded-Encrypted: i=1; AJvYcCXfPjGNjCvMyyDaeSd+tzxIfnc34Rx2EUT7iXy8DvZFHdlR0VRICRwGjnUUCb/kkDZJUe/SyT8RUXeCxYNusgZfPcA4Zmwx5zx6BP8x
X-Gm-Message-State: AOJu0YyluOCyJyrN+qp3CYmBvDc0syJ++QBaGU24CEBvws8w5nVjAPeM
	Hn/h/lFdWSpsUxgFnmYDBSuMHBYnQ4aaQwzVJFuHMcaewtAYoI/qdjpym91+Ys7vUCZ212OJhdX
	lpGrwCLjuWqASeg==
X-Google-Smtp-Source: AGHT+IFj5q7Yo4YsIJsQrLQYOROHj6YJ7et7llRDI8ZMXDiH4h4WLHCf4vHI/re4F+qzmcJAh1iw3DYuY1CbWUQ=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:8702:0:b0:dfa:b352:824c with SMTP id
 3f1490d57ef6-dfe66b65314mr59562276.7.1718151428817; Tue, 11 Jun 2024 17:17:08
 -0700 (PDT)
Date: Wed, 12 Jun 2024 00:16:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240612001654.923887-1-ziweixiao@google.com>
Subject: [PATCH net] gve: Clear napi->skb before dev_kfree_skb_any()
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, hramamurthy@google.com, willemb@google.com, 
	rushilg@google.com, bcf@google.com, csully@google.com, 
	linux-kernel@vger.kernel.org, stable@kernel.org, 
	Ziwei Xiao <ziweixiao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

gve_rx_free_skb incorrectly leaves napi->skb referencing an skb after it
is freed with dev_kfree_skb_any(). This can result in a subsequent call
to napi_get_frags returning a dangling pointer.

Fix this by clearing napi->skb before the skb is freed.

Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Cc: stable@vger.kernel.org
Reported-by: Shailend Chand <shailend@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c1c912de59c7..1154c1d8f66f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -647,11 +647,13 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
-static void gve_rx_free_skb(struct gve_rx_ring *rx)
+static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
 		return;
 
+	if (rx->ctx.skb_head == napi->skb)
+		napi->skb = NULL;
 	dev_kfree_skb_any(rx->ctx.skb_head);
 	rx->ctx.skb_head = NULL;
 	rx->ctx.skb_tail = NULL;
@@ -950,7 +952,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		err = gve_rx_dqo(napi, rx, compl_desc, complq->head, rx->q_num);
 		if (err < 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			if (err == -ENOMEM)
 				rx->rx_skb_alloc_fail++;
@@ -993,7 +995,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		/* gve_rx_complete_skb() will consume skb if successful */
 		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			rx->rx_desc_err_dropped_pkt++;
 			u64_stats_update_end(&rx->statss);
-- 
2.45.2.505.gda0bf45e8d-goog


