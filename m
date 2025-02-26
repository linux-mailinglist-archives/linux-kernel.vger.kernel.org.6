Return-Path: <linux-kernel+bounces-533867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A1A45FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ECB3A7C27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9D2163AA;
	Wed, 26 Feb 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQG7TpuC"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7E214803
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573712; cv=none; b=GiGUEDrBKrPM0C/UZ+Z2W6apVanuLcwcrPv7etgI53uCJjYDYWwuE4tVK8QUIRV6DVpvYMFv+BkeqolLby32p0uamZVhPZQp65sYI8y90ZoWAOyi1W5X/CRN6hSInZTv5n9TOgXoO20D8t8ygcERmjBdbmRSqUlrVBo75/XeZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573712; c=relaxed/simple;
	bh=B7gqY3rzkhXXRzZYwagXJRkbPCtNmaxhkrd8b4fdijI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVFY2JJqY/2rVA3bTWcpjlzQtJjjqFPZnHtkmMDP0OKCD7w6AhfDTa448+fSBxFKqMC3hgmCUp0LmegfsJwWTXAkF2hsDyss2gyx7/WKmRq8xWTcOIv2i/IfyxUN8J1EXiS9378DW7PEkHEfiQqW8MlpVM/ehEaPR27wGeDfdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQG7TpuC; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fc8482c62dso1744725a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740573710; x=1741178510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blqLB6w4wQnbPbFc3bZOnIP21l1K7wwHNKfipqUAVLM=;
        b=RQG7TpuClyzK74R6sB/HiUHffjapiqe3WpKV2UPdeMOpN6Pzs6keZvIRBEjVtJJsT3
         3GNr9Uy74SuJknIUHRZLSlFQWeNBsSoZRiukFuxC19UZbMxhvkwA+05HRzquFzu5RR53
         e53WWxA2o5ivoWVOG1fUBGZGDFgteabyj0rGnGzYTMzixnO/lNx/bhudWLvP3yMRC7TP
         VWg7HpBgkrUOr1sT6aQxTR/RspenPMAgWq8mQFeWF59EKNh9FQwoZD9JhTKHDT9u60Ej
         ytNk7HDHM9Q6LCFBkZ4K2ytJTj38E6X0GuD1GKplU7ZOtZvP+XLr624GP727M86VTt25
         4BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573710; x=1741178510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blqLB6w4wQnbPbFc3bZOnIP21l1K7wwHNKfipqUAVLM=;
        b=Zz3TTvbtkfYs3lS+9koM5SGvFGRMxuKEbkqUe98xVM0LcD53oUn+Oyao2xNkO+YqCj
         ZWmtqz0ZwnkfI2xEMktF4qfBe0/+o9xfYZAkbU/SvTdaZuL2/v1nOtsJLqQzFANNbbnd
         5lknwp3hQqKZVm4ODaWzdQoHCo4Cs9Ay0gcRjtr/D7kszI1jx/zjAr+fotcCFSFqAUtt
         qmNmXw01S4G+E0O7JxHRs7BAMGf32xa4znv8qKpIu8VOA217yI9XFhRl+bBDtfpefDo2
         R+42edxiDxB+Jnl5H3xcBhqVDTv6FiFUGyQhIrSuO7e1zJyfmbmAJXAeFZPEeQ+dn1dO
         S9PA==
X-Forwarded-Encrypted: i=1; AJvYcCXg2KcQGnVnGu1xGM0RGz8A3McZ/Q9WcIngw76n9c9us2haHK2A60KifYYHpMTiqV0PtgDj5o8xAhkxjrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdKLrW1Fn25RdbZt/7OHuOgiSWVGsu7wPVzHL9bNNZs/TxJSo
	PL+XWyEl2G+QUCJMdeG6/+yD/NFeIAcBEbo78VzcoobH9b1GFCOW
X-Gm-Gg: ASbGncvVZzNQY6THRLsyAUyyIqp4tptjDl8SW+/zOKerrlkWb/FelVLFQZgoTCkJ5HF
	9KhPm1uc9OTzj0Am9QCoc0pKc9v1773pCKMJFpy9KkZExHH9LOxRaOHebTL/bZaB1GhpyT3oswP
	Rpw+MNOkPDOfLQq3mZgEKvHIMb0GhkRqd6HSyTXHEwBJzkWvsYqw8yVDXIu8BUIG2cVGSc4+4J3
	OkMdqpGC6rNmOj6PhwLTTNGx1hMCiHrykejpoWQFcD6sQwlkjU6yyPjwNK06zQUCv0e2eF1rJLS
	p2jl/ScfQJMp8obGLMghCZMVG/A=
X-Google-Smtp-Source: AGHT+IGi1GETef88liKi7gzcBOHTWY6cN7N2IEM20LdyEUet10Q0YfSxX+BkgfoVaIYcIbV1sNpDQA==
X-Received: by 2002:a17:90b:3ec4:b0:2fc:2078:1726 with SMTP id 98e67ed59e1d1-2fce7b080dcmr13393659a91.6.1740573710227;
        Wed, 26 Feb 2025 04:41:50 -0800 (PST)
Received: from SaltyKitkat.. ([185.2.163.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825bb346sm1390515a91.18.2025.02.26.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:41:49 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: nphamcs@gmail.com
Cc: Sun YangKai <sunk67188@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-mm@kvack.org (open list:ZSWAP COMPRESSED SWAP CACHING),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm: zswap: use ATOMIC_LONG_INIT to initialize zswap_stored_pages
Date: Wed, 26 Feb 2025 20:41:39 +0800
Message-ID: <20250226124141.22218-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is currently the only atomic_long_t variable initialized by
ATOMIC_INIT macro found in the kernel by using
`grep -r atomic_long_t | grep ATOMIC_INIT`

This was introduced in 6e1fa55, in which we modified
the type of zswap_stored_pages to atomic_long_t,
but didn't change the initialization.

Fixes: 6e1fa55 ("mm: zswap: modify zswap_stored_pages to be atomic_long_t")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ac9d299e7d0c..23365e76a3ce 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -43,7 +43,7 @@
 * statistics
 **********************************/
 /* The number of compressed pages currently stored in zswap */
-atomic_long_t zswap_stored_pages = ATOMIC_INIT(0);
+atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
-- 
2.48.1


