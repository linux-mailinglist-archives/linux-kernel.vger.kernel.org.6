Return-Path: <linux-kernel+bounces-442133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06499ED86B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B04D18879C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585C1F238D;
	Wed, 11 Dec 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/EpJ0W2"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEC1EC4D3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952042; cv=none; b=mibps5WCJIfHUkrCQMfs64tDyHq7UXYHvadxCKSWxROjmSmp90d4xfwan73YJqUcvXa3lzBxz+t2yLECSIAGxsVxl0YrHcGqHM0Nlona3vVX5jp1ZdSuGQEQbZJtoXlzG05NWKPJq/ey0Jvc6e7yXQ0wctNzVv0LyoIWODS591E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952042; c=relaxed/simple;
	bh=b90XShILltXC+LvOAJbN7AuVnXlBIVN+oi/xu7qF+1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ml4+MQzj89UsSKnoey1gXMFfOY1bHVBi6+hY2vupYmy+bZN0QZ9Kb2pEYHXQG14Cgn7LUUA27pdIJmHRtD8ooidtZp2X8eX+6nAKZ8gxYSMlllPH01K7Wm9JGbzvjnchnutOmA1AMTGB+vPJjl3mwG8zpK9fF/YClMNI8fcrg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/EpJ0W2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so7664682a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952039; x=1734556839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkkaSKdaGNTNNhg4FUb498GHLs5FUYHJ5RvbafI+ZxI=;
        b=s/EpJ0W2mNFEeUnNn1xZ1TFGvqlWTt/ynOuqMsa/43tYpPRomrTsZI31x+4idNcsGJ
         p0bfQKfAU4Jks7ctcnEorFsbfjD7ENbp6GkW/tYV7qaoD/KVLgdn4BMLw7WSQC9odt9G
         rzGnsb064jnAS+0u9wflHiiulXj+KkItTUSbc2qzehLmp2SWEndYdm5XnzhgwpdyyIHL
         vQxVKtflHywz7LBt4G7BaiwtlbSP8ZVJTBVeXRdykSt1YkS3X7cdmFvRzBu2dhCR4hm5
         dVTIpL7Hx8V0qa/C77W+3YC+6iXKY90xUbkRqyXLqZnbffceXTyGZ8CC/QRonkIcZaRw
         IomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952039; x=1734556839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkkaSKdaGNTNNhg4FUb498GHLs5FUYHJ5RvbafI+ZxI=;
        b=smxsGSSBhGX0/8DOabo/3VOb2dYPfUk574dRPNdfNlv/zmXqgUS3bnNOQ34F5skvng
         4/AJlXmHf9yFqmBmzyJFCWUYV4hGDUdTwda1OmMYn0UTdwUrOqs0hh/rXIysaOz/wxgX
         KW5cXWkCwlv3zsGYZnnDGURzXQ3PFmrWbrY3Ruy2pw1wwnv9OJfzSE1J6RFxVYiVJjOR
         ECaCop2znJyXZAfanVdtKKBICfPxUCa53iTNBvSnmrzsBvXL1BboKMqYYkII1jRGR8N2
         4BG6QjcmKnPku424QMm6ork1hlkxJU4KNmGnnTi0/8VPjAOxieaRMStvqyfG5krYl1lR
         V+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXBYI0+iTkLDasJ9UoelprlGp2/QaRPHZPyVk1rRNZxh/JDgywTyfU9rQvB6SuEvZgguno41QzCloRFOYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxop9Twk136k9bYJ2p71JgnH6yEvy1JTG976bjtY2XMq6dOWIlv
	PpapvEjxE1tEFoGnZD4tijF/0GDinwEPjkhJpPJmJGds+5qkN9VJD0f7fbvpa2IDGemA2NlzvI8
	EkHcxiuKCO7Qa3g3qAZn9jQ==
X-Google-Smtp-Source: AGHT+IEWhVqk1hESVIlHN9fpnPz7ovhaAwHnlpf82RR0HAKH6Gbqs6fHleZO+74e3iAsiD+P7NcS8Md3jf3KevFa3Q==
X-Received: from pfbc2.prod.google.com ([2002:a05:6a00:ad02:b0:725:e76f:1445])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258a:b0:1db:ec3e:c959 with SMTP id adf61e73a8af0-1e1cea99eadmr1328009637.10.1733952039349;
 Wed, 11 Dec 2024 13:20:39 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:30 +0000
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-4-almasrymina@google.com>
Subject: [PATCH net-next v4 3/5] page_pool: Set `dma_sync` to false for devmem
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
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

v4:
- Improve comment (Jakub)

---
 net/core/devmem.c    | 9 ++++-----
 net/core/page_pool.c | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..3ebdeed2bf18 100644
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
+	/* dma-buf dma addresses do not need and should not be used with
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


