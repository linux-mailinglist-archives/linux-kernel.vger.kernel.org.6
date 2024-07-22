Return-Path: <linux-kernel+bounces-259399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B549693954C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5136EB21D35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7105A2E646;
	Mon, 22 Jul 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SJoLjlJf"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B78F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682958; cv=none; b=ska/FC+nGrJaaPdvpjwjjDv+/z6GqH0FzSS4exob/R89RvKCL390J4R6klVl4h3GY2TzwmoAA8oOlxa2TLED1kqCn5ZWYH2eY5KeIXJpaH0LYKkfPN2c7YUTJW6GoQK/aP3kIBpPDiLQwZRu3UG0+5Xtf5T79IjuauMC0gwwoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682958; c=relaxed/simple;
	bh=7KFOC5wLs3EJl4NsTnqfnwdjiRRNzD7PATmyJ6TduFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4QRu9rcifIurVDAkkS6Vkrbgf9r69fJgACXwN796uk12gn0xfnHPP9dqgVe37siyOdfJcLK5z5KwPYn/t2u7XSjE5xZqOP6zS5KCJHOiYOzXavPaoMNSNKMcK7HXKgGaL0J3SLHv7cA8HMDL0PvTqharRMZ9/AjIe1ALgbvafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SJoLjlJf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-79b530ba612so2522466a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721682956; x=1722287756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOO2jji9U8j5jqgweOYexBqjPNMVig6bzmPu41c6FV4=;
        b=SJoLjlJfpb4+VTjGMVo1c4ygxlKdEGxG3lxOo4V8o7oMmOJEQQlggrxeXu1/NMtDMu
         zu1d7R4g4ULnq2AiDnMAR29SSY3jIJbzxTHKqUubHYyy1vLrUFdoK+c+2hRd0cvnFF0q
         unq7zBPb5lIalmuEsTyBz63obs4sWlbNXUPzs6o6w5EH+BTTYHCvRMZC0TwBVhQrgGfC
         MY0yIoUdXVr23LLvRZfjgLm7UUcWZi8KYybfoFMAM3Kv+hqVe+mj6TshZwvv2qeYWPU1
         4eHIEN9ixkkngsnb+xwSHSDZT1ITkD+1yMAf1p9/0Q84tbLzKBY29gOSOuaeXX1IGFiK
         BwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682956; x=1722287756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOO2jji9U8j5jqgweOYexBqjPNMVig6bzmPu41c6FV4=;
        b=tqJhNvfjaZTPVxWYXO8bSs5jdKUogjj9EltcfhXKGYuEa9VbXycT80+b4QwSSBzbrR
         kSfwz81TNpuyHPLqzLYPISdt8HuuLRRWPFqJC4RZDjlcdzrrKqWEOrErYkhyNlvFnnj5
         tDgrIfXDG/xymZQMLrT7+ULdHO7yt/0s1tEpsEij1cr/Naqkdj12uAjfZspfj8uz9xcl
         Vm0ZA5Ty54pSy/D0onqv27jtNs1SXb0ESAOYPPBD7Tlep8WylvYfmWxvI4VW08RiSKE4
         DhZgLGSVqBWjznVwozDbtYvja74Tvbf78G2fnsS2OK1JVFPwyVRA/zEoi/2FsvhNxzVb
         Bigw==
X-Forwarded-Encrypted: i=1; AJvYcCWzH3SQNtSqGBxnT2MBRTbmmA7gEbBzvI9Hl0nZ38iFz2qUrDqqiW2vDJGGAGYKvmzjn46tGFASTysV9Ajq/RVyUcQoRoEOW/FkRAYu
X-Gm-Message-State: AOJu0YyWgWhdnHISti92yyu5VtZZTikVV2emQ9rpKsfnQwDBBqUJK2sF
	S/cFDh4lakm7MuY3zo33Svxl8jdBXVwyMLuGZcAPElyzxEprQDrIvnt/mleHGBU=
X-Google-Smtp-Source: AGHT+IE2SCRbidasSEcvUS+FBkZiidEQHa2TVu6rFttRlOgPYgJmcCb4tj758FeHkNi2yyoJQ5XZ+g==
X-Received: by 2002:a05:6a20:4327:b0:1c0:e5d1:619f with SMTP id adf61e73a8af0-1c42285ee9dmr8697515637.4.1721682956411;
        Mon, 22 Jul 2024 14:15:56 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f452c67sm59463035ad.225.2024.07.22.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:15:55 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv5] perf tool: fix dereferencing NULL al->maps
Date: Mon, 22 Jul 2024 15:15:48 -0600
Message-ID: <20240722211548.61455-1-cachen@purestorage.com>
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

Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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


