Return-Path: <linux-kernel+bounces-195256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEE8D4998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250971C223C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F817C7D9;
	Thu, 30 May 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJNXaulG"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FA169AEC
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064504; cv=none; b=NTovw2X+F6qcwSgeG0wd0FpRjPYvqZk1+IkivXcn4UcuTCJW04UydgEkaRbNGe0bHe6TK8YQpd4vb71m2gR5ctkAhkQd/Ppyk5vsNjtDHkN+OhYVjwUH6GV0BFn6s+jXN6WvKaiGLXXW19K10ykgcfAapawLhzhpkZF+8fkuoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064504; c=relaxed/simple;
	bh=75IDTlDpPkG3i5GzseSzfyM9B71c3475838AuHuwHvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEs3CKITuVX/4e8vvgSMpKxXzvlf+De4YOTX7v19Kzny+r71x4Pno3+nzHDuXhk6RiLHflNCsb8fS0+uMU/iDEuDP/XZWrHcAzDTF/7Sj4RGlRNeIum+vbn971wW7znziJ21XkEvJYPDbF5X+703pJC4g/TZOd+qR5zGsC7rj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJNXaulG; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc681e4fso355436b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717064502; x=1717669302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BaRUgvIHUgZO6RMmzziKFreAcGVarRuht+4q5gP5AUg=;
        b=iJNXaulGFoUPHW7V6w7oGnnmnSb+Y3P1JIOy91jGepbCp+S3dWG+I6i3wakRNkLk3V
         dj6ZpXjtj5j1tm6CoV792h3FKOChswF8Bw02p9Wqc6llsRyWa0HoAwG33+xM7lDdWTbD
         rzzZzaz0NtP8AD82+cYmouHU5brZyus548KsQ6mnEWEwkUOsWpNPaXf9OO/EqcUt4ang
         9VGkAtBTTFZvkKZjrY4JVOU2NYAMrJZaKB5Y8Ldq3WvHzQEFe7EadK+bgpj24Iwu1fDH
         59aR/NZXZmljsmYN/r2pZLyhDyAKO5uK/Qii5BtUNkZoSxu2Hd8q2v3rE4J3ph47dEdv
         BIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717064502; x=1717669302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaRUgvIHUgZO6RMmzziKFreAcGVarRuht+4q5gP5AUg=;
        b=GEqrYIpHNQ9P5cRNq6I5ZyWWeZ/Kso63o2rLlVapPTAAhk7aev/PJFYKK2wC5Xyn+9
         QiA+4dvDhrn+y33m6YKIGNW1OsvLvt4gc3RARheVsnaJC/Vqcj76Zj0o0Fso7jxit3KD
         qKlJRMbexpUEe6QKFaVTJZi9YtSxQCIKrZcYMK1HgVP3WCzXamlt/MKx3p0ik9aPazVF
         /fkEKAw7L+wt/V+AORvMX4ESfU8XPytRA313i8/VwClnTcSNZ/SGq4/G9Z0eqxt8E0p8
         P/4vW2EFGs0ulDWw5s9HClsxcCbvuxXvPDLSu/buYUb9ycWecXAboXe8RIsR5v67vmQW
         2/bg==
X-Forwarded-Encrypted: i=1; AJvYcCXPGUBwYm8Zxte9V0BTN+JKPkNZgD89eLhq6bz0uFA/iduFxdvJGBDvMZvXzx/s+6ofDl2LJxw1rKnPx2YpOFHoJjvyORb0bG9IVIHH
X-Gm-Message-State: AOJu0Yz6upjXxYf4Lbck2FExfjIkYh/4rYgSWERXiFZ47LtCXuubobY1
	6d3tPXjBXsk6IhKxN/sj512l8JWmqDzKYlRWZyEejJd+2C2396Jy
X-Google-Smtp-Source: AGHT+IH6QryCjy0Djphuea2ESS7I4qOgIlAxePO+g2CzT+eKa0mFtAJBmNKROYRYRX+tvQuk8uYzNg==
X-Received: by 2002:a05:6808:13c8:b0:3c9:c509:c17 with SMTP id 5614622812f47-3d1dcc9d29amr2381208b6e.11.1717064502309;
        Thu, 30 May 2024 03:21:42 -0700 (PDT)
Received: from localhost (fwdproxy-nao-113.fbsv.net. [2a03:2880:23ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070f6897sm62085986d6.64.2024.05.30.03.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:21:41 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Thu, 30 May 2024 11:19:06 +0100
Message-ID: <20240530102126.357438-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As shown in the patchseries that introduced the zswap same-filled
optimization [1], 10-20% of the pages stored in zswap are same-filled.
This is also observed across Meta's server fleet.
By using VM counters in swap_writepage (not included in this
patchseries) it was found that less than 1% of the same-filled
pages to be swapped out are non-zero pages.

For conventional swap setup (without zswap), rather than reading/writing
these pages to flash resulting in increased I/O and flash wear, a bitmap
can be used to mark these pages as zero at write time, and the pages can
be filled at read time if the bit corresponding to the page is set.

When using zswap with swap, this also means that a zswap_entry does not
need to be allocated for zero filled pages resulting in memory savings
which would offset the memory used for the bitmap.

A similar attempt was made earlier in [2] where zswap would only track
zero-filled pages instead of same-filled.
This patchseries adds zero-filled pages optimization to swap
(hence it can be used even if zswap is disabled) and removes the
same-filled code from zswap (as only 1% of the same-filled pages are
non-zero), simplifying code.

This patchseries is based on mm-unstable.

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
[2] https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@google.com/

Usama Arif (2):
  mm: store zero pages to be swapped out in a bitmap
  mm: remove code to handle same filled pages

 include/linux/swap.h |  1 +
 mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++++--
 mm/swapfile.c        | 10 ++++++
 mm/zswap.c           | 79 ++++------------------------------------
 4 files changed, 102 insertions(+), 74 deletions(-)

-- 
2.43.0


