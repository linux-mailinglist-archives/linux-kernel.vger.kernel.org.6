Return-Path: <linux-kernel+bounces-449382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129A9F4E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9BD7A5A40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D351F63CA;
	Tue, 17 Dec 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXZIool/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C11F543A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446523; cv=none; b=DvKfWTPoK6JV7pAGrvKw+qpCMQf159NofDazNoFzEvtojXPZSixi0ZRTadazdoYvCQSazhZTjkyjy4uuez34MsMtLQ0rSJSlM1T+S1w51D2OazXiEwYP/wfQMcROBuljToq+2YttVEXeeD7TvY/aIByF94LrPFTkZvBkb7YtbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446523; c=relaxed/simple;
	bh=IduhPnhYDH1MDPrUhaN7y0qRs3lIO/NMag9SCbU6GdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZphSsy23+X/6fcdX6c7Hia5Nxb+1HN0WcS6Pg8VLb2ng2WSCNAxqSbJzV0fXa5PZcEj5s8HF7ycbucFvgmdokmK3zq6aOPCLjHfdGX13TBYzQIkiLVk+bmEFWupwlfe8cdmAOm9Rh6QQ+r2wJdLuafs3ZhB4/O432UwPefpvNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXZIool/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361a50e337so37892375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734446520; x=1735051320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkDgX86vllpaHSZlaZCU7Cun96tz+XUmIPtYmYXZiuI=;
        b=iXZIool/DonMLyLPNOTROAiMZLHEuig3f/eck5c6tnJZ7y8jluKd7nS0X97OFTJC35
         mT1sdSTVkT19YJE+MTdNJQm3hd8npaA2INoLdW5PvlrCFqQY6MY+PPBf3NtstoaHSQUI
         g/xvpWAjMvE+NX8pEAMKugj7FAlkeI9gfmv9LZizKY5Nqe3Tsj9HVfZKHDe7G1gAebJ+
         6MnqK9ckNxTbhtawHaVf/9KCVFY2UQ2R8+34Xb1BYdDn5WrnclVFyzVxtHAors7Nzb3s
         jf4amT8ZKzucOYX6pZ28uevXVwB0it/0Gc6255+Q6WR1hxI46dzHmK37XKIWzVdSBH05
         vWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446520; x=1735051320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkDgX86vllpaHSZlaZCU7Cun96tz+XUmIPtYmYXZiuI=;
        b=Ebtj+PW0FHdWl6n7Szf1dshB4b6C1Qh7s5iasLUEQh3QVbLBFbt6YRhRI2QzAj2b9G
         PAwbYdmRv/MCz5UUpbf+Bkg1T96iuAPHDHBGYwiVS9Bz5FS0r21xLd4+Wcp5r4KoF0/a
         K4cv/Gvjvl5bSTyE8MTcKMfoOygtWT2i3R/m7HonTQHMJko4BIjXaRZ31jUnkaz7GPeY
         flfKXaHdnqQUcHqfsLvFLIy00KlR1UBl1xUCoV2kNMx27KHFf3V3Pn2IhFKLFZTeUT1e
         0wS7yI5tt0BjTScXXAqgVV2E/ZhSZoaJF50W48guxeLGokYQxMme/R0tlyWGbq3NP2cx
         eZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURvfd4Ee2uyOfBk2kWM02TKZ3YtY8A6uqHUJ61Q9P1KI/3cTGfd9O7UfSQoyGf8AL1gIV+xBf6J/cz+qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jsIXUhpfshEg3BPUF2u7AD7Vj0xtwvZNZOIUKoiqZlORtKvi
	lsfsILUj5ip1g3boxBIztEmlJvbw8h0n1NrJvfnzCIQkMDYgrm1ZTzMZb7P3IKE=
X-Gm-Gg: ASbGncs3yNsn/+vFRepYDMbSV0LyliqLbFqn2+BSWrl6564jqKFZD//XrLAezpmo1kN
	uuZPeeeMMKSEq1qxjKq4dQmK+BganOJ5uquqM0vVVCc6fmTakGYejSogyUVqmXh9qA1cLd82qvr
	XsQDpNyjvIIMoQAVwTc78/263pmZsTtbKQY+hxZ/r51uq9zT2fLBdAircrqblvWY9+Oo18NQtVD
	g+zqkHN71npH+O/4j4iZkXsESeEBd1DCfGEr4owGkzZbcps9GdCgs7EabqYhGRoFog=
X-Google-Smtp-Source: AGHT+IEzBbDbt3N095GZWA5AkGypzQVy5bfUKzLTwWMXJ09Q7iKoxCNLX0cW+TNl2Iv09tcOh2gpSQ==
X-Received: by 2002:a05:600c:4e8c:b0:434:f7e3:bfa8 with SMTP id 5b1f17b1804b1-4362aacb94bmr138319775e9.33.1734446519862;
        Tue, 17 Dec 2024 06:41:59 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362c8fbasm119231555e9.44.2024.12.17.06.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 06:41:59 -0800 (PST)
Message-ID: <1cb01bec-d5ad-4081-956e-32ac424b5e5a@linaro.org>
Date: Tue, 17 Dec 2024 14:41:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: test: Speed up running brstack test
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20241213231312.2640687-2-robh@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241213231312.2640687-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/12/2024 11:13 pm, Rob Herring (Arm) wrote:
> From: James Clark <james.clark@arm.com>
> 
> The brstack test runs quite slowly in software models. Part of the reason
> is "xargs -n1" is quite inefficient in replacing spaces with newlines.
> While that's not noticeable on normal machines, it is on software models.
> Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
> much faster. For comparison on an M1 Macbook Pro:
> 
> $ time seq -s ' ' 10000 | xargs -n1 > /dev/null
> 
> real    0m2.729s
> user    0m2.009s
> sys     0m0.914s
> $ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null
> 
> real    0m0.002s
> user    0m0.001s
> sys     0m0.001s
> 
> The "grep '.'" is also needed to remove any remaining blank lines.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [robh: Drop changing loop iterations on arm64. Squash blank line fix and redo commit msg]
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Originally part of this series[1], but I've dropped any Arm specifics,
> and it stands on its own. No reason this needs to wait on Arm BRBE
> support (which I'm working on now). I don't expect to have other changes
> to this test related to BRBE anymore.
> 
> [1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandual@arm.com/
> 

Reviewed-by: James Clark <james.clark@linaro.org>

>   tools/perf/tests/shell/test_brstack.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 5f14d0cb013f..e01df7581393 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -30,7 +30,7 @@ test_user_branches() {
>   	echo "Testing user branch stack sampling"
>   
>   	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
>   
>   	# example of branch entries:
>   	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> @@ -59,7 +59,7 @@ test_filter() {
>   	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
>   
>   	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
>   
>   	# fail if we find any branch type that doesn't match any of the expected ones
>   	# also consider UNKNOWN branch types (-)


