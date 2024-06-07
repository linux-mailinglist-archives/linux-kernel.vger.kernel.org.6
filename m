Return-Path: <linux-kernel+bounces-205611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CADB8FFE23
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6DD1C23A50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8B15B127;
	Fri,  7 Jun 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eS2FJ2Iq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983715443A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749443; cv=none; b=ES5KyRdh8aiJ1WMdv4zPqlNiTpCP92ehItrBcfdVTQFNH/M7KCq7cnsdrJCDriiLOshUW/G+bLWLxS4XL8xVRYAmqCiIb++NRzljOR/AreGxhMg5/ALanl8TxJ8s2+8c5YKi1yDpP5U5vSVrqg1lgzdc+b9k9Oo/gRkhSgVgtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749443; c=relaxed/simple;
	bh=g2rcMWyp8GlzCipqNrvSLZZa077Ie31QTsgAwJF3cZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmUAPZrIMQe/dvWXwIJg3WQzKduinpdNYKG7F5Pzmf3e6KzCjWBJJMJkxrhazBY1d+ROR0fdoZVsTlU4idVLOr6ETWPejo5huiWzxIehaooQezHsmQfacNeZe4FD3evqnEmiVh1AHO4PspXM8wdnRf5MOHgZ3zB2ROIO0H/JN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eS2FJ2Iq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717749441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M8ah2Ds86Vnl2swvOWW1huIAKIJrzy4AOAoWffTTPH0=;
	b=eS2FJ2IqPlEm4YzQupjdA768wDome0eCCuNw4YnUEgVLD2oKC2l87XjW+JX7T6utKHDyPE
	8RnCKCgrQuZGTg7uDhrKAMxhCunP/7pFooZo0MMfodyfPJptnWgHl+Reexjkzf0lDsH0Q8
	V973JHleg11HYWFTOIyDB49xovcFe1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-wAHZVWDZNJy7X6xJAQaCKA-1; Fri,
 07 Jun 2024 04:37:17 -0400
X-MC-Unique: wAHZVWDZNJy7X6xJAQaCKA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D12D1935DE8;
	Fri,  7 Jun 2024 08:37:16 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A84A21956048;
	Fri,  7 Jun 2024 08:37:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/2] mm/highmem: don't track highmem pages manually
Date: Fri,  7 Jun 2024 10:37:09 +0200
Message-ID: <20240607083711.62833-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Let's remove highmem special-casing from adjust_managed_page_count(),
to result in less confusion why memblock manually adjusts
totalram_pages, and __free_pages_core() only adjusts the zone's
managed pages -- what about the highmem pages that
adjust_managed_page_count() updates?

Now, we only maintain totalram_pages and a zone's managed pages
independent of highmem support. We can derive the number of highmem pages
simply by looking at the relevant zone's managed pages. I don't think
there is any particular fast path that needs a maximum-efficient
totalhigh_pages() implementation.

Note that highmem memory is currently initialized using
free_highmem_page()->free_reserved_page(), not __free_pages_core(). In the
future we might want to also use __free_pages_core() to initialize
highmem memory, to make that less special, and consider moving
totalram_pages updates into __free_pages_core() [1], so we can just use
adjust_managed_page_count() in there as well.

Booting a simple kernel in QEMU reveals no highmem accounting change:

Before:
  Memory: 3095448K/3145208K available (14802K kernel code, 2073K rwdata,
  5000K rodata, 740K init, 556K bss, 49760K reserved, 0K cma-reserved,
  2244488K highmem)

After:
  Memory: 3095276K/3145208K available (14802K kernel code, 2073K rwdata,
  5000K rodata, 740K init, 556K bss, 49932K reserved, 0K cma-reserved,
  2244488K highmem)

[1] https://lkml.kernel.org/r/20240601133402.2675-1-richard.weiyang@gmail.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>

David Hildenbrand (2):
  mm/highmem: reimplement totalhigh_pages() by walking zones
  mm/highmem: make nr_free_highpages() return "unsigned long"

 include/linux/highmem-internal.h | 17 ++++++-----------
 include/linux/highmem.h          |  2 +-
 mm/highmem.c                     | 20 +++++++++++++++-----
 mm/page_alloc.c                  |  4 ----
 4 files changed, 22 insertions(+), 21 deletions(-)


base-commit: 19b8422c5bd56fb5e7085995801c6543a98bda1f
-- 
2.45.1


