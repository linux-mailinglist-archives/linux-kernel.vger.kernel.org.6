Return-Path: <linux-kernel+bounces-206737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B3900D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212951C21770
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF5154BF7;
	Fri,  7 Jun 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVm5CLBO"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97C18C3B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793414; cv=none; b=E+wTRV80eMklBq7R+r9an8k+zqvRqs7CHVNdsIFINO2/x9M2nQzLaeZNiF9vOMPDQRnCNmNLCMWxNf5DrfBTk6iJmQOq4TUBzaWYcw6T3qF4VojwwyH8TuVGQOaT4fxBz2fN/1l2tp8EnNMseURR8Aq5qJHTQkAewNXx51KT/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793414; c=relaxed/simple;
	bh=4lBB1i6D3CMpL1sebVA4MOEu5mbvTFNJGHklLktW92s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpQBE09JqXVYucacJmmQG9BqKOpcqm3cvakNyk88rBhrVh0S7/QjvFANZ0ILjyR/yuU+EQdxHqLsR3TGleEc/VZUB4ZhZkLXaBUV2lKcCqF0CBCHIThf52wYB9dOYevbF1J2DcuP3kvoYgRBYBSDXOxQv+kJgddMDToRbTbOtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SVm5CLBO; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36daacdbf21so1119515ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717793411; x=1718398211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Tsn/qL+mtDdN74WcgHwSLEegNRkW7b6+85p+wM/SaY=;
        b=SVm5CLBOGE6r01KcVzxFHulmVF/kYGfRrIxYriDnR8Rq7qmJrJpJSDAuimcj6ak2iV
         Esu+LJywpTSCdn7jHYX2pzF/OhAoGyPiNAKVCBjWBb6oUgLAOxlUrNc3Hlwyg1A4cwje
         QSLP8H3rl5lJL+UQanGxSjylPZWkzyM9qNLUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793411; x=1718398211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Tsn/qL+mtDdN74WcgHwSLEegNRkW7b6+85p+wM/SaY=;
        b=nv29oschD6b2/OsXnCz40td10Ayi5sIVfcsYXB7/mZ/f6CR29ij9NPH3Ds9YYLlSj0
         +hWdfYZsfMbandX2dDxdS9YYj+D9cBl+qs2mHMX4Ec8NGEBHpU/ZgNL2VN1Ca9lOtnbC
         bopwC6sBghAcFyoLWsaxW6jT0fSQy76HwE2oyVQVTDjAmTR2ftSX/fYfOGA8lsasB9Nb
         cl351eWsO2r7jg9zI7CTpULsVwhHNPeihVw40CKokKUHVa3fveqivZExsxVOhplljlkA
         p9qQ5d3LlypcuHm+Ww7Ax70H/oLYNjbNuiPM9xMDHkYBtluLqovFk2Xk2KYjPtYl0v6a
         TkfA==
X-Forwarded-Encrypted: i=1; AJvYcCUG/gQdRywVeK6UW6WNnJ3K287XA3OOQN7K/0YUdtB0pRgnu50afFyIuvxnZTy+FO8hAEVXa8t7NjtlqayVcUloD/2aPAw4QZKwqq+L
X-Gm-Message-State: AOJu0Ywx8zke8fqxxGEuaUK43gBA1m3Mq8qBMx8YscNhkZHYsLGkYwml
	tpjHtL8MN+LjBU1t6IALdIj4DMEkH3BPw3DOKCT1QcGiQL3iPuStwlzOpXW3Zg4=
X-Google-Smtp-Source: AGHT+IG0EQ7MhW11fWVoakWksB7r9JzyxuZOJBpSz3susQA94dzCMF30DRNUqUZkVfYKgBXT5GGdcQ==
X-Received: by 2002:a05:6e02:20c5:b0:374:9916:67 with SMTP id e9e14a558f8ab-37580391410mr40701005ab.3.1717793411129;
        Fri, 07 Jun 2024 13:50:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc14cb50sm9719115ab.32.2024.06.07.13.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:50:10 -0700 (PDT)
Message-ID: <5b8e50e1-8705-4ec5-94ae-2eae010cdf20@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:50:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] selftests: x86: build suite with clang
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
 <ae9de160-c8dc-4e5e-9ec9-4846a5dc643e@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ae9de160-c8dc-4e5e-9ec9-4846a5dc643e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 23:04, Muhammad Usama Anjum wrote:
> Soft reminder
> 
> On 5/1/24 5:29 PM, Muhammad Usama Anjum wrote:
>> This series fixes build errors found by clang to allow the x86 suite to
>> get built with the clang.
>>
>> Unfortunately, there is one bug [1] in the clang becuase of which
>> extended asm isn't handled correctly by it and build fails for
>> sysret_rip.c. Hence even after this series the build of this test would
>> fail with clang. Should we disable this test for now when clang is used
>> until the bug is fixed in clang? Not sure. Any opinions?
>>
>> [1] https://github.com/llvm/llvm-project/issues/53728
>>
>> Muhammad Usama Anjum (8):
>>    selftests: x86: Remove dependence of headers file
>>    selftests: x86: check_initial_reg_state: remove -no-pie while using
>>      -static
>>    selftests: x86: test_vsyscall: remove unused function
>>    selftests: x86: fsgsbase_restore: fix asm directive from =rm to =r
>>    selftests: x86: syscall_arg_fault_32: remove unused variable
>>    selftests: x86: test_FISTTP: use fisttps instead of ambigous fisttp
>>    selftests: x86: fsgsbase: Remove unused function and variable
>>    selftests: x86: amx: Remove unused functions
>>
>>   tools/testing/selftests/x86/Makefile            |  9 +++++----
>>   tools/testing/selftests/x86/amx.c               | 16 ----------------
>>   tools/testing/selftests/x86/fsgsbase.c          |  6 ------
>>   tools/testing/selftests/x86/fsgsbase_restore.c  |  2 +-
>>   tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
>>   tools/testing/selftests/x86/test_FISTTP.c       |  8 ++++----
>>   tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
>>   7 files changed, 10 insertions(+), 37 deletions(-)
>>
> 

These patches usually go through x86 repo.

I need ack from x86 maintainers to take these. I don't see x86 list
cc'ed.

Please make sure to include everybody on these threads to get quicker
response.

thanks,
-- Shuah

