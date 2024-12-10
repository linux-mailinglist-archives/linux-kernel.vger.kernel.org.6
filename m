Return-Path: <linux-kernel+bounces-439349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A587F9EADFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D388E1888F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1D81DC9A1;
	Tue, 10 Dec 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWFYD97q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23E23DE9F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826601; cv=none; b=OVwO0/JrXkBOgBVvYuSM/zGGQmDzsI9E8fR3Iyda42SaLAwLs9kkSYun2jzVBiyKqCG7digpIF20tKyFTThPtJDCiFYeu/IIXr3mZYjpeg6J78whJ73Y8tKSNBBIewc9fEn0zSOA4kMyTwIweABKfU7hHL6PkwuTzIHGiMDGSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826601; c=relaxed/simple;
	bh=hUl0WP/BepZL5Ux5glvPwXrvZRtO/oD70ZVHfvd0RyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifBTHDWxdDihw/3SyCY7Dij6Nukhz0/iW+Otxp7R200cymV0BtM2QX3LZaBYaHLiXqSOLXWD9Y6EYfTCHKZVpGuF8lW6zCuidqemNYFvvkY+LNMKQ15b7chGiCbaACSFW0rKRet/MVEnrsDnE0hDzLTfiha0K2UWYHblfukQ5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWFYD97q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733826598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3GsygM6Nzd7DnPDhoBfVyscs8VOyb9HhJPZeXahbT28=;
	b=KWFYD97qQjlo3rfmRWdFKYTW5uegHBU7ir7nBWelue1jQHBUUBgkegoT6p09vmhn5Ij61W
	Ddn3GpGo9FmnpADCtT4L7nuz3NzIeLr+APeSoERBWJWBaOBr6rfLbDcz/kK4Na99UHgXXs
	eTfIeHrMez1N0e9mMZvk80U9n624WyY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Nmftug0JMd-KihruuhJESA-1; Tue, 10 Dec 2024 05:29:56 -0500
X-MC-Unique: Nmftug0JMd-KihruuhJESA-1
X-Mimecast-MFC-AGG-ID: Nmftug0JMd-KihruuhJESA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e3cbf308so1213815f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826596; x=1734431396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GsygM6Nzd7DnPDhoBfVyscs8VOyb9HhJPZeXahbT28=;
        b=A8osVjuFJJyVQM3VJQpTAON3Ss9sJNGU0xbP6A2TmRtzIMMujUQMQfThI1ENfyIY+1
         Cy9N5iQ/h04pRuS3fBgHjD1hGRtI5tFs1nf9VqkIJCB9YI5xeLpG/zFRGF++8u9og1eT
         isXe3Pc7SXYevzbJfO9TKIlMqq0nWIDgK2AniPk3Cj/NLnDpWC7PmnON+0ddAIiIO+wT
         HLxT+fUkzaHHZ2kf2kt6ZL+Kbiwn+8oku7PaH76UBjgntWR+7iEZR75TlzpFd2NkXPiS
         yuuWDr9d/A6g/L8GRK+IuliAvyy15gdJYx6hjarCD1f7eL2nHqpNu/CaBiqVf9OGKFwY
         EWhg==
X-Gm-Message-State: AOJu0YxyCau5Yi07JTrI4r1ZKAEdluLeysZMZxdF85nON8ILR6PRIGc6
	PxrMGfoayz26Hm2BqZrk+rO+PtUpI2u+YIeDRryQyCeJafK/LQ/a0rzqIAn4BKdzuXYJqXuUiNa
	4nUmkvIk4z3QBt0v/jiESd5A8JUEiGiniRNJucP5VEIKwQbY4Wwo0566y+Y8Qusan57f73ul92X
	i/fb4VMPlqLqTS3oM2oB+o68hPDFHjJ/LP/rZRaOCePQ==
X-Gm-Gg: ASbGncta9NtdJwvNUn/kIj/yLZMaY8t3jsW6bQQ0sUxvVsoKnS5qeniIpQqADxufD4K
	gkoxGDfsN41tQCEGc4ZCa2DuuXYtorMXn5doo7zWmt2i4IC054w/jmuQ9fDIbsA98jQwUH+j0gs
	BcF9s+OJ8v8F0+B8Mxv2t++yWL3kV3VGZo8Yu0DbphjYo+Bl+G+OGU7t4RTV1nmxVvKuTYiWvX9
	dWhnCJhQd8hpOQO2LR0xxtoDhGldQmcV7NsQJyFlGT4MjNl58n6Droq0IY+8rZTSFkTt0BSV1OI
	8sl5xxDUiwZQWn6GFl1NuYKynpoG/nCup10L6JE=
X-Received: by 2002:a05:6000:2ad:b0:382:4f9e:711f with SMTP id ffacd0b85a97d-386453d2a9cmr3015024f8f.6.1733826595758;
        Tue, 10 Dec 2024 02:29:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO3hLzX4uTUzOuyS45haTJxJ0zQ18nIw0l6fv8TvmCXKSia2JBwA5Dq7BQ92qLywW0aXOf2g==
X-Received: by 2002:a05:6000:2ad:b0:382:4f9e:711f with SMTP id ffacd0b85a97d-386453d2a9cmr3014999f8f.6.1733826595383;
        Tue, 10 Dec 2024 02:29:55 -0800 (PST)
Received: from localhost (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3861ecf42desm15209824f8f.15.2024.12.10.02.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:29:54 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 0/2] mm/page_alloc: rework conditional splitting >= pageblock_order pages when freeing
Date: Tue, 10 Dec 2024 11:29:51 +0100
Message-ID: <20241210102953.218122-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now based on [1].

Looking into recent alloc_contig_range(__GFP_COMP) support, I realized that
we now unconditionally split up high-order pages on the page freeing path
to free in pageblock granularity, just to immediately let the buddy merge
them again in the common case.

Let's optimize for the common case (all pageblock migratetypes match), and
enable it only in configs where this is strictly required. Further, add
some comments that explain why this special casing is required at all.

Alongside, a fix for a stale comment in page isolation code.

Tested with runtime allocation of gigantic pages and virtio-mem.

v1 -> v2:
* "mm/page_alloc: conditionally split > pageblock_order pages in
   free_one_page() and move_freepages_block_isolate()"
 -> Similarly avoid pfn_to_page() on something that might not be a valid pfn
 -> Add a comment regarding using "zone->nr_isolate_pageblock" in the
    future to the patch description

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>

[1] https://lkml.kernel.org/r/20241210093437.174413-1-david@redhat.com

David Hildenbrand (2):
  mm/page_alloc: conditionally split > pageblock_order pages in
    free_one_page() and move_freepages_block_isolate()
  mm/page_isolation: fixup isolate_single_pageblock() comment regarding
    splitting free pages

 mm/page_alloc.c     | 73 ++++++++++++++++++++++++++++++++++++---------
 mm/page_isolation.c |  9 +++---
 2 files changed, 63 insertions(+), 19 deletions(-)

-- 
2.47.1


