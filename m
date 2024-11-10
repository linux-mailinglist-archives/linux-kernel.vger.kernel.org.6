Return-Path: <linux-kernel+bounces-403375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20FB9C34B9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F421B1C20F86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8A155743;
	Sun, 10 Nov 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvrPK/KQ"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECED13B5B3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731273087; cv=none; b=Z9rkVtKjBymM3+fHfftK/cHkiXcBulIZw6cXKK+uBfAlFyJ8fQIP+UoMHbKAOb78J9R8M2XaqUhpvPbi+t8AMyI2N/tR/8EbYx23auIhRLnJzNsN9L6p9tFZkvJ0GH8/JD3qj7JMAQPmc0efiY8x0zbe717zsVemT5bek0zdCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731273087; c=relaxed/simple;
	bh=6UwvPEOCr9hcboEYF4WfwJu4qonjGE2rQ5sHZtR7UNQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YHnurFvl+lJJiIyUcDVrtZ+TsHDQ8hSwt3pW+4lEySEvL5XC7NV6TZ8qEhdL0hByvyHSmS38UhquNulX8Y/cdhT/6jJj3VsJ244er10LnI2w3vd12aMxhTG6It+s+EMYZzBCKJYnuHeH0dIf064bDNel0KEtxefN0UErXrPDKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvrPK/KQ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260e6298635so1889069fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731273085; x=1731877885; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wm7lqc6cjJtGfdaDUhdk/4pQrGz/TeIdmCREqGvtLL4=;
        b=qvrPK/KQH/ayknkkc8Hb/wiRq+m4DeBJ/OsDhI5LsC+CX7aWB+M04Egu3NkPcHCjsb
         RYRoWcIqBu9WOGxv1CYrtc/PHe6XWlnu/rspm/Pqh0PkIFTVE0pFMGKXoOIQ4amLeizQ
         hP/iZVYFzIxpvyTl/9GDIlqlFqIyh0ORTKrBj2wnQQ7efu2ef0x7WWhgxgKog1IMgs+1
         fdhQTBVPIncjezspO+ktRwLhzLohY2GPPP4MG9VIinCaTk9jCyCuOzk+F7ZdVXTzXKZS
         7EwWzx+6hOx9GL8TWFOeWLFXdqmXrNpVm+JcwSuRcSGtT17osErGkPwxFceTfsKqpn9n
         +vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731273085; x=1731877885;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm7lqc6cjJtGfdaDUhdk/4pQrGz/TeIdmCREqGvtLL4=;
        b=XoHLQR9Cz6AAEz6WypB2viDFYUJ2CjhrJE8y5JLaGGQwsEOn86OYmAzmmMqUWpzq9d
         MVCd6yMxVM1+n5Hfg7IjYztn8kiEW+5NeCOOjCNWj/umhFrokJ2OS/IfZsyEJPS/daZP
         BLtm7Sw+rm5iBBw9EeI/vD1U4mxGXvFW2McjBF/0dZ02OyH05Koiwfj0g21xB86rbfbA
         u8WCWOpUHuqlg63mYM9LfrlSpHpvqtz7OppxTgH7kEZH4I9ywrcpxQT+CrABhoRzr1qy
         G3x3prbGTSdbt+XjcTxcE7777OYxB6Os56JhisxokltoLrOTcvbxWTfBXk2O24zpUCiY
         uWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUke4vXz5956EFYnnx4D472vK/D2gnP+FvugYMSIMqfuAKZLjRDLPkh0h1WYdOf2ZG8ytNz+c6o7Y7uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wZzwx5KvSKXRZ8Aq2fAmC+ER5fxNqk+Fl9WzBxwHNYKQhibJ
	fwD8wwCPJd47YLm7OTQby3KkADqt4cEHkO9+nxNT1/h+o0gc4r25Yzg5gbo3tg==
X-Google-Smtp-Source: AGHT+IF85Gy4fzCNG92ic3IycLYyvuh/85UvmtrWOu0VB2aYEskhi8P2P3+nsuvrZAMyj67x1wyViA==
X-Received: by 2002:a05:6870:d60b:b0:260:ffc8:6d9f with SMTP id 586e51a60fabf-295606ff3b5mr5639440fac.19.1731273085318;
        Sun, 10 Nov 2024 13:11:25 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546edff25sm2414735fac.37.2024.11.10.13.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 13:11:24 -0800 (PST)
Date: Sun, 10 Nov 2024 13:11:21 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Zi Yan <ziy@nvidia.com>, Usama Arif <usamaarif642@gmail.com>, 
    Yang Shi <shy828301@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Chris Li <chrisl@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH hotfix] mm/thp: fix deferred split queue not partially_mapped:
 fix
In-Reply-To: <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
Message-ID: <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com> <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com> <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Though even more elusive than before, list_del corruption has still been
seen on THP's deferred split queue.

The idea in commit e66f3185fa04 was right, but its implementation wrong.
The context omitted an important comment just before the critical test:
"split_folio() removes folio from list on success."  In ignoring that
comment, when a THP split succeeded, the code went on to release the
preceding safe folio, preserving instead an irrelevant (formerly head)
folio: which gives no safety because it's not on the list. Fix the logic.

Fixes: e66f3185fa04 ("mm/thp: fix deferred split queue not partially_mapped")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 03fd4bc39ea1..5734d5d5060f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3790,7 +3790,9 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		 * in the case it was underused, then consider it used and
 		 * don't add it back to split_queue.
 		 */
-		if (!did_split && !folio_test_partially_mapped(folio)) {
+		if (did_split) {
+			; /* folio already removed from list */
+		} else if (!folio_test_partially_mapped(folio)) {
 			list_del_init(&folio->_deferred_list);
 			removed++;
 		} else {
-- 
2.35.3

