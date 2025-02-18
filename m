Return-Path: <linux-kernel+bounces-520648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23BA3ACBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F747A59E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA731DE3AA;
	Tue, 18 Feb 2025 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRo5pY/S"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC21DB55D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922364; cv=none; b=jnIEBuNulP2J+0WCPArclghH5tAU/4DTgP8+6lKV717tkgere6VV4rK5or/J4I2LmRRyu9xGf2Iwu9ysAkZniZM0GRBj6IMraL38ouHOHB18SqJbvwSpXKbdtZMpBeTJSO2/mYsnPL1jpvQ3sNPIe6Qjy3ExZ50qcnV0HpcMLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922364; c=relaxed/simple;
	bh=mhhc0wf/ONFLZ2bacaNQx9TROcDDQUvNWScsp27PYbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZLkQuEzsATBZA5JWtVEwKFZeHY/W/LaYXQpgQsODgyyUvXjC32rB+Dqb+nVXSGGiuCHwHuZoShrzZ7705np5j2B6vEhfBHZrKhiOoo2KcYYC1Qz0HIXkajjqvbLHPcKd3QDH0AiXOGY7k2C0ZNZFRj/2KQP+o7mjSu2OkOTvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRo5pY/S; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d18bf1c8faso15724865ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739922360; x=1740527160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1PBftf4f0RNI82zXcvqxBwywoZCddwy1ySCBhloYSU=;
        b=cRo5pY/S2ICDo7Ir5UGMrUqR9M0LxuDcZVWVmqLu6Cdpt3iM1dOr6KfBe0808Ovjev
         Hko4rwohBP1gerYN0wQNIxcTU8Dc/wkTGk8pkAbE23FyZ5USsuAmF50G0Is0mMW2Y57w
         2PO1uvpMHm2px1jvP30SzeLwumYSe4+s1qh5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739922360; x=1740527160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1PBftf4f0RNI82zXcvqxBwywoZCddwy1ySCBhloYSU=;
        b=v8LdBUppyIdRCVPbfcUcSuPVewU+gFw4UUWy1rA9mKba3DHq9WHboybOx2SHIB2F+a
         JOI6edQgImxBO2JZH40bxmhaKxdfdFhR+CwMZf8kSphCVNpkLJ7hIlFKY69tLFHR+8Hi
         mCKAvasFQRSL2shj9pK9P855q1oUVwB3rnuILCHuigpxS4PVnLPHnZmYBksOqRv/ocP1
         zn0I24geRYWak70H41meHE25wq/XmdnjrMmmtNLv1aP/kv/H2hneEU6wQelRwckBTOw1
         0KxdW4DW7RZEwKaB1mLDEbXgUFIA87Z5UiVHYX7huOlzgvzBYzpvbakSxU08GFzuAc99
         /sUw==
X-Forwarded-Encrypted: i=1; AJvYcCWtpYw6ANMODc0Youkc6mGV3UDUQUHr8bAB69YpJbNEErHJKk/+GbzyF7UhExAxP3uNi0c38NCLCWGS1x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxaf5A1fm6OVJE7lrZdgWYyzMSVkh4ss7KChNUBnmQnA6s+IWZ
	mdl8rsN1A/lHBnGWtMxK2zqU9pValkU43xtSZVe8zS4Nsdh5T7A70wfooxVtfx+B/0Aj9ifQead
	1
X-Gm-Gg: ASbGncsalPeeEjVCwt6Sb7ywK/qN9I0m2qsFSzpQHrV/V6trWw1b+JUUWMkqVwW0+QM
	GnISlJnSdiqMHzWLI/f/wjARYVdbwlUCje/jcGQrQ3kkWoAzVsYQ3hHjiKAG6DVOl7L6eNrnTXZ
	4AD8kp63X/W1VWfD782CVFBKmrqgscJjmFtcPzi2KLZBsOuLguwsqM+1B+kHgaIwwhyjfY+2ncf
	OeyjTbzrF7trDYsFcVGOcqVBQAXqVv7G/I5IG8lb0OWAxLY4kd5jCSX40FxW0+TEwXaRbZb82qs
	txC9fE9iQMdXTqqgxrLc5iAw3Q==
X-Google-Smtp-Source: AGHT+IHR4e0nSCl3q8XbogddW2PD8peUhLro/fUpaufhjp9VugG2dLz/OZnLfqrqVUKTOw6xptXN2g==
X-Received: by 2002:a05:6e02:194c:b0:3d2:1206:cab4 with SMTP id e9e14a558f8ab-3d2b535b5d9mr14592745ab.16.1739922360524;
        Tue, 18 Feb 2025 15:46:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea0f29de7sm995514173.27.2025.02.18.15.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 15:45:59 -0800 (PST)
Message-ID: <60671af0-204d-413e-9b65-00b526764ab9@linuxfoundation.org>
Date: Tue, 18 Feb 2025 16:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] rseq/selftests: Add test for mm_cid compaction
To: Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250210075703.79125-1-gmonaco@redhat.com>
 <20250210075703.79125-4-gmonaco@redhat.com>
 <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
 <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/10/25 08:25, Gabriele Monaco wrote:
> 
> 
> On Mon, 2025-02-10 at 15:53 +0100, Mathieu Desnoyers wrote:
>> On 2025-02-10 08:57, Gabriele Monaco wrote:
>>> A task in the kernel (task_mm_cid_work) runs somewhat periodically
>>> to
>>> compact the mm_cid for each process. Add a test to validate that it
>>> runs
>>> correctly and timely.
>>>
>>> The test spawns 1 thread pinned to each CPU, then each thread,
>>> including
>>> the main one, runs in short bursts for some time. During this
>>> period, the
>>> mm_cids should be spanning all numbers between 0 and nproc.
>>>
>>> At the end of this phase, a thread with high enough mm_cid (>=
>>> nproc/2)
>>> is selected to be the new leader, all other threads terminate.
>>>
>>> After some time, the only running thread should see 0 as mm_cid, if
>>> that
>>> doesn't happen, the compaction mechanism didn't work and the test
>>> fails.
>>>
>>> The test never fails if only 1 core is available, in which case, we
>>> cannot test anything as the only available mm_cid is 0.
>>>
>>> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> tiny nit below:
>>
>>> +		usleep(RUNNER_PERIOD);
>>> +	curr_mm_cid = rseq_current_mm_cid();
>>> +	/*
>>> +	 * We select one thread with high enough mm_cid to be the
>>> new leader
>>
>> Missing punctuation here (...new leader.  All other...)
> 
> I guess I'm allergic to those ;) Thanks for finding it!
> I wonder if checkpatch should be able to catch this kind of problem,
> but that's for another day.
> 
> Do I need to send a v6 for this or just reply here with the fixed
> patch?

Please send v6 with the suggested changes. Also change the commit
summary to

"selftests/rseq"

thanks,
-- Shuah

