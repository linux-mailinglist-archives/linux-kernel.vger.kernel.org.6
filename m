Return-Path: <linux-kernel+bounces-533557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33247A45C07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4998D3A67BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1B258CED;
	Wed, 26 Feb 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AejhHYXM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447851F4177
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566486; cv=none; b=Uon/UWSBUn750W7S52KTsIrd2FiKboj8pbLbuvVQCvSZfAWtayGDzl/ajDKy5If8yw+Hnv+Xw1OxVpQPEmKRWmNMp3zsh4iWPSAfqIlMKzfPP3k63cRvTbIuxae6VotS9OHuaG9HZwfDRZ7+G8E8so7nKg0FoBPiXH/rf/1ejAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566486; c=relaxed/simple;
	bh=XRXy6RSItxNq6QnKOnKdXg5Yk8DodK9KEgrENi0WQ2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lmse00uwdeoolwAYuJjJmFwJXe02PALVu50MPX5sHdxRBRnBg+KOpDAIJpB4awbPfNa8ESaFj3lenM26AMM5C9pey1CX9SAm5Y7Fm5o9dwTzLLSmLTbjFfWLBigmLRED2VTzNnmljDym20FCCLvmsJwtlAeAjB8mci3seH/3U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AejhHYXM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so58089245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566483; x=1741171283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Io4l6/kfa0Abr7c2gr2/O0xUhpbW7CfkwJb9n48BOE0=;
        b=AejhHYXM1X2OqFulETr1+E5mdC+oPAllJ4ttBkAK18cSs7YRVg61z1TMVs6y3nTL1p
         ufoSUADTlOTl7rxVN/a5+42rq3iuHgFzWP1n0PhxkOlnY9Dsp4iEY+Jqse2uEpQtwLQc
         +VZuQtM8AF7iWB6IQMVSISmojak2X8LoYvvN5lx7jDoqto1GeMdJa4dEfr5EHAf8WCcj
         BkovwLHZjCcxU5BxDtoWDcWhGPF506QkIABbWGtNM5dtSZUEgY57B3bSRNxFxc2C4nZ7
         w5gYssY1jGopo79D4t1nrq01/Jo9Yn2/t3SPQUadKQa5h7K7+lIeSwq7fcqOB3y+9EgY
         JcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566483; x=1741171283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io4l6/kfa0Abr7c2gr2/O0xUhpbW7CfkwJb9n48BOE0=;
        b=r3qeRY6AcXcoHyK0cCyejHD1mmSWMpe/kmy5B1LUed+JpcdJ8BC/4tiOB5QQszublU
         oym35jQ+u7NtZFLigUIVFC6Yfh1M8Vy7hYcHZVmCltl12OQh9ijjcHPmEOOsFV4BAwN2
         02Mm8ORVnDesjAg96vemWbrgOV/LMUgIu2ICXL+WrCvOus8bttU0ZY1fV/ST23JLv5sy
         hyFozNFShO1BLXbbWkg9SmfqZeYVv7fwreSwF4Y//jkauxaxxzQ+6diW7bJfzNdiQJ03
         P6M3DCtOHh/oymnshU06oHp4zTY8/pwUxXSl1Y6hFD64M+pio0VZX146tJQlwDLHqujO
         SCdg==
X-Forwarded-Encrypted: i=1; AJvYcCWtzEy0MM6iLyK/fuAGU9ZKsGKnPKa4ZASSH/CBG2suepvsJeAXsQHBs6bNQYvaAP/h7gUfF45e0KeaPf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9uDL223P4zBFNP9R+Ld56w7ZKg83vhuazSKhjXCkSYWaHk1w
	9nLq7LUsfCjJmxJyQgJpHD+BC7xo1UGE4ohRze4woPf5nUCf6lFyqBuGphM1CSg=
X-Gm-Gg: ASbGncsUXQziuA66lyiKWxyRUgPCtVXfz7juRiUQ1UtdR6zc4JtCEEQ5gizhIx8BAOl
	8RUvZWwgcQl9r53NEBOhw0kYdgPlssbsjnT4G6rCCrs+tKmffj9TRbc2jZBmVI/sU2DUsn+r6CH
	PTiZyGmQ1Z5Y+8i9P5umBZXXg7A4Na0Kc1nWS8OtywAXR0je7fEn1FgosniNEtSLNd7Sr3722O9
	KCRj/KnbfSf4DJYS9XgjEfoi66F2zLz3OW2LDO8SNLcnPQD5NkFa+8Y7PGpN1UZ9ehwgmgTcDUr
	PFVTNpTrdVm6js2ADcKGbmjUCnI=
X-Google-Smtp-Source: AGHT+IGM/5sKGlj2yIGkYDThiqtYqRuGy0u3oCOTR3Uv1tGaYGxuD0FRM9XnnIUJokzK6qFNma0+pg==
X-Received: by 2002:a05:600c:19d4:b0:439:34dd:c3cc with SMTP id 5b1f17b1804b1-43ab90169c6mr20461805e9.22.1740566483568;
        Wed, 26 Feb 2025 02:41:23 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm5080832f8f.26.2025.02.26.02.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:23 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] perf pmu: Dynamically allocate tool PMU
Date: Wed, 26 Feb 2025 10:40:59 +0000
Message-Id: <20250226104111.564443-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few minor fixes that I came across when poking around with the Perf
list behavior on hybrid Arm.

Changes since v1:
  * Rename perf_pmus__new_tool_pmu() -> tool_pmu__new()

James Clark (3):
  perf pmu: Dynamically allocate tool PMU
  perf pmu: Don't double count common sysfs and json events
  perf list: Document -v option deduplication feature

 tools/perf/Documentation/perf-list.txt |  2 +-
 tools/perf/builtin-list.c              |  2 +-
 tools/perf/util/pmu.c                  |  7 ++++---
 tools/perf/util/pmu.h                  |  5 +++++
 tools/perf/util/pmus.c                 |  2 +-
 tools/perf/util/tool_pmu.c             | 23 +++++++++++------------
 tools/perf/util/tool_pmu.h             |  2 +-
 7 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.34.1


