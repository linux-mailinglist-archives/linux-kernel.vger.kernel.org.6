Return-Path: <linux-kernel+bounces-331419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2C97ACAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3551328CFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066E158DDF;
	Tue, 17 Sep 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiHjmTAe"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD08158A13
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560772; cv=none; b=hL1wmG6bE35GW5zvjxwgvg+4bcQsFL3b8zD5OuIbccDd0E3VE0UUuqbf/rCUlyt4yWeQY1nFiYZ4X/4pq3e2/ydmoAp2KBIAWBrwG9ffKnKpBmYbUH+FwE8/5fM5916C+lJramTb7ie11w7+WwZi6KpG7u1XOOw3Xwo4L/nT1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560772; c=relaxed/simple;
	bh=8V/T1TTeevqlCX6sEilsjYITxcGrjXtVA9d0RS9AbPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuBqzuCe9w1IgvhwrqEdfQylaVw8xv0led2zXOxk/id0SpWde4K2YvtrwS/C8uM9DpN8Wpyo7OTF//EMa7kfrRKzwvZc6w0R3j/lv6j9T8yXnQl8xmmOUMzfK6Kw8EMWlJS0MiOngdt5emGOVocXLIpXNPipq+4UU9+nlc5woso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiHjmTAe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374bd059b12so2557760f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726560769; x=1727165569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bquy4jUltDspN9IIfhBmZum+MJ8bB0D6RYnioOI8vO0=;
        b=PiHjmTAeXwNybGRupnT2KGKv9vITROkuAP+JzWF1Op+rXq/5XI44ZoDoOBJ8icS9kR
         ujAYyhsdy1l44krArq4SrTwOppfMuTaUFte9LtwbvoNyOWw7zySM2gnpJ6UtzIS6jNUZ
         kEesUT96pCLAA+4xFySPdTJWtRgI/3Sb+Nk28vrUBtvUjxBdLZN89KJ02LwksA8xk0O3
         x5yEX7+Jn/yAEO4kpQdVg9pkGu4yKesL4K4pw3nfJ2g86mkuN2P1kAVrLNPwXYpK7AIY
         3CeAXBfIlx6tLjnxu2qihi21jAI+S8KfCqvLbHq6wSHLmdWxI+NcK1Xlb+D5pbFMZIP1
         6bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726560769; x=1727165569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bquy4jUltDspN9IIfhBmZum+MJ8bB0D6RYnioOI8vO0=;
        b=wpKwh03xfXaWBL77+m/YnaQ9WH20qc2NYi+xhJQ/jySrT0RklGsIV4h/knUZBRxx+A
         3lVs3KM0nWY1IN5VEzwi0+1YN+9mylXpkWA4gv1C9wA56kbZHPiOkrtvE8Gz4QHe11fv
         6g6Lfxx1udYYtf4kIDE16S9xFrXwk2sGAGzd9KdofXkd9rj0OY8/NB3jVamaBGLPgXMP
         Vp0CBRqOdU+9wEaSLS4EXzblhLKMZsRmctX3ZuksqVgpEkkGa9KAwlCsPCrZkVPxPHOP
         qN7E504+K92B5H6AqYk0XK7DVbX0n4qgQrcLAYHYOfF2WJli55xs9jPJ76T9MgK/FNb4
         /8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWUoQUX3nuhaZ6ztTDT9yVLadAwmXfLRXL5bfoE3ENcwfun219k/BzSJdrwWCcDqMjgMWxSNaW44XAyDS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4aejzkizK86aveHeWDpiz6EbQ1iMMLw0yk6tIe2VuAZK0NGX
	P9LhTFTe4qImYHiuoehjc8Xp3eRhvIA310w8gBaj+56cdzCtaID9
