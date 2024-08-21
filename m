Return-Path: <linux-kernel+bounces-294997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0088E95952F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753C2B23456
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1C193435;
	Wed, 21 Aug 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfcvXzTF"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E131185B5C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223500; cv=none; b=u5jb27NOe89l+P/BldP7RQNw/WaLClg6f58vhyjGCPbmqivU/qMiE54snUgQGBPlV67Z5EgGb2jgr6Z9w86xuE7Uz2UPBK+8vSHEKaRSyde86tUAumCf3L39hLPhrZsYcxgiT3pfOAkb5imkRNZT1D6eyDzOfQkNraM7+6AhtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223500; c=relaxed/simple;
	bh=nGwwZKR0gRYMSEgmiBVAnzD1Pp9OdshUmU94NyLhtDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjTXJfNE12Ga2q99CRPRCf/AyuXO+Z+mErLp5jx2yUcDcUKq/kSPtu6O2ibY4Q+A3ZW0qQnxGpQ0eKMaC9pcrkPRDsTb0VPFNTHm1eTJjXhD+ZEdOp5Fv2hiFg8JA1JRRmX+ZBYKIl6DzCPaoZKpdK81KYf7jDH48ALEy7V02b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfcvXzTF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so3901973eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724223498; x=1724828298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcwV5E+ok4Ru342pseyjnU3pRtPhY0hqDhnMEPHRasQ=;
        b=ZfcvXzTFGkfCFK3z9dez8lyTGhgj6gz23qAH/MPvW9twfEeLazeZR/rm0TzqV5X0Qw
         RLLVI8jpT0R/bzVz8ozILE3h5ImiAnJqnJhX45SkU6t6/Mnmp4LIIbkU2ToY6/wD0E6h
         vZAeLf37xClvrzr7RfF1GkofdnvaOl1eoU/zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724223498; x=1724828298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcwV5E+ok4Ru342pseyjnU3pRtPhY0hqDhnMEPHRasQ=;
        b=upyuqdVD5R6RWhTiCv9xoqDHTRrG5yOEtO9+tz05XTamtej+w9WycQTrM8X9rb8Z0u
         iZumjocdO3U7YHCnUQCukqHFDESMUF1LBknPoaTdXmMBugGkJm9N0RsBRAHnfLAnENBq
         qkR7zMSFtrSu/7NjcwTneXlMQ8O76yjobNGvE6XJWUa1+yrMWXsx4/qzIKRMbbppbf3G
         VXKkZOHtYQwHukAlXhDNYqWpfEP/OJE1NuVchak0HWExi65RqQrBeRN+rIXl9xYZ89wJ
         lGB+KvVPedMUuYf3+HQ+/5l6ZTAsY2EtU755f2oVfKQXSs4uWAFDlWVJXyL8zYY1mrut
         c1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX8pdco7f9KHevkbByzxTplv1AO2Y1CWONQdF5cKfTng/AnWr1hQkl4Yi7HaEaWvPtGHDy9Q3MRI574mGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMDX2vyZNdVydor3O+fqcE7wy/P7oQrqpPjrkOojY0HSXl8h/
	vTT0ynTTQgvmXqlo3pb26+Q0Q0nwmcFAvlDIdXvURcvfTzu1hqZ7D6JdTJGJm7U=
X-Google-Smtp-Source: AGHT+IGW3lZ+wVRaP439HYZTg2+EKRY2iSpAqSNAreo/hH4Ej36HDf8GGY057zCw2mgnCuU1Pw4OyQ==
X-Received: by 2002:a05:6358:531f:b0:1ad:95db:b6f2 with SMTP id e5c5f4694b2df-1b59f97b0e5mr218971355d.17.1724223497985;
        Tue, 20 Aug 2024 23:58:17 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6365afcsm10384733a12.87.2024.08.20.23.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:58:17 -0700 (PDT)
Message-ID: <f377d9c2-9bad-418e-b02a-9ef4f45d7b06@linuxfoundation.org>
Date: Wed, 21 Aug 2024 00:58:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix test to handle both old and new
 kernels
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuahkhan@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240515013620.098cb37a@rorschach.local.home>
 <20240614124322.36ad7652@rorschach.local.home>
 <20240819152002.3ecc8100@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240819152002.3ecc8100@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 13:20, Steven Rostedt wrote:
> On Fri, 14 Jun 2024 12:43:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you take this through your tree?
> 
> Ping.
> 
> -- Steve
> 
>>
>> Thanks,
>>
>> -- Steve
>>
>>
>> On Wed, 15 May 2024 01:36:20 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> The function "scheduler_tick" was renamed to "sched_tick" and a selftest
>>> that used that function for testing function trace filtering used that
>>> function as part of the test.
>>>
>>> But the change causes it to fail when run on older kernels. As tests
>>> should not fail on older kernels, add a check to see which name is
>>> available before testing.
>>>
>>> Fixes: 86dd6c04ef9f2 ("sched/balancing: Rename scheduler_tick() => sched_tick()")
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Sorry about the delay.

It is now applied to liniux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

