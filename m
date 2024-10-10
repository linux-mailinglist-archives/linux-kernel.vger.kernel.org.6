Return-Path: <linux-kernel+bounces-358944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 672AD99859B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA32B21E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610651C3F2E;
	Thu, 10 Oct 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOgHlTRF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF61BD018
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562200; cv=none; b=inhpC8v1gV1h1+dmuhSQpUVwZvaPYy+Y3aJGCw1Kz7RyoUYe4oqVxZWknXrqzJrWNJuNFGv9+x4+MS2TvIj8zwQeFeaUr+0oTdfpvnAiNdaA0PnKPS3SdUwr+vNU6kte7c+3Td5NsmhGH8HOIVgD7T5oCVJ03DF2SRR3BAndJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562200; c=relaxed/simple;
	bh=aW0SFmckV67IduRMXCaEXm4aQZLIjm4A5Gwd4KCgguk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GaPjw5nd729z4JP6Gmaf2t93zuPF3z/oo3Ohzwp3FZDb3S5OKMG56wbs4AZh+8l0uUQZTAJZ9Tm3W/3cjYcvusGYDrzfn1sOG+DIk/2RXcxaDdBMEO1ApQmc9HWbriwJ/yULHig8Qc0u5zQzwXcpZRkaEBhMv+0w9J0wmdiD1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOgHlTRF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b49ee353cso7050855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728562199; x=1729166999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uToUyv1Tn3i0V8tUilohK5/CS3wyFdpI4TShRaX1RA=;
        b=BOgHlTRF2xWvk+MbugzY381KdhxjyD5cJN6vysReAuwaiKk1+Y73gpPbiMetdEyVH2
         qbKpePhIwavUxUpjR2jaeAiPlJbDuIvHUgx0gxTU7mqLgGWTSZVB5FLgJH05hTZHR55G
         j/MpTFl0pcT2tNZpU+MSHLRb80oxdfFwUcpuSWYbDSB2bQFkt5iU9HBXsHlKKgBg7qKb
         FepyQexSvLSK3NUmBI9DRIekRluNHp+rQaFgDIwJH+tbfMo9SedIHqVm86guQN62ZaSg
         jHm+hgZrPlEJxuQIWOyhMRnCgK4zilXa9AT6Usj8frLfa4eljhcl8FOXlCwdOz3z2vsf
         Kzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562199; x=1729166999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uToUyv1Tn3i0V8tUilohK5/CS3wyFdpI4TShRaX1RA=;
        b=dEowWfEuzFqX4YYO39/QkR1R4yjFYOS0ea0H67f0InTlmYVU0YobvndpRv0zUZhXtR
         VELyKMge93/By4cDRxCKpeDfhno5q04OCZw3asWDDq7Y2sdO7PrG/qkiw3FBFdmaFAAl
         PBNK1p+WuFi8cnzuktR8QTY5Ldiii6LWSpHT7TkbKV9OudmfdBi3m6WrVmbMz/mbXT1x
         wrKJCla2h+I0sVr4krIiagZsZU71+SDhrEt/GKpZI9NU8LHXxKCZTI/Ja4ucU+MN6ji4
         o+PqjKfimp5S/RrWoQ8cl67fqhBuZRjbQYIkpGyE64h1p1D5VlMX5Dv9XqtdY2YLHwgW
         SE9w==
X-Forwarded-Encrypted: i=1; AJvYcCXFf7Wm5/xy+3g4B9qsT5WFSYbUxS1caSJoGGqAcc3KfUwdPPCX7EXAakY7RGf106i/r2oavniikC5cHPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8p+3YtK6nrXpygpt00y3AoKtNLRu5cdLMkxr2xj4Vp51rGXAA
	zEKz+zR0UvNLZQKmGGPMYn0EK3APBOSoWsLI8/r+RyFR4da/kzJBHC77giRN
X-Google-Smtp-Source: AGHT+IFDS5d+AboBnYWrSLCBixB9EGeFpYM3d2sk/ej8q98MJc0L1bfKF0yDUsRBE9gbrVPmMXhaGQ==
X-Received: by 2002:a17:902:fb04:b0:20b:707c:d688 with SMTP id d9443c01a7336-20c6371d8f4mr55024415ad.18.1728562198709;
        Thu, 10 Oct 2024 05:09:58 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c2133besm8456115ad.211.2024.10.10.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:09:58 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexjlzheng@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH] mm: add pcp high_min high_max to proc zoneinfo
Date: Thu, 10 Oct 2024 20:09:36 +0800
Message-Id: <20241010120935.656619-1-mengensun@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MengEn Sun <mengensun@tencent.com>

when we do not config percpu_pagelist_high_fraction the kernel
compute the pcp high_min/max by itself, which may be not easy
to tell the really high_min/max.

we output the pcp high_min/max to the zoneinfo

Reviewed-by: Jinliang Zheng <alexjlzheng@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 mm/vmstat.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b5a4cea423e1..1917c034c045 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1791,13 +1791,17 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		pcp = per_cpu_ptr(zone->per_cpu_pageset, i);
 		seq_printf(m,
 			   "\n    cpu: %i"
-			   "\n              count: %i"
-			   "\n              high:  %i"
-			   "\n              batch: %i",
+			   "\n              count:    %i"
+			   "\n              high:     %i"
+			   "\n              batch:    %i"
+			   "\n              high_min: %i"
+			   "\n              high_max: %i",
 			   i,
 			   pcp->count,
 			   pcp->high,
-			   pcp->batch);
+			   pcp->batch,
+			   pcp->high_min,
+			   pcp->high_max);
 #ifdef CONFIG_SMP
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, i);
 		seq_printf(m, "\n  vm stats threshold: %d",
-- 
2.43.5


