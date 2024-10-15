Return-Path: <linux-kernel+bounces-366000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1599EF62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C145F1F2604C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CE1C4A12;
	Tue, 15 Oct 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkJVkntR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD9149E16;
	Tue, 15 Oct 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002147; cv=none; b=d93qyra2HcjLkwY7og5/GS6K7kz1rROM51E1Ku1/RBOFmhFKVNAL5lR4y6MPORfRCGxlHe77+O3olGxrS4bs6CMU1nljBN7RcRNvZzGYRkll7sxgrZDb3R/oj0qMsVSxXQJ5eeHQCy9B62/eAuppqqkrO0THJVz14wRqQD2h1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002147; c=relaxed/simple;
	bh=3lH1yDNH4/NXorniCVSsSt3aItdm4wsD0ht4IfwjUAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO32FNHwr8m865FpGvJyRu3NhlOYm71UhpssX2rpn4hiuxCuFCa6Fa1Z6MQugGMNPh9K8dxabqiaNeVeqFFvtGxzZN8pnzeEPGS1x64Skr2thlyfE9r8j4E4ygR8LsmjsUynDk1A2BSYseTj8BnSLBgZph4o8ORnKHvhUzMzAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkJVkntR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167B0C4CEC6;
	Tue, 15 Oct 2024 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002145;
	bh=3lH1yDNH4/NXorniCVSsSt3aItdm4wsD0ht4IfwjUAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkJVkntRx2kEp8kOuI0hdS8kyQbP+qTDOyl75hWJ1QC9c96KQRoZ4paUJpy0KVrdv
	 IdtnNyuuVqdfB0TZpDUQWkuxVVuCjjuuBX0XJmbuwE1B918NdJCm25kKYddE0p/ZNV
	 kncsLrZF8/fcsIaXRVavjOwPaOBWBedn8qOVuiKpvZyqQ76GEcm+1mzKOvy6pVHVnI
	 uAc5fSsmPCp822btHW9k8jE2CtZmFD/g1ZHC9XAz8dIJpNuLzBAr65GAgrlp5K24VM
	 7w1TrL9iPeVxG1WxNDxg5iqaDa9dMTGkVR8Sui8k1lj9t00ReQ1WPEuOp3KhP+wV8P
	 q/HBjYdy4p15w==
Date: Tue, 15 Oct 2024 16:22:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3 16/16] checkpatch: Remove broken sleep/delay related
 checks
Message-ID: <Zw56n9P0Io1bMb0y@localhost.localdomain>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
 <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>

Le Mon, Oct 14, 2024 at 10:22:33AM +0200, Anna-Maria Behnsen a écrit :
> checkpatch.pl checks for several things related to sleep and delay
> functions. In all warnings the outdated documentation is referenced. All
> broken parts are listed one by one in the following with an explanation why
> this check is broken. For a basic background of those functions please also
> refere to the updated function descriptions of udelay(), nsleep_range() and
> msleep().
> 
> Be aware: The change is done with a perl knowledge of the level "I'm able
> to spell perl".
> 
> The following checks are broken:
> 
> - Check: (! ($delay < 10) )
>   Message: "usleep_range is preferred over udelay;
>             see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: When it is an atomic context, udelay() is
>                            mandatory.
> 
> - Check: ($min eq $max)
>   Message:  "usleep_range should not use min == max args;
>              see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: When the requested accuracy for the sleep
>                            duration requires it, it is also valid to use
>                            min == max.
> 
> - Check: ($delay > 2000)
>   Message: "long udelay - prefer mdelay;
>             see arch/arm/include/asm/delay.h\n"
>   Why is the check broken: The threshold when to start using mdelay() to
>                            prevent an overflow depends on
>                            MAX_UDELAY_MS. This value is architecture
>                            dependent. The used value for the check and
>                            reference is arm specific. Generic would be 5ms,
>                            but this would "break" arm, loongarch and mips
>                            and also the arm value might "break" mips and
>                            loongarch in some configurations.
> 
> - Check: ($1 < 20)
>   Message: "msleep < 20ms can sleep for up to 20ms;
>             see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: msleep(1) might sleep up to 20ms but only on a
>                            HZ=100 system. On a HZ=1000 system this will be
>                            2ms. This means, the threshold cannot be hard
>                            coded as it depends on HZ (jiffy granularity and
>                            timer wheel bucket/level granularity) and also
>                            on the required accuracy of the callsite. See
>                            msleep() and also the USLEEP_RANGE_UPPER_BOUND
>                            value.
> 
> Remove all broken checks. Update checkpatch documentation accordingly.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v3: Move it to the end of the queue and adapt it to the new patch which
>     removes the link to the outdated documentation before.
> v2: Rephrase commit message
> ---
>  Documentation/dev-tools/checkpatch.rst |  4 ----
>  scripts/checkpatch.pl                  | 38 ----------------------------------
>  2 files changed, 42 deletions(-)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index abb3ff682076..f5c27be9e673 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -466,10 +466,6 @@ API usage
>    **UAPI_INCLUDE**
>      No #include statements in include/uapi should use a uapi/ path.
>  
> -  **USLEEP_RANGE**
> -    usleep_range() should be preferred over udelay(). The proper way of
> -    using usleep_range() is mentioned in the kernel docs.
> -
>  
>  Comments
>  --------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 98790fe5115d..34d4b5beda29 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6591,28 +6591,6 @@ sub process {
>  			}
>  		}
>  
> -# prefer usleep_range over udelay
> -		if ($line =~ /\budelay\s*\(\s*(\d+)\s*\)/) {
> -			my $delay = $1;
> -			# ignore udelay's < 10, however
> -			if (! ($delay < 10) ) {
> -				CHK("USLEEP_RANGE",
> -				    "usleep_range is preferred over udelay; see function description of usleep_range() and udelay().\n" . $herecurr);
> -			}
> -			if ($delay > 2000) {
> -				WARN("LONG_UDELAY",
> -				     "long udelay - prefer mdelay; see function description of mdelay().\n" . $herecurr);
> -			}
> -		}
> -
> -# warn about unexpectedly long msleep's
> -		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
> -			if ($1 < 20) {
> -				WARN("MSLEEP",
> -				     "msleep < 20ms can sleep for up to 20ms; see function description of msleep().\n" . $herecurr);
> -			}
> -		}
> -
>  # check for comparisons of jiffies
>  		if ($line =~ /\bjiffies\s*$Compare|$Compare\s*jiffies\b/) {
>  			WARN("JIFFIES_COMPARISON",
> @@ -7069,22 +7047,6 @@ sub process {
>  			}
>  		}
>  
> -# check usleep_range arguments
> -		if ($perl_version_ok &&
> -		    defined $stat &&
> -		    $stat =~ /^\+(?:.*?)\busleep_range\s*\(\s*($FuncArg)\s*,\s*($FuncArg)\s*\)/) {
> -			my $min = $1;
> -			my $max = $7;
> -			if ($min eq $max) {
> -				WARN("USLEEP_RANGE",
> -				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
> -			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
> -				 $min > $max) {
> -				WARN("USLEEP_RANGE",
> -				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");

Why not keep the min > max static check?

Thanks.

> -			}
> -		}
> -
>  # check for naked sscanf
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> 
> -- 
> 2.39.5
> 

