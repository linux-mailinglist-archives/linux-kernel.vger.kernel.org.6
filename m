Return-Path: <linux-kernel+bounces-364731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2299D888
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7782B21C82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E591D0F65;
	Mon, 14 Oct 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZY5BNjF"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140151A76B4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939067; cv=none; b=ODgO9t0edO6Iryva2CgpYcPRKAWz3xwdhM2byxL1Y05l6zsjQFdCFmmtbWz28HHqI8fCtCBTUqaaMq9T6jKpHyA5HMMzQkH3foIvi0hohI8oCoOb/rS4K0d2mo5gzpGLnv0b+8F/+tZn4FFZdDg1s5TPvHR1YzKjoB7jh2Tv8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939067; c=relaxed/simple;
	bh=lewVEom6pALFlTuOAHpqok3Dl+EIKgvJ0zO4ds2+jhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PR1Vor3ENyPz0tkdtNrli8eRFu2Gof6arSnVhueFmM406LRQZmNYsesALtqgdhcunSQLhCEq1EDong041bhdkYEfHPvp4cC3FJL2AKpuZJLNhuVBlnfDEQtmlq3+GZ5iKLleCuns/3d0Bwj7S2V4nefI8FpYNqebfPbQa53kHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZY5BNjF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so29249a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939064; x=1729543864; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYJmmOOjCB2lgXUrGfzFRuft4sQanhM1Sz5pixZWlqA=;
        b=MZY5BNjFlVY/+0XMo8XqaCmUGodCJjQSlBQ/ZHmebB5UjlmTZbPmlwM0Xgn/rOHRKd
         O9oATUOwhaTzpuC3xfFLY06hQJoY6jsaNqU8uCWMNKXB/4QLZbzu90YtZVMB+I1xJbSd
         hQYRy5EVx/pPZXZlltz/V8qqqCEX7q/o0siSL9uDgCQRrOHWV5cxE2gnTPjJJWKzLOXy
         VucFFy6xDsXAqvR5ZpI4KmHlw35Kqii1OZdiZbPyvcIT+DKXrac1VetBaHeB9arJCdNC
         feCvvxR6TEbqC1h3rKKTZULxixT9jZjUgC11vfnlcF8C0lOetA3isYifCR7CFPtr5YJj
         ok3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939064; x=1729543864;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYJmmOOjCB2lgXUrGfzFRuft4sQanhM1Sz5pixZWlqA=;
        b=urZqXvb33ZpWxWmcItcin1NH8xz2FRtcRimHFwB2stBWx4TeDtGbEezLsgrUmFDxYD
         GNPBaDkiZQ2nQbbjC4RYXGmiVCnzViiL/bQZOExP/KOzBqrXSRCJGNCw3zLIVNlM016Q
         vNQZ7yVS4ZqfPmqJg1jeSKupixnNtkwtAk8bw+Nb8Au1H5DYQw5LeNj48Qv4fnu1bzrD
         QQUEn43Neowy5i9PzSgyG4JY1rOFCBfaVJsuZUEm6z7qzgOJDSG2ml/KDtcfdkQ4N17z
         zmPnNKC5M7Us3QfsnmjTSOFt2gDm/UY8i0dNy3OuDUZYT4y/GoT7BjZP4yLjHiQ+nKsl
         En3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIbdVRs++CNLKqGQFIrMl1NZO56ZxOW3pBhQEkY6qvvuf8SETmWf456JC1fJ1me9EMuQDAIrlP3lD8Brs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOlLOrLr/ajlJMae87+UYyPAn52aYRctO/zddyeFORTmf5Om7
	weV9y45oZ/GKA9AenPUgH+7bIUx8GQIR034iCtXN5g3w/DGfbHODjE+6LrkahZSjUDa5UGpHhW0
	y8k8f
X-Google-Smtp-Source: AGHT+IEzJnXXPKAUHtScnpZJEgeyh3QTTmVlzgtBSHQSPjVzS114TIAzO6u47WQqicuXIEcHlVzuxw==
X-Received: by 2002:a05:6402:5251:b0:5c8:aefb:746d with SMTP id 4fb4d7f45d1cf-5c95c5ee259mr382033a12.5.1728939063684;
        Mon, 14 Oct 2024 13:51:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:76ed:8ce0:df7b:3495])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffc51sm131351655e9.15.2024.10.14.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:51:03 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Oct 2024 22:50:57 +0200
Subject: [PATCH] MAINTAINERS: add myself as memory mapping/VMA reviewer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-maintainers-mmap-reviewer-v1-1-50dce0514752@google.com>
X-B4-Tracking: v=1; b=H4sIADCEDWcC/x2MMQrDMAwAvxI0V2ApLpR8pWQQidxqsBvkkhaC/
 x63ww033B1Q1U0rTMMBrrtVe5UudBlgeUp5KNraHThwpEARs1h5d9Qr5iwb/ir9qOONJYyUEke
 +Qu8312Tf//s+t3YCYl+AQ2sAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728939062; l=1237;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=lewVEom6pALFlTuOAHpqok3Dl+EIKgvJ0zO4ds2+jhQ=;
 b=3y2yT0Ed8mMqJx0Mw9WwRcbSYcmds/lrBSOqtAVfxP0c5KMTUtoKO/W8lyJNSk+pDnM4cv29p
 PPz0rZWknckC/UPmgod3VUm0GxxvnsKXnsyrATT8fZJthc5p3ZeXqHY
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Add myself as a reviewer for memory mapping / VMA code.
I will probably only reply to patches sporadically, but hopefully this will
help me keep up with changes that look interesting security-wise.

Signed-off-by: Jann Horn <jannh@google.com>
---
(as discussed with Lorenzo)
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 659aca7cfad3..6978444f81d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14918,6 +14918,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Jann Horn <jannh@google.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
@@ -24733,6 +24734,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Jann Horn <jannh@google.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	https://www.linux-mm.org

---
base-commit: d4e7ab0ed929645bee32538532039d3d451efb00
change-id: 20241014-maintainers-mmap-reviewer-82a031ff2425
-- 
Jann Horn <jannh@google.com>


