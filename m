Return-Path: <linux-kernel+bounces-253269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEF931EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E61F22A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF51B812;
	Tue, 16 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qt4uvdiB"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C310C8F3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097027; cv=none; b=Orcx8R2w40udBz6HmI3SS3zYArouDTHWgFkSmny2BcSURzH/s2eRfYzKhVoogyjfQspgQrO+INy7UYFtGX+NluYl4ImEURY0D0mIDjojcyPaHRl2wLkj73eETtgTi9cW7i3k95HbBT5Fbaqr7c7AYltOM3fR0jlxp89vFdEtuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097027; c=relaxed/simple;
	bh=L/UYxKhv+weNiH5QZ9tdfwVpDaTTe0xo/PJfa52jczc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUasPfi20YYegraMY6veu7YkjnHFqL4fFjLVyoGpSqKDRoUfZPkSLRDYJ/RC3T8qV5E7uij7frN04u01kxnZ8CBgjw3Rmuqxx6jTlXcciq/dMqc0uRyJgiyJhKd6wPGyUlxCr44egN3OdIOuKYuPWcRH1/Si+2oUEGTfhajffNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qt4uvdiB; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nphamcs@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721097023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dp+t4TVVT4KvEUTsJDJgPzRF5rh9Mr0HlvSnhg7VjDo=;
	b=Qt4uvdiBJ63KRbdjDcIfbEAfuFSOjdTP5wypoxktEPs0O++jZOkRTi49OXjTCCJxLlbDWS
	MNLwDDGYMCDu7RRnH7Kbhcfa8ooasRcIDJAZDeIjbBwDTOkzj3jJoQKqMMEEQm73D6X8H+
	dFVFlRPIbfBVkUXuw2SPsxsFc6fk6w4=
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <19ceab41-1537-4fbc-b75d-7a2f5c50c0f3@linux.dev>
Date: Tue, 16 Jul 2024 10:30:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Nhat Pham <nphamcs@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com>
 <0afc769e-241a-404e-b2c9-a6a27bdd3c72@linux.dev>
 <CAPpoddfySkGpD5hKgqUAAMgMp2vWcivg1AzcyYh_NP1-ZsGkug@mail.gmail.com>
 <cc5ba793-59a4-4904-a1b3-723ebaa3a93e@linux.dev>
 <CAKEwX=Oqe8qz0YKi1pJaEgXAPC-7cXg7_NRfXb1_0VJp35X7AQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=Oqe8qz0YKi1pJaEgXAPC-7cXg7_NRfXb1_0VJp35X7AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/13 06:47, Nhat Pham wrote:
> On Tue, Jul 9, 2024 at 6:26 AM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> On 2024/7/8 21:44, Takero Funaki wrote:
>>> 2024年7月8日(月) 12:56 Chengming Zhou <chengming.zhou@linux.dev>:
>>>
>>>>>         comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
>>>>>         dlen = acomp_ctx->req->dlen;
>>>>> -     if (comp_ret)
>>>>> +
>>>>> +     /* coa_compress returns -EINVAL for errors including insufficient dlen */
>>>>> +     if (comp_ret && comp_ret != -EINVAL)
>>>>>                 goto unlock;
>>>>
>>>> Seems we don't need to care about? "comp_ret" is useless anymore.
>>>>
>>>> Just:
>>>>
>>>> if (comp_ret || dlen > PAGE_SIZE - 64)
>>>>           dlen = PAGE_SIZE;
>>>>
>>>> And remove the checkings of comp_ret at the end.
>>>>
>>>
>>>>
>>>> We actually don't need to hold mutex if we are just copying folio.
>>>>
>>>> Thanks.
>>>>
>>>
>>> Thanks for reviewing.
>>>
>>> For comp_ret, can we consolidate all possible error codes as
>>> incompressible data?
>>
>> Maybe we still want these debug counters? I'm not sure.
> 
> I'm a bit torn, but ATM I have no strong opinions on these two error
> codes. If you do decide to consolidate these two, may I ask you to
> separate it into its own patch so that we can review + discuss it
> separately?

Yeah, I also have no strong opinions on these two error codes,
it's just ok to keep them.

