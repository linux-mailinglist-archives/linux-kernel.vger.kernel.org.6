Return-Path: <linux-kernel+bounces-387668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D99B545A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5887E2849B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64561208985;
	Tue, 29 Oct 2024 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwmrTMjN"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A58207A3A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234749; cv=none; b=YXCDoYpFkpReUQEENA9p08dGKMWhjMotZplNukbYRxVmj2PGPypY5uKvjEps3yHZ2IJdepIdT8fxeuzWjCq3SMFGUhJRvE3z4PSprxPifEwWQIN2m0kLkCHqdObYKwb4iQj9584qz5Ym6QxCUvylRpW6+mbXiNo/V+Pl6ZLexJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234749; c=relaxed/simple;
	bh=MPpJ9MAgQTGKiMca+3TwxgtGAu4G2CP87nP4yq+P6DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/2zUfkDVh9f13NZ4SUvIxVBXa1Veg62lpy9oNd5saQoZTSvkPhx0+68hdloD7q+D51RNSFA1Mla/rWXq9U2hHCINXVNj18N978nMg0541K5TQ+9sno87vRZPyZvlQCqAp7ZtYT6G5nAotR7UC4naPn/neoWF1fD3Zo0J2iYU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwmrTMjN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e4ece7221so164670b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234747; x=1730839547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTE4xQCVjMyxxqMXxr+7N7iCNqUizi/3PQsJgMgvBFA=;
        b=uwmrTMjNaulWeowjmXoqbIQeGWDxIZURi7bkf/6NcU6bVtEtFcrBfNGU1meC3mZ6Q0
         lnKD67kyx5YJ7z4+1NeUiWeJO0rlJ+9Dms4kOt+U+X8f0TWQFO1aBAQJl1BWLiaPUQw9
         nFX+F7penX6XBVgCsHMy3SlRKdEEzF427IamLnEwI6+K9cwc/mJDrn5QPeZ2FCqwPd3A
         olCmSFgYWkLfYiNPKUdAjw3FONez6AnPIAWDP0TusUjCjzwtgJGNe+m5Zn+9BshEJtwA
         8U4Kz5FP2f0mPJFcLf4wb9Vt9WVKXygZpjqmGTWrrVbJGBlQu5gDKS1ATCEdUmtC7q+H
         UlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234747; x=1730839547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTE4xQCVjMyxxqMXxr+7N7iCNqUizi/3PQsJgMgvBFA=;
        b=Sl6g4ZAhy3VZRGJjgccDxAa3cyxwBccZTH9MlqsxU61BFVXl4ocDXqJwf0yJIkrIkD
         vv99HbI0ePewS+3l8vmf81xVPBHPf9gsNwbseoEEmRyHLAe0yU9xYlN1JfUb0kSwe6/K
         C3GhvCLKfo757ZsWBC6+URKiaFvrMX+f7j6pIfosaSzb5ee1hpbMh5MKYHoEhbkoX6AL
         VUGoiTwOxFd0rKNuzKcBEgZIw/JZ4UamYlPZyCGGrgzlrYJsoMJ+FS6ZQAy1gKHWsVjZ
         bTM9iziSYoMyiYdMMNqtpoUVRn9iJes03SgGGvX2uQUShJF0wFxVtpUJFXzkMBXcOQfR
         cWAA==
X-Forwarded-Encrypted: i=1; AJvYcCVXZcIiV/AWzme26qsL1y9Fg+uYvD1x1q1hG6SZ29moR7Y5t6NBfzCZD2p5edfU81fM8j03K7uyIRXqylE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7roEP1rW+v2BiglrxnxEaBiZzcuZC1wUuVUAZaBy7wkSlHAeO
	TIPspldQmrx+3M+oYcTHxcRGw27rEJ/uCqL/a4x98tfcO7f2AmjK5wnF8Diz3y4rKBD1YNhvcWm
	21eocaCCbLhQfwP7fBkvRKA==
X-Google-Smtp-Source: AGHT+IEKGxoSoddutyhUFaULkcAEtXglgd09/xsyxMRpkID6DUSV4Uo0pLLV1QBH/hysppFRWIE1Nt7vkyQ/XtJbAQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6a00:2e97:b0:71e:6a72:e9d with
 SMTP id d2e1a72fcca58-72096badedfmr36603b3a.3.1730234747151; Tue, 29 Oct 2024
 13:45:47 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:36 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/7] net: page_pool: create page_pool_alloc_netmem
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
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
2.47.0.163.g1226f6d8fa-goog


