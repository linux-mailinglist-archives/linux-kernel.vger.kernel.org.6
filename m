Return-Path: <linux-kernel+bounces-242433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98B9287FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1DD1C22BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60196149DE2;
	Fri,  5 Jul 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr37/KRK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0C142E76
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179098; cv=none; b=EvFQYJ1HGirob6a6rEeuij28e3gPXkvy0kkHtUGKtzxhTu21UB+kg3WAbPsttKNYpPzR6fRm7T9syBGaQuSCEA+8BWswXI/x1terEumvRO0RZklMBYxaq2+diImidkKR1qzdJZtNVpF2KaIdMECnlTQFvAaz8SG8DH86W/8goqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179098; c=relaxed/simple;
	bh=AVrKPszl2rRrwwzdGoDSi4jkGIviSvziWQqJlFjpGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocCCUfWkMmH4xUUnCHtA8NFO1Xs00IzXJjMnHuFaM3amLeJ3/gQjFAQO1D4EymTifLRFsa2SykpHTMWX2G6783XYo+r6FP4j2PXrYz6uw8rqkqmzzNqvIzy5XJPMJF0G1mvt59Pjp8A8PKIoVCfuI4Sd/ZVPJv+O3wsAjlYabP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr37/KRK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso9406385ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720179097; x=1720783897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXpMesFOysqjQmdIZBXmi/S8232psTHkbVyhmtrB5Q=;
        b=Gr37/KRKYRQdEh69vz+rPmw33Sn3Vn4K/ifWyXQ+cYA48DSHpRVPb5QWBdlrBKcyW3
         8Q9DVWS3zhEUU+QGe4ouSndVNg2vyJIbg3ALdav/saOtEZkkx/3q4gy7QMmr4GU5ZGxT
         n5SIbzBGr40WGLECh9/Q96TdowT25pyAsKxLiHxE3MhXGfE525biy12JRlC6dnJElKGd
         F3i8kxyCmIQXihiwxTBxdPum2D+f6GLVUc70WYRlCw+Tln+NZyLKAjGTtZhRBw8Dwv4o
         49h12mI6Cr5aX5sifAhVd84zEEomSuvwERSk8IBEKM70iV65Dyv3d6S4FsRKzlM3+9S6
         iUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179097; x=1720783897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tXpMesFOysqjQmdIZBXmi/S8232psTHkbVyhmtrB5Q=;
        b=vklBG+JTlBBv4HADpVBTyDVZWhI2fgJVgRjstRDCdXHS/RCpzUdFow07CCdkQv6c8r
         5n4ese7zDNPo65T3GsCDokmjO7LpN1wEA7uYCQur6tYrXbmEqHfKkyfRYdx3EwSsuHSm
         5Lb+HuvZ8FqWCG1Nnx9j20Gd0Q2cIJpEueEX5nJ5sd2anDReDJhcJGeIA0aGOzGPcGpA
         6c+WxmbSVIxraysNq6VyJZya+wqNEj2bEYm/YEKhpgFKOqsqOa9CvQauFY5rSk+17SAg
         nZ/GEqQ9jduGLDDgLeOCVIbvljueeo8nj/LwYqSUddESZ3xrN0qq+dSCWLg/9/GgM4uG
         maKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWZ5Lz4nsaFyb/Lj483Y3D27DY0zNSTaAbS01lNVvGV5GDi37QfUTuRItGmFZd6FNdJcIDZ/vkhjx/v9O6Y35vIfoWAd+84hUL+ClZ
X-Gm-Message-State: AOJu0YwDGtakkRa52XZQ3Eka91k4OCaOOQrzdZ5OJDwMNO1TSXvoL+Oo
	sM65e7PWmn2pQk6zI9JWclTBcllH+nmgQar6EnrY1Xtk1ofVsC3X
X-Google-Smtp-Source: AGHT+IETeKs74PjP9sc9Th/Pog9gWp8PldcnmgzKsxBrqPmYCfbWxc8MuoSqX2HCLAXoT528Vs9D+g==
X-Received: by 2002:a17:902:6805:b0:1fb:3474:9527 with SMTP id d9443c01a7336-1fb34749830mr24634745ad.25.1720179096537;
        Fri, 05 Jul 2024 04:31:36 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb167c6a34sm49698415ad.241.2024.07.05.04.31.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jul 2024 04:31:35 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ioworker0@gmail.com,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	dj456119@gmail.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mingzhe.yang@ly.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
Date: Fri,  5 Jul 2024 19:31:19 +0800
Message-ID: <20240705113119.82210-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAK1f24=wK9Gpt71NtVCyM1RRQF0MDmhm4MViVj_gPx_+ywks7w@mail.gmail.com>
References: <CAK1f24=wK9Gpt71NtVCyM1RRQF0MDmhm4MViVj_gPx_+ywks7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Could you please fold the following changes into this patch?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 993f0dd2a1ed..f8b5cbd4dd71 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3266,7 +3266,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	if (order >= HPAGE_PMD_ORDER)
+	if (order == HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
 	return ret;

Thanks,
Lance

