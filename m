Return-Path: <linux-kernel+bounces-385081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2459B322B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7891C2193F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909281DBB36;
	Mon, 28 Oct 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfC9oYfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB771D54CF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123573; cv=none; b=EVwtMgq6PjZcXX7GD49MXjWzkSmbNPDIU9/jIUOQHO6uEf4PwtLzWWoustP7AVG2DG+90iH6mgJomv8q6/opJ7ga47xfPCNphTkbIB5G4V6GGpVtXCMlGVxCVU6o10oC9LH88q3tfR5MJ5RlErwrEI8mwl2bDxFJYgnjXamtp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123573; c=relaxed/simple;
	bh=oAGWlheGPWccFIKKisDZVf10S0U89/ffcuInM7J1kwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmd/CMi++Lntgjjn/sM8g6DCJRcTi0s34p3VIGwevu40cQ5kMXuF3iYMOWLiBEhtCIQkcYoCFKenMFLrLLJNkqONlikVjeqz0HJX2zWMdQi9wmTQ729gT9wKNHFQKXTL31qwZcYBsZx2NrRGnTCVA1zGs55GvSIrRdCXgUl4wUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfC9oYfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE14C4CEC3;
	Mon, 28 Oct 2024 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730123572;
	bh=oAGWlheGPWccFIKKisDZVf10S0U89/ffcuInM7J1kwA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YfC9oYfoyrVzH9LZP1mRb8kjSuRG3k7Szw5MYmkG1aQgzDoG1ENPqNz0KmkpNoksg
	 qPVWP8q+etlb4ihSwtwy9oqdJ+/IZvkOlkEoFRWh5OQFL61T1l9DN9WijR6kIfKNtG
	 b7zNBp53fhFAWvG46FvywtGQLXm7o9H4YAA7Hjx5PuZBTyd5EkC09ps9s6+FnJOIlv
	 QCb1lJZ3lqrjzLDbBGUgUmKOGKcOjHCQUSApBhfxX0y2NHDFULrRg4ihbIOioez2W/
	 QfNxrK85E0evgtSpnJIEjWuFbh0hEoKyks+oRi0WDomMTVnQP692E5ZRd9TbK5GDCb
	 TgQhtKGYg0GyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 237C4CE0A48; Mon, 28 Oct 2024 06:52:52 -0700 (PDT)
Date: Mon, 28 Oct 2024 06:52:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/31] rcu: Switch to use hrtimer_setup()
Message-ID: <a8db4c25-42c5-4201-ad5d-285ccecffa36@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1729864823.git.namcao@linutronix.de>
 <4c07452c5f64a4e44158d74d27ad0693b9f20ffe.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c07452c5f64a4e44158d74d27ad0693b9f20ffe.1729864823.git.namcao@linutronix.de>

On Mon, Oct 28, 2024 at 08:31:47AM +0100, Nam Cao wrote:
> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that it
> also sanity-checks and initializes the timer's callback function.
> 
> Switch to use this new function.
> 
> Patch was created by using Coccinelle.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a60616e69b66..686c4bdbd62e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3701,8 +3701,8 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>  		} else {
> -			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -			krcp->hrtimer.function = schedule_page_work_fn;
> +			hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
> +				      HRTIMER_MODE_REL);
>  			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
>  		}
>  	}
> -- 
> 2.39.5
> 

