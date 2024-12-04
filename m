Return-Path: <linux-kernel+bounces-430413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C779E30A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8663B26B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE9848C;
	Wed,  4 Dec 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0C38Fejy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAA746E;
	Wed,  4 Dec 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274498; cv=none; b=ocXZdXdSibFV7ptr9QVSX89UHGbGjkRFge36aINqjWmpFT/h97vxEAHkT4cPdahmUrViGsGPnPavtoGnco0yin5a8s8nrSF7qggzMT9LWI1MdFPAzmvPFCUSMz59xRrjWZum8LdtoPq+pEhmT3V+pj7MQHmCLob88+6mabaf21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274498; c=relaxed/simple;
	bh=TuK+zEY04Pna6GnArvAcVVhsaISvVxq23m/8Ez9++yA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mlbk1H+rse7NqlXCW3/cBS8+6nI8rA6pz8jhC1GDxOw00TBsOK7c/SlIhBl/Fk8iqb8zuV6Tv10usP1pfRXcRhCaOfj1sb6NEiMmRbRFn+kkpJ5JcFsVnscKu3r0fIgRDLfxdU5Ghz7iCCBvz0JzDtWUo3+rkA9hWYutZVgfF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0C38Fejy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769BBC4CEDC;
	Wed,  4 Dec 2024 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733274498;
	bh=TuK+zEY04Pna6GnArvAcVVhsaISvVxq23m/8Ez9++yA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0C38FejyFWntdFzurye3Ptv78WQkibel8t059iY353tBNabNrhDptyQ80YkxDqQDG
	 Mq8lv+iEW00ZWlBg9911g3qDE64P7mVWyihvClRXZl6aS9wkrXgVx372F99Ixxpn0H
	 ispIKjuxzfy0Ko6MyZPXPMa1nyxVhFfFN3Q7I91w=
Date: Tue, 3 Dec 2024 17:08:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: <jiang.kun2@zte.com.cn>
Cc: <bsingharora@gmail.com>, <david@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>,
 <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
 <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
 <ye.xingchen@zte.com.cn>, <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux next] delayacct: add delay max to record delay
 peak
Message-Id: <20241203170816.3fe81941fe1866ca1672eba8@linux-foundation.org>
In-Reply-To: <20241203164848805CS62CQPQWG9GLdQj2_BxS@zte.com.cn>
References: <20241203164848805CS62CQPQWG9GLdQj2_BxS@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 16:48:48 +0800 (CST) <jiang.kun2@zte.com.cn> wrote:

> From: Wang Yaxin <wang.yaxin@zte.com.cn>
> 
> Introduce the use cases of delay max, which can help quickly detect
> potential abnormal delays in the system and record the types and
> specific details of delay spikes.
>   
> Problem
> ========
> Delay accounting can track the average delay of processes to show
> system workload. However, when a process experiences a significant
> delay, maybe a delay spike, which adversely affects performance,
> getdelays can only display the average system delay over a period
> of time. Yet, average delay is unhelpful for diagnosing delay peak.
> It is not even possible to determine which type of delay has spiked,
> as this information might be masked by the average delay.
> 
> Solution
> =========
> the 'delay max' can display delay peak since the system's startup,
> which can record potential abnormal delays over time, including
> the type of delay and the maximum delay. This is helpful for
> quickly identifying crash caused by delay.

Seems sensible, and the implementation is straightforward.  I'll queue
it for testing and review.

>  include/linux/delayacct.h      |  7 ++++
>  include/linux/sched.h          |  3 ++
>  include/uapi/linux/taskstats.h |  9 ++++++
>  kernel/delayacct.c             | 35 ++++++++++++++------
>  kernel/sched/stats.h           |  5 ++-
>  tools/accounting/getdelays.c   | 59 ++++++++++++++++++++--------------

Please prepare a v2 which includes an update to
Documentation/accounting/delay-accounting.rst.

> 
> ...
>
> --- a/kernel/delayacct.c
> +++ b/kernel/delayacct.c
> @@ -95,7 +95,7 @@ void __delayacct_tsk_init(struct task_struct *tsk)
>   * Finish delay accounting for a statistic using its timestamps (@start),
>   * accumalator (@total) and @count

And I wouldn't be offended if v2 fixed that spelling error!  "accumulator".



