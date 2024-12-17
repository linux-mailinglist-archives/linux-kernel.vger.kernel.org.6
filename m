Return-Path: <linux-kernel+bounces-449885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9189F5760
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010B516EB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207001F9415;
	Tue, 17 Dec 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ng7MEfjH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BF1D9A63
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466331; cv=none; b=sw9SR4yd/fDsk4rh1SWYViqQ+43G+sZgqdjR1t/hWdN7VYqbyRyMYObL8Ia+u81pUeZkdwZm8jnhPI/ANhXFf5Oy7Yki9nlAdWYr8iQ2HVcN5N2jTe8Q+jA7IS8GACB3JtVR5jyErYgmR3rI8PeY7IhRPUbBfTrIxATfqQAKwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466331; c=relaxed/simple;
	bh=pVImGNEmG/zX77a+vhzi+si5GDL8xTOF4zHCM6KYXyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nUAb3VOC6Hij2l7zh0ObX6CGDmTbx1C5R011hpQHMHijR5M9S3yufaSZfB4nlNfapbh+GeMJKpF7sZ/EuWTTvBkeHHCgJFO6Md7V+Z6SbMeqx/IZanoYQx1ZWkTfmsF6p5aTZh8sfuhGKsP91p/K8fFeQwIeia6X/TEFz+Y6eYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ng7MEfjH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso5394616a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734466328; x=1735071128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7CI+KsjLDAbysY8RsQOlNWjMrZ9ZlwbSEe2N6sprvE=;
        b=ng7MEfjH0oSBi72ygWvouldAuy8iUY0x6KB5iS0dZi25HgOfR2vO2HaONKYkjl6cy3
         6C8dcZpxvDY5wJe4+HZyNSGEvKlDsDo+RZUsbOnRF8psusFKP68vn90TAE/cnNkVCCgj
         G6Nc0B9p/2kHRNMdlbxHM1OT+OLYq/U1hXxxQNxhKrVh/0lY/1ZUIYpswvONDQ+xC1aV
         NVoXZGr8g7HWEWNk6kbt0bGxAxerwgfWQ3U2POJh+Bs+YYm0wclldvMv45p2QVGrIAc/
         jEjKWNrYMTk1x6mcpPiB3JAbcnxidFRZUPkncdJbaJTiA2XD4x087A7mX3rTtwNizINp
         LjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734466328; x=1735071128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7CI+KsjLDAbysY8RsQOlNWjMrZ9ZlwbSEe2N6sprvE=;
        b=Nq+SPae5KqOsfRGKwQL4OLNNW36nkG+ZzoWM9Gj4BpTZvpaIAKE3GqS+ADktUVc7p+
         92gVo9bbGLOSuVMX1kKzJoM0PjmsJUggIsylBKruRJHi53DaZ58oHwBDlZhDchmi9N58
         V0pQChz5mf+TaJWi51HpmksTPbpHHbPNq/ecoVz87tGgnmfMBEDVeRMP6VdxGUZNuCRQ
         H532yXKN1WrFK2mOWYNTIBI09Du9rcItJLTVF0RXOTc3xsOrk474eBQAYp7kMXIW7twT
         avRUrt6h8D+DPn5hIa7+b59qWrWm5jCGCBsFVbxtApOkrNQhFbLTd6LdWTNjXg/vmXVV
         kcUg==
X-Forwarded-Encrypted: i=1; AJvYcCV+CnTcLlDrK0HFj9UE0d+zA00xvnZJCU+5gAl2HuYD9sKOVqRxK20oDK4H9kklH/3QfU/pyrGOk3qQZqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6nGyaReoVLSSAYqGfuVXWQilFrQQMf0YPF1DzMD7oM3UXkX6
	yjsvHSK5eVDlGaDqgwIMpNyOdhlu9w5okc4BZQWzYXUfUqElJR9TU3AKVdZAxOKfreVePgLpc+N
	vJoQhpOdcJeHbGqCaV/jcdQ==
X-Google-Smtp-Source: AGHT+IFsiV1/4XtIWEL3oEqqXsvoAtV5761RQFgsgkc/U1ZC9rkOBZSzJ+H2Zb6WjBufhYhAwO1A6CIR7ORB52npuQ==
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:2ea:5469:76c2])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51c4:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f2e91a9815mr307291a91.6.1734466327882;
 Tue, 17 Dec 2024 12:12:07 -0800 (PST)
