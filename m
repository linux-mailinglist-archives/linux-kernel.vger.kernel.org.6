Return-Path: <linux-kernel+bounces-384468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D209B2A71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F1CB2195B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4BC191F84;
	Mon, 28 Oct 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOCh9NcT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F635161320
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104482; cv=none; b=saEauK+/rxfhnmiGQOD5fmdrrm9KbPWVAPTUiEDE22mFjE/q9FlmkTiwY1LvuFtu4UX/1SR2A/EckLG52fhz+d37eedCo+lwwX8qQqkIUIfsEQi34uhJH/ATWx7YiN/hBlDVAiymWewS0yNvlENtQXUlgHirgMdb1lF/1Pak6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104482; c=relaxed/simple;
	bh=Og7VFeibgJVBT6FJrItC1PgY1gkTDt2XqdrbJTB4e7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLcpYTw3fKJ8jCOWovWrzDlzsUEzmIk61IYdEowIgGqCsKHqvOPhprCEQvR2RXK7g/X9K2pT1gttCjeNIxNX6jUEpc/DOR2j8aNeDYGYim28jtkH9fWiPLjvvQJtXxQzKMEyEULOse/FQ4MGhCFPEz6kdvCFKgNd1PM5Mr0ujms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOCh9NcT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5310533e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730104478; x=1730709278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZvzHzoAhSvqMlNJ4Z3rTvD9uHN+8mD+ZB2Dwhaab9E=;
        b=FOCh9NcTt1UWJvXCTjoIbbNWKE614keo8q3fMUDR7FFJdEw4R6WYTmJRrPTfAM1lPk
         aMJddoBsD3Y5/Tokz8pKrhtBumCax49ggTbGAw7GJ9dpZjnBidbAzAt+Nv0BKUqmnrRM
         k04DkExo9xRHsv7jYS3In2Y5x10AnucrGyfA4t0QMAfqCrLII4knvdTbA3CwX7sFerxZ
         NbOrc09L6bb+iB3HzKVjqq1i9e02M+r7wk76jOp82kL9W4FXUUSxFbAH3y6FY4K0u/B9
         cmDFetU74yQLYJ2lnQEmINEGRUZJsVSqC3yUOP92auemoRq/5bhzEmTOkt17JgX+ccpv
         Cd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104478; x=1730709278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZvzHzoAhSvqMlNJ4Z3rTvD9uHN+8mD+ZB2Dwhaab9E=;
        b=j42yxD/WvH3TXtg2qRLqS4LAyHNY9qsjerHVVIEmZ94SXMIvBYh6IvNRB6CqQ0JhN0
         pY8AkGl3son+HIZSktwd5qTHZsmeAPUngG0Rvb9/VVbV3Uz3cnQmSYEFFeRqOHFtum4q
         Tg76YNV6w2iXFY8PReJkDVGfBnwmXuYz4A1jRNOsLpE7gZPiRr8A0oJRJc4HlVS1ynOq
         qtfU1aSJjMo5Gj9HkijUzxcy/IQSNfdScny4yWeXjW9d2dootjjRmemv4wdTAnYg06zf
         e56XZ8Y8Ti1pVCudztZ0WW9rYy+DhNWh0KAWRRUhNCKmjIuC7iMaE/O2K++5su9Wz0aC
         MfqA==
X-Forwarded-Encrypted: i=1; AJvYcCW8TNiHG/8InCtIH7QYIHzrhRtoxHC9ajGhBHoXkNM1dueY577bAiAGNuzUHQwBBxlc+llhkPpM+tX1+kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMpP15wcJWnWrLsli7as0vYqINPJ4TpvISBNHTDn1G83DoqU1
	JijsBl7hCSFPJnC9xM8XgLovGVtogqkt0FmAC7uARRdtoLnBc/oXQJkTljYFMfo=
X-Google-Smtp-Source: AGHT+IHvf3GhuRMSFKVfZ81qhF/flm6MKCz+LjHzg8vMbfIK/ulHNHb5uk/8WCn12dX/Q8vNZNNArA==
X-Received: by 2002:a05:6512:3d26:b0:539:f4a6:ef4b with SMTP id 2adb3069b0e04-53b34c8db59mr2835250e87.55.1730104478404;
        Mon, 28 Oct 2024 01:34:38 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.65.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193573e47sm102561675e9.8.2024.10.28.01.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 01:34:38 -0700 (PDT)
Message-ID: <05c1d469-846b-457d-b4b9-216f8c7e33f1@linaro.org>
Date: Mon, 28 Oct 2024 08:34:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
To: Graham Woodward <graham.woodward@arm.com>
Cc: nd@arm.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 jolsa@kernel.org, irogers@google.com, mike.leach@linaro.org,
 leo.yan@linux.dev, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241025143009.25419-1-graham.woodward@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/10/2024 3:30 pm, Graham Woodward wrote:
> Currently the --itrace=b will only show branch-misses but this change
> allows perf to synthesize branches as well.
> 
> The change also incorporates the ability to display the target
> addresses when specifying the addr field if the instruction is a branch.
> 
> Graham Woodward (4):
>    perf arm-spe: Set sample.addr to target address for instruction sample
>    perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
>    perf arm-spe: Correctly set sample flags
>    perf arm-spe: Update --itrace help text
> 
>   tools/perf/Documentation/itrace.txt       |  2 +-
>   tools/perf/Documentation/perf-arm-spe.txt |  2 +-
>   tools/perf/builtin-script.c               |  1 +
>   tools/perf/util/arm-spe.c                 | 31 ++++++++++++++++++-----
>   tools/perf/util/auxtrace.h                |  3 +--
>   tools/perf/util/event.h                   |  1 +
>   6 files changed, 29 insertions(+), 11 deletions(-)
> 

Don't forget to pickup the review tags from the previous versions. If 
you use the b4 tool it does it automatically:

Reviewed-by: James Clark <james.clark@linaro.org>


