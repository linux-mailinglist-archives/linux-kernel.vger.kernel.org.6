Return-Path: <linux-kernel+bounces-413486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037059D19AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16091F2258E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6F1E571A;
	Mon, 18 Nov 2024 20:30:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1B1E5015
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961817; cv=none; b=Qt5D+rz9OiiolWaFxsjHICS4nHI7HGDRApxgfRYZng4yjCzI+4vqR1Dcqu5jrJmDToN0rZPTO0cudouTzpKgmh2M7Pgf1/NFWx2/bEiP2aHSzAWISskS37MZhxIeIeMWugvyfApxxwomLS8ky3K2/Paaq6K9F6G6hODL6baJla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961817; c=relaxed/simple;
	bh=jEvHO4Nb3Vm6L2tJkOG0KnRylkGSCf1d4SfjzIXhfO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAzW9zU6naEFgj06qMRU9ro8lqg6bD9myqfIzfC/NJp0ZlWFXexEj44TlrFrtoQMTaOIAXkM5M5OX5QfPcrfHIETTqGHn/r0/dcpJ+IwIXCgGlmmfkra1uyPoqtZn/lnPkjUsqCNnIf9bB4NZD8A/UjvhVoeje+VpNHvLQS3a1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D34C4CECC;
	Mon, 18 Nov 2024 20:30:15 +0000 (UTC)
Date: Mon, 18 Nov 2024 15:30:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com
Subject: Re: [PATCH sched-next] sched/cputime: Fix unused value issue
Message-ID: <20241118153047.7e90015f@gandalf.local.home>
In-Reply-To: <20241118111314.58481-1-dheeraj.linuxdev@gmail.com>
References: <20241118111314.58481-1-dheeraj.linuxdev@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 16:43:14 +0530
Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> wrote:

> This commit fixes an unused value issue detected by Coverity
> (CID 1357987). The value of utime is updated but has no use as it is
> updated later on without using the stored value.
> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  kernel/sched/cputime.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 0bed0fa1acd9..3dea3636a260 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -571,13 +571,9 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	 * Once a task gets some ticks, the monotonicity code at 'update:'
>  	 * will ensure things converge to the observed ratio.
>  	 */
> -	if (stime == 0) {
> -		utime = rtime;
> -		goto update;
> -	}
> -
> -	if (utime == 0) {
> -		stime = rtime;
> +	if (stime == 0 || utime == 0) {
> +		if (utime == 0)
> +			stime = rtime;
>  		goto update;
>  	}
>  

The above adds more branches than just having:

	if (stime == 0)
		goto update;

	if (utime == 0) {
		stime = rtime;
		goto update;
	}

(or's "||" are branches)

And the latter is much easier to read!

Just fix the issue. Don't try to be clever about it.

-- Steve


