Return-Path: <linux-kernel+bounces-361835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BD99AD99
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324791F23EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D051D1311;
	Fri, 11 Oct 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYUtV0rv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wy7lDz+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAC1C3F0A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679066; cv=none; b=RqyP/TnLGYZNEoS/cTnZhVO4OdF1/Yug7jLs8aC5QTgkurceTOvtqWCeP5Ae3NkIR25iLbz2gOlwGvzUzp7v6Fv8yyHi3fxvL7HJFkpvNLNlCMb/w5keJudJoNUkhJmLt/C6e1Eq3X46NEFb0xJsI8dMYGdAds5TFRumxIn0Euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679066; c=relaxed/simple;
	bh=0w/5Ikj8lHHRzgca3Ci/TW1pF/uPHUczyyzvek/bCeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3pZAs/UvaSCm+dRRcSFrnA5QPEBYeD9iRTQF0SQmtKy/oBtePRYU5ILqmdlD7eHMkUCFOp3AaSqeL4h+imJGgvifNm3Y6OOOxakDoEEZMWLblPArcG8p5O9ri9R7V6SSKE1y7nHT4OGz7l9hGDzQOB4YgYemmca37AKZEnQZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYUtV0rv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wy7lDz+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728679063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvGBlOwXZ0QwZ+atkdEw96HjKqy74TcuL2n6BgA/buQ=;
	b=WYUtV0rvezi3L9xJFgKXgVoc2Ok7V70pG4VLSK5YQ+NZf6YF8ul239Wr5rHHt3xpG/x4+u
	IbGQlVT/ThC9pOfy5b3VjGqdPA+4N+5+DalIjYDKyxZcri29754GQIWvx/fCyHvuWvX7Z4
	3iD1gKHwI77Z7AOWW4XKgolfJJfyw05BrrH5qnXM4gvLhf1qm1It3OZAplLzFt183OzFe5
	9hpsV22rOjk4mu0n8s30NM3DPfn5Zv/HqTq1bO/UGT0Lo+ekYaCw/2lGxCkcjHD2333lh1
	x4P1FjEH6d7chyOudqS1bE+FM79mwCGxo7iYmAX1LecALRUpMapss3dPjzSwGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728679063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvGBlOwXZ0QwZ+atkdEw96HjKqy74TcuL2n6BgA/buQ=;
	b=Wy7lDz+UnAkc2lqW/Irxea/WgS06DN7FZzdOquBLDKERBqdCmELDHS1FxK62VHJDu1eXhQ
	zqGD4W2m5MFc0rCA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 03/25] debugobjects: Dont destroy kmem cache in init()
In-Reply-To: <02904743-8c39-5a44-78cd-a41715bf2f0b@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.137021337@linutronix.de>
 <c118dad2-4e39-78f2-c09b-0fe771feb86a@huawei.com> <878quwi3jb.ffs@tglx>
 <02904743-8c39-5a44-78cd-a41715bf2f0b@huawei.com>
Date: Fri, 11 Oct 2024 22:37:43 +0200
Message-ID: <87plo6gyug.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 21:31, Leizhen wrote:
> On 2024/10/10 19:46, Thomas Gleixner wrote:
>> On Thu, Oct 10 2024 at 10:14, Leizhen wrote:
>>> On 2024/10/8 0:49, Thomas Gleixner wrote:
>>>> -	if (!obj_cache || debug_objects_replace_static_objects()) {
>>>> +	if (!cache || !debug_objects_replace_static_objects(cache)) {
>>>>  		debug_objects_enabled = 0;
>>>> -		kmem_cache_destroy(obj_cache);
>>>
>>> kmem_cache_destroy(cache) should be kept, or move it into debug_objects_replace_static_objects()
>>> and place it above 'return false'.
>> 
>> At that point it can't be destroyed. See the backtrace.
>> 
>> So we just give the objects back and leak the kmem_cache.
>
> Oh, sorry, I didn't figure it out before, but now I do.
> But shouldn't we add kmemleak_ignore(cache) ?

I don't know if it's worth the trouble. With the follow up changes the
only reason why this can happen is that the static object conversion
cannot allocate memory. Leaking the kmemcache in that case is the least
of the worries.

I just tripped over that back trace because I intentionally triggered
the error path.

Thanks,

        tglx



