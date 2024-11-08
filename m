Return-Path: <linux-kernel+bounces-402155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE99C2474
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D39E1C244C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6E227BAA;
	Fri,  8 Nov 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbg8TK2e"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536B227B93
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088204; cv=none; b=dVEt4SPtOClVllH22dnb2et/h06Oy9Y/3OHNzR1DhPKeNhrWqwIXdpnxuf2GPWw4KhV0IOxZEgZr/Mtwb9U8lEKFYhFKvl5gvYur1beQmaJaFPtCfgfMwQzCo/jhqm+hWlLcbTTph1vjpJ4QlkiS34yCKjFqCHiP+Ja+uxXsKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088204; c=relaxed/simple;
	bh=rmktKWgkJHRVy/ZdsAA0Vc65puJoSfAalv+s0diLDGY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uzTxZOLKnZchA/DKmwOPwVvsk7vQzpsOqAh/SOd+1kFWpNf0YgrsHAhsxrsbNxIHFZDahyDBgliSq41qDdsUYYZWfBPjCPJj+XXkvwzKUSYahruYtjKcLnf1PsHH3am+aaIlmZam53CyebYGpa8po36VOYXn6p/cryGuOSjfHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbg8TK2e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30d7b4205eso3764436276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088202; x=1731693002; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=hbg8TK2ekfbl7b7fvBanQiotkExyxCobWs2mC9Q8Q+Z1rqvs48ih7NA9VXbGcZUjCp
         BJxI9PdavZQtcdTVwosMLdTOlPAv+79BmzHrV8YHKPEvNHs1gzCQwd8DBnN3jE0YWmZV
         6/XCGLhln11CrZfeOA0dvMu79+krIUIPWec7fkvL0oXY/F1MDFT6Pomg+o1JlkFqc7Hk
         9L46e1ZajhVLTciJvSC0MFhZeK3LhrgBjrj9XsZHYZmWXYr5MWr9gkey8YNO2Pk9pzpw
         /jRuZKjj8z3obOmeY2oig1TrRernTbcVHjWbq14fdXdK8bVz2n0HCuJlrhqmnzOrW+zC
         /R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088202; x=1731693002;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=RDAlAh6KBcduoseCfFrnO8E2HUb91oL55My8z1pjkXA7cmx4tDKInkM4D5miXaN2RG
         WavUBm/iUZmqoow63Wp90hOyIGGfl+OfUGKkLk0UJD6/Sam3gC8RXdyCyVRgFAkkrw7N
         dX71y0snXTu+lo9hDtw/tDcPd2SQpt42Regt3y++FsmCHt1V8hl2TLSRIm88O0Kt6E2m
         uiuuoZshXJ8CmsGR8BInFtymh3gCQkLhPiho72w7VAF3JGLBvdvwANddBrg77orGguX/
         6nAXlMaGHcVMz43yQDjApyapU0yswbb6xnRahvW2ARP9/2iuZ3MJEiWAuoxlIQ5CJvKD
         OHfw==
X-Forwarded-Encrypted: i=1; AJvYcCV7cf392ANJgfQtd7uGNJhgm9GOhPOwihOUrUz4ILqIASdg5jYU//0h6mt4JT+xD92N0gJdgbVHOugb1Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYE+B6gWzsh+mRP+my/pkJqKp1iOGa3nTbadgLEPINfkNH2T9Q
	XG5UOTamhOCbuV7H330u/D+igoDJDCDIbf+6HaJFjl22gFxBEMcaMt9AotyxIhEgbIjIdCzNbj1
	X96QBqw==
X-Google-Smtp-Source: AGHT+IE6H8CgOpCqJig/S4Vgt0UKfIFpQ/8DXRr9lC+DKXJKn6W/WgeX/rl6HZtxD1DxaonovpxJKCR6AiXA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:c09:0:b0:e30:cdd0:fc14 with SMTP id
 3f1490d57ef6-e337f8ed79emr2910276.9.1731088201981; Fri, 08 Nov 2024 09:50:01
 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:36 -0800
In-Reply-To: <20241108174936.262704-1-irogers@google.com>
Message-Id: <20241108174936.262704-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 7/7] perf docs: Document tool and hwmon events
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


