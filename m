Return-Path: <linux-kernel+bounces-318586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF90D96F02B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E061F2988B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0D158DC3;
	Fri,  6 Sep 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRuHtWdt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073013E898
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616256; cv=none; b=oXr68p3LggR8xBtIpTK+Wx4yCXy7hBbhk7JvOKZobrQr/Jg7Mrb2+MCmQCSCLftethipwd4rPYyNipUB9GeJJL6hqdpkFGw1GbC+WRoJrJTQF3ZCzKxKSZ6MNp01dahr+dQQADr3/1hQA0TZ6YgKIcOHccDg5l7iTowT4KuzdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616256; c=relaxed/simple;
	bh=oevenWFone9FrFN9bEMB8X8dI2TtFwVy9l/2uWIl5a8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YigOyIiPnYrZnYKYAU+HuGGxxdQFnXFZp5wnWY6Xx9qRspH2mI5suK2b/qiqya9zUaQxSrXP0tfIWZER5t+64oyEw5FsvfGYhxhQXJk90p0NHtOdhYwmmvJvdQI9BJ4BHrzu5TkRAFburCteHP78eO2JIC5x/fVOAgA2pBdcQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRuHtWdt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5356ab89665so2312755e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725616253; x=1726221053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TYk2P8rsrGGMkeOuqXW3lZdK3gNZRYY0x1m32EPi4=;
        b=MRuHtWdtSQrfAnxOKvepdMze4H5O4f8BsFVq3kbofsWKmGc4p31pH1+NxI+eDfkuxl
         ZtYFdxs6Ud6+wVaTiBu9kCgRbH6IzxeM52kvROU0neQ24nK8zJMz/ZB7GZ5biJVGQUr/
         VG8SWe1axcZQlgwKkWljVhXtdlV/qVLufAKdrQRH0zq96eoWjasgQhKI7AM1iOhHrYMp
         +3caiK4XSUG1tPUT+Y/PKGdelmIwPbHs7nrU106VsvyifWvar81Vj/bAdn5SnhE7Hanc
         pjlI+pOZi7CxG3nRPQ45mh4akg7INKoIEdTLqdfaFoR+OL2cc4TvQTYzusWUfbtDD5dn
         WtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616253; x=1726221053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4TYk2P8rsrGGMkeOuqXW3lZdK3gNZRYY0x1m32EPi4=;
        b=BrKZoZDWyVlULLn75xv9BI/rGLbGRRX8t22Poajarh8dVDpcEQ5iv3/k8J4Rygwzg7
         7PG7w+zC+hWjia1x8Eq5jA2fhM0s6IsfL81gCuKkylWOzm+FDat9tqKjZyDa5jGy5Jy9
         EpqXABlbgJ8go/PAh2jJGGUvzyQGQgm0CRHeq1CkaUsUh4igLT6OObaGRkjqwDelPZuo
         HELoB6dt1JD8wkXpNJybJFITbQBo/QEiouE3wnDzf6CEmUOV2k+x96C5k5T6P1zArTpw
         7MgLhvMv36g8213nma3LiWt/jwA2+5rqsRhRv8P9cs090yBcuAL44C6nTsWyrYK2Wd4N
         q3CA==
X-Gm-Message-State: AOJu0YxOLYWnScwSbj7VbklOpHCjFY8sPDztlYRw+X9w3oonyltr08F9
	rRCgVhsM1j/rjjBocGh1v5Wh5YKrMKiDyHGU5M4lDdpa8JAJ8QHdoOwDqw==
X-Google-Smtp-Source: AGHT+IH4xgnJzuB+XNt+jzT483aoD47ewEooA1HsXBJo4l0GdOSXNStDt7eSLXB9clNpK1YrY0NVWw==
X-Received: by 2002:a05:6512:3b0d:b0:530:e1ee:d95 with SMTP id 2adb3069b0e04-536587aa5c7mr1439310e87.1.1725616252386;
        Fri, 06 Sep 2024 02:50:52 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536571b89e3sm180503e87.53.2024.09.06.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:50:51 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH] mm/vmalloc.c: Use "high-order" in description non 0-order pages
Date: Fri,  6 Sep 2024 11:50:49 +0200
Message-Id: <20240906095049.3486-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many places, in the comments, we use both "higher-order" and
"high-order" to describe the non 0-order pages. That is confusing,
because a "higher-order" statement does not reflect what it is
compared with.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 37b6e987234e..c7bd8740b8a2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3590,7 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			break;
 
 		/*
-		 * Higher order allocations must be able to be treated as
+		 * High-order allocations must be able to be treated as
 		 * independent small pages by callers (as they can with
 		 * small-page vmallocs). Some drivers do their own refcounting
 		 * on vmalloc_to_page() pages, some use page->mapping,
@@ -3653,7 +3653,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	page_order = vm_area_page_order(area);
 
 	/*
-	 * Higher order nofail allocations are really expensive and
+	 * High-order nofail allocations are really expensive and
 	 * potentially dangerous (pre-mature OOM, disruptive reclaim
 	 * and compaction etc.
 	 *
-- 
2.39.2


