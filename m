Return-Path: <linux-kernel+bounces-355467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4E9952A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FB81F25E02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B641E009B;
	Tue,  8 Oct 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YCxbzfZ5"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E51E0086
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399504; cv=none; b=o64/23V0maZxedMTHFVJousMUEFIQ866HaN85pQZCcF9bogat7YJt3wol5TNE9iobe2iZkh8lundNanln0g3VKTErBkNvSDHKhrt3nQVa3jxFGIE3DycMvFbz21kdgXOc4GRFagAPOrG/6D4D1Y6Ly9TEaj/FFmsmNNRZcUmONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399504; c=relaxed/simple;
	bh=f+8/n12xZFqGWTB1bG0jDgSSCsZrQ3sN8dEjfXcOMEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeUHe4WFW+iXabw+CQxLV88cCT9C2Eu/EmvDywlu/ClZt8C65PkZh3fofILnTIY979DJG7izIehoXIXkhO2ZMJ1H8xWsQFiq6ywqTdWFYS5/rk5BWgV/SbcofvDU3AkEVvMscD2YLZeOwnaNuWNsmNJNaEdpR0Spf0eR3KUI8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YCxbzfZ5; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728399500;
	bh=f+8/n12xZFqGWTB1bG0jDgSSCsZrQ3sN8dEjfXcOMEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCxbzfZ5rZ9XQyZcej798yyk7qYg+dhcvDDji7gU93UsbxOdGbYrYjkk9dSc+V1jP
	 wRTaJD+fdQnSdEEjRH2UskfyYe4bHqMb0fFRYLPWMfA7WQb7QXBECAwZ4ZXPLSVYPT
	 1aHa+mcMYwUZ6Z7b1GheBPlH19vT9PI9edQZDvPuVPky8KLq6W16hTijmazMhrKrn+
	 VJ47fSAFjKmeZHJph8kg90Bqo6mBuyVkJ710f/9NTVxhvwAu04gM6vLXqtl37FkPxN
	 +6D0s7LC6v2ozzU8AzbJinP7WD4wToi5DaU+0ajERQAw5m8zP/wpD+TlS2Hfo3mhn6
	 SpKjQuEMPpJvQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNJzw0sL0zMWd;
	Tue,  8 Oct 2024 10:58:20 -0400 (EDT)
Message-ID: <9c3a8650-c855-41d2-b500-6a72e45c057c@efficios.com>
Date: Tue, 8 Oct 2024 10:56:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/rseq: Fix mm_cid test failure
To: Shuah Khan <skhan@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>
References: <20241004004439.1673801-1-mathieu.desnoyers@efficios.com>
 <20241004004439.1673801-3-mathieu.desnoyers@efficios.com>
 <01153485-ea70-47f7-ab6b-2c17496ab8ff@linuxfoundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <01153485-ea70-47f7-ab6b-2c17496ab8ff@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-04 21:18, Shuah Khan wrote:
> On 10/3/24 18:44, Mathieu Desnoyers wrote:
>> Adapt the rseq.c/rseq.h code to follow GNU C library changes 
>> introduced by:
>>
>> commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature 
>> detection (bug 31965)")
>>
>> Without this fix, rseq selftests for mm_cid fail:
>>
>> ./run_param_test.sh
>> Default parameters
>> Running test spinlock
>> Running compare-twice test spinlock
>> Running mm_cid test spinlock
>> Error: cpu id getter unavailable
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> CC: Carlos O'Donell <carlos@redhat.com>
>> CC: Florian Weimer <fweimer@redhat.com>
>> ---
>>   tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
>>   tools/testing/selftests/rseq/rseq.h |  10 +--
>>   2 files changed, 76 insertions(+), 43 deletions(-)
>>
> 
> Looks good to me.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Peter, Ingo - let me know if you plan to take this through
> one of your trees. Otherwise I will pick it up.

Hi Shuah,

I just discussed with Peter on IRC, and if you can pick up
this rseq selftest fix through your tree it would be very much
appreciated,

Thanks,

Mathieu

> 
> thanks,
> -- Shuah
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


