Return-Path: <linux-kernel+bounces-346159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09198C07F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C03F1C23AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0A1C9EAB;
	Tue,  1 Oct 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsI5mclX"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C81C9DFD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793645; cv=none; b=ZwkxIdZtJiemTgIQMshWIc+ePJQrvUFJgF66giOGFQaqKj6CdTnuW3PcH44e+HFvQfsir5Cpw2PubY9mlwaXzgB4uiPhPggeuy7+t3laVI/g9wzbySklvXrpHmEnX3p/KP4tLd8zDt2L77GYNZ2xALjCEnw+PEQrROQMeZPMvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793645; c=relaxed/simple;
	bh=zxHbuzdK8nWsF4Qd8mbyl+FzEThCtJXb9mYf/9pkr5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7KRUYvKrx1HoeR1KvakvDbnVjEdDSUck7YjSqPhLkv6TWVpCT6+MxszdXS4Auwk5mtc+OI1dZpf2J5t9P8DH8sMoQcasIKNsCP882bv01OJnjOm0Wu7KQgJgiF3vmAXAGbqzb/XsN4C92lPoD2kdfKUgs2XcCzMQnysLZOYqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsI5mclX; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82aa3f65864so249220439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727793641; x=1728398441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH6Gj5o0Dsut7SHZMO7xTQsbpbbShGmKYJpl5e/my0c=;
        b=QsI5mclXbbkvXpZcY5hQvpYnB19G2hBKY4+uGsJ8BOEEuqlRHcvSEI1fxE45FJ3NJy
         xab9jJbltK0Gk9GDODw2ghaYxPEN2InJFYbMVM3xRlhXsHnVVF6BldzY18oW4cGtcVY/
         JJOQPKJwBOwWKbqcQRSLuefkK6ewPO7fLxUUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793641; x=1728398441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6Gj5o0Dsut7SHZMO7xTQsbpbbShGmKYJpl5e/my0c=;
        b=ZE7ltnanaM/HRmf79P4dyvmV3GYyBVPvom3vfTeC0FFbdtTdSC2Nd70KlAvmEuLmuJ
         1D+VoDPrkS/3nJ7Ehtj5LgvuiAC5WBQBWmp6n7CX0EZUE3szY+EsGp39u9KxSPA/92FE
         FOGoW6pRBc40gDhIKeEnEA23th5BdGiKEaJpUmp3NGTKoaQ8/LCTFI9QLzVzvcY9w4lC
         MWhRRjePp8111+fvfTaE8c4AyG9Y5vAbNcn8ViDIIPjFB8rMRCnQjDYhkH6QzUo7ZK85
         obmjNiYH8Q/NneRNYWsNv+Z0i2ON7sz2INRDvIGD383pJbLNKMlmjxJr2f4yrPKHzl1R
         ZxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8aJ44U2dvfFZUiqcHhxbzBa0y00Rvh6C+Gu9hGag0RAPHd2EWeiV6n4rUpexUrFzPCyEXzWo+uqjypXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQWHpLexZ/wv2/cKFvdl5MKPfs879in1jvJr/5BBnX0AiGjBJ
	BVMG1xcQVf/vhnWIOsDIeIUL1qtUdEVvtatmr1CsXa9R7FCYGFWATpLRTTPORtI=
X-Google-Smtp-Source: AGHT+IHaEVwDtNrwo0NR3zyG0+hO0l1ljDQU1Gt3urcoO8IOOyU9n3Km7W8VE6gwm2ssz1JIotug6Q==
X-Received: by 2002:a05:6602:148c:b0:82c:d67d:aa91 with SMTP id ca18e2360f4ac-834d83bd384mr3618639f.1.1727793641103;
        Tue, 01 Oct 2024 07:40:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936e2c94sm280716139f.29.2024.10.01.07.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:40:40 -0700 (PDT)
Message-ID: <04fac319-2cfe-46ff-b932-e3c867d1c9b2@linuxfoundation.org>
Date: Tue, 1 Oct 2024 08:40:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
To: luyun <luyun@kylinos.cn>, Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240929085549.3528293-1-luyun@kylinos.cn>
 <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
 <7910784d-18c2-4e72-9dd8-6b8bd1b9dd0b@linuxfoundation.org>
 <c9763b7c-fc93-44cf-bccb-9709a542e3e6@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c9763b7c-fc93-44cf-bccb-9709a542e3e6@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 20:43, luyun wrote:
> 
> 在 2024/10/1 04:57, Shuah Khan 写道:
>> On 9/30/24 02:38, Benjamin Tissoires wrote:
>>> On Sep 29 2024, Yun Lu wrote:
>>>> The HID test cases actually run tests using the run-hid-tools-tests.sh
>>>> script. However, if installed with "make install", the run-hid-tools-tests.sh
>>>> script will not be copied over, resulting in the following error message.
>>>>
>>>>    make -C tools/testing/selftests/ TARGETS=hid install \
>>>>          INSTALL_PATH=$KSFT_INSTALL_PATH
>>>>
>>>>    cd $KSFT_INSTALL_PATH
>>>>    ./run_kselftest.sh -c hid
>>>>
>>>> selftests: hid: hid-core.sh
>>>> bash: ./run-hid-tools-tests.sh: No such file or directory
>>>>
>>>> So add the run-hid-tools-tests.sh script to the TEST_FILES in the Makefile.
>>>>
>>>
>>> I assume we probably also want:
>>>
>>> Cc: stable@vger.kernel.org
>>>
>>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>>
>>> Not sure about the timing regarding our next PR to Linus, so in any cases:
>>>
>>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
>>
>> Thank you. This commit appears to be right one for Fixes tag?
>>
>> Is this the right commit for Fixes tag:
>>
>> Fixes: commit ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
> 
> Yes,  the run-hid-tools-tests.sh script has been introduced since commit ffb85d5c9e80,
> 
> but not added to TEST_FILES.
> 
>>
>> Will apply with this tag added to linux-kselftest fixes for next rc
>> once I get conformation.
> 
> So should I need to send a v2 patch to add the Fixes and Cc tags?
> 
> 

No need to send v2 - I added the Fixes tag and applied to linux-kselftest fixes
branch for next rc.

thanks,
-- Shuah


