Return-Path: <linux-kernel+bounces-330413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA2979E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A036281322
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4B14900B;
	Mon, 16 Sep 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjJDVG8L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577914659A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478276; cv=none; b=a+Exqha+T9n0RhIkQxwKgtwkD+WMsgp7+qLlGOzCJyrpz2LY54NBG8JW9tBPb8opFjD6IdG2VONPjR4yP0UnGmyRypJYjyYQ5EQyfaqwxQhMfc4+Rq/NSKp5qMwx9sOdRzIp6T8bftstuJK3qdpo1HLe6YqwuonavL1WVhM8Wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478276; c=relaxed/simple;
	bh=fsbCsd/n7hYkx9OiYs/hOULw05rGBgTRhjgNDnGETEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uEtMvS2gNR6JqAxwD28tABqeeezECwmo5YpoNRChAOZnF6YYYdKAcAAb/JJBlNS0MLyZEXPY9bGQwT811C/br7YuM6Dmk/VKxPMIOrWmXTnVVQKaSLUe7Gq8SZD8Z5Ea075N0GjP5x+1kmfa6oY65AOBYYEVJ8K5P81BgoSbTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjJDVG8L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726478274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZlUpJD1u2D4y829v0MZ+38o7vNfH4MDWrJrr43iAOo=;
	b=ZjJDVG8LJjaNE07x1JwQcdg3m1MS8CbZM5H+xE4bzt8H+eyTj/WV+u4Mnz8CYPS0l/RmIE
	rlLx51hTSrHCFUOx8gt12OyTjUiHpzjWczGcGZxz48klH9255uMhiIbbrHyYdOvgMYJEKg
	n5qKccMbNyHRMBGn2NxgfuCtPZ8CGn4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-fGnXcqNcNd21EQ7nupNJ_w-1; Mon, 16 Sep 2024 05:17:52 -0400
X-MC-Unique: fGnXcqNcNd21EQ7nupNJ_w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374cd315c68so1269666f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478271; x=1727083071;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZlUpJD1u2D4y829v0MZ+38o7vNfH4MDWrJrr43iAOo=;
        b=Zq7rI5q1swzXnqHm9TVn+GyNobZALH44Fhll3TrXbEMZxGbxurEaxG1xEtCcmezxsu
         wFC6IJhqiagDf1R/+0H27/bWGESFgMY/9F9gTkT2Es2NDcnO4wwtQSgt7ekFh3Rr3yiv
         W9/FOAIYHZWeDj2T/o7didEO9AmeTw+wa9laGsegldbk55J04KJucryKnat/RDbZoYw+
         b11i+Zsoce1D0AigANBrgiJ58r38FXEeSRBXNqiARUTyCFbzr8DBt8TNlWlIbPFXihea
         1Szwws5Ap9ii/lG2J4+6IQ1/Dm8gwtflDd97NK4DzT9L7EOkMUGgwpmWUnHtb7MoWut3
         i2jw==
X-Forwarded-Encrypted: i=1; AJvYcCU26evG5B4iTzJWr/Aez67HDki2OGKYSiL+952ip19xUoHD8VuJ65U6IT8INN8GCaWIxxGx+7+G6V8z9VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJYfDm8ZsvzAQgbyxcLp7Xdh6OgdhflpGS2fCe2Lry6YJSo6w
	g3n4B4z02UX2uWME5yJOtiHpnwsCf6fwm0i75VYKPHqwW8EzJIuTXvVQXesOrOaS6UI5yGBtRWC
	LS8SeB/t8YEcCX7psd2T4Wk7ovHG7r3L5xRC4jEiBaNLGeoqV3AdBxKG0ONgOrg==
X-Received: by 2002:a05:6000:459a:b0:374:c87c:6653 with SMTP id ffacd0b85a97d-378d625d1bcmr5180010f8f.59.1726478271527;
        Mon, 16 Sep 2024 02:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr/amHL1g9g9bIGYoMJCQHZMKTHGf7MVVMg5YL/dVBytjGa9ZBq7SHyvot4r13prMJmLQeqg==
X-Received: by 2002:a05:6000:459a:b0:374:c87c:6653 with SMTP id ffacd0b85a97d-378d625d1bcmr5179986f8f.59.1726478270844;
        Mon, 16 Sep 2024 02:17:50 -0700 (PDT)
