Return-Path: <linux-kernel+bounces-243000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6EF92900D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A9728454D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782B91BC58;
	Sat,  6 Jul 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvLn8Fcr"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF719BBA;
	Sat,  6 Jul 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232747; cv=none; b=ELzG34bfrB20wtHPlV6FPc0Aw5Zlou5897QClelvolr8kJkRG2XCxtsQys32XaKj7RtUlsZxRGq7zXNJPAKdlFPsIgxn5Hd1/nJsDf80qe+ZCbquEdr4+ZsiOPPnWd9CM7tLHCjq35XeqJMoY+D1j9XSdi1m7mEVhHM69kfZhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232747; c=relaxed/simple;
	bh=bYRwOWQYBjBFnit4/fPMSEzIcQVFaj+ywbAIc0qfafg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF2A6RO1Ff8tb4SRKH3r1EccyHIeJt5nmz8mYZNJt5SF/JadO1K/TT4g9UIlLEvndBAH5P31JWg4UFf14PQsfL13EA4IjiyefJoaeI3cxHu/0mMrLjKTlpM67HQo25OYGWpNpkV7hkJyX+rakv9vrhimiQJl0TIm05WMQZe21L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvLn8Fcr; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e026a2238d8so2241476276.0;
        Fri, 05 Jul 2024 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232745; x=1720837545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6NW2XiaqgCOW2kGzuZtQVJiLTkQZp/jGPzUs3Qox2A=;
        b=KvLn8FcrfDPfaBA/gabgWPe+W/zsP+jl8O0MIqO6rc2BZ6ghxv/eJ4ZYtINPTZeifg
         U1UoikSY9t8CPCRcYHaXN13ccXVT2LcUGFih7LLxq4H97RTMA43f8vIo0PyaSupavg9K
         eOZbQQsQbF1+BPC4UvgQwDppXjgNi+KYrP1aTbG5s49nKzE9udMoaRAuYXeT650D63ID
         zX6/8ne0LhX7rxZlfxZV/05R87bOYCXq/gYHMdx81mrhjAUIDT7UgEq3dal5YYMGKvOF
         AdneNBmbOiNtmhZlJWH5Z5KkJGIwHUHCStTE1Nmeho19TFHn5Hfw9VBZbqTqjwbhQK77
         aeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232745; x=1720837545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6NW2XiaqgCOW2kGzuZtQVJiLTkQZp/jGPzUs3Qox2A=;
        b=Ts75zVliqKUDh3qpSFM38ZNlCCAU/7byYyXnpfKLh/VJbFVsGOK57ipp3Rs09TE+MX
         ZyV/pzf0oBIJvDmPMMVX4pFjse8LbFnLSzHkdP6KHygZySbqX9ynkdZURqmIc1GGpqI9
         0j0lhBbEochlIxOprrdjNbo6gF1kX4vPMiOQRsRmAlV0W9SI+FNsgn8k48SchWa30mhm
         ECPxufKjqdQE4GtXqZPfV2iixpH8pu3rbdjmj8V4nSdkyph68ebcp2h859BEIlnn4aP/
         BDOjPiUAunANYdt4o4MygtIqr37eBXULwTUswCcSM9uqwyMkFQHEazIX+m9Jz1sv5eMe
         06AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK7Brs/SFdEHS3xquVdBH7wspBDKfdUY8sTpjp1soYz8fFsIG5RJSxayzy4SSF1LIVwQwklUszR/u6NuvJXap5aYDLL8KjsLMQVysaweni1Et7shhyGuwiOmeOePs7/BxBhcqXE4Es
X-Gm-Message-State: AOJu0YybjEHSs672l246I5yHFawaukYgAzbFAqfTDnNqke7OkzuXSUeN
	KaG1SPNWs30iYbaVngBbPI1KynuH2EC3302IKcuJ91IAggJ+kscB
X-Google-Smtp-Source: AGHT+IFNkqLTZT9+2L2xdRVS7Od8usyV5xtdrQiTpxoRliyeJe2Nh1WeW8XTWGwhpPrd5owlnsnLlA==
X-Received: by 2002:a0d:e68b:0:b0:64b:8086:5805 with SMTP id 00721157ae682-652d5917b6bmr62075797b3.15.1720232745356;
        Fri, 05 Jul 2024 19:25:45 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:45 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] mm: zswap: make writeback run in the background
Date: Sat,  6 Jul 2024 02:25:20 +0000
Message-ID: <20240706022523.1104080-5-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
References: <20240706022523.1104080-1-flintglass@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the WQ_MEM_RECLAIM flag from the zswap global shrinker workqueue to
resolve resource contention with actual kernel memory reclaim.

The current zswap global shrinker and its writeback contend with acutual
memory reclaim, leading to system responsiveness issues when the zswap
writeback and direct reclaim run concurrently.  Unlike kernel memory
shrinkers, the global shrinker works in the background behind the zswap
pool, which acts as a large in-memory buffer. The zswap writeback is not
urgent and is not strictly necessary to reclaim kernel memory.
Even when zswap shrinker cannot evict pages, zswap_store() can reject
reclaimed pages, and the rejected pages have swap space preallocated.
Delaying writeback or shrinker progress do not interfere page reclaim.

The visible issue in the current implementation occurs when a large
amount of direct reclaim happens and zswap cannot store the incoming
pages. Both the zswap global shrinker and the memory reclaimer start
writing back pages concurrently. This leads the entire system
responsivility issue that does not occur without zswap.  The
shrink_worker() running on WQ_MEM_RECLAIM blocks other important works
required for memory reclamation. In this case, swp_writepage() and
zswap_writeback() are consuming time and contend with each other for
workqueue scheduling and I/O resources, especially on slow swap devices.

Note that this issue has been masked by the global shrinker failing to
evict a considerable number of pages. This patch is required to fix the
shrinker to continuously reduce the pool size to the acceptable
threshold.

The probability of this issue can be mitigated mostly by removing the
WQ_MEM_RECLAIM flag from the zswap shrinker workqueue. With this change,
the invocation of shrink_worker() and its writeback will be delayed
while reclamation is running on WQ_MEM_RECLAIM workqueue.

Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 24acbab44e7a..76691ca7b6a7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1806,7 +1806,7 @@ static int zswap_setup(void)
 		goto hp_fail;
 
 	shrink_wq = alloc_workqueue("zswap-shrink",
-			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
+			WQ_UNBOUND, 1);
 	if (!shrink_wq)
 		goto shrink_wq_fail;
 
-- 
2.43.0


