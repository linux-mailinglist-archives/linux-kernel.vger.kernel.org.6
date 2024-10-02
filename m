Return-Path: <linux-kernel+bounces-348223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01998E44E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DBA1F233AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3118217307;
	Wed,  2 Oct 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gr9bn852"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B59216A20
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901584; cv=none; b=dfVpSUwh8FBFeHqWZG52F9OpXN/62O6IYJtkYnwsT2rbCGHcVPFTKI83jaa0bDqtbSrFwPlrvbqDnZsQSam/e1xDGrXcEqiDAdd3ZzNKEACHw1oNWCX2HqtUYlU5LGn7m0a611H56RXLNj5maXUJ6IRjH7ElQMEmpMxez2H5dII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901584; c=relaxed/simple;
	bh=w2ZD0+YIPjKopFJ/fFPeXxClssMJBJqEeAoVQ/XgxsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWxJr2DOrUW+7AnSxwRInBpRsve/3c0HMWVzNPvZekGurHlQMcJw1+Rq3CGeuqsE5uQN5TFnclaLkMoHrfnGqCQi1w6dCP3LSMuJqKGtcObGS6q1PpteVEt6nRrL0a4IOlbd70Ol3pi4Stnc7QWgvUtUkF8YbrkFZgZb0QTEYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gr9bn852; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a34517248dso981595ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727901581; x=1728506381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKdE3ZYSRzWzEBdecF3TYnrD5ck9Yz/T8utWruczAjQ=;
        b=gr9bn852z3M3Vm+/L8uTm2m5hLmKcNfFO8usJiSvxTMdPV0sMTpyAqvcGY6I86FyhS
         rqJgY2+TJyPrZm3FVTevI/U2NgZaOE4rr01nNY/uX3V4pIFs558VeIX1eoV1NyWNrX6b
         lypBNorxnWQ5swTSDCVq1dnl6UxiVltmPDtV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901581; x=1728506381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKdE3ZYSRzWzEBdecF3TYnrD5ck9Yz/T8utWruczAjQ=;
        b=V9Hatr2nak0hok2qLeHTFPfs52KN8kxQEek67kFeKlmjJuu0nPrS0UUcDZS6flarPH
         sGKnsBM5W89KZ5dYzJbqg9ycqGCkSU6t1seVOtjunIWXwq0FCT6TLPGefPaeDlp55ffT
         qW9mJyatFnRI0rIxbHOXmJZd4dVV9eYAH14gOChZMmtKWd7PjwA31zPI0Djr56e+5yDq
         EDIMyyhJBVKdniI2Yp018PRl3vO1XSH70oo4So7U15gyo0Pno1bgzud2u9gZrF5D4gj8
         KcAwoRiUZ+qctMD8OWy01CvWLcDFFy/YXD602VPBdOrxOg6e864AKZwLcqI1L5MZ+aaT
         18cg==
X-Forwarded-Encrypted: i=1; AJvYcCUPnjH2+9nRSutJxXOeDvYVhuBkEvSfeYiJEP+r1Rd+kfmtCK54Wc7PAMy7xQ+ZdloDBNm1unXjhCAY8KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OBKGDDvjBQVhVDnXlpLXFtxIPadlnlPgUyrkGDLu0i9BQJr3
	7K9f/qe0ImlOrdQJSgoR8ggdqadd3YKyosXkrm0IBwipwzzpxZapAEMGTt/qgmY=
X-Google-Smtp-Source: AGHT+IFpMa24H9qgWYeUopGct4f/5GP33n2RJ9cR5Tkp8zcUx51HIJcsjkUoCPmlaNQQnkBRPOX7jA==
X-Received: by 2002:a92:b710:0:b0:3a3:67b1:3080 with SMTP id e9e14a558f8ab-3a367b131b3mr27415165ab.7.1727901580791;
        Wed, 02 Oct 2024 13:39:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835090sm3239656173.15.2024.10.02.13.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:39:40 -0700 (PDT)
Message-ID: <6b46f75a-cfef-4426-bab7-68959d044978@linuxfoundation.org>
Date: Wed, 2 Oct 2024 14:39:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "list: test: fix tests for list_cut_position()"
To: Jacob Keller <jacob.e.keller@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, David Gow <davidgow@google.com>
Cc: akpm@linux-foundation.org, davidgow@google.com,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, richard120310@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240922150507.553814-1-linux@roeck-us.net>
 <dd9b940d-c5a6-46aa-ab00-73cbb3cab635@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dd9b940d-c5a6-46aa-ab00-73cbb3cab635@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 17:18, Jacob Keller wrote:
> 
> 
> On 9/22/2024 8:05 AM, Guenter Roeck wrote:
>> This reverts commit e620799c414a035dea1208bcb51c869744931dbb.
>>
>> The commit introduces unit test failures.
>>
>>       Expected cur == &entries[i], but
>>           cur == 0000037fffadfd80
>>           &entries[i] == 0000037fffadfd60
>>       # list_test_list_cut_position: pass:0 fail:1 skip:0 total:1
>>       not ok 21 list_test_list_cut_position
>>       # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
>>       Expected cur == &entries[i], but
>>           cur == 0000037fffa9fd70
>>           &entries[i] == 0000037fffa9fd60
>>       # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
>>       Expected cur == &entries[i], but
>>           cur == 0000037fffa9fd80
>>           &entries[i] == 0000037fffa9fd70
>>
>> Revert it.
>>
>> Fixes: e620799c414a ("list: test: fix tests for list_cut_position()")
>> Cc: I Hsin Cheng <richard120310@gmail.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
> 
> I ran into this as well.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 

Please take a look and let me know if you are okay with this patch.

thanks,
-- Shuah


