Return-Path: <linux-kernel+bounces-366692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C799F8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2842282D41
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D541FF05F;
	Tue, 15 Oct 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+WhKirv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6E1F76BA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026405; cv=none; b=SMfDQMJw3EvfQeVqtKN0IYyUxgLH0Sz61p6Y8ZKDfblBivh55/U2So6w9LGjwV9mGZ/qCM4RqcWmDaqy5hE3cTxuREi4MJqG3QPPX/a2mUnUUb7L8KwojJwgFdkWvKRfqUPPGS21TURu+M3m065FTfbQnREQ7h63HpOWRnCyfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026405; c=relaxed/simple;
	bh=+SQm6ToLAWNpvrKCrPvkCkWCwHhZuo/XlKSY+rp30bA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LYRiSHC37jbvOAZFrpmuO2g6vraZBO2ri3NEAgr0CFytSbHggIOUzP6yrU61z9X6NJCiJD5WCNjCezkGhrjbIpNQiq2uaIFtflAmCoXEIzy4aYFKpx5afAaxi6aNI1jpLxfLnpYC3598jHiZHnhmfPwknxOIJsVvyuhHBZPXwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+WhKirv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2954ada861so3701088276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026403; x=1729631203; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRKQqH4Tzsyn1CLHPprrZshwHHnu4oMEFPacs+PDqiY=;
        b=Y+WhKirvLRpan+9onwEFGxBteaSSnBrRpnd3EQxwUDJLeUFAbgqe0gZHLCPoMyIxPO
         VU/sWAFA++lO6G9f+BbTaV4nR4q4DJiucn+k6IuSokZpr4O27Cy54ExAsHE1qCBw4Yrr
         mZ+m09c7veyNoVS92J+vIvU1UoCVhbZGTTmo70sy5V3CMLZeg6bOAJEVUOpCbm1YynKU
         8MbYItU6kycRJkI2Vj6N/q3Kt/Uzw/NUC/88GlWye2d6ptpUg6fctFyZqMdWd1OvzhUb
         eXRMw77FJhW6yZxpBa2JGFNWQP+o+KJ8lTjQhPaxdlrXFbnbLlkcKJdG6bz662lLFiTy
         OBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026403; x=1729631203;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRKQqH4Tzsyn1CLHPprrZshwHHnu4oMEFPacs+PDqiY=;
        b=I8MJlmc/MB6fqPz+qjP0CTNJ5m2xEGnawqzbE+zLB5Z8A4MBs+2TjO5p7BgPW91gc/
         heZBar+S6UHjZ3+8L6jnlq4bnACbm/F40ML2oDA0TO8hzotV5Sriu1e9q/pEy9A/qtwi
         9Fl+SNcCD00bMGDNSsbW6ydBjQIjvsHUOttykygK1Dr5J/jBsMHGxCJ8B8FNHvoEY+J1
         0TucDhEIjBdhBxik9NoV+1o/EArp4bVDCXBCI/A6mLbArIArk9aSIuyuhZyGW7xlTPKR
         hJhd2tQ78DKtVCt6Bh/l13mFcyBIqI4qBiSBhk9XAKmybFKqBsUS6WJ0Bm3YF80ypU4Q
         1Cvg==
X-Forwarded-Encrypted: i=1; AJvYcCX8f0//L06wErqoPq+CjbQRWyvBqIhc3pm+48f7Blnjqp40ZMofb1ciKmbDmIR9iTuAUHJe68SLTmegnMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDdf2FoAQRYrYaZBtQyZutkD/q+ywCKS72XYeML5XEy7O0StXv
	s7hg5Bz6t6FbM2h5U8PwH7bz6Xwmwzmc4ihdB0czaVHwZH27BM7JORU4dWvabvr7TogmN1zHMUP
	B+QnjTw==
X-Google-Smtp-Source: AGHT+IED+Vp1JVzDA8jd99+Eah7CILHxbTgCUnpTT9+NNJfG5lamnYAH4xlDurRkKmIkkbuifualo82lAQFu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a25:9e0a:0:b0:e29:7454:a4dd with SMTP id
 3f1490d57ef6-e29782db2aemr1382276.4.1729026403091; Tue, 15 Oct 2024 14:06:43
 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:28 -0700
In-Reply-To: <20241015210629.1150428-1-irogers@google.com>
Message-Id: <20241015210629.1150428-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015210629.1150428-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 5/5] perf docs: Document tool and hwmon events
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
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.47.0.rc1.288.g06298d1525-goog


