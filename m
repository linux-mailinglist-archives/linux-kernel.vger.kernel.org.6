Return-Path: <linux-kernel+bounces-368283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306339A0DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C4282C96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E520E011;
	Wed, 16 Oct 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUrilThX"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213154F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091317; cv=none; b=Rr00kn+FB8GcVdGHVHvOnIft4T1qHqtIfQ3mgaqRu9V+PVtvnb3ReBan37a/FqN9fEvJQZCpTEBPj72jqQuTfRONythIw1Pl/ct0TY9g1T8A60XNqv0VxHfWGOTFR05YpN/6X3wFrRf3mkpeIYk3kbw471QahjWJG8k4OyJoNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091317; c=relaxed/simple;
	bh=ugXK4yJBUN+Slya1taqj2nqhxByT0jN7tyoiZsSnCWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOlcc0ZTqATKJRVq0AfrQ/C1WFGAb0H7mQjkn0xHkZw4vzsNHUGN7GpgNiwXE1DqeP12mppiECOpKp6q6s8FD61JB//lxCy0Fc/ot5V084CcOfU3aayeI1q2AkWSEjPqAxqUmypj8WNwY57ls1f9zOGGln8Cmxxj1sF5w5y/sPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUrilThX; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83a9317f93dso65998739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729091315; x=1729696115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4tgYDEMyWF70hV33bnhGys2n1KE306NIrsZuvfC/VQ=;
        b=hUrilThXxuOWoBixMthbICuRxoS56TeBu4FqBmF99oSckfwkJFZC7BQfh0c+zTqbZ3
         46nlNccaipFBTPKmWeZTh9jeBjfmqFAhC3COqXATgWwA38ug1HQBRuXRTCUMusK5r3mt
         usUjyzA8lRJJcpnFnoEszAx/CnkXP3WuW4NGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091315; x=1729696115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4tgYDEMyWF70hV33bnhGys2n1KE306NIrsZuvfC/VQ=;
        b=keGUWvq3WZ06bw4kOKi7xjolMMhN0zAPPgAotpI+Z0DQNc4plNvUQ3vbmNa/B6iRqE
         qyGVFQJGzyaIIe4Vdy1DXlKZRnGsozwh7tL76phH/WyV57/zDCyH6LpZ29ppzvVe2723
         BWAotpWY1IwQ/Tik56ybv1l+Uviqe1RbovJbhq4I68/ec0ex6VOvuhB66HPtRfjagxg5
         kNlyyZx5qI4bMtBH3no2cMYiAsIGaw5ectm/lJkDm/BIFrPexDZF+wutdU3MdqEtnScg
         91Bag+ke8Z3bbVqjlE4tePtZwRvr+ETWl1KWmCcf9+YQcGd7VGUCvJqEoCR7DZTlQTcL
         8GwA==
X-Forwarded-Encrypted: i=1; AJvYcCWVGNVUmh2Qs/FDpLsW2IyOVeb4NUPE0R5LUWYpWepmC9jCN9dbMDjflgTJqmpehBN6sV/z5d1QqM6ciaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN57ymqjCk1uokxd3MajjB7HcQvK7tZgMQvNrBD9nURnAydVC0
	AmBHRcGC8VYMLSXr5r8C7TDMYuLn1oXJpa/cgsS+P0n7PPAOFRp8OjyqzgqogkU=
X-Google-Smtp-Source: AGHT+IEZZ9R5D5k7TiW9DkRGpBKYTHVQXRVjQpBXUXlLF3pytP9NH7nG87Ar66Nko1Wgo1NMA7yySA==
X-Received: by 2002:a05:6602:164a:b0:82c:fdc2:e25a with SMTP id ca18e2360f4ac-83a64bfd806mr1687024939f.0.1729091314567;
        Wed, 16 Oct 2024 08:08:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b28c080sm81265639f.10.2024.10.16.08.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:08:34 -0700 (PDT)
Message-ID: <96ac2fd6-a885-4455-b0c9-91c514c8f3f5@linuxfoundation.org>
Date: Wed, 16 Oct 2024 09:08:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest: hid: add the missing tests directory
To: Benjamin Tissoires <bentiss@kernel.org>, Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015091520.2431150-1-luyun@kylinos.cn>
 <4ioshjncgxafin7jcm7kne5fahp4l5nhk5664mnrdo7fgutgyn@jac5gopdyjty>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4ioshjncgxafin7jcm7kne5fahp4l5nhk5664mnrdo7fgutgyn@jac5gopdyjty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 02:27, Benjamin Tissoires wrote:
> On Oct 15 2024, Yun Lu wrote:
>> Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
>> has added the run-hid-tools-tests.sh script for it to be installed, but
>> I forgot to add the tests directory together.
>>
>> If running the test case without the tests directory,  will results in
>> the following error message:
>>
>>      make -C tools/testing/selftests/ TARGETS=hid install \
>> 	    INSTALL_PATH=$KSFT_INSTALL_PATH
>>      cd $KSFT_INSTALL_PATH
>>      ./run_kselftest.sh -t hid:hid-core.sh
>>
>>    /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: PluggyTeardownRaisedWarning: A plugin raised an exception during an old-style hookwrapper teardown.
>>    Plugin: helpconfig, Hook: pytest_cmdline_parse
>>    UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [...]
>>    __main__.py: error: unrecognized arguments: --udevd
>>      inifile: None
>>      rootdir: /root/linux/kselftest_install/hid
>>
>> In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
>> directory to run tests. The tests directory also needs to be added to be
>> installed.
>>
>> v2: add the error message
>>
>> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> Shuah, I guess you'll want to take this one through your tree given that
> you already took the run-hid-tools-tests.sh one?
> 

Yes. I will take this one. Thanks.

thanks,
-- Shuah


