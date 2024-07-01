Return-Path: <linux-kernel+bounces-236932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00391E8BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E41F22250
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AD16F8E9;
	Mon,  1 Jul 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FVNE8Wog"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7516D9BA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862812; cv=none; b=dyoLB+aoQlqBcDOZX/cPCjeOjvN2xL1guQEAC9EYfZMOA+zbodfh2TSPzAw7g4w/UAbse51Cwo0veGjox+8prTNuIXg54BAbHJr+8w2ZtpQ48b7dD+w9DWwwB7hRom9KP993ekyI0JmGIvPsHny/QfCU+rIQlxWQJ5zZ7tqsw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862812; c=relaxed/simple;
	bh=Osp/Q2MP0iI+oJriW8ZjrL3Eg4r3SKimzRBMLOLVGq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af54efQDq/kGW/kc9f3dXuXy3aCg305rGDup7DSuLHJEYjl7VvdX0x9r/FhkU7Vg2QP6OOojD0ZQ2bHXN1qaz+9IQiZG4CGiy3l/IMD8ECigl47hJD4Zoqc17VTmogEXOIYypij5pp6rbh1cnT0ySCW7YqHsOiKTH4B3CIrUvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FVNE8Wog; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f3ca9bc769so7669139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719862810; x=1720467610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DAhhPyLlfY/a7RrnttMrssdLFe9/7+sNUUJTZ5aCBQ0=;
        b=FVNE8Wog2pGzYfF/O6XlfJPF+D79v4UcmTyhowZ7Lo6jr1e/2/t0Pb5yXQy2rCx6PJ
         YJgDk98h66ecO0grkQ9oz7NTNBq7oAAbFxV1P/Yqi++UaDzPkr4gAuxp9u6thARklVzI
         Atu3IcmVuxEWSBfOHwZqovGTGeBFAxPRNDy48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862810; x=1720467610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAhhPyLlfY/a7RrnttMrssdLFe9/7+sNUUJTZ5aCBQ0=;
        b=NSkjluFoJyB2jJUUNSJPJfjihnxVrAT8I85XZrbnPHs8QQXswfLVZCOnKjsdZdnKOB
         OkLPRYORHfE6ZbIxgmt+lWJ/NKxxNhKsVqezs2WBjNvyKhbIeWm+0pVuxRbAF8aJP1TB
         PIPcl0vlJTG1F7czVSX0MguR9b7fHAHLE7EOU/nAeYCZzq2kDRvMdxoA/xAR8CSvRMJ4
         EcVE7IFkdpqFJeR8fNXxmq2D/LEgz6aI63HQ3XF8xRZjTwc19leaLvh+ZSfah/2kakoN
         mjFP19RoYG9Hb93pze/dfR67gI1YT9B3jSvTE5ovXms3RwBobYw1l3kqEW6OaHM1p0rN
         CPXg==
X-Forwarded-Encrypted: i=1; AJvYcCUp/gJmZnKYB+/0ru1kmEFQWqLQ3J0/CCKp2H8/Wz7eM07F3xqcZysmI9+SWkaLRvfmqKvrLBm5rxQiWGUHb2u1lFgTEg7oLQzMR+vT
X-Gm-Message-State: AOJu0YyVQgKuaEGhq1by9A0lxvSiKR5hB3kN9hJdHNpEVg/vO3H+44kx
	WJ/mc3cPCvf97BR9Ymt27XLA+xK0RAaGYpKD/KPjlGhZpaq13/+cUQ0VWULu0bI=
X-Google-Smtp-Source: AGHT+IF8axZ2/vy/hXd0tRQ0/E+Tei2rSB81t2iyY6jdEbqmwfAm/hp1ooFCB8a4pZpHMxGxuu1nfQ==
X-Received: by 2002:a5e:8908:0:b0:7f3:9ef8:30a4 with SMTP id ca18e2360f4ac-7f62ee595b8mr564143839f.1.1719862810525;
        Mon, 01 Jul 2024 12:40:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd4b82sm2406130173.42.2024.07.01.12.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:40:10 -0700 (PDT)
Message-ID: <501954d6-3f0a-4f1e-863b-c60353435700@linuxfoundation.org>
Date: Mon, 1 Jul 2024 13:40:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
 <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
 <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/29/24 04:48, Roman Storozhenko wrote:
> On Fri, Jun 28, 2024 at 9:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/28/24 05:30, Roman Storozhenko wrote:
>>> On Thu, Jun 27, 2024 at 7:33 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 6/27/24 01:49, Roman Storozhenko wrote:
>>>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>>>> render appropriate help info for a particular subcommand:
>>>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>>>> with error message like 'No manual entry for cpupower-monitor.1'
>>>>> The issue is that under the hood it calls 'exec' function with
>>>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>>>> standard system man paths.
>>>>> Make subcommands help available for a user by setting up 'MANPATH'
>>>>> environment variable to the custom installation man pages dir. That
>>>>> variable value will be prepended to the man pages standard search paths
>>>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>>>
>>>> What I am asking you is what happens when you set the MANPATH before
>>>> running the command?
>>>
>>> It adds the custom search path to the beginning of the MANPATH variable.
>>> I tested this case. All works as expected.
>>>
>>
>> Let's try again. What happens if you run the command with MANPATH set and
>> exported and then run the command. Can you send the output?
> 
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /tmp/
> hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=lib64/
> bin/cpupower help monitor
> ...................
> man output
> ...................
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /tmp/
> hedin@laptop:~/prj/cpupower/install/usr$
> 

Is this with your patch or mainline? Can you give cut and paste
the man output here for the mainline coupower without your patch?

thanks,
-- Shuah


