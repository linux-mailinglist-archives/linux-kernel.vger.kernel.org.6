Return-Path: <linux-kernel+bounces-387670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A62D9B5464
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5531F246B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D8209F2E;
	Tue, 29 Oct 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1I7f4CdV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4F209683
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234755; cv=none; b=VlxwViDa3EUGvEb6azwPxEOa5yQoNxx2aKO+NOnAeIQSsMlEL5FwVG29jdCNQ89BTrg+bZqSvRUzhGOSc+QtNZ+llEdrpa4sNyc7wVKmvHRWNOPBoEmvUn9R9oaJkDWcA+o5JQcq/ftDDR/XWK6lQg0kFKQgRIt8fITLqKPdUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234755; c=relaxed/simple;
	bh=6eTzR/9ZOnj5CYN8SmYXPKii2L+YcvUeqGgZJmywDDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hW2EdCLYw6pkzgbZPw6fVs4nRsrjq3DTVhPo4/PLXowIuSOEhBL9hMyQ1Yr620fWcoih395AiN3RqTE0Pn27j51TBXgwueJ9jhnILgwEbogMGGcs2OMLS9vL4ucg37kjKpp6BUbpsuNrJ0Nv3AgT26pPMJrA8SINmoaQ3eIldRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1I7f4CdV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30c7a7ca60so1242629276.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234751; x=1730839551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWvEuGXnU27PXRSp7zy0hKeJv9z9WHLclRxJOt6bNk=;
        b=1I7f4CdV+m1hJl4NXy/waR41WzCM3pE/+/Sw9/c6OsYSCH0YSTjAwX+FaxxLvjwr2u
         YoX9Mjt7+iPjFCM3UV7U2HeMJdAPwmL0X/s/fNRv4mZgqRrGY9LuqoYPJuMrZf15rFla
         bzRz9+1CjG6aTiF9UVLfLEKKO+DVnIVbTka5j4CpG0Tp2nU/gEa8Ut049ZNr/OHBin8g
         iLZ9j3VebD1YA9Znp80O8+oTM1XaEYP9TnWzNVasFkeSzinV5mOe2gq95CI7ewaAVgCq
         n+H0cJy/8IoVOEcLZhVENJ77THhDZD1eVVwqEcrcMNcuKhcYAhzh+wUFtLGkNdxd8t7Z
         rTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234751; x=1730839551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWvEuGXnU27PXRSp7zy0hKeJv9z9WHLclRxJOt6bNk=;
        b=BgnC7odLF2EAyAu8cHplJb89B5zJNlhI53mONXsjMmeEfEUzoy3B8Iu5lW01DN+bif
         rAvSVx/+YIsCqwVtwx0PYE3FRWjO0sxZCzleH/nAy4PXrN2Qm+8TmAzBApbfcKSB/oU3
         3nlX/kGVosNXIyS6RCFD3YEiLRHsaOo1ChMc0O0K/aTZ94NYKr+WuWZsirO2JyXwAn7U
         1RFMyQtwTvdVFynspiPnLbDHIWpsfxD0M9P+SaNsqilYrHxNb2bE3cFvqTlRsQSA9/yT
         36zaoiApXJH9V/b54iwMM4GXkRB7lZ/YRQHv6YQdJ6Y7tahF3oDBngO4hoYdfzn7n8ho
         3r8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGrmb2BDhPULxvGMc82+NOaPi9uz3NV/fJmT+OLv8HdTo64DoyMRelyunMJRb3ipOTmpJMNAUUge1Vdmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOhkWvrDKeW9KZTt6c39HXUNwTWPqER0qNZSgFDmpi0H8hKnO
	PUTyh53k5pk2CjYnWgPtXLmY9pu3NesoPn4VRAiKlWfdajL17wP/2J6ErmZ/HVjcsmdcT4mtvhN
	GiGvZ1jiuFnrqYGmjWMs2Yg==
X-Google-Smtp-Source: AGHT+IH9DOKv8lVSkF/qC/v3j6pptyY01q0mblnOxpf7Wr+4mvSOn1+/x8RXmICWDZSdFxzfx8BIVffTqN0qBKCV1A==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a5b:bcd:0:b0:e29:b6d7:20e2 with SMTP
 id 3f1490d57ef6-e3087736bf6mr83545276.0.1730234750854; Tue, 29 Oct 2024
 13:45:50 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:38 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-5-almasrymina@google.com>
Subject: [PATCH net-next v1 4/7] page_pool: disable sync for cpu for dmabuf
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
its the driver responsibility to dma_sync for CPU, but the driver should
not dma_sync for CPU if the netmem is actually coming from a dmabuf
memory provider.

The page_pool already exposes a helper for dma_sync_for_cpu:
page_pool_dma_sync_for_cpu. Upgrade this existing helper to handle
netmem, and have it skip dma_sync if the memory is from a dmabuf memory
provider. Drivers should migrate to using this helper when adding
support for netmem.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/net/page_pool/helpers.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 8e548ff3044c..ad4fed4a791c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -429,9 +429,10 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 }
 
 /**
- * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
+ * page_pool_dma_sync_netmem_for_cpu - sync Rx page for CPU after it's written
+ *				       by HW
  * @pool: &page_pool the @page belongs to
- * @page: page to sync
+ * @netmem: netmem to sync
  * @offset: offset from page start to "hard" start if using PP frags
  * @dma_sync_size: size of the data written to the page
  *
@@ -440,16 +441,28 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
  * Note that this version performs DMA sync unconditionally, even if the
  * associated PP doesn't perform sync-for-device.
  */
-static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
-					      const struct page *page,
-					      u32 offset, u32 dma_sync_size)
+static inline void
+page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
+				  const netmem_ref netmem, u32 offset,
+				  u32 dma_sync_size)
 {
+	if (pool->mp_priv)
+		return;
+
 	dma_sync_single_range_for_cpu(pool->p.dev,
-				      page_pool_get_dma_addr(page),
+				      page_pool_get_dma_addr_netmem(netmem),
 				      offset + pool->p.offset, dma_sync_size,
 				      page_pool_get_dma_dir(pool));
 }
 
+static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+					      struct page *page, u32 offset,
+					      u32 dma_sync_size)
+{
+	page_pool_dma_sync_netmem_for_cpu(pool, page_to_netmem(page), offset,
+					  dma_sync_size);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
-- 
2.47.0.163.g1226f6d8fa-goog


