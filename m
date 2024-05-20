Return-Path: <linux-kernel+bounces-183834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157048C9EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E5A286D30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCB13699E;
	Mon, 20 May 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9NkebL4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8A13665D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215041; cv=none; b=MU6vowLmvI6kLFfXFExCwLzNLx6b4PolUeaHkZyrdrr7UEuyV30EkAJW83rGnZ8k7Fe2dlaxdlFVpYWx6iEvScBT5xEbHdO6i47L6mrXVBmP0d18m9RNgPkjhcGlZoiGdGxHz/b/RpQajCDG3TKSmhOJZldN8+3P+aYYu7k4/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215041; c=relaxed/simple;
	bh=Kxud4rInQ/uIzpvwj6zKqD7cVG/YMxBM6hnwJWDO3Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgvxC6RS3WYG9hph+H3uCFTPFg75KI4PyZP9kmNY1vpvXzJC5WK2Pch212DOfVEzpxTXJaA82HP1BHXMHz2CHYnvD87SJT1ijK3psSoXHfEQaaVqve792WDB77zMk4VbvXq3GGoX8H77NSQYXpQn2VSkePrs4n4r6a767MVlY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9NkebL4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e1b520812fso26948939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716215039; x=1716819839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBQNQ9FZZZqvjteJBWF+UbSAu8Fn4cYlBjQ/AkQ61gQ=;
        b=g9NkebL42r+8TquAQvVximMh2Xju3TT4znDAtnS3KoUJY554PkwakpV0I9st2rshqm
         xEWeQMD8WRc6AGMFwgUzuImuF2tnCu+GUB5LcKgtib1DQyjYFBOW5/fbaScTdrkY3tyz
         5hQ0aNrlF6KPwIvmd6JgNZ97XZ9MYxTgbjitw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215039; x=1716819839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBQNQ9FZZZqvjteJBWF+UbSAu8Fn4cYlBjQ/AkQ61gQ=;
        b=XDj2JLCw9BLJQcXBPGHNSDwPL3bS9l+TZNwo/2fyAhf1N1rsBGffVYVsqTItIjp+wN
         AwOPjwylX3i6eFDMlM6kL/DjyjQ6CbNH5gME+mb7IicYzb3SQBXC7uFdf8EiF8FnWB7t
         CexS9pKKszxYqe1vxg1G2R6LEbHboq4X2LAaAGk8Svgf5GBZ7agzemUFdUZpm0uZ9jfS
         3gTKd3ywpI47iEsiYvRQJk4evAPe/u+XvFF5LoisVnRFUcXzWOr0gyVxkvlBimxPXho1
         qpdHvdhCto5IL8JfViW/9nMt3KTWJRgM1ycdBFl8fyH983mBShzcV1en5v6IrcQagqFz
         vixg==
X-Forwarded-Encrypted: i=1; AJvYcCVYEk5fuzOZB6SCALku5o7bIqiG0ADvdwFcWCbPSX57JDMKdfL4UbXbHUjm/XEQ2vMQvX+0+UORNAK38gyUhCLe8Z2dTiqhCwr9v9JL
X-Gm-Message-State: AOJu0YyoGcyQYiKD1fP1jrmnuhzQuVe5Qj4NAyonjYvrZuBPjY1LpNCY
	1FmScTI9wJE4cQlcc+K9br2M98L1pyx3Y2jtqeUzFT5jlXe0eSMZ0hB8JoKklNE=
X-Google-Smtp-Source: AGHT+IHOExpjLNN+4G5/kjDmKREPcV4+VDUq67A82eppucYtUYxOE/4nd3SHNqSCoiAcFlRE57sYAw==
X-Received: by 2002:a5e:c748:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e1d865e82emr2632162039f.2.1716215038950;
        Mon, 20 May 2024 07:23:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893700e444sm6409930173.28.2024.05.20.07.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 07:23:58 -0700 (PDT)
Message-ID: <6b2a93f0-8521-4915-b63d-d28d1d243481@linuxfoundation.org>
Date: Mon, 20 May 2024 08:23:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/alsa: Ensure _GNU_SOURCE is defined
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
 <871q6025ut.wl-tiwai@suse.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <871q6025ut.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 02:35, Takashi Iwai wrote:
> On Thu, 16 May 2024 17:27:33 +0200,
> Mark Brown wrote:
>>
>> The pcmtest driver tests use the kselftest harness which requires that
>> _GNU_SOURCE is defined but nothing causes it to be defined.  Since the
>> KHDR_INCLUDES Makefile variable has had the required define added let's
>> use that, this should provide some futureproofing.
>>
>> Fixes: daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> The commit isn't yet in the Linus upstream tree but only in
> linux-next.  I guess it's better to put the fix in the tree (Shuah's?)
> that introduced this change.  So feel free to take my ack:
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> 
> 

Thank you. I will take this through my tree.

thanks,
-- Shuah


