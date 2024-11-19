Return-Path: <linux-kernel+bounces-413678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606F9D1D22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00772825AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1818C150980;
	Tue, 19 Nov 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO4HASe6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54F14EC4B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979082; cv=none; b=dld3bxHLYvRs5PARj0s5WuRM4ZcrDSEUjdt6QJxhLKdejmoViehmHlYo2PnKHJ00WaTfPbO8wCuaVtup15EQjfvhHMAplng5lt8tRO4Sfueh25q6+iG5KDB+1f9jZgcM7X5NoBqk/IOSfBoIvZhOUjfLDxFfiXTai8WFOfomDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979082; c=relaxed/simple;
	bh=HtA+/VMRAFKGJnTE0aeWCJPRPsBs39WpjsNc7oQJRsM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=r6vaTQDDT/MkpbDOYKlDFpSWmfYzBiBrYQTnUBY1q2YFR+BPAJc9kn7mXk+9uTPqfQbpNvi5YBIQDkknHv4o4t0Gqap16+fzRvB/eHZtnSnkbn/v2Mc38uXy6158QCPeN7abMzt92AXYHqghGJjIkEabmimZjWNrEe61Ou4lxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO4HASe6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e293150c2c6so5365008276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979080; x=1732583880; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiB6WPAUFBLTutmf66Jh2bwqLt5nfeR6J1OUSjouKLs=;
        b=EO4HASe6v7FXLPVIXY4Xof0r56VyfGIraxQWbBrsvYob0vUzp9aNuiwDkk9CM1q/4k
         mWdxyZbibHh3DuSvBfCzzUiBT3zAP6aRPOML7nHBBHPvaP2F0/kpDZQx1K145CI6S2bN
         xGuP3vBZh2iZRzlPNo9Nug+N6qE7HUIjUN1G2eNceiy1WBbHjA3MCbrWQOzQyh8jFCsU
         7lUhqk/wUJe53rTw6QcGQh8PytnAzYtJDEuqrlxzjGMFz1DMoS9lERs6JpYuGyQCdrmj
         lkPAvqSc8oul1dVp37sGmYSGKzmPwZrjVAnkCcoV9u1ajl6rRJYYeg9AclmEJifl+HUc
         LwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979080; x=1732583880;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiB6WPAUFBLTutmf66Jh2bwqLt5nfeR6J1OUSjouKLs=;
        b=WeNs2DYYG/ekBp/2+opnAFf8Cn/F05ItiMQrdv6z+Qjk1v4117IRot8MxGTmcXkaIq
         UF72c/dHmtyrJgZIGkQeYfj2BlFxoRWWByfcApBYwnGxUkz9TOPomJvEl+GA2F/dRK/X
         DyOYNkwW5UjOVsJcjFn79x/O7nh5iG2zKYwrYO5nHgXJnkgKqGEHP4luP3BgsTjtdE17
         OwUBomma8K+kQMrUynVZt/kro+bbvtJDwP2q3smiqkDz39heD3wDTYaw0sd2n6X5WEtI
         RvqPGHTh1V1ROq/fKNzUXUltWwk/1sf+/OjhyOYPwZavH+KTV1rjafAvYbM8pAJUvDFe
         v/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD/s4h4A31hTPO/qC81O18EkqXa/uDlSRCQZX/Gzg2byE3mC9QxlZSA6bma1RqYsWAgBL/23duDqASH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDH0vr2Spp8Agtqnp4MtrIAZGcqy1ZpFqz0ZDT6WWs6oTWUTcC
	TKIM09OKXO2TiXgh3p8sZfYNoJ6kC00fv2UjIyh8HW3W/sjUzJImJHlGd2hzaUb2K7sYO/3c/w3
	dTRpUSQ==
X-Google-Smtp-Source: AGHT+IEh5ChSTsDrAC1TFlUx0QvFRSJAlWCS1zQL12q2cVph1KJUN9j8LUTVNw9PTbQzwXll+E8g1c6qLQtG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a5b:888:0:b0:e38:78c0:1a0d with SMTP id
 3f1490d57ef6-e3878c01cb2mr8797276.2.1731979079542; Mon, 18 Nov 2024 17:17:59
 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:35 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 13/22] perf intel-pt: Remove stale build comment
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.47.0.338.g60cca15819-goog


