Return-Path: <linux-kernel+bounces-355929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F073995946
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE641C215E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C8213EFB;
	Tue,  8 Oct 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0AQh2VL"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBC17C7BE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422949; cv=none; b=GvsUhXpQ3y+nbbprSWewFldSSuhXwZehKzZxSoSjHhmuXnhRJd8OF2yyOTgsEVOkYpKDPOFRpvI+EzRdahBOlcuO7PtGp9ssn7V6F6zumWSCDtTVIIgP5MmKQYoyI1OdUxjWkViGLUpLjFgw/TQvUCCXW8NHLAeZKu0ubHCiVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422949; c=relaxed/simple;
	bh=+0JRHpcRkNGdImyqm6PACfdElpw2NkAms0S6ol8mB00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaOAzSTX7t8yqV1xG1FRe4kWM22yFtxCLG1cO7tKRAEHCN1a3eJ38k0E1ff090lSUxhXrvLFOmrkvT70UYzEGQqbQoHrMVi+9otdnnXlWcabzV22UwPLrHASsr3lFmbN2xluxeANGAKYphpyPkdp2Sbv5A2bTbqKbJC/xi5RfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0AQh2VL; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a33a6c3102so886315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728422946; x=1729027746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VX28x+DgIWJLaHF6qMvsQ3gLIdz53a0eTaZr8GrruRQ=;
        b=h0AQh2VLhLbDPbjBJpB52Z0fxdBtJRhn5dA6+H31eAwgck4nJSgZbo9jdu6yGeg6H9
         Ys8ZimCAvO4fhciBgyYtQZ9SLc4yC3i4fENIrKIu9fhGif4nUavr1772MMdlMRBuapOo
         gbBCwiiMJTwGVqEJLXHt6folbRl/GP/qYcWp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728422946; x=1729027746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VX28x+DgIWJLaHF6qMvsQ3gLIdz53a0eTaZr8GrruRQ=;
        b=uxRusJ5GRewksm4303TyKHsu5G+BGJxWklMYMJYc0LoHE6kbq6RqsOWAdvwLox/p3P
         /lNjoVI5qoVoCY9rNvtH+8+2os43fw1QrvW9KVwQY9Mh+wCSB2gWdTC+KDbLTRQf3F94
         WGHkBkiURFU0lksPe4Of5IaAYDX0lrmoFiKffDoffB+K8nLihqfL91Kk5r5A4PZ4iz76
         BjgqsCW+aiKECJ2/FEkUC/PLxdmteqbZ3+jFB9pIGU2Yn6ZoZpCKhjQriZYKRxUvFeLH
         VpKxac9zfbU472mUIIcUAq8q4luVqpckTzA0rhb+kNzKeg0B5Nw3qFoeTLZLRJLsZB09
         Obkw==
X-Gm-Message-State: AOJu0YyRjvuu3g8xSIhnXr2j3+FRaC6vvRTMNCvKhRGpxPeqE7iFGeCf
	4DYy/tVcrSwgNHasJdeoGOZQ7lLPGHEzSxrW3+6hflPULmxXrHcvgw66g74drdY=
X-Google-Smtp-Source: AGHT+IFyqjxd88/ufD4TKMFujnBg608E+xsQFuQtKm+QSLI+abRzN7hd7J1xg3ghgDMlBsa8Du104g==
X-Received: by 2002:a05:6e02:1541:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-3a38aef1aabmr42801385ab.1.1728422946692;
        Tue, 08 Oct 2024 14:29:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ec72df9sm1812143173.165.2024.10.08.14.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:29:05 -0700 (PDT)
Message-ID: <cd1c25bc-8395-4dac-9f03-930a7e221a8b@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:29:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/rseq: Fix mm_cid test failure
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004004439.1673801-1-mathieu.desnoyers@efficios.com>
 <20241004004439.1673801-3-mathieu.desnoyers@efficios.com>
 <01153485-ea70-47f7-ab6b-2c17496ab8ff@linuxfoundation.org>
 <9c3a8650-c855-41d2-b500-6a72e45c057c@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9c3a8650-c855-41d2-b500-6a72e45c057c@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 08:56, Mathieu Desnoyers wrote:
> On 2024-10-04 21:18, Shuah Khan wrote:
>> On 10/3/24 18:44, Mathieu Desnoyers wrote:
>>> Adapt the rseq.c/rseq.h code to follow GNU C library changes introduced by:
>>>
>>> commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature detection (bug 31965)")
>>>
>>> Without this fix, rseq selftests for mm_cid fail:
>>>
>>> ./run_param_test.sh
>>> Default parameters
>>> Running test spinlock
>>> Running compare-twice test spinlock
>>> Running mm_cid test spinlock
>>> Error: cpu id getter unavailable
>>>
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> CC: Boqun Feng <boqun.feng@gmail.com>
>>> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>> CC: Carlos O'Donell <carlos@redhat.com>
>>> CC: Florian Weimer <fweimer@redhat.com>
>>> ---
>>>   tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
>>>   tools/testing/selftests/rseq/rseq.h |  10 +--
>>>   2 files changed, 76 insertions(+), 43 deletions(-)
>>>
>>
>> Looks good to me.
>>
>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> Peter, Ingo - let me know if you plan to take this through
>> one of your trees. Otherwise I will pick it up.
> 
> Hi Shuah,
> 
> I just discussed with Peter on IRC, and if you can pick up
> this rseq selftest fix through your tree it would be very much
> appreciated,
> 

Thank you for checking. Looks like it doesn't apply to my tree.

2e456ccf0c34 isn't in 6.12 yet?

Also a couple things you could fix. Please cc linux-kselftest
when you send the next revision with these fixed.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#114: FILE: tools/testing/selftests/rseq/rseq.c:110:
+unsigned get_rseq_min_alloc_size(void)

WARNING: Prefer 'fallthrough;' over fallthrough comment
#221: FILE: tools/testing/selftests/rseq/rseq.c:218:
+		case ORIG_RSEQ_FEATURE_SIZE:	/* Fallthrough. */

thanks,
-- Shuah


