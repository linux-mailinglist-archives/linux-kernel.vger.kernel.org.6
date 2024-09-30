Return-Path: <linux-kernel+bounces-344837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460B98AEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44251F241F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB71A0BD8;
	Mon, 30 Sep 2024 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="To4/C4W9"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196B19F42E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729850; cv=none; b=gI/gwdJnllgf5/VZUhX/ocviD8XEsRVHJxyYOrC7zs2X911bKHMm2m/9aHjZUtGwULc2Ka+zG99VROYpEeaqV6/2B/lSYw+WId0EKVcG39OBDHmXj5+Z+sh4ClhBWLvhFwtcvSYfbRw1ATDl4g5k3r0p6+MOiQTMA5Ew42pC2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729850; c=relaxed/simple;
	bh=DSHUum/B8b3jGdeFXxORM8MingRk2dWycd/+sDgEp48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHRyjcIRe3wKMYTPVTlh3gs4GQ/NSv0jaluYNaKfdO0JWhg2kkmDy9Wtnvwt0Fyme3jZo2zX3MHOP5f1S5Py4wEiJRpOzlWDqCfhIv4inIGs2xGZiWXt8N0tojqVhRbd8T29lnF17dXVoch87UsD6cSAnEVx9DAiE2IvRMD0T00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=To4/C4W9; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a33a5a3b5cso17115025ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727729848; x=1728334648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AW12f3fV0hnyKGmmmTzPeXu+IfjPN42/qOVSHOfH93Y=;
        b=To4/C4W9F5fCVeeE8Jzy/DgGTkxNOscGYGXrwH753pNJZt5EZtj2treow+A1wb5HYv
         QOGkjMKa1sIbpXV4jUs+E9nTAMX5OIbIt/9bCEmZa/O94rNY0jC1RXG6ekQ+lHKbopfl
         MOK3sLFmJMUJf8GeT0CIYo1WyH5ZYsyBqQthI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729848; x=1728334648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AW12f3fV0hnyKGmmmTzPeXu+IfjPN42/qOVSHOfH93Y=;
        b=LQgRIIm/FAR+ahH/vGa/mLuPHFBFL/Ji7qiDJlQDwWXtQL/Nd5r/hv/smry0p7ZnHc
         qxE7yDz7/iNb+QN6GzomElod5+YdxApXZWXsWgNVTjnkymJp4Y1pYtbS9MI1AkBWjVPH
         QDKN7XHnNsMvJt4lIDA2YxAAoLOnjkcAuObxkAnBukYOMjYNodNaLZN3OK1AEJ4xzfan
         SlKUj6+8Lky5bEjgZLL3aM43A2yIxvFf2zrsJc4H5yDS0JEpGI8+3qaNkHwb2hfsXTzn
         X80TcJmXyolid2jZbAa2JlBQiOoOWEZYcz9E+hM6nFy8KDFp+qSmZbOHmKFNSqnpQx77
         fLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUJlAApsn0e7FA4/emAe5SfwC4kuJjrQTuIkSQLxaOdTknVL3lYANOfBy5vYOqkEyV1wtAIuodrwtmpALc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFkScephAOzoGWO9dcJb2fyN0hwZnZUtJz96XAFQ1tTdu27z3
	XuxnVkOtpnQ5BehNqz2NNyuoUnuQEZYEzK6AMGgM80yaxegikUtWZHfqMyfIi8E=
X-Google-Smtp-Source: AGHT+IH6+aml0RNiH7eTsWsGVqK93eOEN3UEu1k2nN3+MRDt4bFti+AQepgmBbNSpbK5JtsjZIb4sA==
X-Received: by 2002:a92:ca0c:0:b0:3a2:aed1:12a6 with SMTP id e9e14a558f8ab-3a345166cd6mr105578745ab.6.1727729847981;
        Mon, 30 Sep 2024 13:57:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344df41a8sm26488915ab.88.2024.09.30.13.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:57:27 -0700 (PDT)
Message-ID: <7910784d-18c2-4e72-9dd8-6b8bd1b9dd0b@linuxfoundation.org>
Date: Mon, 30 Sep 2024 14:57:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
To: Benjamin Tissoires <bentiss@kernel.org>, Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240929085549.3528293-1-luyun@kylinos.cn>
 <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 02:38, Benjamin Tissoires wrote:
> On Sep 29 2024, Yun Lu wrote:
>> The HID test cases actually run tests using the run-hid-tools-tests.sh
>> script. However, if installed with "make install", the run-hid-tools-tests.sh
>> script will not be copied over, resulting in the following error message.
>>
>>    make -C tools/testing/selftests/ TARGETS=hid install \
>>    	  INSTALL_PATH=$KSFT_INSTALL_PATH
>>
>>    cd $KSFT_INSTALL_PATH
>>    ./run_kselftest.sh -c hid
>>
>> selftests: hid: hid-core.sh
>> bash: ./run-hid-tools-tests.sh: No such file or directory
>>
>> So add the run-hid-tools-tests.sh script to the TEST_FILES in the Makefile.
>>
> 
> I assume we probably also want:
> 
> Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> Not sure about the timing regarding our next PR to Linus, so in any cases:
> 
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Thank you. This commit appears to be right one for Fixes tag?

Is this the right commit for Fixes tag:

Fixes: commit ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")

Will apply with this tag added to linux-kselftest fixes for next rc
once I get conformation.

thanks,
-- Shuah

