Return-Path: <linux-kernel+bounces-169648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80B8BCBC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EB91F23599
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB61428ED;
	Mon,  6 May 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYJEqUri"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74F142642
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990695; cv=none; b=UtIwuYPLzOpMjEUpjgGeC0lLIoUaYJI/8Tk1HU4unTSr9eo8JMB51FdknHgwoFog6CWP7wQyz0565AEARpcjcQaIJJ1yyWkF9IT89Z+AXodGQpdLNrUfXKSO/yqxUtAwfz5iQ/wL97uTIKxchAHGljWArmvkxvQ3KvVRbLRqc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990695; c=relaxed/simple;
	bh=aW8K4LlF8r1t0fqsYZXyZZaeJhZfLCbRlWDBMVNk598=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3nkXNDamBd/cE3i0hmHadNpBwoVRosxImF6RxGjDtyRMeQ9MaA1ru+GHAqPmWaNhRIzaKljsJXPkJ12efXoUQwKZdheSwoIfkZq9GqJyB0rnuKfWeUjYHR7D+YK3/Gq1hJ43A4PyXdxUdZjBlCP51Y54ObBF3q7JA7JxWNucWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYJEqUri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714990692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdxmZuI5jTokyLLfusHKdtKb4By7NqPY0RrHHYpB960=;
	b=bYJEqUriOJvQbTBVNHu5ex+JUpbpfXGsKqkZ5alpAMfHnnS7kYSuJ2fZxRqDsYsQyV6vWK
	f0UEgqe1te8lJagzNeZ8ajgmwqY4yYdaKITDHzkjn6DPach/KHGLLRyJfjkzIqTzD1SVct
	ol8+5lirqQDYdnhjDENFRahM3ZKqs/o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-UvkWnFyVNd-MDwGXOqPQHg-1; Mon, 06 May 2024 06:18:11 -0400
X-MC-Unique: UvkWnFyVNd-MDwGXOqPQHg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a59c3cf5f83so73331266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 03:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714990690; x=1715595490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdxmZuI5jTokyLLfusHKdtKb4By7NqPY0RrHHYpB960=;
        b=WG+HwYmTlQfQ7zdSl/3Tyifpe+gMCUyIvKIrOGnxbz16upLgYeJgj/TmJVrHn1Hh7H
         r7jdgU9KAO/JR34DzyIzgsfzhjLQkDAUD6QyaMQqPFPPlDXw3Fv/4Gqm5vrJDj001XUM
         OKhula00EBjjSk6Z4v19diuu/9UFEqriBo0GqF/RAZr+1D8EGWV1Lzt6bzQvN9vluYu/
         wbpaP+30mSjHd2jQr5+4HyfrtylsHRFhwbj+U9i2VdGjyS47XADUjhcsO6G6libtY6m0
         aEaZV0nI3xTC4sttCBE/jpP8csYGJRnGO6zoqxSyPukzzAsF7orTdrwdDUEN6o3peC7v
         dFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUW3xURNCIfu0WmiFQUZ76rovszP+LM4C9JWN9yYZbdLxrAHYGg8hvoH4cgwjct26RStPaGguZlOcZvssjsxtz7QiEVCYiSwSbHyaIf
X-Gm-Message-State: AOJu0YxigJTyrM+n/AM8jh+T96IDr9NA3ykjV+Kw42DodjQzbpuc4/hQ
	gAXllJZBG0Ty9jXawc8BSQiqNWydDl7D2UilwdIFepF5+H3x7ndMCy0Vn9i1hF5d/AgN/5sQ+2L
	s9yVdj2hzG1g2ao6qa7vwmefqsdmED0CMWEtcNpbRmPPCOO605Lyjs6/YA3vliw==
X-Received: by 2002:a17:906:7f05:b0:a59:cdc9:6fdf with SMTP id d5-20020a1709067f0500b00a59cdc96fdfmr1471830ejr.4.1714990690005;
        Mon, 06 May 2024 03:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Rmg46pqkEubaB8A+NPfk6o3LAM0etZx1imlpQDm/pH8WR39XAlpHmox9waYYu8s7aR0XBw==
