Return-Path: <linux-kernel+bounces-340616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25C9875EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BD71C2431D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165E146A7A;
	Thu, 26 Sep 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zjfub3xD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12608248C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362153; cv=none; b=n8DJSbAz9iYNwSKjFqRXpfxgPjlu/j4ZHk5LBL45Bx+uRDSjt+vH8Df3Qw48muHBXbwgHrWTUx09b8zBT3uXWqUZBC+TdseysiSb81RTCiZ29i2Ov0LSE/blH9trxbmzHwokyB7Wb/Y2ePhgFgiJAlZL5pdquvecHuFwuwGlv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362153; c=relaxed/simple;
	bh=OSGnjJWD2AUBP6nI/tMbL5fnjDrNC3+r3I4DIEtTgjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FK4fs+NDjhIdrzGmLeULUsFmV43ZaRHrGG/iDQftRwDeRi3aRA+HZNFvYHQaQ66oOLlh8+WA6t16MmGLUxwAqFX+D9tiFTTTnhUoQpfeIJdhbCUhbsOAojXdz5WK9Cm+8x3PyCh95h2pSFQNDYJ9c2Zdda87LS/qsykpOZsCIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zjfub3xD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso1292186a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362150; x=1727966950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nmo5sfzFJvh03XPWULjDAkriT3KqgWW1PyKr3ieQ8E=;
        b=Zjfub3xDLVwsPxCVtUBlN9PtOwFkf/3Ab4ki7gbbcniEvFQPvTn//qoCJ7lgL8HE3e
         jnfgalqHrOSCSrrO3FsVU/5jf9XWdWErjjWZsZzpsez9M5MwsBJIcba4YvpdF/KtNCI5
         gIR6jbRvD5I1ij1x8She+RLAYk4tqnZAPBhoO/vvxGb8h8gaiI1P4l30/9ipUxUz+kiS
         0biK7ke0yc8uVI6yZXVxM5DIoSdUF01fTap3+mbt8VoRGHH6z/S9nXz++nEr26D3pErc
         NIr1ttyJyizmdXeBRV7HL9RAPlmqXwFhIS61xbABQI1WpM+/T1PvQguJW1qmbJylgwfP
         4ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362150; x=1727966950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nmo5sfzFJvh03XPWULjDAkriT3KqgWW1PyKr3ieQ8E=;
        b=YfNOqMiGr44K222N3xCJQF2WWLE2bLqafrcD61wcTeaiKIxvANSJxmuNm/o+oaxGX9
         2N0qXDwLG9YJCsm7Hd7vFQRLPF4kGKPl+CcrhwPtya2QwqainylR8qN7lKU5n4gNlihT
         ExqR/D+CBdgYqh2cM6nHo16MZQYuvVGY2rY53TmuZy5svHn47XdriF10Dt2QPc+TFG4p
         S3Sh7/CL9rVaJ0DrkeVt4roM/eQD+ld/1ymh0q8eusuJ7NhcC0RCGa2/YhvhiAT2BY8p
         M5hTvTbTGzoP4nRNZyEa1xmuPPYSi16+1VERxz0r7PZC6nwjH0w2Be53FctUZAZq3zpg
         eX1w==
X-Forwarded-Encrypted: i=1; AJvYcCW+BTmBpE5+umiGTh0E0AAXtdQ0vBxWB7MhXV+wn3ef8bKEDrpnlvajHKYwq5gQf/yqUo17ObUOqQ2RMHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIfec377DJACnXo4FswilAsNU/lgBYMe1kJREBOy4PbHMSOAq
	IDUfvjowmar/IqgK9cpbAwzmzl+VZ4fF6Wv2CXPAYONdjxMCfsXbFm4iirxVwA4=
X-Google-Smtp-Source: AGHT+IEEXyvhJCDptdkfXlYuLzjr9lZI+o2LHFX4/RBpRoo60JvvnSuQQ77087WzgbwG59bASlVU1g==
X-Received: by 2002:a17:906:dc8f:b0:a86:83f8:f5a2 with SMTP id a640c23a62f3a-a93a038c991mr608490966b.19.1727362150042;
        Thu, 26 Sep 2024 07:49:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:49:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/7] Event parsing fixes
Date: Thu, 26 Sep 2024 15:48:31 +0100
Message-Id: <20240926144851.245903-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I rebased this one and made some other fixes so that I could test it,
so I thought I'd repost it here in case it's helpful. I also added a
new test.

But for the testing it all looks ok.

There is one small difference where it now hides _all_ default
<not supported> events, when previously it would only hide some
selected subset of events like "stalled-cycles-frontend". I think
this is now more consistent across platforms because, for example,
Apple M only has cycles and instructions, and the rest of the
default events would always show as <not supported> there.

Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
cycles PMU) and I also faked an Apple M on Juno. 

Changes since v8:
  * Fix rebase by adding NULL check before perf_pmu__is_fake()
  * Keep 'cycles' default event as non-skippable so permissions
    errors are shown

Changes since v7:
  * Resolve conflicts and rebase onto perf-tools-next 1de5b5dcb835
  * Fix build error by using the new perf_pmu__is_fake()

Changes since v6:
  * Fix empty PMU name in perf report
  * Rebase onto perf-tools-next 003265bb6f02

Changes since v5:
  * Test on x86 non hybrid
  * Assume 1 PMU in the test when no PMUs expose /cpus file

Changes since v4:
  * Hide all <not supported> default events when not verbose
  * Remove previous note about <not supported> behavior from the cover
    letter and replace it with a new note about the new behavior
 
Changes since v3:
  * Rebase onto perf-tools-next 6236ebe07
  * Fix Intel TPEBS counting mode test
  * Fix arm-spe build
  * Add support for DT devices in stat test
  * Add a new test for hybrid perf stat default arguments

Ian Rogers (5):
  perf evsel: Add alternate_hw_config and use in evsel__match
  perf stat: Uniquify event name improvements
  perf stat: Remove evlist__add_default_attrs use strings
  perf evsel x86: Make evsel__has_perf_metrics work for legacy events
  perf evsel: Remove pmu_name

James Clark (2):
  perf test: Make stat test work on DT devices
  perf test: Add a test for default perf stat command

 tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
 tools/perf/arch/x86/util/evlist.c             |  74 +----
 tools/perf/arch/x86/util/evsel.c              |  35 ++-
 tools/perf/builtin-diff.c                     |   6 +-
 tools/perf/builtin-stat.c                     | 297 +++++++-----------
 tools/perf/tests/parse-events.c               |   2 +-
 tools/perf/tests/shell/stat.sh                |  37 ++-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/evlist.c                      |  46 +--
 tools/perf/util/evlist.h                      |  12 -
 tools/perf/util/evsel.c                       |  28 +-
 tools/perf/util/evsel.h                       |  22 +-
 tools/perf/util/metricgroup.c                 |   4 +-
 tools/perf/util/parse-events.c                |  60 ++--
 tools/perf/util/parse-events.h                |   8 +-
 tools/perf/util/parse-events.y                |   2 +-
 tools/perf/util/pmu.c                         |   8 +-
 tools/perf/util/pmu.h                         |   3 +-
 tools/perf/util/stat-display.c                | 109 +++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 369 insertions(+), 415 deletions(-)

-- 
2.34.1


