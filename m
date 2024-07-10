Return-Path: <linux-kernel+bounces-248287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51092DB40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C982EB227E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032D11422CE;
	Wed, 10 Jul 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cSf+22fh"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B213C80C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648160; cv=none; b=AxnGUlcXW6E8YKLStkYroVFksonpAr0HKalb2IC5eleZQ9igjMGldA8hnvLfteaIEwC9m2rZswFr9Q8XfopOq8b5RLkA9In0Us1FVkbCMwv40Xl7jvvQSFAB7lS7ATSS36MCB0z0EuHqxWN52Y6SrUvb6ktee1zSlJJkdqhZ+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648160; c=relaxed/simple;
	bh=brE4XTSJWhbb88xBaNooE0Ex2C70boV3laaSm4tuuVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4yZZtsTBU0kPb4LSCwgf2FuCoX8jWHWUL0as7QZlijXeeE7wSYMP0KXc2AjPyIB5YutJUxat5o1TPgdxUg1Uzg0YRsrdD6wsfbV3wi7MYHNql+g+KqVDkjY5fTgXITvqdm0TpYBLwxnHfh7m1KfvKWcTS2u1yyW9luIXyIQsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cSf+22fh; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8045e14c32bso462139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720648157; x=1721252957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtSBaQwe1ySQPE3Nxg4vQj+bxphEtyrHawYS7S+O8iQ=;
        b=cSf+22fh7Hhppl2RmauylXzRrRNRuaqeIlDrPkeYxP5K2cwVGP9qc0NDkVeub9nq4k
         Xb6xQGwUADTgePZtfzFdHIkSqqByCxuwJrGMvdKPGQUPhyEXbyvtXhxt2eR2fr9EKkiT
         SfqsMUG1UqOksFB1UHWT3w/8lkwCw6+DmXj3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648157; x=1721252957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtSBaQwe1ySQPE3Nxg4vQj+bxphEtyrHawYS7S+O8iQ=;
        b=Y8tnWIFwzRToWSc90agaX6FwnNpxZwMB9847WECGSRvSUBU9AxXQgB/roSYLkNG7BY
         r+gZudBrHkcA7PvDPPxVZ5CAoCNQU5B22oRGWqBRIBxB8LRbtvHdEagipSCAJnWegQM4
         CrpT/aKdZSXKIGUj4JsdPm/zmmXJj+Xnm51miMlmCZazM8T9k7CtY4S2lQTRLpKv8RxZ
         +JDUBg6JD+oxb8cx7svF+Wbm7rw8oeiXgpo8SPMHNblKbjbWLn1hQgaZYN4DDTNBFGxp
         xXzICAelo+DHMwl5ji6usnHapGCSaO9BQRqAM4zv0+dp/FeY+DLy2SL0KFVBndsa2GwC
         +ZAw==
X-Forwarded-Encrypted: i=1; AJvYcCXkW07EquXTmdD8sEuFAS3lcr7U3B6WRn83jo48mWvt9dc0P3c1JRkLxQ6ClhntYCRGfm+wTY5bIvOhXzfNkNWTVXhKO1hEx3h+Unvi
X-Gm-Message-State: AOJu0YwSe658eL2WPCLFBYlbpoz5uBDr3qnnYwCrIvG6PTVqS/fii2MJ
	QY1tiJiAF5OgLL1rwiUIjfQCaue+Oq1uLyCqdYGyniELXurZSnPcTCLJkBqhNg8=
X-Google-Smtp-Source: AGHT+IEFRDfD1vEXZq26Y1M1yoffjEsK1KsWIIpjMxCah/7ryd/I5EyLoysc8wgc41iMeh+sQYyfyA==
X-Received: by 2002:a05:6e02:eea:b0:378:cf86:357b with SMTP id e9e14a558f8ab-38d19c2c612mr7398515ab.3.1720648157443;
        Wed, 10 Jul 2024 14:49:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4907578bsm11992935ab.11.2024.07.10.14.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:49:16 -0700 (PDT)
Message-ID: <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
Date: Wed, 10 Jul 2024 15:49:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernelci@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2024071003-islamist-expediter-a22c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/24 07:11, Greg Kroah-Hartman wrote:
> On Fri, Jul 05, 2024 at 07:29:53PM -0400, Nícolas F. R. A. Prado wrote:
>> Log errors are the most widely used mechanism for reporting issues in
>> the kernel. When an error is logged using the device helpers, eg
>> dev_err(), it gets metadata attached that identifies the subsystem and
>> device where the message is coming from. This series makes use of that
>> metadata in a new test to report which devices logged errors.
>>
>> The first two patches move a test and a helper script to keep things
>> organized before this new test is added in the third patch.
>>
>> It is expected that there might be many false-positive error messages
>> throughout the drivers code which will be reported by this test. By
>> having this test in the first place and working through the results we
>> can address those occurrences by adjusting the loglevel of the messages
>> that turn out to not be real errors that require the user's attention.
>> It will also motivate additional error messages to be introduced in the
>> code to detect real errors where they turn out to be missing, since
>> it will be possible to detect said issues automatically.
>>
>> As an example, below you can see the test result for
>> mt8192-asurada-spherion. The single standing issue has been investigated
>> and will be addressed in an EC firmware update [1]:
>>
>> TAP version 13
>> 1..1
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `model_name' property: -6
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>> not ok 1 +power_supply:sbs-8-000b
>>   Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>
>> [1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Is this dependent on a linux-next?

Didn't apply to linux-kselftest next.

thanks,
-- Shuah