X-Received: by 2002:a17:906:7f05:b0:a59:cdc9:6fdf with SMTP id d5-20020a1709067f0500b00a59cdc96fdfmr1471814ejr.4.1714990689552;
        Mon, 06 May 2024 03:18:09 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a599adfd49dsm3711634ejb.64.2024.05.06.03.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 03:18:09 -0700 (PDT)
Message-ID: <4bb43e89-c387-4219-9051-421d700f332e@redhat.com>
Date: Mon, 6 May 2024 12:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>, kernel test robot <lkp@intel.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
 Necip Fazil Yildiran <fazilyildiran@gmail.com>,
 oe-kbuild-all@lists.linux.dev, mario.limonciello@amd.com, pali@kernel.org,
 W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240501215829.4991-2-lsanche@lyndeno.ca>
 <202405031851.NYy0ZB02-lkp@intel.com> <A9SXCS.IUN31UTTT9GM2@lyndeno.ca>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <A9SXCS.IUN31UTTT9GM2@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lyndon,

Thank you for your patch!

On 5/4/24 3:03 AM, Lyndon Sanche wrote:
> 
> 
> On Fri, May 3 2024 at 06:19:18 PM +08:00:00, kernel test robot <lkp@intel.com> wrote:
>> Hi Lyndon,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v6.9-rc6 next-20240503]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240502-060146
>> base:   linus/master
>> patch link:    https://lore.kernel.org/r/20240501215829.4991-2-lsanche%40lyndeno.ca
>> patch subject: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
>> config: i386-kismet-CONFIG_ACPI_PLATFORM_PROFILE-CONFIG_DELL_LAPTOP-0-0 (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/config)
>> reproduce: (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202405031851.NYy0ZB02-lkp@intel.com/
>>
>> kismet warnings: (new ones prefixed by >>)
>>>>  kismet: WARNING: unmet direct dependencies detected for ACPI_PLATFORM_PROFILE when selected by DELL_LAPTOP
>>    WARNING: unmet direct dependencies detected for ACPI_PLATFORM_PROFILE
>>      Depends on [n]: ACPI [=n]
>>      Selected by [y]:
>>      - DELL_LAPTOP [=y] && X86_PLATFORM_DEVICES [=y] && X86_PLATFORM_DRIVERS_DELL [=y] && DMI [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && (DELL_WMI [=n] || DELL_WMI [=n]=n) && SERIO_I8042 [=y] && DELL_SMBIOS [=y]
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> 
> I will try reproducing this test on my machine, to avoid spamming the mailing list with the same error over and over.

No need to reproduce this. When you select something in Kconfig you must ensure
that the item doing the selecting depends on all the dependencies of what you
are selecting.

IOW if you add this change to your next version then that should fix this:

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index bd9f445974cc..d18fbc6a5fbf 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -47,6 +47,7 @@ config DCDBAS
 config DELL_LAPTOP
 	tristate "Dell Laptop Extras"
 	default m
+	depends on ACPI
 	depends on DMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n

And please also address Armin's remark about making sure that failure
to initialize platform_profile support should not cause the entire driver
to fail to probe.

I see that Armin suggests to check da_supported_commands for this,
this is a good idea but atm this is private to dell-smbios-base. So
you will first need to do a small preparation patch adding a small:

bool dell_laptop_check_supported_cmds(struct calling_interface_buffer *buffer)
{
	return da_supported_commands & (1 << buffer->cmd_class);
}
EXPORT_SYMBOL_GPL(dell_laptop_check_supported_cmds):

helper for this.

If this check fails (returns false) make the code not register
the platform_profile() while allowing probe() to continue / succeed,
please do not log anything in this case (or use dev_dbg())

If this check succeeds but subsequent dell_smbios_call()'s
fail during probe, then it is ok to log an error but please
still let probe() continue / succeed (without registering
a platform_profile handler).

Regards,

Hans



