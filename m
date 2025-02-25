Return-Path: <linux-kernel+bounces-531959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0629A44737
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0D67A697B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE61C861B;
	Tue, 25 Feb 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mb1rWkWa"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D791A08BC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502057; cv=none; b=mWIsTeR2s62PqQw2JIdZeQFnCTbQUhKIc2KxGgFLSyXdBnv9JKXGhWCoDZUt6LyxxPM5fOANRf3zmTUNeq/PLVOci4GgGpTUm3VjMqdgPyJQu7335ckIWvIk0AHBtX+lYP8JthbFVFrQWa3Ly968D9hzL1j2ERARO/TKVbtp5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502057; c=relaxed/simple;
	bh=vZO3AQe7+CZOR/U3Zg+1o41nmB25hPOspCaBT/odcNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9WjJhufxX3z+w//M/cPRejAIbgnV3gexi7qou//7lUsigiWDJDkwzwev3Btjn5yelp4qdSSJ6e+uIXBSFLpFCicE02jH7osEwVKWhErnORpkJH57fTe/EmviFt2ex5KMk24lpNqyrSC+IsfyTQeQAcEIxHaPJ7BiS9465yPDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mb1rWkWa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so56937185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502053; x=1741106853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD4YPrrWymRk6rucC/v1JXU8kR8dNumKu6tLq4ELeWE=;
        b=mb1rWkWa7YMG1EkPMWOFSDe8yfK3dLX9c+lVL+/so0ZK6jRuatm/rkZ2MCiLNuTzPm
         0IDBrnGwpQlgmnfTv0YScD4VK0xmLTZGP2P0ZgAlKHlrL9qk2CsZjOd8sufEgiYgaETv
         kzDY5+yLsFmqGhWjaLB1gK5kV8FIkq4GuD/P6y7d8jhKtHWcEAKdOiTmE4WGNZSTokl5
         jRvXW/ETtPL5tgKVdhE/BiLf3D1U1apwMX5AosDBzRURVa2rDNzq+b9GdF5t45TgGmNM
         fh7nLTTV9qxom+PHEeK0VDpY4y/Nm4wwAzt9RBH+AIU5j2YUGzjqy8kfFo3VPDqjpE4q
         0Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502053; x=1741106853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD4YPrrWymRk6rucC/v1JXU8kR8dNumKu6tLq4ELeWE=;
        b=fCvLry2E1C2huBDXzRBlQuJME/g6u1rww3cV65zd3iL8tykv2DTIyEhVfLtA53sKoY
         uCIZVZL7wPRqEBPsMasXH4oiEmYdaJvOjwp/zx6d3e3i8FcAkJHiYIQT2BQ0R88ji/MO
         2WlTJ26GGbekqmYG8/jIcXOPozsRblj4WzOOlsgbYfuDfd+gfOa4BzDzxJq8hbHC5ztp
         1f1cNPmUpKDAudHiirrF3iU+k2Dy76tQRNL+SVneoH3oOxIiGw5XdOGb8btz8fhbsumN
         soBaVyzYqtEMFhXskCCgNThaHblIeUVjXEc4CPaAVWiQcRIyn1Jopt3Ux9J8WQW1bDKi
         +4TA==
X-Forwarded-Encrypted: i=1; AJvYcCVYDe7oXHLIXFoAI7tQ9pXfUevBvEJx1TU5SYFZoSbD+BiJIyoGbH8j7B/YOwbZ94t15JjIdt4Ois1FSyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUFFp2jHmXLf6XrRqk48Q9TMkE6rMi6xndE/cTPOSxtspVcYZ
	XnWcSQuGC1RO0ODBOwLCPBA4GZYMd8BmIon9vZAIn4gW5mNI8y/iQCggUxKPo7k=
X-Gm-Gg: ASbGncvVHuFqEZRYQwY9PcWzLdb9udbGri7aTeXPAJrhxsDdJVQIR65bsKOqRsm+2mo
	vgmAFhWbEUOYSbpC9wiIu+3X52Er4zyLEPpECB1YJ0lVsz2c/magbIfAoHs1kEPiedUZ0JflAxl
	HqyX5Q/FJrkQsrKnPDpTiA6Te4cX6GwcsVCJKreQnMZBh0lxsTT8eF8Rzal22jIAb4HVYURDOYJ
	7/qLZ9Nm7hcZCs5I/bjpPtl8MzOU4/bfD6B5AUglAbaDVxq0cBHIhj2EJwDOe4/haVzqWrEahy9
	KhQyMrA2fNHAMKBNpb48LHnGFA==
X-Google-Smtp-Source: AGHT+IH5ZcoPzqCagrsFUM8SoRpAwVswd6FpNDml9RsM7oTLv0BA6f40Ah7/FOS5lM9Vwj5qLNvnWg==
X-Received: by 2002:a05:600c:3d19:b0:43a:b186:8abc with SMTP id 5b1f17b1804b1-43ab1868ac3mr38322035e9.2.1740502053232;
        Tue, 25 Feb 2025 08:47:33 -0800 (PST)
Received: from pop-os.lan ([145.224.90.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab154754esm32072415e9.21.2025.02.25.08.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:47:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf list: Document -v option deduplication feature
Date: Tue, 25 Feb 2025 16:46:30 +0000
Message-Id: <20250225164639.522741-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225164639.522741-1-james.clark@linaro.org>
References: <20250225164639.522741-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-v disables deduplication of similarly suffixed PMUs so add it to the
help and doc strings.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-list.txt | 2 +-
 tools/perf/builtin-list.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index c3ffd93f94d7..8914f12d2b85 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -27,7 +27,7 @@ Don't print descriptions.
 
 -v::
 --long-desc::
-Print longer event descriptions.
+Print longer event descriptions and all similar PMUs with alphanumeric suffixes.
 
 --debug::
 Enable debugging output.
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c19826f218a0..fed482adb039 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -527,7 +527,7 @@ int cmd_list(int argc, const char **argv)
 		OPT_BOOLEAN('d', "desc", &default_ps.desc,
 			    "Print extra event descriptions. --no-desc to not print."),
 		OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
-			    "Print longer event descriptions."),
+			    "Print longer event descriptions and all similar PMUs with alphanumeric suffixes."),
 		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_STRING('o', "output", &output_path, "file", "output file name"),
-- 
2.34.1


