Return-Path: <linux-kernel+bounces-524194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30690A3E04E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C049C189EEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA01FFC78;
	Thu, 20 Feb 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JThSDjfx"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B31FE46F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068293; cv=none; b=k6VrkBvF5P5yGnZJLKsM+lZyIkIkjB0UTMme+cNhTxDIGs9rAXDwJcYtYgvVzgsMPmdLTVNFR/oHo95/7KaKBYyAJALm7fPebVZzQZVT9O7duVioTHvG9dsTKRvoZ69Xh/ZmRP21KUhT3LdiMwzvMKrUBbmEcEhm93HZsaCNJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068293; c=relaxed/simple;
	bh=/dWabNOB3H/l45GLrHuFpQul4Awb4+rHqOfNRlYWSVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqs6x3VSe4+RyAOtRqQLV+3wgyBEVr+w4+KWCUvfHgqf9wJGYlQv+l5NjdkbfCy/z/nfMimfHrITLUXBG9NbIiVpG5RqJM2SsQiGnnfNuyrVqEres8i84VGrZWM57KPubN5DnnP4MAKx/1pIbpqIX8yLUV58iCc1kH6mnASbZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JThSDjfx; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855a5aa9360so77081839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068290; x=1740673090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgyoPRXU6a6kG4N3+disEL2MEnPtdcZMZBxF77QaXes=;
        b=JThSDjfxYNINHmAnk9NMcxlPw/YGxJiLcxuatlHW2d8cem7g3uF7+VCOvam6wXu3jN
         V1nWqwwZZf8QksaJMEYHT4Jx7sX2A5wf+CfAkNyqi70iJ/HrF/2s8q3h1cqgrVZ8y9VU
         91w+O3ObA+uUPuGF7rlYnZDga3LacDjT+RWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068290; x=1740673090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgyoPRXU6a6kG4N3+disEL2MEnPtdcZMZBxF77QaXes=;
        b=oAsYaPNEPOMZ3ps28TVD2gftZgS+X7a1dPJvYysXB1ikJt8Tqi5aOPKMhwXhmTHwcP
         zWZVaQBnBZBxWQ2nMf8b7kQ0IhMpJsb+XiIFRjZbmFkt14XDEoO13xVTQhCdFRMqkjXQ
         uvMXu2h0UvNogmAYT7bonMxcsOGi6ZNEo1Rdu/GFdArT2FD6tVxGJqs6ZTp+q/pW92gR
         Ma0kxXXUFjtucfx4kBfLJsULVrkqiUcU2BZffwFuAPx0n3JJWqg+LXM9JuTi4gL5UeSG
         ULT2sSlMpOMKwn3T6Zb7FB3oaQasaY0CcJa34MsEAdVY1kF2RvZUPW6rNBfAzjiFUhcz
         aq8Q==
X-Gm-Message-State: AOJu0YwfvcOEQfKfU5M3m32KfJvEt2JEOjeSscwktQR6fkK6buHBPHL9
	bjwsVwADGXztJjSkA8eA8HGmoR6RcMUmJtI8wrW2RK9OzvtSaAN/ankVOAYzUBqNV2y9MNqncYP
	V
X-Gm-Gg: ASbGncvEWSB5UBrl60DHbTlsftJ8Jm9iTL3Wid6IX6WJ3ES1oW81JD9uOrcUiaoHoai
	K+EMxGAI+j3csJPJP7KXEu6NP4JY09NL8GT6Vnq75zeEclluhX/ag8mdwW4O5i0wMJHxVCByMta
	ya86KUolJsRz2LX9a3oAXbC4GYOk2EehgCDwNaLaHVOWY8hRfv31iO/E3qk6VVzZFDBZv5kTarr
	ZvcB/TXIbC0PJ+zVaDRXFW56sJgtRdLNCvNVON6EZ02LeUKR81cRhhXn2R0UwRgL+nhGJInL9bp
	ru1TcACygZXk/wyb+TGMYYLuDA==
X-Google-Smtp-Source: AGHT+IEJ7Oc5HsTMETSfAVR01i2ff6EJ8L0D+zb08Ob/9RlyCuyRRRxFupWsQAosXlRZJP1IxnAqqQ==
X-Received: by 2002:a05:6602:6c03:b0:855:bd9c:717a with SMTP id ca18e2360f4ac-855bd9c724cmr892782639f.4.1740068290492;
        Thu, 20 Feb 2025 08:18:10 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855c0791a3esm56942139f.29.2025.02.20.08.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:18:09 -0800 (PST)
Message-ID: <3ae6c7de-fb0a-4c65-afca-c0c91289650b@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:18:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
 <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
 <20250123172530.474e873f@gandalf.local.home>
 <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 16:54, Shuah Khan wrote:
> On 1/23/25 15:25, Steven Rostedt wrote:
>> On Thu, 23 Jan 2025 14:56:55 -0700
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>>>
>>>> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
>>>
>>> Do I need to do anything or is this taken care of?
>>
>> I think you can take that series. If you want I can resend with you and the
>> mailing list Cc'd.
>>
> 
> Yes please resend.
> 

Steve, did you resend the series?

thanks,
-- Shuah

