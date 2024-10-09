Return-Path: <linux-kernel+bounces-357032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE125996AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A21F21F88
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DA199FAE;
	Wed,  9 Oct 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0mh2efb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C191199EAF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477905; cv=none; b=heOBhEwSRwnzkxL8dXV/Std00f722scmHGwc6JuhWkf7aDb9khgvsm5jg6RwLHPRfBa1zsGDX1SUyHw8aLmp5sl1Uiha1FkXmj6S0suFo7F99d1BlgHEB5pHSh+eGFNFKNfxDWe8Dbukq3qOoRp3FHvsEiw14ZLK6n7FlBJS6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477905; c=relaxed/simple;
	bh=qwtNXNyM7VSYbG0Hk0UVI5t1PmxOHnEFqBivgH8sEBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecga7t/7W+y/79l+PZLXT88dPugcusMq5YK7uPvlyr8GcAdOv07/Tfqkaxdp9fC8BUlkTxgWsNI6FvjAGJqf5dSwp9Tdb36OVEP5FAHM7eArzd0pr+Yk5TEerIP8FPffVBBUIUu1yl4cHlPzKSo1OMybEO7iebAcBk/C+IhSx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0mh2efb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCC7C4CEC5;
	Wed,  9 Oct 2024 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728477905;
	bh=qwtNXNyM7VSYbG0Hk0UVI5t1PmxOHnEFqBivgH8sEBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0mh2efbGiwAsh4eZhuTPlpyre/nFnMdp3Slw9JUJGwkK7YzZVFy6qQ/WtKB3GTQr
	 hyewtYLsU40l4e5JGaYJwTbxxh1YCtfvt2YkiiD93MscIEGsjHqDbUwcX8TcPsx4rO
	 UDbl8BBSqykhRSA99BeHKCv57mLq+1tfFuDthBmGv0W/CKl4Sgnbm3WA6BtxGsanWw
	 OQi0XiIejW4yr2uM2U1QQq3Z5WTLnsmDjNRcbKjmV4V0g6mOsPkrJWNckPAVQVPtUl
	 uncMx1gaCXEyBigCJYpPh59xrMLkpWnh6F4/OWT/8yKKcyz/Mj2Vfi9W0DuUqUZei1
	 5OGBwPy6HVaEA==
Date: Wed, 9 Oct 2024 14:45:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v2 10/15] checkpatch: Remove broken sleep/delay related
 checks
Message-ID: <ZwZ6zsC_4X3OfGSQ@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-10-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-10-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:36AM +0200, Anna-Maria Behnsen a �crit :
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

Acked-by: Frederic Weisbecker <frederic@kernel.org>

