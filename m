Return-Path: <linux-kernel+bounces-366063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8965099F056
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A242B22A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80A1DD0E0;
	Tue, 15 Oct 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSZ2hddO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96D229100
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004093; cv=none; b=O14I8xrWoAvCIF++1cM44eaxJITCOFoGT6DZdADDu6t7zn0hIJoXsWykHBGnZKTv+0K8V66HgpnpmjyQV4pNbcD++yCpNvlf9EvV9pR2iHOA6hKqJMPOxbEGFom1pDEbQyrsOLHkevQCX30sq8V7TMS9nu2BXq3J4Wk3IcJo0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004093; c=relaxed/simple;
	bh=RQYGn2jIDYaqutoCESCR+eXIQFlOxeIgFw1cN2aVNGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbbHC4g4p26corgjDmLJGOnevES3ykPXqRAdAkPXyZxEgXbISgePGrZyFZPIcPsUgLpkaf5dTIzFu69rxrv1HXyRtLVLpeMXZfyXpBTicKVDlwlc2eged/gRShQwaTraQLaElmArNRVFONFuEPoi7gSeJLEuly6zsTQzQ/Id7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSZ2hddO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-430558cddbeso37495825e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729004090; x=1729608890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNppHPuInbdvtUJgo5QglFbpfisVUb1nYRslX9GMCO8=;
        b=sSZ2hddOXxGHUGs0/ccFR0WLza0l5zPbzWUqzFqnds4HurarRb+JcoygrVZCJ34lNU
         lY051aK99MQTPVVO/N+YSQxqAHGh4rBXu9ej1R0qehfcRRbJkStog5uJLA/jSGYfgPYP
         TqIoduW/a+Hy2koXE+EY/8WuA1Vd/GtV9QN8UBu5XARgvV2dsUcxDnSvVtE4f6g8RGbf
         sXpUNLXg0rsLETcAE9QpuCc+cFonwDyt21GP2qMApZGBNyAqxvqH6h/WAicXEHZG36Nn
         G+828NXbmQlTuhCzjn6rHEvus577sS5tJWVKIEUO4Gi52K7sYZX+JECz77FXR4jfpWZG
         U3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004090; x=1729608890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNppHPuInbdvtUJgo5QglFbpfisVUb1nYRslX9GMCO8=;
        b=m/wjYzlAU8DIL1yWkjocYJBeh7IDN20zLTuZeRtJXKGsLSQIaKIdotKFgz9ReT/Fzp
         30uUJ9LYZCk1LjoU9deDmFQw2y2Rmr9ilXw7pAKoyvGDN+WCG3kYLO0bGyikCscGe7wL
         Q6xNz4t31aSbttLrbZpTLkQ5Afr5h4r/+/zAmhQQe7FZ2zafry82s6EXTiZf4BGtVD7Z
         P5Fc9V5P6S1zbuhGXfSBpcvhPBqiptsW2dTTZm4ftVVsV0JfpPMLTOfH7Gl/MkMnyPtn
         3LE6+n02ZycxeM0wZiO0aViBKI7ee8SwG0hG3fqnIgKPlg0EvF/fV3aho/E8yXxcuGGq
         7a1g==
X-Forwarded-Encrypted: i=1; AJvYcCXtQJzMbrfHe3VqQYNkF34H+LwAdZQz3bpRdi8ZhlynbGbTgwvWGWZ67rdBaGpRjqe/K9JgblUvS8p86NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth+D5/FX6VmPb+cDIkI4Uq5FbV0WQfzwy62WWZTBZ88kGN41u
	n5SrCIfMSNWzRyuy55oJBJfizOpTltFgeoCR7+dKGh2uD1CXR+YGf34pJcu6ncw=
X-Google-Smtp-Source: AGHT+IEzjo1rKrOzsn3saugp6Nyk3pZBYBBnzKAPBRpXjDasPkzIHtcBAjBta3AKHNl9TSCoJQWSLg==
X-Received: by 2002:a05:600c:5248:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4314a3abf68mr7691945e9.17.1729004090227;
        Tue, 15 Oct 2024 07:54:50 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f20fd99sm20363955e9.0.2024.10.15.07.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:54:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] libperf: evlist: Fix --cpu argument on hybrid platform
Date: Tue, 15 Oct 2024 15:54:14 +0100
Message-Id: <20241015145416.583690-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed that this isn't working on Arm or Intel, and I've attached a
hack that I don't really think is the right fix but it does work. It's
not strictly a regression from the linked fixes: commit, as before that
events wouldn't be opened on multiple PMUs properly. But after it the
error becomes more fatal.

Posting the RFC because whatever the fix should be isn't straightforward
and probably needs discussion. I think similar things have been
discussed before about the empty cpumap issue, but not related to the
--cpu option.

I thought of a few possible fixes:

 * Don't open "empty" CPU maps in Perf. This would make Perf and libperf
   diverge. Also not sure if libperf is supposed to be backwards
   compatible? But this would be a breaking change because someone might
   be using empty == all deliberately.

 * Prune the evlist for empty CPU maps in every tool in Perf. This isn't
   great because users of libperf also have to do this and is a lot of
   duplication in Perf.

 * Use cpumap->nr == 0 for empty instead of cpumap == NULL

One issue with the attached fix is that you can only delete the core
evsel from within libperf and not Perf's part of it. Also maybe it's a
bit weird for the propagate function to start deleting things.

For reference the empty to any code is here:

static int __evsel__prepare_open(...)
	if (cpus == NULL) {
		if (empty_cpu_map == NULL) {
			empty_cpu_map = perf_cpu_map__new_any_cpu();
			if (empty_cpu_map == NULL)
				return -ENOMEM;
		}

		cpus = empty_cpu_map;
	}
 
James Clark (1):
  libperf: evlist: Fix --cpu argument on hybrid platform

 tools/lib/perf/evlist.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1


