Return-Path: <linux-kernel+bounces-171760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7758BE874
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66922B2A060
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5616C6BA;
	Tue,  7 May 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="WM5EB99d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSTXjV9P"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19D1649D3;
	Tue,  7 May 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097655; cv=none; b=dL7lvXoPHHMxZ1uyC3K0rI0Ph6/Nui8NHo4T1P/+uffQnlW2cue5thKBK3echCqBOsGh5SkDDiMPDwRi/WKP+0bGW+8QJYF4eM2r8S8wBqlncm1PJurH1gSkeorrwZ1Q9FPf+7ccwUDBeOkDBQbYz79KW6sx10b3bqosTTvwpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097655; c=relaxed/simple;
	bh=FddP+c4dgFZb9XdTcHg7G1UtgfmUmewlW32Kal5emFk=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDnXqqWQsqsJAkuHk+4JdpyA0zR+XGUQZQDPi146ZxrrAp4pkNTYlHFqD4zrcIrLzKI+gaJApoJ3TRI+mjfHvOOo657Cb3s4d/ebMULJzvtk9EXOzRbBszb5lVfMJopY8GYCuF1PjRqBTZivT8d+3YXd3hXDcU3i4aUs0tMHxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=WM5EB99d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSTXjV9P; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id C808F18000E1;
	Tue,  7 May 2024 12:00:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 07 May 2024 12:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715097650; x=1715184050; bh=x9SXQUaEjS
	lb5DAJspjir6oHwES+a/5cta9M20wGfws=; b=WM5EB99deHS6/YdZrhB1WiWOsT
	9RjEotf3L1RU8tVMjYbuMiuC+DFfGOFx4kXsYynGUsWLdXUHPtbw0gSYilAUUfNN
	s1OvtIexwbQsJ3FG3p9nX8zT/kbCw3SOpPGdU5ZEbPPyMTREucaRYgZYc3aBYG58
	/aoFehJ/W0dhKDBLstNFumaNWs3zIrq0fITK7KRUeeTfRJ+wX+MU6IPOfJatU1bu
	3EtiN8RIY/kqINrvf7m34TbT4GCJ4Kqa33u8ttJvLzeWsFtpmqRw8Y8VqcAZdfaD
	mopAeYwlx02M3E7TF/NJBdKk9iK6h1z2NxrdQi1yjehVsLkOWyUjVZx7PJ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715097650; x=1715184050; bh=x9SXQUaEjSlb5DAJspjir6oHwES+
	a/5cta9M20wGfws=; b=eSTXjV9PxS8BRR/5pdxJbkNthk6INdFXzSVtret03MOl
	+I/wk8/hMVzrNt19myDKRS+y35QieKcTViO8abvIyrEuPE+dZgXS9viFFHpLJcce
	MAsTsgosUXJI09LWX5b8p68r5VUQwIj3X3zckUStbgLOgVrLgaUkrgQbDwTsMB8x
	yhTz92rwwgOP9/R4r2CqWYgiQJA506M8sjDP74pJ0HNMwbhYvtI4d9EUOe36/u/A
	krWn74VL36cp55EcAes4vbno7nOc9bnOrbE42K+HOf+/UN9HoO1tSDL0SfAgh+cM
	rn9qTLdf+mcLEPwzh5FlqSEkAn2EobtHRr+nssmw+w==
X-ME-Sender: <xms:MVA6Zvy2cC3gTDiG_gj8l5UgmwuK_vafMQSazFuoLZ-o27zKPqUcow>
    <xme:MVA6ZnRtqh082m2305P2kvCoD9mVh1CCpMixR-OrOAJ7sm6FQa0gZysn8PA6w5d4z
    pn7TdycuGOr3TlR8as>
X-ME-Received: <xmr:MVA6ZpUqNzbDVqIGC3OwXwlPlxx8-XWGAweaKYj1AeVC2nWPRpXJfGEGASo5SERpYsw7Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepvdfgjeduvddtheekkeduiedtieegveefgeekgfevffffjeevgeffueev
    heejjedtnecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomh
    dpkhgvrhhnvghlrdhorhhgpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:MVA6Zphr_mHn0ROrXrxSuf5s3IrRSW7tMa7W6Cz1My0_xWLhSCszBw>
    <xmx:MVA6ZhAkYopwc5mE9wysh0rHnwrmmI1aXNyN9PR1W3eD1-VKkYmWnw>
    <xmx:MVA6ZiJX1rcsNobFuk1g8oGrPSBkvz3bR7bkciotQfZGnzNLqdDj2w>
    <xmx:MVA6ZgA3gRqE-Hp1GLhhtUVLxUbpxU1_MfM8toM6bYsCeAATIeZY_A>
    <xmx:MlA6Zl3OKYHu3VH2ojdk4xDeC9FUponUcqAeddS7mEP1IVPiC1po8ES2>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 12:00:44 -0400 (EDT)
Date: Tue, 07 May 2024 10:00:33 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: Hans de Goede <hdegoede@redhat.com>
Cc: kernel test robot <lkp@intel.com>, Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>, oe-kbuild-all@lists.linux.dev,
	mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Message-Id: <XSH4DS.Y4TZMDPWKC5Z1@lyndeno.ca>
