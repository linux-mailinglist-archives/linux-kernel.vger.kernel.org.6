Return-Path: <linux-kernel+bounces-230652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA377918009
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB561C22E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283817F500;
	Wed, 26 Jun 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Taq5XDpM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC22AF1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402210; cv=none; b=PpHU2Wbctg0pJrXt8yelrXHrd2CfwpBCxYKo4igo6IOMICVeJMPF4fNkEuelPtrG8KLQHJryO3noKurEgERVTueVYUGyDJYZSg1Y3aJUIPNELxQhqbiUM4nnh/L3GtzL1hvxABHrwrlh8QhyR+ZZu3XJYBB0wFTEmTV90B3eQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402210; c=relaxed/simple;
	bh=yDgpjULbGpf74flIs/KZFjD95dyQt8UIej7x4ZY1Y44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QUbN4zgdhe1VPbQoMFQOxGlyyVXi0+tZg4r7NOgmecbuUkFZx69c+qQlH3j9oAdXi2XCOR/oFPolQKHYCmtMgsxnB2gmUWUqVfZ5oI5VnIk29Zrd+gHurUyg7SzqENliJd28HHHroBmmydaa0IiJ2jFrOIDGtUrz6QdiWnRTmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Taq5XDpM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a72510ebc3fso504775466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719402207; x=1720007007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0vlM+qZ0aOaH69nP4epFVl6In7rL2hoACpDR7WfzP8=;
        b=Taq5XDpMe6bz+08I7PzZUHDP9TmaWxIaLqVlxAaGg2RH1hdeYM2hW6nqtMMLZuUrJl
         3c9RBoBKhc8FdGrWXAcwErwyOFb6oGbHxkfy5k+eC1mGL3D+Lbvjt+dgbKJdUpX0FdZK
         4JQwt/AUbZXNDWSKp4eUbgN+EQ6o1k4zQZZcmM3DKQJBd1q1w2REl7KzLKem2Rd6DvGI
         rjubrtKG7IrKYjD2uuOczvED/FASuhaZEJ8eeSDH106K41vWID4gq2i8TKnaoIs87NAC
         Gv77V1AakG2wnusisCohNtX3OmAXJR6dquqDa/7XV6ADcmxYvsfv2EbKQENa4IlCTtF2
         oPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402207; x=1720007007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0vlM+qZ0aOaH69nP4epFVl6In7rL2hoACpDR7WfzP8=;
        b=MasgWoSjgJd1xGvpDPHaShL3Q3GUezc2cY7oehsfya4dqJbp8kxK/UM4HCtFwogW4y
         /inqi+Ugnts/mvIV9XaOj91nwaRnTiDUYOX2fLGDPVHWNnKA8KskEqlV9wJaukgh2MDu
         KK3j3FyHpRCDJRQX9TaWSBAE6kEHKNly23E7zBV0v6gDNFQYkdknxgt+lzB1u5ysC4nP
         uonitSxmo9fzMB5vRZAcKUqR48XWaHqMkgbGgaVNBRBElVPmabz215HhMT5XqTJcz0vC
         aQu4rCoX5tKQoPMnCekJK60Scex7nOp/lcRMpYoMwyEdY+caxllgcyFF8bKxlYzuYJE+
         07XQ==
X-Gm-Message-State: AOJu0YwucURE8ftw2nK/htxGKHO4IptoJl/d1QM69AcJCZvVAI3UESfM
	wp3OudQGRUoJfRYDzoDXEyhoV7y8pkApnkAXGIUI5ze9H0K2BLDFhGfCbg==
X-Google-Smtp-Source: AGHT+IH0zTf3PRIs+wLpFlt0dnNP1JgTx6WSdgmDhpVsQcy/yQ+0DmXy8dcDqf7xJ4EdVZoGHDqZYQ==
X-Received: by 2002:a17:906:c1d0:b0:a6f:5922:54e7 with SMTP id a640c23a62f3a-a7242d29bfemr815358266b.65.1719402207101;
        Wed, 26 Jun 2024 04:43:27 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72452140e0sm409649266b.217.2024.06.26.04.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:43:26 -0700 (PDT)
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
Subject: [PATCH] mm: vmalloc: Check if a hash-index is in cpu_possible_mask
Date: Wed, 26 Jun 2024 13:43:24 +0200
Message-Id: <20240626114324.87334-1-urezki@gmail.com>
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

A per-cpu vmap_block_queue is also used as hash table assuming
that incorrectly assumes the cpu_possible_mask has not gaps.

Fix it by adjusting an index to a next possible CPU.

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


