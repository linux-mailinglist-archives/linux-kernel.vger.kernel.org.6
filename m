Return-Path: <linux-kernel+bounces-406266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748B9C5CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BD91F23B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94E202F9E;
	Tue, 12 Nov 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smRvCkBx"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1F20262E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427271; cv=none; b=KkeW69hMreZwSxQbDq4HD1uNULcZsQgNX4IRH9pt6DzFRct70jRg7ZobRwHUe+R28iIF6gT2S6Ys0UizMcLVhihRoeONP4cePIXFnfICi6sdsKEra69qUp5OBUKYSx4lBLMQTfNvWFNcgufUtXHt+aVsR+XI5gzXHpPQpZQiEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427271; c=relaxed/simple;
	bh=UAcGazzCp6/O/W5MzKvdpcujovBvjqAvNrpyKPtJrfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L31z7ue3ixa/fkQ31dB0GMyDhDCGJQHLpD5lGfMGkzT51kPAclfHFeiRwrFVmD6HxXe0nVJ0GWa7K+sHXphl7IJRF4AlEIbnes11Wb0brIjYToAxocMDi17w1TQeRlAfydgASaKRgvy7L/Bl4vjOrcGqPqfcTmwoTpZqPwZrHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=smRvCkBx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso2528848a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427267; x=1732032067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOEI8UezSMAVzR/zNgR5LZjC5DnJu/D/ladTewPTC3U=;
        b=smRvCkBx2EbvbhaiGiZ+XqJy/17grEqFfxRI/NJ/FkaShRSsS36QK/46MxON58zCAp
         vlJWru4j5J+voyFyLXTTBjYseI16ThByhl4MVmtrR5r6EgOmbOE2EFH1JwHodfF1qgBI
         rD8BpdWF3x7UNx8ZTMZ9rIM1PRSpAogDvGLJDZYYwxqWxzZDKiyFS/dv7lkg10u1BbEE
         GXPMWNPvQMP6xSIMDkWYEcZZs5g3y5ghaGBbz81l1rwOpKrIl1GZeKYOFEGHijQf8k03
         Us49INxr8jg1lCmReVRIVPUtm4KZPDUwsy1MoX9hnDAXrIRb9KVnW/e9J3fZ1o2L1T+C
         bA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427267; x=1732032067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOEI8UezSMAVzR/zNgR5LZjC5DnJu/D/ladTewPTC3U=;
        b=BWSXfAwpLqpPkaUpKGW3MKIYn/Er1gbjFSOs/f2IZ53YKlcYNWEYzRVrrO5Xw9ewyE
         7VroK17pgdFnaaZtzFcZM7RfV/lyMo3Z0lnAfNIA+l+IaaFumnUT//6EpX4jF6WFiowW
         yuctDhBEfUB0i5BMI2O7MytBEfhbYjYpmvCN6Tta2hmrCgi4tvnJvI/QsiKOCOKb13b4
         9kqR5+6ij8AiA5JyB7xoznNnxUppWZO/GnbqqFl8LugXfd3Rue1dNBu/P8mQOe6fqxEq
         g3v8zVaRHbdZrg/p/PlHpCSfph7CmejrAN4KYD8hnKraS8tb8gbBywdHS/fiNcRhyW7O
         t//A==
X-Forwarded-Encrypted: i=1; AJvYcCVB7w58LUld+1l5LKi9WsIHU1Usf8hVnPRVvQkHJTRnL4j4mhsfZUqGFb7gZOXG6+JXcO3yPpkIyhGXHbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4nBTUUNBXaCGS0GasEbt2L7xIMKBQ9srXEmN/8aF6eEqAV3z
	YYI0nBmhfGXG7h14hQMLwQA35/ladxBKhQN4OcGM9hJ90QuoFPjFcw+6J+5KiXA=
X-Google-Smtp-Source: AGHT+IH+CZ2kdawDB1g8i2yUpqSeBIFmuQev+NUGYW0XZmJCMTwAMWirfE2v1Z0EXkcL3is4/Zg/4A==
X-Received: by 2002:a05:6402:4021:b0:5cf:1214:8146 with SMTP id 4fb4d7f45d1cf-5cf12148226mr17482294a12.4.1731427266960;
        Tue, 12 Nov 2024 08:01:06 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:06 -0800 (PST)
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
Subject: [PATCH v3 0/5] perf stat: Fix trailing comma when there is no metric unit
Date: Tue, 12 Nov 2024 16:00:40 +0000
Message-Id: <20241112160048.951213-1-james.clark@linaro.org>
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
about it so not sure if we should do it or not, but seems like the empty
metric-units exclusion from the JSON should be consistent if we're going
to have it at all.

Changes since v2:
  * Do more documentation and tidyups around struct outstate

Changes since v1:
  * Don't skip printing when the metric-unit string is empty but pass
    NULL instead of an empty string.

James Clark (5):
  perf stat: Fix trailing comma when there is no metric unit
  perf stat: Also hide metric-units from JSON when event didn't run
  perf stat: Remove empty new_line_metric function
  perf stat: Document and simplify interval timestamps
  perf stat: Document and clarify outstate members

 tools/perf/arch/x86/util/iostat.c             |   4 +
 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 242 ++++++++++--------
 tools/perf/util/stat-shadow.c                 |   5 +-
 4 files changed, 147 insertions(+), 118 deletions(-)

-- 
2.34.1


