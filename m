Return-Path: <linux-kernel+bounces-549026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD4A54C4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37A416BD6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF35200100;
	Thu,  6 Mar 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hlgeAm1t"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4F946C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268042; cv=none; b=DxCtaFYQiOgb54mc3bdDBhPsY8Gm05D0gmBw1FN1eiecwtA8wTfipotsYBEvaAz0/qLBtnKVAdRRqjBInBkoUU7vRxW8KsbOD1OO4xK2RxV/PosPAI/YFQ2aJLwY2VeNbkkWWcQJ+m5MlMZOH/v+3L+zVe+XI3EA0buOHnWFiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268042; c=relaxed/simple;
	bh=eD2myyI2HbycFMkGnXrnSQ9pMO5dvQj5iU7CrRA2a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Brnfb/DvscBmAG+Zidm4wNN+oz4oEggJDGYgdrCMopMPg0csLzTXWwUr2n4Yk/7n0uk0GlnmDmYYf6bWvocfFVu/f1eek261uQZU1enhpFjTzaJsAbtXEnnb6czT9Q8jGe+lhPtXG5LUC4j9Y2Pn6SZ5Y7+pLp2zssoZ00EONec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hlgeAm1t; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <806ee13d-cb97-4c27-b645-763c02b51713@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741268036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tyu2TAPopjbCVkeIsPbh3kuv8x1AO5Bjab5dQtTwfkY=;
	b=hlgeAm1t/cxsCRcclQMlxuq/5LG8knhextClp6Ux+68IBbFvBwORSf8n1xoc4O688vTS54
	HwoNw1Ou+zoiNUXga5qq8SoF3iabaz0ts/P8c2MQvJoqUHQNKgrdMgc+9AgYbPzawM4kB4
	bP10NahMTtIZ6NfL/WAgOCXbFTOMajE=
Date: Thu, 6 Mar 2025 21:33:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
To: Joel Granados <joel.granados@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
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
 <e861fc51-f244-4645-af72-56416a422060@linux.dev>
 <qpuf3nepmmkiqt7spcdpyrdnbyzbztr3jgabwou7bjyl746czs@c2iimb3bekr4>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <qpuf3nepmmkiqt7spcdpyrdnbyzbztr3jgabwou7bjyl746czs@c2iimb3bekr4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/3/3 17:26, Joel Granados wrote:
> On Thu, Jan 30, 2025 at 10:32:14PM +0800, Wen Yang wrote:
>>
>>
>> On 2025/1/28 01:51, Eric W. Biederman wrote:
>>> Joel Granados <joel.granados@kernel.org> writes:
>>>
>>>> On Thu, Jan 23, 2025 at 12:30:25PM -0600, Eric W. Biederman wrote:
>>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>>
>>>>>> Joel Granados <joel.granados@kernel.org> writes:
>>>>>>
>>>>>>> On Sun, Jan 19, 2025 at 10:59:21PM +0800, Wen Yang wrote:
> ...
>>>> struct ctl_table {
>>>> 	const char *procname;		/* Text ID for /proc/sys */
>>>> 	void *data;
>>>> 	int maxlen;
>>>> 	umode_t mode;
>>>> 	proc_handler *proc_handler;	/* Callback for text formatting */
>>>> 	struct ctl_table_poll *poll;
>>>>         unsigned long min;
>>>>         unsigned long max;
>>>> } __randomize_layout;
>>>
>>> That is just replace extra1 and extra2 with min and max members.  The
>>> members don't have any reason to be pointers.  Without being pointers
>>> the min/max functions can just use long values to cap either ints or
>>> longs, and there is no room for error.  The integer promotion rules
>>> will ensure that even negative values can be stored in unsigned long
>>> min and max values successfully.  Plus it is all bog standard C
>>> so there is nothing special to learn.
>>>
>>> There are a bunch of fiddly little details to transition from where we
>>> are today.  The most straightforward way I can see of making the
>>> transition is to add the min and max members.  Come up with replacements
>>> for proc_doulongvec_minmax and proc_dointvec_minmax that read the new
>>> min and max members.  Update all of the users.  Update the few users
>>> that use extra1 or extra2 for something besides min and max.  Then
>>> remove extra1 and extra2.  At the end it is simpler and requires the
>>> same or a little less space.
>>>
>>> That was and remains my suggestion.
>>>
>>
>> Thanks for your valuable suggestions. We will continue to move forward along
>> it and need your more guidance.
>>
>> But there are also a few codes that do take the extra{1, 2} as pointers, for
>> example:
>>
>> int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>>                            proc_handler *handler)
>> {
>> ...
>>          for (i = 0; i < NEIGH_VAR_GC_INTERVAL; i++) {
>>                  t->neigh_vars[i].data += (long) p;
>>                  t->neigh_vars[i].extra1 = dev;
>>                  t->neigh_vars[i].extra2 = p;
>>          }
>> ...
>> }
>>
>> static void neigh_proc_update(const struct ctl_table *ctl, int write)
>> {
>>          struct net_device *dev = ctl->extra1;
>>          struct neigh_parms *p = ctl->extra2;
>>          struct net *net = neigh_parms_net(p);
>>          int index = (int *) ctl->data - p->data;
>> ...
>> }
> Quick question: Do you have a systemic way of identifying these? Do you
> have a grep or awk scripts somewhere? I'm actually very interested in
> finding out what is the impact of this.
> 

Thanks, we may use the following simple scripts:

- the extra {1,2} as pointers to some objects:
$ grep "\.extra1\|\.extra2" * -R | grep -v "SYSCTL_" | grep -v "\&"

- the extra {1,2} as pointers to elements in the shared constant array:
$ grep "\.extra1\|\.extra2" * -R | grep "SYSCTL_"

- the extra {1,2} as pointers to additional constant variables:
$ grep "\.extra1\|\.extra2" * -R | grep "\&"


--
Best wishes,
Wen


> 
> 
>>
>>
>> So could we modify it in this way to make it compatible with these two
>> situations:
>>
>> @@ -137,8 +137,16 @@ struct ctl_table {
>>          umode_t mode;
>>          proc_handler *proc_handler;     /* Callback for text formatting */
>>          struct ctl_table_poll *poll;
>> -       void *extra1;
>> -       void *extra2;
>> +       union {
>> +               struct {
>> +                       void *extra1;
>> +                       void *extra2;
>> +               };
>> +               struct {
>> +                       unsigned long min;
>> +                       unsigned long max;
>> +               };
>> +       };
>>   } __randomize_layout;
>>
>>
>> --
>> Best wishes,
>> Wen
>>
> 

