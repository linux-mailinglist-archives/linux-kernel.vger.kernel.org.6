Return-Path: <linux-kernel+bounces-335961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49797ED29
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3811828140C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F42AD25;
	Mon, 23 Sep 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bONhUMdT"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4881392
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101538; cv=none; b=nJolzaE7GpjJlytVH9oJnX7U3opcdfTrefaB2EC3u1fZslEalsAxknaPiyHTZLu1+I9ObOYaD3cQwtN8Ftb/Bs6Hx446zAhRHUPTHII+uK3IjCdf/e8wnku9tQ/LXxpeHeY6MkOigKnVAQeMVjHZHLxuDNC5FDAXtC2SzHfa6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101538; c=relaxed/simple;
	bh=NbbIM+jTtXGG9jCNY5Xhx58HYcV3coXSo0Te2K4usq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=id4V7Pw0uJbcVBqj5Dg9Pt7LbzkyptVJ/fiIwFQ+KKKC+/SnW6owKNeLAHsDFvhPUBA4T5tTWBRg6GNsaaZVpp8dfQNfT4ThAO04sGDIiTvOSRFU1L5/X8Vh06FCxlU5VI2Nh8fIGAJUnAxLsMRmRlsVgTTpxt7NbIQMCujHxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bONhUMdT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7191fb54147so3252624b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101536; x=1727706336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=f/RAhNxEAp+I30ReyW3KKpuGInU42s+KyP1A1+TRN0g=;
        b=bONhUMdTbNdvouT9YhO2tiqRGUld98rFcFEcYUKX543Ollr9/zLAvxLAH4EgIZSXG7
         z6DdhCq40Sqtft5E9tvIuNiVLBbc/7sEM1HhW1G9Vb89utLK0rvz7z84tBmcYabWXw/E
         SMROHBRukmIyC2G4p2fK5urzKw3NpdUN1zMb60XzBDx4OEKSpCZHLpzsAJd1Hr+KB8p+
         z0w9ip3GQMay3CyLH05n3AFHOkjDt7Ctn1I+pqbZIBqWe1kL8CBzw3JUa9WibaY6rTG8
         0hIRct/h9i2v6ZEABsK4SisvFso3LvtWL4V98j+XIRmP9H6TC3hbGKv7HqUHxznJhhwi
         Zr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101536; x=1727706336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/RAhNxEAp+I30ReyW3KKpuGInU42s+KyP1A1+TRN0g=;
        b=D/L036mOqpIEsENYbb2KKN/keRZaXMUJz3iBrKmjaF5hf8HlO/ThofwNxnZ5+hpUMY
         saVXhYLHqQmvU078To/9xhyoVeuFp0EG2U0JDDMmbl4sEue5Q2f9a4U49eM32kESevVw
         NCDzbl7rovYnn8Fh2649O5RCDA9XNj9zrSQB28+bJl/LQQeEMabb/MLNQbzoeMwpIzMt
         m4QK8yxfk7kVuZXKIisdy+/2a38dbEH9UPXtG/L410QMMMylJ2sLD0EZ7A0Wq1QZxJMm
         a23thaMriURQBNor82CBjnui04m0qTgHfZmj2pA7vi2Pmlp0ctSMkN1nY9Ea9RjzQiLP
         du7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaM2UWF23fwYlm/femMuf9qYMWM5QAK9Y5wQb3vqsXGPm4wsaKCEr4d1REMPJs87+mKHrufylIVECY9AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4xbBcDf2GX4Tzc47O73BKQ6v81pBXI/NrX+USIP4sH54+gyj
	FhUnCghwWS1JeTcGwxLo4DHySmS8aMAhD8nlfNBKHgCmuEOr3qYYJ0sdkw==
X-Google-Smtp-Source: AGHT+IF/32xVhJM+Yi3WbHwCjjj37zZwnw2o/XTaGsqD/M6rrHqJy0NKwypUhzJVuXy0X9+Zk/xoAg==
X-Received: by 2002:aa7:8894:0:b0:719:7475:f073 with SMTP id d2e1a72fcca58-7199cc45545mr17539289b3a.1.1727101536224;
        Mon, 23 Sep 2024 07:25:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab56d0sm13952571b3a.66.2024.09.23.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:25:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Hildenbrand <david@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of NR_CPUS
Date: Mon, 23 Sep 2024 07:25:33 -0700
Message-ID: <20240923142533.1197982-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPLIT_PTE_PTLOCKS already depends on "NR_CPUS >= 4", but that evaluates
to true if there is no NR_CPUS configuration option (such as for m68k).
This results in CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig.
This in turn causes the m68k "q800" machine to crash in qemu.

Adding an explicit dependency on the existence of NR_CPUS fixes the
problem.

Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options")
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 09aebca1cae3..20fe60389cf5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -595,7 +595,7 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 config SPLIT_PTE_PTLOCKS
 	def_bool y
 	depends on MMU
-	depends on NR_CPUS >= 4
+	depends on NR_CPUS && NR_CPUS >= 4
 	depends on !ARM || CPU_CACHE_VIPT
 	depends on !PARISC || PA20
 	depends on !SPARC32
-- 
2.45.2


