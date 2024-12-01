Return-Path: <linux-kernel+bounces-426736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF79DF720
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FDD16275B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B01D88DB;
	Sun,  1 Dec 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKlZhLdT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE82AF12
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088171; cv=none; b=WCLBkSLEcW9wjYxI8McXDDh5pfIDoNesHnxKXvYTNP0OPV8wEE1SD/pGCFNWK/nboMBTMHnHxJMpoXfXp7BqAvifjrm0eF6Ru48cneCEiQh8Y/SlyJX8HpFzoC7+8l7vlWNAqbGKWVurYyxI1CWhKZfEbsgDj9DsX9wnNS4K2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088171; c=relaxed/simple;
	bh=omDPZcuaOfSvu9O8fV5+PoxX2S41Q4jJlLuSAJ+08Go=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eqanRi3hMKydoW13TYTOgtG4td0dYnmqs8QsJdOx3e2JATKMPKJG1kk+arRdUPUFcJYJU5wPmwIHQlE0yFi1QrP0nBhDdbKTQb8pghfM24HJYMCAJBfA1RmSOqC3GSL97+9cuRTpKWEhmengCt9EpKDMx3adWdfR1vjTyNrUV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKlZhLdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YM8DkKfRb8IpPKMV3s7yyQAleOKBXGqJpJ7QJnlSE3c=;
	b=WKlZhLdThoKWgKo4/UW2QJFdepxSOBNpMb8oDvG/+Y3PKrJZnlvwLW2c0r38zz6urZ7/cq
	UMvke4aozpm+wDT5Spkhv7D2iYxpOazPwd0rtABgCfnlNYhOCQlIouJPDgo978rMKaINwq
	jCL/Z+vWflHTZYY9rNZMymusTSgUiqc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-_HeJaRUrP7ywKE53p4FTQg-1; Sun, 01 Dec 2024 16:22:46 -0500
X-MC-Unique: _HeJaRUrP7ywKE53p4FTQg-1
X-Mimecast-MFC-AGG-ID: _HeJaRUrP7ywKE53p4FTQg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46689320badso71108261cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088165; x=1733692965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YM8DkKfRb8IpPKMV3s7yyQAleOKBXGqJpJ7QJnlSE3c=;
        b=mbFywYlHONG4bkTQUMREC75KsJnl7KgHpckkl1HJuSt/5n5/EKxYiOlQ/BuW97BftY
         hG13BoXQdhWRDzwr5yG0WITKhf/RmwecW9HOsx3ym/QoDoovkUO7gQMZr3yOSY1VPOV3
         ayHlON7Omy1ZicCB4m/nJydujpL5fcPJ/Wdji4xKEtQuYwf6GmbY9peO1X7gP/kbHUde
         ZABZTgHnZccerjkeGBc8AN56Yrd8zZ8NKontt4wH6GuEZOx4aRQYVYtK7iEm6XtuumAO
         6BZMGelUzpvbas9PwsjNcjLza0uFy49cRehc6mYREpxVprWn8TxA6rvdQ4dNisRgO4fx
         ha3A==
X-Gm-Message-State: AOJu0YzdXNWrKx01bJPeQbsyuq2F3h9RvfHFmJw4WIcu7ujJjZnrVWmn
	+32aBUHMBY3TXHU/dzPLPpbT/n+vMZHXIuxVRCNbnkyUYqnGzXJiWOByro6UQGhLVUaw8MXkcx1
	M0WpjZnifZ1zFC8GGI9mM3hL+bWCQ8IN8fPL/hwF9t1WRr3pu6Dkh0qH2qDYn3uN2h4is19Y+L0
	oVAZAg1DN6Ks34lZmDqkr/LGMTvMJwAfnz5gz6afjGDPE=
