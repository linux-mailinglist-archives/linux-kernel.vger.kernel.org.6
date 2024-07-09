Return-Path: <linux-kernel+bounces-246788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2E92C6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE621C2240A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651F189F36;
	Tue,  9 Jul 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwMDK9Vb"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4918562C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568332; cv=none; b=Zc7KjEBJdA8X0luCv1iUFQgLWG58nWacBU+FMG4v0j7xOutmQDWuWqflBg0vC6TT0HAYZVoxRhRDwGh+TpaxcjSEUXueakJ9nxOTMPDcp4MLoAv6MyvhFYWVeXtqWlpHEUUxLJ1Yf7/VKTwv0oEDNRy3U71kM3zikOFuf+C2/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568332; c=relaxed/simple;
	bh=RuPp0plIUcm2hiUjMAHcgSlAPWRplrDAy68HI8id/lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSvqdR/EcNMAjrLU3AMoRcNNyX9gy9kVeY8YoA43QLAk7FW9DjWbC8UE1qljKu8ZWvRnC97SpIm9iaD+DZW3cy88LnlVbzdyR676L0QsQYGQe5J3qyKtIBczyLML/IGzznM8tBt92YLJ8ey6TuICShRoYY2NXvV+1536SU5Piro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwMDK9Vb; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f70a7470d3so12805439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568329; x=1721173129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiYRkS5dffbPdY7ESeU8dGrN5NK9uqhcG4NBsVwY9Uk=;
        b=bwMDK9VbqIguYIio6dP5yyoAlf6OC80HlVH9bk0vdfJLWesbgjvloJLO7uhg+Ijr4V
         W6B1Tc2fZ0vrPgKU73DqJN6NEFhkCk8HTcCcO0RkLqCxR6b/L04sptjiVXNpFMuzNTHr
         215nH01BCr8gkxZ2RO8VeHPWczqLzh1Dd2aS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568329; x=1721173129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiYRkS5dffbPdY7ESeU8dGrN5NK9uqhcG4NBsVwY9Uk=;
        b=gVF5pufXwuzQEtdgMPMKeNV0Zlfk6R6uBUuJjwWUkdLm8FjFBKKBIhbdmywKtmXTlL
         0Bex6cKoSJeIr6TNxtCr5d00s1Rgq2R0zUqH2OrOh9nElWgCrq/j4crOK4lC84UiaL1t
         nnmxqjj0b2pv57tnqSoorIIN9DxW7UAkviILclYvRoLjJ8CwE/dgKwvV3oRL3w87Y19T
         0Qi7172whEmu3SQcTyRsx4xVd0uxZb0bSDwH44gMAqCxEWkqy5e7PA3S3OgZ1khnAR8y
         Kkl5O4Tjcmz8pv/r8MvHhJ0GiAjO/fRSvm85esA8XA//h9ZdUHfoqg4+Hjo4ZuxO3oQ6
         Umjw==
X-Forwarded-Encrypted: i=1; AJvYcCURO1zw1C49W/EeJXG83Nrrm+uCAQA+ErZbyYvpgV/p76ohNjy0FGNXL3EY/TqZ7XLcphljnqRvVNPg4iIOjEGMHjmS+5XRNpm7YInJ
X-Gm-Message-State: AOJu0YxbN1wD4wqa9w3Fc35KJblWkNiAtzXXFtUamvO8WQRtyBkkT4wQ
	/YtzRKmQOL+a4ea3U8yiyfW3f5TFWibGmzzdpWxpdrNe6HzSuDn3Ibq74J7PIsQ=
X-Google-Smtp-Source: AGHT+IHdB23dPfRVEiAyF1a/dxmrUpEj/oEeEquP9E9Sbqw7xQ+Zd1yKbrTTUgATJRc5BJA/NXcpLg==
X-Received: by 2002:a05:6602:3413:b0:7f8:bfcd:db53 with SMTP id ca18e2360f4ac-8000269672bmr455275239f.1.1720568329579;
        Tue, 09 Jul 2024 16:38:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c2b576sm764262173.177.2024.07.09.16.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:38:48 -0700 (PDT)
Message-ID: <6854f593-4607-487e-88a0-cd79b193077b@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:38:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/thermel/intel: conform the test to TAP
 output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702101259.1251377-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 04:12, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> The test has infitie loop to read the value of index_str. Break the loop
> after successfully reading the value once and finished the test.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use ksft_exit_fail_perror if read() returns error
> - Break the infinite loop after printing index_str
> ---


Usama,

As I mentioned another TAP conversion patch from you  patch if the
following command gives you TAP, there is  no need to convert.

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

kselftest framework lib.mk and runtests wrappers take care for
TAP. The reason to take care of this at framework level is to
avoid changes to individual tests. The wrapper keys off of
KSFT_* codes returned from tests.

Please don't send TAP conversion patches like this one. The output
from the commands will have duplicate messages. The reason tests
return

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

thanks,
-- Shuah

