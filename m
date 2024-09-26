Return-Path: <linux-kernel+bounces-340731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703A987727
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E0E1C21E71
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53475153BF7;
	Thu, 26 Sep 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqevvK6i"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BE1BC4E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366525; cv=none; b=slfhNrvHohtZ8RwORlbqvXvNxF/AJA95rRUE+MhJmTxwG6coqX2lJCkW3zKG9R7T0JQMAPpVYeO324T29Gn9UZSjHGIj4grs639/4d3UzRGQKei707KH7ANTRb2jay19VVDzy6WCti2yxtkouWDpztVFTRt4BBNbOisXdLqnMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366525; c=relaxed/simple;
	bh=4aceUhrYPH839zLVrSqN3cR9BHC58eWvYRt1F8Wzdm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1kOr56pNHD1TApaq6xu3xZ2U/wGF84aNfqJbrKEEMru7OoYnJGsvBw9y+4oCA/6Zw1T9uGn9tkHZFRmDBPaEvIqZuF0HH0W2D+BQa2ekA+50+XOimI/g1TP8X8jPpgLRE2EWZiV7sABJ/C+q61UDym7UwPQdOeWTex9Jul6EL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqevvK6i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb806623eso10044075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366522; x=1727971322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wXD3NXhjfyRcts79w/bA8m88oNJIZx93Kf2xOvSY0A=;
        b=aqevvK6inGsS5pro6+hPsQZE1oqKr6tiiO6Swp1HxtZPqZKJH/bK49YSX7Q+DDljhS
         U6KT1tT7TYQZFu2CoTZpZcg4vXd3xkj7kKAAWxAE7C3AAxhAcS7sbPzgZQIfvZ+RzM0y
         J4znggFfAmn0KJ1nEwqKfZSGKzIZt5PYjvS1atnP72ua5HoXOR3ksbR1FYzyRnkMuqgB
         5YQx+zxwESF9ebHrUdA/s/ZNSuJYidEiWtOEEQwnx3dWvCH9E/2IZVDyO+CJ4nCtKLNd
         g5r8G5EIUb8sGbgxGZw9Y8hIJPAHMjo+jA3HcQMir2v49jWkUxQyPY6u98Qvgo/tDex/
         U9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366522; x=1727971322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wXD3NXhjfyRcts79w/bA8m88oNJIZx93Kf2xOvSY0A=;
        b=Gm04ZD7RhhSrmTobqBHEvS33zTZR3qbbVxU2xfeJRqUcgyuxj6VHwgU0H6+sZLuxIT
         rtgHtAnD8tKV3GRTwFJY0ZuIz3dVlKjF5yPkHeM0R3RsvJXaqFo0uoJ+SNUNUF99e8p1
         5YfaIhDQs/rns0005YnYN5ONvCGV0zmAIpY3ATvvB1WOvRnpmYaRUXVX26AwUEihs6PW
         4a6h6pHuCHjOE0ugVxbWRvXVfAkLUNpwZpd7h3loaFvxcOwbxaw3LLTlp3BzoxEp1Dc6
         Hz37yvAbXETZ7CyjWK62H1RoCk1W0RQsapwl9RiVYU6ccit6M1rEVW9QleVexekRvrIZ
         059Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpgjib0Jr4rGA4houbIc9csy8kREjLh9hHw1Ga21uNpaDwRzaYUQHiWgjB4FYUqNCr/RA1R/efFFNz5LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaK1NIRLihH0WPOwii4xrqXd1FHczkpygT9NprkxKvNqrDZtHF
	W5wZhXH16EYN3jkeCfRhttC20OOXPVb4axiXBds1uKkE6q/+eeQ7
X-Google-Smtp-Source: AGHT+IEymn8CsnP4n2mcbJfdOh/y10WAdYahbZJ7ZtftZTIzP0yR/IiAMrDFsqquOrl7lvqpOjdK4Q==
X-Received: by 2002:a05:600c:3b97:b0:42c:c1f6:6ded with SMTP id 5b1f17b1804b1-42e96242c55mr54746205e9.29.1727366518720;
        Thu, 26 Sep 2024 09:01:58 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730fbbsm162064f8f.77.2024.09.26.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:01:57 -0700 (PDT)
Received: by wheatley.localdomain (Postfix, from userid 1000)
	id 20A742B33EA6; Thu, 26 Sep 2024 18:01:57 +0200 (CEST)
Date: Thu, 26 Sep 2024 18:01:57 +0200
From: Martin Kletzander <nert.pinx@gmail.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <ZvWFdUDWXuIL_x7a@wheatley.k8r.cz>
References: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
 <a7c80676-0761-4618-ac07-0b53434b1a9b@intel.com>
 <ZvVZoOm7R-dZ4N0_@wheatley.k8r.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZvVZoOm7R-dZ4N0_@wheatley.k8r.cz>
X-Clacks-Overhead: GNU Terry Pratchett

