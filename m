Return-Path: <linux-kernel+bounces-356612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E197996426
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01C81C241C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA3194C77;
	Wed,  9 Oct 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="a8uMLX+q"
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8118BC0F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463900; cv=none; b=S8HXpPFTixcWd9xWK2YZtlrWb5t+cNmsLsTRSENtN0LvekrzNG37tdRBLkVZLzbh+Kqy7aT0tuH0MdaZKqd0HAlgInBNFGFxM9a/1PztMDqGiFh6eMFme252DN+4ekt/LDWceutWB3aIxyfiVIZEb+1hFalA9JTvwizvOLVfmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463900; c=relaxed/simple;
	bh=xegdOlru2FXlyYKCiCV+GnSQ4SIraYfodOdgVdYSPJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoPahqxJ3JCM2/1MJRYAxkzlfgrRv/fDKfF9WTqmg0N8sdLJDkSRT2Cd0NdIxHhnFV59eVWdRyE1sk4XG95y7MAG0QEATUDYh27l5ZwaR1ZsVRls+6Xo7R+/3gOmWvT/2IuxHaF2D1oOzK1H8/9HEFS8ljShhrnwqS+6T7tzMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=a8uMLX+q; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id ySN3snLGnwy3rySN3srqnd; Wed, 09 Oct 2024 10:48:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728463718; bh=xegdOlru2FXlyYKCiCV+GnSQ4SIraYfodOdgVdYSPJE=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=a8uMLX+qz1ZvjBBhgGbJv1YVCse+OAB/DWZB1QngqCy4G933h25YQpqOinevnAeVh
	 j8p/cTUaPM1kkv7/5Z1VJWWjarxkN5inxdjd4bA56E76fbQejDIJGtj2TwFLDb0I2X
	 kBgJeDbQLNmWvYyiwQcs+xsma0h/+SHUNHGHpPXDNEqRJbz6OnDYfKVwqtwKxS6UiL
	 simUE8tZTCPG+l4kTz+O9MK2Cq6XOOFU8V5K2wCqfNlVWyD4nEz7/FE31KEgM82jLw
	 g0qfg7oLp1xqwLeFHxOJfTTmmcEMoh+odtKOcl1llotn7H+UjEibIguor3djhYkpJq
	 vtGIkRvF9rDXw==
Message-ID: <d8e9b91f-65fb-4b71-b586-998fbf914b0a@enneenne.com>
Date: Wed, 9 Oct 2024 10:48:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] drivers pps: add PPS generators support
To: "Hall, Christopher S" <christopher.s.hall@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "Mohan, Subramanian" <subramanian.mohan@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>, "N, Pandith" <pandith.n@intel.com>,
 "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
 "Zage, David" <david.zage@intel.com>,
 "Chinnadurai, Srinivasan" <srinivasan.chinnadurai@intel.com>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
 <MW4PR11MB698415531AEF2041384989FBC27F2@MW4PR11MB6984.namprd11.prod.outlook.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <MW4PR11MB698415531AEF2041384989FBC27F2@MW4PR11MB6984.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAvLGhsGccBYx9Kw36Yzyq2b9Lnlkipb/FiRx0xHUmheEVFWM4x/E3s8TIzm11//fMbnjGX5icd2tqA9B1mW+oXjLcCPdyzudN/5Ku0+jwsh1CLB6Pfp
 T2lvYhT7l2ExvQCW7OTkinOA8vAOGQuGL/Z8RFRYej/WrnT6NHfOm9YXrk4852cp96zDSqS1BRrI0KB6Bzx9bT3j0U4sxK1jQPKKFz1uINvIIP8Vg2z/rxEV
 Z1BSkKMDq0ZCECz8lkg5JfzAWbieBhzGVTntMbvNTqqQVZH09hEqrdYAhAPGJ1AUVoBebtvI3yBBe4X6H6s+WoFJCsPW2K0Pm25kQT6Ht394PPzH6/jnqzyx
 KeisHgHW5PpDzALlphhmRtFd7y4Ij+DSw4/cfReRI1tfldcoh5KuVLi78GIAm4iE7ds3h/KH7N+bdfpBohBviWluAKEQ32lbvYNaLX3oL44nI/BNKLfFK1BY
 k2gDmEBhrYvXUt5ZLcOanF7hUXTGR1O/vIKJPtQv+uzOxs36qH87q0pcnkBzdensdKhl3SamiM1z+iJao50xDfisz2yDpQwH9+oK3ETKl1Wd6CqJlMDO6oQX
 vRgSSOBCBMfmqv2R2Go6A3G+YSvPjirYA15+YHIluDB/sSlM9ii+qpFQiUTdUNqDiGfvXGYXrXta7JrR9NVE/o68

On 09/10/24 04:49, Hall, Christopher S wrote:
> Hi Rudolfo,
> 
>> -----Original Message-----
>> From: Rodolfo Giometti <giometti@enneenne.com>
>> Sent: Tuesday, October 08, 2024 6:51 AM
>> To: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> 
>> Sometimes one needs to be able not only to catch PPS signals but to
>> produce them also. For example, running a distributed simulation,
>> which requires computers' clock to be synchronized very tightly.
>>
>> This patch adds PPS generators class in order to have a well-defined
>> interface for these devices.
>>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>> ---
>>   drivers/pps/Makefile                   |   3 +-
>>   drivers/pps/generators/Kconfig         |  19 +-
>>   drivers/pps/generators/Makefile        |   4 +
>>   drivers/pps/generators/pps_gen-dummy.c |  83 ++++++++
>>   drivers/pps/generators/pps_gen.c       | 283 +++++++++++++++++++++++++
>>   drivers/pps/generators/sysfs.c         |  89 ++++++++
>>   include/linux/pps_gen_kernel.h         |  57 +++++
>>   include/uapi/linux/pps_gen.h           |  35 +++
>>   8 files changed, 571 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/pps/generators/pps_gen-dummy.c
>>   create mode 100644 drivers/pps/generators/pps_gen.c
>>   create mode 100644 drivers/pps/generators/sysfs.c
>>   create mode 100644 include/linux/pps_gen_kernel.h
>>   create mode 100644 include/uapi/linux/pps_gen.h
> 
> This looks pretty good to me. I would like to see an alarm callback. We are able
> to detect a missed event and rather than stopping inexplicably or writing to the
> system log, it would be better to be able to notify an application directly.
> 
> Off the top of my head, something like:
> 
> void pps_gen_alarm(pps_gen_device *pps_gen) {
> 	pps_gen->alarm = 1;
> 	sysfs_notify(pps_gen->dev->kobj, NULL, "alarm");
> }
> 
> The device is reset by disabling/enabling and this resets the alarm flag.
> 
> Could we add something like this?

Yes, of course. But it's better to provide a proper patch against my patchset V1 
(I'm going to anticipate them to you shortly), since I'm not sure to understand 
what you need.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


