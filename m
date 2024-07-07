Return-Path: <linux-kernel+bounces-243452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53D929648
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D71F217CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9F28EA;
	Sun,  7 Jul 2024 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc7sBhKM"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BD136A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720316262; cv=none; b=aykR4gODgNpcJYFtSHXglOailocCYhKCDLj9J4jEf2qusmJdw8tsckHB9klBGUp9rQacsz64djRV8+9Gmwd3FtCJClhWZGdBy7Cy2B4lnA4+ITfoqBqQ8H4MKm2QH+7DlolHa4LwhFyxgH98tHg2X5+YfNt2TCzk4+Cb5AfmF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720316262; c=relaxed/simple;
	bh=i4OJnuFjU5D17LlvlGu+RARI7rZTs6J0HAiqIAMsexY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kz7yYZCF+Ji4+7X/ec4zUzh37bMItzcFj75EC6XhtdJMRe5fJGIb7mkMjdCWw9y+u6DDpST1Yoc6jMuoXVNO31KBzdDqMo0lt0mPWBxfUaN0ld5nW2uGvuDjFiYPubgMjMYxM9JIeYF9VSiwEzcCWRt2KSF+WgyAw0Pzk5ibu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc7sBhKM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af3d9169bso1783948b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720316261; x=1720921061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnmnKzS0MqQjJkVIzx0uL8WK8vRtoDuAmz8drJ9JhLw=;
        b=Qc7sBhKMeLmk7b5JSYJdGG5EeB/mUJguybyPPysTtbXNWmEss9G1i3Cbt64Bi2F/Z1
         skXvAh32qbbXFbR1w10W/rXfczg7S/x/lMnW+hWUU/zZx0KLc4BgicZQIFIQziI82H/u
         yqC9Ie4MQhyqwWWHSbFf8Gi8Zvmw6tNLjQmAmIcrhTjUTnf9bOa8+r2TjdZ2atlJkP4I
         fLPZvT+evARpVcprg4GAMj0+hPBYXG1KFbBcDuIMD6L29zYeuJYoLnsw/JlH+BPF9tHC
         7K3S2j5jdespOBrPbkgF2fcNqicLXmgFaL0n8l1sFHF5xguTIxAhFEdIxZJLPLVjUY8p
         HdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720316261; x=1720921061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnmnKzS0MqQjJkVIzx0uL8WK8vRtoDuAmz8drJ9JhLw=;
        b=Pw+gXtg0cV9ZsqO1JhezDA3gQzwfjeAffwrHAYpdpZcThrt7jRbYVuAOOPhYXfV7Kz
         MwOkp7hm58SCarbISgyKDtMWoaQT2m4f6CBYW2hT41RmPzZ7k+TGd7ZmmMf4cHdP6Aae
         FFMj6+tNgQOkRNCrb8siqsQxRFUy9j96rqJ1z5/hhHFXHAwZR62sRYmgBsYr2Tf8eOyC
         WWu+xIn4ldJRUV2hM3G2L0QP43AlTSyIT3BS4md2ybDm9HyfzEWzH0zyvq0nanZvz4HA
         UOVescs0M3viM8bXSJEHaFdorYDl5YwzRgWaio7nMHDp6B0rb0rnC6DMmq1xI6QwH3TY
         X/0g==
X-Forwarded-Encrypted: i=1; AJvYcCVNxux6kUTRt5xShxiYjCkGjLO46HA1TjcEujfq2CIVgn646Y6MXOC1s03w8CRpH7kCztUjtYs1I8OQEv59dfpKqXRt4ywuDOx4O5rI
X-Gm-Message-State: AOJu0Yxc1TzZQ9WC8CC5571kNl1nOAt7kjYKt4FpzQjbuGfG31CyHqBz
	A8/Xwbv197b3i3SzfmVc/xbG88qi0DJkW5ZFftCUQ4EdbFOf2hToF2As5g==
X-Google-Smtp-Source: AGHT+IFpCBjDL7gPHbh818KuoaEfT1fK1KoMm6EqG2GWgdksUPg1xa5qrR/h+FOd+kz5WCZzw21Tow==
X-Received: by 2002:a05:6359:4587:b0:1aa:b8ba:8e with SMTP id e5c5f4694b2df-1aab8ba0370mr327529955d.22.1720316240013;
        Sat, 06 Jul 2024 18:37:20 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:6::3052])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a984507sm5642635a91.32.2024.07.06.18.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 18:37:19 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ioworker0@gmail.com,
	21cnbao@gmail.com,
	baohua@kernel.org,
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
Subject: Re: [PATCH v3 2/2] mm: add docs for per-order mTHP split counters
Date: Sun,  7 Jul 2024 09:36:59 +0800
Message-Id: <20240707013659.1151-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240704012905.42971-3-ioworker0@gmail.com>
References: <20240704012905.42971-3-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Could you please fold the following changes into this patch?

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 747c811ee8f1..fe237825b95c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -513,17 +513,16 @@ split
 	is incremented every time a huge page is successfully split into
 	smaller orders. This can happen for a variety of reasons but a
 	common reason is that a huge page is old and is being reclaimed.
-	This action implies splitting any block mappings into PTEs.
 
 split_failed
 	is incremented if kernel fails to split huge
 	page. This can happen if the page was pinned by somebody.
 
 split_deferred
-	is incremented when a huge page is put onto split
-	queue. This happens when a huge page is partially unmapped and
-	splitting it would free up some memory. Pages on split queue are
-	going to be split under memory pressure.
+        is incremented when a huge page is put onto split queue.
+        This happens when a huge page is partially unmapped and splitting
+        it would free up some memory. Pages on split queue are going to
+        be split under memory pressure, if splitting is possible.
 
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
-- 

Thanks,
Lance

