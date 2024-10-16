Return-Path: <linux-kernel+bounces-368191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B561E9A0C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A177286128
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DA20C49A;
	Wed, 16 Oct 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9nyEtpd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED001BAED6;
	Wed, 16 Oct 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088306; cv=none; b=l/R3N5kVWfGAQlWTaK1G42mEqHniM5x1kmKhcmAVMcwxzB6pfXmNIj5OP0v0OtTuEfiWMeESrZ2i0DQ1PIhtOHbnm2FeK1ZLsZEwCwCkTAdkmzMJwaGN/3ZU0YIMyOV2a4Kp6h3l288NkhDteMRbyrsjAM7XYYPWP/X3itynvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088306; c=relaxed/simple;
	bh=uTMxhO6j3BYYeLd4QWNWn8AdA0c+ysziLl33AzuKTjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a53NcEucpw32NkA2r82lQ4n1cOmgrdmusoHvc/gYZXlB+zv1xb874fZATeonrFXmKvYqJ/Ff8TIFRw0qukWOXRmX1h6LYlWG82D1LUxEVx0K5rjtPsWx8NJitNPW3wV2ujFs6b8KQ0yGh4gySuDkL42wZ9W2mzcFTcHeEYiUaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9nyEtpd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c78a10eb3so3982935ad.0;
        Wed, 16 Oct 2024 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729088305; x=1729693105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L172NOv3wOkVFxWrfQVi3uOC3mjkd6ZSc2NP+AYeuk=;
        b=b9nyEtpd6BfaDs0d51RXqdDbKtRn1ehnskIQCl5YUo430vEsBcO7fA+IYgdjqIanwd
         8cNNHqVusDK7y3GxXWsvl9gt8BuDHVHYT6hkIV1ad9Vf0Yk2k5my5RcWCBfLbhiAk4yx
         dRe7kI+zPXriweE1gF6BispGZ/edhuclos7iueH70AzniwXDLcMXOZ675x1qaeY7opYI
         ruf2nDGocSnJTaq/CA4xa4rCPr0U7O4af/f7/F8muRYVM5LZq9mbllQFa5a2yG1YIA4V
         ps6ykB8np2kCowneZCJ653xSYmN4VlOIbnbbWxfoUUrFJrBZ8OvQYdzElkC7tFrJXjaN
         DfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088305; x=1729693105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L172NOv3wOkVFxWrfQVi3uOC3mjkd6ZSc2NP+AYeuk=;
        b=CgC1iZiVQP6evW6yP+xj+FnAjqsk0kJJgPJVdLd8jDlSyVuUzhX2DpE+fJ2OTh+rhO
         henWI+KxOgICDlQAWk7YvDEWWj7TOksgna18dkkzoNBN+kjmSLgDnpdbeHfWmLx54haT
         iIg3pRt60rcOokmebuSEr47n6frXVW6fgGvDtbsB2hQ39Mg8LRAkV6jtRfofk8/hsPvM
         r3B7JI2jztv2G+wEROdyaIclGZ4fQgleogfg45Zrro/gi19j5ZCpbdSARiFG+3x0IQq/
         0WvyiG0rABsIr664UJbP0Ep9YFBlzToqDRhq1B4nJni2MpW9enD/+dyE1R5nmTdQ1mIF
         8ibA==
X-Forwarded-Encrypted: i=1; AJvYcCUk5lPQts0zzgqVNgwThKvXZ3FGu+3v6781ngS5y+5hflViXYyym4eOcAKzFK98GJpldQ7shEqzz5UIXQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoOEg8CTn6T0ZCbkkSsasDDrWuOE7cpr4vbY6/TVU0i8vn+Fb
	QsxwQjgn+wL0m1jv4X6KlqekZBM2IeXYKL/6SIEZF7QTLSHNrSzD
X-Google-Smtp-Source: AGHT+IHPGGb+g5HEat8gSILYHLGH4z8wOJBmz+/sWj1hsAd0a2ZM8myNjQKEoVvGjnmLdCx1NEELmA==
X-Received: by 2002:a17:902:e80a:b0:20b:7a43:3693 with SMTP id d9443c01a7336-20d2fd0b0e2mr17083795ad.1.1729088304804;
        Wed, 16 Oct 2024 07:18:24 -0700 (PDT)
Received: from aizome.localdomain ([36.170.32.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c033sm29057045ad.214.2024.10.16.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:18:24 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev,
	Pengyu Zhang <zpenya1314@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v6 2/4] Docs/mm: Fix a mistake for pfn in page_tables.rst
Date: Wed, 16 Oct 2024 22:17:59 +0800
Message-Id: <20241016141801.25487-3-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016141801.25487-1-zpenya1314@gmail.com>
References: <20241016141801.25487-1-zpenya1314@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly calculate the pfn value as 0x3fffff,
which should be 0x3ffff instead. It is obtained by right-shifting
0xffffc000 by 14 bits.

This patch corrects the value to prevent any potential confusion
for developers referencing this document.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
v5->v6:no changed
 Documentation/mm/page_tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index be47b192a596..e7c69cc32493 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -29,7 +29,7 @@ address.
 With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
 address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
 and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
-at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
+at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
 
 As you can see, with 4KB pages the page base address uses bits 12-31 of the
 address, and this is why `PAGE_SHIFT` in this case is defined as 12 and
-- 
2.25.1


