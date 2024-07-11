Return-Path: <linux-kernel+bounces-249402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A314192EB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247051F224F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920EA16A95A;
	Thu, 11 Jul 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdiNn2fj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004115D5D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710210; cv=none; b=EC9NjobpPyXIyu7yY/5Sh4g+ljhsTud2GdQgBpVAJgaIEJAGpa+tQ1iiMmDbos9djilLDsRzgowa+wfyacf57Xyz9Xob8f1h9Ofvn1+rbpHaBA4/BukvtwMi27iax14Jj3ww2Fq/M63+mZ93KYCfPNQIT2w+MMkbnzPpZdsQhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710210; c=relaxed/simple;
	bh=oLbC9uCugqInfyfcfBh1KESCh9DNMWsmJLHcXIg1LN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz+BeeqhCGY9QWnws3uswPMZyiUoTHiYsoz9yvFXgn505Ir6U894mUYa6Kfm/cY7Rlv/Jf/cAe/Pu/VaJ1O4yEt2neHdJhsyEra3wvz2DNAKqnteHvYbzjmNbiv1KothQa0YPk5Sa4oBWxRsEe+hX9cfAXArY7wgjKVt0/MY6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdiNn2fj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoAvnNTF+Xf8gm58BhGyfpIw9BMY8EgJeUlCS4SuWZg=;
	b=NdiNn2fjU5lezWJNiJx9rTW+NFE957LSedGEmQz4JIOB17lmz21T6bxQBq1yyOkPizWjq4
	ME4vp+O4RtwQoZQN3f/We++PFvpxO4B/cE4t3AZbPYeT5DXt2gN4oX0P50NRlYge8QBAtS
	mZrCP0m425O8GSZb4SWQiQI5PEhTZ6g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-YXstYHobMLCg7RTrk5tMpA-1; Thu, 11 Jul 2024 11:03:26 -0400
X-MC-Unique: YXstYHobMLCg7RTrk5tMpA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77de2c6583so78268166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710202; x=1721315002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoAvnNTF+Xf8gm58BhGyfpIw9BMY8EgJeUlCS4SuWZg=;
        b=Z7kjLFgGvvsOciAvceKLI7qIXXVNcJk3PRCJx9b/P7keMzMayaSeNmZiP2Wg0B9IUw
         l2BMbrY3o763hqirUkYqmpEAQCTTsq5Wpkc7Xs88j+CXffO2xMa2ZCn2alFawLa7vWfj
         mI+PtiXfYYQkYxqgvRBJgHJzdrL2JxZCe0wGz7e/d9bHdLBZeyccmBWiH/elUm7fNkPX
         VyQ0tdLqNQpz2gOSPQjSCES2uuCT5tTYScsdnNejQFdFXL7wuS4dae2isTlW8wM8hCz4
         UK0i12yYdVugqziC+z/8Zfv/qE85YOi1BhKPtp3BCWElRDpxUHYdxlxKD6AxaxZm7Zw0
         eI5w==
X-Gm-Message-State: AOJu0YzQ1KPgGu1dn+119/Dtt3Gz5w3rfsGfJT5EpqGPgT/mPeIE1zkA
	80A0sSOKDQsNFAZqLkDVnh1r67WGz7Oex6W/b5e/7Hhf4l1qBgUSVG1WrpYiA3vWn5D/qjbu/tN
	7Om0RCmRuGmj0qvX0C07LdKY7qy4RpaQUdvxyjCLiz7ug2mx2xUwVfejhOehyd8m6d0DWStxb
X-Received: by 2002:a17:906:230d:b0:a77:e55a:9e8c with SMTP id a640c23a62f3a-a780b87f101mr525980966b.47.1720710202136;
        Thu, 11 Jul 2024 08:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNYYrEm4vvD9J6b8E2x4gCTEIXXuDBaavxqhzJ9M4nEB7Yow3KpFuaVPy3QYYZjUBb9Hmrw==
