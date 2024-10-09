Return-Path: <linux-kernel+bounces-356982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D319969DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9291F2378C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FC192D91;
	Wed,  9 Oct 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBtHeT28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336961922DE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476540; cv=none; b=IYdqslJf3DQhvXgqO4dKggC+wY4WqWwPsSUU81TEDP1wX2Kxq1dVuyVWgdSg2KU1DymiS4Mq/T3nlZgZbvTw5lqWsMhBaMxKn3pqlKNKvJ0ju7XEw1dgRmiyZS913np3kAY/wb9IUu94tZCbK+UtmXwE6lrxbnPJ/tKuLPz10Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476540; c=relaxed/simple;
	bh=pfpkVqS/zK73IKhw6LUi9n/2MQuf2vXG6yP2uBgZrco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrmAp3+YYtoSTMo/LfXrnLUYgnkvVZrmH0Q+rPD7YrqIN6nUoI5di2PdMHh7Pgi0wJu2em6IQfbSdKtG5kr7MpcV1ljMzpIqk5+miTBkeACu+kR+SNopm6uCGDUMZcZ+lhIdLi8FgAz2Skzk70cxW0vsN+WAjUkmdPSmds0+KGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBtHeT28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D23C4CEC5;
	Wed,  9 Oct 2024 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728476539;
	bh=pfpkVqS/zK73IKhw6LUi9n/2MQuf2vXG6yP2uBgZrco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBtHeT28e6qBxVEsYTPgOBxkjLtk7SWDnX7d6lH/T+WIlE7yaZlKyjsY95772f2Dm
	 ODX4XnCVbERHYMFdwEnVazSjXAwLnJxkbsWfIdo5XPSa7XY+xqHXo9B6TCaH1J9p0I
	 jthdNrZcsGOhkyvp/fWwWfHGg9KZAxP5NVMDZQ/K7p19qwb2wAfVYPkZmC+pzFBPhg
	 ouQTASTRI5PmxADn5IALMkABbgTb3ipVzXMUGaa+jreVn2GSMn0NhI/LHmY1pIFlhv
	 o0AIAFSQStc7YLO5p5vfWMUxvx9xPxF02cQOgAJFDBJ8UPrsZKNwNGzg4R5EAUSnat
	 gct/HHH8pyGLg==
Date: Wed, 9 Oct 2024 14:22:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 09/15] timers: Add a warning to usleep_range_state()
 for wrong order of arguments
Message-ID: <ZwZ1ePAzuyJBlxNy@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-9-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-9-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:35AM +0200, Anna-Maria Behnsen a écrit :
> There is a warning in checkpatch script that triggers, when min and max
> arguments of usleep_range_state() are in reverse order. This check does
> only cover callsites which uses constants. Move this check into the code as
> a WARN_ON_ONCE() to also cover callsites not using constants and get rid of
> it in checkpatch.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/sleep_timeout.c | 2 ++
>  scripts/checkpatch.pl       | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
> index 21f412350b15..4b805d7e1903 100644
> --- a/kernel/time/sleep_timeout.c
> +++ b/kernel/time/sleep_timeout.c
> @@ -364,6 +364,8 @@ void __sched usleep_range_state(unsigned long min, unsigned long max, unsigned i
>  	ktime_t exp = ktime_add_us(ktime_get(), min);
>  	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
>  
> +	WARN_ON_ONCE(max < min);
> +

Should it try to "fix" to avoid overflow?

if WARN_ON_ONCE(max < min)
    delta = 0

>  	for (;;) {
>  		__set_current_state(state);
>  		/* Do not return before the requested sleep time has elapsed */
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..ba3359bdd1fa 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7088,10 +7088,6 @@ sub process {
>  			if ($min eq $max) {
>  				WARN("USLEEP_RANGE",
>  				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
> -			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
> -				 $min > $max) {
> -				WARN("USLEEP_RANGE",
> -				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");

Perhaps it doesn't hurt to keep the static check?

Thanks.
>  			}
>  		}
>  
> 
> -- 
> 2.39.2
> 

