Return-Path: <linux-kernel+bounces-368835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE689A156D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F3F1F21659
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94D61D2F61;
	Wed, 16 Oct 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZpkp0aQ"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF831D3593
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115953; cv=none; b=F2MJ5Y2/QRk14yiFIUmUUwQJY1qSPNF7qAK8zaQdMNCiAR59iEodXeDeyM7BoMP+zvcAXz4fQS7Cq5TTHYXRaOeucHmMDJjb1Xoov9F8s5BBAqAQ8Alkvgxky92lR9+MyHCBuWZLBV25czCO2io0EZyPSpPgKU2HdbfxDztsoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115953; c=relaxed/simple;
	bh=8qYHelQUjDoTybira0O9Q7Zj6yilO0u+xZOecQxQR8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTS1zePCszdO7jIm0Dz7XCDqS7aOnMPrmPNyLX8pX4btitxMz/GNv4eBTRncE17eFdOVws975ecLn75IxzNlJH5i/VhndZZzPTbl7W1z7hZxOvp4Ay9YF7/zz55YryvgcyCR5akOcI0aaQQ5x7PRsC17YzREg10/tP5oHOZk7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZpkp0aQ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a363feabc6so5079615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729115950; x=1729720750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKmb9Wl1EPVaTgFDnEvZmVVLPMr8CXfZoJTK+cdxx8k=;
        b=SZpkp0aQ0wmscAoqCX51/Rtd77yvPbfpofdwArw9mVjk5LW6GMhWPdz0qOFDTQIFvf
         BZjeLJOV6jzy1qR+tLP+MfVLgLnSB03oVkzYQ8pwmzUqyF+HsTo0z6L7TamQnbZaofqu
         ozkAxCb45cn5tMGHnWf+irBLeJSThIW+t1y9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115950; x=1729720750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKmb9Wl1EPVaTgFDnEvZmVVLPMr8CXfZoJTK+cdxx8k=;
        b=byU4si54A58Wh3yrcLGHhMvHE1MoEWDUOx+dqT2q+fMhriJGe+8yqdaCdK5sEg1V0k
         aJijieAmfy5xaVT/Pg934HQliMzDqeN6YrqHB6i8M8kRPnJJz5Rb5kATCOQjtiYH3GMP
         jmL+Z+xu9x+hLJIMZlc4wtN7fd3QNnZBXk8KGMOVriyzdOBOi5m8qWZ+ptfoNVg1Sk30
         4npbHRMr/CSn3K/y1pR1lMN+VQJ6acUkBavogs4xM1fWE8jtrzY3sUhmIM9IaPOXVpdQ
         7n4eX0BKS2kB4rUSuEpi+mCHxDZGfGI/9tE4tD5xI3G03cyHGzvAEZFIblPj+YCUamSc
         LYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE0nVu9SE0OWI/FNa/ILV1TYIkcNjDArhUB5kmggzYVWboj20Hfht5klxayHmC8ny5IfZ+4YRQCF67h2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4R5RJaYuWKqwDgIQLhcIgqeUr70FdG4G4drqaJWMI6m1J6/xo
	Oj8G0zxFHwCPEHAVFrE1Py9OZL2xaH3SCKOfb5crI4ByWf+rOqM2zgDax1DB9c0=
X-Google-Smtp-Source: AGHT+IEPRTO0e9QGvFwLCNnSf650+7rhXWqxmDc8PUGnLVGRYi1Npd/Q8UEd25NszhcXsxF1dwVEuQ==
X-Received: by 2002:a05:6e02:1aaa:b0:3a2:6d54:33df with SMTP id e9e14a558f8ab-3a3e52a7266mr8993475ab.4.1729115950287;
        Wed, 16 Oct 2024 14:59:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc68bcasm1049582173.159.2024.10.16.14.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 14:59:09 -0700 (PDT)
Message-ID: <e5889240-8109-4b75-aa27-25a771c4edf0@linuxfoundation.org>
Date: Wed, 16 Oct 2024 15:59:08 -0600
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
 <96ac2fd6-a885-4455-b0c9-91c514c8f3f5@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <96ac2fd6-a885-4455-b0c9-91c514c8f3f5@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/24 09:08, Shuah Khan wrote:
> On 10/16/24 02:27, Benjamin Tissoires wrote:
>> On Oct 15 2024, Yun Lu wrote:
>>> Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
>>> has added the run-hid-tools-tests.sh script for it to be installed, but
>>> I forgot to add the tests directory together.
>>>
>>> If running the test case without the tests directory,  will results in
>>> the following error message:
>>>
>>>      make -C tools/testing/selftests/ TARGETS=hid install \
>>>         INSTALL_PATH=$KSFT_INSTALL_PATH
>>>      cd $KSFT_INSTALL_PATH
>>>      ./run_kselftest.sh -t hid:hid-core.sh
>>>
>>>    /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: PluggyTeardownRaisedWarning: A plugin raised an exception during an old-style hookwrapper teardown.
>>>    Plugin: helpconfig, Hook: pytest_cmdline_parse
>>>    UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [...]
>>>    __main__.py: error: unrecognized arguments: --udevd
>>>      inifile: None
>>>      rootdir: /root/linux/kselftest_install/hid
>>>
>>> In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
>>> directory to run tests. The tests directory also needs to be added to be
>>> installed.
>>>

Yun Lu,
The patch version information doesn't belong in the change log.
You have to add it below the three dashes as shown below.
Check submitting patches document for details.

---
v2: add the error message

  tools/testing/selftests/hid/Makefile | 1 +
  1 file changed, 1 insertion(+)

There is no need to send another version. I fixed
it up.

>>> v2: add the error message
>>>
>>> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>
>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Thank you.

>>
>> Shuah, I guess you'll want to take this one through your tree given that
>> you already took the run-hid-tools-tests.sh one?
>>
> 
> Yes. I will take this one. Thanks.
> 

Thanks for the patch. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah


