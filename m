Return-Path: <linux-kernel+bounces-197995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B788D71C5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360671C20B19
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B5154C04;
	Sat,  1 Jun 2024 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPbz4eHU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0A1D555
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717272361; cv=none; b=seUhMk0TIKL020y+f0ixJDHVDB/w99whA9KPAqygUEuEKiquJ/RflX9KhQQRix+/iuCpqv5SfHMLtnL8Nv/OkhrosaCCKE8d8yTqZ208q7wSPK5OFuT7Ie1DG0CIPNwivGa4QVd0lKOoVzyAXLc8Kt+fkrsZVkLhh1piydSniM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717272361; c=relaxed/simple;
	bh=bb1Eh6sYxp0wiXwMLIgdauY1kNYKOWwZ0sTYj+x+3i4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UswREWUCXqMVTWqGJPIymnVaJT+VhBQZkwgmsA4otUB20dz8c2OAQGZDbcwxqYsQwfYi0fUoppg0PRpqeXUBMgRktqSWaJV/blKOOyAoglFv4eAw6SIHfnCbP9qJV5h8zE6EHKmDaS81nhFQFcUdGvgiNxw2ObXhcoAUQznXzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPbz4eHU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717272358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzxohq/lDop4X+G5bOl0wtRNygcADEx/hc58/q+dn7c=;
	b=SPbz4eHUVezLvTCm99v6uKgqt4dbGyx9fq+sCFd1nbREuKmoGKSz1Jl3oqDuX22H4OnhE0
	6dWjSbuMfUxgJwC4XJW/3QA5nwO+fNQXKJUyBVJdaDLopMsmlQCp4rNvGyXmnzYRivvAZt
	w2fINPg1UeFvxoTFJfSVgkey5pYbnDw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-uOItLCLfOWiboiv4ZHoCTA-1; Sat, 01 Jun 2024 16:05:57 -0400
X-MC-Unique: uOItLCLfOWiboiv4ZHoCTA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a592c35ac06so251777666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 13:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717272356; x=1717877156;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzxohq/lDop4X+G5bOl0wtRNygcADEx/hc58/q+dn7c=;
        b=Fn2tLs7wjbWPIpqhDG6v4W7bDHTIJXD3MW4naA1Bvdne3Y0+q0MhyLHmESSBY93UTB
         egwIjXdydhN/rRvxMHlQi8njLbjvggfuzvxWNSRYEyJciMFSdLlBqS2vRgzzEg+WvMZt
         BkWm1Ce7FF+wosfeS173N3gkDm7Oi2w30Y5c+yK+7AjHdWp0zp2q+N8Bhj7GZAZN2BDa
         Kp+cvRU5v0BPMz50JPlpzl/D/i31PCCkFWzSQVmKQpEYsOK6udTtEPzAT7K3DwPo2eiZ
         WKrAaQ01Ixe1YUeyDFIPWRMKEqs9btGugPta4J9cQh32RkPt3bEGkiNSFCY7wJqXuk4q
         HM3A==
X-Gm-Message-State: AOJu0YxoflQVGN5nQpgNuwsLPScGyuceOktgnrwmSBPwJioEA42qYUYw
	Z6jCD0I24o+SIWiwIkT7eem7FREVbLttOz/dUmbdERpxdJPk+L1DB/vJIe55gAwbn58zqI8KWlH
	NrS6BY75CsRAGzwlm9PGyv4jYkbeBzcGOAWL9QVftsA2v2bg1nQWufUVAiEbNNg==
X-Received: by 2002:a17:906:5a8c:b0:a68:e834:e9bb with SMTP id a640c23a62f3a-a68e834ff24mr25611866b.35.1717272355879;
        Sat, 01 Jun 2024 13:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKBjI4khq4cOxujM+nFtg2T6bx0NqxvdpUtcJC72aKWj08HWBrV5C0F9kUUcWZtUreaiC0mQ==
X-Received: by 2002:a17:906:5a8c:b0:a68:e834:e9bb with SMTP id a640c23a62f3a-a68e834ff24mr25609766b.35.1717272355320;
        Sat, 01 Jun 2024 13:05:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6848423bc9sm210815066b.147.2024.06.01.13.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 13:05:54 -0700 (PDT)
Message-ID: <d7c555cc-d07c-4f22-9636-9ebb44165e1d@redhat.com>
Date: Sat, 1 Jun 2024 22:05:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hung tasks due to a AB-BA deadlock between the leds_list_lock
 rwsem and the rtnl mutex
From: Hans de Goede <hdegoede@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Linux LEDs <linux-leds@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, johanneswueller@gmail.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Genes Lists <lists@sapience.com>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
 <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
 <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
 <42d498fc-c95b-4441-b81a-aee4237d1c0d@leemhuis.info>
 <618601d8-f82a-402f-bf7f-831671d3d83f@redhat.com>
 <d8f8b1b2-1ffd-435a-8bed-b1a05d16a270@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <d8f8b1b2-1ffd-435a-8bed-b1a05d16a270@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 5/31/24 12:22 PM, Hans de Goede wrote:
