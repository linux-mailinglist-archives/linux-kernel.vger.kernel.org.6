Return-Path: <linux-kernel+bounces-210582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A393A9045D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451F2285D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623215250A;
	Tue, 11 Jun 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="adkztwbw"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0812E61
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138271; cv=none; b=jwSfBDoH59ASZFBzwOeOl+BEXZqnXo1Kf6paGKkDvadFaRrYCAsOsuIhRTHJBvhu3088yzu40LPVapaG262DQ46NWh2jS/dUQNNPby6YBRm4gv56MO2PlBYla3y+detYBii59M7BCArQaw0VlB7eWdxQ+A3PScfFIvjgzTMBLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138271; c=relaxed/simple;
	bh=V/biF71bv6Pq6LJwgeITRAa/Hj0e5fUOoj2yUgJnfGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqYWAKXYgIxSIXcrOA1aTA6wkE28GlnWsMHFOSIVKh2vGAa0CBaAAmqUuO6wiX1xaSA+xHsdj5ikMBitYDdVESAuRu5/UptNL24TeD4qzX4je8DLD3rZhNdTnUl6tPRGYl0Ci6+Rx3YXngkFM1hapnL0BBMYndXZjDYkSUJsCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=adkztwbw; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d218bbba30so431646b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718138269; x=1718743069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HE5nrSg/RT1klcR6UUxM42f0bi6ZlwGGrbOCaO2TDuk=;
        b=adkztwbwTy9OQIWxtu2NEFEG3SJlYgNHYbeLgpVRFlf13rtJyjFCuGUSW1xv3FnUms
         J2AIjeOPywAzUBIyMuV4Zh0DahHErlkw2ZVs5vJNOIyM8N8XEI74zIXWaMIDlGR9hZVr
         pyeUGR7kPURudihsjrKNPVeG1oOe4y7rdG21U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138269; x=1718743069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HE5nrSg/RT1klcR6UUxM42f0bi6ZlwGGrbOCaO2TDuk=;
        b=k8h9Cg3GnvQi989EWINZB/nq4IVAIelV8UTh6CYY2sUhw7OqXZZW4z/QC8q9PP1tUx
         nUCTm3OrlWKFBiXyZmPZlayWGXu0w1OCEOxhJiC488TJasjPIcwNMrxIHYHg5r2KCw9I
         yKxKhVQrTYQFuQbTSUfhLkCBhDngRtaQXtU+YDW1Akb44LS20oL7o/nySw6uXDujGdps
         butPl5oIqIOWNYadkH1xaO3zhH9Qai2KlbHNU2Lb9hed7OCxngRFtnKrumIquYonimTm
         KYdQQZcZ+EEoPseddu+Bv6t71DkZx7WEUAV8yXM+53Bxwqm3O1OVe1A8xV8aGuvaTvfM
         WObg==
X-Forwarded-Encrypted: i=1; AJvYcCXkIjLOGSZBskXyUHjskDgyusDywH3hYwVPZg5565I6wPOMOd2Vs1h15fB7iOzYViEnxFEpogGakT8ibCNa5dyAt5TcarNEQOCqgAvF
X-Gm-Message-State: AOJu0Yy2gH4dD+ktOebROHDcqXcud3GHARM+gN6RY+cMBo3ZVzZS/CLZ
	2NeNHXMdEOfnsgVhUyIMjaVE6ACQyZLE6Nu0wFX+fjD7NKP6zyk3gUjnKtRZvL8=
X-Google-Smtp-Source: AGHT+IG90OE/6gP5cB7neVTC/ES16EBOsNBxZKxN58g10F5pDUw3PniO9bBtreO7MSfSgGyUV2P++A==
X-Received: by 2002:a05:6870:3310:b0:254:7dbe:1b89 with SMTP id 586e51a60fabf-2547dbec04cmr12704059fac.1.1718138269159;
        Tue, 11 Jun 2024 13:37:49 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955086fb96sm379035885a.37.2024.06.11.13.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:37:48 -0700 (PDT)
Message-ID: <b3741c08-5cc2-4b82-be26-7c2a0f79fa86@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:37:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] kselftests: vdso: conform tests to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610054129.1527389-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/24 23:41, Muhammad Usama Anjum wrote:
> Conform individual tests to TAP output. One patch conform one test. With
> this series, all vDSO tests become TAP conformant.
> 
> First patch conform the test by using kselftest_harness.h. Other patches
> are conforming using default kselftest.h helpers.
> 
> All tests have been tested multiple times before and after these
> patches. They are working correctly and outputting TAP messaging to find
> failures quikly when they happen.
> ---
> Changes since v1:
> - Update cover letter
> - Update commit message of first patch
> 
> Muhammad Usama Anjum (4):
>    kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
>    kselftests: vdso: vdso_test_correctness: conform test to TAP output
>    kselftests: vdso: vdso_test_getcpu: conform test to TAP output
>    kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output
> 
>   .../selftests/vDSO/vdso_test_clock_getres.c   |  68 ++++----
>   .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
>   .../testing/selftests/vDSO/vdso_test_getcpu.c |  16 +-
>   .../selftests/vDSO/vdso_test_gettimeofday.c   |  23 +--
>   4 files changed, 126 insertions(+), 127 deletions(-)
> 

I see two changes:

- concvering this test to use kselftes_harness. I am not seeing a value to this.
- Second converting every single print to TAP. This isn't necessary since the
   kselftest wrapper prints appropriate summary message based on the KSFT_ code

I want to output before and after to assess the value of this change. TAP conversions
make sense if and when they add value.

thanks,
-- Shuah

