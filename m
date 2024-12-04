Return-Path: <linux-kernel+bounces-431071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE19E395E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA87B3D647
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6571BF300;
	Wed,  4 Dec 2024 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUJxPmzn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCF1BBBF7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310950; cv=none; b=MN7dWhF1zPrSz9TdK75ocLR9UQJ1OEaGzXJvrsHh3nKtmKH/D2WuCNtFf0lDkzXNKI9AS0xClGHO1FyXHiQdVTbIquL/1LS/jcwvFF+pbKXnNlW4JjXsDi6xBZx9VQom/xK3tA9CE7Mvvg//bGG/NLVCmp9wiuVblwvNLhDjDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310950; c=relaxed/simple;
	bh=6haO52hbbqb+Ge1gGjrlJIH8GzfdI7zl8el26uthSe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQkeBre4kcsPSSdm3gUNNVHIrQYz9YkZdvEPUVmMysjAaFTgRe1pzu4B0h0+TZ+E25x9M/vKluE9KGnyJvEqIolGt7PlewSXtv36tGhFV3Eej/967T5mNaLEUcPXJYFkIaBV9kzFlJPkHu9h727qiE6NkGNqUyPdLYRnzZIpmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUJxPmzn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso61073235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310944; x=1733915744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PyMV4bLyaktItEEO0O2hHQkcftcybGuVejNfsC7KtYY=;
        b=kUJxPmznIU4K3p2se+NkhAPq1cBrN3HosrhIIK3WXXcIl4nN73HcgN9Y8TAbMGFegA
         to8p7Y30n7wZZcP6z0oPhF3GmnrEXzOE9h1qBdYQuHBGmfJTWWbnrAAjUfhMKML861EN
         nu4sisy2eVoQkkkyZJSYyiN6uXLykTdeKP6LFZJgB8SyoCliCozwAO97XmOkXH+YSkI4
         oj78oJyk6TVp8SorlFJ3lsCZ5KDIz8CmAguT40bDaqd4T10DMFRcQsmkbPe+LMaMRqvy
         +IPNNZ5JM+b7wt2TIPRJptMPJleEowlVKRsqf+rfJGolLAT0p5uQQSzp450VkN4lnJTl
         ENhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310944; x=1733915744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyMV4bLyaktItEEO0O2hHQkcftcybGuVejNfsC7KtYY=;
        b=d2r0JSNsGlw+508FPZs/nY6EXWmFtoZbnTvgCMB5gc+EknCMU6/Hhw7z3YFxx/Y9mf
         Ibk2WTr2x3mwcKjfDXPObx7zPwY2GqmIs55CDM7IaiO/o+tFeKPbP3n/KHaapaOnO9H8
         A2VwMbILXT4zVDtK0juVfW1/HkkoYQJNk5asaixrUJaLHtIYaD57ERT9II4qIQwlqcp1
         aUxRCUvb6L6XbxyfSAVjnyBCMjNDIyLlJqD5KNxvoeYYP62PQvcehX1xTmVOvbKCb2R5
         TQTBXPRqcjuhqQlxqM86SfWO8AwDgjNzpZcWSWw1P91097pD7dTviYRVbNwdLa6BUEBt
         dlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGe4DBpJTHFvfw03y6aG2AOj0ih3EfBHj9Psh2FDKy8pTRCjLKI38CqdUkggqbHStnRg1iizz3NVQxTrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFurXDAXWbnkhn9Jd8nLvygJoGlwA+LrGOp77XvjvfxpPOIcU
	vDU+2q5XjBUjjECy4L/9+MscqDKxvU99I9Q4aqfUKqtCkLHdUbfn3n2TWrCk66LRrkexEDAT2aB
	Z
X-Gm-Gg: ASbGnct1bLC1Y6xyO7ue/GyTxQuX2f/s28VegVvU9ymbpxMLkmUu92V4I9LPxkPnGjw
	v2xV0yAhWH3QNkYpG2wbEjyvbw3mXUcu/s3Xaot7IdsJFIMp1vCPZG3EdLnJaoBsKDy1LFSyV0b
	hmBjmPx1GZl+GsZ4ofrqMTFzWfw+ze94dGkbu1SM6bPO4w+/fwB76+4252rjEk/ylwn5mjKqLBW
	WnsW8wJOCWApi7gt/kdJGgktU5eLk1rQZaCb11DeYZreRROfEUL7UUK9G0rdA==
X-Google-Smtp-Source: AGHT+IGfDnu2hvQw6lAXpCu8yTqKC7sSN3W0dVpbKUu+3ZC2h61wf1xZ9LgnpipofMZ5rmAaVuaEfQ==
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5060123f8f.33.1733310943999;
        Wed, 04 Dec 2024 03:15:43 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385db37debdsm16833644f8f.2.2024.12.04.03.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:15:43 -0800 (PST)
Message-ID: <1b7aaa17-48b7-45cd-b468-ef54ca048e31@linaro.org>
Date: Wed, 4 Dec 2024 11:15:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: arm coresight: sysfsmode testing
To: Linu Cherian <lcherian@marvell.com>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, sgoutham@marvell.com,
 gcherian@marvell.com, Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>
References: <20241129083813.3056909-1-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241129083813.3056909-1-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/11/2024 8:38 am, Linu Cherian wrote:
> Add sysfs mode selftest for ARM Coresight hardware tracer.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>   .../drivers/hwtracing/coresight/Makefile      |   5 +
>   .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
>   2 files changed, 149 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile

Hi Linu,

You need to add this path into TARGETS for make install to work:

  TARGETS += drivers/dma-buf
+TARGETS += drivers/hwtracing/coresight
  TARGETS += drivers/s390x/uvdevice


>   create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> 
> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/Makefile b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> new file mode 100644
> index 000000000000..7dc68ae1c0a9
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS = sysfs_test_trace.sh
> +
> +include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> new file mode 100755
> index 000000000000..0d6307fff1d2
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> @@ -0,0 +1,144 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Marvell.
> +
> +# Test Arm CoreSight trace capture in sysfs mode
> +# Based on tools/perf/tests/shell/test_arm_coresight.sh
> +
> +glb_err=0
> +
> +arm_cs_report() {
> +	if [ $2 != 0 ]; then
> +		echo "$1: FAIL"
> +		glb_err=$2
> +	else
> +		echo "$1: PASS"
> +	fi
> +}
> +
> +is_device_sink() {
> +	# If the node of "enable_sink" is existed under the device path, this
> +	# means the device is a sink device.
> +

Looks like you still need the skip for TPIU here the same as the Perf 
test. It's an external sink and doesn't have a readable file so the test 
fails.

With those changes, looks good. Thanks for adding the first sysfs test. 
Hopefully we can expand them more in the future.

Reviewed-by: James Clark <james.clark@linaro.org>


