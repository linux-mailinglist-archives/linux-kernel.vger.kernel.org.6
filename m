Return-Path: <linux-kernel+bounces-376687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4189AB4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE21F24461
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0551BD01D;
	Tue, 22 Oct 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrPDLUmL"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA51BCA19
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617678; cv=none; b=ioMj7RHqpj+rEP+MksbNvGunhlRgxtXgt2FeX0LB5uPq/HTdVEN367nOJf0X1i5OCOITwnGFKf3ELtDqJYaAxjrDbb8wcCxjUxLdzr7klGbUxL3vSHWmn51zik5xlBd+MhS0kIA3iCRpcZx4Vx/5DwQlvUKNz0lSXKM6I+L1dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617678; c=relaxed/simple;
	bh=E3+kC2Fpl3HvRHihxub5c1TmhJtK7A93CHUeJh8cIm0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QhbBgTofbkMXWBOI3RrFvjivIdesMuQJH72hUCKcB+9lwXs2Q/lNH7c5RriOqdriisdB6G1NAu3Ic59Q/Yeou92IjVo1ymTFzUHZdlIdySMXChKGmGJSSaiWRYtgJ0hXeruMGdDB/RjvkOPHK8PVXtaT3RjmXcWYEmUNuz8i5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrPDLUmL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso784976066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617675; x=1730222475; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVTv/ksHummE97FnDYtFliWHAfZzUexk/HaH8jn7z+I=;
        b=mrPDLUmLRmU4diDXJZ0a3XGVV9wU3TTX7/4QLkykGxK2caUg8knsGCIIefyFXz1eAN
         7+T3b369ph76NO+jN2nk36TCkFEZIbnSfo2yH+BSDFhJ9moXA4NMkyoUtKQzwF1XDEtS
         FI/WMYLMD4AR6w3q4qOoZGsQcx3RkZwelKbLJruDniNog3BgBf5MxQdchRQCDuIjKVM2
         vj8H/KhUzmS2vvNHt820WYDMtAIEGVVBR8bi0CTKCUHuM+U6m1oQCc5h9BKPGgZD62wj
         Wcdq7ls0eKpCuy4hlclKtL3ly5bOGdCKbOuXZw23QY5divmZvREKhoOrQasj6/evsXvV
         iDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617675; x=1730222475;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVTv/ksHummE97FnDYtFliWHAfZzUexk/HaH8jn7z+I=;
        b=LYQVK+NQishvDiYNUD8icgUs610h1Vu4JUPj82CoXFPOGE3f+V/O2AzbxUovASKtsO
         DdlZhaM+br/h1230U/1v41BrqOD8tq3YGrsNHX0ewcxAz8nCFJtWXoxIhxoWid7INbzu
         WqyViHZT/HTrSfSZTB4dUrx5qLeAyu34QkOGDtzhGruCrojg2t1pKpigmlWWdMltATDC
         J8P1CThWmBs/y2MPzA3HoHAvcI8M97PB5lqETlEdFeUSgGmjEzMnjn5wqsBui4p/eJ9e
         Din6ZJcx2PjTvuh5NgZ9Hpn7uIrHA5Xq43r9XUsedVhfkoJGZthF1nl6iGSBDlcIExTn
         Ekpg==
X-Gm-Message-State: AOJu0Yy5aDf6wOlc7/WyXlz2OPTf984RQbMuMM5cV7JVjHVrUea4OMb9
	mt2MXwBNtggSivtom422GPBenLnbbmTviTbqYKdiklHXzuJJ8iXw
X-Google-Smtp-Source: AGHT+IGhAOPZp6xrjMIPt+5jU8/59Zal3osEA6sx6csLQQdOmUbXnGm6ypF56Te4f3ZV5guHeWVdWg==
X-Received: by 2002:a17:907:1c9e:b0:a9a:188f:efd9 with SMTP id a640c23a62f3a-a9a69bad2a2mr1517764666b.29.1729617674288;
        Tue, 22 Oct 2024 10:21:14 -0700 (PDT)
Received: from [192.168.2.39] (ip-109-192-223-157.um38.pools.vodafone-ip.de. [109.192.223.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598f11sm364897866b.193.2024.10.22.10.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 10:21:13 -0700 (PDT)
Message-ID: <c1ceb507-94bc-461c-934d-c19b77edd825@gmail.com>
Date: Tue, 22 Oct 2024 19:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, wladislav.kw@gmail.com
From: Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: [PATCH] tools/mm: -Werror fixes in page-types/slabinfo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit e6d2c436ff693 ("tools/mm: allow users to provide
additional cflags/ldflags") passes now CFLAGS to Makefile.
With this, build systems with default -Werror enabled found:

slabinfo.c:1300:25: error: ignoring return value of 'chdir'
declared with attribute 'warn_unused_result' [-Werror=unused-result]
                         chdir("..");
                         ^~~~~~~~~~~
page-types.c:397:35: error: format '%lu' expects argument of type
'long unsigned int', but argument 2 has type 'uint64_t'
{aka 'long long unsigned int'} [-Werror=format=]
                         printf("%lu\t", mapcnt0);
                                 ~~^     ~~~~~~~
..

Fix page-types by using PRIu64 for uint64_t prints and check
in slabinfo for return code on chdir("..").

Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 tools/mm/page-types.c | 9 +++++----
 tools/mm/slabinfo.c   | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 8d5595b6c59f8..69f00eab1b8c7 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -22,6 +22,7 @@
 #include <time.h>
 #include <setjmp.h>
 #include <signal.h>
+#include <inttypes.h>
 #include <sys/types.h>
 #include <sys/errno.h>
 #include <sys/fcntl.h>
@@ -392,9 +393,9 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
         if (opt_file)
             printf("%lx\t", voff);
         if (opt_list_cgroup)
-            printf("@%llu\t", (unsigned long long)cgroup0);
+            printf("@%" PRIu64 "\t", cgroup0);
         if (opt_list_mapcnt)
-            printf("%lu\t", mapcnt0);
+            printf("%" PRIu64 "\t", mapcnt0);
         printf("%lx\t%lx\t%s\n",
                 index, count, page_flag_name(flags0));
     }
@@ -420,9 +421,9 @@ static void show_page(unsigned long voffset, unsigned long offset,
     if (opt_file)
         printf("%lx\t", voffset);
     if (opt_list_cgroup)
-        printf("@%llu\t", (unsigned long long)cgroup);
+        printf("@%" PRIu64 "\t", cgroup);
     if (opt_list_mapcnt)
-        printf("%lu\t", mapcnt);
+        printf("%" PRIu64 "\t", mapcnt);
 
     printf("%lx\t%s\n", offset, page_flag_name(flags));
 }
diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index cfaeaea71042e..643fd9558e09a 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -1297,7 +1297,8 @@ static void read_slab_dir(void)
             slab->cpu_partial_free = get_obj("cpu_partial_free");
             slab->alloc_node_mismatch = get_obj("alloc_node_mismatch");
             slab->deactivate_bypass = get_obj("deactivate_bypass");
-            chdir("..");
+            if (chdir(".."))
+                fatal("Unable to chdir from slab ../%s\n", slab->name);
             if (slab->name[0] == ':')
                 alias_targets++;
             slab++;
-- 
2.39.3.dirty


