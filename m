Return-Path: <linux-kernel+bounces-358612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE3998194
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA46B27AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198191B3724;
	Thu, 10 Oct 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRSaE0zi"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621019AD73
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551172; cv=none; b=Hdi6UFrplMD7JIMAH5gpsF0ZuCRamJCuyd7UkS7HajEFb7XTy0fF0VJjSbK2PXOdRgAszUifLXiH3nxV8vPNH4og/oa2KXVeWx41kajaWHnpfdWAC/nYsVYOAcf1cUyUxIZYOMjyE75PINz8bq9YginIsLJ5v4+8SePyFZY0lpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551172; c=relaxed/simple;
	bh=vQFYsetKvh92e/zvO32kVmpmG0fODL02A6a/hL3T5sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqeRQbKcRK9aOGUirpyHzIO/6y1NZOjicBW2p24qbzHjg3I3Ee9cbtArknGIjqwNsm4AcvM1EuVZEnQXjMdOREYPnCRJokufDLEmV9BHLpazGjcOyfCYCvpNLfuY3tJEuAXihdmmOBZ/J81uu4RYh5t6WMA6ucsQhtcwjYybzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRSaE0zi; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539908f238fso808539e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728551167; x=1729155967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7HF+ewI6tZ9yPck9QZOJ+Ws/0TKRf2Dgxr1lY+CsiE=;
        b=pRSaE0ziXfzh9tRjEMnCpOj34y3zctwaahXbGqEsc+tAWS2nmNqrP4M6fM5JrttoLs
         zk2qmfvoWEMEqCV1lmrcq0eByaoKLxO/zCtvaBRxD45bxC2IpPmLxscnAUnNK4nV5FC8
         G62HJZKftTK3K6QcENC2CMN7efFYK9+EsAz0pKMNYxvT/xbA5B69DyTkBe6DvNBGhcs8
         L8oqRwAHpTR6CzqiUtBldq07hQqodgRcF4Qtv54UTg7F5uyAgGopPOLxIZZ7xCSNclbv
         joOhsIE/OItSUT7D5ITQ+4+6Ix2aUTwDoBeRfo50ofN9JiYL84Kd16leXIGh/WId9Hah
         W1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551167; x=1729155967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7HF+ewI6tZ9yPck9QZOJ+Ws/0TKRf2Dgxr1lY+CsiE=;
        b=rcEO3asVgIIoGQezROWjPupzzU/2GPGEdSuj17abW0KAy98ZQyJCajrsGvZzutYi2a
         MM/qmEh84oKPmbfmKg/lG4m00WEEBpYsNB3BPfrWHESI9n+Izsjrsdi6m4kElxVGnayC
         SwHmY13kZdSsUgHDh8NzYHqGl5XSM+8Pi1LOpQpBwdfdcr3GxsqjenfuGgGTTdw6GCcJ
         usWd1zUF2kvAZ+etsDrJ5rIllRJp0EQ6Q7OoHaWyhlW98Q9gV3Aj3CRFaStUj5ODK8eD
         xXvrKjCRRMhdIAgtE1YU3q6EvlNmFz9Yy/a4ZKPdWJN3xnYaT0E7W9E6BXFRnhLfCI0j
         Rumg==
X-Forwarded-Encrypted: i=1; AJvYcCW9xeL1O3EQZu3usuHdvsCSCFbrCvW3zs6MKXTGBxTVrt4jhFVuD05l4AaSCiIpNJKnBHNu90V9oV/wG2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZXtnI22lFqwO5XxR9FL3w7ryVMGM0yr02ISx29/7cSv35CW9
	9jKjiSghDDYHBUr1KLi9nVqb3sJSKIVck39PMe87SjSs8W7lURodxElfvbVvdhE=
X-Google-Smtp-Source: AGHT+IHWxG2o8e/70tdhq6YBZ0lpADFoBYupOp/ROu9HosAG7AZwJVoFGYbTjtgi9nvjJmi3WvVlzA==
X-Received: by 2002:a05:6512:3b23:b0:533:43e2:6ac4 with SMTP id 2adb3069b0e04-539c4965aeamr3368953e87.49.1728551167278;
        Thu, 10 Oct 2024 02:06:07 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd7esm9857605e9.19.2024.10.10.02.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:06:06 -0700 (PDT)
Message-ID: <52125138-9ba5-4f71-9e7d-aff5f85d0dae@linaro.org>
Date: Thu, 10 Oct 2024 10:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf trace: Fix support for the new BPF feature in
 clang 12
To: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <20241007051414.2995674-1-howardchu95@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241007051414.2995674-1-howardchu95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/10/2024 6:14 am, Howard Chu wrote:
> The new augmentation feature in perf trace, along with the protocol
> change (from payload to payload->value), breaks the clang 12 build.
> 
> perf trace actually builds for any clang version newer than clang 16.
> However, as pointed out by Namhyung Kim <namhyung@kernel.org> and Ian
> Rogers <irogers@google.com>, clang 16, which was released in 2023, is
> still too new for most users. Additionally, as James Clark
> <james.clark@linaro.org> noted, some commonly used distributions do not
> yet support clang 16. Therefore, breaking BPF features between clang 12
> and clang 15 is not a good approach.
> 
> This patch series rewrites the BPF program in a way that allows it to
> pass the BPF verifier, even when the BPF bytecode is generated by older
> versions of clang.
> 
> However, I have only tested it till clang 14, as older versions are not
> supported by my distribution.
> 
> Howard Chu (2):
>    perf build: Change the clang check back to 12.0.1
>    perf trace: Rewrite BPF code to pass the verifier
> 
>   tools/perf/Makefile.config                    |   4 +-
>   .../bpf_skel/augmented_raw_syscalls.bpf.c     | 117 ++++++++++--------
>   2 files changed, 65 insertions(+), 56 deletions(-)
> 

Tested with clang 15:

  $ sudo perf trace -e write --max-events=100 -- echo hello
     0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6)
                                             =

Tested-by: James Clark <james.clark@linaro.org>


