Return-Path: <linux-kernel+bounces-312833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A41969C37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E801C230B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B91A42D8;
	Tue,  3 Sep 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUJhY3BN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+htTep39"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233E195
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363784; cv=none; b=nUlkVMIBgXLtX01QVB+xciRcZMAdhC74ElV50rD5qOrxB9MZq+kugDJh1GBwKFBjtzjG2s+lX0uUhcaPXxqepoXoEq1k+b+5iibb834IE7oxYyznxD4l+D7ov6r6H6U5URhqeIX2C95a7raNlsSxPhonRduw42zUFdEQYD+PNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363784; c=relaxed/simple;
	bh=NewpaBT8/18jKrhIKXo3t8BlOZWI+3CZ90xWofJF5vE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCoxvxpwKFmBBFNm6W4GcVC42tJsLHahihV3UvHux6eWIsjSyKsM3eLlY8qqPpl56++AbMW7gVBG9elf845gKxXEGT6R05p7Bjhe3EBrCak5X/2z50xoV+bZmHW4gF+gu1vvHTkPPZXjkFCaXjovml6yhW7yZfDOcIZqVrIQxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUJhY3BN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+htTep39; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725363780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxPKfeg+sNcsgTJLyA6WETLEYxiu71BQyJSPNeaF8/s=;
	b=mUJhY3BN8PpxhUZWOOH0WV4WjpwE2kodHk7w1y6o3Wnk7vx/Tvlc8L+PuiPWqs6Gl0TYCX
	JZZmkJFhlW0wke27VQBAo2Q8/UhC5XCdnZJbxWXPy7kk8VSbsNN05c2AdzfYi8JTRupyPJ
	CKccZjCkfPq/yhVZARKq89hOPXJkOK0amqooxU673ZR2sqZ1UG6Ih6d7pyp9Vvk/shhHiT
	jV9astUb2jB0/J+/85zCa9+V7NJWBsaNzy6zSFNkGeOotsZ4x3LfAUYmBvLNKeIJnx169O
	atYQ0G/uGBipnb+mFNsl04859gA9UyJpwtEBIvPHYm7HS8Vr94yR6Tu4pWVCrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725363780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxPKfeg+sNcsgTJLyA6WETLEYxiu71BQyJSPNeaF8/s=;
	b=+htTep39ANvninhI9IGDRU4Rf7hNZBV355Q7iUT0+ucgIZFicMrtGkz33Nr/xl89pnKr81
	83xBMNJAiaG30OBA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] debugobjects: Fix the misuse of global variables in
 fill_pool()
In-Reply-To: <5cf23898-892c-c0a6-2525-206e21732665@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-2-thunder.leizhen@huawei.com> <87mskq58l5.ffs@tglx>
 <13d2be50-4a52-7cf0-8325-65435ad47a62@huawei.com>
 <3bb35c94-dd54-33d4-b7ac-64f0d2b77c07@huawei.com>
 <659f0321-e567-ad48-4545-4a47a158d6c2@huawei.com> <87seuh84cx.ffs@tglx>
 <5cf23898-892c-c0a6-2525-206e21732665@huawei.com>
Date: Tue, 03 Sep 2024 13:43:00 +0200
Message-ID: <87a5gp7ykb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 03 2024 at 19:14, Leizhen wrote:
> On 2024/9/3 17:37, Thomas Gleixner wrote:
>> On Tue, Sep 03 2024 at 15:00, Leizhen wrote:
>>>>> @@ -84,10 +85,7 @@ static int __data_racy                       debug_objects_fixups __read_mostly;
>>>>>  static int __data_racy                 debug_objects_warnings __read_mostly;
>>>>>  static int __data_racy                 debug_objects_enabled __read_mostly
>>>>>                                         = CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
>>>>> -static int __data_racy                 debug_objects_pool_size __read_mostly
>>>>> -                                       = ODEBUG_POOL_SIZE;
>>>>> -static int __data_racy                 debug_objects_pool_min_level __read_mostly
>>>>> -                                       = ODEBUG_POOL_MIN_LEVEL;
>>>>> +static int __data_racy                 obj_pool_min_free = ODEBUG_POOL_SIZE;
>>>
>>> Sorry, I rechecked it again. After this patch, obj_pool_min_free is referenced in the
>>> same way as obj_pool_max_used. The only race point is located in debug_stats_show().
>>> However, this reference point does not need to be included in the race analysis. So
>>> there is no need to add __data_racy for obj_pool_min_free.
>> 
>> The read races against the write, so KCSAN can detect it and complain, no?
>
> Oh, I just saw that there were a lot of other global variables in that function
> that didn't mask KCSAN's detection. So I'll recheck each global variable.
> However, for obj_pool_min_free, it seems that it would be better to just add
> READ_ONCE() in debug_stats_show(). This does not prevent the compiler from
> optimizing variable references in the lock.
>
> # define __data_racy volatile

This is only when KCSAN is enabled. Otherwise it's empty.

And if you do a READ_ONCE() then you need a corresponding WRITE_ONCE()
to make sense. __data_racy is much simpler for that.

Thanks,

        tglx

