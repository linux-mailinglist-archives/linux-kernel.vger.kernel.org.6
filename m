Return-Path: <linux-kernel+bounces-402550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC669C28F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E5CB22337
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0782D66;
	Sat,  9 Nov 2024 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAxdo2XH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC07FBC2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112701; cv=none; b=ucDIRAuXHFAuuZ06yYkvVos3hpZkm/oS7/oDYmv0qNK71vmE774YW5XDEDvhdFSnE+bAHh1gqtMKbJFs+TzlifJcGsGRpPPXorQ/5+GW0paGUQsq8Lqo+L3mAfELb9cW3r5epK2/tnR3oVPc+KEe+qu6LeGAWWdrv14aFBOCh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112701; c=relaxed/simple;
	bh=rmktKWgkJHRVy/ZdsAA0Vc65puJoSfAalv+s0diLDGY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HseM0xVaJFbtXLta6BbNngES5GxduErbwTHJHQ3+5dd1l8dPmSGFKKbdP1HhxAMvgJjq3niBl3TCQsrAftXtqwaJidkiYpb4ke7ypJI8zF49yz7zmRzrc59iStDxsFKAVBHOdNTRUvZMtwLwcMbXN19Wz6t5fQxsOyORKIGAtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAxdo2XH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so4946685276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112699; x=1731717499; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=JAxdo2XHJkmVnZVU2H5VwO7b7u1regk0rH6zIPJ/I0U1gfpKypxEQkzdsfI47jcj0U
         tU0jS8+m/CTIP3z9vQRURr7cdusyNVcsQMSTXbr7ARjR7qnX6oBPdivKIvnilvm/X8V+
         HAp7NRlKQ2e9V+wPw1cWwzefQVLLD0E/DrN4psrqFO+1YfI7sp2Q+HqGrL+xe030y4Lo
         +SWAxSUkHbSheDj5QF5QbpbdimE8f6RY0qz+q8lC6o3qIItnPBPPbvX0EB4BX3GIZGeB
         iey+sp0csCQF1wDCc126gjCHjP9Ptw3+yWxeFII+cChCwX23fVOblU5oRP0p3iUE6hJW
         3iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112699; x=1731717499;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=Z5GiHBIA4IlzhBJRk1eBxOvfVP/HC8KV1/oAkXKDAedINQQYYxJdfHiFY/4F7Mf9pO
         GAecEjGk1pEVYZr29lWnAqY236JzPqE5/San1G+3V5Gd5XOqzOu7Sxna4pvb9KV78vmh
         VZXS/XI/SXN0lEVh9tmALIQG65rInhTUyeRWYfefBZuOVCK7YQetsUcN6kksbTv32ybh
         xPxc32vvBovRyq3A8CJDQPXLErllHlVWacCSLhqnKqF6dFXfcY07qDGC7E3uLNd1rUjd
         uOSP/xT9biylw1srSrqUoP+NIe1XGbxupd1m9kx9nIgGHUkK6DvnhGzKw9sbaGNPMro5
         +7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4/bvkTXYCWZpYebhkgDcZMTI+9ngwU5+rPLsiGEIDfh8WcWihI88+Klr+rumHvt7hhBnuDf2mSQnHG2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzibO8LFgnGAD6FBLEWRqTnwsjrvESK1yebMZZDr0vntZ+S/I9
	yltRUXI2qWmUCNrDjMYJULZ0GlpdQS7B4GQiNxXjGzneHqTCXYw5Cy6eI0WuZ6wZLKHfzawBQuD
	yiT2umQ==
X-Google-Smtp-Source: AGHT+IEqdC8t660cmhTSYdvMHvoW2c5074g9eAsdYu18qhy97ttYT1601rGIQiMK2FsGOX+Uk2p9iv9SY39p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:80a:0:b0:e30:dccd:9aaa with SMTP id
 3f1490d57ef6-e337f8c6c74mr13337276.6.1731112699203; Fri, 08 Nov 2024 16:38:19
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:59 -0800
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
Message-Id: <20241109003759.473460-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003759.473460-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 7/7] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14621f39b375..d0c65fad419a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.47.0.277.g8800431eea-goog


