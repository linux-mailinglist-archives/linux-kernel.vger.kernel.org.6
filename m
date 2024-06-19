Return-Path: <linux-kernel+bounces-220646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14B390E4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9941C21FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ECC77F12;
	Wed, 19 Jun 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sZ6nBALH"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938167B3E1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783395; cv=none; b=eQPhyJgh9mRrDbS79/cB6B8YYHmn9+YDDhtnK51Rjjx/bYpWiyudofipEFZhuTh9NwS+b6Z/JVyjjXo/z4egbfsrcfvirBLmy9phUHPCfSzU6i7wRzYfkQwmfWYC+nZ2iA9ZQYWawt4DHQ8qq5gXAdb5dy6dMP/QYJlLRQsr3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783395; c=relaxed/simple;
	bh=fXdRBgLdszDmRS3sVpisuU4SX1OPQQAvA6yd4EKdQXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bq/a36HjV4+/Pvc9tYrNRGi+00mm7L/ejJ+rPLymhm+wvPHeyLHTgkgF7vC8wETHjBj+RmqZAuTlk8ClAk7EAmsQjBmBqk/goziIc38E+ndeiNr/6981Oz7Zyz04YYY2XgFZEZ/NJxHp5707AfC1PcSJvgMWAXRUDCm1cxCm64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sZ6nBALH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 76B5E3F2B3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718783391;
	bh=+Z6PIWkhLWvItlz4Fqmv/v1cM41RjY2eqsQ7JQg3TVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=sZ6nBALHlx056d9Lv09vlvluguvFoKiwMgadV8h+lAo/XaBGR3cULWjfF63jlDAF8
	 Dxoj5BppvmOOIut90pkX9HU8kvDiGWMTmo1VdU13SSP0XUikzZJby1rmPGu3ZmnrFq
	 1oScB43sZq3Zt2WOvsErmFtpzR1tL6KQy+LRZaJ10XTGhbEPaKcGNYWINN6tZfPwfF
	 NYhI3gu7qrcJcDkVqJfJ8ttFqgqS7YvEPItN3wEMCuxRuQV+H7RmF32ENGK8SOzbvd
	 NSdLr4XmcXQHRLjqO6jYK2vE1GLSAK4C1lAy1tplhrINkgulns0vouvntM9HeKAJVs
	 sSv1EAiM4Jz0Q==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-705f9efa07aso3988100b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783390; x=1719388190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z6PIWkhLWvItlz4Fqmv/v1cM41RjY2eqsQ7JQg3TVM=;
        b=KqMiKYoSEG+1xjyuMGYCQuiSuHbwwg71mdd82fu/Qc1I09rff9hW6wEthfF8/amjZz
         BoWJzGKTzqkuV2LySIJWeCUqC/LqhSBFvC9/fSdBwgEpKRyD2WVt9Jhbyt6TinTOIczo
         QrRRuRXVD4Wv54iYkjSdSQ9pzIkwYkMZjsyf3H5iSpH2qbeoTaT+s8+B42U5T5oexXVT
         njiayFe//6j+vZtZyvCse8ANcqjUEpc6xHKsu1HIBpWjXzMl1dRBPbXUvjOeJIh/a0vK
         G28RzZpYDENpR8Lm/OgEXg6ubUA2kVDiPv9x2dgZkNRaH4HHORhNCzi95pewZEIVA/sh
         tHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrCA4zgHNO0UMdCAplTIAffHm40L9Lhbj+S2CHmeL73xLesJA1Fi3nrvaQS3+baxO/LUUE6dNs7bkrHSLgagrvY1EdX9/oghS8j+9s
X-Gm-Message-State: AOJu0YxdWSOSMjh5NCVchoFpqPMiKRqf017LaodmFzsOUR7uWZkHKhys
	+cEyNSzM4W1mbmF40newGIhZyOZt8EbMl6XMcWVNKjH0JjeYZgJcqhUCmToRgrpjDgv1bvuhDIt
	XNMkNxkak/se+XW1KoLoxUKPWQykYYWDDPTwBESOIX91sPYhruAapLqSeFS76UGmxg0TdI+EGwd
	7GWA==
X-Received: by 2002:a05:6a20:3219:b0:1af:96e8:7b9c with SMTP id adf61e73a8af0-1bcbb5e2c01mr1830067637.47.1718783390168;
        Wed, 19 Jun 2024 00:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1iF4A/y2B2hwDQfIT/eUeqxoyRy14g5sQYr2UmEdpWhzAQpQaAnzac+jnykGR3Ot6xCIhJA==
X-Received: by 2002:a05:6a20:3219:b0:1af:96e8:7b9c with SMTP id adf61e73a8af0-1bcbb5e2c01mr1830050637.47.1718783389848;
        Wed, 19 Jun 2024 00:49:49 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdc6sm10076908b3a.138.2024.06.19.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:49:49 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Peter Collingbourne <pcc@google.com>,
	Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] scripts/gdb: rename pool_index to pool_index_plus_1
Date: Wed, 19 Jun 2024 15:49:11 +0800
Message-Id: <20240619074911.100434-7-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
References: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter the following issue after commit a6c1d9cb9a68 ("stackdepot:
rename pool_index to pool_index_plus_1").

(gdb) lx-dump-page-owner --pfn 262144
...
Python Exception <class 'gdb.error'>: There is no member named pool_index.
Error occurred in Python: There is no member named pool_index.

We rename pool_index to pool_index_plus_1 to fix this issue.

Fixes: a6c1d9cb9a68 ("stackdepot: rename pool_index to pool_index_plus_1")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/stackdepot.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/stackdepot.py b/scripts/gdb/linux/stackdepot.py
index 0281d9de4b7c..bb3a0f843931 100644
--- a/scripts/gdb/linux/stackdepot.py
+++ b/scripts/gdb/linux/stackdepot.py
@@ -27,14 +27,18 @@ def stack_depot_fetch(handle):
     offset = parts['offset'] << DEPOT_STACK_ALIGN
     pools_num = gdb.parse_and_eval('pools_num')
 
-    if parts['pool_index'] > pools_num:
+    if handle == 0:
+        raise gdb.GdbError("handle is 0\n")
+
+    pool_index = parts['pool_index_plus_1'] - 1
+    if pool_index >= pools_num:
         gdb.write("pool index %d out of bounds (%d) for stack id 0x%08x\n" % (parts['pool_index'], pools_num, handle))
         return gdb.Value(0), 0
 
     stack_pools = gdb.parse_and_eval('stack_pools')
 
     try:
-        pool = stack_pools[parts['pool_index']]
+        pool = stack_pools[pool_index]
         stack = (pool + gdb.Value(offset).cast(utils.get_size_t_type())).cast(stack_record_type.get_type().pointer())
         size = int(stack['size'].cast(utils.get_ulong_type()))
         return stack['entries'], size
-- 
2.34.1


