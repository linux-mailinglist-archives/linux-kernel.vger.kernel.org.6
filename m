Return-Path: <linux-kernel+bounces-230901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F229F918397
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89BE1F23E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA118411F;
	Wed, 26 Jun 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K21gvrpq"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9A181D1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410616; cv=none; b=EkphcFTMYMcUYv5H4d7GplkrTtG5/5gb9GQCwFH7gX6rTwlLHKuKRENiD4DieKsaAIq72fyrzZS94BdNdalrE3qUF4FFGEDxrGpqVKbQSF3cUys2pJCw3m1/rXpuniCta2Uxw8XIYe/Co61EJT+tr+OjejXoWxztQuB7g5BtMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410616; c=relaxed/simple;
	bh=zO0ET6/ST7Go9gIMb2eyBEc5Sg5in16GY49d0Ky8J/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qid18o2WnBfyrY8OC8oEtCZQFa/9R8jCSlQydSt/Q5LJF3cS0nI9af9tijVySHbw9i7RF9lS1zlZdT/ZxcDjDhorIipt1GGJp5Fa/L0WzcA+rwGNbjAzc1niCcELJ2yj/9lcLUtkBRt1OhRY/V06U6nTsE8V7O1uXIWyrCQQkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K21gvrpq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d0f929f79so312705a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719410613; x=1720015413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8J/0rbvyVLHrEXRHvUI44ewOQgj0kI0R2lTjROyuIg=;
        b=K21gvrpqud1vpGq9f2PXLaebGO1yLaUEx9Y1y4F8IFbKeuhPe7hY0esdlyc6fV66Eq
         ZfV6MxjLuBQ7LIY1rQLOmhzzddMRlCa+VvXpyX9YdH3EV3ei2fsmCwZZsK5ydbD3cvgp
         KKOO1UCVfQAqBqJTQIK+4HROR5XraG9pDFhU3cxaH6nSUYt58zdPV2w5NR+c8Ij8qTOn
         cTbB0+Z4QauMt7yQUa/YmaSzJ4HCtuhyn9EOrWNc0/fyzC3CY5dT+sIw0XvPLamu5zT/
         XlY5F+hPIuRF1MMyoiP2Lfz2rn+Olnz1d3uV1n9aFpnLdoETO0bSGHr94dp8xMZrG0g8
         IoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410613; x=1720015413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8J/0rbvyVLHrEXRHvUI44ewOQgj0kI0R2lTjROyuIg=;
        b=Lbmb2/HYefwxl3uznwV4LJ5eTmp85zrnJHtXvgt/1M/S+EGrhe38xFsCs8I4VGZ/9V
         Ql3cNPBBCf59C0sCdMwvdj89T1ZHGWa2dzazLEIocB9W47YL1J1e9bZgbEC8FI5f0lgu
         dSNh/adkRK/1lsrEH6gOWXniu/rQ+IXMkIOuCQReB+tQTZEk8+WEXWdFtAG2Iw8jjvl3
         1TkfTo7P9DJNnfWNiEZj+wZ19gcM86PcpugsCJnHvjCoVVxao84M/M4H0wuLYSM2FUho
         e1NDeZsOMFfSPvA0MEJm4rYH1MP74mGfLqX6QpRqV4jgGIFwFTGc1hDAQZtuBTRJIv7K
         8INw==
X-Gm-Message-State: AOJu0Ywyl2zrgpzeXMJVwtoBv24WxZfRKUNzmIVngRgxdom3YfWIxtst
	spMNZStALpM9D2IqmFYIxy+54AKBFBVAB8TQpiKnOj6I5aSTFSuk
X-Google-Smtp-Source: AGHT+IGwnJigcVlekJc4wuhQ5CyFPJkiRM/TvW9TOjWhYvxkbyUS/ofbTHF/oNZGwslIbIrTilh92g==
X-Received: by 2002:a17:906:2690:b0:a6f:586b:6c1 with SMTP id a640c23a62f3a-a7245c2db6cmr683232866b.56.1719410612919;
        Wed, 26 Jun 2024 07:03:32 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725bc1b3e1sm270143766b.8.2024.06.26.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:03:32 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Hailong Liu <hailong.liu@oppo.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nick Bowler <nbowler@draconx.ca>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2] mm: vmalloc: Check if a hash-index is in cpu_possible_mask
Date: Wed, 26 Jun 2024 16:03:30 +0200
Message-Id: <20240626140330.89836-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem is that there are systems where cpu_possible_mask
has gaps between set CPUs, for example SPARC. In this scenario
addr_to_vb_xa() hash function can return an index which accesses
to not-possible and not setup CPU area using per_cpu() macro.

A per-cpu vmap_block_queue is also used as hash table, incorrectly
assuming the cpu_possible_mask has no gaps. Fix it by adjusting an
index to a next possible CPU.

v1 -> v2:
 - update a commit message.

Fixes: 062eacf57ad9 ("mm: vmalloc: remove a global vmap_blocks xarray")
Reported-by: Nick Bowler <nbowler@draconx.ca>
Closes: https://lore.kernel.org/linux-kernel/ZntjIE6msJbF8zTa@MiWiFi-R3L-srv/T/
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b4c42da9f3901..6b783baf12a14 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2544,7 +2544,15 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+
+	/*
+	 * Please note, nr_cpu_ids points on a highest set
+	 * possible bit, i.e. we never invoke cpumask_next()
+	 * if an index points on it which is nr_cpu_ids - 1.
+	 */
+	if (!cpu_possible(index))
+		index = cpumask_next(index, cpu_possible_mask);
 
 	return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }
-- 
2.39.2


