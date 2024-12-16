Return-Path: <linux-kernel+bounces-448287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA289F3E33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F113C188A586
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF01D9A51;
	Mon, 16 Dec 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSvu2SDP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326061D5CE5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391505; cv=none; b=kW7IRCePJb7c2AqtSLlDpQKc01RwUgYBewKj0Gy0dirhtoWuu2CWi/pc/rms6mpJ/AK53tKg/5KNn/4IX/iQ7cZ2yRce/RhePXpj/TyDgDZ5C1K8O79axnjp8/wCqh8YlUX3bF897TxFl9nEMCrMPUmeJhXLwdX6xZlUazwcn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391505; c=relaxed/simple;
	bh=d91pHALH2JV63qVzNlVUa+U7oTmGwGGGzm/Q8UVFG90=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=KLrTr6GsJUbCsbld2+Pr7M8aEQVpEDP3YcRKqvo5JpzEhXzn6Q90+F5Uh+dDEhz1/2JFMuO3wQo2ziYUAIJwhxwbHZOufHmJYytGS5b4x2Tal2en4iqXUIdHtkBdE3eBxwiFv2PEvr5ZvdJ2ZUl3feKagsYBv42+t8acgHKf3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSvu2SDP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e4a8b40dd40so2534217276.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391503; x=1734996303; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WjcAqvkQ6mqB2bq1bnIy6pEaKZ5fQXPGMRJeTM3fVLw=;
        b=TSvu2SDPmRA+FbjGwrG9BPngGhtAeoRxW9338pAsxW5RMfHReVmo/QHIP7KGwOxScY
         xHZv+mOuuTU6KeVRAs2Fpy3nFvnwDmqVXgTBUIxIJfrODf0tEG4CrfUEe8PJpl8s+qwh
         ssVKqD0n0gky/Z+RU2iQTQs1O534EBpRPzG98VfbeZzM49RMWXfsjRD00kglnX4CMOpB
         M48i5eg+viuGpeoIf8xfwJpCdnYDFXeuwkshrhOD7MLF4xd0uXgIGGWF7O8iAXxOQ0zc
         HlbZkFVKnXM4vVk/z9It0N5oaogXcn6uDpW0yGwDmWIClfttcyU6l8W/v8PpLeq90W2K
         sAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391503; x=1734996303;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjcAqvkQ6mqB2bq1bnIy6pEaKZ5fQXPGMRJeTM3fVLw=;
        b=Z3eyx3q0pHyrfObS1VWTal4VedE7ue8H+QpRQs1ksNWDZKFyIHCQFkSKUECXG62wC8
         eEhbE8zrzMKpsnYN+OjSDvFLbsSr/skEbO8ONw+Act34wSeg82ykZ3MvcV06rDTJom7T
         4NBwK8CCHwxPYjm+nLxxdVHchzsAqbWYml9sKaA27CJDaQsFfpjiCbwYwec7jB8X3lTw
         x9koC17NfpAZZefbJd15+5coUhXNY/pGUtemQNmiT78w+VxIQahpj9UzJ99oX8NtGRpp
         d7TwN0ltaxjFFPg60u0dfEHx0h5gGrrZvY4oMC/0zfrswsEkfOPdIhsSNZ5KE8FaRyed
         nfAw==
X-Forwarded-Encrypted: i=1; AJvYcCWSEbIrAkzm7eNiRFE3DP47uqjponwALv2rX15O4x0JJCxqKNcqbIj4nkACozDYdttaBoDKzZwM5jl7S00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbq8/m+ssJUndaNc0I5v78OS/zFJ298Wab0hYtj+JCDXcKsypc
	5efiFghwU9Zfiet0qTGh/fRgsO7K081cqO12i//dVEPHQVuTcPj0yWuOkOeKpbCjC7OCmdU0OYl
	dd97sJQ==
X-Google-Smtp-Source: AGHT+IGeupgY2raDYp+ihoXXsjMJZ7hS5dTyfW7QOdPBXmIr8dC2y2j8ryPDorsH0XUo3BK6UXLRX8lc/IEt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:8884:0:b0:e4a:9d0a:4e51 with SMTP id
 3f1490d57ef6-e5300052d57mr770276.8.1734391503244; Mon, 16 Dec 2024 15:25:03
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:54 -0800
Message-Id: <20241216232459.427642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 0/5] perf file align features, avoid UB
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Features like hostname may not be 8-byte aligned. Add padding to make
the feature aligned to avoid undefined behavior (UB). Modify the
writing of the CPU topology features to always write die_cpus_list
even if empty, as the size could have been aligned and not allow the
missing list to be detected. As die_id may be invalid (< 0) ensure it
isn't for platforms like ARM. Avoid UB also in machine where a NULL
may be incremented.

v3: Additional patch to avoid invalid die_ids
v2: Fix CPU topology as described in replies to v1.
v1: https://lore.kernel.org/lkml/20241212080530.1329601-1-irogers@google.com/

Ian Rogers (5):
  perf cpumap: If the die_id is missing use socket/physical_package_id
  perf header: Write out even empty die_cpus_list
  perf synthetic-events: Ensure features are aligned
  perf machine: Avoid UB by delaying computing branch entries
  perf record: Assert synthesized events are 8-byte aligned

 tools/perf/builtin-record.c        |  5 ++++-
 tools/perf/util/cpumap.c           |  3 ++-
 tools/perf/util/header.c           | 10 ++++------
 tools/perf/util/machine.c          |  2 +-
 tools/perf/util/synthetic-events.c |  2 ++
 5 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