X-Google-Smtp-Source: AGHT+IGqBXnxwo3Ay3fstrZ1vaLzbn3YjQWFKXdtUzhUFr5F9LCl1hAQIRuaDpH9z31MgxoOGvjh9w==
X-Received: by 2002:a5d:5c88:0:b0:378:e8b4:1900 with SMTP id ffacd0b85a97d-378e8b41a8dmr4423463f8f.41.1726560768889;
        Tue, 17 Sep 2024 01:12:48 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780defdsm8748313f8f.115.2024.09.17.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 01:12:48 -0700 (PDT)
Received: by wheatley.localdomain (Postfix, from userid 1000)
	id CE37C24C0BD8; Tue, 17 Sep 2024 10:12:47 +0200 (CEST)
Date: Tue, 17 Sep 2024 10:12:47 +0200
From: Martin Kletzander <nert.pinx@gmail.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <Zuk5_3qzSfld5dvD@wheatley.k8r.cz>
References: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
 <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Mon, Sep 16, 2024 at 09:56:01AM -0700, Reinette Chatre wrote:
>Hi Martin,
>
>On 9/16/24 6:07 AM, Martin Kletzander wrote:
>> When resctrl is mounted with the "mba_MBps" option the default (maximum)
>> bandwidth is the maximum unsigned value for the type.  However when
>> using the same value that already exists in the schemata file it is then
>> rounded up to the bandwidth granularity and overflows to a small number
>> instead, making it difficult to reset memory bandwidth allocation value
>> back to its default.
>>
>> Since the granularity and minimum bandwidth are not used when the
>> software controller is used (resctrl is mounted with the "mba_MBps"),
>> skip the rounding up as well and return early from bw_validate().
>
>Thank you very much for finding the issue and proposing a fix.
>
>>
>> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>> ---
>> Changes in v2:
>>   - actually save the value in the output parameter @data
>>
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 50fa1fe9a073..702b1a372e9c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -48,8 +48,13 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>   		return false;
>>   	}
>>
>> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>> -	    !is_mba_sc(r)) {
>> +	/* Nothing else to do if software controller is enabled */
>> +	if (is_mba_sc(r)) {
>> +		*data = bw;
>> +		return true;
>
>While this would fix the scenario tested I do not believe this fully addresses the
>overflow issue. As I understand the test wrote U32_MAX to the schemata file,
>which triggered the overflow because of the rounding and is fixed by this patch. Looks like,
>after this patch, writing "U32_MAX + 1" will still trigger the overflow.
>
>The overflow appears to result from some inconsistent type use and not using
>appropriate parsing API that is able to detect overflow.
>
>How about something like below:
>

That makes much more sense, I have not considered changing the data type
as I wanted to keep the changes at minimum, but your solution is even
better.  Should I leave the fix up to you or do you want me to send a v3?

>diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>index 50fa1fe9a073..53defc5a6784 100644
>--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>@@ -29,10 +29,10 @@
>   * hardware. The allocated bandwidth percentage is rounded to the next
>   * control step available on the hardware.
>   */
>-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
>-	unsigned long bw;
>  	int ret;
>+	u32 bw;
>
>  	/*
>  	 * Only linear delay values is supported for current Intel SKUs.
>@@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  		return false;
>  	}
>
>-	ret = kstrtoul(buf, 10, &bw);
>+	ret = kstrtou32(buf, 10, &bw);
>  	if (ret) {
>-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
>+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
>  		return false;
>  	}
>
>-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>-	    !is_mba_sc(r)) {
>+	/* Nothing else to do if software controller is enabled. */
>+	if (is_mba_sc(r)) {
>+		*data = bw;
>+		return true;
>+	}
>+
>+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>  				    r->membw.min_bw, r->default_ctrl);
>  		return false;
>@@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	struct resctrl_staged_config *cfg;
>  	u32 closid = data->rdtgrp->closid;
>  	struct rdt_resource *r = s->res;
>-	unsigned long bw_val;
>+	u32 bw_val;
>
>  	cfg = &d->staged_config[s->conf_type];
>  	if (cfg->have_new_ctrl) {
>
>
>
>> +	}
>> +
>> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>>   		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>>   				    r->membw.min_bw, r->default_ctrl);
>>   		return false;
>
>Reinette

