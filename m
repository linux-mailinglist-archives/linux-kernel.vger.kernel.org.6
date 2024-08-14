Return-Path: <linux-kernel+bounces-287287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F869525F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A291C21269
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021B14EC42;
	Wed, 14 Aug 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQM28X2f"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BE14D457
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675615; cv=none; b=G9/mj5fIklx6NdVGKtVYqXPmfRfe1dIa14jFmVJa7beonDKzOlwmM+U3xAPZApN5U8zpN0CO7LtGIUDs47i4zcfk2gnFJBsMw8g8VNEkLYkLst97UDHYn2+K5J8SIzrz360mLXsEJBq5aib7cKFuDnISBK/0RhhMlx2p7vO+8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675615; c=relaxed/simple;
	bh=EHzuiQ3O9cLeDrvdRVthsfP7R48it3qG/4yCrwxbArE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0omPBeZNZApgN8QIQZ15lcTa0dDa//1/cItMhLqd3JhKuxp+iuZJY0PhnVeMGDLe0p6bOO1rXuRnWq6t2u5LtFqkgll41pX8pliVC37wYrothH2YSBWeVn6wuakw+hRcecwnk0qyrZliLuoqVMV4BRMdj+yUn05x6vKWdaCosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQM28X2f; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc569440e1so3581755ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723675612; x=1724280412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcqzLYpNsoY+ZnD+WFpV8qX4Fal+QvpIacZtFR5Zuao=;
        b=IQM28X2ffg143Eb7CrEhua1NARhKNdoe8+xGj2QooYyTXuIfKWL/bnvaNBlsHmZXTB
         MnMXYxZodMaOEYXXi11cBJCOh/0orIsB1tKN24j0ESftf75oaNnIWCKCdAgiAG0Nebyv
         jqIxYnISwpGOgUqKJEsvjRXcSSquckUx2OAn8gDT4gGjuMc9RlnYOgK+y+rSdatirY8F
         ajVjvFd4vd7NB4YsTuhv7c4YHFN5WgMD+hw2pFCl0Ac709xi5foKXPuMp3aOfvZHvctS
         oJGl8+rY3MTHyBKph1GDkdSmu70ON1w9PeJOLXNk99iQrRwUhrmnNC8SOtkEqo4VpwFN
         8eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723675612; x=1724280412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcqzLYpNsoY+ZnD+WFpV8qX4Fal+QvpIacZtFR5Zuao=;
        b=bwMoUQ5E+0d8um46NSRclEyfVnu1zfqTM/Cfhn15T0DLfQ46CGJQQEQ9vNpKTrH62k
         ht8RqXhdN1sbEDLcHVOxW8BDvsspbRytFwby9CiMshlU0goBBwfaQMyYtpqurAlFt/9o
         /HZ0//WHkrEzJT9KePPzyihF0/ZIsafkfoBeuH5NesT8CjItPMuh1Yr9oBwpmXVZSrLz
         WdeqMneUw2LovtRW6sa60BESpBC9ZvT5cGpDU40apqMvCMEza/lOPt45cR7R/0cfc0HI
         wSS/cM2SxKnAA9DAJKTVQ3BrgNIwgX+EDmXid9e87pIyP30w7Ijp6LF9HPsGtAcli4M/
         u7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC2c50XoExOhMdkqNE/+l7DIb7yuohAd+sy+4+gcfXqlDM49p1j7fyjvWFpCf3pjAdPrHs8qeo9+XiDPhaSmucyfmfcvLFOnaDxvbf
X-Gm-Message-State: AOJu0YxkX5pgiG7+H7XPpIuCgXmqzbE8NapgtwWpqoQ4RhbchlmwrgFn
	6YmfK7ohOh1w/wgEQ702T2VUztddpFlRET1sQGxf2tJ0mtcsndK+
X-Google-Smtp-Source: AGHT+IFO5UORUfVNhW2Ln/6YPwNByDpJDPmwRa/e8gxfW+B41zZ8po6NKbV3iYE9EAYVIYi/GHRRKw==
X-Received: by 2002:a17:903:1208:b0:1fd:a0b9:2be7 with SMTP id d9443c01a7336-201d638d72fmr50846795ad.13.1723675611940;
        Wed, 14 Aug 2024 15:46:51 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039e06bsm1269505ad.241.2024.08.14.15.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:46:51 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org
Cc: baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Thu, 15 Aug 2024 10:46:35 +1200
Message-Id: <20240814224635.43272-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814020247.67297-1-21cnbao@gmail.com>
References: <20240814020247.67297-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Aug 14, 2024 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
>
> From: Ryan Roberts <ryan.roberts@arm.com>
>
> Add thp_anon= cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
>
> thp_anon=<size>,<size>[KMG]:<value>;<size>-<size>[KMG]:<value>
>
> An example:
>
> thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
>
> See Documentation/admin-guide/mm/transhuge.rst for more details.
>
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---

Hi Andrew,

I saw you have pulled v4. Thanks!

Can you please squash the below changes suggested by Baolin and David?

From af42aa80f45d89798027e44a8711f7737e08b115 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Thu, 15 Aug 2024 10:34:16 +1200
Subject: [PATCH] mm: use get_oder() and check size is is_power_of_2

Using get_order() is more robust according to Baolin.
It is also better to filter illegal size such as 3KB,
16KB according to David.

Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/huge_memory.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 01beda16aece..d6dade8ac5f6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -952,14 +952,17 @@ static inline int get_order_from_str(const char *size_str)
 	int order;
 
 	size = memparse(size_str, &endptr);
-	order = fls(size >> PAGE_SHIFT) - 1;
-	if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
-		pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
-			size_str, order);
-		return -EINVAL;
-	}
+
+	if (!is_power_of_2(size >> PAGE_SHIFT))
+		goto err;
+	order = get_order(size);
+	if ((1 << order) & ~THP_ORDERS_ALL_ANON)
+		goto err;
 
 	return order;
+err:
+	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
+	return -EINVAL;
 }
 
 static char str_dup[PAGE_SIZE] __meminitdata;
-- 
2.34.1

Thanks
Barry


