Return-Path: <linux-kernel+bounces-268305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE81942300
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBB11C21878
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90F1917D2;
	Tue, 30 Jul 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eycCCwWp"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692618DF9D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379044; cv=none; b=TNTbhIl6WlDLlU4tiGXX6UWm2Y0fMXYBhhcWc7gHYbFUpbWo7o5huZ/jQl9yH8NWvFOoEByWm2qXDR8eUjPdfp3NKuyaVSNS5Z9gFD3TTkogZxLZ6R90W0rv6slBv6anXn5MKFdnX29xyOddY7mLps7ec55ydRxrTQ2z1EttzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379044; c=relaxed/simple;
	bh=SHSkH6WVtoSt0+9xxmAtSO1AOYxfaTf6X6tRZUPHolk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ota4vptivKS5rTtubshWk+WBtflwUUB6Kj7sDnZMrtJJOOfn4ktJ3zBpj4iMlMisbw7q/hFDRhJtR5kuu+xQj46j7FrFKrB7UvxUyYtm7ugnPukLjoV9nGzuUj3YrLuSA1cn3CpGdlXN4KUQeEUo2LuyyKxvGPYrlN0QK9sS9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eycCCwWp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8075313cc7aso28800239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722379042; x=1722983842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBUf5s8wTKFksIEZ7OczGBQ304rkGN/otRWigA83r3U=;
        b=eycCCwWpMzTN1xAw1zkPz2ptBgB/xQYaYku6IWCCNaoafPvuMeoUjzmRnH+dUcU0X1
         dt7cOrK7yT13HQGyWLIZfavJDtPIU2WNIe2XUOocuTVMmO8RxYsOtvZGtHlNJDDVErBW
         ldsFRHXK0yu4EvWwiBDLnr4XLB0M2pW3vfrRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379042; x=1722983842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBUf5s8wTKFksIEZ7OczGBQ304rkGN/otRWigA83r3U=;
        b=dQ07spv+2pueFeK9nfUZH7rVYYh3dncZYeTGSrIEk7IAUqBPFSuRjbhcFKiv6/uf4S
         0n0cMr715J76VcBSyagf6ijYZWhBn5KJt3MdwQHCzt/uYA4yLywjzSabhwMf2qMHkl7e
         bQWO6R0Ks5JEQ7kyDFza5tKDH3il1XkHz2NPcMZwfRw9H7GK8pDQgO5j45rEtjAREJ5k
         zDajWxHQNFQSo1G3T759HsIh/HK2AbJYvKrFpJ0pJX9YvALTGkCHQc19KdGjDq4OuNW5
         2lC2kSzmOdPe4r2giTf+M4nQkloaT4ZTQ3zLBpexo+07/4xmQlcBznk7wUs0Mflg/Ozf
         +ROg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Tgray3mVcNqdAcQ83VmRVrCuBssOR09lPdKXSXpYvTYjkv2GHMb4d3w0RjmQsHYS2q+CdMyzK/Ba8QNoNDgKxhf+sG6TLnhuxw7t
X-Gm-Message-State: AOJu0YxhLWy3HSnANgqYB0WyJFOFThT8j3eNOFdXjcenDgSYpbiwCXYp
	6+0PhPfxxl3lT0G4nLnCixyudEW367Y9TLoUBFhOMczbzzFN9ZTClWdTO4qZQaU=
X-Google-Smtp-Source: AGHT+IHtcRRr8g3z2xirD6z2B77KRitfjm9MVf5aaQhDzXm8SieKmYtHCoOtv8sMQXc9nZUBZ3mWPw==
X-Received: by 2002:a5e:c91a:0:b0:81f:922a:efdb with SMTP id ca18e2360f4ac-81f922af876mr783327439f.1.1722379042596;
        Tue, 30 Jul 2024 15:37:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d787e4dsm368702839f.25.2024.07.30.15.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:37:22 -0700 (PDT)
Message-ID: <9d5c0793-e90a-4549-92b1-41ad06b85de6@linuxfoundation.org>
Date: Tue, 30 Jul 2024 16:37:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: lib: remove strscpy test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725121212.808206-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725121212.808206-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 06:11, Muhammad Usama Anjum wrote:
> The strscpy test loads test_strscpy module for testing. But test_strscpy
> was converted to Kunit (see fixes). Hence remove strscpy.
> 
> Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Remove from Makefile and config file as well
> ---

As mentioned in other threads on this conversion to kunit and removal
of kselfttest - NACK on this patch.

Please don't send me any more of these conversion and removal patches.

thanks,
-- Shuah

