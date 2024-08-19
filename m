Return-Path: <linux-kernel+bounces-291399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C89561E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C152D1C21425
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7E1581F9;
	Mon, 19 Aug 2024 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB/qdbf5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0314A09C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039705; cv=none; b=BtaWyn2wTZQ69FKhKUsDfvwm22d3ic+ryB23v5TxAFelQaoDE3usQx7bur/yWXNOKP7a8LCqsEVJSMovy11XmVw6ahrFi9OBlkF0exiG9CjeKP8+TS0wOZ7cNBR0TQOdov7JS47o/Z4zl8LFvwXnFE187/KDGVenGbq7jVY+8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039705; c=relaxed/simple;
	bh=KwO45KqZd3TIhgCMntDmXTBc/ls6/ytjjlj+mvPmjhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RmqU6qxiSE44fabjae5BmUB5T9F2+YCJUpmV+VhyayML0POqSGOtX1RbsMgrVeV3EXtggJYUC9WSBIYjwIURYSGAEp+qe1SbAhR+M7xc2PULQ6EhRpktYz7/LzOZJdweciWiM2OtKpIj78Cq+f2ZcacK9mev/S0vm4dHE0bfAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kB/qdbf5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e11796af1d0so4212169276.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724039698; x=1724644498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo0cwDcH2XdL72jwowPP5DRqM80W+FJfKPsKZaD7qTk=;
        b=kB/qdbf5Y3wIT5jAFx64fFkNKq/dIbTIeoXQzjW0wT/Ap0eYoH71/M/Za1sl+N/pId
         GPJ93zjXGBCnbKQSM/Rkbqy5WnSk3kI6PRYTbDy12aD3npUkl0J5gI7naRxw1K/Mb2Gw
         /mtrPQOsLNZ+IfOBAaM4IXfH0ZuSreeurxBMC/5IFroGew5FABLtutwu9IXgBTHjvT7o
         pLdEekx07siYAlSQOeJnZn+9e0Bji38CktDL8Gei7fw78vkEZYH+8bg+Oo1FJr4EaYlu
         ujCxAWDcVHJ162wB6RyEDm06sbS84t+2uzGmdJR/jPSo99NiClNObYnPdMBYgq1B5im3
         MLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039698; x=1724644498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo0cwDcH2XdL72jwowPP5DRqM80W+FJfKPsKZaD7qTk=;
        b=dx/e9hxO6IQ5O5suHNplbmxvvuzDaZNLKEWm87Hbldc2POQdRU0iOiBw+N999ZxUvl
         zf/49esUhTMY82FaP2rYxaykgF+UxiYf7SOBQyQn0Hmchhm6RiX+LosHJxPRCR8mz3sv
         4IX9CjSgIhdaLdkpDWk5y/QjOaQcPbMwntVIEq+5g9e3LTH82mfczypkdN+ArRC2TcDc
         fAsPPjQ9DObufjckSuGkHv6NBUzmCML+JOHGIXGPP9nuRKf5l8onqS7f6/165rA5ZbGR
         aX5GH57LQBWG+sqLOrklw2YvM9P8VKbP2zeXScOXmLBlBtr3YkxgX/wrqcDXrv9Qmg8S
         wMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcpQs9nMmCcD9zxZul3xO+r0x61smi9wJG++uhW9x4ZP5EST9Dz84MVBIyGGCpRobTYVUVW44KXK5nmz1Y2aHxTvaoYoLQz9dPMRX0
X-Gm-Message-State: AOJu0Yyw65DQg6VboKY4mXL5BrgcVj/3g2hXN1eaH9uHe1kGxeSdiCJi
	ait8ih77WDrJ9py5IxdAjstmSvA7/fOegzawcyVSAgFRJMVRumWhs2ZcAka+hQP8ZCRs5Zo/hhn
	t+euehGX6cWCLmxcOePfiWA==
X-Google-Smtp-Source: AGHT+IGmr9yxY0yuW7dSCL0cdDg1UGR/aZSNn2kgjWeeWCZpXBirfO1kJPAcLTyUK/CeC4h835Zv1Jo9aVRKw1dL5Q==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:8007:0:b0:e11:5be8:323c with SMTP
 id 3f1490d57ef6-e1180f8abdbmr74381276.10.1724039697567; Sun, 18 Aug 2024
 20:54:57 -0700 (PDT)
Date: Mon, 19 Aug 2024 03:54:39 +0000
In-Reply-To: <20240819035448.2473195-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819035448.2473195-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819035448.2473195-5-almasrymina@google.com>
Subject: [PATCH net-next v20 04/13] netdev: netdevice devmem allocator
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates net_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a net_iov
struct.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---

v20:
- Removed dma_addr field in dmabuf_genpool_chunk_owner not used in this
  patch (moved to later patch where it's used).

v19:
- Don't reset dma_addr on allocation/free (Jakub)

v17:
- Don't acquire a binding ref for every allocation (Jakub).

v11:
- Fix extraneous inline directive (Paolo)

v8:
- Rename netdev_dmabuf_binding -> net_devmem_dmabuf_binding to avoid
  patch-by-patch build error.
- Move niov->pp_magic/pp/pp_ref_counter usage to later patch to avoid
  patch-by-patch build error.

v7:
- netdev_ -> net_devmem_* naming (Yunsheng).

v6:
- Add comment on net_iov_dma_addr to explain why we don't use
  niov->dma_addr (Pavel)
- Refactor new functions into net/core/devmem.c (Pavel)

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h | 13 +++++++++++++
 include/net/netmem.h | 17 +++++++++++++++++
 net/core/devmem.c    | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index c7bd6a0a6b9e..2e7cc46d4d3c 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -69,7 +69,20 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding);
 void dev_dmabuf_uninstall(struct net_device *dev);
+struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_free_dmabuf(struct net_iov *ppiov);
 #else
+static inline struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
+{
+}
+
 static inline void
 __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 41e96c2f94b5..0fbc0999091a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -16,6 +16,23 @@ struct net_iov {
 	struct dmabuf_genpool_chunk_owner *owner;
 };
 
+static inline struct dmabuf_genpool_chunk_owner *
+net_iov_owner(const struct net_iov *niov)
+{
+	return niov->owner;
+}
+
+static inline unsigned int net_iov_idx(const struct net_iov *niov)
+{
+	return niov - net_iov_owner(niov)->niovs;
+}
+
+static inline struct net_devmem_dmabuf_binding *
+net_iov_binding(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding;
+}
+
 /* netmem */
 
 /**
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1b693424c17d..88d188149148 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -35,6 +35,14 @@ static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 	kfree(owner);
 }
 
+static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
 	size_t size, avail;
@@ -57,6 +65,36 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	kfree(binding);
 }
 
+struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
+	struct net_iov *niov;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	niov = &owner->niovs[index];
+
+	return niov;
+}
+
+void net_devmem_free_dmabuf(struct net_iov *niov)
+{
+	struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
+	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
+
+	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+}
+
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 	struct netdev_rx_queue *rxq;
-- 
2.46.0.184.g6999bdac58-goog


