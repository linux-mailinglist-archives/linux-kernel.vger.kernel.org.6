Return-Path: <linux-kernel+bounces-387996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91889B58F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66099284609
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344D12D1FA;
	Wed, 30 Oct 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmSbb+mK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5530126C0A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250724; cv=none; b=W0aSZoLQprhvpnSD1yhxIVYxV2J2IqasCg+LdLPAh7N0T4d3ozomZTGB4SnImFP342DeMBXNLuH+2+Pn6q7PZTHL+FwlcS7AnnxM6aE+4A/Fa893FgNTTwEcb9gU35i8m8i+DjQAVwuQLPbCSMrsV62nQIH5Pw2yJ96Ws6pyvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250724; c=relaxed/simple;
	bh=rkWMe+q7YE91JJSH14RGk9u52F5soEQs+wqZBxWnc0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMZr+cslwIhBM0fPUJUgP2DmZIk5VHb8Bb8JoihGM7/9wT2UC7h029+h0CQk1LSfotjaB25PTYsGPFn3tTbcH7LT5krL2pzc41PK7zbDet1nL1S13sx2BHCj6RSb/LPsJeaNW1f6B1skQcb11V81OIDw/9ggwUNU1L4Lo+ZWHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmSbb+mK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso4559228b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730250722; x=1730855522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQeSwxz5uUvTcfuWV7iXLr/jIgrx+m1N8dA8FAnJTIU=;
        b=SmSbb+mKEY6lOKL2LCn625i1usRBq/OjIy/UL8a7bT2wYgHElgWzK2uPdqM8wDrBBz
         1o+9GvrxydMA/LoFZseIN76Dh0ASf6z22tWtySHX4xZqN5YZKEH/4oW/Wz8oOeamU6mW
         Qdrv1UoUq2PIpObFpO2X0Uie3BNCpbwAt7plw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730250722; x=1730855522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQeSwxz5uUvTcfuWV7iXLr/jIgrx+m1N8dA8FAnJTIU=;
        b=pSXXNeXnO2FUAauKgxJagBxZl2uxualNDs1wL9Ss2foITaBDQhbQLCZj3cxacxfs95
         CwQYpUvEHqMpNMftuxXlXHZ9qNHvdnViGw3SXc7yIm6NIsAWiG3/7ziUhlHwP+IuFRwM
         WCZhJ/TTRElyU+3VkpkyUfBknmSgaS6BqA+wqNX+tYsOe5I7VUmvpdRohUA2tU2hD865
         c7tk0Kv3rv/wIPijJ0AvC3HAy8ll0a/Y2F9+Bp8KfHY63NNO3rRJaHQIg0+jMFSvRqLz
         qFR35wEY2JlQ4Umtc/TRAxzI0QbDY9KKjU+gI3g+ho+L9V8Wxg6/GGTX5jQX01xnyZdg
         KLDw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8W5d0B4qBjCutNdfNTR+KeHSkKh0vtwfTuF5paWJeDDcybytFj8KHseD4rkT7ctrjnO763p5KvymcMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgVVg7h+zJh5E7mjs+C7EEUX1lIi25o3bSKdOXSnta0+mbPU2
	dbdsUJy9DssPQrcmvY7350Mi1hp4lcMmAD6BE5shM8W5YHlb5LS20LlIZRzyxPU=
X-Google-Smtp-Source: AGHT+IHMrbF8CoVpGDbrSwiNAoCRtHBAraPF1XTqZ20q8hnPphvyiRNL01Y5zDxxgb0Xh7+6RUHp5A==
X-Received: by 2002:a05:6a00:3ccb:b0:71e:4ee1:6d78 with SMTP id d2e1a72fcca58-720ab39e56emr1862518b3a.1.1730250722137;
        Tue, 29 Oct 2024 18:12:02 -0700 (PDT)
Received: from [192.168.3.101] (p8535228-ipngn42701marunouchi.tokyo.ocn.ne.jp. [180.15.75.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a44ad0sm8165893b3a.220.2024.10.29.18.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 18:12:01 -0700 (PDT)
Message-ID: <85570e57-1af3-4d17-8a21-58c75e6bac9c@linuxfoundation.org>
Date: Tue, 29 Oct 2024 19:11:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/hid: increase timeout to 10 min
To: Yun Lu <luyun@kylinos.cn>, jikos@kernel.org, bentiss@kernel.org,
 shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241029090746.179108-1-luyun@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241029090746.179108-1-luyun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 03:07, Yun Lu wrote:
> If running hid testcases with command "./run_kselftest.sh -c hid",

NIT - When inestead of "If"
> the following tests will take longer than the kselftest framework
> timeout (now 200 seconds) to run and thus got terminated with TIMEOUT
> error:
> 
>    hid-multitouch.sh - took about 6min41s
>    hid-tablet.sh - took about 6min30s
> 
> Increase the timeout setting to 10 minutes to allow them have a chance
> to finish.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>   tools/testing/selftests/hid/settings | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/hid/settings b/tools/testing/selftests/hid/settings
> index b3cbfc521b10..dff0d947f9c2 100644
> --- a/tools/testing/selftests/hid/settings
> +++ b/tools/testing/selftests/hid/settings
> @@ -1,3 +1,3 @@
>   # HID tests can be long, so give a little bit more time
>   # to them
> -timeout=200
> +timeout=600

Okay - maybe this test shouldn't be part of the default run if it needs
600 seconds to run?

thanks,
-- Shuah

