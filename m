Return-Path: <linux-kernel+bounces-387669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9A9B545E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D23284DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45DA209696;
	Tue, 29 Oct 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPcxWyh4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477C208978
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234752; cv=none; b=OePtoOMWptxxiaMWu1L1GaBG9u9Z4ofc/14VVlPyoXuGwd9PGvRdfUBH9YKiD137UoNqP/EI/U6s0KuzWXbgh0poAMiBT61HY+u5K0xA8nrG1MYHs/yKnj3UujYoN/csPWjMkCyO2PMVe5H+Cqpq4MaCuQYMr9QiuT3QuAZ+VR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234752; c=relaxed/simple;
	bh=wj9CgD+x0GVWC/RysuEBDRx4mXq9fGHiB/kdVGdaca4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pm2NrP77dBKX6qbAip5OiR1tPCYW9Lizu9sQRXuP9/ykH9AT8DA34/z4Z5spNE+DuZFw1ev3FgnW3YEkRy/UVOcejEZ90rGSNvXs/TrCjVdEjMK1e2waW01ttB8rQxR0qldhRbP3gFyRA2E02m6P0e06tLQRw4/7XNyymOKsndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPcxWyh4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc60660dso8894576276.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234749; x=1730839549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia0Z0AQiuotb1aQB7+r4THgYyxvP1pQZETcnEmFDqWc=;
        b=nPcxWyh4nHDSfNGljewbLP/Ur27KLsWEgOsJWAgGqK3EwwPcSUeOcF9Z6Z7v3vqShx
         uZEPgwTPherzGDH6Fx4fwowpnrbAM9/mrffJTAa4IrtUiJS4/4MXywBcMzLFNbyS5Qt7
         +oIxoclN2QOnB9Arxel024zrWvT8LFsZkuVuFB80g4WRbP9pDlReKAvLAnNX5mjtJuO/
         SvNfXga1w5eFkRoWw4F+fnxN+tnQeCriNBaQpDkbtMVRpeiYa8rUJf5l5Z9W3o09kUvT
         g2jClRPtnG+C4UXCqYD6Mmv7rzVWz3MZRZGCa4X5sftT/grATazTuDFP6iOa2Ox2KzjQ
         Zp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234749; x=1730839549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia0Z0AQiuotb1aQB7+r4THgYyxvP1pQZETcnEmFDqWc=;
        b=inKcAFHo4DjuAh8Uevzu5LCvye+ncGycHTcIXqMT8EFvgyg6XvvR5x6mlYCgAPWoMq
         BMRQ/f/rMYLmUS88rfsKOXMlLiPczgnfckzHkZSwCX3QPqY2jFQR2sR/LRMXII3w6XgI
         uaOxAtgvrSVCLVdQ3Ri1bxst2yVShJgsSQwKwD3Q/ij64hN0D17JqTuFOzROR4OVlRUJ
         SCK1CJoEkWsNwIGhoufbYvjdNs9W68eaYmjg2LeZRdf5DjsWZOnmMpqoWCk+wDL6sNt5
         o2L8UDlOvq/BpW3N6WkZPqiQZgUfbzxXnGaUqo6qPNj6vz8w5md0KYImaOpFhjh7uwWk
         NNLA==
X-Forwarded-Encrypted: i=1; AJvYcCU5TW+ssMkuQRonLQeEPkn/uFUO6imMuTlLU4Rd/kQ3U7CPorPj/Uxo18Anm+uAt9LYn9GUYTWaCeSa4fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5nXOm/PlJXq2/LgMurbu3FGTQTaWCiRZ3HkInFtHCSe2/p12
	4KiTU1ohVuZAk55Wt1YDgG4+jA99IfjbgowgC6WhMJZXIk/q3oEubyDXdjY84zNtffceykH+oNZ
	ucRM1RZNVCFfg243koynJYg==
X-Google-Smtp-Source: AGHT+IF6iUlUajnIuWSLwO8GHFuWPdZ7TzjtXW+wmOwLsLSi+oJyQ0Mqbj3G/hC6QRpn9nQ26QyYa9SQhh+OMtpcIA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:f301:0:b0:e28:eaba:356a with SMTP
 id 3f1490d57ef6-e3087c10916mr55330276.9.1730234748927; Tue, 29 Oct 2024
 13:45:48 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:37 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-4-almasrymina@google.com>
Subject: [PATCH net-next v1 3/7] page_pool: Set `dma_sync` to false for devmem
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
index 77de79c1933b..528dd4d18eab 100644
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
2.47.0.163.g1226f6d8fa-goog


