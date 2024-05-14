Return-Path: <linux-kernel+bounces-178963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C78C59DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824A01C21464
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5B17F360;
	Tue, 14 May 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwLFwFBk"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A92AF09
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705113; cv=none; b=i9fIx5PEZBMvbo5vfDrUe5IwDjp470kPakrFsPdAA6WtYJc1ZmP47HKhvoiBMYg+X7rYU96MamJq1sIQ7gBukcrba7JsDZ40Dcj3NhP7KJvPmUDJSUKQWrhamqrNVK0PZxuY5qSE7/agHfjVPCzgqbrWm5TI6AU80BQQO1CHKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705113; c=relaxed/simple;
	bh=diyKllqobKbeGJc5R1CZjCecj8JwIgAdEMhvC1ZOIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nS2DdhgX8/TP1WBuIpAARWVqFhMjscGR8bpCP1vHQzvu6zq5Wn1Njfyod+0XoEacGTIHZBsZUqW7xh0tlVYRgtGCwS6EyEvGhsMMmVMwTtY1J0ScZrItidqZfb4tUCCD0f6FYnkw2XKOR9d3aL4TCqQkxggQktI6m8Y+G4gvm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwLFwFBk; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e1b520812fso36430839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715705110; x=1716309910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqKNcj7j0AZZaaEg2IE4Ch533Q1LfRJ1nDU5mEA1FkI=;
        b=SwLFwFBkbB0nbUxeqedwjU/lTmquVv67N+Wv80U2rttrPYQJ4WLoNDAoIU5h0PT52R
         KN6j+gVQQkMe2j9WNJUF7kgNsCe41WdrAEusWLx5PG4T3Twy5QmOGGEdwobuKR85SkVz
         mCf+ttokVOLfUc64RWCziJn33FXRq8Ak5wTmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705110; x=1716309910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqKNcj7j0AZZaaEg2IE4Ch533Q1LfRJ1nDU5mEA1FkI=;
        b=gA354e+eauqcUT7+sWHBFDbtlaODiYEH9TxCm33G0CUTTcFDToBJJdcrhzoE1ljd/Z
         37xY1zjsJQ50qpmKXwKu8JD7sNwi9favZ9H4VuUUC3Ctr50oSNpFEsKsT83eqv/sd+Lb
         skQGgwsDMpiZbtibuZqKjfPWEVpE+tbUc2XjYH6zS+JIeKLu9UAAUV/TaUikPv+o5fxm
         Dfvh2BUQ/ByGT103ULGSjVs/pItIc1t3Ofnl7z/jYwQsA7Taq/ImAESeJX5VFak821G3
         cSKc72NW2AAAUdEsffUEuuMAbMCYnSUqfuP9TsAYMtSakTV5Cre/UadhVjEmg8anejlT
         p0Gg==
X-Gm-Message-State: AOJu0YzNOM5jh9uQsGoLMu7XSQp9aC4AaDB7a1pcs8Hy9+LJ2qDcqN32
	D5nfWFvYBwMMfjuvGpeTg6ifouKZr60ZWqASy2AaoLvHgJWY/a0p9KHrUdaNMLs=
X-Google-Smtp-Source: AGHT+IHJWsjymJ9pgm9nI2xMNo2ER37wCeFcVuOst5E9tYnvhx2Gbm+LFuCTw3kM22zofhBtRP8VSg==
X-Received: by 2002:a92:608:0:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-36cc14e921amr138441975ab.3.1715705110440;
        Tue, 14 May 2024 09:45:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cc9473003sm19088335ab.79.2024.05.14.09.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 09:45:10 -0700 (PDT)
Message-ID: <58fd25ea-c444-45cf-a41d-c3022e9d5f80@linuxfoundation.org>
Date: Tue, 14 May 2024 10:45:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: Pengfei Xu <pengfei.xu@intel.com>, shuah@kernel.org,
 linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jithu.joseph@intel.com,
 ashok.raj@intel.com, sathyanarayanan.kuppuswamy@intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1714447026.git.pengfei.xu@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1714447026.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 21:31, Pengfei Xu wrote:
> To verify IFS (In Field Scan [1]) driver functionality, add the following 6
> test cases:
>    1. Verify that IFS sysfs entries are created after loading the IFS module
>    2. Check if loading an invalid IFS test image fails and loading a valid
>       one succeeds
>    3. Perform IFS scan test on each CPU using all the available image files
>    4. Perform IFS scan with first test image file on a random CPU for 3
>       rounds
>    5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
>    6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds
> 
> These are not exhaustive, but some minimal test runs to check various
> parts of the driver. Some negative tests are also included.
> 
> [1] https://docs.kernel.org/arch/x86/ifs.html
> 
> Pengfei Xu (4):
>    selftests: ifs: verify test interfaces are created by the driver
>    selftests: ifs: verify test image loading functionality
>    selftests: ifs: verify IFS scan test functionality
>    selftests: ifs: verify IFS ARRAY BIST functionality
> 
>   MAINTAINERS                                   |   1 +
>   tools/testing/selftests/Makefile              |   1 +
>   .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
>   .../platform/x86/intel/ifs/test_ifs.sh        | 496 ++++++++++++++++++
>   4 files changed, 504 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
>   create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
> 

I am fine with adding a test. I would need ifs ack or reviewed-by.
I don't see ifs maintainer on on this thread.

thanks,
-- Shuah

