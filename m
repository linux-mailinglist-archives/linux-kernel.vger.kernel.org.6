Return-Path: <linux-kernel+bounces-522398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6DA3C9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234EB174CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B61235C1B;
	Wed, 19 Feb 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcrgGAiV"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECD235C04
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996854; cv=none; b=u30lRSPJpiAORArhDSXHHrQp2XKY1T1qZuMJATYceAmxxcQGul0nmUQgCJTtPSsK3pBZfVD51vCjStZkSZqm/TksiIvjvdcIs0po7G8bhLqKM96cTZd98NM+hJEAhnxXaddvUZ4nT7KxHVkqiuXtUZL/zP4T5A6MTn5JrESJVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996854; c=relaxed/simple;
	bh=7+3Oqsi9t4NAojKLqXCl76z8Q1Z6durWBRdTaAMdOk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuCeCNW2EiN4PAyqGEFYOArALc2uYu47lCaSO9Y8FxM+hztkMNj+0RLjuVySnJctKI6yiz+nHBTvTyEGjRJim9LlYEI2MjqL+q4TDZCYgDNWWMSgK0vKOqPEgSYU7j4w7Zjlt3N87iVN1ljKTS0XvossxFq45QF21HEeLdrgptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcrgGAiV; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d285a447a7so573245ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739996851; x=1740601651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsejSwHwkJ6QYid4RdG2XJ8ehgacoeNREUlPqfWGagg=;
        b=LcrgGAiVsxBJep8L/RAtGhvrAmXixJtE+t6rA2D1J7i7876YdWxvq6E4v3/coojVhK
         Hn7WRLp9Wa7aie4OjBKKpMPzuQd7H9OFVQdTT6caQapOPRp5vkDdiTtMuDtgP1OVjKQm
         abTynkAjaywPneIX5Ye7Q5x2xoOdWXTW92AYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996851; x=1740601651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsejSwHwkJ6QYid4RdG2XJ8ehgacoeNREUlPqfWGagg=;
        b=vgrdUIvl7jeQYtwY71ySj9D9jtF/X5pgDa80rbkYJJkt9VmSdKAWi7vZsiidJuS6VH
         sSry3IbgiM1S7xRsXSzwt9Pp41pdheIs0G9Biroa7yNqsMsPIws3C8J/D40rBk+6QwjP
         xMRxMOCjrduohU2wFuhLRNmzFQVUSn0QS9kNuV2mZnV5Fek+kDmx4E6gG0KI50uru9id
         eNn4xchEZuARzt7cIkwr13cq29jG+hWG3PJZ/Jz3TnzFtJD+g/7ED6ZRmxn2e+WWQ144
         3AE7hfGPn0ssWZ0POaiVwcd1utFSt5F9yY5/lTvd04aLFydpqi2AfgJru8TL2+EdH2hy
         vTXA==
X-Forwarded-Encrypted: i=1; AJvYcCVuxHnqQi5CVbBYYnGE5LuJO9kqD5tm+C6ttDsFMWyJFAgwaEyeoFzP4UGoE28GHPDHaf4+mehYePvThGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oEoHeQ7Sw/4aiK2MhYdkKy/dy+Ors5oduS3KM3BefwtHWPhC
	lh8K9cBjNuJI4Aw+5V99U9Ud6G1V2XT7AeNnzo2TlQJBUz/n9qAYmSWZCwnjZTk=
X-Gm-Gg: ASbGnctyKWJ/xBVzx21/faPeHatec4leadVvVe1PELIlcdJerrqPWGP3PBjcOBudDfE
	emSf+lnOKk94u8g1jroDervjQJLrz4FmXqSXzDqpRJsYo4b3yk6qjmgA/+wJPRgeB2FXX7twLKx
	JFlnzOKkkDcALdxgyUTPTac/IN13IaZehBeWUEjUD1GHT8eZ0J3SoCHbqHjcswHZFOB1UkbRDGj
	UaNTL8BvabdwKbyXlIu7pflS/axInbGicho5zs5Y2kmlNHHkFCxO0pmQflrchUTDr1VfM5+S1HF
	Hizeer3JxZAePNrDpdBHZEUXzA==
X-Google-Smtp-Source: AGHT+IEfJAW3Yclfr0r5XudDdE31KDxPhhhC1Meiegi+EQSUrtQ6tXr0burmxFZLwf/V7Os++FKJzw==
X-Received: by 2002:a05:6e02:1a2e:b0:3d0:47cf:869c with SMTP id e9e14a558f8ab-3d280949c9emr151862565ab.19.1739996851528;
        Wed, 19 Feb 2025 12:27:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee980374dasm1713460173.3.2025.02.19.12.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:27:31 -0800 (PST)
Message-ID: <88d440c0-6a84-4483-939e-9f69e1d7befe@linuxfoundation.org>
Date: Wed, 19 Feb 2025 13:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: monitor: Exit with error status if execvp()
 fail
To: Yiwei Lin <s921975628@gmail.com>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250211100530.5918-1-s921975628@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250211100530.5918-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 03:05, Yiwei Lin wrote:
> In the case that we give a invalid command to idle_monitor for
> monitoring, the execvp() will fail and thus go to the next line.
> As a result, we'll see two differnt monitoring output. For
> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
> is not executable.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index f746099b5dac..0fc0e229739d 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -6,6 +6,7 @@
>    */
>   
>   
> +#include <errno.h>
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> @@ -295,6 +296,7 @@ int fork_it(char **argv)
>   	if (!child_pid) {
>   		/* child */
>   		execvp(argv[0], argv);

Good find.

Add a check for execvp() fail and print a message
to say that it is an invalid command and then exit.

thanks,
-- Shuah

