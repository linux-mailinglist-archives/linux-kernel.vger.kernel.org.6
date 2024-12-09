Return-Path: <linux-kernel+bounces-438465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BA9EA1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F46816637A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF8519DF4F;
	Mon,  9 Dec 2024 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgAOcLQA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3B19D89B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782233; cv=none; b=DFOL5LEtGXEKum7ln5p5ZTZDxEFTwB4Kic44LrSMrytHHSxYXK0t9ccxDKAmbl3kpQnbi2aAeFaF4s7zYnYHQ4VDMQzLTgRm7COFpWl9QWhYvwdschIWJnnBKAcruuL821/PXl4w2f5g/+5qLES3qU8fm79UsDGxQByj0cTtHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782233; c=relaxed/simple;
	bh=xdhQRO7iG5g9QwFMiLtS3VOf3NDOq1Xd5r/XukgCc4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uLzXFIA6+fppsznCI6cZNxy28k0+aSWLVxdEryzsu+wO7ig7CsgqkIgsJm86jxkznRlI4zxCGDpN6c9SMBRD7bmBEgmu5V44ePWcpxSJ35RpiDvkTYvHcyCQsTmYn9PEg+wDPD6D+M6DKdLtSS6gr23SJUTV/881U6LEbhQKyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgAOcLQA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd48914d9bso1229536a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733782231; x=1734387031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5kJ8tuGRSUiMYssDTJ1ovChFT1489Ldfej8iSXdE6s=;
        b=VgAOcLQAtEFDdzKiss4o1QcuVSW0Ci4H2L81LBl5MdEXuYQeSAoA/9rQOKU+ZguQjV
         Tg/HX3n/RGVSqK+yLsdXWfB/3jfDo46c4aogbyp9TJ70OQn6n+e8vRKtwfn2DDYenx1y
         bD4kSYKVDFI9hOTTpLocdPO3E+o5wwew9yHmCHBYeX5v4MuJRvXTwDe4oWkXZg1fAlew
         ROEYTG4PKBmaJIE0fFzbj36Xjox33ML/iMHZsXekIwRH42wyu5Cr+FBqASPemDZ2wELI
         jcTgbU95z0+SQhwlEmbivR9CqIJiuLYtqufXsKQuZ1jeRHzlhPXVnsCTMaG9hgKeMR+d
         cCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733782231; x=1734387031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5kJ8tuGRSUiMYssDTJ1ovChFT1489Ldfej8iSXdE6s=;
        b=bImByx/uHvbpfi7whCKS5H4hm1uSnU7REfKpJr07HUDBj8V+m49+OfpvBsqaEbyO40
         n53+Ye4b0j9DGZK3dY+GWAhPpyn4KXQmHKuXg1oUN1v49JBzXeGW1FrTnP0Z2AWGWZ1h
         bhM7vRTML8nZYApdMtXVFL5kHZgyhsz4HREpamJWnyYFyNe8lk1g/Yi0d8wrJLFmlr3H
         oL9YDmPtSPnRs7gg9AMoeC2csCGaHa4oslxHrvSGgeD66e8aY+yq+5zkCA/8P3RPPDCW
         Yitelu/lkkjCQlNeWRXM8BEoPIYQzbpFBfSXp8p6NzYW3X6YnGnxM9U7oX24OD/b2Xqw
         Xa0w==
X-Forwarded-Encrypted: i=1; AJvYcCVdLkc8LVdGvvWAdjQklRsP+Io3c/dGKQ13FQWVo0iaL47UI+fCPLqUszmZxctz6hxT3uEHuhsy/wJeQpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gjPfdV6dYNvadXkE/cbF0D5YSMLhQgFvoAzDHUWrLt91ANmr
	Ryyp/bFdj4hQqxuWCowAddNFUpQfce+TtalBSfkHbj1FIm4VOzsUGkCmRkZY8SJjq1AgRJEGFa2
	xEg==
X-Google-Smtp-Source: AGHT+IGwA+SRdoKoKP199xBaNffbhc4gaYBx7LHg0PekrQ7mrUUner/oH79OTzpbo5FJCxTnEDqYj4PiT/s=
X-Received: from pgbda5.prod.google.com ([2002:a05:6a02:2385:b0:7fd:57ef:61e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918b:b0:1e0:d837:c929
 with SMTP id adf61e73a8af0-1e1870a8012mr22865787637.9.1733782231311; Mon, 09
 Dec 2024 14:10:31 -0800 (PST)
Date: Mon,  9 Dec 2024 14:10:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209221028.1644210-1-surenb@google.com>
Subject: [PATCH 1/1] mm: fix vma_copy for !CONFIG_PER_VMA_LOCK
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: oliver.sang@intel.com, klarasmodin@gmail.com, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_copy() function for !CONFIG_PER_VMA_LOCK configuration copies all
fields using memcpy() as opposed to CONFIG_PER_VMA_LOCK version which
copies only required fields. anon_vma_chain field should not be copied
and new vma should instead initialize it to an empty list. Fix this
by initializing anon_vma_chain inside vma_copy() function. The version
of vma_copy() for CONFIG_PER_VMA_LOCK is fine since it does not change
that field and anon_vma_chain of any new vma is already initialized and
empty.

Fixes: 85ad413389ae ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.com
Reported-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/all/d0ae7609-aca4-4497-9188-bb09e96e7768@gmail.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies over mm-unstable

 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index fec32aa06135..d532f893e977 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -524,6 +524,7 @@ static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *de
 	 * will be reinitialized.
 	 */
 	data_race(memcpy(dest, src, sizeof(*dest)));
+	INIT_LIST_HEAD(&dest->anon_vma_chain);
 }
 
 #endif /* CONFIG_PER_VMA_LOCK */

base-commit: 6e165f54437931f329d09dca6c19d99af08a36e1
-- 
2.47.0.338.g60cca15819-goog


