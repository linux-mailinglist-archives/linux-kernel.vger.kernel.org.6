Return-Path: <linux-kernel+bounces-438111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B29E9CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DAA166BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459441C5CBB;
	Mon,  9 Dec 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEEVEtWf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4B1B040D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764997; cv=none; b=E1zHEogowSFE7prWC/CcITTHdR8OfdQ1WgsPnIRl7Zs4buYccpZml8oHWK1G26R/k++jvSdtiIdLVTBIHzhqKPVeWt/oZIWDCO6IZ3ssxMFYpCNJeW/vV3+F7CoTbsLVhWiGGSCiQqoKcXFjoPrMVjewYvzKvb3xF3tjnj89qOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764997; c=relaxed/simple;
	bh=RqJl83u5mUsQ1GGoNFG7LwEJNTXhU11e4cYe3HNOEy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxcKPOo9CUGO4AF2rvb59tbmAYDDCMWoxQLoaATz8zP0Iqrw9mC0i+k3LIuhhIbyI/YkVw0jHo6JVqsjwzYlYJrFCxy7J0yluydUYSVa/Q2/I0ZEGxJQEE/bkn30wJeEB0WqiuYMqPJ445uk4ix6TJ6WYHjgcmSGjMEsf3+FVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEEVEtWf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso3079061a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764995; x=1734369795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz5RWYLKjoPvLP8MJgn8eUAzuErak4lvg0fVmbsg4yk=;
        b=pEEVEtWfb2MmbsnwcYCnWPtbnkoGDomW/KARFcceOysPQS1bloHXb5E0YRcDis7qw0
         Kc1UQk3E+kfzskUeFx8OMZwhBjFcin6tV9b/KcyWC04apLP8AN2BBjtbbxUPi0AGs0Az
         O5Mq79poS0BxAijG/EqrQL12bWAI5a6GcLVYm+IyPWFG/iHB8cTxoEuwCGrNDHW0YpcZ
         WXKjcpu1VMNO3bc15tW/oQNyriJWhVpdxK0FoZn/4vc/Ldxcw/g47TPmLOy5ScsM+k7b
         CppNcvWyuZvGaqEx37gIeRNEfWvuySEfHvHjPmca+But0T98oSXBmZq/J2JraxfFxij6
         u/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764995; x=1734369795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz5RWYLKjoPvLP8MJgn8eUAzuErak4lvg0fVmbsg4yk=;
        b=qjL/fxkrf8je915qHSirEul1hMittLr2fv6nEdNiFddSgVCnBCB5Jyzv3jTrlQSqoL
         OLMXucoU5Xu3Dp8qL3XO7+11PBzaoMK9j+SjcHZgwpMIeBHXsULge18gFvr5fmYOd8p5
         2Zzxst4wyqpfBmIf7EcrA1MoP1Sk2NiA5VKV9gbFyeTqnL4WhFRPgim52LmaH36K0S6s
         vbaMsWzbLq/0KOEz6TG6ZO+Gr/yDeqrpw145yaez7OExd0INioEFayZgEQPQO9a/Xdq/
         A+/EAbH5fgE4VFYeSAPXILyERb+UMPrYTr4yqwSD3yqHi01mZQmjcoCmNUHQZSo0+jyY
         VzSg==
X-Forwarded-Encrypted: i=1; AJvYcCVXBreG7hm4oC7OR7h+aeLWv9+xoRXfgKo8CrXePVEEouZH2u5aBE7S07IF9IYIeS1fPwIE7hlg2u/fzCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMrOEFZFu8hBfLf9AWVCtMuTdD2gPLcHRp8TWAk4cO+aJqdeU
	SKNWvGcio63mYYEKwz3a48pbAUYqkDYBV1RxSOFbNvqgZBbVn4XregqCUM4xu7Kj8j/vhjoAl3y
	NONYFX2naqeYXCK7hYdYb0Q==
X-Google-Smtp-Source: AGHT+IEPftCb4Wma3I6ceQ+nMsGCVDlESSWU7yvIQd8cUNgRVcxZksTsHMKUHY+m3zByd0dJJtyL5yltuD+o/Xbo/Q==
X-Received: from pjuw15.prod.google.com ([2002:a17:90a:d60f:b0:2ef:977f:1108])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d52:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2efcf26e18fmr1739112a91.32.1733764995640;
 Mon, 09 Dec 2024 09:23:15 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:06 +0000
In-Reply-To: <20241209172308.1212819-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-4-almasrymina@google.com>
Subject: [PATCH net-next v3 3/5] page_pool: Set `dma_sync` to false for devmem
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

From: Samiullah Khawaja <skhawaja@google.com>

Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
them generic. Set dma_sync to false for devmem memory provider because
the dma_sync APIs should not be used for dma_buf backed devmem memory
provider.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/devmem.c    | 9 ++++-----
 net/core/page_pool.c | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..826d0b00159f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,11 +331,10 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (!binding)
 		return -EINVAL;
 
-	if (!pool->dma_map)
-		return -EOPNOTSUPP;
-
-	if (pool->dma_sync)
-		return -EOPNOTSUPP;
+	/* dma-buf dma addresses should not be used with
+	 * dma_sync_for_cpu/device. Force disable dma_sync.
+	 */
+	pool->dma_sync = false;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3c0e19e13e64..060450082342 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,6 +287,9 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_priv) {
+		if (!pool->dma_map || !pool->dma_sync)
+			return -EOPNOTSUPP;
+
 		err = mp_dmabuf_devmem_init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
-- 
2.47.0.338.g60cca15819-goog


