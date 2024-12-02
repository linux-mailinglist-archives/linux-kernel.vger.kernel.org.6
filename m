Return-Path: <linux-kernel+bounces-427637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58F9E0460
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D740B28D95
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BB1FF7C2;
	Mon,  2 Dec 2024 13:52:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE579EA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147576; cv=none; b=beDLvas01D7kfc58x0sIDU1r8ftTtoma6R4B2otSDo8xgSh5L17avEz6cKzLxpoW9PSUkN4iVkM0tHI6REwUAWBMS0c4NXFMFMF4jPskiNexCK0uhqSIa2wBaV/+c/zrO4RMgmw+cu7Qm6X41vIljPxWSzDvA+qrMCpl/Hj3mIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147576; c=relaxed/simple;
	bh=/vYsJHI9CuPDtXQ/XxKYlO1C14RTfWm6TWI6cI62aA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nB6S1bcjwts5ViisZh4XpF0pbvHrDLfsmyv1rIEM4xrmByYPESnAOujAkt2uzI+40bTqhnk/XqVN+H5xalw+ygG3KRkNEE/N5hc2Rar9cD4f9yilTHrO9zcDIfvgJHcMc8UVn2+xanvfvpYe6v+3J9150Z45AGxJZELFzFcwY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61631007;
	Mon,  2 Dec 2024 05:53:20 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79B303F58B;
	Mon,  2 Dec 2024 05:52:50 -0800 (PST)
Message-ID: <e97196fe-3ab2-4ad5-ba88-e7f635fbf957@arm.com>
Date: Mon, 2 Dec 2024 14:52:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Luis Machado <luis.machado@arm.com>
Cc: Mike Galbraith <efault@gmx.de>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, pauld@redhat.com
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
 <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
 <dacfbe5d-a730-4643-90a8-1c38cb6780da@arm.com>
 <CAKfTPtAmidDzBRE7UGqodaVfyge1M9D0Q8M_EX2ojqYW2Y8V=A@mail.gmail.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAmidDzBRE7UGqodaVfyge1M9D0Q8M_EX2ojqYW2Y8V=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 10:59, Vincent Guittot wrote:
> On Mon, 2 Dec 2024 at 10:23, Luis Machado <luis.machado@arm.com> wrote:
>>
>> On 12/2/24 09:17, Vincent Guittot wrote:
>>> On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
>>>>
>>>> Greetings,
>>>>
>>>> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:

[...]

>>>>> h_nr_runnable is used in several places to make decision on load balance:
>>>>>   - PELT runnable_avg
>>>>>   - deciding if a group is overloaded or has spare capacity
>>>>>   - numa stats
>>>>>   - reduced capacity management
>>>>>   - load balance between groups
>>>>
>>>> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
>>>> runnable seems to have an off-by-one issue, causing it to wander ever
>>>> further south.
>>>>
>>>> patches 1-3 applied.
>>>>   .h_nr_runnable                 : -3046
>>>>   .runnable_avg                  : 450189777126
>>>
>>> Yeah, I messed up something around finish_delayed_dequeue_entity().
>>> I'm' going to prepare a v3>
>>
>> Maybe something similar to what I ran into here?
>>
>> https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/
> 
> I'm going to have a look

Looks like this is not an issue anymore since commit 98442f0ccd82
("sched: Fix delayed_dequeue vs switched_from_fair()") removed
finish_delayed_dequeue_entity() from switched_from_fair() in the meantime.

[...]

