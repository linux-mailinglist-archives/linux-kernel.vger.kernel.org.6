Return-Path: <linux-kernel+bounces-307159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853DF964959
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E691C21D82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284C1AE05A;
	Thu, 29 Aug 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEOlI+06"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54726AE6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943733; cv=none; b=qNBSf9GbGvh7DGRbdcUfAku5GGP5AJDn/p37xQ6/qnSiECdD5K238z0j8Cc4rGhf2157yXv9y5IwUhlSjaD2gQ9hUyUXRh6fDZjnkHV8vWkwK3sJL3DarKq5CEL0sVJF/zhATZBBh2Sb2vV6MYR48hGARQpzu0+uXOoXZ9fQR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943733; c=relaxed/simple;
	bh=6FignmCutz3zKvNy/RkpyD7aw0PdHeweeWlalGbaZus=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jDjM/43ircicew54fK8aZRAyyWv4XZCoIGQ0LRkRHYSNhjZcw0C5sbebLE/kwJBz106sZIY5nYxEhkAYH/wt31LhxTG3bR5hJlgWtkbP5ltehll7uAw5jX9qfkQlX4SMyUIZw45B+Kf5mDHDFzXgMmv4A9aaGATHzOqq1I9OtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lEOlI+06; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b44f75f886so14389757b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943731; x=1725548531; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CS4QMMQNHIIPC8Q7bc/pYMBPK4chhNINAZxjMKT+0+U=;
        b=lEOlI+06TOOpDi6kknQNa5MSZYsWM3FAHmPgcqokWVtqQQ1TeWZJDlbPRolNwE8vdP
         NVhwuKLOy6JrRBGl+0PQLTWjtgDco2vJJjO9Icfy0KpZQnNCYILWt+m5ThES5xdeMGwv
         UgZnf28wCwEPrvgOHs2POautzGLNCNX0yotDTidAoGC/Xw5Rc84TVafE7fbXJFWD9DF7
         ZunwK4kZY7kXgNeivZjC5F53kkHkdq94cog0HTBWy8tdYJFCofxohkkoRZ7BaPqHKE/k
         TtWT/O4oHDZ5ecg058rI0F/m8+3mTX5u4ESXm5o3ElmUsd1lQQiLBY7AB1j+GHA3i2ds
         sJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943731; x=1725548531;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CS4QMMQNHIIPC8Q7bc/pYMBPK4chhNINAZxjMKT+0+U=;
        b=FdC0AjM2pP1ZYt1xf33G0LnhsVJ7QZZDjBS8ZzOiL4Q1UT0WKxdPwLr9ZWDpka9wFg
         snNocruSIE4a7Zr57Bplj0oREMzKy3exBi+SRXaQTpAjW4isXJTrk+6bb53OOxAKSgb0
         Nh2KvBEp+AyjX2j6DgJJL3LhcKlidOtt6y6fx33lM6U8HUbrc2SwXfco2sSxDLh5jE91
         IbGWhkNkUAklYJpXruvN7eKyrbaF+ZCiHyG51IzKqaNZCY50pWbsa8L2eK9m/Md0bVjx
         kv1TPs2c5uqoblB5NDWIB3Aj44HlqZ63qiqC5ddDrXORU6aRkIYRibC7cjYa3wZZc7Rp
         Jcbg==
X-Forwarded-Encrypted: i=1; AJvYcCXcvea3OBPWiaQrFqvWozm3y0cwHdblCWhTjMx7sJePJOimpItTH40B4oXfyVIYEEFwFid+jwPm1EpoEYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Y/CeU1u2CmblUNLxNYfudKnAfxbmw7v+BlHM2hKVsssvaJuG
	reWK3GxsZ8zcRIdI2bedkdllTt/iTj4uT0GA9pm3TZMhrIaFqO+IkFXxzfG1GD8kJrly591sDIu
	6RPVM3w==
X-Google-Smtp-Source: AGHT+IGoWr9zL5UYJmAZlAbRIC+kENMwKREc4nRi0inl7+soNRQqIos+I9RCphTs74J+tlekKEdPzWQD0rQx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a05:690c:680d:b0:697:9aae:1490 with SMTP
 id 00721157ae682-6d2e6f712ebmr489247b3.1.1724943730788; Thu, 29 Aug 2024
 08:02:10 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:46 -0700
Message-Id: <20240829150154.37929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 0/8] Correct inject's handling of pipe files on disk
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf inject tried to repipe the header, but this isn't possible if the
input is a pipe and the output a file, as the attributes are events in
pipe mode. Add an ability to write the attributes after the data so
writing the header doesn't need a possibly too large or small region
reserved for the attributes. Add testing for the case of a pipe mode
file on disk, add checks that the perf file's header isn't obviously
corrupt by having the header, data or attribute sections overlap. Add
more comments.

Ian Rogers (8):
  perf report: Name events in stats for pipe mode
  perf session: Document struct and constify auxtrace
  perf header: Add kerneldoc to perf_file_header
  perf header: Fail read if header sections overlap
  perf header: Allow attributes to be written after data
  perf inject: Overhaul handling of pipe files
  perf header: Remove repipe option
  perf test: Additional pipe tests with pipe output written to a file

 tools/perf/builtin-inject.c         |  60 +++++------
 tools/perf/builtin-report.c         |   1 +
 tools/perf/tests/shell/pipe_test.sh |  26 +++++
 tools/perf/util/header.c            | 151 +++++++++++++++++-----------
 tools/perf/util/header.h            |  21 +++-
 tools/perf/util/session.c           |  12 +--
 tools/perf/util/session.h           |  52 +++++++++-
 7 files changed, 223 insertions(+), 100 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


