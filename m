Return-Path: <linux-kernel+bounces-340479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0559873E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986B8B25EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C418B1A;
	Thu, 26 Sep 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWgvqaox"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451713B1A2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355302; cv=none; b=DGhdg5REhVoVJmkav35WEDeNHGaE8+mLLeDwYjdLtZ1WpMuzCQsqTSYtDu0VgVn4+ptZV6Tgd4sjdOM0qJxFC/NkpB/w4JU9l+5zowp8M6DnP9VQLGMUsdnRo3rW/r+jbdKI1lCY4KHKQGQIwD6WahK7Tcnd1ut3eUsw+Rrucj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355302; c=relaxed/simple;
	bh=9dF3iUa6yI45rbNEhrt2KS7zxt+OBwUq1cmjaZB+MwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjHFHkYm3+ISpjhAgu7FAG8GcfGtOnt4GQ1Yg6Gg7MffwNO4g+K8SbUynoawjbnA4OTDVCbdgrzvoPsDiOYrp9WGZCSCSzdc1eZdst8mjfviH6PL6/UpPfcBt/boLb8dyy4XF6q9GJOHker6egyZgGxurBchqEi4wQCTYGGl7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWgvqaox; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so8593705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727355298; x=1727960098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cZaKIW5ldYYCQ1aPFsfHBe6Iv8vNJVaxevOlWBwbC4=;
        b=bWgvqaox46N7ArwRF80TfxPewa4G96FRkEEJhHwuWGDF751qAcgIf1mRKRmka94X+L
         IZpk4tSUEf5YtILIQ+xnuuJ6L0JA5Va5FvGrTMMTUW6k3LEvl3iyzQxoyAcVsJzEnilj
         AxBkAVhNxk+RMwSrSbVvyG7kNwsHgAqfaiitoYHkAz1Tj7TVLJPBplz38VN3azHsCmvE
         Rvj+Eeo7iTwkgut+Sa7FAtTsDz9SRFJa9fITEPlPs8smvsLeiTx4U0H7B4wtonQEr/8m
         MQE7KV9qWGdHzDF8lrotJXWPv+HmSUmRu14eJmsKkJjl/dHpzRjYY2ggDOIh0IpajWu4
         Griw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355298; x=1727960098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cZaKIW5ldYYCQ1aPFsfHBe6Iv8vNJVaxevOlWBwbC4=;
        b=YrymRiUsfkBwnnDIW9Ant3n3gMpofrP61E1iVVet6dxTVIS8XRoFcirHpXAcZWEkc/
         1k6OpQnP0NgBSVD722l6bMp4GPW7gcMLZNqR9tN9IzD48l4Er/To2FBItri6hoAlWUhJ
         2o3ONtLYO8AVBFkDRQEEcN5EmAKqnIk3MjUi512BIoimFnIgV1kDxO69hUdQbGoZr4ET
         egzL6R8/cnuD1GjDT+bd/lLcwRmoo+Z1JobAW9Uzv3yTjlvHBocceIYA4+lV8wgXv4u5
         wTkW3OpIkQiEfKwyMuIrUeyWSyULR8CwkUwyNSMqwu8pTvs4JKARU+wT/pyhPIPdQBsU
         p3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+iilmrbgl0nyi7GDeQzFA+pdmjJrGSZEIWyF7FFvrheCrnLH8QVxhlcp2aaF0CPgrbq3lKSBMragstg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4RzuuH0GiMOKW0znZVfpcdKWdT+yHhQRaWmNmO1EeFBz4Be1
	z5gJ3Gcrcl6MhYSV9Qi0cJu2etclC+HkoVyoTfwtaR50FpSBsPa+
X-Google-Smtp-Source: AGHT+IHj+eQFxqE1o/0zIXDElkSnt7eSVT1uIM+o5YN/rZ/q/ajgSbgnrlmXv2q2hseljy469MHYqg==
X-Received: by 2002:a05:600c:1da4:b0:42c:b995:20c8 with SMTP id 5b1f17b1804b1-42e96146c36mr45702665e9.24.1727355298064;
        Thu, 26 Sep 2024 05:54:58 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cca11c20asm3421364f8f.41.2024.09.26.05.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:54:57 -0700 (PDT)
Received: by wheatley.localdomain (Postfix, from userid 1000)
	id AF15D2B294B9; Thu, 26 Sep 2024 14:54:56 +0200 (CEST)
