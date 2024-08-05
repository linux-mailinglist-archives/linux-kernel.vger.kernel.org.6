Return-Path: <linux-kernel+bounces-274348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F494770F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4116DB21A33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07E14D6ED;
	Mon,  5 Aug 2024 08:19:51 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39814AD10;
	Mon,  5 Aug 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845990; cv=none; b=XSxOaAS0O8+HnS+2avKg03/neCFxQs55OdcOFPCWlarr+bImz0T6JX204uIvCPlCtwalumUxtgPyZLFgRdtjZMawKH/4EpWinxO4sMCA2pLPXwardcYRPlDJxf7ir8VrW1msVFWaFF2aeMwuPT1ER/rzY8HT2dnkyy3Yl3ZTeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845990; c=relaxed/simple;
	bh=IIfmNDKo2Co1Mn/8N5ntMyacDCWZYQAxUOR2ChZg02M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFzR2Wj4Chyod8aTToThW3qpKjXD2xYsHiCwgMkjPSHwYbvlUFpHTKDA+kVzdZbsBH6pLzLYplmEkhmDJPnZOYCOuLOO4+35yKehtv9PGKFJPumVW/eySM75T5tyxQ4HRCcNenT6oOopO6m3/eJhKL0PHVyNntRHxbsPeAadJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeb3c.dynamic.kabel-deutschland.de [95.90.235.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BB1461E5FE01;
	Mon,  5 Aug 2024 10:19:18 +0200 (CEST)
Message-ID: <7eef194d-17df-4681-95aa-be6ec09b5929@molgen.mpg.de>
Date: Mon, 5 Aug 2024 10:19:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset
 recovery time
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alan Stern <stern@rowland.harvard.edu>,
 Nicolas Boichat <drinkcat@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
 <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>
 <f1e2e2b1-b83c-4105-b62c-a053d18c2985@molgen.mpg.de>
 <3d3416cd-167f-4c50-972b-0eb376a13fdf@rowland.harvard.edu>
 <cee9630e-781e-49b1-82c5-9066552f71b1@molgen.mpg.de>
 <8e300b0b-91f8-4003-a1b9-0f22869ae6e1@rowland.harvard.edu>
 <712dee24-e939-4b1b-b2ea-0c0c12891a62@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <712dee24-e939-4b1b-b2ea-0c0c12891a62@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[To: +Nicolas, Cc: -Heikki]


Dear Alan, dear Nicolas,


Am 04.08.24 um 09:15 schrieb Paul Menzel:

> Am 26.07.24 um 19:48 schrieb Alan Stern:
>> On Wed, Jul 24, 2024 at 11:00:42PM +0200, Paul Menzel wrote:
> 
>>> Am 24.07.24 um 20:52 schrieb Alan Stern:
>>>> On Wed, Jul 24, 2024 at 08:14:34PM +0200, Paul Menzel wrote:
>>>
>>> […]
>>>
>>>>> Am 24.07.24 um 16:10 schrieb Alan Stern:
>>>>>> On Wed, Jul 24, 2024 at 01:15:23PM +0200, Paul Menzel wrote:
>>>>>>> This basically reverts commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
>>>>>>> ("[PATCH] USB: relax usbcore reset timings") from 2005.
>>>>>>>
>>>>>>> This adds unneeded 40 ms during resume from suspend on a majority of
>>>>>>
>>>>>> Wrong.  It adds 40 ms to the recovery time from a port reset -- see the
>>>>>> commit's title.  Suspend and resume do not in general involve port
>>>>>> resets (although sometimes they do).

[…]

>>>>>>> devices, where it’s not needed, like the Dell XPS 13 9360/0596KF, 
>>>>>>> BIOS 2.21.0 06/02/2022 with
>>>>>>
>>>>>>> The commit messages unfortunately does not list the devices 
>>>>>>> needing this.
>>>>>>> Should they surface again, these should be added to the quirk 
>>>>>>> list for
>>>>>>> USB_QUIRK_HUB_SLOW_RESET.
>>>>>>
>>>>>> This quirk applies to hubs that need extra time when one of their 
>>>>>> ports
>>>>>> gets reset.  However, it seems likely that the patch you are 
>>>>>> reverting
>>>>>> was meant to help the device attached to the port, not the hub 
>>>>>> itself.
>>>>>> Which would mean that the adding hubs to the quirk list won't help
>>>>>> unless every hub is added -- in which case there's no point reverting
>>>>>> the patch.
>>>>>>
>>>>>> Furthermore, should any of these bad hubs or devices still be in use,
>>>>>> your change would cause them to stop working reliably.  It would be a
>>>>>> regression.
>>>>>>
>>>>>> A better approach would be to add a sysfs boolean attribute to the 
>>>>>> hub
>>>>>> driver to enable the 40-ms reset-recovery delay, and make it 
>>>>>> default to
>>>>>> True.  Then people who don't need the delay could disable it from
>>>>>> userspace, say by a udev rule.
>>>>>
>>>>> How would you name it?
>>>>
>>>> You could call it "long_reset_recovery".  Anything like that would be
>>>> okay.
>>>
>>> Would it be useful to makes it an integer instead of a boolean, and 
>>> allow to configure the delay: `extra_reset_recovery_delay_ms`?
>>
>> Sure, why not?  Just so long as the default value matches the current
>> behavior.
> 
> I hope, I am going to find time to take a stab at it.

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..72dd16eaa73a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -120,9 +120,16 @@ MODULE_PARM_DESC(use_both_schemes,
                 "try the other device initialization scheme if the "
                 "first one fails");

+static int extra_reset_recovery_delay_ms = 40;
+module_param(extra_reset_recovery_delay_ms, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(extra_reset_recovery_delay_ms,
+               "extra recovery delay for USB devices after reset in 
milliseconds "
+               "(default 40 ms");
+
  /* Mutual exclusion for EHCI CF initialization.  This interferes with
   * port reset on some companion controllers.
   */
+
  DECLARE_RWSEM(ehci_cf_port_reset_rwsem);
  EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);

@@ -3110,7 +3117,7 @@ static int hub_port_reset(struct usb_hub *hub, int 
port1,
                         usleep_range(10000, 12000);
                 else {
                         /* TRSTRCY = 10 ms; plus some extra */
-                       reset_recovery_time = 10 + 40;
+                       reset_recovery_time = 10 + 
extra_reset_recovery_delay_ms;

                         /* Hub needs extra delay after resetting its 
port. */
                         if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)

The if condition above

		if (port_dev->quirks & USB_PORT_QUIRK_FAST_ENUM)
			usleep_range(10000, 12000);

is from Nicholas’ commit aa071a92bbf0 (usb: hub: Per-port setting to 
reduce TRSTRCY to 10 ms) from 2018 [2] adding the port quirk 
`USB_PORT_QUIRK_FAST_ENUM`.

> urrently, the USB hub core waits for 50 ms after enumerating the
> device. This was added to help "some high speed devices" to
> enumerate (b789696af8 "[PATCH] USB: relax usbcore reset timings").
> 
> On some devices, the time-to-active is important, so we provide
> a per-port option to reduce the time to what the USB specification
> requires: 10 ms.

Nicholas, do you have field data from ChromeOS if the 40 ms delay is 
needed, and do you apply the quirk to all ports?

Being ignorant about USB in general, does this quirk make my patch 
obsolete, or should I just send a patch with the diff above?


Kind regards,

Paul


> [1]: https://lore.kernel.org/all/f1e2e2b1-b83c-4105-b62c-a053d18c2985@molgen.mpg.de/
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa071a92bbf09d993ff0dbf3b1f2b53ac93ad654

