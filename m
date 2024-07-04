Return-Path: <linux-kernel+bounces-240917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1F927486
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CFC282F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F01ABC21;
	Thu,  4 Jul 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hBdr9Evg"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987E1A4F1B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091032; cv=none; b=DXBk+HZzkBLOo7abwQ2Snnup09ESTXIIg/5r0azlmG1mSkGl+zKFUj+1fTB6ugBz3ShhgonqpBTBuqrtLMJPwfzIi/fgJPh9qIOvNCstsJlZBkPWFqslsNBCkpJ7W8guQpS0WXJ4dF2wiUl2whZ2kcmFWynz/zA+HkWVxgXghkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091032; c=relaxed/simple;
	bh=EBxe/t3uSzRzdZjEJR/AJMf0yXA55gbPoKvJndaVbdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BljrAbWliv2+ECcOeRyQ9OBHU44qax9VGaK+ONlOTkp50SyHL9TWS5BifBGT/0scX5vsg+lpMc+CFnDnDywHWFMb1CWlWP0aKjU/C80JHFfN1Yj+hvtvsA6HAL9Pzm4kmXj/9oM/51RAKkGeFskbvFYL3oHIwfJl/dPvwa50QlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hBdr9Evg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso682947a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720091029; x=1720695829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnwm1BTULushUpNZszhCJGbtzCJ6CyxKbj/F8YwWxEo=;
        b=hBdr9EvgcnYF0uuivaRdLJ+7kWN2JFie8D0zKPfm2J9SzWtaPkTyxT6IG9ezGKotN1
         m+rTr4gOXh39xORahlGH0wBiHZ4n5PZR1KIQOHmxAm6SdlFarPO5QhemMF+0u9WZ2zFj
         tf9K79zUmr7y/XCyo13TRh9CtXWDJg4Zhyb1vO1lS7LSbCIS2+d5FIXKT9YbLoE80R9H
         8XX2YQ0csdQPgcYdOL2j9Edeqe8dekrCgKo9jsJdsQjJ19cLFDt7juDrOoIJ9V6ldym4
         xL5MLEpNm0OAbiT3M8ovw/vs0KtFdJM16SE+6a9btqCXVa+c8Oj2EqAL2bOhG/EytIyQ
         GZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091029; x=1720695829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnwm1BTULushUpNZszhCJGbtzCJ6CyxKbj/F8YwWxEo=;
        b=bD4L/ErtbJR270b+bNwp7bMOdRM9fKET350KhLs0PccJDmyV5qYUjQZ3r1rkIPonrA
         Gx/+f70jexm6W3vsqD8e/Ukavzuz0mP3zc3w5w7h8+95YnwFV0Gxnp3oGgF7IvV/CQoR
         hx4CvzgoBnYzoPHBxrbDJqmIz4BoTC+rw06PYOQ5Sx1Cicft3EQatKA43wJiMivJ1cLe
         nczzo5VMOJgcSGXjlgzIZy+lS6bTv9ERonbKkz9Mk7teoDjq5Fga6WXy0wXq7qyJYsBv
         tKcsr8tEYkeHT6PPqVmHD4N+Fpl0N9qylshKi6iCJPsoiVJj2UXWJxAeUD28B3eFdFyz
         1TQw==
X-Forwarded-Encrypted: i=1; AJvYcCUheMAiywpRqiZNWl/h/DojrkrDfETniDw9AX3NC/3ZqDJQebJ8tg1mz9Gcbpw7m7vQ8PAUIsf2Fv2LijqTVzd9NuiHlC5/GGr2lSK5
X-Gm-Message-State: AOJu0YzPA2HFEpM4pEm2qujPq30sHULquUVgO1Kp9X8SId6OGnnFx3WE
	m0lqjs5hHwooZvAaUc/2O7ZVxOfa6PIQ7QnvxCCAMKrya1al8xer5TgtHjA4iCXYHaHvHhewt9C
	9
X-Google-Smtp-Source: AGHT+IH58951WKhr3vunDvweX2ewiiOBq9EXAK+uHr3Y/U9wenl7u/pKdz/iKmhQk5feyllS+8YH2g==
X-Received: by 2002:a05:6402:50c6:b0:58d:ebf9:4e1b with SMTP id 4fb4d7f45d1cf-58e59265b81mr877095a12.2.1720091028667;
        Thu, 04 Jul 2024 04:03:48 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d51asm8323679a12.81.2024.07.04.04.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 04:03:48 -0700 (PDT)
Message-ID: <07b88f71-5b77-4c16-bd55-3f5e3812c93e@suse.com>
Date: Thu, 4 Jul 2024 13:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240703075314.23511-1-petr.pavlu@suse.com>
 <20240703174410.099e8784@rorschach.local.home>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240703174410.099e8784@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/24 23:44, Steven Rostedt wrote:
> On Wed,  3 Jul 2024 09:53:14 +0200
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> The function rb_check_pages() validates the integrity of a specified
>> per-CPU tracing ring buffer. It does so by traversing the underlying
>> linked list and checking its next and prev links.
>>
>> To guarantee that the list isn't modified during the check, a caller
>> typically needs to take cpu_buffer->reader_lock. This prevents the check
>> from running concurrently, for example, with a potential reader which
>> can make the list temporarily inconsistent when swapping its old reader
>> page into the buffer.
>>
>> A problem with this approach is that the time when interrupts are
>> disabled is non-deterministic, dependent on the ring buffer size. This
>> particularly affects PREEMPT_RT because the reader_lock is a raw
>> spinlock which doesn't become sleepable on PREEMPT_RT kernels.
>>
>> Modify the check so it still attempts to traverse the entire list, but
>> gives up the reader_lock between checking individual pages. Introduce
>> for this purpose a new variable ring_buffer_per_cpu.pages_era which is
> 
> I'm dumb. What's an "era"?

I meant it as a calendar era or epoch. The idea was to hint this is
a number that identifies some structural state of the pages list. Maybe
pages_gen ("generation") or another name would be better?

-- Petr

