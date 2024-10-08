Return-Path: <linux-kernel+bounces-355936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4799596D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE23D1C21D93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA017DFE1;
	Tue,  8 Oct 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JniwNCvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FD14A82
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423930; cv=none; b=mg8yRPH+Cbu0eY4RrbsEVVTypSG9JLIz6hI08GEnEihySSkSPkzFxHxzADJ44LiBgLvLcBu7lE6BLVvNKiNAR5MISq3vBDx/5v3ihKWsWhY8gPTv47q4Q0THsfAWRyfZqoxu4DGWqsL6urt4kO6lQxiIKH9ecK9LLM7w+5RjKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423930; c=relaxed/simple;
	bh=tRhLXlVTPcGTkKXclxZvDizz1TaahzHko/T/cahcp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzkqNutsiLDdfLG3G2X2BfV1Rq16KycLWkncnkljbe3wC89NK+PuH27zKucDAOCU5oegnHjdi0U+ElfNzfy5nAXaJUuA+b/SnXQtquREPhqizCJVG1+INHHokk7d7541uDYeUevL4eHQC4QcZYCXaGhmFukmI119/e4wFek+1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JniwNCvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC84AC4CEC7;
	Tue,  8 Oct 2024 21:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728423929;
	bh=tRhLXlVTPcGTkKXclxZvDizz1TaahzHko/T/cahcp+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JniwNCvgvY1s6AmVO3CQ6REBx2UeN1aT/Ox2JjSTBd4Ks7ziVKJXd8zch0uoMzlGQ
	 Pa9MIj30yiIVo8lv9dpojH/c2gOiudC6GPwQh8PguGxnFVlI1eq7oPAz0LVQOrv5eX
	 O4QYXmYFrr/GvHv4ezGcEaNPG504ycQHMdeC/y0vui/5XT17L3dUM5uSa4nxFoc6tW
	 O249KDnJ3K1e64UXwJP9ZIaKtIRw1BYpWLCsOGtugmfZh2oUVLa0S5lylhtd8+4/78
	 BNh2jG7hLVEMlS7RI64OZubZv9BbwjmbTd2AU+X1mooagqrwjAAQet+fk+IA1vbNH8
	 +axm5OMlbiAKw==
Date: Tue, 8 Oct 2024 23:45:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 07/15] timers: Adjust flseep() to reflect reality
Message-ID: <ZwWn9m2y1DmyavgX@pavilion.home>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-7-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-7-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:33AM +0200, Anna-Maria Behnsen a écrit :
> fsleep() simply implements the recommondations of the outdated

recommendations*

> documentation in "Documentation/timers/timers-howto.rst". This should be a
> user friendly interface to choose always the best timeout function
> approach:
> 
> - udelay() for very short sleep durations shorter than 10 microseconds
> - usleep_range() for sleep durations until 20 milliseconds
> - msleep() for the others
> 
> The actual implementation has several problems:
> 
> - It does not take into account that HZ resolution also has an impact on
>   granularity of jiffies and has also an impact on the granularity of the
>   buckets of timer wheel levels. This means that accuracy for the timeout
>   does not have an upper limit. When executing fsleep(20000) on a HZ=100
>   system, the possible additional slack will be 50% as the granularity of
>   the buckets in the lowest level is 10 milliseconds.
> 
> - The upper limit of usleep_range() is twice the requested timeout. When no
>   other interrupts occur in this range, the maximum value is used. This
>   means that the requested sleep length has then an additional delay of
>   100%.
> 
> Change the thresholds for the decisions in fsleep() to make sure the
> maximum slack which is added to the sleep duration is 25%.
> 
> Note: Outdated documentation will be updated in a followup patch.
> 
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  include/linux/delay.h | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index 23623fa79768..b49a63c85c43 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/math.h>
>  #include <linux/sched.h>
> +#include <linux/jiffies.h>
>  
>  extern unsigned long loops_per_jiffy;
>  
> @@ -102,15 +103,35 @@ static inline void ssleep(unsigned int seconds)
>  	msleep(seconds * 1000);
>  }
>  
> -/* see Documentation/timers/timers-howto.rst for the thresholds */
> +static const unsigned int max_slack_shift = 2;

Should it be a define? (such const variables are usually for arrays).

Anyway:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

