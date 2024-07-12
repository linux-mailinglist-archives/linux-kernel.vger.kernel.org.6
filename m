Return-Path: <linux-kernel+bounces-250127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26292F483
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA771C230A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F6A15E96;
	Fri, 12 Jul 2024 03:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvA/h0f+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AEDDCD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756306; cv=none; b=GdaoNxEDcJuVaN8y6wk7gqsZKRAbghaskhInNxXJzqEHJIz7SW1O6E/k/bEEy55y/E5RBCGaHGmA7oBZx4GUZdCUTdTM5GgMN8UtxokBQYHo9DJN9HW5cp/jfmz8Tde8/Yqg7Fl+i8BEok/P+Bb8uwvREr415M1mmnxvJUVtTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756306; c=relaxed/simple;
	bh=d7LTJV9IlxW8+L/AjKuDlqFR8ZMjHyraR64pPCkVqBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jdY/Ps+jTzMN1Wzax1FZWaC+hey80BMxn2Q8z86r/zC2GrQ+Qt8rUFArYG3udjhhM991f/HATdC9Z0igc5lbgZXfKHZIzZKOk6Pc7etFSMBQIOkkGT85xjKKus+KpZM8gBi4pZF6FmHQL7Nujz5PDeNGBuNQvlA1yWz54YmpkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvA/h0f+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso197159266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720756303; x=1721361103; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCFj880VNkxO0HYZD+OwyJox07xhsd/AqJTyvBPQ71U=;
        b=XvA/h0f+OU/ivb/Qn7kKpXZ7yJy6y/QxbZaGhe95Es3N2ry72SAJKrj0bWc5IhGbKv
         7wBRVJPiVAooontzlamLr3W6WwMgLrTp6Xz2xav5r6RsJTO4Tk7al9tYvOO8+YYE7HG5
         mH9t/sqgN4CNFTWXuqSaQEjOfHGHPHU/W8sSdYRqpFsGEXCDuC+4nWUxhJ8wecfs0yRe
         nH1ToHRNF4lPr0PZeJ3zOOZu8uvqPCgmCmE+/4wp03+TzLwE6RELx1zVw8jS/X07N914
         3sL5sVc0cCAXaGXvWGV+yZTXwR49la8MkAAV8nkHHZV9jxeBrJRsO77spKT5kJQAU5PA
         yj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756303; x=1721361103;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCFj880VNkxO0HYZD+OwyJox07xhsd/AqJTyvBPQ71U=;
        b=Ut6vNvNKSpJ8su8/2CnPVl7Y5ZsFaXzpN2AsFFHRRyWc9FTfu1lo/JPq5c4RKM/mYl
         uHgvxhyvblJiEnVtrNJIkDrife89AAN/3rtgkAMDrw0t/msl3ukuWNL8VMEYSz8hnSzm
         lynTdWMYNaH6qEt90H5S7mgAhq55GG/MYxTn4KOhwNeuzocSVbfJ8AdR2Kv5V5Nq6dbE
         mIg7KnYn3VHJL5Nnq13yRhvP+ncq51V0r/Pvg6KYkt9BCOsl6VHEJWmeRCplLyiGgAvC
         Ir0km4fdhzczjEPWqWu/KX9HUjNwHMsJsaREcSJ3ozdNgk7hmOsjX+7weHpuRXKadMV4
         hmTw==
X-Gm-Message-State: AOJu0YxwYmiArk0jbONuHe0esPfy1kuhKktDIU8CDjobsXIcu0FCX+P2
	7A3YsHyWKnvzhPuEvlntL4n070px0ScsZGpdPlZcGwYwO5d7EsKD
X-Google-Smtp-Source: AGHT+IGU42SFOUlzrj7kRRzHWCymLPr+3FJfHb34KI045J585sywpXTtKt3Z7zk2SYVEJATzJEXU4Q==
X-Received: by 2002:a17:906:260f:b0:a77:c364:c4e9 with SMTP id a640c23a62f3a-a780b705312mr604819766b.45.1720756302841;
        Thu, 11 Jul 2024 20:51:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff0bbsm303491266b.119.2024.07.11.20.51.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2024 20:51:41 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com,
	will@kernel.org,
	broonie@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/3] memblock tests: include export.h in linkage.h as kernel dose
Date: Fri, 12 Jul 2024 03:51:37 +0000
Message-Id: <20240712035138.24674-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240712035138.24674-1-richard.weiyang@gmail.com>
References: <20240712035138.24674-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In kernel code, linkage.h includes export.h. Let's sync with kernel.

This is a preparation for move init.h in common include directory.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
---
 tools/include/linux/linkage.h       | 2 ++
 tools/testing/memblock/linux/init.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/linkage.h b/tools/include/linux/linkage.h
index bc763d500262..20dee24d7e1b 100644
--- a/tools/include/linux/linkage.h
+++ b/tools/include/linux/linkage.h
@@ -1,4 +1,6 @@
 #ifndef _TOOLS_INCLUDE_LINUX_LINKAGE_H
 #define _TOOLS_INCLUDE_LINUX_LINKAGE_H
 
+#include <linux/export.h>
+
 #endif /* _TOOLS_INCLUDE_LINUX_LINKAGE_H */
diff --git a/tools/testing/memblock/linux/init.h b/tools/testing/memblock/linux/init.h
index 4aeddce53310..bd74abc5cba6 100644
--- a/tools/testing/memblock/linux/init.h
+++ b/tools/testing/memblock/linux/init.h
@@ -3,7 +3,6 @@
 #define _LINUX_INIT_H
 
 #include <linux/compiler.h>
-#include <asm/export.h>
 
 #define __section(section)              __attribute__((__section__(section)))
 
-- 
2.34.1


