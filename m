Return-Path: <linux-kernel+bounces-364859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD099DA45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4191F23307
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0D1D9A62;
	Mon, 14 Oct 2024 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzcJc6qM"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F941C302E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949293; cv=none; b=Vw5hGzMgsaU96Bo5HJBL+5mOvyO5nWRVeUKb2S7ILnyHydubYWkwAk+Qj0f5nzFTHkIpXadM5/Jl5IY6BpQMYzB/tm0KYciaQLVwk7Wi/0nyHOxabOno6xEZYKnx/1HuAvA6ibf8v2yprj9wrpTTvNge1Zbyvq35DykzYkTX4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949293; c=relaxed/simple;
	bh=gC22zyS732dJqWQtITLgaa02TeSHSByVxfRzRVFZh1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFs++RzUZoC2lN1AalLl41KlXqJw3HbCGT15vHJK43yNy1aWVtWTXyNAFCLqQIH9cLEJ0adUfmEMkvmonpXAF+N93VqGL2A80dA3/pPDojFoGoXeNVn5RaKWBN/U+oIReDucbsKxWkakkldUvp24L9eoT64uY/3w0OP4Yns2GQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzcJc6qM; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8377fd76196so128155139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728949290; x=1729554090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tic3SCTKhK3/rlRhjIaYAFeHYIpx7Hz8LHFBIUIs7gI=;
        b=WzcJc6qMbghWyWXSvMdFhv5s9C3+0cxFaThcifK+7VtKJtQatVeoLm2MFYcec8vknT
         agvS/57koh/zTzfj+uES7kE6x6BbQnA/zoDvroiyhjlcHxauWmWIpIz4BwbD/EY23w4U
         MRkazRUeddhSwrw0dFBP6Sh8LKj6NzwTJYWdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949290; x=1729554090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tic3SCTKhK3/rlRhjIaYAFeHYIpx7Hz8LHFBIUIs7gI=;
        b=rIP/N3jnUECZZkiE21cMg8Baf3yAmYJurIw/ogG41NvoWag5XRkt7Xgal1BaB4h+G6
         08AUcarXeVtmG7kOAJmaFBToQhYi4p0nH5rSpNpYK5Tvf8/fK4LCW8ntgFsU8eJMU2UZ
         NiCPi01VYY97Y/586Kb2X/SJpa1x4CWUn2I1WWcaGlipfT6yTKNpkIlzxZfmTpgAMTwp
         Oqun0eRLCHJhsx6iuJ1BtcfYOQsATOLMtohfeeOUp1/PpL5LCq7q8KMvsGz1fyo5iSfm
         o/dh5fe/6rcPXVYQMpsciJhtXm/SVQc5NQ7igoWBROVHZWnfk5QdJdujcJHl7CwrVYuj
         vE2g==
X-Forwarded-Encrypted: i=1; AJvYcCVopJ3tfFkuqy0dxseBtLbP1UT/hy24cLCM5oj18q/HMI4IjhxBfp/SiuYp30rhaNDYRrIPaacdSoaRfHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWvlC72co07DwEC1JExrjQoRqVPlkLfsy1k1dNOGYzqxIRjP0
	M46KmQUcuGk+ZgwpaEiSm2INs9fMYIiQrfoLHvyY08yV09/jSbZHwoNe9AcWDKs=
X-Google-Smtp-Source: AGHT+IGBuqcBtnVFCeJZy1XKkocC315zdG0Ql9eD5QCu+Duuy7QOgyQD1cteIaIeUWmCMFZEGmHfYw==
X-Received: by 2002:a05:6e02:1846:b0:3a0:90c7:f1b with SMTP id e9e14a558f8ab-3a3bcdc0bb7mr70303995ab.12.1728949290074;
        Mon, 14 Oct 2024 16:41:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9633f6sm43038173.30.2024.10.14.16.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 16:41:29 -0700 (PDT)
Message-ID: <0997dba1-2289-4291-a06a-f9041a95c16c@linuxfoundation.org>
Date: Mon, 14 Oct 2024 17:41:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/intel_pstate: fix operand expected
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241014140918.229922-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014140918.229922-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:09, Alessandro Zanni wrote:
> This fix solves these errors, when calling kselftest with
> targets "intel_pstate":

What is "calling" kselftest? Please include the command you
ran in the change log.

Also, say "Fix" instead of "This fix"

Running "command" results in the following errors:

<errors>

Fix them

> 
> - ./run.sh: line 90: / 1000: syntax error: operand expected
> (error token is "/ 1000")
> - ./run.sh: line 92: / 1000: syntax error: operand expected
> (error token is "/ 1000")
> 
> To error was found by running tests manually with the command:

"To" -> These?

> make kselftest TARGETS=intel_pstate

Why not just move this up:

I don't see any errors when I run the above command on Linux 6.12-rc3
What's you environment like?

> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>   tools/testing/selftests/intel_pstate/run.sh | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index e7008f614ad7..39130a359535 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -87,9 +87,11 @@ mkt_freq=${_mkt_freq}0
>   
>   # Get the ranges from cpupower
>   _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
> -min_freq=$(($_min_freq / 1000))
> +min_freq=$((_min_freq / 1000))
> +echo "min_freq:"
> +echo $min_freq
>   _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
> -max_freq=$(($_max_freq / 1000))
> +max_freq=$((_max_freq / 1000))
>   
>   
>   [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`

thanks,
-- Shuah

