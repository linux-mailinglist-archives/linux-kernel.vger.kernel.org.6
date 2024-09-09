Return-Path: <linux-kernel+bounces-321615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18711971CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B681F23B59
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994E1BAEDE;
	Mon,  9 Sep 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7DHNG1P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOjqB79n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFF1BA26E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892863; cv=none; b=CS6WThu64rHJctrEJ3cbaSs8xYW/107u1TY+xueom9pfZAyxVDt0GyBHE+M8iDpkW1D8pZAmJlPw5M4NvKE1njTXi8epEABOoJQsteXAvs+W+m0v1nPUW+6c3F2BglGjS6/Wn6PZIpymkq2AteEciPHpUYXFrZ0YeaCrMsmavQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892863; c=relaxed/simple;
	bh=7/G5DjG2KyGR1d9SzRNnNSHuGxIVay1LFTQXqOUlO1k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ent+IJjEl/ef0sFH0qXNShJmufft3KyhPoLycsDlJuw6U+50wcWXvqm1qPQfa8dC4+CDmggH0TsYOE4EOTkro7W13XI0ucjrOFPgWlQIzoYF+mnk2nqjaEJJAL+kN5X3ZPCzrCAUs0cUVoJ3ps8gHmcGpS9DOhEN2FhttxfpC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7DHNG1P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOjqB79n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725892860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHipTEW4OJFVZM+5bs+it62Yg/W7jpVg5zrORk9f5TI=;
	b=L7DHNG1PLl3fXr+XFewcZ/KEjc98qfCFBpEkyb01xzdqhO/RBnS/pdBUNklVTVS53vlS2H
	iFE27ISHMu3kzsmW/cULqgk795ScUW4HPKWCEu8hr/3LVzrW37FC4S1AtYPeKVAA0dVJRA
	84FbVazYgL9bvc3AwQ6Li5gPltFL3kYyb9JRItS3XS63oRzb7har4RFoIP5UXK1FOTAmAi
	xcet2OfZsYwvbPB/T4oQBNbijdFdcgt7CH19EWF6wtCZhkL8mL1zrMzEUr9JFRPT/KOJKt
	Q4ANDLGTsmgmywcWclxylzeptXIjXMbMQVd1KxyIJlAKz37QPa/sETwUW8hsRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725892860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHipTEW4OJFVZM+5bs+it62Yg/W7jpVg5zrORk9f5TI=;
	b=sOjqB79nWCIY4IQgTMKk572dma2X4CYaKxsMF4hvVZSYz8PEt7TrvW5uxXmkv8/azkM3i9
	pi70qLAZQRrmKsCg==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
In-Reply-To: <87wmjkc2te.ffs@tglx>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
 <87bk0xc9iy.ffs@tglx> <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
 <87wmjkc2te.ffs@tglx>
Date: Mon, 09 Sep 2024 16:41:00 +0200
Message-ID: <87r09sc2kj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 16:35, Thomas Gleixner wrote:

> On Mon, Sep 09 2024 at 21:51, Leizhen wrote:
>> On 2024/9/9 20:10, Thomas Gleixner wrote:
>>> So something like the uncompiled below should reduce lock contention
>>> significantly with a reasonable safety net.
>>
>> It looks very good. Especially flexible use of 'state' and 'cpus_allocating'.
>> In this way, there is almost no conflict of lock 'pool_lock', and the more
>> cores, the less possible conflict.
>>
>> Hi Thomas Gleixner:
>>   Do you plan to post this patch? But this patch will conflict with my patch 5/6.
>> If you're going to merge my patch 5/6, hopefully yours will be applied
>> after mine.
>
> I'm short of cycles, so the best way is when you pick it up and
> integrate it instead of 4/6 and post a v3.

I'm picked up 1-3 from this series now. So you can drop them and work
against

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects

Thanks,

        tglx



