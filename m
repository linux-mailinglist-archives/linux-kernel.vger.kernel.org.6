Return-Path: <linux-kernel+bounces-388610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F89B620D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FDBB2364A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6A1E492D;
	Wed, 30 Oct 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADDBRMIO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE01E47DE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288403; cv=none; b=VT7kVJZPsOKquUhUWM+CyV0Fpf/5KGgx3dD6wFjz/uKYG4xga9bZIzL7A0zSazXOqANdDeQ8o6a3yLCS0jDbhJS+sYjC/AdAlb7NlzjVBCyp1ChTTQTECfK7xGGY+/JHyP1GXPE5yHrbnvl5MBNQoFASYTs6oVif0AT/WeGJfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288403; c=relaxed/simple;
	bh=mIPtaWDJqtsaEQHxwqXP7OxYEV/lwPyYCOJyw1pv6EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYSXkdz/CWKu9PV1sr3Ko2Y2yIB+Fl9D+R3pwxZ0jg6nKkITeSVGtvplsntdrLbI9RAxAj8HNeyrTsF28OvD91GT7lO7AaWIB2Rk2HlYx0tSDaev25qLJmmbXvPOJB7O5EG+3l+Ec4uZUkYnaSqbloiKv88WTY4lElc80jUGs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADDBRMIO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316cce103dso82869575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288400; x=1730893200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsrM4nE/dAWuw/a82LKCSe9qni3gTvXsnkuiCmuf0hM=;
        b=ADDBRMIOH+/oK9e6GcVxF2ilZIg/JP4Qiu+dw1AKFeKb9ksSK8XQWwzyRqIRPYBFvb
         EWxxrGYe6nnAXSuz1xHz9RZmLjjKmfNZruta4N8+6PcqoJnOZSWJ14QsOBcut9vdmmWE
         CfiYi+jkZOPSzkctju4V+ejamta1iNz3/2hZ8/wF17V/5X7mHh6gjQI3wC0DT8bRhBXi
         7hBgc93TxAJO9uU8Tn0DDUJgXlEkglJAyjBojlvYns/E5GtJj0HhwDOxbJuDEP1v1frP
         +VyeTLDSJ4dAgthGuBdH61OUPxREGFVE3lbr5dauSugqM7K5SCRfPdq7B/ArhZe9yKqF
         Bafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288400; x=1730893200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsrM4nE/dAWuw/a82LKCSe9qni3gTvXsnkuiCmuf0hM=;
        b=Sd35QP2Ysqxbp1cl5PHz59/Mvw7ygkDDUEzyI0rECGHHzqHQEk+2/X6fVwmWc2Cj4L
         c9Qf32rnP6fwc2uCuXK8RO2tHJ+yTteJTzVJmNgghk774oA/dDl9InNzcAA7G2ZcOskR
         +8hDS7+2Go2xQTNcf0UG6Ma2zzYQMqwL00J8xfvNxnvkiRfIzkX34BYy9wWyaGnPAukU
         8xythQJswGaK+sB4JBNKf/KFi582grGZ5ojNKM+UVUrZtJpwmKQKJu4Prx5kCA4ZkHJ/
         N+YkdVkOhw9+TFzB1ok0SnUgfxb54yc1+eh8DMBsmhNlufkRqEf5sl1xkafO3OMFioM/
         5APA==
X-Forwarded-Encrypted: i=1; AJvYcCWUBveOBEk/vMIGebZfNRPyk++uwWXhXV57qtN27pHe2vsaOEoTv09rPYXokt7LY/M1npal5DrXj19ZUu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jYHA2B5iUiE2tw2XlJIqlxc47Xh2G7a9OPGHOzbwqNZKhGTU
	xHKtkR3HP9oKMC9cgvU2N9PrIk5i5Uk/UsevS/56y3XaOURXbHP4RkBiZOIi8ag=
X-Google-Smtp-Source: AGHT+IHd/f9EqK1YhUX1cfDfRhSD6kG20xIVn/uvsdBFt4dtEH5o0x6Ry2gsyh7RFzYXjM7VH0/r/Q==
X-Received: by 2002:a05:6000:1ccc:b0:37d:4f69:c9b with SMTP id ffacd0b85a97d-380611e0c40mr13445805f8f.35.1730288399847;
        Wed, 30 Oct 2024 04:39:59 -0700 (PDT)
Received: from pop-os.. ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca6f8sm18885045e9.39.2024.10.30.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:39:59 -0700 (PDT)
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
Subject: [PATCH v2 0/2] perf stat: Fix trailing comma when there is no metric unit
Date: Wed, 30 Oct 2024 11:39:43 +0000
Message-Id: <20241030113946.229361-1-james.clark@linaro.org>
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

Changes since v1:

  * Don't skip printing when the metric-unit string is empty but pass
    NULL instead of an empty string.

James Clark (2):
  perf stat: Fix trailing comma when there is no metric unit
  perf stat: Also hide metric-units from JSON when event didn't run

 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 182 ++++++++++--------
 2 files changed, 107 insertions(+), 89 deletions(-)

-- 
2.34.1


