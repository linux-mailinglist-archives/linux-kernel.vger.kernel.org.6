Return-Path: <linux-kernel+bounces-539768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E118DA4A859
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 04:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBA7189A40C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33905155C88;
	Sat,  1 Mar 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mAdOipA/"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82B2CA8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740801011; cv=none; b=AYSbCi7gV5akFb5cx2WulvblOlznXsZfwuZSmYHbTbRDf7P3ZuGG/bL5V8Hb2AGw6MYhpNFzn20d7HRiHXwSNpZYJhmRVXPhamuG8vLkdeXrOx2m4jVdrFmj6TYBxZ00D0DbJt4oNoX0ERdp5MdDi9IRJbbWZNd1PfMLyAnQtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740801011; c=relaxed/simple;
	bh=xynOytaan/Oe1XyJE8tqbjE+EkDNyqAz463FIVB4Oeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeGlM7DFcRCuO3y+o9s98RypElX3Cs3nlxQcLjdOAP1NsUro1dXc1D58V8TgyGcIF3+RI9TT5lO1sKtgoKyqIvj0eDDSFvRYtNgoecLwQUyqC7+6xO+jqL8UgL6F9YNiQa40AGAshDbve9yJACMV4jB5gEOrmrwpCCxAi/voku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mAdOipA/; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1667aa56-e49d-495b-a8ea-8835b2ea7341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740801005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmaveweWJCBZM1QdavIDzGtze3/PRZGSe0FfQRYS1xg=;
	b=mAdOipA/8iGmhQGOfBGr7+PGpCxmAQs0epqmJVXaawrisevF8cXSELosRcx5qgNEdU/nTp
	vPjnyflOG1cyBlL3GhFKwXkLKRFzZUlfyLNp0qukyEsFrO/QxOb+0bFQLCKUPych14PqhA
	rHFUwxP8eOKuKnAGkCYKbK+FqMpmkdM=
Date: Sat, 1 Mar 2025 11:49:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
To: Joel Granados <joel.granados@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250105152853.211037-1-wen.yang@linux.dev>
 <ce2na5wzbkpvrh4tccmrfwi5hukwjnrpkhnggdfgce7ccs5rvq@w2c76uttfxq3>
 <58da9dcb-a4ea-4d23-a7e5-b7f92293831a@linux.dev>
 <i5h3sxl34d5pddluwxfhlumkt5fatin3rsqbwpfcm2rceg46ix@w3c2l6ntu2ye>
 <875xm5o0tx.fsf@email.froward.int.ebiederm.org>
 <87o6zxmlha.fsf@email.froward.int.ebiederm.org>
 <ov6x26vw4rq5ekz4fy2t23xbtkh2dkkrfrkzp7dvkhy2djm4vl@2b7batukhrbm>
 <875xm0gn60.fsf@email.froward.int.ebiederm.org>
 <xklw53ynxfl3m5ngk4wz6bjgoylbuy2zo6vhzjrfoj4mgkpptr@ja6zq4lldmd7>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <xklw53ynxfl3m5ngk4wz6bjgoylbuy2zo6vhzjrfoj4mgkpptr@ja6zq4lldmd7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/27 22:07, Joel Granados wrote:
