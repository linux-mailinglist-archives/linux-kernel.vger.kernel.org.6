Return-Path: <linux-kernel+bounces-421679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C49D8E75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2033D2812DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B71CB31D;
	Mon, 25 Nov 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ZSyZ67OZ"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA1156F3A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573343; cv=none; b=CWtMrnwtMMnmMm3mygu2pGznwboH67gqAhXDPm18nXbE05V2WXScacamikh3ikJpMAgIdJMOUCy0ShQ8a5KTyWAzmLzaMPdYYOB95XRAL1BiBns208bg4+9F3w5f11J4Sso4epb3F7i0NnwSBtbZgdbmmVW4OG1O/207/jMH5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573343; c=relaxed/simple;
	bh=WAnc6ueCMCSt20HrwXxWpgNFZtSn1djB6/sdfn3FJsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlEgjZZRd1jkUiWxYISh6t/Rog07pXXRwmSQwG3mYyVikNmdjTbYMNIBV9wB2kV3OT4u2T0MMnqE5oVn30kUn8sTQHHh+a1bfkF4TegVzVxEac0mMQkDMW+N7wxz1sbucf0421pff9whqEmAlqN+shQulI1QUNdDSL1lBQBHtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=ZSyZ67OZ; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a1f:0:640:ba2e:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EEBD160B58;
	Tue, 26 Nov 2024 01:20:42 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b6b2::1:1d] (unknown [2a02:6b8:b081:b6b2::1:1d])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id dKgiYl2IcCg0-I7biPIeB;
	Tue, 26 Nov 2024 01:20:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1732573242;
	bh=ZqIB+iWzek3veLfNu7hxjtu3YlB1W0REJaTr2ObFX1M=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=ZSyZ67OZQEbndL0QyOpLaaz0JBBV9B+4/TVLOiChknZxG7A86Fw9UO8Spg2mHGkZl
	 WkVXF2DQhtcAuxTys4EtOblg1UkxMUpv9rcZkyFQpNn7qxkTFBcwEHLfXG8wiGmADK
	 bp94a9xHTA/lk8cmjPiHwJyVcDLhpnDgyFI3FpSI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <62ba9085-0872-4aab-8871-20d3720a5aee@yandex-team.ru>
Date: Tue, 26 Nov 2024 01:20:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] x86/split_lock: fix delayed detection enabling
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: den-plotnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
 x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de
References: <20241113142301.704057-1-davydov-max@yandex-team.ru>
 <afccb8f2-a376-266f-5477-493bbc5fb7d3@igalia.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <afccb8f2-a376-266f-5477-493bbc5fb7d3@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
Thanks a lot!
I've rebased onto the newest master
https://lore.kernel.org/lkml/20241125221147.932377-1-davydov-max@yandex-team.ru/

On 11/20/24 22:16, Guilherme G. Piccoli wrote:
> On 13/11/2024 11:23, Maksim Davydov wrote:
>> If the warn mode with disabled mitigation mode is used, then on each
>> CPU where the split lock occurred detection will be disabled in order to
>> make progress and delayed work will be scheduled, which then will enable
>> detection back. Now it turns out that all CPUs use one global delayed
>> work structure. This leads to the fact that if a split lock occurs on
>> several CPUs at the same time (within 2 jiffies), only one CPU will
>> schedule delayed work, but the rest will not. The return value of
>> schedule_delayed_work_on() would have shown this, but it is not checked
>> in the code.
>>
>> A diagram that can help to understand the bug reproduction:
>> https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/
>>
>> In order to fix the warn mode with disabled mitigation mode, delayed work
>> has to be a per-CPU.
>>
>> v3 -> v2:
>> * place and time of the per-CPU structure initialization were changed.
>>    initcall doesn't seem to be a good place for it, so deferred
>>    initialization is used.
>>
>> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
>> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
>> ---
>>   arch/x86/kernel/cpu/intel.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> 
> Hi Maksim, thanks for resubmitting again. I think that is indeed a valid
> fix, but what I've also noticed is that recently (as in this week) the
> code changed from the intel.c file to a more generic one, since AMD is
> enabling split lock detection in their CPUs apparently [0].
> 
> So, I'd suggest you to rebase against 6.13-rc, that would likely
> increase the chances of a merge. Once you do that, I can try to test it
> as well, though I don't personally have an Intel CPU with that feature
> (but some friends have it).
> 
> Cheers,
> 
> 
> Guilherme
> 
> 
> [0] https://lore.kernel.org/r/ZzuBNj4JImJGUNJc@gmail.com/

-- 
Best regards,
Maksim Davydov

