Return-Path: <linux-kernel+bounces-400681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32729C10E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102381C22A07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BA218D82;
	Thu,  7 Nov 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvvZHTSc"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FC2185B3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014599; cv=none; b=gcGOkpEBGjhaCk8+1GPYWRH6c7RoL3nxZTDeONKxh15MVvqMfZoPP7kkcwh46fotAd6bQXj95937zpRVefw1BbTY2DUCmUNcYfhCmeSCymxUOZ3Kz/8ff9cXiKyqHpuV4XwYw2MaBQQ94FHY1he9DuhJDiwdLj46BWLjEhJj6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014599; c=relaxed/simple;
	bh=MvJ6yPQOrI6wahZADxfSEp4jdMsiVlhVUJM/vAV2fS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rYF+0kKn8wZxs1OF0s8MY8Jepp5qlwHzZLTupUWlNnuWhPDX3f+Hy8Jp968+saacdFqI2uXZZNHVCowJbjjcveAhR8lACcLJtaN3sYf5hpGdxinfq5n+J8gcJdYFFKyMhpIz/F4M8E1z+pcUlWcrqk8Sme6XxO6JWevxWlqGD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvvZHTSc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so3078235276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014597; x=1731619397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J83wfJiF0JQ+3oVDQ8yXRG5SdUbkoDbY+HbVcbuh1Lg=;
        b=VvvZHTScGjBhZdgsuFEa93EhYKmmQxRdWkoHnY328/p+Ll5mw+hP1n1OxjoILI82XN
         o3oaxBgILqZ4HJXJ8xh6E8e+a7Ypg/QqIO5YrhNwUQqZEKRQwF0qY7ZriSSwajZAkgIf
         KsUyt+Yaw1gRffdhVO+xkhS1PpUz8M/h0uect80zoz+LiiLcUe0UIyibCu0gfegDPw8c
         ISiTFd2I7rgWQyXVN7v0GIlcInJ4f2ueJL/LFNklTlppHhosoinG5cg0rbjU9sVhdlXA
         hvGZlbObGURLjMpWSyst+pA1QQBR4lS1+z3lrT7N1f66r/Ey/phKRbCW/uh7nyJnJj6F
         TEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014597; x=1731619397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J83wfJiF0JQ+3oVDQ8yXRG5SdUbkoDbY+HbVcbuh1Lg=;
        b=dSl1qgIdbg7FfATcerX7KrYi/bqBkag4iFrcMCr9u7qqI0+T7H4+U4cV1RA7n6LiDD
         loJRscXYk0CZPGImPf7nAc5wipuTTZcAxWNQ6F1qzW9hfg1XfxT+BbZpjulBJW/l/soh
         8kMgQWMudyKkI5Z7gNZ42J584fhLMBztgcQoyzSkAmf7S1n3ypKVMbpveJmEXL6ZeCxz
         Rvxs9Rlz2g8MkBHFVBajF1R795DiV7Ab14R6bbXnO+P8f5LumXZ+rIluMsGiNQW1de72
         4o6lUiTR6fGz34SQT6x59mL3NVoRUKkS9e3GwoTdY/P77iWGniPudqLO2UqStUSgkyoQ
         326g==
X-Forwarded-Encrypted: i=1; AJvYcCUoQrOiXW0hEGeEkgMDAIWzJqaYCor8L3FizusabZD3O0jsTrwLM9Pm0wIonKY7RQwWTqgVf/lNQPQwZYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dXFGfweD+I5prPtsSJPA89ko9hJ232xR/OypSbpYXdwI4LaW
	ne63IYkPkNoZ2mfZ/BCnsFUv6gaTofggIL1Zw8377z27dqztri8nS+xBRzv4FH8PTnzYisQNEPt
	UeFT5VMna6mJeS2AbprUwmA==
X-Google-Smtp-Source: AGHT+IF6z/QPQ1XLZAvWGreuIWIzXwrgafM/eQRgTmOxVD278ef+a/phPaMZMGyLfa6rqPGjMSbh4Q8VmdUVJC+pTw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:a249:0:b0:e28:e510:6ab1 with SMTP
 id 3f1490d57ef6-e337f8faff5mr344276.8.1731014597352; Thu, 07 Nov 2024
 13:23:17 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:06 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/5] net: page_pool: create page_pool_alloc_netmem
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.

This enables drivers that want currently use page_pool_alloc to
transition to netmem by converting the call sites to
page_pool_alloc_netmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/helpers.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..8e548ff3044c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -116,22 +116,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
-static inline struct page *page_pool_alloc(struct page_pool *pool,
-					   unsigned int *offset,
-					   unsigned int *size, gfp_t gfp)
+static inline netmem_ref page_pool_alloc_netmem(struct page_pool *pool,
+						unsigned int *offset,
+						unsigned int *size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page;
+	netmem_ref netmem;
 
 	if ((*size << 1) > max_size) {
 		*size = max_size;
 		*offset = 0;
-		return page_pool_alloc_pages(pool, gfp);
+		return page_pool_alloc_netmems(pool, gfp);
 	}
 
-	page = page_pool_alloc_frag(pool, offset, *size, gfp);
-	if (unlikely(!page))
-		return NULL;
+	netmem = page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
+	if (unlikely(!netmem))
+		return 0;
 
 	/* There is very likely not enough space for another fragment, so append
 	 * the remaining size to the current fragment to avoid truesize
@@ -142,7 +142,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		pool->frag_offset = max_size;
 	}
 
-	return page;
+	return netmem;
+}
+
+static inline struct page *page_pool_alloc(struct page_pool *pool,
+					   unsigned int *offset,
+					   unsigned int *size, gfp_t gfp)
+{
+	return netmem_to_page(page_pool_alloc_netmem(pool, offset, size, gfp));
 }
 
 /**
-- 
2.47.0.277.g8800431eea-goog