> On Mon, Jan 27, 2025 at 11:51:51AM -0600, Eric W. Biederman wrote:
>> Joel Granados <joel.granados@kernel.org> writes:
>>
>>> On Thu, Jan 23, 2025 at 12:30:25PM -0600, Eric W. Biederman wrote:
>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>
>>>>> Joel Granados <joel.granados@kernel.org> writes:
>>>>>
>>>>>> On Sun, Jan 19, 2025 at 10:59:21PM +0800, Wen Yang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2025/1/16 17:37, Joel Granados wrote:
>>>>>>>> On Sun, Jan 05, 2025 at 11:28:53PM +0800, Wen Yang wrote:
>>>>>>>>> do_proc_dointvec_conv() used the default range of int type, while
>>>>>>>>> do_proc_dointvec_minmax_conv() additionally used "int * {min, max}" of
>>>>>>>>> struct do_proc_dointvec_minmax_conv_param, which are actually passed
>>>>>>>>> in table->extra{1,2} pointers.
>>> ...
>>>>>> (if any). And this is why:
>>>>>> 1. The long and the void* are most likely (depending on arch?) the same
>>>>>>     size.
>>>>>> 2. In [1] it is mentioned that, we would still need an extra (void*) to
>>>>>>     address the sysctl tables that are *NOT* using extra{1,2} as min max.
>>>>>>     This means that we need a bigger ctl_table (long extra1, long extra2
>>>>>>     and void* extra). We will need *more* memory?
>>>>>>
>>>>>> I would like to be proven wrong. So this is my proposal: Instead of
>>>>>> trying to do an incremental change, I suggest you remove the sysctl_vals
>>>>>> shared const array and measure how much memory you actually save. You
>>>>>> can use the ./scripts/bloat-o-meter in the linux kernel source and
>>>>>> follow something similar to what we did in [2] to measure how much
>>>>>> memory we are actually talking about.
>>>>>>
>>>>>> Once you get a hard number, then we can move forward on the memory
>>>>>> saving front.
>>>
>>> Hey Eric.
>>>
>>> Thx for the clarification. Much appreciated.
>>>>>
>>>>> When I originally suggested this my motivation had nothing to do with memory
>>> That makes a *lot* of sense :).
>>>
>>>>> The sysctl_vals memory array is type unsafe and has actively
>>> Here I understand that they are unsafe because of Integer promotion
>>> issues exacerbated by the void* variables extra{1,2}. Please correct me
>>> If I missed the point.
>>
>> Not precisely.  It is because the (void *) pointers are silently cast to
>> either (int *) or (long *) pointers.  So for example passing SYSCTL_ZERO
>> to proc_do_ulongvec_minmax results in reading sysctl_vals[0] and
>> sysctl_vals[1] and to get the long value.  Since sysctl_vals[1] is 1
>> a 0 is not accepted because 0 is below the minimum.
>>
>> The minimum value that is accepted depends on which architecture you are
>> on.  On x86_64 and other little endian architectures the minimum value
>> accepted is 0x0000000100000000.  On big endian architectures like mips64
>> the minimum value accepted winds up being 0x0000000000000001.  Or do I
>> have that backwards?
>>
>> It doesn't matter because neither case is what the programmer expected.
>> Further it means that keeping the current proc_do_ulongvec_minmax and
>> proc_do_int_minmax methods that it is impossible to define any of the
>> SYSCTL_XXX macros except SYSCTL_ZERO that will work with both methods.
>>
>>> There is also the fact that you can just do a `extra1 = &sysctl_vals[15]`
>>> and the compiler will not bark at you. At least It let me do that on my
>>> side.
>>
>> All of which in the simplest for has me think the SYSCTL_XXX cleanups
>> were a step in the wrong direction.
>>
>>>>> lead to real world bugs. AKA longs and int confusion.  One example is
>>>>> that SYSCTL_ZERO does not properly work as a minimum to
>>>>> proc_do_ulongvec_minmax.
>>> That is a great example.
>>>
>>>>>
>>>>> Frankly those SYSCTL_XXX macros that use sysctl_vals are just plain
>>>>> scary to work with.
>>> I share your feeling :)
>>>
>>>>>
>>>>> So I suggested please making everything simpler by putting unsigned long
>>>>> min and max in to struct ctl_table and then getting rid of extra1 and
>>>>> extra2.  As extra1 and extra2 are almost exclusively used to implement
>>>>> min and max.
>>> Explicitly specifying the type will help reduce the "unsefeness" but
>>> with all the ways that there are of using these pointers, I think we
>>> need to think bigger and maybe try to find a more typesafe way to
>>> represent all the interactions.
>>>
>>> It has always struck me as strange the arbitrariness of having 2 extra
>>> pointers. Why not just one?
>>
>> Which would be the void *data pointer.
>>
>>> At the end it is a pointer and can point to
>>> a struct that holds min, max... I do not have the answer yet, but I
>>> think what you propose here is part of a bigger refactoring needed in
>>> ctl_table structure. Would like to hear your thought on it if you have
>>> any.
>>
>> One of the things that happens and that is worth acknowledging is there
>> is code that wraps proc_doulongvec_minmax and proc_dointvec_minmax.
>> Having the minmax information separate from the data pointer makes that
>> wrapping easier.
>>
>> Further the min/max information is typically separate from other kinds
>> of data.  So even when not wrapped it is nice just to take a quick
>> glance and see what the minimums and maximums are.
>>
>> My original suggest was that we change struct ctl_table from:
>>
>>> /* A sysctl table is an array of struct ctl_table: */
>>> struct ctl_table {
>>> 	const char *procname;		/* Text ID for /proc/sys */
>>> 	void *data;
>>> 	int maxlen;
>>> 	umode_t mode;
>>> 	proc_handler *proc_handler;	/* Callback for text formatting */
>>> 	struct ctl_table_poll *poll;
>>> 	void *extra1;
>>> 	void *extra2;
>>> } __randomize_layout;
>>
>> to:
>>
>>> /* A sysctl table is an array of struct ctl_table: */
>>> struct ctl_table {
>>> 	const char *procname;		/* Text ID for /proc/sys */
>>> 	void *data;
>>> 	int maxlen;
>>> 	umode_t mode;
>>> 	proc_handler *proc_handler;	/* Callback for text formatting */
>>> 	struct ctl_table_poll *poll;
>>>        unsigned long min;
>>>        unsigned long max;
>>> } __randomize_layout;
>>
>> That is just replace extra1 and extra2 with min and max members.  The
>> members don't have any reason to be pointers.  Without being pointers
>> the min/max functions can just use long values to cap either ints or
>> longs, and there is no room for error.  The integer promotion rules
>> will ensure that even negative values can be stored in unsigned long
>> min and max values successfully.  Plus it is all bog standard C
>> so there is nothing special to learn.
>>
>> There are a bunch of fiddly little details to transition from where we
>> are today.  The most straightforward way I can see of making the
>> transition is to add the min and max members.  Come up with replacements
>> for proc_doulongvec_minmax and proc_dointvec_minmax that read the new
>> min and max members.  Update all of the users.  Update the few users
>> that use extra1 or extra2 for something besides min and max.  Then
>> remove extra1 and extra2.  At the end it is simpler and requires the
>> same or a little less space.
>>
>> That was and remains my suggestion.
> Thx for all this. Been putting this off for a month now, but will slowly
> come back to it. I'll use your and Wen's series to try to come up with
> something that look good to me.
> 

Thanks.
The following is the latest series, which has been tested for about 20 days:

https://lore.kernel.org/all/cover.1739115369.git.wen.yang@linux.dev/

We look forward to your comments and suggestions.

--
Best wishes,
Wen


