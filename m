Return-Path: <linux-kernel+bounces-189748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC608CF475
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B011281420
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A71642B;
	Sun, 26 May 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ2r4zs2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345115E90
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716732108; cv=none; b=bOYqJy5cZmUxjH9XXSzhfW0BOyIB6Y547YKd8KVU4x6GIHShfSLXZp21obtKzg4MEANHklFO16wzHHDKHnhPkf+45BjDmFmO8vlJcsll5SvnxtFKhiUjXyo//ObD+QPXvyv0UWFy0rL4waFa9INBG98+b/sbGTdL+30qrz6R48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716732108; c=relaxed/simple;
	bh=In48y0pApngmsbuMVu4rLDLb/XOfXDOmaT7OduNUFew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDJgZ0Jkt0UP5t2DjchOge31x2H2PBL6p1zuOhRqp/cg3bZ5et6ZqeCskyJs8lrVFNoCJpUI438y9Wwxc/fStj/TipnYK7rU4mclyI6zxlEc7ybuXnQ1JbYC12opRWcsbGE6AZmzdw36CpshK1jKwZR7mvXozl7bDi2hdTU/y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ2r4zs2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f32a24e0b2so891735ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716732106; x=1717336906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wWwa2blJw1v9DPCM805/uZ0DLUpVg3y4xjSDjosOAA=;
        b=BJ2r4zs2spayVnniESeCaXksMNNcG3n+C3Qs5ZSsNKeTObbGjVchufMtc5I3hyUy1M
         AMrlfGFbzo9x9iAVB5hi+McX6sONLCSYyD33IY0jEnhG+lKUG/FOeh6qBK97u/QTGmE1
         GJXYpMtWCegqiUf+5+LpSwqxA5D+y+ZhAfeqOz/jH+8DZrCxvZfgemFcAUgdzDVqXD0p
         JJgE/t/Wp7RHMX7KGXKo7VcQc24ajHPG5nd03j7uzw+Ox/EkmB6lEWO/estSS1CevU0G
         GVSbI34Z6s4NMb0E31tRpayKIOHnDafiZ4Up438L8idCARQdpGWY0vxCzXjhyRymKqT8
         WmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716732106; x=1717336906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wWwa2blJw1v9DPCM805/uZ0DLUpVg3y4xjSDjosOAA=;
        b=Ng8NJE7E1qyU3PSucRwGE2S9ZwPMcqPy7ZdLW6z6e0YCcrfu8sCoGbIOhd4a0EkUsa
         M8Gl8ez0hS0j1Gwvngz1Dp9dGq5jt4hhATwo8qmoWiwqthw3Rmao9ChZzMfhDHpTZPN1
         vqKwhUZee3W9Y3nENNoPq5xSWWUk1mH2oj7hZe09RxJeTSdBNk/lzxwG8znmqMAR6vzN
         +q/1cgEddtpp9fiM1LH3DT60eT2FjS5NmDfUQNkPMDZKRWkNVxDTrLj74xfr5FKTPgt6
         8NrgZFEEOzoa9OuzaTDPWD/lxNPe12fh3C+hAjnk/mr9GgtGND4QFnSAW8SHlaszszpj
         QprQ==
X-Gm-Message-State: AOJu0YxsQaWbeZF45AQlEJTsPiwCH70y0qmeo3Rpj4U8nrjO/NKvbmCC
	bYErN0H3NGAqtSqjxn5PMuuOjx7ApmVH4SiVmW5t8bjMfcdoGW+583JIIQ==
X-Google-Smtp-Source: AGHT+IHAtx87oxiIyIRT+DNpcR/QG3eeRSxM/CPLi+a1mWzK7eM1Jk7VGlKPM5UPDZq3cz1ScCp87g==
X-Received: by 2002:a17:903:2451:b0:1eb:50eb:c07d with SMTP id d9443c01a7336-1f4498f0cb6mr77393305ad.4.1716732106118;
        Sun, 26 May 2024 07:01:46 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:da5d:2d85:2879:5a6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f460b311f0sm31066085ad.212.2024.05.26.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 07:01:45 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] lib/plist.c: Enforce memory ordering in plist_check_list
Date: Sun, 26 May 2024 22:01:39 +0800
Message-Id: <20240526140139.17220-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There exist an iteration over a plist in the function plist_check_list,
and memory dependency exists between variables "prev", "next" and
"prev->next". Consider plist is used scheduling subsystem, we should
guarantee the memory order between multiple processors.

Using macro "WRITE_ONCE()" can help us to ensure the memory ordering as
it was stated in "/Documentation/memory-barriers.txt".

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 lib/plist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/plist.c b/lib/plist.c
index 0d86ed7a7..2e51829d3 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -47,8 +47,8 @@ static void plist_check_list(struct list_head *top)
 
 	plist_check_prev_next(top, prev, next);
 	while (next != top) {
-		prev = next;
-		next = prev->next;
+		WRITE_ONCE(prev, next);
+		WRITE_ONCE(next, prev->next);
 		plist_check_prev_next(top, prev, next);
 	}
 }
-- 
2.34.1


