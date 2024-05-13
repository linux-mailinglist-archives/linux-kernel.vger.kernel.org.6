Return-Path: <linux-kernel+bounces-177128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EA8C3A74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8561F21232
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE086145B2E;
	Mon, 13 May 2024 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1Zs3zFP"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C81C6AF
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570779; cv=none; b=n/pfIrkY6dvE1OkL5rJPEyO2UZkTbojbbsjO0ZnrTecaeY2ALThxt0FOkyYaxVOo45n2t8OzzeBv1nXkh6qgVshuVPHcZeT4UYY/qiRVONPTClGNFPZac7GuhmA816VT6u7Q7RtRbA5hlzx716yngkWBfIEiWdXWABQftD7MVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570779; c=relaxed/simple;
	bh=fRb02CGZS+fgXelFowWgMAxURxxxXJRSf8wTvL6jUkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDLd5EClevJIIEyEbJ7fkzX5Ufcic6AvzAbgw33WWeRoZC7raqYY1QcdnDkEjSY43h3lJLSV6fkm1AVQpaMJgEsWOqzAkdq2b4qBJdmaJ/WdM/zkmiVW7WwZwivCYgfUg7C/y+j9KsPGII6DuBaZKEWCGBffvsKUau+dD5U4fN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1Zs3zFP; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1ee7963db64so32419195ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715570777; x=1716175577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOXg8rlLiBbIUynXL7jRvxHGjt0168dh6EbtfJtWOUs=;
        b=M1Zs3zFPUnlqWnYvo4vraIV/ozAOzpxpAeumKWhoSeSrps4xU4wUc/NiQUlvn4bZOS
         6pgQ6lYRyVVNpSWNGtgVskLH9v8j530kpJx4BBU6MuDovu6EfQTmWVj15w2uIn0k5JQB
         yI7xX6UcEVUSFE4ecJD1x1SKHOGL3AnGvICrLvh4rVQLDjiNP1NYZ5reyn42jJighDXA
         3e4sJ3ofh8V23UQkEycDln8ZiEHxiDInwwoBDy03LUylgXJsXZ0Q2MqM80mx99mNzAHl
         FHbW30t9qN4sgPYN2bgA2F90vxAI4o9QKl/ueaH2du9zFhCwE5OjJGxKtTomhPJERcoZ
         UkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715570777; x=1716175577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOXg8rlLiBbIUynXL7jRvxHGjt0168dh6EbtfJtWOUs=;
        b=E1yZj20zZwt9isUxHAqJA+8GcFneG9cmyzVSFS6WgP8b+vvt5kxrAm/OkYie0Eqnql
         D7QY2UqM6FlFrgVbkjrdTifZ1jXaqaoyW4KzoBlQv7FB7a3gkrfehmCRg2lzc9CoCl+m
         3Rlck6QzmfiQaye562dEHfyevjOKwWMZHrYszbXt+yvIRiUoNSe5T8UNvj8NLxHEkP5p
         ArydFGz4OYTPx3nunQMJordnSoC8qdPyQDZIpqgQbVoWEUB55fwFEbIsUuVEeACNnvYq
         MemqLSMgEhGxoQwlqsB9pwX1xe6/hb/K/kuQQSiqxqK2yFD5EvsvYIHmwtca6hB1p/vP
         lgWA==
X-Forwarded-Encrypted: i=1; AJvYcCUH10Po4LgIMyx2Cx5ibczaFKviOoFtm8XpiSsVILreSvO09GwxIQEDL1FPWvDbZQ2VO9qmEu4T7XAdgDVZsh5BeGu3oYOfBipUZSq0
X-Gm-Message-State: AOJu0Yy7EKTAUAnEbuB8XVvn1lz51f4N2KpdBTSII/dgBS7g9MN/g3f+
	z8ghaCGSWCt6V4N4macETT5lcEU3R/C+iK6VztSK2lCIs+JIYh9y
X-Google-Smtp-Source: AGHT+IH4smblCv1xdxm1/3T1VcVC7OVMjaEW2e6EUZubGvPoluPnUzrSoOC+QJgum1sLwOVwU/MWzQ==
X-Received: by 2002:a17:902:ecc7:b0:1e8:c994:b55b with SMTP id d9443c01a7336-1ef43d15786mr128499615ad.7.1715570776901;
        Sun, 12 May 2024 20:26:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038733sm70428985ad.215.2024.05.12.20.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 20:26:16 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: chengming.zhou@linux.dev
Cc: aarcange@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shr@devkernel.io,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	si.hao@zte.com.cn,
	zhouchengming@bytedance.com
Subject: [PATCH v2 1/2] mm/ksm: fix ksm_pages_scanned accounting
Date: Mon, 13 May 2024 03:26:09 +0000
Message-Id: <20240513032609.650507-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513-b4-ksm-counters-v2-1-f2520183a8ca@linux.dev>
References: <20240513-b4-ksm-counters-v2-1-f2520183a8ca@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Fixes: b348b5fe2b5f ("mm/ksm: add pages scanned metric")
>Acked-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>---
> mm/ksm.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/mm/ksm.c b/mm/ksm.c
>index e1034bf1c937..0f9c491552ff 100644
>--- a/mm/ksm.c
>+++ b/mm/ksm.c
>@@ -2753,18 +2753,16 @@ static void ksm_do_scan(unsigned int scan_npages)
> {
> 	struct ksm_rmap_item *rmap_item;
> 	struct page *page;
>-	unsigned int npages = scan_npages;
> 
>-	while (npages-- && likely(!freezing(current))) {
>+	while (scan_npages-- && likely(!freezing(current))) {
> 		cond_resched();
> 		rmap_item = scan_get_next_rmap_item(&page);
> 		if (!rmap_item)
> 			return;
> 		cmp_and_merge_page(page, rmap_item);
> 		put_page(page);
>+		ksm_pages_scanned++;
> 	}
>-
>-	ksm_pages_scanned += scan_npages - npages;
> }
> 
> static int ksmd_should_run(void)

Looks good to me.

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