Date: Thu, 26 Sep 2024 14:54:56 +0200
From: Martin Kletzander <nert.pinx@gmail.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <ZvVZoOm7R-dZ4N0_@wheatley.k8r.cz>
References: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
 <a7c80676-0761-4618-ac07-0b53434b1a9b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a7c80676-0761-4618-ac07-0b53434b1a9b@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Tue, Sep 24, 2024 at 10:46:10AM -0700, Reinette Chatre wrote:
>Hi Martin,
>
>On 9/24/24 1:53 AM, Martin Kletzander wrote:
>> The memory bandwidth value was parsed as unsigned long, but later on
>> rounded up and stored in u32.  That could result in an overflow,
>> especially if resctrl is mounted with the "mba_MBps" option.
>>
>> Switch the variable right to u32 and parse it as such.
>>
>> Since the granularity and minimum bandwidth are not used when the
>> software controller is used (resctrl is mounted with the "mba_MBps"),
>> skip the rounding up as well and return early from bw_validate().
>
>Since this patch will flow via the tip tree the changelog needs
>to meet the requirements documented in Documentation/process/maintainer-tip.rst
>Here is an example how the changelog can be when taking into account
>that context, problem, solution needs to be clearly separated with
>everything written in imperative mood:
>
>	The resctrl schemata file supports specifying memory bandwidth
>	associated with the Memory Bandwidth Allocation (MBA) feature
>	via a percentage (this is the default) or bandwidth in MiBps
>	(when resctrl is mounted with the "mba_MBps" option). The allowed
>	range for the bandwidth percentage is from
>	/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity
>	of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for
>	the MiBps bandwidth is 0 to U32_MAX.
>
>	There are two issues with parsing of MiBps memory bandwidth:
>	* The user provided MiBps is mistakenly round up to the granularity
>	  that is unique to percentage input.
>	* The user provided MiBps is parsed using unsigned long (thus accepting
>	  values up to ULONG_MAX), and then assigned to u32 that could result in
>	  overflow.
>
>	Do not round up the MiBps value and parse user provided bandwidth as
>	the u32 it is intended to be. Use the appropriate kstrtou32() that
>	can detect out of range values.
>

Great, can I use your commit message then?  I wouldn't be able to write
it as nicely =)

>
>This needs "Fixes" tags. Looks like the following are appropriate:
>Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
>Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
>

It seems to me like this should've been handled in commit 8205a078ba78
("x86/intel_rdt/mba_sc: Add schemata support") which added support for
mba_sc and kept the rounding up of the value while skipping the range
validation.

>> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>> Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>
>Please place your SoB at the end. For details about tag ordering
>you can refer to section "Ordering of commit tags" in
>Documentation/process/maintainer-tip.rst
>

I'll go through that docs too, thanks.

>
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 50fa1fe9a073..53defc5a6784 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -29,10 +29,10 @@
>>   * hardware. The allocated bandwidth percentage is rounded to the next
>>   * control step available on the hardware.
>>   */
>> -static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>> +static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>>  {
>> -	unsigned long bw;
>>  	int ret;
>> +	u32 bw;
>>
>>  	/*
>>  	 * Only linear delay values is supported for current Intel SKUs.
>> @@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>  		return false;
>>  	}
>>
>> -	ret = kstrtoul(buf, 10, &bw);
>> +	ret = kstrtou32(buf, 10, &bw);
>>  	if (ret) {
>> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
>> +		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
>>  		return false;
>>  	}
>>
>> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>> -	    !is_mba_sc(r)) {
>> +	/* Nothing else to do if software controller is enabled. */
>> +	if (is_mba_sc(r)) {
>> +		*data = bw;
>> +		return true;
>> +	}
>> +
>> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>>  				    r->membw.min_bw, r->default_ctrl);
>
>By now you may have noticed the lkp report [1] catching an issue with my
>code snippet. Could you please take a look? Seems that %u would be appropriate.
>

Yes, I finally got to it and %u should definitely work.  I wanted to go
with what seems more appropriate, PRIu32, but this file does not have
access to it and in order to include inttypes I would have to change the
Makefile too, which seems too much of a change given it takes me this
many tries already :)

However if PRIu32 is preferred I have no problem adjusting the build
process as well.

>>  		return false;
>> @@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  	struct resctrl_staged_config *cfg;
>>  	u32 closid = data->rdtgrp->closid;
>>  	struct rdt_resource *r = s->res;
>> -	unsigned long bw_val;
>> +	u32 bw_val;
>>
>>  	cfg = &d->staged_config[s->conf_type];
>>  	if (cfg->have_new_ctrl) {
>
>Reinette
>
>[1] https://lore.kernel.org/all/202409250046.1Kk0NXVZ-lkp@intel.com/
>
>

