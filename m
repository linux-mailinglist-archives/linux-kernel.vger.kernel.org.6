Return-Path: <linux-kernel+bounces-259320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29013939415
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC2A1C216E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A0170826;
	Mon, 22 Jul 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ONH8jy3V"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C41C695
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675949; cv=none; b=iTEV978VG7X2qLC7HS/hSOSOq06az0odUcPX1HqJICX4QQ3PhQ67qoMiZ1iC7dgTQpKLAfyM5D6AcRhXewozWuEHpj1htrKT7vwBlKK2yB28Y2bkF2jkImESlgwQoYMjT6sqnymu2bp9iefn4a95e/k+7kHwTfUPoF5oac7UlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675949; c=relaxed/simple;
	bh=r9kLVIViVucIerQTivQNa2tjjSeW2pCf16/nfvHRyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5fziXB7gKNkKt6DYA1ibPNJNlxNDPoO0eIkrA+0oMz+oR50V/JWpG+VYZx5gbc9cLiG2HdJMBqVbkeLOzEhoc8UOVNS9cMVJoALNtN/D2r5ypgpA0yUmsyjQHDb8cGs7JDWMOmE7h9S2jbgnMiLIFELZiOHaIq7n60W0p89soY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ONH8jy3V; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so866926b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721675947; x=1722280747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=ONH8jy3V25IoiZHCCYPQcyihE8719DX1Pp7lIkrZmbxEKnu9zyG+qYdH4jADVOLSm6
         5CIWGsQg7Oh5GtNbQLH26XcAqqEOi9O74Q6hasl6EVpM9uq+CxH4gdVacgVUOipMgoVr
         mzzyfGqCK1hO3Cqx7KKWEMETv8yjxnQ/FoXCjBZgzeWh0SoQ1irkbLDtsa1DUc9wL3sf
         D4ieEzhcp2Bq9eMdRbiHop9stks0ThHje4v+lZMNwdAPw4ZAfM3xw7soneWxa1dVOcKv
         rUHbg5PQgT6LXv9x9UOn/xG3VxGj5XIdMTaT6ldMUXC/ZgjM2+gSxMD+1gMlWZ1FjDER
         a4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675947; x=1722280747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=VXN178lSu1wil+IJxKdULt5kSlR6qKtJZEEkjd7xwmv22QW/8jTKp0G9WHlgUuZrJn
         u8Rzxa8GASMdh/N0ubgg26pZifEV8at99xUWdR4I+UfJ2mrvu6u/jk8BM+/jI7KkniLC
         bF4KonfXlLFrQ7iJbQayT0fG/V1gPq6eBJtaCmdwOt8XVLOlYOFcg22YuqOChiyuKp+b
         pCZwa4MSmb35uA09lg7ejPj6H43p/x9xQda4k5XjSfFYtRI7mgTeR0dhXzR/adEbZJsx
         MYFU/mbK935C6sRlfH+j/DcZNyeNiA/N17fRObXB79fGEOBhnBMuwM5wT8yq3tBYyYl5
         IHSg==
X-Forwarded-Encrypted: i=1; AJvYcCXsRBKqexNGaAL9yTZgxAwYi446s38uH73662pS37wQJNVaVAkKzVpXgjFwfAfmOJ8XY8pgPEFV7esvC9tlFLYLRHyNMGa3QOPCKrip
X-Gm-Message-State: AOJu0YzkDCJ+0sJbxZ22VdW0nlY33uv5kHxsPwrVhLKqL9YMnCSH/eds
	2AtN2Nv4GLts5jHPGSOHs5wW+0kk04hTjGE+XEle9wfIRbvpLEYyl6VLi2lebus=
X-Google-Smtp-Source: AGHT+IF+6ezlAEacxRcRnQTAh+ST7ge2mD1E/qoknXTm8h+8a0i06zt6N8Y3TJNeGHwhl804Jsw0PA==
X-Received: by 2002:a05:6a00:3989:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-70d0f176ed2mr5620185b3a.24.1721675947389;
        Mon, 22 Jul 2024 12:19:07 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70d156a3891sm3534133b3a.123.2024.07.22.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:19:06 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv4] perf tool: fix dereferencing NULL al->maps
Date: Mon, 22 Jul 2024 13:18:58 -0600
Message-ID: <20240722191858.123607-1-cachen@purestorage.com>
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


