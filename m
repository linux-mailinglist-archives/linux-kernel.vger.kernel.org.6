Return-Path: <linux-kernel+bounces-206740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C82900D34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71FB283E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C567154C14;
	Fri,  7 Jun 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGsO3Qlr"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80C33EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793537; cv=none; b=DNeTBDGQgxGc8Xg438oVID8CkJXyG0UO0vnJVtBDpLHzgRUhVOsf5HYjQlfCd5AKsGJNuIX1IMav/vfp0N6LK6abzPJoK1VAtI8TsUMSHthAjC7Vf99tvfP19RU6IYyX2Oce0eUQ8z7vZglu0tqryUDuTSwk53dH5oEVUmSynIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793537; c=relaxed/simple;
	bh=SZ6Wc5Vq8jwCEgLW64CL8jql1u90RGIlvXFNkn1siwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCFaJfqMtGPRdLL65HYyePDeMnDNcu2rlraCN4hvp4Mzv4X5zQvxXRQpePof6kgI8KVKl3oxhHh7l+qJCzwzqZ6XD/JlqMCwKUTgKDLVDr+AgoUTe2V9IfrLO7GalUIqgvbC2GPjQe8/g8VJ+OuC8cBY1u0UWxHyZMHTdjVNjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGsO3Qlr; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb358b6f3cso5152739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717793534; x=1718398334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJaJkiWYiViUf/fnTVHHvyeYTFZz48/UDD814ZGGe2s=;
        b=hGsO3QlrKyXfpXOuJr+0arRkoUWYY9oDy+GuPOq2NtwwTS0r6JVgrDnuSkgMFlHkcy
         ZoCB3F1IjSecmDhuOJjXuVTkLjK9vewEw0HV8u5k6l7PGDFEj2V6er0czr/E/XwGZ5xI
         Hb7iZlhHX2dJOHJztpuNPEehkQCGc6KuGcO5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793534; x=1718398334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJaJkiWYiViUf/fnTVHHvyeYTFZz48/UDD814ZGGe2s=;
        b=Tjqhq2e5JfAvcUNyirSwGnB/G2j2UmLtnCZMwjwtyhlJTPSBtrv/4/eQN1lvC+8WAD
         v9fnjY+Kle9Fmj1f01a5mQWC6oSkX8u/XiBL9roIzbu1988n+bfN1QEPDTm8fc5q66lb
         dV4ZEA4NKfcq49urLVWNQQRl0X2h9y3zXVm+vv/wWmhFLMJpdzF8qudJuDwhNJNKniZL
         CTdR2aD7XdxZ++vx3/yXsRplvEG1vSlyVfPJxcnP4urIOg4B5uOEy1WKUkFU3Mdb/01u
         T3l8QqpO6BxfjZKPCfbx5Av0ewORLz1aQU2RuveiHDdGh9E3aZC5iRJR53akSfIC4bO4
         yiFw==
X-Forwarded-Encrypted: i=1; AJvYcCW7BTk1BXmU3VeO610YDJDwFRID9Jsd/dcXmvi5vvKv1ugSJ01aB/SWZhDV6Rgh6YulQ+Pfw0XGa18TEPP0fjnzRXg9fKIO/oh4mCGj
X-Gm-Message-State: AOJu0YzXwFaUbOM93JSAslYzOc1oe5Qw/FTMI2Vp67qqhqTHxAJJCgr9
	KWckhPE4w9px17Bl7Uq9PfUYd+0mEKfkVnshR+54gCqEmDu07YwK8SqSDDa7tzY=
X-Google-Smtp-Source: AGHT+IEwyNkUhgFCMEL2V3lKkmLRF1SDEdrxPDCpCkbfuJ3PZjTBFOKh0XicN33feeiX7FEx4xTs7g==
X-Received: by 2002:a05:6602:8ca:b0:7eb:2c80:5354 with SMTP id ca18e2360f4ac-7eb5712c5a8mr370364639f.0.1717793533991;
        Fri, 07 Jun 2024 13:52:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a227d79dsm1013349173.77.2024.06.07.13.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:52:13 -0700 (PDT)
Message-ID: <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:52:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 23:04, Muhammad Usama Anjum wrote:
> Kind reminder
> 
> On 4/14/24 6:18 PM, Muhammad Usama Anjum wrote:
>> In this series, 4 tests are being conformed to TAP.
>>
>> Muhammad Usama Anjum (4):
>>    selftests: x86: check_initial_reg_state: conform test to TAP format
>>      output
>>    selftests: x86: corrupt_xstate_header: conform test to TAP format
>>      output
>>    selftests: fsgsbase_restore: conform test to TAP format output
>>    selftests: entry_from_vm86: conform test to TAP format output
>>
>>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>>   4 files changed, 139 insertions(+), 141 deletions(-)
>>
> 

These patches usually go through x86 repo to avoid merge conflicts.

I need ack from x86 maintainers to take these. I don't see x86 list
cc'ed.

Please make sure to include everybody on these threads to get quicker
response.

thanks,
-- Shuah