On Thu, Sep 26, 2024 at 02:54:56PM +0200, Martin Kletzander wrote:
>On Tue, Sep 24, 2024 at 10:46:10AM -0700, Reinette Chatre wrote:
>>Hi Martin,
>>
>>On 9/24/24 1:53 AM, Martin Kletzander wrote:
>>> The memory bandwidth value was parsed as unsigned long, but later on
>>> rounded up and stored in u32.  That could result in an overflow,
>>> especially if resctrl is mounted with the "mba_MBps" option.
>>>
>>> Switch the variable right to u32 and parse it as such.
>>>
>>> Since the granularity and minimum bandwidth are not used when the
>>> software controller is used (resctrl is mounted with the "mba_MBps"),
>>> skip the rounding up as well and return early from bw_validate().
>>
>>Since this patch will flow via the tip tree the changelog needs
>>to meet the requirements documented in Documentation/process/maintainer-tip.rst
>>Here is an example how the changelog can be when taking into account
>>that context, problem, solution needs to be clearly separated with
>>everything written in imperative mood:
>>
>>	The resctrl schemata file supports specifying memory bandwidth
>>	associated with the Memory Bandwidth Allocation (MBA) feature
>>	via a percentage (this is the default) or bandwidth in MiBps
>>	(when resctrl is mounted with the "mba_MBps" option). The allowed
>>	range for the bandwidth percentage is from
>>	/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity
>>	of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for
>>	the MiBps bandwidth is 0 to U32_MAX.
>>
>>	There are two issues with parsing of MiBps memory bandwidth:
>>	* The user provided MiBps is mistakenly round up to the granularity
>>	  that is unique to percentage input.
>>	* The user provided MiBps is parsed using unsigned long (thus accepting
>>	  values up to ULONG_MAX), and then assigned to u32 that could result in
>>	  overflow.
>>
>>	Do not round up the MiBps value and parse user provided bandwidth as
>>	the u32 it is intended to be. Use the appropriate kstrtou32() that
>>	can detect out of range values.
>>
>
>Great, can I use your commit message then?  I wouldn't be able to write
>it as nicely =)
>
>>
>>This needs "Fixes" tags. Looks like the following are appropriate:
>>Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
>>Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
>>
>
>It seems to me like this should've been handled in commit 8205a078ba78
>("x86/intel_rdt/mba_sc: Add schemata support") which added support for
>mba_sc and kept the rounding up of the value while skipping the range
>validation.
>
>>> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>>> Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>>Please place your SoB at the end. For details about tag ordering
>>you can refer to section "Ordering of commit tags" in
>>Documentation/process/maintainer-tip.rst
>>
>
>I'll go through that docs too, thanks.
>
>>
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++-------
>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> index 50fa1fe9a073..53defc5a6784 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> @@ -29,10 +29,10 @@
>>>   * hardware. The allocated bandwidth percentage is rounded to the next
>>>   * control step available on the hardware.
>>>   */
>>> -static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>> +static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>>>  {
>>> -	unsigned long bw;
>>>  	int ret;
>>> +	u32 bw;
>>>
>>>  	/*
>>>  	 * Only linear delay values is supported for current Intel SKUs.
>>> @@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>>  		return false;
>>>  	}
>>>
>>> -	ret = kstrtoul(buf, 10, &bw);
>>> +	ret = kstrtou32(buf, 10, &bw);
>>>  	if (ret) {
>>> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
>>> +		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
>>>  		return false;
>>>  	}
>>>
>>> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>>> -	    !is_mba_sc(r)) {
>>> +	/* Nothing else to do if software controller is enabled. */
>>> +	if (is_mba_sc(r)) {
>>> +		*data = bw;
>>> +		return true;
>>> +	}
>>> +
>>> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>>>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>>>  				    r->membw.min_bw, r->default_ctrl);
>>
>>By now you may have noticed the lkp report [1] catching an issue with my
>>code snippet. Could you please take a look? Seems that %u would be appropriate.
>>
>
>Yes, I finally got to it and %u should definitely work.  I wanted to go
>with what seems more appropriate, PRIu32, but this file does not have
>access to it and in order to include inttypes I would have to change the
>Makefile too, which seems too much of a change given it takes me this
>many tries already :)
>
>However if PRIu32 is preferred I have no problem adjusting the build
>process as well.
>

Disregard this, I found out the only uses of PRIu32 are in code that has
access to glibc (scripts, tools, etc.), sorry for the noise.

>>>  		return false;
>>> @@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>>  	struct resctrl_staged_config *cfg;
>>>  	u32 closid = data->rdtgrp->closid;
>>>  	struct rdt_resource *r = s->res;
>>> -	unsigned long bw_val;
>>> +	u32 bw_val;
>>>
>>>  	cfg = &d->staged_config[s->conf_type];
>>>  	if (cfg->have_new_ctrl) {
>>
>>Reinette
>>
>>[1] https://lore.kernel.org/all/202409250046.1Kk0NXVZ-lkp@intel.com/
>>
>>