X-Received: by 2002:a17:906:230d:b0:a77:e55a:9e8c with SMTP id a640c23a62f3a-a780b87f101mr525978466b.47.1720710201701;
        Thu, 11 Jul 2024 08:03:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a87200dsm261056566b.198.2024.07.11.08.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:03:21 -0700 (PDT)
Message-ID: <15ea35e7-21aa-4c27-8261-e0727375ff16@redhat.com>
Date: Thu, 11 Jul 2024 17:03:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 mustafa.eskieksi@gmail.com, pavel@ucw.cz,
 platform-driver-x86@vger.kernel.org, rishitbansal0@gmail.com,
 wse@tuxedocomputers.com
References: <473d8897-7b97-4175-b171-42fd2c8de0d6@redhat.com>
 <20240707172000.19723-1-carlosmiguelferreira.2003@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240707172000.19723-1-carlosmiguelferreira.2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carlos,

On 7/7/24 7:20 PM, Carlos Ferreira wrote:
> Hi, sorry for the (big) delay

No worries. I'm happy that you have managed to make some time
now to look further into this.

>> Hi Carlos,
>>
>> On 3/24/24 7:05 PM, Carlos Ferreira wrote:
>>> Added support for 4 zone keyboard rgb on omen laptops.
>>>
>>> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
>>
>> Thank you for your patch and sorry for being slow with replying to this.
>>
>> There actually already was a previous attemp to add support for
>> the 4 zone keyboard to hp-wmi by Rishit Bansal:
>>
>> https://lore.kernel.org/platform-driver-x86/20230131235027.36304-1-rishitbansal0@gmail.com/
>>
>> As discussed there we really want to define a new standardized
>> userspace API for the backlight functionality of these zoned
>> RGB keyboards. Using driver specific sysfs attributes for this
>> is undesirable, since that will never get wide support in userspace.
>>
>> OTOH if we define and document a new standard userspace API for this
>> then hopefully standard userspace stacks like KDE and GNOME will
>> eventually get support for this and then for the next zoned rgb
>> keyboard things will just work using the new standard API once
>> kernel support is merged.
>>
>> I realize that using a single LED class device with kbd_backlight
>> in the name to tap into the existing userspace support to at least
>> control the overall backlight brightness is useful and tempting but
>>
>> IMHO this really is a case where we need a new userspace API and then
>> emulating just a single brightness control for compatilbility with
>> existing userspace UI code can be done in powerdevil (KDE) or
>> upower (GNOME and others) in combination with offereing a more
>> complete DBUS API to also allow controlling the zones separately.
>>
> 
> That makes sense. I should post my first implementation using the
> multicolor led api soon.

I see that you already have done that, thank you.

>> Recently another (laptop) driver for Casper Excalibur laptops has
>> been posted and this also include support for a 4 zone rgb keyboard:
>> https://lore.kernel.org/platform-driver-x86/20240324181201.87882-2-mustafa.eskieksi@gmail.com/
>>
>> This driver actually already implements the userspace API proposed in
>> the discussion surrounding the earlier "[PATCH V3] platform/x86: hp-wmi:
>> Support omen backlight control wmi-acpi methods" patch.
>>
>> This driver creates 4 LED class devices using the multi-color LED API
>> for RGB. One LED class device per zone. These are named:
>>
>> casper:rgb:kbd_zoned_backlight-right
>> casper:rgb:kbd_zoned_backlight-middle
>> casper:rgb:kbd_zoned_backlight-left
>> casper:rgb:kbd_zoned_backlight-corners
>>
>> Where as for the HP laptop case I believe the 4 multi-color LED
>> class devices should have the following names since the zones
>> are different:
>>
>> hp:rgb:kbd_zoned_backlight-main
>> hp:rgb:kbd_zoned_backlight-wasd
>> hp:rgb:kbd_zoned_backlight-cursor
>> hp:rgb:kbd_zoned_backlight-numpad
>>
> 
> For this driver i think it should be something more like this:
> 
> hp:rgb:kbd_zoned_backlight-right
> hp:rgb:kbd_zoned_backlight-middle
> hp:rgb:kbd_zoned_backlight-left
> hp:rgb:kbd_zoned_backlight-wasd

