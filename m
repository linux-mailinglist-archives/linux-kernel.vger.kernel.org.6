Return-Path: <linux-kernel+bounces-389850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F293B9B7224
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC741C21B87
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B6146599;
	Thu, 31 Oct 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZalzd1W"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07155142E67
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339026; cv=none; b=dfCKy5mkQCuwK6fCUu6/+4xWHBJSYmPtxXzqk7rS9FQTlQvoGGtplvYAXBh0QMfY2epbJv8unLsHAJdvImj+C9Y/f8XYkqNoIkiWbY3FE8+AFRO/VSgPYkCnz3P8HteAKz2VSKYYuw/1IYd7SxCbxO1wrAEYatbtleglD/m3Ysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339026; c=relaxed/simple;
	bh=DLQSr6SnK+8kn/RmCu+SnzxGcgCWeuDWyrx6+bcBl+s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LA1c0jGjAJxBZvH8dnAqpXQvn7Gu0yk3B/2+vV0CZXJs8o1jvSqnMvswKhhp14cUEHJJ3jdR/DAnxOgbLBR4AWkokqja9Z2A+3QceWNTvr3pDVgtmZ8bi0LdM3mNeOZNVyMYSbz9UApfF4OWR0Rl20LpCjENLAPFfhArn3P+erM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZalzd1W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9e897852fso8707637b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339024; x=1730943824; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AVgUHfJDItQA9RxyoIMfq8JR0bFjxdZgjCoy85Lj8s=;
        b=uZalzd1WLyPminW80awrnT6fZCE4DZhhU2wg03xE4GF4iBpHQ6xADO6gg2nQKU1fZO
         /iDcP9mxiGegnuL1nRf/KH/VQf6z7lVIx8PMspV2qsFnmXjszzIFShQ8cnrF27P/fy8s
         XfNnAMg3k6FkW7MYdWf/jyvzd5sFcNRudzotcVUim2L+95vM/IlAgoEeUNTsPd5C4L6Q
         Zg5SQXwt5u2UnkqYeJsCQ3DFBvenbkSq8HGM2E/IDzHXHdebdssuCHJ2MNSTwlnLEVrr
         GjRy6QKn/5qBr4eUKyLSP6YTFCwq0OJRgzddJXrWaDlyFeD5lRbrnvctfNs2VL2Ytr9Y
         k+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339024; x=1730943824;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AVgUHfJDItQA9RxyoIMfq8JR0bFjxdZgjCoy85Lj8s=;
        b=EGe9ktQl265DSMmg9TLKugYCBI+9gliLwn6mDopcIkUThDnkjGUxzHqfzkOTNE/a5Z
         zSPory039Gf+nY4O/DG2PeQZcRgnORA1dF4+Iu76aVDc4x5fCSQGFiZztH4/b8lhNeij
         e48j6p2AWeh8lhP1yxdQL3c4M7Acsp4me5yf/uZVieRtySAxsYWdU1kt9Wgln62RVFVO
         aSbBQIWZrUirt//7CO2im5niWiD4qTFAmyusntnBRF6F0pzE5dEItUB602Y6PRIVLy7y
         8o0/Tpvjwr8P4zq5pZuqhlK+/8zy80wr3l2Q0uvvmuxAIu8XpNnthMwurmiuKpNxEnJV
         bALg==
X-Forwarded-Encrypted: i=1; AJvYcCXJGaJdyCcf+lG4H7J5KNOoDnM3RZmw7Q26acRO9tppyPN8SsxNT5lZd7wU6WGPm7wXSAjBoNqrprDhWU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhOCiVk9w8S833M9zFyQbbFFm277rAXXu0/CaPvR+jt0Hs+t6
	dvHzpBECK/5yXkDQTuqJ+yfUjKxdBwWiAPdrLO4Zrh+uEHxhTlFI7rK1Knw8XL7nNVNVR+53cVl
	J/YCjmw==
X-Google-Smtp-Source: AGHT+IGWaNJtf4/sIlqPPGJnBicFjuTejugTBGvCf+W6KOXLnebs9Hw1u+rJ+APnqGqmZvtWD0iNxWHEowVb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:690c:f:b0:6e3:6414:80c5 with SMTP id
 00721157ae682-6e9d87b4522mr7889527b3.0.1730339024226; Wed, 30 Oct 2024
 18:43:44 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:43 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 12/21] perf intel-pt: Remove stale build comment
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 00a263902ac3 ("perf intel-pt: Use shared x86 insn decoder")
removed the use of diff, so remove stale busybox comment.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-pt-decoder/Build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index f99d150059b9..5b8f0149167d 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -7,8 +7,6 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 	$(call rule_mkdir)
 	@$(call echo-cmd,gen)$(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@ || rm -f $@
 
-# Busybox's diff doesn't have -I, avoid warning in the case
-
 ifeq ($(SRCARCH),x86)
   perf-util-y += inat.o insn.o
 else
-- 
2.47.0.163.g1226f6d8fa-goog


