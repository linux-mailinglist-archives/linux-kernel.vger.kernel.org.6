Return-Path: <linux-kernel+bounces-417044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5779D4E38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DFF1F22E95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F31D7994;
	Thu, 21 Nov 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ux48Y1oX"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40884320B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197738; cv=none; b=VbOMyyFvzmV8Vb4RW06iy/tbAw1oxUgekkpNW5n90sGCkyvYMT+k4EGGNCDw8zOgG6sBJWB5Anj+HaK0/BKx2jDLN7xb66y8Ffa4qFzC2LtCbq+aDwESppHtQsKYKbGBFDBJn9kDX7AopOQJN1/1qMDOx0MQh97gKl34ByfXNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197738; c=relaxed/simple;
	bh=1yHbEhVAo6KTrXnZzHNR63CihjTHGs9bJbZXWAfV0R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S16YbD6LXokDVbq3ZVQHtLkCiz1SPRkdEa+HXALdkGaa/LKAqhMUlxh7VtCytWpUmQi3riJUzXpsSsu9TTqPyMgfCLK4whjuKdmqLaOI469Owo6qt+CZh5jyGTYN+usyyktuCiQkBh0OkcV6V/IrwrOVNPlxIH0ekhA3iH6n2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ux48Y1oX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732197726; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sSE9P+6fQSog68BYc7iKax0rvyIdA8LXB9XGGJ7y2I4=;
	b=Ux48Y1oXVoZlGodA70qZldiWYemSukpMK3ycfndUf1cwPVD4XTl2vXUN2MWzoRLNdNLhDBAteNiksrLr4JDHaWDLPk5LJ+wKVdYaBnwJYGtX6YcjnC88hNYRmvSH3fXTsalM200e7sbWw50sC2pdT5KARXDkLFB70TsO3tixR5c=
Received: from 30.244.109.101(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJxDh6-_1732197724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 22:02:06 +0800
Message-ID: <ad888abe-2ffc-41bf-b60f-e4508374b5c1@linux.alibaba.com>
Date: Thu, 21 Nov 2024 22:02:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com>
 <20240612094856.GV40213@noisy.programming.kicks-ass.net>
 <CAKPOu+-X8P8WdSEcTX_EVgA9wiMdSdXdzA58Z5vvkQKc+Oz-PQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+-X8P8WdSEcTX_EVgA9wiMdSdXdzA58Z5vvkQKc+Oz-PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/12 18:20, Max Kellermann wrote:
> On Wed, Jun 12, 2024 at 11:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> The erofs one is also not entirely obvious, but irrelevant if you're not using
>> it... the below should make it a little more obvious, but what do I know.
> 
> We do use erofs a lot, and I read that very function the other day -
> it is weird code with two loop levels plus continue and even goto; but
> I thought it was okay. psi_memstall_enter() is only ever called if

The outer loop handles the whole inflight chain (all compression
extents that need to be decompressed).

The inner loop handles each compression extent (called as a pcluster
-- physical cluster in EROFS) in the chain, and it could contain
several consecutive physical blocks so it needs a loop:

   If the physical block doesn't need a real I/O (due to cached data
for example), it will "continue;"
   Or it will check if i/o is consecutive, if not, submit the current bio;
   then get a new bio if needed and add the physical block to the bio;
   if the physical block cannot be added to the bio, retry:
    -- some similiar logic can also be found in:
       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/mpage.c?h=v6.12#n298

Hopefully it helps.

Thanks,
Gao Xiang

