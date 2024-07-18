Return-Path: <linux-kernel+bounces-256423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE6934E40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE651C22813
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008513D61D;
	Thu, 18 Jul 2024 13:34:58 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3A9457
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309697; cv=none; b=euNBCRhP731OzL8gSkKSaXT9LnvTXdrg5i0U/2omNM8K/sTdsnM0R0uNErYRNKijVBQ4jiXwH0/6h7MYjdpdf/vkU9rHtg32XXbihAeDX7++bTnO11+d89p9i1if5TYlGHQDEI9i8DpBAkyCbuoui27z6J6vO1au74vnFYGc6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309697; c=relaxed/simple;
	bh=cFNPczviUxJcSbvgbgQOvyWdFe6cNoyDRRjhKGcybaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF2gE7/+DP6Sz2htmAbQNymWF7LCE7tRaRgYyF97Q+zS/hO51tCTs3izxZ0tl9jeEVbrAT6+I4M3ZNenUUo6hbluICm9xhf6R7em9SG7ebg0nZLhB6HQwLpQhpgtH3B6U2Kwp0I5H9NAUrcRTWhCW8SRcHz5J7a7E8jVyWQe4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46IDYOlP036881;
	Thu, 18 Jul 2024 22:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 18 Jul 2024 22:34:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46IDYOiB036878
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 18 Jul 2024 22:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bef0612c-df79-4478-8704-68d07cff46b5@I-love.SAKURA.ne.jp>
Date: Thu, 18 Jul 2024 22:34:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in kobject_put /
 kobject_uevent_env (2)
To: Greg KH <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>
Cc: syzbot <syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000381fbb061d81bd85@google.com>
 <CANpmjNPzw1=_VDfMDskrKWiabLV1aZVC1VeThLZTDn=qWMUsZQ@mail.gmail.com>
 <2024071845-breach-dripping-a1e5@gregkh>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2024071845-breach-dripping-a1e5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/18 20:09, Greg KH wrote:
> On Thu, Jul 18, 2024 at 12:38:05PM +0200, Marco Elver wrote:
>> The two racing accesses here (on bitfield variables
>> kobj->state_remove_uevent_sent, kobj->state_initialized) are in the
>> same bitfield. There's no guarantee (by the compiler) that while the
>> bitfield is being updated the bit at kobj->state_initialized will
>> remain non-zero, and therefore the WARN in kobject_put() could be
>> triggered. This appears benign, unless of course someone set
>> panic_on_warn.
>>
>> More generally, if the bitfield is updated concurrently, it's very
>> likely that one of the updates would be lost.
>>
>> Just my initial observation.
> 
> Thanks for the review, I'll try to carve out some time next week to
> knock up a patch for this...

Unless it is proven that these

	unsigned int state_initialized:1;
	unsigned int state_in_sysfs:1;
	unsigned int state_add_uevent_sent:1;
	unsigned int state_remove_uevent_sent:1;
	unsigned int uevent_suppress:1;

fields are never modified concurrently, just marking this "unsigned int" as
__data_racy is wrong.

When we hit unprotected bitmask modification bug at
https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
we fixed the race by converting to test_bit()/set_bit()/clear_bit().


