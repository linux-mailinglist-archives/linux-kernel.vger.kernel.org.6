Return-Path: <linux-kernel+bounces-260181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B8693A435
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D51F235A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFD15749A;
	Tue, 23 Jul 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INgrZ5G3"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38314D2B8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751475; cv=none; b=FZIppRBho9BNOIs1Em+WMjxzJcMusXqFaWrxLXjbhaCcOuW/Rk06mUr/DdsrZMuvkerXjq74a5s0T3aXF6tRP4EnsjfzyTiAO/OiRVgny/a52ifiv2+Rz4kxbrN5034PDL9VDBgGviRHEMLuAqML7o0nKT67h1RTXIoRQc9GfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751475; c=relaxed/simple;
	bh=pRoaIDicTrBMV9Y8Wv8cr1leg4UK4r11oJkILZ4HRMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOGOuoCjyF0+yQb3XpO7Uq4tXMgzKI8XfLRg04Alcz9h3Chau7bYZEAay9Mw5XV3V2BkNVSYUX2bE0E1QEvGHD04YguTd/WsRd/cy2gxhaCUMsyskrwmCFREVV9B2YpC4G9JKcQGLzOuk00pvtDZpoGkR3jVa0hFtSD0B+3hv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INgrZ5G3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7fb4ac767c7so25851339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721751473; x=1722356273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WckdgsdVKcnunHrXHx3KQ06hIGXGwaXg2AXB5/rozpI=;
        b=INgrZ5G3MlqZPolW3fZmc/ZD8lCzUs19XEKaW3sLba54zG6u+NZL/LOlGoky5nTiXi
         BEpx6C3Mns+v9WNkksY5Rwb0u0H5YQxVbmQc+dNM8Gf99NcZ5W0ugmQ5tKT4iT//Bzkk
         oi78Xto9/eajIXQRWUX+kXOtGnb0WZ7y9cpPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721751473; x=1722356273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WckdgsdVKcnunHrXHx3KQ06hIGXGwaXg2AXB5/rozpI=;
        b=tTzIp2+AQnt4L/mr4qt+VO7Mf4VrSH9e7B32s8cH+zD50N/HDiZwQOGpV8JcdH5KNZ
         iZjxPiqclI7kykdwPOlJqHnZzCcULfYtO8AHnAEZSsvGECZ6d2MXLWVVRgnidRX3YDG2
         gquRb8DphNWCfWHBeUg9Lmnedj8w6QgRNm5XAZc7aCDZQ8xVYVfhOZbwiDKM/v/Sh66q
         NMvkW47WsmQv9p3IgxuCXx7X3hy+2YN7OJYatjQXZ1P502+0Cycre1MwxJfGhjgKNvGL
         0GXvyESwNTrTc+hZrOHjB+K1R/aeYtivCKI82qpOKlVTn843qHQ+TgfDJ7B+TiHdraHk
         vwyg==
X-Forwarded-Encrypted: i=1; AJvYcCUhYnB9Wc9mkpRouU3bt6JH5K+BJyq390cbwg3n+hbk4KleM0IlzgzK8przkF+M/cBXZBJ2fIzBCfkt7dQ5oLuMBo5qC25n/Xj4DrU7
X-Gm-Message-State: AOJu0YxTYZoG0nBNNztn31rnbh6Q0f+/DlkKhy6J/WeyQW9YYZnNyOBB
	WkQVub5pHI33oKNoJkuYJlUUKFm+NOCxJxVAn1cccBfTLZVDBfX/4FXls6nWfPCM7iCjSX2/qva
	h
X-Google-Smtp-Source: AGHT+IHBJf66ztYfZNCfxnbGx4Z5m41bRmi5L58frY1Jq39oLN0lrAUqTLUc3qwaGE+1ZaBYXDKjOA==
X-Received: by 2002:a5e:c746:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-81aa70732d9mr633081739f.2.1721751472896;
        Tue, 23 Jul 2024 09:17:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c276c03bb6sm447490173.93.2024.07.23.09.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 09:17:52 -0700 (PDT)
Message-ID: <9009f4df-ca7e-4961-97e4-446afc4e87d2@linuxfoundation.org>
Date: Tue, 23 Jul 2024 10:17:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org,
 nfraprado@collabora.com
Cc: gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 09:43, Laura Nao wrote:
> Consider skipped tests in addition to passed tests when evaluating the
> overall result of the test suite in the finished() helper.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> index cd89fb2bc10e..bf215790a89d 100644
> --- a/tools/testing/selftests/kselftest/ksft.py
> +++ b/tools/testing/selftests/kselftest/ksft.py
> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>   
>   
>   def finished():
> -    if ksft_cnt["pass"] == ksft_num_tests:
> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>           exit_code = KSFT_PASS

Laura and Nícolas,

I saw both your emails explaining how this fixes the problem in
a previous patch.

However looks like you haven't see my response about the implications
of the exit_code = KSFT_PASS when tests are skipped.

if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>           exit_code = KSFT_PASS

Let me reiterate in case you missed it:

There is a reason why you don't want to mark all tests passed
when there are several skips.Skips are an indication that
there are several tests and/or test cases that couldn't not
be run because of unmet dependencies. This condition needs
to be investigated to see if there are any config options
that could be enabled to get a better coverage.

Including skips to determine pass gives a false sense security
that all is well when it isn't.

So it is incorrect to set the exit code to KSFT_PASS when there
are skipped tests.

+    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:


>       else:
>           exit_code = KSFT_FAIL

The logic here seems to not take into account when you have a
conditions where you have a mixed results of passed tests,
skipped tests, and failed tests.

Please revisit and figure out how to address this and report
the status correctly.

thanks,
-- Shuah