Received: from localhost (red-hat-inc.vlan560.asr1.mad1.gblx.net. [159.63.51.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71ed08esm6763307f8f.4.2024.09.16.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:17:50 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, kernel test robot
 <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Julius Werner
 <jwerner@chromium.org>, Hugues Bruant <hugues.bruant@gmail.com>,
 intel-gfx@lists.freedesktop.org, Brian Norris <briannorris@chromium.org>,
 dri-devel@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
 chrome-platform@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v3] firmware: coreboot: Don't register a pdev if
 screen_info data is present
In-Reply-To: <a6a994b0-5021-49e5-b853-a1b2abe3af2f@suse.de>
References: <20240913213246.1549213-1-javierm@redhat.com>
 <202409151528.CIWZRPBq-lkp@intel.com>
 <eeac1c3c-4a21-4cd5-b513-8e55cffe0bae@suse.de>
 <8734m0atbu.fsf@minerva.mail-host-address-is-not-set>
 <a6a994b0-5021-49e5-b853-a1b2abe3af2f@suse.de>
Date: Mon, 16 Sep 2024 11:17:49 +0200
Message-ID: <875xqwufcy.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi Javier
>
> Am 16.09.24 um 10:36 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas and Tzung-Bi,
>>
>>> Hi
>>>
>>> Am 15.09.24 um 09:44 schrieb kernel test robot:
>>>> Hi Javier,
>>>>
>>>> kernel test robot noticed the following build errors:
>>>>
>>>> [auto build test ERROR on chrome-platform/for-next]
>>>> [also build test ERROR on chrome-platform/for-firmware-next linus/mast=
er v6.11-rc7 next-20240913]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>>
>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Martinez=
-Canillas/firmware-coreboot-Don-t-register-a-pdev-if-screen_info-data-is-pr=
esent/20240914-053323
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platfor=
m/linux.git for-next
>>>> patch link:    https://lore.kernel.org/r/20240913213246.1549213-1-javi=
erm%40redhat.com
>>>> patch subject: [PATCH v3] firmware: coreboot: Don't register a pdev if=
 screen_info data is present
>>>> config: riscv-randconfig-001-20240915 (https://download.01.org/0day-ci=
/archive/20240915/202409151528.CIWZRPBq-lkp@intel.com/config)
>>>> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8=
dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>>>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/ar=
chive/20240915/202409151528.CIWZRPBq-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202409151528.CIWZRPBq-=
lkp@intel.com/
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> ld.lld: error: undefined symbol: screen_info
>>>>      >>> referenced by framebuffer-coreboot.c:27 (drivers/firmware/goo=
gle/framebuffer-coreboot.c:27)
>>>>      >>>               drivers/firmware/google/framebuffer-coreboot.o:=
(framebuffer_probe) in archive vmlinux.a
>>>>      >>> referenced by framebuffer-coreboot.c:27 (drivers/firmware/goo=
gle/framebuffer-coreboot.c:27)
>>>>      >>>               drivers/firmware/google/framebuffer-coreboot.o:=
(framebuffer_probe) in archive vmlinux.a
>>> Not all platforms define screen_info. Maybe fix this by following
>> Yes, after reading the build errors reported by the robot I remembered
>> that we had similar issues with sysfb, for example commit 1260b9a7020
>> ("drivers/firmware: fix SYSFB depends to prevent build failures") fixed
>> one of those.
>>
>>> Tzung-Bi's advice of removing the local variables and then guard the
>>> test by CONFIG_SYSFB. If SYSFB has been defined, screen_info has to be
>>> there. It's not a super pretty solution, though.
>>>
>> If possible I would prefer to avoid the ifdefery in the driver. I also
>> believe that the local variables makes the code easier to read. But if
>> you folks think that's better to drop them, I can do it in the next rev.
>>
>> Another option is to restrict the architectures where this driver could
>> be build. As far as I understand it is mainly for x86 and ARM64 arches.
>>
>> These two have a screen_info defined so the driver will build correctly.
>> I can include a preparatory patch that adds a "depends on x86 || ARM64".
>
> That feels arbitrary, as the dependency is not really in coreboot, but=20
> in sysbf. What you'd want is a HAVE_SCREEN_INFO define on the=20
> architectures that provide it. IIRC earlier attempts to add this have=20
> failed. :/
>
> If you don't want the ifdef-ery in coreboot.c, you could add a helper to=
=20
> sysfb. Let's say
>
>  =C2=A0 bool sysfb_handles_screen_info(void)
>
> returns the result of the test. If you put it next to sysfb_disable(),=20
> you could add an empty wrapper into the sysfb.h header as well. [1]
>
> (There's still the possibility that screen_info is available, but sysfb=20
> has been disabled. But that's not different from how it currently works.)
>

I like that. And when SYSFB is not enabled, sysfb_handles_screen_info()
could just be defined as "return false;" which will indicate to drivers
that would have to handle the system frambuffer themselves.

I'll try to type the patches later today.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


