Return-Path: <linux-kernel+bounces-261526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE193B850
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CD2B24191
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776313BC31;
	Wed, 24 Jul 2024 21:01:05 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32113B5AD;
	Wed, 24 Jul 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854865; cv=none; b=XuaBDTAJgWE8OUinkvpLH2GUEfK91Z//Md4HV4nxJBP78VxbbxT/9qONI2nQdNtbNrXQ9iGjoYFp8/qYJ6kCVkDC/iIOjeyG4n8HxyX/Lm368o29cL02MTnAxSIGN+3JIdwY1S0UNqL8SsJpfOnbQFtsQTvAWqBZJaYBxqOrQI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854865; c=relaxed/simple;
	bh=D7vc7wOwIqD6t2vwgWyB3/foYAdWPEJEjuw2hg+H4xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWELURm9X9LWogEvxBoSV2GwRmAfAe/6T7B10VGJ8cPYhgguL+zkqR1fZRdh5HCjg90mDgjzak8dm0zeoTvFeBHwE+xJvpMcBMk/q8WUS0bZXOXsIMpghvsllAK3DWkzaPTdBmKdgfyA4bid4uSOgh9f3lHvbLw89t22F0KkEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af27a.dynamic.kabel-deutschland.de [95.90.242.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EE2B361E5FE06;
	Wed, 24 Jul 2024 23:00:42 +0200 (CEST)
Message-ID: <cee9630e-781e-49b1-82c5-9066552f71b1@molgen.mpg.de>
Date: Wed, 24 Jul 2024 23:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset
 recovery time
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
 <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>
 <f1e2e2b1-b83c-4105-b62c-a053d18c2985@molgen.mpg.de>
 <3d3416cd-167f-4c50-972b-0eb376a13fdf@rowland.harvard.edu>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <3d3416cd-167f-4c50-972b-0eb376a13fdf@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alan,


Am 24.07.24 um 20:52 schrieb Alan Stern:
> On Wed, Jul 24, 2024 at 08:14:34PM +0200, Paul Menzel wrote:

[…]

>> Am 24.07.24 um 16:10 schrieb Alan Stern:
>>> On Wed, Jul 24, 2024 at 01:15:23PM +0200, Paul Menzel wrote:
>>>> This basically reverts commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
>>>> ("[PATCH] USB: relax usbcore reset timings") from 2005.
>>>>
>>>> This adds unneeded 40 ms during resume from suspend on a majority of
>>>
>>> Wrong.  It adds 40 ms to the recovery time from a port reset -- see the
>>> commit's title.  Suspend and resume do not in general involve port
>>> resets (although sometimes they do).
>>
>> It looks like on my system the ports are reset:
>>
>> ```
>> $ grep suspend-240501-063619/hub_port_reset abreu_mem_ftrace.txt
>>   6416.257589 |   3)  kworker-9023  |               | hub_port_reset [usbcore]() {
>>   6416.387182 |   2)  kworker-9023  |   129593.0 us |                  } /* hub_port_reset [usbcore] */
> 
>> ```
> 
> It depends on the hardware and the kind of suspend.

It is ACPI S3 suspend. Can I find out, why the ports are reset? Not 
resetting the ports would be even better to reduce the resume time.

>>>> devices, where it’s not needed, like the Dell XPS 13 9360/0596KF, BIOS
>>>> 2.21.0 06/02/2022 with
>>>
>>>> The commit messages unfortunately does not list the devices needing this.
>>>> Should they surface again, these should be added to the quirk list for
>>>> USB_QUIRK_HUB_SLOW_RESET.
>>>
>>> This quirk applies to hubs that need extra time when one of their ports
>>> gets reset.  However, it seems likely that the patch you are reverting
>>> was meant to help the device attached to the port, not the hub itself.
>>> Which would mean that the adding hubs to the quirk list won't help
>>> unless every hub is added -- in which case there's no point reverting
>>> the patch.
>>>
>>> Furthermore, should any of these bad hubs or devices still be in use,
>>> your change would cause them to stop working reliably.  It would be a
>>> regression.
>>>
>>> A better approach would be to add a sysfs boolean attribute to the hub
>>> driver to enable the 40-ms reset-recovery delay, and make it default to
>>> True.  Then people who don't need the delay could disable it from
>>> userspace, say by a udev rule.
>>
>> How would you name it?
> 
> You could call it "long_reset_recovery".  Anything like that would be
> okay.

Would it be useful to makes it an integer instead of a boolean, and 
allow to configure the delay: `extra_reset_recovery_delay_ms`?


Kind regards,

Paul

