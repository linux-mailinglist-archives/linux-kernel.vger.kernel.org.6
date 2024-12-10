Return-Path: <linux-kernel+bounces-439351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA309EADFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D9B1888EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941F32080FB;
	Tue, 10 Dec 2024 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNYV/SgE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FA2080E2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826607; cv=none; b=RRy7UwfbW+1TAkWGWFJv8olj1vmwKvAYaLeX7pjY8oMipKT3N6Enoq7Pz35XbFwBlUjz5lr58aKTARTjPpCJHXSn8otO00PIYOlA/ls6F8unLOqP6QsD6+IFXR9+Sz1bAdE2feXazwxPhCLskhOxrTkXS2VgmrCW3NerAarb/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826607; c=relaxed/simple;
	bh=sxVKAE2qs3debSq7EGIER7WT9zza0c6m7ew3pssESnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1e8bgfvV+L6fXzfnf+4xvUvLQrp6fRB0kVOk8ai5sElwI4FpoS2OOv5XCpjkgepVvtLPXYa69xhrI8QjDqfd7ffEzX2EYUIEJ6+AqUTFFCLqLOVETLt9tgT23NY2LpK0F1/0jOg2ug67D9JS5mXiT36QoSZdiqsl9reAoM9cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNYV/SgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733826604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsHcUHs6DeYsnWvoRaSergLRElq6OgEvwA7Y98GHY8g=;
	b=TNYV/SgE2dDcwZtlV8a46N7m6Xl2LTE+A6S71IIswWGr3k7Q9m8qVIV6/NxFKowsqbCuSj
	oj7M7ITVTaSmiVrICbf7XnjWMD/xXQdQIhpVciJH1RnN/Hfm8R2uY90+yHThaleX4jtDIa
	Si/XvSjUQjUiDMnVaO4go1rpkBv5l38=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-z4JMB250PD2rndefRip5iw-1; Tue, 10 Dec 2024 05:30:00 -0500
X-MC-Unique: z4JMB250PD2rndefRip5iw-1
X-Mimecast-MFC-AGG-ID: z4JMB250PD2rndefRip5iw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434c214c05aso42978655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826599; x=1734431399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsHcUHs6DeYsnWvoRaSergLRElq6OgEvwA7Y98GHY8g=;
        b=cjNfE89RzCSjSYywf05pQLtgnthq4sUyot9wtzfRblQp+kgzWMQbWTUnB7ypU0x8+8
         YvS6tfNzTDWqlj9XuyL3sMie3lvQXpMYe3FtIKQe7WFoRmjXsDy5F9+Pe+xehuUW/llg
         0uvx2jHhL0cWdRs2etNenRhjcwPeEaIERZ8hiPRktAreRUA131YGl6XdSkfgj4Ln3g4B
         iS+POW9Zya15Pxv4GqyV/F6OWa90mM1B2rvmYPmdbHbsd7Pm2R1KhRT3TM9qV909G4uR
         f6CsXjVY4C4Mi+xQCcsbplMQSwBajbd5p629R1OtXF5o8wRbv7+6QDxx2FKnQKCfe0Us
         k6FA==
X-Gm-Message-State: AOJu0Yz/g4fHlpL6ZoSlXXee2yZ9fMIiu12pknOcxdHYRJ7GLwocZvRE
	rBxORrkwVMysAdyCI5zffD/y19p/nBFAuIDouIBYYnBu3NinQfHeWQrCZFr5Bs6rBCxdps16L3j
	GSv1//6ywZi3vMqWYXXlbMLJJrpPnXVxGPGAwnelSKGWmyjkas5kBBfMEy/Oj1ovKjOH58zjiws
	Zstu+RxnTgBIFi3IzyjmGNGyxXZlDIFsd3qTy6U9CqAQ==
X-Gm-Gg: ASbGncsujP6BtoPM+riHUDL2brg9Jcm7fRNtEMGe0I6Ogvi8eM8k1cOBS6C09ARr1MQ
	1LGb6raxwWwSfV37DHxiQ2efS796Y6TFhCZ8pIug1C2iVc6ewsVV329WkYspY2rycrZn8H7dDnz
	Pxvso6g0a7q9PmvXng+8M+CpYJ0TM/B7UFp7E7vojTury0+xyPEg/LomfLSIg2yLSQW7EFaK+of
	1jSxwFUFXdHA699nBSFXIkCoVyeFUkhkjDDIgpUI+YA9eiKRm37UmY8b6zoo4p8N43AvnuMADCH
	mHAa347lhMiyzUPqxPwSgI5osS/WdMQeZfu1FaY=
X-Received: by 2002:a5d:6484:0:b0:385:fd31:ca34 with SMTP id ffacd0b85a97d-3862b3e3e43mr10725005f8f.54.1733826599299;
        Tue, 10 Dec 2024 02:29:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWTNmulgBHuseiTodhsuNrK6Atvf8UYrxinaniVZlvd9jCVyLu5KM2kLzhq5jpm0t11e/Ovw==
X-Received: by 2002:a5d:6484:0:b0:385:fd31:ca34 with SMTP id ffacd0b85a97d-3862b3e3e43mr10724981f8f.54.1733826598916;
        Tue, 10 Dec 2024 02:29:58 -0800 (PST)
Received: from localhost (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-386220b071dsm15302098f8f.101.2024.12.10.02.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:29:58 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 2/2] mm/page_isolation: fixup isolate_single_pageblock() comment regarding splitting free pages
Date: Tue, 10 Dec 2024 11:29:53 +0100
Message-ID: <20241210102953.218122-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210102953.218122-1-david@redhat.com>
References: <20241210102953.218122-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's fixup the comment, documenting how free_one_page_maybe_split()
comes into play.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c608e9d728655..63fddf283e681 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -298,11 +298,10 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pagelbocks.
  * [      MAX_PAGE_ORDER         ]
  * [  pageblock0  |  pageblock1  ]
- * When either pageblock is isolated, if it is a free page, the page is not
- * split into separate migratetype lists, which is supposed to; if it is an
- * in-use page and freed later, __free_one_page() does not split the free page
- * either. The function handles this by splitting the free page or migrating
- * the in-use page then splitting the free page.
+ * When either pageblock is isolated, if it is an in-use page and freed later,
+ * __free_one_page_maybe_split() will split the free page if required. If the
+ * page is already free, this function handles this by splitting the free page
+ * through move_freepages_block_isolate()->__free_one_page_maybe_split().
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		bool isolate_before, bool skip_isolation, int migratetype)
-- 
2.47.1