Date: Tue, 17 Dec 2024 20:12:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217201206.2360389-1-almasrymina@google.com>
Subject: [PATCH net-next v5] net: Document netmem driver support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

Document expectations from drivers looking to add support for device
memory tcp or other netmem based features.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v5 (forked from the merged series):
- Describe benefits of netmem (Shannon).
- Specify that netmem is for payload pages (Jakub).
- Clarify what  recycling the driver can do (Jakub).
- Clarify why the driver needs to use DMA_SYNC and DMA_MAP pp flags
  (Shannon).

v4:
- Address comments from Randy.
- Change docs to netmem focus (Jakub).
- Address comments from Jakub.

---
 Documentation/networking/index.rst  |  1 +
 Documentation/networking/netmem.rst | 79 +++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/networking/netmem.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 46c178e564b3..058193ed2eeb 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -86,6 +86,7 @@ Contents:
    netdevices
    netfilter-sysctl
    netif-msg
+   netmem
    nexthop-group-resilient
    nf_conntrack-sysctl
    nf_flowtable
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
new file mode 100644
index 000000000000..7de21ddb5412
--- /dev/null
+++ b/Documentation/networking/netmem.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Netmem Support for Network Drivers
+==================================
+
+This document outlines the requirements for network drivers to support netmem,
+an abstract memory type that enables features like device memory TCP. By
+supporting netmem, drivers can work with various underlying memory types
+with little to no modification.
+
+Benefits of Netmem :
+
+* Flexibility: Netmem can be backed by different memory types (e.g., struct
+  page, DMA-buf), allowing drivers to support various use cases such as device
+  memory TCP.
+* Future-proof: Drivers with netmem support are ready for upcoming
+  features that rely on it.
+* Simplified Development: Drivers interact with a consistent API,
+  regardless of the underlying memory implementation.
+
+Driver Requirements
+===================
+
+1. The driver must support page_pool.
+
+2. The driver must support the tcp-data-split ethtool option.
+
+3. The driver must use the page_pool netmem APIs for payload memory. The netmem
+   APIs currently 1-to-1 correspond with page APIs. Conversion to netmem should
+   be achievable by switching the page APIs to netmem APIs and tracking memory
+   via netmem_refs in the driver rather than struct page * :
+
+   - page_pool_alloc -> page_pool_alloc_netmem
+   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
+   - page_pool_put_page -> page_pool_put_netmem
+
+   Not all page APIs have netmem equivalents at the moment. If your driver
+   relies on a missing netmem API, feel free to add and propose to netdev@, or
+   reach out to the maintainers and/or almasrymina@google.com for help adding
+   the netmem API.
+
+4. The driver must use the following PP_FLAGS:
+
+   - PP_FLAG_DMA_MAP: netmem is not dma-mappable by the driver. The driver
+     must delegate the dma mapping to the page_pool, which knows when
+     dma-mapping is (or is not) appropriate.
+   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
+     by the driver. The driver must delegate the dma syncing to the page_pool,
+     which knows when dma-syncing is (or is not) appropriate.
+   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
+     tcp-data-split is enabled.
+
+5. The driver must not assume the netmem is readable and/or backed by pages.
+   The netmem returned by the page_pool may be unreadable, in which case
+   netmem_address() will return NULL. The driver must correctly handle
+   unreadable netmem, i.e. don't attempt to handle its contents when
+   netmem_address() is NULL.
+
+   Ideally, drivers should not have to check the underlying netmem type via
+   helpers like netmem_is_net_iov() or convert the netmem to any of its
+   underlying types via netmem_to_page() or netmem_to_net_iov(). In most cases,
+   netmem or page_pool helpers that abstract this complexity are provided
+   (and more can be added).
+
+6. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
+   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
+   CPU will be done by the page_pool, for others (particularly dmabuf memory
+   provider), dma syncing for CPU is the responsibility of the userspace using
+   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
+   the page_pool which will do it correctly.
+
+7. Avoid implementing driver-specific recycling on top of the page_pool. Drivers
+   cannot hold onto a struct page to do their own recycling as the netmem may
+   not be backed by a struct page. However, you may hold onto a page_pool
+   reference with page_pool_fragment_netmem() or page_pool_ref_netmem() for
+   that purpose, but be mindful that some netmem types might have longer
+   circulation times, such as when userspace holds a reference in zerocopy
+   scenarios.
-- 
2.47.1.613.gc27f4b7a9f-goog


