Return-Path: <linux-kernel+bounces-381320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CE9AFD98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8801F24296
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B11D45E2;
	Fri, 25 Oct 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mv/RIVjg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99511D3593
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847018; cv=none; b=eXyL4DCcoC3diZsRY87UGG3v4pfbAAD7C3KVBuYV5yYky9jMJqG93bYDT4O3QvuOUZzgwqb6MTv00z35JPc3CXf6wezS+8lIfb3rQ4MlvwQgLFqaENmjQPKVFxKSvHu6xDBFurKN92F34XIQuFYjLNwec6Wsnozq8rwXI4rJkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847018; c=relaxed/simple;
	bh=3i65461D+4XoZPw2Lwafzn0QzXalFUSDFfgTKdG3+Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMLETpWKc1Ko3miZ1po/pyP5T2BYzwWIANnq5UnihZlxiiqlUYK9G/LpnLiZ/7Pem15Ip7hVtuHeXLXAMt2K9xc60QFsj6ewS4WPf2s8GGqMj2spcceNI4nay/VhzNsnz4yPicCowLeuS/Ptth9jAkW19qzjrbTxaOgsjvCc6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mv/RIVjg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539983beb19so2308879e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729847015; x=1730451815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWvkJJy1mehlDHyb9ikHdYWAO1HcKU43x1P4tAcYbLo=;
        b=Mv/RIVjgc4yGsirx7T66WsFwPJltiDbm517QGQTtCF2GUdZ+GeP1gmEUCrM4b9iucU
         1gfdnZT8OCi84Lfb04c/ZQHpU3/tgeg2N9qLIwWTTqWmXia8Bzvc5cNOWt8e2qx03lUl
         9NvY2yWg78311RibtRqcRse3BhZcNH1QSFBxzju65TLEO9SkE37h+hRTnYHL2ApzzHdG
         gvOMVbHmJfGSam6Pn35AP6p70XdcqOmYtOGIK72y2FcfiYHUHt00GGvrY71HdfblfgmN
         WdOzqdWpOE+vfc1PPiiUub9w2cG01GR+RuYNQHliSxyOf9aBXFM/S4dJHfKpetw26UcK
         whVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847015; x=1730451815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWvkJJy1mehlDHyb9ikHdYWAO1HcKU43x1P4tAcYbLo=;
        b=siPnq/Q8VtA0fEmR16hxYYNLRyATSsFygy+JXRp+z6GObwew141vTSyGJqPor2utnW
         8yi8uYrdSOphjWNNJQ49u0AnqLl1hCB5ZYEj3XabHyMjoIOphjvLqKLf/xZWae6HKeGo
         hPCde8qN7PK7LdS1sMPog/2ClFMDSW3+r86MFtiCEoFd85HT1jyL2H/QCZ+R5XZ4uq1o
         pipsDmMWq9SaoNpk4JEvQIfEm6ATbUweK/s7dbwzMZD+wSurn8OBVWCxEabexbxz7BXJ
         u5Uc5FnsxWvIgoW7/XswoXsBjOdAJme92hBP+9e/PsmYJLArgqmWL0X3VrqcMKG3urCq
         iv6g==
X-Forwarded-Encrypted: i=1; AJvYcCU6ydp4jsuweS4r8CgGBKT5AKzPYxkXrquiGJebhhbRPUXP9NcL+lgcMn/afAoNlzjYylN9PCkDOe2D+C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIZTYkO6Y0jp+6wk0mCAPUy3FKFB8NB4TZy+43aV7x6SFIBEL
	2ovHrFLJXU9yCfdOuD9IVtRAXOOdT2LkgvR5M5AOgSNMYL3VuC+tquPJDsXpzsM=
X-Google-Smtp-Source: AGHT+IFn6MK5AhFx/uFQRxnLybRiy2rqn/lh1YAPpdvwpcC86UlBSya7gDvIKw312BamyODsOQ2tTA==
X-Received: by 2002:a05:6512:33cf:b0:539:dc87:fd3a with SMTP id 2adb3069b0e04-53b1a2fad1fmr5420922e87.6.1729847014945;
        Fri, 25 Oct 2024 02:03:34 -0700 (PDT)
Received: from pop-os.. ([145.224.65.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c73sm988689f8f.72.2024.10.25.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:03:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf stat: Fix trailing comma when there is no metric unit
Date: Fri, 25 Oct 2024 10:03:03 +0100
Message-Id: <20241025090307.59127-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit is failing on Arm and I think the fix should stop more
trailing comma issues which keep happening.

The second one I just noticed when looking at it. I don't feel strongly
about it so not sure if we should do it or not, but seems like the
empty metric exclusion from the JSON should be consistent if we're going
to have it at all.

James Clark (2):
  perf stat: Fix trailing comma when there is no metric unit
  perf stat: Also hide metric from JSON if units are an empty string

 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 179 ++++++++++--------
 2 files changed, 105 insertions(+), 88 deletions(-)

-- 
2.34.1