Ok that sounds good.

>> As I mentioned in my review of the Casper Excalibur laptop driver
>> as part of adding support for these zoned rgb keyboards to various
>> laptop vendor specific drivers we should also document how these
>> devices are presented to userspace:
>>
>> A separate patch needs to be written to add documentation about
>> the use of these names for zoned RGB backlit kbds in a new paragraph /
>> subsection of the "LED Device Naming" section of:
>>
>> Documentation/leds/leds-class.rst 
>>
>> And this should document at least the 2 currently known
>> zone sets:
>>
>> :rgb:kbd_zoned_backlight-right
>> :rgb:kbd_zoned_backlight-middle
>> :rgb:kbd_zoned_backlight-left
>> :rgb:kbd_zoned_backlight-corners
>>
>> :rgb:kbd_zoned_backlight-main
>> :rgb:kbd_zoned_backlight-wasd
>> :rgb:kbd_zoned_backlight-cursor
>> :rgb:kbd_zoned_backlight-numpad
>>
>> with a comment that in the future different zone names are possible
>> if keyboards with a different zoning scheme show up.
>>
>> Perhaps you can work together with Mustafa on writing a patch for:
>> Documentation/leds/leds-class.rst ?
>>
> 
> I am open to it if it was not done yet. But could you please
> be a bit more specific about what exactly
> needs to be documented about my patch?
> Zone names, brightness control, userspace interaction?

Brightness control is part of the standard sysfs LED class API:

Documentation/ABI/testing/sysfs-class-led
Documentation/ABI/testing/sysfs-class-led-multicolor

So that is already documented and those files also specify
userspace interaction. 

So what needs to be documented is the existing practice
of using foo::kbd_backlight as sysfs LED class-device name for
keyboards with a single brightness / color setting. As well as
documenting the new API + naming for zoned RGB keyboards.

So basically add a new "Keyboard backlight control"
section to:

Documentation/leds/leds-class.rst

Under the "LED Device Naming" section with as contents e.g.:

"""
For backlit keyboards with a single brightness / color settings a
single (multicolor) LED device should be used to allow userspace
to change the backlight brightness (and if possible the color). 
This LED device must have a name ending in ':kbd_backlight'.

For RGB backlit keyboards with multiple control zones one multicolor
LED device should be used per zone. These LED devices' name
must follow the following form:

	"<devicename>:rgb:kbd_zoned_backlight-<zone_name>"

and <devicename> must be the same for zones of a single keyboard.

Where possible <zone_name> should be a value already used by other
zoned keyboards with a similar or identical zone layout, e.g.:

<devicename>:rgb:kbd_zoned_backlight-right
<devicename>:rgb:kbd_zoned_backlight-middle
<devicename>:rgb:kbd_zoned_backlight-left
<devicename>:rgb:kbd_zoned_backlight-corners
<devicename>:rgb:kbd_zoned_backlight-wasd

or:

<devicename>:rgb:kbd_zoned_backlight-main
<devicename>:rgb:kbd_zoned_backlight-cursor
<devicename>:rgb:kbd_zoned_backlight-numpad
<devicename>:rgb:kbd_zoned_backlight-corners
<devicename>:rgb:kbd_zoned_backlight-wasd

Note this is intended for keyboards with a limited number of zones,
keyboards with per key addressable backlighting must not use LED
class devices since the sysfs API is not suitable for rapidly change
multiple LEDs in one "commit" as is necessary to do animations /
special effects on such keyboards.
"""

Feel free to use the above example verbatim, although if you think
you can improve on this, then that would be great :)

Regards,

Hans



