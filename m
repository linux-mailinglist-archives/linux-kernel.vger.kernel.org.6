Return-Path: <linux-kernel+bounces-283249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F194EF20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A101F21A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362E17D35B;
	Mon, 12 Aug 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQd/e5rJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732011C92
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471536; cv=none; b=o2S8XSz1BzkLwBiq11a2wt429KHKCIkh7Yzn2YtlJU7HMZ/7sd75Yzp00Uu3mSvQ4yVWVWxokvbJ+57GU4psCOUDRogtrQEnV52LCqJi8Lkbu7RO/+MQG4Ltfxcx/IMWkQ9zR9pQIScVydFwdRhSbScv37Z4R/0B8CpgpBtt2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471536; c=relaxed/simple;
	bh=3xCMLH7MsifyBLCUDKa8lXsPc0wtRxh97RTxvJGAhF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNgc5GWy44hB1pGXbfkIFq1pjs7T9rKn7KeZypXuXkxbujIWJ22G3Y1jGK6n9fta1RepNcJjo0uaN2sAAQx0R7q3mj2tZ1/Xbf6VUCHjqH5GbkIGJa3aNbOHztUfy85EkwAf1hn5haYgehIVtms01TsJ8A9RET1wQxToY7XP8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQd/e5rJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723471534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGEa+Af6Zglnh9LsfCijFVwHN8LnCtyL0NaGTe9kvVs=;
	b=NQd/e5rJeNJf9MDClnj6/40FcA+IoiYUAL3GI2bWIiSmoyGhIribDyeiFBSg7Y9GPlr756
	yV1e3W7kIeIJNK7/ujJblv8/Oog6YvIAVgWUDTVoFhJT1+Ep6nmd4hfzt+ZED2Fr8CWIRZ
	waxygbz80Fs99+1/06gStvqwOUlh73Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-zgOWanMAPF-G1NcRJn4ihA-1; Mon, 12 Aug 2024 10:05:32 -0400
X-MC-Unique: zgOWanMAPF-G1NcRJn4ihA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52f00bde210so5066436e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723471531; x=1724076331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGEa+Af6Zglnh9LsfCijFVwHN8LnCtyL0NaGTe9kvVs=;
        b=m8IZdss7HfGFTLNaKKWmRNg2L9VxRMU4MzC3VuJfwdESCooyTKKAUZfZf9cUuScG67
         1YeKBu9ioaoMTBLrDEojE+mYa58pBvk+KM2XtVUJDdR22gAIK4tIcoacB070/84U3C1D
         d8Cil57bsS8V05D0kfKtF7T6mdR8HNWjKZg/BhNBwzRY1oWCh9e5s0Oy6r4U+bNqaiDv
         m0LXx3SMDkBqgr/98+l+ulOzTlfcDmeXhEjJbcrPfw7o15+SeYkpQoV2R50SOG9Bx1gA
         7RVmoJYMdovy1MGImH4DMbkvYgh/R99HG7SktU0MlYhf6oFHt/LCnUbzbFiB4EWP2xtH
         Rw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0rO50L8exMH4oDSxjaLiqvVqtAOucAYrVoIj7luHtOnhyM5VCyXNHk16a0Zrj+CKGvOT7eK2AeufKitDodzRN0+W8OB012iGJzuZU
X-Gm-Message-State: AOJu0Yy7tk7hsJ/+EpkXP0xsoW+1mGcgIi/Zh8uU/8sUCus0ecoZPs7l
	rp4Yc5Eqamx5digIFj051kdQSc091uXgRO58igft41vFFdZ2SEU/WzmkwTyGWrhSMn2QjAzzECX
	6QSl1IeIF2OtxVvaOJSbUYLhng+yPk6ij4y1F18XovJov7buDhLeNspRZe3j8eA==
X-Received: by 2002:a05:6512:131b:b0:52f:79f8:a42e with SMTP id 2adb3069b0e04-53213649b36mr198768e87.4.1723471530645;
        Mon, 12 Aug 2024 07:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk/QBJfKvI/V6kY6JKluZL9/0B46SW8ykJ7Fw990aS99S+TDihVuAISa7JNM31o7HHXL2mKA==
X-Received: by 2002:a05:6512:131b:b0:52f:79f8:a42e with SMTP id 2adb3069b0e04-53213649b36mr198742e87.4.1723471529592;
        Mon, 12 Aug 2024 07:05:29 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72dad7sm182555855e9.0.2024.08.12.07.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:05:29 -0700 (PDT)
Message-ID: <e26941f9-f86c-4f2e-b812-20c49fb2c0d3@redhat.com>
Date: Mon, 12 Aug 2024 16:05:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf tests pmu: Initialize all fields of test_pmu
 variable
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Radostin Stoyanov <rstoyano@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZroIIXkmErNGZjQO@x1>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZroIIXkmErNGZjQO@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/24 15:03, Arnaldo Carvalho de Melo wrote:
> Instead of explicitely initializing just the .name and .alias_name,
> use struct member named initialization of just the non-null -name field,
> the compiler will initialize all the other non-explicitely initialized
> fields to NULL.
> 
> This makes the code more robust, avoiding the error recently fixed when
> the .alias_name was used and contained a random value.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Radostin Stoyanov <rstoyano@redhat.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index a4730b5dc0d9259d..be18506f6a242546 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
>   */
>  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -	struct perf_pmu test_pmu;
> -	test_pmu.alias_name = NULL;
> +	struct perf_pmu test_pmu = {
> +		.name = "pmuname",
> +	};
>  
> -	test_pmu.name = "pmuname";
>  	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
>  	TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
>  	TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),	     false);

Reviewed-by: Veronika Molnarova <vmolnaro@redhat.com>

Thanks for the rework,
Veronika


