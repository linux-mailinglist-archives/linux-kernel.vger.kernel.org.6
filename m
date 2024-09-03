Return-Path: <linux-kernel+bounces-313838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7833F96AA87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9251F26954
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E31C9DC4;
	Tue,  3 Sep 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRdu61FZ"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5002126C12
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399902; cv=none; b=CzZKjajXyZuy/sBvCA9XSfLPwHuFvDbhoYnOS//q9yqoTln9pp4v9526KaGdfsCiLpMzifoRH0YgDfbw1WMiJL4DXFtrkOgLbb7YYeJEwb0G1e88UQr9ssb9jI/QihsMldAbLVUkK+O7mxZVUPyZt+Kb0qt2evjGRxkmyTiTuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399902; c=relaxed/simple;
	bh=PLKIv8RNCP5azf91HaOUUUXqfw5WN7TU/PuiMiJ40zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaRXZuC3jYTNb6ujvYMwFw+G/5sTN1LwAWzy+i1X5TGDsaeDoJ2DNPa3Pf0yX/NR8npIVprQNr4d5Co+uaFknyR7Gn09va+4mEJraaUxGn1iXy7r+xUMrq8/KQlowsdH5PYU04Md+qbnvNAtAGwUmOzOfD5gpXic4XqgOUmy+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CRdu61FZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f4ff22a49so14237745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725399900; x=1726004700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TtFvusUukhrfcBNs4BwVyAYh5WdPZpiUxYKdFfEHXU=;
        b=CRdu61FZlfZg+WNX5V86ce0g4PfkEqfjw2vblx+LjGTAhUeRf5gqSJz/INPKT2y/Ve
         ZL9xzXpHpLdYHp25++EWKj1s07O64UguKqJTz1511MdkPvw6bFuszpi3gq9PPOBMQxTF
         cbi4tXv0SlF/Ck2Rj+2L7HE5olVkI3Xj1yl1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399900; x=1726004700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TtFvusUukhrfcBNs4BwVyAYh5WdPZpiUxYKdFfEHXU=;
        b=YwqwIABNa1kwWl9y9F/owgdOWChovndOtb0jZPRaiyAbpo0H8sGnQmspxBzRYS32Ui
         COio3nzKOaNrRSAwn/AZRxxxAiQhqSUOWxoJleRTQPpKrbzrECMsxdllljLv3HnAoQaE
         T0lZY0lV92yHjKeZMSh4qQ+fqmRz6l72kHfGUJpbuB1I6XZa+J4tuSLBLAcWNUX53hhZ
         UWO0SksuLogwKQkE0bit8w4U5316cFCnqtGVnNz7Dc7LA0n56MRQ4raGmL0IkK/ZRzeJ
         AYTotWeQwQr0xfOqUXvuw/irjabnuYSqonF7TS1J5bE9Ng9QEi2nMjKciLF+6BAJ7Am2
         beBg==
X-Forwarded-Encrypted: i=1; AJvYcCWaiSj8iJx8OmwTgG6Wmjzzl7FXzLWUnkSzPjbWrWl25lePHPLuUCYbu3JJHkKqXJWvkcLVZboPZlKVjSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBpx3yxJ7GUt2vHeCUdPrcdCE1NaUrkAgwtyqnwQO0xVsoMGm
	/ONzyQQQaHkIVA1fsOQrpFGjna9Z5FBCFLNY8CdITNxDnTYW+iEjpUmAzY2VHsw=
X-Google-Smtp-Source: AGHT+IG/3kcP2Aomp3DaLFXa6UxP8KdZNnsbzcKEfk6F7L/aaWT/b/F2J1xVnRBRMXxUtMYtofx6rw==
X-Received: by 2002:a92:c56f:0:b0:396:c825:4db6 with SMTP id e9e14a558f8ab-39f378693cdmr234142305ab.26.1725399899562;
        Tue, 03 Sep 2024 14:44:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2eab562sm2784057173.134.2024.09.03.14.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 14:44:59 -0700 (PDT)
Message-ID: <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
Date: Tue, 3 Sep 2024 15:44:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 10:29, Dev Jain wrote:
> 
> On 8/27/24 17:16, Dev Jain wrote:
>>
>> On 8/27/24 17:14, Shuah Khan wrote:
>>> On 8/22/24 06:14, Dev Jain wrote:
>>>> Rename sigaltstack to generic signal directory, to allow adding more
>>>> signal tests in the future.
>>>
>>> Sorry - I think I mentioned I don't like this test renamed. Why are you sending
>>> this rename still included in the patch series?
>>
>> I am not renaming the test, just the directory. The directory name
>> is changed to signal, and I have retained the name of the test -
>> sas.c.
> 
> Gentle ping: I guess there was a misunderstanding; in v5, I was
> also changing the name of the test, to which you objected, and
> I agreed. But, we need to change the name of the directory since
> the new test has no relation to the current directory name,
> "sigaltstack". The patch description explains that the directory
> should be generically named.
> 

Right. You are no longer changing the test name. You are still
changing the directory name. The problem I mentioned stays the
same. Any fixes to the existing tests in this directory can no
longer auto applied to stables releases.

Other than the desire to rename the directory to generic, what
other value does this change bring?

thanks,
-- Shuah


