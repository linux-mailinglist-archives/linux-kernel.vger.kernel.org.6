Return-Path: <linux-kernel+bounces-316777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E300296D484
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A156B28276D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1089198E83;
	Thu,  5 Sep 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSmMCL7m"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A86198A29
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529972; cv=none; b=lJLKguGEU8cwkATVojgmrnXZ01PYHK4CKbrwTomjEBq3RTS/hf3VnpRdZ+vwWVw61HKa13xr5Do8wzb2XH/hhGR6DlBQTOkPrYQ5LSeN5wqO+p32EamMyf3N60MBaTPEgj+hnuHMQYtP0sOhBqotFX3UoKwzHnrF2SRZZv3Bl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529972; c=relaxed/simple;
	bh=gzngvDwluLEe7lCSNkT8HVUCMDTsmzHiq1kOL2zStvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EuoD+rxreiQZrZZR2/McDd97TU9gv6VMoA9r0bqVLWjVvBfbLpEhAwzB+SiGlY0+L2MpCvRhLA+maBipqYp8JmI1uXzqTIlHg66xt38SXptCBsXR3V2AhmWwa4h6iU2ZkdtOLOzTfmn5f1CD3CJtVm+pQT5A/9PLLv59jZQ4xVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSmMCL7m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2055136b612so6308145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725529970; x=1726134770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02/uy/7+25tcFKpRbeJa3Z8eQolu7MZ4cB3OwstXuO8=;
        b=FSmMCL7mZti3t9CZH+bc+7Ua7+UrEl6kRMByYrBVlS/ApBd+S/DizvA1ynmB1A/9DW
         hyVkkri4tQbh+48K5p2YKK0VIUSJBkGVe/kRKcPkTd87q60/KSI87IDIONRPYINQ/Mcu
         x+vG0liz9WX0FEZiIclhui0oa9/b9EgonrIaRMveIVCpa2/UWLXIr4QjbF2VlyZehH/L
         AN+d0mpcAdI8Odh5Aij07LI4RZXmtDNLvDLPvbZm0z5tyjacB7UqWpnAu6u6LtcXEuMu
         Oxzi2vbXyACR7LkZlhC8lp8mPrh4QNDwkRVjsXDKEkJVeB6j9ZeA8CyAyifsoFJ7Tz7n
         UMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529970; x=1726134770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02/uy/7+25tcFKpRbeJa3Z8eQolu7MZ4cB3OwstXuO8=;
        b=iKDj+7jUbeAs6Yglo6v0fy5Sxj1hA215gbfD3jjdSEfZnADn/nnYbx9bg9PhIQ6+Lg
         XXi0wXD71LQ5UWnLZo4fwUMPpYlOcQVF7KyO/m8sT3Lvw6sHXaxwjJrtUGHw3W4L2mfO
         pLBvVnWfyWpYal/D1awVxm7J4ijcHs9FdMZhBoaTG2TwSBXFlGomjxUDw/XjHD3HTaq+
         tsbYKAEN55LyXAJyEEopBijMXrEkLeiKfWm1QeDe8qoYsHAexrCMF8L9/mTDolfQ7XAs
         tBDoZy4hB9SJ9/dDVDjcYq5tKuhX9fibStypARPkX4LtnOIBwR2ngoThZTBvA0R64EM5
         yCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIipQUVesmp0m8tyDhh3nhKE+UOiwqoG+5xF5+UcA4Gn4kgpROaa9WltNTsn+YZwOc8TvWqWSlPdxqMOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCxajWmfkOpLILIXTv0NaehMIPwnYor4vpMwBuZ8Vdt30U5i4
	LwIPomocR+tXGJnpQZ7aYn+NzAlkd3i7u1dACrIvk0a9L0FtaKSt
X-Google-Smtp-Source: AGHT+IF1TQGvQ9Uw4JQocrRBj7ITBar+56VGGpVhL/etHwEFalxxKCYcL/geA5TzhpYyWBlN2mI1Gw==
X-Received: by 2002:a17:902:f690:b0:206:a239:de67 with SMTP id d9443c01a7336-206a239fb32mr71910745ad.18.1725529970181;
        Thu, 05 Sep 2024 02:52:50 -0700 (PDT)
Received: from localhost.localdomain ([123.124.208.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea556f8sm25578455ad.198.2024.09.05.02.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:52:49 -0700 (PDT)
From: Wang Yibo <lcnwed@gmail.com>
X-Google-Original-From: Wang Yibo <wangyibo@uniontech.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Wang Yibo <wangyibo@uniontech.com>
Subject: [PATCH] mm: move bad zone checking before getting it
Date: Thu,  5 Sep 2024 17:52:16 +0800
Message-Id: <20240905095216.7888-1-wangyibo@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flags from gfp_zone() has an error combination, VM_BUG_ON() should firt know it before use it.

Signed-off-by: Wang Yibo <wangyibo@uniontech.com>
---
 include/linux/gfp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f53f76e0b17e..ca61b2440ab3 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -133,10 +133,11 @@ static inline enum zone_type gfp_zone(gfp_t flags)
 {
 	enum zone_type z;
 	int bit = (__force int) (flags & GFP_ZONEMASK);
+	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
 
 	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
 					 ((1 << GFP_ZONES_SHIFT) - 1);
-	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
+
 	return z;
 }
 
-- 
2.20.1


