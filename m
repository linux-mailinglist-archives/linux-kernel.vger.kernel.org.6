Return-Path: <linux-kernel+bounces-178208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A48C4A72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56761C22DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92736801;
	Tue, 14 May 2024 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXGBBIdx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C837B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646506; cv=none; b=rznB3+ud/tjGaCuXFLQ3IXRUMEAHlFeVlDKIPapKBxny8o4sVYxcvJi92Z/TqJUg70sp4Y9DMjuj1ZFgCGy6VF+LF8KYz9P1Xf+TeFimUFxp5vAQfKxCIwVoFkO/yOnFj/9BqTlLwk0iCNb64mxPN7HzVE6Vi7JfCg5cxxePevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646506; c=relaxed/simple;
	bh=5a8er6sN7WB7QIJ9lSXZpimqvDl+BduXwFtMIlDMSPU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ekGcBms/2kAF+lBmmDxj9utloO3bzirLkQopEaCy1Qz14Lw56ZHXaJpPYfTOT/CI6GjQENJ1MqtcCNhqRjYSbLGMj5Iku0MEbAteaFWfENSXjtXNDX8Cahxq/VFY0D5H/jIC2WvK/zhMTs4muJn9ofmTT0yBpWccX59461DQYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXGBBIdx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so10965140276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715646504; x=1716251304; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UQNrFfmCY/F9lJfCct9y2gwd0jA2l7EIFDK4kqkig5c=;
        b=hXGBBIdxvbjvdiNSE+4Yxg7FiBgf8eAENJMdivmqrtS4DFQyHvcZ2rZCW+iW7+orpS
         RLGf7DxciE4l+tkb8rZvyZVTx3pML7Mk2DeJW/I0+AvC6VbI2HlM8pkerJx/zkFLHAA8
         MQI3BxwwuRYx+WRmMdZoEYOG41K4GiplPLnGsxhMGZ/4ZveSORItmKRt5UyyviexdPOF
         zBIVTY5naSxoQkRpxTe5u8BBmceSPCiq7r5Bd116AdSZEMkyWzyhxp7UYXVhxcxbrsEZ
         jbbSSZGHev4pt+l4YWxM9kc7JRNHPIAYlCqsUoSP+WF1irG3Pey9EskqhiiJXsz4GZF0
         L2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715646504; x=1716251304;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQNrFfmCY/F9lJfCct9y2gwd0jA2l7EIFDK4kqkig5c=;
        b=Qzys2zYjhjBTShycaFQsPgfh41o8pH+f4aWXHfmLL0xS/nGWKU7UyNUse0IATeBVWr
         tJshHfnCJIJz6e8a49U5JJuwAhbEp6Tg+XsGsnU6N4+JUF4RsIaMAvsDRV7NyLXSJE/S
         YaP6DpQmr0MInBFBybREb4NUTtCZ2PIoyt20xNGaSPa30dRqi7TNiBCpYSpG7wOM922c
         N8hTKVspBTnrqZkXLCnVUBwd4vpK8XiQ6/P1HicD58uEk+jXMg+YK+6b4uQZKGsuGZ66
         lyDmtWojyM1iTfUBAFzE9FGIPGmczHf3JZgPINH9+Lfcb/3yY6cBPrGwicy+NAoufz56
         lu2g==
X-Forwarded-Encrypted: i=1; AJvYcCVqC5rTNggLGS2s6meYe52O8US35jfjJrtATP2csQcM83Djy+ud08uZZklE2voD7Lqwm/1jtQh0A81Kb5gpH8Jt6knN4IDCCQsQdC5w
X-Gm-Message-State: AOJu0YwSSPqgxs18xEikG2oLPsLa4BxqTKl4QhBTsIcVw31rdmHEGKEA
	H89vosG8IHRXr+5PDZWQ5ZUBf8/p5ZAZ07L9y45g9GzTSuFkmG1d2/YKnNRsYlVpdIH8O6CjaB3
	gvd6Kqw==
X-Google-Smtp-Source: AGHT+IEFqZ+uf/JIV/YaVeUrN3oUC/xTY9i2WYROhr13Vv5ow+tJQycb4K9zCOqHA5UL9dfuzt22mGF7L+27
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:6902:100f:b0:dee:5d43:a0f3 with SMTP
 id 3f1490d57ef6-dee5d43c91fmr2523877276.6.1715646504489; Mon, 13 May 2024
 17:28:24 -0700 (PDT)
Date: Mon, 13 May 2024 17:28:15 -0700
Message-Id: <20240514002817.2896240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address
suffix. Current PMU sorting/merging code assumes uncore PMU names
start with uncore_ and have a decimal suffix. Add support for
hexadecimal suffixes and add tests.

v5. In pmus.h remove needless addition of #include list.h but add
    stddef.h for size_t.
v4. Workaround GCC build error by using unsigned types. Don't consider
    short hex suffixes as suffixes (e.g. cpum_cf) and test this
    behavior.
v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 17 ++++----
 tools/perf/util/pmus.c | 67 ++++++++++++++++------------
 tools/perf/util/pmus.h |  7 ++-
 4 files changed, 152 insertions(+), 38 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