X-Gm-Gg: ASbGncs/ZK4f4NXvSDG6KQ6Zrn4IgretkNtovrriTsQTZH8NQf6zLZ34ypsWPHHxyaf
	k+XrAHifMvUKXdxe2NSFSvtUCjRsaBnUFuvaCIc6/aM6cCPl4H0JPIMLSjGaspuMKDZpPPlec6V
	9XZA9SQf5CYR/nUlqW/N58hq6p06YosFmodZNJVfNhuMAvvVrefEXhi/MX9D0DNfW8NwyyNg95T
	ivk1Onhgnow55rhHSgCzzr48xn2n7ImrHauAH4EbxSSZgcnSBuJYzY+HOKTB9eIx8DdRNNcKl6D
	zWc9eDTVBl9eDXGmpB4JopUmuw==
X-Received: by 2002:a05:622a:5817:b0:461:3834:b632 with SMTP id d75a77b69052e-466b34d2ed9mr269144551cf.1.1733088165121;
        Sun, 01 Dec 2024 13:22:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYMfFUKKqY8ldvyra2Aod+R5tafce9p1vcixhiu004Ft5YinVMtwa9M1qGrL758c7rfXnD3A==
X-Received: by 2002:a05:622a:5817:b0:461:3834:b632 with SMTP id d75a77b69052e-466b34d2ed9mr269144211cf.1.1733088164736;
        Sun, 01 Dec 2024 13:22:44 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:43 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Rik van Riel <riel@surriel.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 0/7] mm/hugetlb: Refactor hugetlb allocation resv accounting
Date: Sun,  1 Dec 2024 16:22:33 -0500
Message-ID: <20241201212240.533824-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[based on akpm/mm-unstable, latest 8351c1503010, of Dec 1st 2024]

This is a follow up on Ackerley's series here as replacement:

https://lore.kernel.org/r/cover.1728684491.git.ackerleytng@google.com

Ackerley, I wanted to reuse some of your patches, but when looking at this
issue I found a bug which is described in patch 1. I'll need to have that
patch to be the 1st patch of the series, and then I also found this is so
far the best way to layout this whole set.  It should have gone a bit
further than what you tried to do in your series, but I assume many of your
gmem 1G patches after that will still apply on top.

The goal of this series is to cleanup hugetlb resv accounting, especially
during folio allocation.  It paves way for other users to allocate hugetlb
folios out of either system reservations, or subpools (instead of
hugetlbfs, as a file system).  So for the longer term, maybe there's chance
to use hugetlb to be separate concept v.s. hugetlbfs, which I hope would
work.

Going back to this small (not so much..) refactoring series.  It touches
the (probably.. hard to read for most) hugetlb resv code, try to make it
more readable, decouple things so that it might be easier in the future to
allocate the folios without hugetlb VMAs.

Tests I've done:

- I had a reproducer in patch 1 for the bug I found, this will start to
  work after patch 1 or the whole set applied.

- Hugetlb regression tests (on x86_64 2MBs), includes:

  - All vmtests on hugetlbfs

  - libhugetlbfs test suite

Note that I found libhugetlbfs test suites can fail on some of the tests,
but it doesn't look like to be caused by this series, as I can get the same
results when I run the test suites on either akpm/mm-stable or v6.12 tag.
I didn't yet have time to look into all the issues, but the current guess
is those issues are separate from this series.

Comments welcomed, thanks.

Peter Xu (7):
  mm/hugetlb: Fix avoid_reserve to allow taking folio from subpool
  mm/hugetlb: Stop using avoid_reserve flag in fork()
  mm/hugetlb: Rename avoid_reserve to cow_from_owner
  mm/hugetlb: Clean up map/global resv accounting when allocate
  mm/hugetlb: Simplify vma_has_reserves()
  mm/hugetlb: Drop vma_has_reserves()
  mm/hugetlb: Unify restore reserve accounting for new allocations

 fs/hugetlbfs/inode.c    |   2 +-
 include/linux/hugetlb.h |   4 +-
 mm/hugetlb.c            | 243 ++++++++++++++++++----------------------
 3 files changed, 110 insertions(+), 139 deletions(-)

-- 
2.47.0


