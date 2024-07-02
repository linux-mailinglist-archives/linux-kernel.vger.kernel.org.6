Return-Path: <linux-kernel+bounces-237376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6A91EFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C67B2397B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654312EBE3;
	Tue,  2 Jul 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RwuL3ESE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885655C8EF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904781; cv=none; b=Y7ITP0F4c5eo6zV4rFo7dDT1o7eUWpwFYrHF80Xz70FNtmutGfk39Gc/foWkhq4gKJEDtIJLIIAXciI0wRMapyudDS18MtuqiRxUptp5o6BNLHHFr/RwjKNuVhT0CZxiKaA9A4Ie7UzmsDXJbq0p3tBAInX47Jjtdl6ztO+qJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904781; c=relaxed/simple;
	bh=Ta3m9a85sklCrgOE7zhhYK4It5kzXcFZaPgEN0vhZtE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qr92ITawsKADQ3jO9KBmN4+LJEmFtt68g0ZIYjrR+0bYv20+4Tu4EUaTUXRV6mjExGP5Us7O7NqoMM5c6Id/FRHe6tLriDqMNsYjp3EtQ7Ag9IyiYgnfFTFxyi8j4xudymSGNMSorOMPO2kgzlyFpLu65wBb86lK5BB8dCtXHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RwuL3ESE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFF8C116B1;
	Tue,  2 Jul 2024 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719904781;
	bh=Ta3m9a85sklCrgOE7zhhYK4It5kzXcFZaPgEN0vhZtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RwuL3ESEYW197t6wLrPEYOCN0yzspp1ChYPbd2CaJLzlk4/f+XdG1WmCEKTnMQ2Dm
	 C57mwtqELyeCsf3EwCS1lt07rtE6ndT8KjcREe2+jUhQXV56ZG4N8EuLXrX/eOFjQs
	 GDP+bYOum01YF7vOqiqf/tAFV7YR93oa1r0xe6kQ=
Date: Tue, 2 Jul 2024 00:19:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Rui Qi <qirui.001@bytedance.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <nao.horiguchi@gmail.com>
Subject: Re: [PATCH] mm/memory-failure: allow memory allocation from
 emergency reserves
Message-Id: <20240702001940.43a9447a76b51a871d8dec97@linux-foundation.org>
In-Reply-To: <d7fb45a9-2d16-a2d5-59f4-f1e7a4362e33@huawei.com>
References: <20240625022342.6158-1-qirui.001@bytedance.com>
	<d7fb45a9-2d16-a2d5-59f4-f1e7a4362e33@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 10:09:46 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2024/6/25 10:23, Rui Qi wrote:
> > From: Rui Qi <qirui.001@bytedance.com>
> > 
> > we hope that memory errors can be successfully handled quickly, using
> > __GFP_MEMALLOC can help us improve the success rate of processing
> 
> Comments of __GFP_MEMALLOC says:
> 
>  * Users of this flag have to be extremely careful to not deplete the reserve
>  * completely and implement a throttling mechanism which controls the
>  * consumption of the reserve based on the amount of freed memory.
> 
> It seems there's no such throttling mechanism in memory_failure.
> 
> > under memory pressure, because to_kill struct is freed very quickly,
> > so using __GFP_MEMALLOC will not exacerbate memory pressure for a long time,
> > and  more memory will be freed after killed task exiting, which will also
> 
> Tasks might not be killed even to_kill struct is allocated.
> 
> ...
>
> > -	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
> > +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC | __GFP_MEMALLOC);
> 
> In already hardware poisoned code path, raw_hwp can be allocated to store raw page info
> without killing anything. So __GFP_MEMALLOC might not be suitable to use.
> Or am I miss something?

Yes, I'm doubtful about this patch.  I think that rather than poking at a
particular implementation, it would be helpful for us to see a complete
description of the issues which were observed, please.  Let's see the
bug report and we can discuss fixes later.



