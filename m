Return-Path: <linux-kernel+bounces-176138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED9B8C2A70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E571F22BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76673481D7;
	Fri, 10 May 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeK0WpzC"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2D4642A;
	Fri, 10 May 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368956; cv=none; b=ZLzCiLMC4aOUSBwlboJlgyyj4JIM8MM/P50HFZm1ekZSbrUaImzye+rmJTrmrei5JM8u96XbCxqdGDrExMdK1MCQpWpGvZ9GF/l8121qL4xRfSbZVPwUpMkZCpWCU2WRnwA7xARAIgYgC/53/oCFYcmYjT3M7S+j/g88TIb0Tiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368956; c=relaxed/simple;
	bh=wBxook6alxIAXIcTcDJxowlHfyM70SBSwPqTZ2O6g+U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CCSn9sR6580Chf/W0Sp0D5PzVLnyIPh4WFDO2XSllQEqFS5b0XdApDcMlL1Ig7oxZFdju57Kpzgz66Es6cUjd0+7mbdx78xBNFv7B1n8HUOYvRgCFq+LWtyxhqfhVKgR0fxj+V1QJAj37/14tJV3ZjXR8xcMsHRZlFOmUQnOwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeK0WpzC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso3256051e87.1;
        Fri, 10 May 2024 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715368953; x=1715973753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i0Ra8O90/gic7UxozKAlXzQpo1FNfxGGEIwrCm2ve08=;
        b=XeK0WpzCWMH0i3PQ8QxaUokgObklvCUeDZ7uA9VjLi/M0sLhhv485Bzfr/6bVfU9iX
         QHXTLyQ1gtQuaDwI9yWLaNn//gz0MRtI+3lhedEFZnvBl+1UJJtJIoa64VJLXG2HnPFs
         6OenOi3kFC2vwKjGX68i4XYJY0yePwMHNA/bGUByi5FRA0YZjP+NrMaspNcjcFeRpvqZ
         NzZk/DoWh4z29tsLgcWsci4+YkzAYUhEDIQybmgQKDNIERXZoOj3Ga+ZKUoo4O+tw7pm
         tAAZczu4UweySPcTdT9oJc5Qf12I/OTyvwh+nKcY/PNeq8qJZMUt2uElu/TNmWX8/+Nq
         wYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368953; x=1715973753;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0Ra8O90/gic7UxozKAlXzQpo1FNfxGGEIwrCm2ve08=;
        b=NHuBrqGAN/rHvxnnORWCTMOjzUS5rVngctFsUrXWPGdQIVP7R1j8OEn1XMeHEVgR4S
         pHBmx6a4EWA4CNh6RwwI1HrGjrdX0MN/7I47meNAn5MRVLD+mmkugPsZYfSlJAWWbEgJ
         RMySrK4M6cveDnUQVM7SHq1Deh7VhLSdDRGEaP6aaNImJqRLT409+OP2m4o0nDZy+Gm2
         UhANw3244xpIXgza+9eZpAqKiensz6UqHRRyopXFQEEgIssX6w0marISDLDmUPVW8oCG
         H8E6NLpvToOUDJENiSJc2EhUgXXNXB7okaxg0h53LhkzHfHIlrAqn9HAQFyiV6x8RjpC
         cOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX70bMkeLM1nUQ6gaorfnkPuJHDSnUhBxcJksCHXJ6uiGjRnmT6j2UhX+DZEdfyh1w72+v9tQ/qq4QgOVxnq3ZyrblTt3kd8SniybRJly+JRy73XXpHtM68UQwOkGFo04GvMQiV6q7GvDzlJ81h895MBw==
X-Gm-Message-State: AOJu0YweLuO9ao5jdzxy7csvIkhCZ6MThyOtyDqCP6N++iBfcK6Na46m
	J5BM7YYNeIpjcv87lEy/Gjdy47Ra1U5tX4z2pBf4CDD4v5zbKHgh
X-Google-Smtp-Source: AGHT+IFCGsEmdwD1nv7fIOUqLYgOAgkQZolM0LpjQzM1sDVVyFIjmvmk64CnUpsfa8aXmUVyEZ2PgA==
X-Received: by 2002:ac2:4831:0:b0:51d:38ee:ddda with SMTP id 2adb3069b0e04-5221057932amr2261317e87.52.1715368952919;
        Fri, 10 May 2024 12:22:32 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1204:59b2:75a3:6a31:61d8? (soda.int.kasm.eu. [2001:678:a5c:1204:59b2:75a3:6a31:61d8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3367sm779234e87.145.2024.05.10.12.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 12:22:32 -0700 (PDT)
Message-ID: <b9ce0494-ab30-4647-9b0b-e01cc19dab23@gmail.com>
Date: Fri, 10 May 2024 21:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: bcfradella@proton.me, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ben Fradella <bfradell@netapp.com>, Ranjan Dutta <ranjan.dutta@intel.com>,
 Yifan2 Li <yifan2.li@intel.com>, Jonathan Yong <jonathan.yong@intel.com>
References: <20240509164905.41016-1-bcfradella@proton.me>
 <Zj0CIPR5djf0-hHb@wunner.de> <Zj40RnWnNqpr4Nom@smile.fi.intel.com>
Content-Language: en-US, sv-SE
In-Reply-To: <Zj40RnWnNqpr4Nom@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-10 16:50, Andy Shevchenko wrote:
> On Thu, May 09, 2024 at 07:04:32PM +0200, Lukas Wunner wrote:
>> [cc += Shin'ichiro, Klara, Andy, Danil]
> 
> Thank you!
> 
>> On Thu, May 09, 2024 at 04:49:34PM +0000, bcfradella@proton.me wrote:
>>> From: Ben Fradella <bfradell@netapp.com>
>>>
>>> The P2SB could get an invalid BAR from the BIOS, and that won't be fixed
>>> up until pcibios_assign_resources(), which is an fs_initcall().
>>>
>>> - Move p2sb_fs_init() to an fs_initcall_sync(). This is still early
>>>    enough to avoid a race with any dependent drivers.
>>>
>>> - Add a check for IORESOURCE_UNSET in p2sb_valid_resource() to catch
>>>    unset BARs going forward.
>>>
>>> - Return error values from p2sb_fs_init() so that the 'initcall_debug'
>>>    cmdline arg provides useful data.
> 
> ...
> 
>>>   /*
>>> - * pci_rescan_remove_lock to avoid access to unhidden P2SB devices can
>>> - * not be locked in sysfs pci bus rescan path because of deadlock. To
>>> - * avoid the deadlock, access to P2SB devices with the lock at an early
>>> - * step in kernel initialization and cache required resources. This
>>> - * should happen after subsys_initcall which initializes PCI subsystem
>>> - * and before device_initcall which requires P2SB resources.
>>> + * pci_rescan_remove_lock() can not be locked in sysfs pci bus rescan path
> 
> PCI bus
> 
>>> + * because of deadlock. To avoid the deadlock, access P2SB devices with the lock
>>> + * at an early step in kernel initialization and cache required resources.
>>> + *
>>> + * We want to run as early as possible. If the P2SB was assigned a bad BAR,
>>> + * we'll need to wait on pcibios_assign_resources() to fix it. So, our list of
>>> + * initcall dependencies looks something like this:
>>> + *
>>> + * ...
>>> + * subsys_initcall (pci_subsys_init)
>>> + * fs_initcall     (pcibios_assign_resources)
>>>    */
> 
> This makes sense to me
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I assume others will conduct the proper review and testing.
> 

This patch did not introduce any new issues on my previously problematic 
system.

Tested-by: Klara Modin <klarasmodin@gmail.com>

