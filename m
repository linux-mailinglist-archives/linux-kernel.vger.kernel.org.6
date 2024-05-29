Return-Path: <linux-kernel+bounces-193505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53D8D2D25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE101B27E73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA915F41B;
	Wed, 29 May 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nuk5asU3"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8E15CD7D;
	Wed, 29 May 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963823; cv=none; b=mEQ5UEw7M+dpyJxOr7skPSJJwVty+DWYSuroMG65tuNXvbLWEySsiPUy8iVudJ46bHF7D5O/+uGQgaXPHPGMcbKTvuZ0gjQJy9HNKIU5BnG7oDCg+h7HpBULqstXU47LEqG3GFSJfgALnEJzASNzdND7iE2ZJ/trxWryRZohcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963823; c=relaxed/simple;
	bh=3bracRjbxdYDDKFLpVEB1YVlYghO1YkC0e4RdFgdlgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ourDERhyGKjaOmQB234hXTam290Z+mlBg9F6QNaY4sV18ZBQoca148+5ZlEVa1sQTu3uCF772uQCFCWu029Rl9OEe7pYAJjcLIyH1EnT67EFCpISx+S5CpKu+/E/xa7EQWlhQqdruvo5CgytpaemL6kBdyOTELgX/GgMBSaiqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nuk5asU3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716963817;
	bh=3bracRjbxdYDDKFLpVEB1YVlYghO1YkC0e4RdFgdlgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuk5asU3sIeBf0jHEJVz/u9DYiH4FioJxqM5jMXUbR4u7Cbkmtueho+zV7Tn5fiV5
	 JAMyfFMsrGjYVvKqGsH0yALrQ/tMAEnXEkZSHbfIONhrLE30EFfzKW6h5KUlyttNnX
	 ukoVxwhaGPQzPnEFY/PnKva4N1UgLVqCQsDOWG+k=
Date: Wed, 29 May 2024 08:23:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Stephen Horvath <s.horvath@outlook.com.au>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>, 
	Lee Jones <lee@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
Message-ID: <22a16af6-93c4-454c-853b-5959a5c018d3@t-8ch.de>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
 <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de>
 <SY4P282MB306325BB023A95198F25A21DC5F12@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <c9b110eb-ff0e-41f2-9492-8a5d8c3c01d0@roeck-us.net>
 <b8072b36-688f-41b8-8b32-40fc4fa4d148@t-8ch.de>
 <6824f030-92da-4439-af3b-8c2498f4382e@roeck-us.net>
 <SY4P282MB30638301303268093B6D1ABFC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SY4P282MB30638301303268093B6D1ABFC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>

On 2024-05-29 10:58:23+0000, Stephen Horvath wrote:
> On 29/5/24 09:29, Guenter Roeck wrote:
> > On 5/28/24 09:15, Thomas Weißschuh wrote:
> > > On 2024-05-28 08:50:49+0000, Guenter Roeck wrote:
> > > > On 5/27/24 17:15, Stephen Horvath wrote:
> > > > > On 28/5/24 05:24, Thomas Weißschuh wrote:
> > > > > > On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
> > > > > > > Don't forget it can also return `EC_FAN_SPEED_STALLED`.

<snip>

> > > > > > 
> > > > > > Thanks for the hint. I'll need to think about how to
> > > > > > handle this better.
> > > > > > 
> > > > > > > Like Guenter, I also don't like returning `-ENODEV`,
> > > > > > > but I don't have a
> > > > > > > problem with checking for `EC_FAN_SPEED_NOT_PRESENT`
> > > > > > > in case it was removed
> > > > > > > since init or something.
> > > > > > 
> > > > 
> > > > That won't happen. Chromebooks are not servers, where one might
> > > > be able to
> > > > replace a fan tray while the system is running.
> > > 
> > > In one of my testruns this actually happened.
> > > When running on battery, one specific of the CPU sensors sporadically
> > > returned EC_FAN_SPEED_NOT_PRESENT.
> > > 
> > 
> > What Chromebook was that ? I can't see the code path in the EC source
> > that would get me there.
> > 
> 
> I believe Thomas and I both have the Framework 13 AMD, the source code is
> here:
> https://github.com/FrameworkComputer/EmbeddedController/tree/lotus-zephyr

Correct.

