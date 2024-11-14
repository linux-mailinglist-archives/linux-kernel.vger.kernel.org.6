Return-Path: <linux-kernel+bounces-410032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C89C95C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14678283ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A81B21A2;
	Thu, 14 Nov 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YI8NIcXX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A151B218F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625640; cv=none; b=a02IKg9kO7OVy5tyq7XM1/jov75kutV7dn4U+4oo1ryV/VBl0vAzBTHY+BbG9/821UItWVWNtDUQBC0kB2L/RyNL48B3tvz7a55xiH4kk7embrYpsOMMNPRQDe7ZDhxID5rXz3RX0J00uJgey5/ZWahVDCDBZE+LuF1N8WxIVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625640; c=relaxed/simple;
	bh=Dp15DIVEEmSIdD9NNVgWjs1O/f/At8X6WEz0SMIxKZY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=NYlxAF0qIGo5GLA8lvDDOYxzk9Qo8tW1wY1Prn7k5nTvg99ssxNDSYmzftpHLNQt8GjZWbU+skyA5BjTjcyisN3yFa2N5b5XODXrupSQI+YD38YxpXsvoJJUeirzb1NyhMKzIbJ+C2XIq1hD5w2GjULc4FkOqG71Mhc3wqONcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YI8NIcXX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e35e9d36da3so2042264276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731625638; x=1732230438; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ll/vUW8S45nGRGrDIOMcD0GkJeApUvNMCuJ2LReRko=;
        b=YI8NIcXXRnD6H8gtDf7YKoBIMSn8+p5vvd4wSrv1z+2rE9PA3+Sr0zqkK/zlN8WjiW
         RwmmkKnvGW3qxCE6Zel6H9Qx7L1hjp4mXwNRvOk8L/6Ue3kJsojxuwTr3T6A3OsEnmSi
         PDRjWea5WJGb7KvSK6WG5ambN7vFn+Y1VG2D0tnxf/aK9OCNIPO1GW/kwU6UxyHcZu3S
         w798pOBoVZ94d45AD5hGQdBafYzBwad4xevb4SM3/AszeJVZhqmLzxM3RIImh7YEJsXL
         UNkG6BkDYaFMxV4fuOutrKIov/qRAcT0haNZ/xLMkSJk+HLUJ5BIIdBwCNFC17UgkYZk
         MB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625638; x=1732230438;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ll/vUW8S45nGRGrDIOMcD0GkJeApUvNMCuJ2LReRko=;
        b=DiBFsmY2UMAnNbldoHLJ/xqED1r7imB5C846yTynMquiGGdV7bGGLhgmQUwaOsFwPr
         JLtOuwqEESB1sxCM6clNoeBh/6HSfoInylIFi4urEO8TGLLcS5TtE4wSO800FaxuL45U
         MGzqFCRXIOWFy2OoBMa1NHR6mfLX8VAbcwLodfudYO2vIVcvA6GPMhdPu04Jb1kUa94H
         SCMGbdAlegTXe6dWrEvuL8FJSZTpfCNMacJZcgWNrI5HyEO3QAE+GuznvSLqw+7Fi6bK
         VYoVDYhiGjbs61+yqQKStME6PgVkUed+RRLV1t5sboQBSBJfMVGhmaKswJHUBw4bpNWj
         xQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCXFIZuHEjjA2nBcH7hwdrEyn0DLmRUPeg9lN5H6QKFrMb1y8O2LZLMZTt+buFiahvj7IWBhRTenEE/NLoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEVM3WeDh9/e4FCU3JYY3W8X4SZK9cRfghXKWrFi4MMbLJOQa
	4atKEy6R0soFNxTaindICkhma1eYGkwy6MRcrpGsaYTSFbWC/6bIm3oZxDKOBimGh36tGk3ECKh
	oMz8rMQ==
X-Google-Smtp-Source: AGHT+IHFF9XsruTHygct2BUmMIVXMOfzIFG3QuYDLL+UaiMJSCi+DbVqlHtkgUqfQV2zEFhqf5nETeSphKtp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7595:be86:b969:ac41])
 (user=irogers job=sendgmr) by 2002:a25:a28e:0:b0:e38:10a7:808e with SMTP id
 3f1490d57ef6-e3825bd1b6dmr10359276.0.1731625638147; Thu, 14 Nov 2024 15:07:18
 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:10 -0800
Message-Id: <20241114230713.330701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 0/3] Prefer evsel over evsel->core.idx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

James Clark's patches fixing evsel->core.idx [1] reminded me that we
pass the int value around unnecessarily. Passing the evsel avoids
issues if the evlist is reordered but paired with sanitizers we can
also know when something is used when it shouldn't be. These patches
do some initial work reducing the use of evsel->core.idx or reducing
the API to pass evsels and not their interior index.

[1] https://lore.kernel.org/lkml/20241114160450.295844-2-james.clark@linaro.org/

Ian Rogers (3):
  perf stream: Use evsel rather than evsel->idx
  perf values: Use evsel rather than evsel->idx
  perf annotate: Prefer passing evsel to evsel->core.idx

 tools/perf/builtin-diff.c         |   4 +-
 tools/perf/builtin-report.c       |   4 +-
 tools/perf/builtin-top.c          |   4 +-
 tools/perf/ui/browsers/annotate.c |   2 +-
 tools/perf/util/annotate.c        |  32 +++++----
 tools/perf/util/annotate.h        |  20 +++---
 tools/perf/util/stream.c          |   7 +-
 tools/perf/util/stream.h          |  10 +--
 tools/perf/util/values.c          | 106 +++++++++++++-----------------
 tools/perf/util/values.h          |   9 +--
 10 files changed, 90 insertions(+), 108 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


