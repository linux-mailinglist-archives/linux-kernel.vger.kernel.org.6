Return-Path: <linux-kernel+bounces-441103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30B9EC9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4387169ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E91C5F37;
	Wed, 11 Dec 2024 09:48:34 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B5236FA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910514; cv=none; b=oiwcsVVYn22oliE1ZxfrDWt8rhoES7K1gZHuSDaP7XIs1ojSXw7tF1CeIfzpD2qk0qSaz4wxQJTELGblvrC2HOntGtGETi3BqQJHPpNJP/0CQGCWjY9v4uFl8jf+6o9EG7I9VEWkBYpetDk4pi4Ast5Ln9zSu8kNYroH9BXqxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910514; c=relaxed/simple;
	bh=y8eqAqCfx1C4oh0tQfrPPK9N5yNffOoqAf2v51ABD50=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I2+T4xbsSXjhRm0o4oDM2bVSRb1Ff3NwEj7bQcbiIhxzBHQlL0A8GB0SecpWuWQDVYlIzvHh9iZ7RnLVbs0P1IaykzLIKmHATe+OM9SfrWhhHzXlOP8LEPCgtaSJeQbFjCxsTLG+evBIBFE/cqselaf8EvFORoU/t3AlGsmOVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so272356f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733910511; x=1734515311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVeFabnaxqlvR0znLrTruELrYW3r1evcSGWVaVDfx6A=;
        b=M3Vg+27c//tQR2J+H6tGJeh7wFJLE3O/6Tr+qZpGDbUVN92qdJStLsR4dIoPwzV0IW
         fAPhuGibG6qr0/tCYRCKsUYlv3Fd7AdiywUS6lbwACokS1bqFMYV3g4MxpEGeCelFLNq
         s6mU1bu6JAV8llSuDmLTCziuJqKfFcCWxsxjvM967vlFIYoNJH0CZRWWneZM21k6zxNX
         eQfvSj+fD41bct+fX7XoY6zuejqXRmAHi+yQK/k6z6WJU64lfp4KmLmg/VBl0g2Jd3el
         ZHbsShA+21msqs5QqFJNrDXHU2Ndhpre0jm+GWc7CHgGtF2w5Ftb02Ei7vHL0voYfmhe
         prAA==
X-Forwarded-Encrypted: i=1; AJvYcCVN/lBX5qDuSgflXAVPsoTMDtbiiXgY+7MOdB1PfjTdQCW2+SjUF1SZaX44Ng43k1FGHhDJ5yu+lYcOPfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQcYTU6KG01yD3woBXjQvlDTY4uMCdZu7gf557m3I2UydA2Ab
	BRl93mPj0+uLRdMy+ZbXLgrC8p6bQNkBmWQpoP6+PsxImgsfZuYo
X-Gm-Gg: ASbGncssnSaZbPsmMXjLml5eqE6vdveU9OTi2MtgYB+oWRVwB27i1XPGuhDGPjuWUv3
	KplJxWWLpAtezrZmVpg86Asdl/oY0J78AdjoBsXfg/Jl2PbxyTQRNa8CHKPo0U3zpiEgye4AwuM
	NiJxJ8rJRjckohdLy+f4HWX1aeSYTvSGppPDSc2PwnJOa7Zzc5FVOW0wGGlY2OJP2nC3HzWbnvM
	kvfPEk2A47r9yb5aiD5vEyguvnWFXbie1urrm/EWy7Y1WQCLfDGY2bE/p0Ni2+tkyAcmlKa7C2+
	HgbQ8c9mNQ==
X-Google-Smtp-Source: AGHT+IGfvnNiXXcf9udAr6Hr8SLMBeUAX5NxzNf2xLnfUk0XTxxaDYjuvmxxvF7Adk9gnXHqgl2S9A==
X-Received: by 2002:a05:6000:1f82:b0:385:e328:8908 with SMTP id ffacd0b85a97d-3864df1012fmr1242206f8f.29.1733910510457;
        Wed, 11 Dec 2024 01:48:30 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514bf9sm894705f8f.80.2024.12.11.01.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:48:29 -0800 (PST)
Message-ID: <01e7f4a1-9fbd-44fa-a590-3fa0a7a5ab46@ovn.org>
Date: Wed, 11 Dec 2024 10:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Peter Zijlstra <peterz@infradead.org>,
 Joel Fernandes <joel@joelfernandes.org>, LKML
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
 shraash@google.com, marcel.ziswiler@codethink.co.uk
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
 <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
 <CAO7JXPijXstA3Eh_LrRGiK26U1Mfn8C1jSXP+4kfTnQRxSax7g@mail.gmail.com>
 <CAO7JXPjGFmfwAVcSaRhtM2Mf=V9P6oQm6H=QfHcFhtkLU8magQ@mail.gmail.com>
 <10db7c11-5578-4386-88ae-542ffcaac818@ovn.org>
 <0d64be76-7afe-416b-96f7-6ceb713c7ce0@ovn.org>
 <CAO7JXPh40hhge6dSHj1=jERj63HSmXnNPd16_VXDbxapiTCzHA@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAO7JXPh40hhge6dSHj1=jERj63HSmXnNPd16_VXDbxapiTCzHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 03:30, Vineeth Remanan Pillai wrote:
>>>                 /*
>>> -                * Any fair task that runs outside of fair_server should
>>> -                * account against fair_server such that it can account for
>>> -                * this time and possibly avoid running this period.
>>> +                * If the fair_server is active, we need to account for the
>>> +                * fair_server time whether or not the task is running on
>>> +                * behalf of fair_server or not:
>>> +                *  - If the task is running on behalf of fair_server, we need
>>> +                *    to limit its time based on the assigned runtime.
>>> +                *  - Fair task that runs outside of fair_server should account
>>> +                *    against fair_server such that it can account for this time
>>> +                *    and possibly avoid running this period.
>>>                  */
>>> -               if (p->dl_server != &rq->fair_server)
>>> +               if (dl_server_active(&rq->fair_server))
>>>                         dl_server_update(&rq->fair_server, delta_exec);
>>>         }
>>
>> That indeed also fixes it for me.
>>
> Thanks for the confirmation Marcel
> 
>>>>
>>>> "static inline bool dl_server_active(struct sched_dl_entity *dl_se)"
>>>
>>> Sure.  I can try that.
>>
>> Running with this for about 8 hours and so far so good.
>> Will leave the test running for the night, just in case.
>>
> Thanks for the update Ilya
> 
> I also have been running the test for more than 24 hours now and did
> not encounter warnings or crashes.

Nice!  On my side, another 11 hours and no issues observed.

> 
> Juri, Peter, Shall I go ahead and send out a single patch folding the
> 2 fixes in this thread(dl_server_active and fix for the
> dl_server_update call)?
> 
> Thanks,
> Vineeth


