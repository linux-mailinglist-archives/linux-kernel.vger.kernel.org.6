Return-Path: <linux-kernel+bounces-536595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4FA481AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF77A3D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD5235BE8;
	Thu, 27 Feb 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6WKOeKJ"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146E2356CA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666906; cv=none; b=QrsD9FvXXA6H0QOo4Dov97gePLfC2Cepm5CmnVMlYyo7JEEZ6UvL0PA8XNohQMcKE385IkhMNrIKP00Ex5VkEu4nQP4hWnti+YeduXFEDn56mGo0v0lXSRR8YEu3kGzTpi+CeyESFEJT2q4tDjHieCb/1BwBxxDvn/PEwbm+NHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666906; c=relaxed/simple;
	bh=P7K1u0ixFzS8NeAeR2mMYNXPbZgGX3idgQD2ynQSJIk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l4ozzWQgXa0cVii0yfoWWfI6CJEl4lnPxcblJ2NR18c7mINwrdKzpiRd1ZaV6Vas3tuWG6/HKBc6f4fwHII+juRI9rKd7KCP987WAvJvaYIhdgMwCaTEXOkBJJQ3f6bvOtnfAu/uQyqjz2FaafsCqHul7+a6GCr2ybzmxAqspuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6WKOeKJ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-abbac134a19so146012066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740666903; x=1741271703; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ibqSO3DoiXQkj5z3DA6r5R4G3+A9Zbr0Rhh2VpYSgPI=;
        b=I6WKOeKJ1HuItSPQD7s46z6+PyKBMWLYNgc058K+KB9ysUt6ZHPLy+GWUBj8OvHi6l
         xtc7XEUTiSB7DI407hj+9myq2xyk8fbK7s0oR0L5aqKNR6UO6lXyb+XBba3/EijFJxKg
         b0duRIuqAuSeKMHCS1oS5d6k0bYKt7s/nYMVBQw7bcdx229qmyMgpXl3Zr6J2H4xY4wR
         yrUl+1W0UhFhoq9BeZAoY7gbx02WH6qJ+mfEBj7DfCcJFF0huVr/vddbIjj7l0YVx4UJ
         Y4iEkdXWO5EOPCUL0RwsMcocRNY6wZ98k3/31wXPuJzPqFB/qGbE41t2P4z+gjFTuqpx
         tlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666903; x=1741271703;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibqSO3DoiXQkj5z3DA6r5R4G3+A9Zbr0Rhh2VpYSgPI=;
        b=LQyQIF3AHQ6Rjx9pA+YnRjsuw1CIg/N8UF4mMRMk9A+pb8h51ozA1sKJVQhQ8XLBL5
         69F8g9ujzgzlU3JFUIxpSSazZ8RiJ1/Rlmz7v4c6HiGCGK+TX8n/LBWLUfIay7nPhoe5
         FGeoe44TSsFThq23vP7bopKMDStdXMVTB3f/fY3lh/tDF/HgBU2IRdjH4RvtUHXB+HNL
         jKl5ZDbVWxAhtgcPgodVNBEdjmTM0WWDtyq062OZJOklolFLK2i46BPkXRQSbGDxhS2d
         pX6ojwkjQxX6F9HbEWDA6+C7TSljFKYTtvw0AA8zU33IxCFiShf5MzeY1Kd+RDgHe2/k
         Nk5w==
X-Forwarded-Encrypted: i=1; AJvYcCVUBQeWZg1mfX4UPcvnydpGkjgtWTjWehCWRrGHcT5Bn0fG7M23vE93gy4ufB5Jr8dznfrriT8hvEMFbcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3N3F+Q4gxkeBKSOyC+YBz33jhe1/dMiuoWTDvIAJjrS2dur5
	Oxq4dtPtVgzJtLl/ZM55HaMmVMBP0zWo/4UlMe9xuLeXFzB0RZuHPsW18Jx8S1/wvnINHh9YTiA
	Oxa7E8bpkRqv/ZeFE9Hnzi7teR09CQj1uwnU=
X-Gm-Gg: ASbGncvVhZ415d1eo1Bh77/ydrZqA9kxStiZxaHjnxaXaOPHyQU0rwpAmIevRfzgbkA
	TdWPU2caYHWCZDQ5TA0eL1+IgCbvSh5o5xhdP352C+n2q0k09nFArF5qzo2q3Xg1d6j8qRFF51/
	GWfAx5DcOW
X-Google-Smtp-Source: AGHT+IHI4s1A0CHJ5Z4CV5rWWmbAagFbgom5CnpV8lpEVLqD7ySce7xQtbQxb4hLnJWn/p8cn9cGgdKTUJd5zkRUnts=
X-Received: by 2002:a17:907:7710:b0:abb:9d27:290f with SMTP id
 a640c23a62f3a-abed0c66939mr1295588966b.9.1740666902326; Thu, 27 Feb 2025
 06:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ying chen <yc1082463@gmail.com>
Date: Thu, 27 Feb 2025 22:34:51 +0800
X-Gm-Features: AQ5f1Jqhp8MxfKCvUO5ejp43rCfqNhFZS_PCQafaVCX5mXCKqBeZW-CMLezrUkw
Message-ID: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
Subject: [PATCH] mm/vmscan: when the swappiness is set to 0, memory swapping
 should be prohibited during the global reclaim process
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When we use zram as swap disks, global reclaim may cause the memory in some
cgroups with memory.swappiness set to 0 to be swapped into zram. This memory
won't be swapped back immediately after the free memory increases. Instead,
it will continue to occupy the zram space, which may result in no available
zram space for the cgroups with swapping enabled. Therefore, I think that
when the vm.swappiness is set to 0, global reclaim should also refrain
from memory swapping, just like these cgroups.

Signed-off-by: yc1082463 <yc1082463@gmail.com>
---
 mm/vmscan.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..bdbb0fc03412 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2426,14 +2426,7 @@ static void get_scan_count(struct lruvec
*lruvec, struct scan_control *sc,
                goto out;
        }

-       /*
-        * Global reclaim will swap to prevent OOM even with no
-        * swappiness, but memcg users want to use this knob to
-        * disable swapping for individual groups completely when
-        * using the memory controller's swap limit feature would be
-        * too expensive.
-        */
-       if (cgroup_reclaim(sc) && !swappiness) {
+       if (!swappiness) {
                scan_balance = SCAN_FILE;
                goto out;
        }
--
2.34.1

