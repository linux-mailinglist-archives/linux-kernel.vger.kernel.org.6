Return-Path: <linux-kernel+bounces-256558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34843935029
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CF41C20DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B891448E7;
	Thu, 18 Jul 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfPyJT1k"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9177D3EF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317719; cv=none; b=lt6QwUIJ+9xHSWso25q7pS/rAkKay7uqeB2jzTCMiv6NfCmUS8B2Gft1NBpdxBibw2dbG+UHUN8ILUTLkn6UZvKd2VUgVzU/q4b+NkOLxleUxL9hZsZndTb2rnLeXAC2/HHlGL9uWp5QazEKOSakfCKYeWUDbA6FYXNYNkbzLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317719; c=relaxed/simple;
	bh=N4NafWiJVnP1G9rk3JnOz5c3tGQd7s3GEI4Ga4+SnHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIQctmSMgi3lXhfowkR50yKSZX67fA/ma5XKIC33pWjaPP8s22u7hsPrGjgtYYk80o7iM4kcxE4dUSSTMD5flKzOkwdR6dzTu9NaixeSf5TT7+DutaXbJh6CjqZBh+f/YI/qNozUR1IZCWEzhwI/ATKOLbhKZXajBg15LCMVXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfPyJT1k; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-805fc096a34so2193239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721317717; x=1721922517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu/hFtc8rLkm1iv/03/RXKvj2O6JntzacsCG00S9+0w=;
        b=RfPyJT1kcOKPNN7Sm9j2xTYD6SCuYRtERisjmpyMWsASaesNFV8s6SXzYOSo5514JW
         S3muiXpNe2sX9z0c7V+rFBNUv0OXdlIP2K9VrJajH+G5c0fH3u1PqRVrSJ4O7zj0kena
         hrHdgF1K/P5s5WF75s0ZZYQ38sZW2eOMSt3Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317717; x=1721922517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu/hFtc8rLkm1iv/03/RXKvj2O6JntzacsCG00S9+0w=;
        b=H0CxsPjRrDVPVBwwg7Sk+VOEWBe+YQjC0o/a16lHqhYL3ZDhODOTy5f7VrkdJMx8b2
         mY8YoKZxGueNVqRNWCdNaLo59tig/qDxQ+QQnOoI0jGPCjnIHpTt26Ybs39NOOZVDu+b
         F7w8HQaRzZ0Oxv1QtsLTKfb0gQJHH/dpgLtzkqJ6U95ozzH26AFFaK1EP8BVR+EhPKfY
         5JGL0KdrqjjW3FZrMJj3rIf/WPosbcwQhluQPqFT7spwr5SBPG8Gaz7dqa1kJ1+lBw7J
         oBmMkImKkC1CL6qPrSj/xhHT/zPTtIic4NlvkV5JpyizCFhhnmOaD1FohG7bxxAVrGZz
         XqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYkm3FIcIEQq0GdZ3m+ZH2dRHoxOmGEyE/iiU6IsC4XKNRc9JxHdR89VAIti4DYGlqSIvN7j0CqGw5HykpYD1S/yxNBw5FspzWkleA
X-Gm-Message-State: AOJu0YzxAJxp+EsdLe8JyiVKB6/3rXyfJ1LYoPSJxB9f6F2E42z1p8vS
	myqy1d4pmFJKCqzpK8msyCFhX3mrmnOaFySam/flAQRWBmd0gNATOXksQX1la9o=
X-Google-Smtp-Source: AGHT+IHmMdklMnDvF81muBrH8Y8NYIzffDfV4N4oKaFAtm0kA/02HZYqEw0UAHd8izBu71UsG/SmHg==
X-Received: by 2002:a05:6602:1dca:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-817124ec4ffmr365101139f.3.1721317716717;
        Thu, 18 Jul 2024 08:48:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c35da741sm149375839f.49.2024.07.18.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 08:48:36 -0700 (PDT)
Message-ID: <6a477f29-3425-434d-88a7-b3d619fef2b8@linuxfoundation.org>
Date: Thu, 18 Jul 2024 09:48:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests: x86: check_initial_reg_state: remove
 manual counting and increase maintainability
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
 <20240718113222.867116-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240718113222.867116-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 05:32, Muhammad Usama Anjum wrote:
> Removes manual counting of pass and fail tests. This increases readability
> of tests, but also improves maintainability of the tests. Print logs in
> standard format (without [RUN], [OK] tags)
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - correct description of the patch
> 
> Changes since v2:
> - Update description of the patch and add before/after output
> 
> Before:
>    # selftests: x86: check_initial_reg_state_32
>    # [OK]	All GPRs except SP are 0
>    # [OK]	FLAGS is 0x202
>    ok 5 selftests: x86: check_initial_reg_state_32
> 
> After:
>    # selftests: x86: check_initial_reg_state_32
>    # TAP version 13
>    # 1..2
>    # ok 1 All GPRs except SP are 0
>    # ok 2 FLAGS is 0x202
>    # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>    ok 5 selftests: x86: check_initial_reg_state_32

What's the output you see if you were run this as:

make ksefltest TARGETS=x86

How is this different from the output from the above command?

Please provide the same information for your other patches in this
series

thanks,
-- Shuah