> The organisation confuses me a little, but Dustin has previous said on the
> framework forums (https://community.frame.work/t/what-ec-is-used/38574/2):
> 
> "This one is based on the Zephyr port of the ChromeOS EC, and tracks
> mainline more closely. It is in the branch lotus-zephyr.
> All of the model-specific code lives in zephyr/program/lotus.
> The 13"-specific code lives in a few subdirectories off the main tree named
> azalea."

The EC code is at [0]:

$ ectool version
RO version:    azalea_v3.4.113353-ec:b4c1fb,os
RW version:    azalea_v3.4.113353-ec:b4c1fb,os
Firmware copy: RO
Build info:    azalea_v3.4.113353-ec:b4c1fb,os:7b88e1,cmsis:4aa3ff 2024-03-26 07:10:22 lotus@ip-172-26-3-226
Tool version:  0.0.1-isolate May  6 2024 none


From the build info I gather it should be commit b4c1fb, which is the
current HEAD of the lotus-zephyr branch.
Lotus is the Framework 16 AMD, which is very similar to Azalea, the
Framework 13 AMD, which I tested this against.
Both share the same codebase.

> Also I just unplugged my fan and you are definitely correct, the EC only
> generates EC_FAN_SPEED_NOT_PRESENT for fans it does not have the capability
> to support. Even after a reboot it just returns 0 RPM for an unplugged fan.
> I thought about simulating a stall too, but I was mildly scared I was going
> to break one of the tiny blades.

I get the error when unplugging *the charger*.

To be more precise:

It does not happen always.
It does not happen instantly on unplugging.
It goes away after a few seconds/minutes.
During the issue, one specific sensor reads 0xffff.

> > > > > > Ok.
> > > > > > 
> > > > > > > My approach was to return the speed as `0`, since
> > > > > > > the fan probably isn't
> > > > > > > spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and
> > > > > > > HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
> > > > > > > No idea if this is correct though.
> > > > > > 
> > > > > > I'm not a fan of returning a speed of 0 in case of errors.
> > > > > > Rather -EIO which can't be mistaken.
> > > > > > Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which
> > > > > > should never happen)
> > > > > > and also for EC_FAN_SPEED_STALLED.
> > > > > 
> > > > > Yeah, that's pretty reasonable.
> > > > > 
> > > > 
> > > > -EIO is an i/o error. I have trouble reconciling that with
> > > > EC_FAN_SPEED_NOT_PRESENT or EC_FAN_SPEED_STALLED.
> > > > 
> > > > Looking into the EC source code [1], I see:
> > > > 
> > > > EC_FAN_SPEED_NOT_PRESENT means that the fan is not present.
> > > > That should return -ENODEV in the above code, but only for
> > > > the purpose of making the attribute invisible.
> > > > 
> > > > EC_FAN_SPEED_STALLED means exactly that, i.e., that the fan
> > > > is present but not turning. The EC code does not expect that
> > > > to happen and generates a thermal event in case it does.
> > > > Given that, it does make sense to set the fault flag.
> > > > The actual fan speed value should then be reported as 0 or
> > > > possibly -ENODATA. It should _not_ generate any other error
> > > > because that would trip up the "sensors" command for no
> > > > good reason.
> > > 
> > > Ack.
> > > 
> > > Currently I have the following logic (for both fans and temp):
> > > 
> > > if NOT_PRESENT during probing:
> > >    make the attribute invisible.
> > > 
> > > if any error during runtime (including NOT_PRESENT):
> > >    return -ENODATA and a FAULT
> > > 
> > > This should also handle the sporadic NOT_PRESENT failures.
> > > 
> > > What do you think?
> > > 
> > > Is there any other feedback to this revision or should I send the next?
> > > 
> > 
> > No, except I'd really like to know which Chromebook randomly generates
> > a EC_FAN_SPEED_NOT_PRESENT response because that really looks like a bug.
> > Also, can you reproduce the problem with the ectool command ?

Yes, the ectool command reports the same issue at the same time.

The fan affected was always the sensor cpu@4c, which is
compatible = "amd,sb-tsi".

> I have a feeling it was related to the concurrency problems between ACPI and
> the CrOS code that are being fixed in another patch by Ben Walsh, I was also
> seeing some weird behaviour sometimes but I *believe* it was fixed by that.

I don't think it's this issue.
Ben's series at [1], is for MEC ECs which are the older Intel
Frameworks, not the Framework 13 AMD.

[0] https://github.com/FrameworkComputer/EmbeddedController
[1] https://lore.kernel.org/lkml/20240515055631.5775-1-ben@jubnut.com/

