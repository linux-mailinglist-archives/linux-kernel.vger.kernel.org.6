Return-Path: <linux-kernel+bounces-526966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C809A405C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3D426EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42F1F3FD9;
	Sat, 22 Feb 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BewLNPK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B01DE4E5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204626; cv=none; b=cCrnDzhGLa6iIhC5PJgshLCxQd2FbiEnE44uxehfIVoE2rRW3SBkCmmiTaqNyov/eDmF7vN0zaRYSQrT88e90+FM25HX9x7LRqmLdtn35KUfmb9TQxkfMoDxqn31/WTbs3+NJu4y3H/wntzyMcoNIoR4mfntVADQfr+rdymqZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204626; c=relaxed/simple;
	bh=44vLGO6dfCf3yHVDGRp43Z/DBpYI93I5nayxy9m9dtc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=gFUsf0JgUc4JS0tac0oqyfsbIbuihVHOdxgMJ1+SS016aelt3UHKJYPh2TRGfjjNO9Ji/oLjKcCp6h5I1IQq3mWo7OqIT1dODTvUntixRdR+dfhzJzdf3lxrO3xEMBWfsVBCREoZEIfsCv+bR6YYndjAkte8tfk0zYNdBSfQjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BewLNPK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fb7fbb15beso27612627b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204623; x=1740809423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7qKacfYtj+Uys83rLKLuWvlrNQj3O9LR1s0o+R/+wQ=;
        b=2BewLNPKVTtW+bZS6Dn10bv6WR0jmfD5ph3mGu68tAVYf+zBLZ6CfbWHxbxashY/h3
         srJcefw+S1JQ6DLSHl52fUBv42GZax2vmvCiyDlz5LVQjzyeGJssdven76Txf8SMEiGo
         6LjokVO5sGH0pTUdwIz2PFvd3NBD+Z15fMNKL6+5c69xUXaudpw0FjPNiXsqcsImDSxZ
         YELt5DGbvtPC8I3HAoxUqgjP49wozfHVt8JIkoY9KeQTx75Gn6cM9jKJ6cRAhLSiW6lP
         vNwNxk7rsKE/B/bv9GYjXwOt67ZA3oWPtRwV/YQbRy2W1It6ZsOS55+Bo+l3DzKk1SFn
         1OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204623; x=1740809423;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7qKacfYtj+Uys83rLKLuWvlrNQj3O9LR1s0o+R/+wQ=;
        b=HJqb6Ajh6C5gSjTpNefhcyMhOsBhmHnqxq/VVf2DW5JWCOzU59GUly8A4e2Mq7XfhF
         R1UlGWn8X1laX3NzSMCU6jpTyBUmpdxloUY3rgAwA3Hx0/mgbUpinulMQcyvKKKAnLbB
         WP6sqDARKCkNkwP4F6UM7/tq0zFwtx4vSVWLqBXHNU7u1TuZlgFVgTVEVLTxJ5CWlA9u
         M8t8xWj5099eyCvI/kCVWKGRj3HevuOrvF1JOX1NgRK7xdVoyR7vuOcL4W25yuQEVtQB
         AkhZcW4CTr/vG+JN0Tqo2baciyXE9+AiO2AGgmdD1dYcVLG9YGv+vAg5MjRGKwUJ4pQt
         +/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKTgIeRCpzh8A3lAw59yaHxPSSZONghqTivURIseei66RpNi3Px6ZoTN1GrlLFtt7w9pQMkNdK/PlEuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4BV9vcRRNqUdzEIcuPVO4FJ6JQJ5tb8qqNJesomIzHbcg/IR
	sS8xixiNPSshIhsQK1NRZb3X6IhfWGo7JD6+JJZq1P9J0zKdnrrKwbtXQ85kp6Qy2BQ3djLbNYc
	15Bv7bQ==
X-Google-Smtp-Source: AGHT+IHUzcS3zYdkob5ereQO8XuYiUykNYQN2TTbZsfC9JsCedVy8HHKfv1gCgdftEMUwRqsASk76UFrIxgd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:48c9:0:b0:e5d:afb3:1c81 with SMTP id
 3f1490d57ef6-e5e2469386emr575413276.6.1740204623353; Fri, 21 Feb 2025
 22:10:23 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:05 -0800
Message-Id: <20250222061015.303622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 0/8] Add io_dir to avoid memory overhead from opendir
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb

v3: Rebase on top of Krzysztof =C5=81opatowski's work. Add additional
    defines for SYS_getdents64 on all other architectures if its
    definition is missing. Add a patch to further reduce the
    stack/memory usage in machine__set_modules_path_dir by appending
    to a buffer rather than creating a copy.
v2: Remove the feature test and always use a perf supplied getdents64
    to workaround an Alpine Linux issue in v1:
    https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.co=
m/
    As suggested by Krzysztof =C5=81opatowski
    <krzysztof.m.lopatowski@gmail.com> who also pointed to the perf
    trace performance improvements in start-up time eliminating stat
    calls can achieve:
    https://lore.kernel.org/lkml/20250206113314.335376-2-krzysztof.m.lopato=
wski@gmail.com/
    Convert parse-events and hwmon_pmu to use io_dir.
v1: This was previously part of the memory saving change set:
    https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.co=
m/
    It is separated here and a feature check and syscall workaround
    for missing getdents64 added.

Ian Rogers (8):
  tools lib api: Add io_dir an allocation free readdir alternative
  perf maps: Switch modules tree walk to io_dir__readdir
  perf pmu: Switch to io_dir__readdir
  perf header: Switch mem topology to io_dir__readdir
  perf events: Remove scandir in thread synthesis
  perf parse-events: Switch tracepoints to io_dir__readdir
  perf hwmon_pmu: Switch event discovery to io_dir__readdir
  perf machine: Reuse module path buffer

 tools/lib/api/Makefile             |   2 +-
 tools/lib/api/io_dir.h             | 104 +++++++++++++++++++++++++++++
 tools/perf/util/header.c           |  31 ++++-----
 tools/perf/util/hwmon_pmu.c        |  42 +++++-------
 tools/perf/util/machine.c          |  57 ++++++++--------
 tools/perf/util/parse-events.c     |  32 +++++----
 tools/perf/util/pmu.c              |  46 ++++++-------
 tools/perf/util/pmus.c             |  30 +++------
 tools/perf/util/synthetic-events.c |  22 +++---
 9 files changed, 229 insertions(+), 137 deletions(-)
 create mode 100644 tools/lib/api/io_dir.h

--=20
2.48.1.658.g4767266eb4-goog


