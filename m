Return-Path: <linux-kernel+bounces-442132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164F9ED863
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC75164089
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA321F0E56;
	Wed, 11 Dec 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWqXVral"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F31EC4CD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952039; cv=none; b=e8HgFdJ/2F8Lp+GSYJVI/2MjBpZ1lXVXu3oETeeU8OAoRuR2WcRKTQ6aQkrSTvMdV8/hQw7bXWaunuhd7392hHTZHn7AxkJK9XAgp5cVl704AVobPG6viMxYxtJAMYszQD2TUJkl8iYsA5+77Ez1Tbgj5AO1Bt4F2z/Mut4OymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952039; c=relaxed/simple;
	bh=3m4AIfXRnx+qjxTq4vCGjNR0f9YLSWQ6fISqEIE0hIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TK2ZTWN4XR8ZTm5XVY04FKaIUUyTmFyz+EelshG93dc7b64OHI8h/RlV/zcfdo3CmU6Qn7DVPiyqt5DKIzV3bJZXiicNB93FUDYR22ALX1NP+9G+Br1nOLK5NEMxRisBrb8GqvSsYZJr1gyY/hDB8JiXLgLVhb/ZpCOoojrjMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWqXVral; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eedd15c29eso6995800a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952038; x=1734556838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mA8UqtPkSm6GQfXzmIjEK9H6u29hiGHFb3M2KsrojFY=;
        b=zWqXVralWRnHS3P3g7jzVp5qP+IUiFeFJlYBpRDXiwybvAV8q73zgWe1vVLbDgel9u
         P4R/a9dYsIkhiZlFvObIuTis2ZKcNXgzRwaL0m/P+jlsocxyAV87Q/ZV5m+1ZSaJIR4s
         yGGux1DgYQ2n9q6+F9JQY3q8SZVb1gyOvTqLnKS5NPXK3bE6LGsjb0d0+WVFKR+mPTNk
         DaKdFD1x88XTeIjR4JUP/Uc09r5rySZI1ErBNjLPWU72GYgO/8YwnZGVE43m/cOKYkrS
         ISJtPmeZOLqJQq2unVgrXC9cuFj9Rht4UTtEoof2CHTAhFRS/aAC/p3Whh6B/P+1K+ji
         r+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952038; x=1734556838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mA8UqtPkSm6GQfXzmIjEK9H6u29hiGHFb3M2KsrojFY=;
        b=KbMh+p6b85ZXSzj0+FoV9d3YyxvQF0xJITLWTrgcfkifqXovtA46SwKJpxLFs4h05P
         ZxEm6zOxggnud8tFcIS6Zm55qSpdvAec8JziDj8o9EevA9j+xOhXgU+FlCqNhP0X7ZJB
         mZNBpKi16CC+ygG151pDORieImlylQ5qZv2zK0d3PocSerXHF1bZiBa9yZi2/EaBudYP
         TLiMrtTAXFlnfwsmZukCXpPv6VpgeYrY6lxCTJB3Bp8LPyVQsHd6VQBo8HIvkiJmYem+
         EQXfHCB3Ow7z6ycC5LBGd37bJ8h2Gv17PGXe/9T9GEFkTmwtxP3CfOCCI7U6qY16oj0C
         FADA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0Nm88HhvVmeOg2gjwjDkcT9AnO5NF/KFufpglPuBUUKM6pUZmVxejrnfr33ARXoe4LHjHeZ2Eh8yb48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCJ9tvnErwr6rW5XgkUiyJv/gRFfLfrnBNxEpF4OODqQ1YVtn
	RLSLLaNxgaWWMTJFkypr1dzxiJxsM/aYkiM5tQxTCRt/fSEP3gnFULQOJYRzhv0oOL42t0EBIhL
	AOQNqOtuEvKbJwCSb5yY9SQ==
X-Google-Smtp-Source: AGHT+IHN1brNhEqwbjgxRfUmN4rKMrV4z/3BVdYGbVJagf+4pWYCGKpL+e4/y4yE3uGb17nnzh1gc+fCR05mYSThTA==
X-Received: from pjbli8.prod.google.com ([2002:a17:90b:48c8:b0:2ee:2761:b67a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3802:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-2f12803559bmr6406562a91.27.1733952037733;
 Wed, 11 Dec 2024 13:20:37 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:29 +0000
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-3-almasrymina@google.com>
Subject: [PATCH net-next v4 2/5] net: page_pool: create page_pool_alloc_netmem
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.

This enables drivers that want currently use page_pool_alloc to
transition to netmem by converting the call sites to
page_pool_alloc_netmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/page_pool/helpers.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 26caa2c20912..95af7f0b029e 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -115,22 +115,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
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
@@ -141,7 +141,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
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
2.47.0.338.g60cca15819-goog


