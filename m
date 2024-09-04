Return-Path: <linux-kernel+bounces-315332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285F96C12C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A2E1C22D60
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1511DB931;
	Wed,  4 Sep 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GZNggFPC"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26D1DB53C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461374; cv=none; b=NVQcEke4AIlDcrhG7sOh8xGp2BYEKfjPe3tM/bPDVaxcWjFIAXal87+No770OGQgsJ0wPksVJ3bYXIBkC8Em18sRuhyYo/Pc3evZAglrNhquLqYY/t76z30NpXofXSAM2hhKiCJkYLdZMX3v8HT/Z5hdheacBj1fkk0W/nMzKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461374; c=relaxed/simple;
	bh=cBtG1mGQoB1mZs6kdcgoRPisL9P5R/ZmOfxaKD8RhiI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EczoxLt1lkl344kgM5XmTIrO3OpBMcY2ptvg4WR2VPkmt+JiERapc7bC9WqvbAp3OL5IZTSQB8gQChfouNdoYTz3g2leJTb+BVagNVJPkEaIG8l5r6jBTCjb+V2zJAoUsBnosCkUIZGcPOvlSSy6f4bQPKbu67lnTybOEql2iNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GZNggFPC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a35ea3edaso238638639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725461371; x=1726066171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gg/6+bOeg22R6GFget1feB6uWX6QELmDRdwKsUWQSdA=;
        b=GZNggFPCEi//CWkjBoXW/XI6gYIvD4VzKtpA1DTS45gjk2BGs7IbmndNczYXAuojX+
         iJh5nLeEf6twpDicyGMck+eKzAL74hn16fUghvVKeLq0Z+uXO9SG4ALF26wTo/XVdAoK
         Fz8SX4+gyByIoDiS127s//6wuLaszhHpGsDnQ0GNTY2RB8h8Hxwwy0Tl89JQDcqbL61H
         g27ObFsCxs2emj/mCf5tA8liQCQ+17jqvDCUAWKsJDAsDx66LSvXO1g8alUxIND1+U4j
         nFYr2SosV090vcMoCuwhuEokjujuzUA7Rm/J3HNsqIDEL95BR1m34lwh8kbuyld2PKGg
         r+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461371; x=1726066171;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg/6+bOeg22R6GFget1feB6uWX6QELmDRdwKsUWQSdA=;
        b=eZRiTiK6YJRtvw/rSgbaoS7xMAz4tLd7ruWEwAeiT+qnmPHccgfyyHUc/eBqksSPwU
         2M3cZr4k/HF2u/ncCUawBTgE3epNeusDX2GBhT9PhWj26WHza5mSurTd6u2xm1djYSPc
         9XTaXMWIikzYxPZpYAoMkzrHJhxa1a4FvzYyVb+KwxSlc/IyFKb7yVpOnm7F+WxLiftY
         1wjGxcykTda+XOfmeNssEzwoH2lNgZ/kSA5U/LgFp7znEnkr5LK5KcstXaUn1PaOzgjE
         J+0u5i5qed0pReb3OXKZeeZHv98xYZ9Z9pGghrdyqG2b+Ex/x0kgTbLJsKOiu3hlxrpG
         zwgQ==
X-Gm-Message-State: AOJu0YyXpTV1MdQAcV0FlapdM/SvVIGBpPNunhK5w/ecv4bocaxv0i5N
	L7xKk2Hr/pqisUXfBlotnBS/sjMXcpMqmGx4hoLKK8Du7kmh/+VUgS2kk+nazPI=
X-Google-Smtp-Source: AGHT+IH8k7vfp320rD77eC2+5M59WBgRyP+qCZblSu8VWx7cqNHs3tkLg51MBXFEtHpGgqQnrjEggQ==
X-Received: by 2002:a05:6602:26c7:b0:82a:1e96:bce5 with SMTP id ca18e2360f4ac-82a1e96bd72mr2961475039f.10.1725461371276;
        Wed, 04 Sep 2024 07:49:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de7b11sm3084201173.70.2024.09.04.07.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:49:30 -0700 (PDT)
Message-ID: <4f804d53-6f6c-402c-b8db-db6ab8161f11@kernel.dk>
Date: Wed, 4 Sep 2024 08:49:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>
Content-Language: en-US
In-Reply-To: <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 8:41 AM, Jens Axboe wrote:
> On 9/4/24 8:28 AM, Peter Zijlstra wrote:
>> On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
>>> Hi,
>>>
>>> This is v6 of the patchset where the current in_iowait state is split
>>> into two parts:
>>>
>>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>>    in terms of sleep and wakeup latencies.
>>> 2) The above, and also accounted as such in the iowait stats.
>>>
>>> The current ->in_iowait covers both, this series splits it into two types
>>> of state so that each can be controlled seperately.
>>
>> Yeah, but *WHY* !?!? I have some vague memories from last time around,
>> but patches should really keep this information.
> 
> To decouple the frequency boost on short waits from the accounting side,
> as lots of tooling equates iowait time with busy time and reports it as
> such. Yeah that's garbage and a reporting issue, but decades of
> education hasn't really improved on that. We should've dumped iowait
> once we moved away from 1-2 processor system or had preemptible kernels,
> but alas we did not and here we are in 2024.

Forgot to mention, it's not *just* an educational thing - lots services
of services do mixed network and disk IO, obviously, and they do have
some interest in retaining iowait metrics on the disk side.

-- 
Jens Axboe


