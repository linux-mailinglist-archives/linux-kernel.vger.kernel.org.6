Return-Path: <linux-kernel+bounces-315955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9F96C916
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305E528666A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD91487E3;
	Wed,  4 Sep 2024 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PBPSPyqe"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E738DD1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483880; cv=none; b=SWM3bSLsPqgct2JJu8TMZVctEbKEA6ptAkE+fMFyvxmWLwC7vGgz4/rhh3McQYQuE4X9K0HgzNoZCf8XsuGQ62lyxSk2iabESNptpnoNPFuBm9Uazcl3DUtciU63S4cT7MoHoPLDhj12RrOrA4aWjG8HHcf4IcRkPl0ZHP6RdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483880; c=relaxed/simple;
	bh=G9K/1hZZTmp1kQfb5kzUbqSoQ8f8wtM/L01bkN/uxLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuEyYdDCzK+XgUVBjN/5U50L5J6qAfjKUSS6UqulClXyD9dWLQBlqtRdSGmYXyCkDrpJZlT2K9pLbniDG4FYg1VAAjAQXYRYu3NUJnNiyfg+WehzPH83sBE+50AQXh1SPA8l5WJ4Q5cVFE4wIGuVJFAvZS4gzavzi0zNEPOfKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PBPSPyqe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717877183a2so38642b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725483878; x=1726088678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpl4MqD9sUPOQvrseTfoBLw/AKjGr/Fne5YCkeowl+c=;
        b=PBPSPyqeFONMC2BWw5ACAmvie7T13zx4BFMegj+LEh5QgDRS7P4oI4NulweVX6mCsf
         mesM2A5WvbWUemm44U6FFPmd25n1ODTfs1hNgwk9dJ7BQLVh7vX1rfMG3lMoEZl9WA0I
         YxMMSL3JYk9K4YCKpWnVSukO2fAKkiOgaltcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483878; x=1726088678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpl4MqD9sUPOQvrseTfoBLw/AKjGr/Fne5YCkeowl+c=;
        b=XOC2ID3RGxS7HFxqFCpUfiDtfBlYvxzIhdYTzAcEuk2pcgHXMg2FaegYIXTFroA9gA
         WfBhn01HyokJeoBu9PO7TYELERuDp8dEyY6HQR+yV0g7ejy93zg9Q1Gb7spj8Gr9oLhO
         Ptvz1bN6C3tzPznMV5jLc1TWMF3dxmqWHrYLRd0bkLDG5HxlAITqznMQ0d78sy8XiTcg
         VLCi+8bRgmnvKZnmKJWFF6OFQ+ETMJLSXzmmDE10M2fbsKVMkJO4pD/3YBxwwB2CdKPi
         f/RyZQk6+M6Xd7AlhXBiab4RsMHO7CuvssqogODsmExAbDO6pIfpKscdvonYz4X5c7qU
         iWLA==
X-Forwarded-Encrypted: i=1; AJvYcCW2CLpjlnvDyQGY8FGlYw4FTchOWZ3usS0ZSW1+t/NjZ+ynmauOUt7bg6xdKL/gDTxS6QzRvk2YD65bgYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqa0ET4T4b19cxmDCV46yEbVV4DAdVLCFyCiJ2ExbW2h+pMouF
	VYHO1qODw1NWuzBHkWpdTp4XqfGlwaI8D7uOMbqoVBb0tPA0EWeGi94tKHIXfBw=
X-Google-Smtp-Source: AGHT+IGzmBuf7e+NSKcOZk/oPyTcZgEHnxdOFY0cOZliz2ot1s1rB16maphwJjlEBYR/SrrWHlvzYQ==
X-Received: by 2002:a05:6a20:d70a:b0:1c6:a680:ef3d with SMTP id adf61e73a8af0-1cecdf2a6b8mr21265752637.28.1725483877412;
        Wed, 04 Sep 2024 14:04:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785891edsm2014741b3a.108.2024.09.04.14.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:04:37 -0700 (PDT)
Message-ID: <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
Date: Wed, 4 Sep 2024 15:04:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/24 06:56, Shuah Khan wrote:
> On 8/24/24 12:53, Thomas Weißschuh wrote:
>> Hi Shuah,
>>
>> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
>>
>>    Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-20240824-for-6.12-1
>>
>> for you to fetch changes up to 25fb329a23c78d59a055a7b1329d18f30a2be92d:
>>
>>    tools/nolibc: x86_64: use local label in memcpy/memmove (2024-08-16 17:23:13 +0200)
>>
>> ----------------------------------------------------------------
>> nolibc changes for 6.12
>>
>> Highlights
>> ----------
>>
>> * Clang support (including LTO)
>>
>> Other Changes
>> -------------
>>
>> * stdbool.h support
>> * argc/argv/envp arguments for constructors
>> * Small #include ordering fix
>>
> 
> Thank you Thomas.
> 
> Pulled and pushed to linux-kselftest nolibc branch for Linux 6.12-rc1
> 

I am running sanity tests and getting this message:

$HOME/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory

I tried setting TOOLCHAIN_BASE to the directory I installed gcc-13.2.0-nolibc

Something changed since the last time I did the pull request handling.
Any help is much appreciated.

thanks,
-- Shuah


