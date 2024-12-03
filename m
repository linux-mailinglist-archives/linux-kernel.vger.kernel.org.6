Return-Path: <linux-kernel+bounces-429175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD99E18F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5AAB3640D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD91DFE04;
	Tue,  3 Dec 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mlr7Botx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71335364AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219261; cv=none; b=YLPW39eWEoZl5VWDqUGZg60vy2pnykegXacoyV3OkBlg+/b+ju0Yfmgv0Ymj496PpPfm4syJyvZWKUJUX7yJ0Hl3cM6ue/lhdwmm7JD6O4zdr5g3fzXngGl5KdbzMKtaY9ElD/PsIcWGsu17qkS1lc6hfrpWX4r6X0ky9bYb/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219261; c=relaxed/simple;
	bh=xxTmA2My3aUIlDxdvSLyLpX0VQVGaT+oxPNrtsorq+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hv2m61jnnZYVyhaUYMVMzDbXHCmNrzykdw8RIbHafu4k8d44cjOFRXgYpowrAPUqP+zZ0it4/9c9MbSenemtH68JMiULMHy5f+Dt5TkhrLCIZZR0cJFKVTLfsBon/7s6ihK9NMNh9DIaME7fH5AmVqlTB+y0sRmlf5xUt5THNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mlr7Botx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I+WpaV6OWdi5kvpk6n/53fQFkDnKmQdF+vIgGPak5jU=;
	b=Mlr7BotxU5mRWkfHbCSE3rF/t6WpDRsFuHUoi8UcvmaeDsQkxn5X0vmBbjFFujuuAgqJwl
	85J/1rHlrxtPBdB7bDif8ppsao8ayy30NXPrloUg526h8OsQfumxs8da4m9TQewQavTY80
	ZV46xEYhKi1pK8LkvB3eg6B1Hnk8jnU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-8mvls8SXNOGjhi8fw5Y4tA-1; Tue, 03 Dec 2024 04:47:37 -0500
X-MC-Unique: 8mvls8SXNOGjhi8fw5Y4tA-1
X-Mimecast-MFC-AGG-ID: 8mvls8SXNOGjhi8fw5Y4tA
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ffcaf83611so31242881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219255; x=1733824055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+WpaV6OWdi5kvpk6n/53fQFkDnKmQdF+vIgGPak5jU=;
        b=Meu49cbQBCN93tb9lHp3nK21spTpH4V+aQ+nulG24RyFqHIVnLv4OUUx0y21/hrpM9
         r7grMA3b7w4wmYp42bP/EBBeHBxnFhPjPeZQN35Wx+G/PbivoYfycPa3pJEYkYWFPZUE
         b+evr4yPVw516kk8JeVdUpTp5P5XQqKU4EhV4Wjtfjd5nr4WV1F3kEbDDCfnlim22Cgc
         HGb7BwOE+UmHoy40kJ7p80GazCyTKX0h4MP14mwZFPg6449Q5LAVHGOqnQsWc7aOWrIf
         8BdLemfBg7OcT2CysOPwqVXiTlQrszGLUADvAVupqRyF987EXuzUpRQhMreCOBoAcpLI
         0Gag==
X-Gm-Message-State: AOJu0YwAane+ZeY+jJN8oozf26SentdqhO2pAGzlSHzZN1D4rfnHRxPU
	dpsLWTDRXIBLEoCBlJU72vPTAQDhOexwWvu/7NxaF+BUK2nsFyHW8MKzxX3qUuO8I8/Y7uhmyf/
	eLkVZOSMQ9dOj0ZqSqcQqts9/LLXrHBgYy6h3MhIc/yKVmWu/3Tdvb4eZi5uIRSswln+5CyXRP4
	Y3VFnPrkFhOSB3qm7RsMheX+E4SMmnYE3KppQ/zw/6U26P
X-Gm-Gg: ASbGncsY8+9w5DQE9urN8wIwj8s5RPkTZlIzFWu7+DHK3FZQmLU/MmUDc6E04KVLMhl
	a2PXdCxGTezy8/Ujnd0NataguU7/FqPuxVrvQUpWeKFvSvVsI/H+hyKGMXIMA8+CnCV2s8+H7kb
	uvqqI27Hy4NX3plF+6az/cZolq1tYCoCcVCYthx97SrvPzHuuO8z2jfqySI71cJhHNqPsh60o9i
	kA6TuSNmt9fZFvXnaS51G3YT9B9d/nm8IMevdCuozjyb3jDAQOQN2dMpLETf0SkkGOHhJa5C296
	gzmoPBkLXn9UtEr34UnZNOva35Sqaaoo+iA=
X-Received: by 2002:a05:6512:3f1f:b0:53d:eefc:2b48 with SMTP id 2adb3069b0e04-53e12a01888mr1168023e87.33.1733219255638;
        Tue, 03 Dec 2024 01:47:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7ix1vCCH64WEfdTl8JuJR8R5JVe6DQ6ETyTqieE4HgQ8WDhb2jympdCPhJGy/Jq9uyRGFBg==
X-Received: by 2002:a05:6512:3f1f:b0:53d:eefc:2b48 with SMTP id 2adb3069b0e04-53e12a01888mr1168001e87.33.1733219255133;
        Tue, 03 Dec 2024 01:47:35 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434b0f7dccasm182037325e9.43.2024.12.03.01.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:34 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH RESEND v2 0/6] mm/page_alloc: gfp flags cleanups for alloc_contig_*()
Date: Tue,  3 Dec 2024 10:47:26 +0100
Message-ID: <20241203094732.200195-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason v1 didn't make it to linux-mm; same with v2. Let's try
a different SMTP server (gmail), maybe there are some issues with the
RH one ...

Let's clean up the gfp flags handling, and support __GFP_ZERO, such that we
can finally remove the TODO in memtrace code.

I did some alloc_contig_*() testing with virtio-mem and hugetlb; I did not
test powernv/memtrace -- I cross-compiled it, though.

v1 -> v2:
* "mm/page_alloc: forward the gfp flags from alloc_contig_range() to
   post_alloc_hook()"
 -> Fixup patch description

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>

David Hildenbrand (6):
  mm/page_isolation: don't pass gfp flags to isolate_single_pageblock()
  mm/page_isolation: don't pass gfp flags to start_isolate_page_range()
  mm/page_alloc: make __alloc_contig_migrate_range() static
  mm/page_alloc: sort out the alloc_contig_range() gfp flags mess
  mm/page_alloc: forward the gfp flags from alloc_contig_range() to
    post_alloc_hook()
  powernv/memtrace: use __GFP_ZERO with alloc_contig_pages()

 arch/powerpc/platforms/powernv/memtrace.c | 31 +++---------
 include/linux/page-isolation.h            |  2 +-
 mm/internal.h                             |  4 --
 mm/memory_hotplug.c                       |  3 +-
 mm/page_alloc.c                           | 62 +++++++++++++++++++----
 mm/page_isolation.c                       | 12 ++---
 6 files changed, 63 insertions(+), 51 deletions(-)


base-commit: 679694cdccaf75df589c2737f233954669a5f601
-- 
2.47.1


