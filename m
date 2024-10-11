Return-Path: <linux-kernel+bounces-361837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681F99ADA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DFD1C22378
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596261D1311;
	Fri, 11 Oct 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADBndfTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BgUardgU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E351991DB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679222; cv=none; b=jrPvenkIJdHmR8kQIJGdTwTe+6+KRl49KKYBnG13BPlJuGVInGdGe1p5WJpDOXOfD+/YfE5B3/Rj8TDSCGnBCJmuPrIXcSl2hcDv9JSqci5yeRj7L7GAu0KPpJ/yZdkTN/+DRbCvrfy6gQN2eyqxnR1C3VyEVyiWlTjh82OC7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679222; c=relaxed/simple;
	bh=UGRDoY+YboBnTtFYrJn7BoaQf0cZDHnrRWwO85GWp3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayFCeGl/RL3zMyKzcwL8a7vSWMN3pOewyL+CfgrCBdUOgK7GkYddfm8r4MCHRYpzwBKsVgYbRmyLDiqLuIA/XjhKglP5RDHi53zvGGnGvYH+hcNrhoDjEyZImO4C3c25HLz7XwTEZK9NZDrMw42aumDzy+aodVLyz6R9z20ymOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADBndfTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BgUardgU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728679218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nS6sTKML1qBFZshEiXzAKzQQpzPzhvTKWEQIsUOdgqQ=;
	b=ADBndfTkFWZ9Jn0o8DrGcH0eWv47VpWkYHIJTBGUzNAVjY8c4ltc3gz9L7nU10b5KwBMe9
	wo9tUnIQ5z3fGjB8UOxqJvu8ilb8QuVbEKrT3CXpcqkcb5ZLIPzyxZhV4kFhDD1ob5Nyjc
	MGGZdautJmTYNVQP/PS21JAPYo35YkmLBdPpyfhaXWy5rPqqQ7CkyzNWWn3QGvywsYgMWj
	15BH8/+K9YH8eo/2/s6N1hodBYn4YKgz1jqBwg6xQyW/JFaHOvO1h9LHhHXmWNN+46dYEm
	ONb80fQgtLhJPq/Ki+GvnAXa85DtzDz06dgRNIwGNslrM1pnzKUJVNC70Iyo6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728679218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nS6sTKML1qBFZshEiXzAKzQQpzPzhvTKWEQIsUOdgqQ=;
	b=BgUardgUU797WYBkUBbeMpSRD/SFF2mnToYwDRQMuh2rR9CiY1QN5ETa1qwjX78JCoG206
	blCay2lE9o9lLiDA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 08/25] debugobjects: Provide and use free_object_list()
In-Reply-To: <9a23ef1f-096a-c808-8ddf-27f6e1673581@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.453912357@linutronix.de>
 <9a23ef1f-096a-c808-8ddf-27f6e1673581@huawei.com>
Date: Fri, 11 Oct 2024 22:40:17 +0200
Message-ID: <87msjagyq6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 10:54, Leizhen wrote:
> On 2024/10/8 0:50, Thomas Gleixner wrote:
>> Move the loop to free a list of objects into a helper function so it can be
>> reused later.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  lib/debugobjects.c |   22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>> 
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -125,6 +125,20 @@ static const char *obj_states[ODEBUG_STA
>>  	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
>>  };
>>  
>> +static void free_object_list(struct hlist_head *head)
>> +{
>> +	struct hlist_node *tmp;
>> +	struct debug_obj *obj;
>> +	int cnt = 0;
>> +
>> +	hlist_for_each_entry_safe(obj, tmp, head, node) {
>> +		hlist_del(&obj->node);
>> +		kmem_cache_free(obj_cache, obj);
>> +		cnt++;
>> +	}
>> +	debug_objects_freed += cnt;
>
> debug_objects_freed was previously protected by pool_lock. Use atomic?

It's statistics, so I'm not really worried about it whether it's a bit
off or not. 

But aside of that the freeing is single threaded because objects are
only handed back to the kmem_cache from the worker thread.

Thanks,

        tglx

