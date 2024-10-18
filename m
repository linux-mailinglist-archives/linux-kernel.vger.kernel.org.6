Return-Path: <linux-kernel+bounces-371676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433599A3E77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688E91C238C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8074084C;
	Fri, 18 Oct 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUD+nsid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01315E8B;
	Fri, 18 Oct 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254699; cv=none; b=Tc++ozQXWsv2rsZFHHwlLxGxysGp6s5sIqTtIsEAnplsk7wOsv6qzz9X/IJ4GlFjfccrvbY+RDYcEWcUvStKeAb3BFLBAGu8ZsJaECiztUcSca8Wa7Bz9TGdev3CFLuNOQVqEnpGpguY+sVN3vFxd3pQGQQbjJ+peEJHm4XuwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254699; c=relaxed/simple;
	bh=2+K8JMMFpl8RPAVm0w2i40EW28QgBoA4YuGXOYb4GiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSKUphduEPczf/t4EqL4IFMzsAkQoDqYmiAWXpjMuAYPLEEg8o9KKW+22RkN4z+svM5HxgScLyhwBWqBlpR8DNCIYNxjuBrsfdTwaS+MPmSkx3f7qLbG/t1/Q9XqlVVXE3yZub5wyEvP8wvWjRg2EUqU87nWU8MB0XX6RcLrFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUD+nsid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FFFC4CEC3;
	Fri, 18 Oct 2024 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729254698;
	bh=2+K8JMMFpl8RPAVm0w2i40EW28QgBoA4YuGXOYb4GiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUD+nsid9VzEBbh2NmxFsxNQBGXprPAjlVdjqbi13ZKRToLz4C2Ly9X+waY/tatkX
	 NjSpVEb886Lul0a4pZn50e3Lv4x7jpGNT5T/HOtQau3BrZNG/TCV5qPQs3r4jvNQWM
	 OxHZvChkmadG7HcOhMYuS90CdtdWQjr3RmLLCl6+hj02GEY+KAN9b8DAKgesFNK3uL
	 jJFlAcCw6vf40aI2fJgZ+j7sRzvOpLQ1n9Hyqpj7KzJiR2g/VLZfS9YgsfDCPMH8Ba
	 bIzbyBsN+MITSGzEmt8R2ZxDzVN1i5W0NmWrCiNrw2nGYV2V1sJIlKQn0yZGIuTPMC
	 P/DhNc7AfGpfg==
Date: Fri, 18 Oct 2024 14:31:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v4] checkpatch: Remove broken sleep/delay related checks
Message-ID: <ZxJVKEouOke_sbd9@localhost.localdomain>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>
 <20241016100531.7153-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016100531.7153-1-anna-maria@linutronix.de>

Le Wed, Oct 16, 2024 at 12:05:31PM +0200, Anna-Maria Behnsen a écrit :
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

