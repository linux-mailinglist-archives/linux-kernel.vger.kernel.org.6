Return-Path: <linux-kernel+bounces-237693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42980923CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9E5287A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C315B141;
	Tue,  2 Jul 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgXP28g5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A415B12A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920623; cv=none; b=OIrbaKmZZbByD2083OGlWcomBu2xv82u5/z8k3Ra/47rCXoRuv9mVQMfaVZF0+3Uua3mJOKjH3WNfb0jCJsiRCyj6U6VTX2S2SCWmgeeCVF0W0YKE4jD58gNoDJst7uV5ZwtpN+aUTqmHg61gNlyt/g6QEBOj3dIcxfaUESIRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920623; c=relaxed/simple;
	bh=O9guna17fXWoVSiTORL8jOK5U2JuVFN10UDkWzmo+CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsdEcEhJYygztptCAyyYSqNuerCbqY52eC3vc/fdYpyhCvgd5hkISgy5jWzAMZYWeGnYwbInyLbfvnhizzlm9D/FtU0rGb6+MDEPz1tj8WErEmfa2/uu7Sbr5RX3Xh6X1/2s0T5zR9Foo/FlpkNSoGg1Z3H9lNgnYUNYDKV3Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgXP28g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A83BC32781;
	Tue,  2 Jul 2024 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719920622;
	bh=O9guna17fXWoVSiTORL8jOK5U2JuVFN10UDkWzmo+CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgXP28g5N/vixs4zfYEekmQkkk+3X1rrpuT8Q1IVImDmqcHRNWLx6x+rNLJXj6iOW
	 Xt+ck1rqutRjmTf7AgPoBMx+Jw0F9hwAQKoOc1vbPAuYwehlkMKSgdaoT223lnLiAu
	 rjwb83VshihCGYRmyKcShMp2umS97rHy+hWoV6qBI0qSYiXIj6ET5+rQNe9Qx0UfeN
	 3i5KGWDdX1y4+uJuPWdeAjoc+Za7qTROvh/d2IBRM3pU6ifblKyn1PqiMuQXqGqlzr
	 pnNW3R49yeHOsITWmsxonhsQ5D37QtczM2R8c8w2Is+lK5hymsj//kjM3LuuZvsQiR
	 LduodtFx5uovQ==
Date: Tue, 2 Jul 2024 13:43:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] timers/migration: Use a single struct for
 hierarchy walk data
Message-ID: <ZoPn65jVGSRn2mTI@localhost.localdomain>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
 <20240701-tmigr-fixes-v3-4-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-tmigr-fixes-v3-4-25cd5de318fb@linutronix.de>

Le Mon, Jul 01, 2024 at 12:18:40PM +0200, Anna-Maria Behnsen a écrit :
> Two different structs are defined for propagating data from one to another
> level when walking the hierarchy. Several struct members exist in both
> structs which makes generalization harder.
> 
> Merge those two structs into a single one and use it directly in
> walk_groups() and the corresponding function pointers instead of
> introducing pointer casting all over the place.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer_migration.c | 126 ++++++++++++++++++------------------------
>  1 file changed, 55 insertions(+), 71 deletions(-)
> 
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 0ae7f2084d27..b4391abfb4a9 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -475,69 +475,31 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
>  	return bitmap_weight(&active, BIT_CNT) <= 1;
>  }
>  
> -typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
> -
> -static void __walk_groups(up_f up, void *data,
> -			  struct tmigr_cpu *tmc)
> -{
> -	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
> -
> -	do {
> -		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
> -
> -		if (up(group, child, data))
> -			break;
> -
> -		child = group;
> -		group = group->parent;
> -	} while (group);
> -}
> -
> -static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
> -{
> -	lockdep_assert_held(&tmc->lock);
> -
> -	__walk_groups(up, data, tmc);
> -}
> -
>  /**
>   * struct tmigr_walk - data required for walking the hierarchy
>   * @nextexp:		Next CPU event expiry information which is handed into
>   *			the timer migration code by the timer code
>   *			(get_next_timer_interrupt())
> - * @firstexp:		Contains the first event expiry information when last
> - *			active CPU of hierarchy is on the way to idle to make
> - *			sure CPU will be back in time. It is updated in top
> - *			level group only. Be aware, there could occur a new top
> - *			level of the hierarchy between the 'top level call' in
> - *			tmigr_update_events() and the check for the parent group
> - *			in walk_groups(). Then @firstexp might contain a value
> - *			!= KTIME_MAX even if it was not the final top
> - *			level. This is not a problem, as the worst outcome is a
> - *			CPU which might wake up a little early.
> + * @firstexp:		Contains the first event expiry information when
> + *			hierarchy is completely idle.  When CPU itself was the
> + *			last going idle, information makes sure, that CPU will
> + *			be back in time. When using this value in the remote
> + *			expiry case, firstexp is stored in the per CPU tmigr_cpu
> + *			struct of CPU which expires remote timers. It is updated
> + *			in top level group only. Be aware, there could occur a
> + *			new top level of the hierarchy between the 'top level
> + *			call' in tmigr_update_events() and the check for the
> + *			parent group in walk_groups(). Then @firstexp might
> + *			contain a value != KTIME_MAX even if it was not the
> + *			final top level. This is not a problem, as the worst
> + *			outcome is a CPU which might wake up a little early.
>   * @evt:		Pointer to tmigr_event which needs to be queued (of idle
>   *			child group)
>   * @childmask:		childmask of child group
>   * @remote:		Is set, when the new timer path is executed in
>   *			tmigr_handle_remote_cpu()
> - */
> -struct tmigr_walk {
> -	u64			nextexp;
> -	u64			firstexp;
> -	struct tmigr_event	*evt;
> -	u8			childmask;
> -	bool			remote;
> -};
> -
> -/**
> - * struct tmigr_remote_data - data required for remote expiry hierarchy walk
>   * @basej:		timer base in jiffies
>   * @now:		timer base monotonic
> - * @firstexp:		returns expiry of the first timer in the idle timer
> - *			migration hierarchy to make sure the timer is handled in
> - *			time; it is stored in the per CPU tmigr_cpu struct of
> - *			CPU which expires remote timers
> - * @childmask:		childmask of child group
>   * @check:		is set if there is the need to handle remote timers;
>   *			required in tmigr_requires_handle_remote() only
>   * @tmc_active:		this flag indicates, whether the CPU which triggers
> @@ -546,15 +508,43 @@ struct tmigr_walk {
>   *			idle, only the first event of the top level has to be
>   *			considered.
>   */
> -struct tmigr_remote_data {
> -	unsigned long	basej;
> -	u64		now;
> -	u64		firstexp;
> -	u8		childmask;
> -	bool		check;
> -	bool		tmc_active;
> +struct tmigr_walk {
> +	u64			nextexp;
> +	u64			firstexp;
> +	struct tmigr_event	*evt;
> +	u8			childmask;
> +	bool			remote;
> +	unsigned long		basej;
> +	u64			now;
> +	bool			check;
> +	bool			tmc_active;


Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Ideas for a subsequent patch:

Is tmc_active actually useful? It must always be true in
tmigr_requires_handle_remote_up() since that function is only called
on active CPUs.

In fact the following condition is dead code:

	/*
	 * When there is a parent group and the CPU which triggered the
	 * hierarchy walk is not active, proceed the walk to reach the top level
	 * group before reading the next_expiry value.
	 */
	if (group->parent && !data->tmc_active)
		goto out;

Thanks.

