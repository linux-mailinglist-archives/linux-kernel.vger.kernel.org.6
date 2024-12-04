Return-Path: <linux-kernel+bounces-431016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C29E382D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5928161D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC21B219C;
	Wed,  4 Dec 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="d6MIJPTd"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D081AF0AE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310204; cv=none; b=Mmxtwk2cSx01XbEbaaYnvBB9BEUIIlJA9eaiY84gb/sJhxxPMjUJWHcIV+d5n+U3wgN5Aa2xy+uVd0lFL5g5+eouwFcnQytJRYKy936d+fNi1oZGAwSERVcwZZVvqkKF7TSvnjeonmllyPNAdARVtGwhyDReQWY45CPg9cM6c/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310204; c=relaxed/simple;
	bh=HiRHBVxJRzJUX7pxKBAGHT2nWDVudw+euIZaibZo5IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OR8hGLoOwucLfaTtFrdr9cyrlF0GFhpS2O2vgS8BHf1pzpy/5SJjtPKNPBAyH31SJmzBu2kUCdulahRbVDodqL0CZ44PHwJoRAtdMXSlsyUmKDIfbGMGDSnMt1EIHYOEugloerq3wlPOKeXO4vVuLTST8XxLqHWymWf3gNHuBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=d6MIJPTd; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [172.18.100.99] ([109.238.20.116])
	by Aruba Outgoing Smtp  with ESMTPSA
	id In73tJdcv15fBIn73tOtCY; Wed, 04 Dec 2024 12:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1733310010; bh=HiRHBVxJRzJUX7pxKBAGHT2nWDVudw+euIZaibZo5IM=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=d6MIJPTd1wESepjIfn1rsvMfFycQ8XYJ41Tt5C80yo7813WA0VSFIgMwg24dQocIt
	 +Yfaf3xVSQBgb4Lcb0F+lel7N4JPtULvcn2t8a+j+85vY6yDfY8XzyPc84Dl4pQVNs
	 hYEKpKLUjqOLOMqJeaSjPuOfmhmRfswx6EXKTQpsLfxa0mf1jzGZCb4CPUcfGjyrbK
	 Kt4vF0NXgGUrE5ns9Uv2my20ha8mqeGDLmVkgwP7YUJMr7Quug743/pZ6CwDz+y0o3
	 cMznwljtclP7KaGPc1D+jSexnM1xiPDEbUZlA/Es/6L7R7KlZOcM6osgMBWEq/a3Iz
	 cYIMGPWc5D5kg==
Message-ID: <c32efa4a-287f-4ae4-bb3d-74b6e595dfc6@enneenne.com>
Date: Wed, 4 Dec 2024 12:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
Content-Language: en-US, it, it-IT
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
 <3612b36e-3350-4a5c-827e-482434753e95@enneenne.com>
 <973aa216-4932-4e21-b9a1-184ce809d483@bootlin.com>
 <956e2244-a95e-4c5e-a4a3-fb694c124739@enneenne.com>
 <39b78b3e-466c-4ab2-81a0-1633df48ef3e@bootlin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <39b78b3e-466c-4ab2-81a0-1633df48ef3e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHe4arRZRB1UwNwIpwNSITkquhqwPht+2KYw+VkfpSIC7ymUoPOn7QqvYwV/8C9DdsK4y6/v39FyEuZqyYadNzBnf2L/aeI/4yTOCPaYPosjKMs0qB3O
 /puXoYL76nxGh/gRJ2Tj9qRyHPdIkG165TjL9gJofXw2zkqE8bflXiW4WS33qqT+mWvKNpf5txJsjMxkXHigV6g0qyMLMkeliwSgCc7bAt6jdrl5uAkXuQh9
 3wpHdb/H1yYkA41MIDTSVNRrMbsLvuACFf2fB+oylAPtCZ/qKny8CPdYXoFZqAaRzCbqzmdGgo+vR4Nd+OE/JHljhxNiFupjsH6kKQK7ndNn5fWpgbuwG57Y
 twM1uoyXdy6Jli4AWCSfO/ykcrBu3WTU3sCUNo9eGov0Fa4o6Q7X7qIpppZV7FMTkC3h4MQOTwpwVQzX8XPSTnCDIegMEGankRb3YxXJhfMTet4R1W4=

On 04/12/24 11:34, Bastien Curutchet wrote:
> Hi Rodolfo,
> 
> I revive this topic.
> 
> On 6/26/24 4:16 PM, Rodolfo Giometti wrote:
>> On 26/06/24 14:55, Bastien Curutchet wrote:
>>> Hi Rodolfo
>>>
>>> On 4/25/24 14:42, Rodolfo Giometti wrote:
>>>> On 25/04/24 14:28, Bastien Curutchet wrote:
>>>>> In the IRQ handler, the GPIO's state is read to verify the direction of
>>>>> the edge that triggered the interruption before generating the PPS event.
>>>>> If a pulse is too short, the GPIO line can reach back its original state
>>>>> before this verification and the PPS event is lost.
>>>>>
>>>>> This check is needed when info->capture_clear is set because it needs
>>>>> interruptions on both rising and falling edges. When info- >capture_clear
>>>>> is not set, interruption is triggered by one edge only so this check can
>>>>> be omitted.
>>>>>
>>>>> Add a warning if irq_handler is left without triggering any PPS event.
>>>>> Bypass the edge's direction verification when info->capture_clear is not
>>>>> set.
>>>>>
>>>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>>>
>>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>>>
>>>
>>> I don't think I've received any updates since you acked this. Is there 
>>> something missing before the patch can be applied?
>>
>> No updates. It can be applied.
>>
> 
> In the MAINTAINER file, you are listed as the sole maintainer for the PPS 
> subsystem. Could you let me know if there's someone else in charge of applying 
> patches so I can gently ping them please ?
> 
> I checked, the patch still applies to v6.13-rc1

I was quite sure to have acked and then forwarded this patch to Greg and Andrew 
for the inclusion.

If not (I'm sorry), please resend the patch, and I'm going to pass it to Greg 
and Andrew right away.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


