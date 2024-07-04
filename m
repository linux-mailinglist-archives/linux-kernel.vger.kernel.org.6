Return-Path: <linux-kernel+bounces-240385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C9C926D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7551C2177F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B69168DE;
	Thu,  4 Jul 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpRWV8FZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE1512E7E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056580; cv=none; b=TDXpVi7d2ns2SAzdZH2xO8l6+FONzO3h9Hqh7LBfgeUJlI/IfYmGE98fpXudwNIVDtCr8ZCexF+5FCrqB6nH6cg4sTN1bxZTxj7JqYrYIe2//TGXhkbnDtz+D3cjB2dVb8Z2VsWSTa5MfQ0/MxFA6rR6V1kLnjida4H0sGQuLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056580; c=relaxed/simple;
	bh=LU/LafobfTgNIX0MyQnzmm5MPJP0lywWJfdCihEy1uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBluhJraybB4an9RE6G/oWfQZpOIPWYjBzBbY1vwX3KHrA2DWIVDuf0hqoC8PaRXrOoq1TYAWaJcBuv/3On2plNYodVP1m2yhjAWpLlgwe/FuAM3jF08fd0w1uIn34/7HpxIvl1tkUw8ygpOfR0zItkMn5uU5Gf7EUTfTd87+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpRWV8FZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1093615ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720056578; x=1720661378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTYAZdivsHjBzXP9vp5pmO/cchsVNESwksg5bZfIdNg=;
        b=GpRWV8FZd4Houxw4icUBF1OVaocGoQK0Fj81INIHoN7y9NjbiFhp3FHx43ToV/X4vh
         gkUPJ0Kvsi3Txkscc/0nfwhBL/k5Tn6PeY0mC7ib8VyALj7z01V5htwwbuMq9jff8fmG
         gXHMAJ2kdk3idRxk5bTWHIY9rm241O917sg04oinWxMZ+zDUTxs4xSGogBIL5UJzWBXT
         PnBHfHMkpTkCZIYgQkNPfHZJWiI55FJ6QLWpbgMQ0p2nj5e8WdhFtwNka7aPbxIkTQkd
         MosinobgyChwEaKbQfzNv8c9CLwrQkVsOe3CWs6GgAlbTgiNc5ME1JZ6t3Oxu2AcEwBz
         BGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720056578; x=1720661378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTYAZdivsHjBzXP9vp5pmO/cchsVNESwksg5bZfIdNg=;
        b=PU06t7Sk6JX5EntyDSklbhc4lMgin0FEbnrbCXR//MKnxQ2AfNaQtP6MOt38woJggZ
         KDO8rVuLghAUbDXiBo4E3rlQ1IUBK43/SOpPnugnL8mVHwzJmGrk/85nalGg6yYGy+Px
         7D507Ccl8MawoEEEhPj1A6os9++dEEcqvNDZiYotMCf0xt3iz8lDrdIQW5H1QO3eoLpL
         V90tzCT6TwKC1xL/bUEnSLvmqvGNKS+03GMiOpPN3aLOc4q2+AqCih5hG8a19Ok554N7
         RJLweFWWSXfthFmKVagMSO7RqLirvPsNbkNjVRw9AtvlcAVwFfBHORBLwwXaWRvqDjvi
         kyfA==
X-Forwarded-Encrypted: i=1; AJvYcCXWrZXDjNeiUv8yS6ABv8UAAiHIfZ4F527nGmN6zDYVnm4QnBXP7nXCiR4Ap+hzg63b4q25iit45TKiL3Yn9U1Lfol646AR+F/WGowh
X-Gm-Message-State: AOJu0YwqPbZaOzl4tVR0FfpJHjZ7ZoxaIXhVYKvGEARfO/bCvpKx6Swh
	ZX4SV8Bov2HaH8DBhEkmH1CniAdKw4vtT8RNa/UufUoXl1XJN/+5
X-Google-Smtp-Source: AGHT+IGY0yPT+zHZTfE83IvT3tjkGOP/4CZzxM5op9vPgkY0O7Su3xXQfWK8rAUNvo6/V70lKKe6OQ==
X-Received: by 2002:a17:903:8c8:b0:1f0:8c5e:ffdd with SMTP id d9443c01a7336-1fb3440b4d9mr3459145ad.4.1720056578292;
        Wed, 03 Jul 2024 18:29:38 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac153767dsm110162735ad.148.2024.07.03.18.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jul 2024 18:29:38 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>,
	Barry Song <baohua@kernel.org>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v3 2/2] mm: add docs for per-order mTHP split counters
Date: Thu,  4 Jul 2024 09:29:05 +0800
Message-ID: <20240704012905.42971-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704012905.42971-1-ioworker0@gmail.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces documentation for mTHP split counters in
transhuge.rst.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1f72b00af5d3..0830aa173a8b 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -369,10 +369,6 @@ also applies to the regions registered in khugepaged.
 Monitoring usage
 ================
 
-.. note::
-   Currently the below counters only record events relating to
-   PMD-sized THP. Events relating to other THP sizes are not included.
-
 The number of PMD-sized anonymous transparent huge pages currently used by the
 system is available by reading the AnonHugePages field in ``/proc/meminfo``.
 To identify what applications are using PMD-sized anonymous transparent huge
@@ -514,6 +510,22 @@ file_fallback_charge
 	falls back to using small pages even though the allocation was
 	successful.
 
+split
+	is incremented every time a huge page is successfully split into
+	smaller orders. This can happen for a variety of reasons but a
+	common reason is that a huge page is old and is being reclaimed.
+	This action implies splitting any block mappings into PTEs.
+
+split_failed
+	is incremented if kernel fails to split huge
+	page. This can happen if the page was pinned by somebody.
+
+split_deferred
+	is incremented when a huge page is put onto split
+	queue. This happens when a huge page is partially unmapped and
+	splitting it would free up some memory. Pages on split queue are
+	going to be split under memory pressure.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
-- 
2.45.2


