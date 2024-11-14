Return-Path: <linux-kernel+bounces-409653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662799C9058
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF93CB33EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2E185923;
	Thu, 14 Nov 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GNqBNj4O"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AC15573F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601560; cv=none; b=liPB0pFFR1OnaW65ulnCNEDI9Id1hnTSNsPAruIotJwYWpniPDs8x4sctABnwMiKeYdpF8UOFZcMklUfid+4rGjQPJ3kqdLOOx/OrxQ21Oi6z6DfgGhhPn7S43AJkwyBJlu2efdRvoz9gTbWFMAWiSMo2r+IEssoeR/ex8P62Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601560; c=relaxed/simple;
	bh=2azEyOOIZxWLX+rEYvWlTcO3ezizSL/hvIbb6FpDcpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLiTCfiyRuox2n/YYxaJkpNYc9iiD8hUJpAzQrM1jtn/gsKKBP6ET8fY9ii7nuCElwY8aYHL5uwH/3vse9KmoFoCTUQKRuXRXFlLkEz9OMpK6o/z4AjH1s2pRiOkqGUd8t/nxF39mlM0KEihNTd+D8dpo5zxSTYq1QQ+/7Sqd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GNqBNj4O; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315abed18aso7101995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731601556; x=1732206356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BE6I/9hvASyou65NVg1AR4ngJ2iceiPqDij9FkZy+k=;
        b=GNqBNj4OfhGblH0DVADhWfoYGy/IYicJgfnHVfMLMiFEJGpDWbFyP6KUNj84OPX3mh
         RRS+gUe6QcbhkSf6PPbhSVqwIlfpp/soG1/TlS+iidB5GKneExbV91wzOnQPccJXf+KO
         eyCJjhbv27AQsFA94zh1klaTCcBMmhq2iVwcfHmryBWqJNj7PSRpCMhA+/dRDtxJEGTU
         z8gpu4OoGvegmr8JoIoXWN0VK/m0Ys4Hjb2LMWAzb++wWKysS9WUfapfsxm2OhB69MMJ
         uokXo3THYariwr0CUhoIudHmPuwZ+xxfPZCX41rHrsexIJJMuheJcazThdrDhHSZSB04
         qtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601556; x=1732206356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BE6I/9hvASyou65NVg1AR4ngJ2iceiPqDij9FkZy+k=;
        b=AI7ztlfZtQh0QdaUm7E3hZp7KHrNrPxgpvT7lWeV5pr+pOwoswnvfnZNkYdwAv+8eN
         N1AEuiyqGOnkiXS7SytrSXmYQPZIx0sXva5AY99+2qJWRu8MPENI8ulfSK12B4ZVMs9u
         V/VJc6/J5UKfAAfOMs2fx+q/fj9xsXr4n1f1hkb1ft1K7uBr6f2QX9GGQm6/+xSYioVN
         WE6uAd9PSMGYGXdiKnVW/L9pp68xr4BJ0ZmIPspfMcxTgy9xmfFMVz08u2jiok7iqp2h
         TbDAOxigswp/7W9iJcMSphdiuooMh7IYx6tTzNd3zF+r4Hy7Jau/NvW7GyRDDlZDJwNv
         R6eg==
X-Gm-Message-State: AOJu0YybnVr+Tjq7iNQsdFAoeJLZXplbmElbsPTUhfsS4WJfOz+5XHWv
	J9sjHtMKwn/UosRV6bM+Og/pqzFpFaSgJMmMFqNaKM6PG7gjg/4DsB1CIEf37Bw=
X-Google-Smtp-Source: AGHT+IHAnY0K/EIVanBDErUG4RzaQT7euR3moULobLera/Okal5DgpXT0gPZLbOHB1Q4UJE+oStA5Q==
X-Received: by 2002:a05:600c:384e:b0:431:3a6d:b84a with SMTP id 5b1f17b1804b1-432da767a27mr26544845e9.4.1731601556157;
        Thu, 14 Nov 2024 08:25:56 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265ca8sm28895635e9.14.2024.11.14.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:25:55 -0800 (PST)
Date: Thu, 14 Nov 2024 17:25:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 10/11] printk: Deprecate the kernel.printk sysctl
 interface
Message-ID: <ZzYkkTHJFNnvJBh0@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <993d978d4a59dd370ac39c6c24c9b72c11f4dc74.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993d978d4a59dd370ac39c6c24c9b72c11f4dc74.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:59, Chris Down wrote:
> The kernel.printk sysctl interface is deprecated in favour of more
> granular and clearer sysctl interfaces for controlling loglevels, namely
> kernel.console_loglevel and kernel.default_message_loglevel.
> 
> kernel.printk has a number of fairly significant usability problems:
> 
> - It takes four values in a specific order, which is not intuitive.
>   Speaking from personal experience, even people working on printk
>   sometimes need to look up the order of these values, which doesn't
>   suggest much in the way of perspicuity.
> - There is no validation on the input values, so users can set them to
>   invalid or nonsensical values without receiving any errors or
>   warnings. This can lead to unpredictable behaviour.
> - One of the four values, default_console_loglevel, is not used in the
>   kernel (see below), making it redundant and potentially confusing.
> - Overall, the interface is complex, hard to understand, and combines
>   multiple controls into a single sysctl, which is not ideal. It should
>   be separated into distinct controls for clarity.
> 
> Setting kernel.printk now calls printk_sysctl_deprecated, which emits a
> pr_warn. The warning informs users about the deprecation and suggests
> using the new sysctl interfaces instead.
> 
> By deprecating kernel.printk, we aim to:
> 
> - Encourage users to adopt the new, dedicated sysctl interfaces
>   (kernel.console_loglevel and kernel.default_message_loglevel), which
>   are more straightforward and easier to understand.
> - Improve input validation and error handling, ensuring that users
>   receive appropriate feedback when setting invalid values.
> - Simplify the configuration of loglevels by exposing only the controls
>   that are necessary and relevant.
> 
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -7,6 +7,7 @@
>  #include <linux/printk.h>
>  #include <linux/capability.h>
>  #include <linux/ratelimit.h>
> +#include <linux/console.h>
>  #include "internal.h"
>  
>  static const int ten_thousand = 10000;
> @@ -46,13 +47,24 @@ static int printk_console_loglevel(const struct ctl_table *table, int write,
>  	return 0;
>  }
>  
> +static int printk_sysctl_deprecated(const struct ctl_table *table, int write,
> +				    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int res = proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +	if (write)
> +		pr_warn_once("printk: The kernel.printk sysctl is deprecated. Consider using kernel.console_loglevel or kernel.default_message_loglevel instead.\n");
> +
> +	return res;
> +}
> +
>  static struct ctl_table printk_sysctls[] = {
>  	{
>  		.procname	= "printk",
>  		.data		= &console_loglevel,
>  		.maxlen		= 4*sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= printk_sysctl_deprecated,

I would prefer to follow the existing naming scheme for
custom modifications of proc_dointvec() and call it
"proc_dointvec_printk_deprecated".

>  	},
>  	{
>  		.procname	= "printk_ratelimit",

With this cosmetic change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


