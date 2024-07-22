Return-Path: <linux-kernel+bounces-259397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F0939540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEEC1C217C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4313C684;
	Mon, 22 Jul 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FNz0AoGf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01951288B1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682880; cv=none; b=Umj03Ma+mwoseKcbgGIemtfCGlZIXfj1YtsOF8Cu3Ean3nxVMPwOwxs/kng9LRH+vsZ9wRmztkBigjB55KQqF5XQbhiSbaT3G/1HnnXbEltRI7o3wmHyTTxJBgz1uoAHErXpv8BOae4cJIxLxmJW5VfZeu6qT+N38WSa2EGVjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682880; c=relaxed/simple;
	bh=r9kLVIViVucIerQTivQNa2tjjSeW2pCf16/nfvHRyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqkfMSaYKrGSglsNOZU5aU1zV5uZVOtrVVPpzHbVJbrVbdxEWgf4uLi/zPE5XTtRVEAGflc+9Jxhm532DUqNG109qtB+cCGrOCKo8kmxGPmnLPwlZ6WMSUb2MTLt3xe+kgfzOcUK7HyujqRajhVM3VXwujWyihyR4Q4zn+J1oEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FNz0AoGf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd640a6454so23922505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721682878; x=1722287678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=FNz0AoGfwhktiB6dLrCdmTdz2b02Qlvaye7fVNuWHjzdanm7j7JluyFLE/yqmEkWKR
         Avvaw8Ql5xtdP630jmpmDVAFa1aNE3vtXGmbDLJXNwaDewb12IXkXv+d48wE/Otd56nE
         lOrKQ/fSNkJMlJ7bHmhxV4SYGPgD/t7oqcNjHc6xiHoBpzfgzm0FAh2ZMHz87agASTZB
         G7iHrcZsD1CLzhKW0qFa+FDQagiGQDcO9omhEixcFq99Zj9VTL/KUJfuMrr14OwM5HHF
         YdK6DzYN9xzaRY/0SpOPATrtioSHV6QUtLQz3uwSntYTJxVsNk7aI4lw1Q1vPXy0Oc/O
         +Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682878; x=1722287678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=giA1nxjk7mhIMa+hNU7LN+nrLggT2d59T3xfuPKGfLmfZScDF+GrSbNYgGqgzpaZvh
         9zhYmbWwpVLR+R2MWDnsf9BWdxSCMXqpdmNE6i5Lw2OSeooNVnG1STVF3Ug0hcl3Kgf8
         cf6XRZbjoTPbhtvSMuBQNn/764j/mgaCLwojYMI2Rz8ISL6cb4fgvjf+x1IoQyRBbc5c
         OO7gBH06+IbZhoFlgiXf8bMnR0ICXhqoz33FU8i7RQ9KS1wlYBlxQbdn+xw7IRcHcDiL
         COqFL1/ZEtdcLdy1Kp5gPGw2Jb1KkNnSLBoNZ76smfRwUH6nlQeHc3JtwcSkyVSVsE6Z
         ZWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZF5hp1DU6rraA0YskK4kiZbS2BbN2j118wFgsVJvaMqVZ6D3suxj5JDHDjYbim5hUmR7xUAk9WvpwWguQRt0OMulw2hx7nsAuOvAd
X-Gm-Message-State: AOJu0YxyNKmR82mGxfNz+AX6WH+eOSRA1qdrdni2tocw99HpVvH+jFDP
	ePQBY3vHpM3AKVf5MCJfC8lyvQlhBxjyek47kepE+ooYrqno/1TRGdo90GZ73j8=
X-Google-Smtp-Source: AGHT+IFPsa5+oGIc1rmg0F4U9ktMMqPmuRltbe4o6v2Y2hW0kkM0DVDIXg83Ar/+m4XCxk1tPexWZA==
X-Received: by 2002:a17:903:190:b0:1fd:7fac:a539 with SMTP id d9443c01a7336-1fd7facab28mr46391415ad.16.1721682878172;
        Mon, 22 Jul 2024 14:14:38 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f28cf4bsm59522205ad.85.2024.07.22.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:14:37 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv4] perf tool: fix dereferencing NULL al->maps
Date: Mon, 22 Jul 2024 15:14:30 -0600
Message-ID: <20240722211430.61427-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
thread__find_map() could return with al->maps being NULL.

The path below could add a callchain_cursor_node with NULL ms.maps.

add_callchain_ip()
  thread__find_symbol(.., &al)
    thread__find_map(.., &al)   // al->maps becomes NULL
  ms.maps = maps__get(al.maps)
  callchain_cursor_append(..., &ms, ...)
    node->ms.maps = maps__get(ms->maps)

Then the path below would dereference NULL maps and get segfault.

fill_callchain_info()
  maps__machine(node->ms.maps);

Fix it by checking if maps is NULL in fill_callchain_info().
---
 tools/perf/util/callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1730b852a947..6d075648d2cc 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	struct machine *machine = maps__machine(node->ms.maps);
+	struct machine *machine = node->ms.maps ? maps__machine(node->ms.maps) : NULL;
 
 	maps__put(al->maps);
 	al->maps = maps__get(node->ms.maps);
-- 
2.45.2