In-Reply-To: <4bb43e89-c387-4219-9051-421d700f332e@redhat.com>
References: <20240501215829.4991-2-lsanche@lyndeno.ca>
	<202405031851.NYy0ZB02-lkp@intel.com> <A9SXCS.IUN31UTTT9GM2@lyndeno.ca>
	<4bb43e89-c387-4219-9051-421d700f332e@redhat.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Mon, May 6 2024 at 12:18:05 PM +02:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Lyndon,
> 
> Thank you for your patch!
> 
> On 5/4/24 3:03 AM, Lyndon Sanche wrote:
>> 
>> 
>>  On Fri, May 3 2024 at 06:19:18 PM +08:00:00, kernel test robot 
>> <lkp@intel.com> wrote:
>>>  Hi Lyndon,
>>> 
>>>  kernel test robot noticed the following build warnings:
>>> 
>>>  [auto build test WARNING on linus/master]
>>>  [also build test WARNING on v6.9-rc6 next-20240503]
>>>  [If your patch is applied to the wrong git tree, kindly drop us a 
>>> note.
>>>  And when submitting patch, we suggest to use '--base' as 
>>> documented in
>>>  https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>> 
>>>  url:    
>>> https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240502-060146
>>>  base:   linus/master
>>>  patch link:    
>>> https://lore.kernel.org/r/20240501215829.4991-2-lsanche%40lyndeno.ca
>>>  patch subject: [PATCH v5] platform/x86: dell-laptop: Implement 
>>> platform_profile
>>>  config: 
>>> i386-kismet-CONFIG_ACPI_PLATFORM_PROFILE-CONFIG_DELL_LAPTOP-0-0 
>>> (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/config)
>>>  reproduce: 
>>> (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/reproduce)
>>> 
>>>  If you fix the issue in a separate patch/commit (i.e. not just a 
>>> new version of
>>>  the same patch/commit), kindly add following tags
>>>  | Reported-by: kernel test robot <lkp@intel.com>
>>>  | Closes: 
>>> https://lore.kernel.org/oe-kbuild-all/202405031851.NYy0ZB02-lkp@intel.com/
>>> 
>>>  kismet warnings: (new ones prefixed by >>)
>>>>>   kismet: WARNING: unmet direct dependencies detected for 
>>>>> ACPI_PLATFORM_PROFILE when selected by DELL_LAPTOP
>>>     WARNING: unmet direct dependencies detected for 
>>> ACPI_PLATFORM_PROFILE
>>>       Depends on [n]: ACPI [=n]
>>>       Selected by [y]:
>>>       - DELL_LAPTOP [=y] && X86_PLATFORM_DEVICES [=y] && 
>>> X86_PLATFORM_DRIVERS_DELL [=y] && DMI [=y] && 
>>> BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO 
>>> [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && (DELL_WMI [=n] || 
>>> DELL_WMI [=n]=n) && SERIO_I8042 [=y] && DELL_SMBIOS [=y]
>>> 
>>>  --
>>>  0-DAY CI Kernel Test Service
>>>  https://github.com/intel/lkp-tests/wiki
>> 
>>  I will try reproducing this test on my machine, to avoid spamming 
>> the mailing list with the same error over and over.
> 
> No need to reproduce this. When you select something in Kconfig you 
> must ensure
> that the item doing the selecting depends on all the dependencies of 
> what you
> are selecting.
> 
> IOW if you add this change to your next version then that should fix 
> this:
> 
> diff --git a/drivers/platform/x86/dell/Kconfig 
> b/drivers/platform/x86/dell/Kconfig
> index bd9f445974cc..d18fbc6a5fbf 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -47,6 +47,7 @@ config DCDBAS
>  config DELL_LAPTOP
>  	tristate "Dell Laptop Extras"
>  	default m
> +	depends on ACPI
>  	depends on DMI
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
> 
> And please also address Armin's remark about making sure that failure
> to initialize platform_profile support should not cause the entire 
> driver
> to fail to probe.
> 
> I see that Armin suggests to check da_supported_commands for this,
> this is a good idea but atm this is private to dell-smbios-base. So
> you will first need to do a small preparation patch adding a small:
> 
> bool dell_laptop_check_supported_cmds(struct calling_interface_buffer 
> *buffer)
> {
> 	return da_supported_commands & (1 << buffer->cmd_class);
> }
> EXPORT_SYMBOL_GPL(dell_laptop_check_supported_cmds):
> 
> helper for this.
> 
> If this check fails (returns false) make the code not register
> the platform_profile() while allowing probe() to continue / succeed,
> please do not log anything in this case (or use dev_dbg())
> 
> If this check succeeds but subsequent dell_smbios_call()'s
> fail during probe, then it is ok to log an error but please
> still let probe() continue / succeed (without registering
> a platform_profile handler).
> 
> Regards,
> 
> Hans
> 
> 
Hello Hans:

Thank you very much for your feedback and suggestions! I have been busy 
the past few days, but will be able to tackle this this week. These are 
good ideas which I plan to implement.

Thank you,

Lyndon