> Hi,
> 
> On 5/31/24 11:50 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 5/31/24 10:39 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> [adding the LED folks and the regressions list to the list of recipients]
>>>
>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>> for once, to make this easily accessible to everyone.
>>>
>>> Lee, Pavel, could you look into below regression report please? Thread
>>> starts here:
>>> https://lore.kernel.org/all/9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com/
>>>
>>> Another report with somewhat similar symptom can be found here:
>>> https://lore.kernel.org/lkml/e441605c-eaf2-4c2d-872b-d8e541f4cf60@gmail.com/
>>>
>>> See also Russell's analysis of that report below (many many thx for
>>> that, much appreciated Russel!).
>>>
>>> To my untrained eyes all of this sounds a lot like we still have a 6.9
>>> regression related to the LED code somewhere. Reminder, we had earlier
>>> trouble, but that was avoided through other measures:
>>>
>>> * 3d913719df14c2 ("wifi: iwlwifi: Use request_module_nowait") /
>>> https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
>>>
>>> * c04d1b9ecce565 ("igc: Fix LED-related deadlock on driver unbind") /
>>> https://lore.kernel.org/all/ZhRD3cOtz5i-61PB@mail-itl/
>>>
>>> * 19fa4f2a85d777 ("r8169: fix LED-related deadlock on module removal")
>>>
>>> That iwlwifi commit even calls it self "work around". The developer that
>>> submitted it bisected the problem to a LED merge, but sadly that was the
>>> end of it. :-/
>>
>> I actually have been looking at a ledtrig-netdev lockdep warning yesterday
>> which I believe is the same thing. I'll include the lockdep trace below.
>>
>> According to lockdep there indeed is a ABBA (ish) cyclic deadlock with
>> the rtnl mutex vs led-triggers related locks. I believe that this problem
>> may be a pre-existing problem but this now actually gets hit in kernels >=
>> 6.9 because of commit 66601a29bb23 ("leds: class: If no default trigger is
>> given, make hw_control trigger the default trigger"). Before that commit
>> the "netdev" trigger would not be bound / set as phy LEDs trigger by default.
>>
>> +Cc Heiner Kallweit who authored that commit.
>>
>> The netdev trigger typically is not needed because the PHY LEDs are typically
>> under hw-control and the netdev trigger even tries to leave things that way
>> so setting it as the active trigger for the LED class device is basically
>> a no-op. I guess the goal of that commit is correctly have the triggers
>> file content reflect that the LED is controlled by a netdev and to allow
>> changing the hw-control mode without the user first needing to set netdev
>> as trigger before being able to change the mode.
>>
>> But there is a price to this, besides the locking problem this also
>> causes the ledtrig-netdev module to load on pretty much everyones
>> systems (when build as a module) even though 99.999% of our users
>> likely does not need this at all...
>>
>> Given this price and the troubles this is causing I think it might be best
>> to revert 66601a29bb23. There might still be a locking issue when setting
>> the trigger to netdev manually (I'll check and follow up) but this should
>> fix the regression users are hitting since typically users do not set
>> the trigger manually.
> 
> Ok, I can confirm that the lockdep warning is gone for me with 66601a29bb23
> reverted. Unfortunately it does still happen after a "modprobe ledtrig_netdev"
> (to add it to the list of available triggers) and then setting the trigger
> for /sys/class/leds/enp42s0-0::lan to netdev manually.
> 
> Still reverting 66601a29bb23 should avoid the problem getting triggered
> and this would seem like a safe fix especially for the 6.9 series and
> then the necessary time can be taken to fix the actual underlying locking
> issue which 66601a29bb23 exposes.

I recently wrote a new input-events LED trigger:
https://lore.kernel.org/linux-leds/20240531135910.168965-2-hdegoede@redhat.com/

and I just found out this has a very similar deadlock problem. It seems
there it a generic problem with LEDs or LED triggers getting registered
by subsystems while holding a global lock from that subsystem vs
the activate / deactivate method of the trigger calling functions of that
same subsystem which require that same global lock.

I came up with a fix but that just fixed the activate() path leaving
a similar deadlock in place in the deactivate path:

https://lore.kernel.org/linux-leds/20240601195528.48308-1-hdegoede@redhat.com/
https://lore.kernel.org/linux-leds/20240601195528.48308-3-hdegoede@redhat.com/

So this seems to be a non trivial problem to solve. For the new input-events
trigger I plan to solve this by switching to a single input_handler which will
be registered at module_init() time instead of having a handler per LED and
registering that handler at activate() time.

But I have no idea how to solve this for the netdev trigger I just wanted
to share my experience with the input-events trigger in case it is useful.

Regards,

Hans



