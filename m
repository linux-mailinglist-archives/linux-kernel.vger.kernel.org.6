Return-Path: <linux-kernel+bounces-430367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C40A9E2FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048B5166EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570F208983;
	Tue,  3 Dec 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJRydVSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17981DE2B5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269221; cv=none; b=UzIJVeq4hITG9mEuW4/wmdP8zwTMLblYlzcOtc03GKjEJkhu36V7plAdxTBtatB9ksnNi/906MzgIRTMmu3fMOPA8ltl41woxmFZ4GsOlpHE+vpJB4Qkp0mc9K8ibEFs8t3MXOh3tKu5jhpWsIZA9O8g3mx7Lm4rXKF1St9pSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269221; c=relaxed/simple;
	bh=6sfwQQEl80+fJrjomNAocQw711Y9lpLHa65lqw0j9rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA7kl51ZFjfdbnJ8G7g3kL2jkZSuKyIQog6vFl8+++WcXncdgsY4KqSkEl7J3XBDyOrlVG/ZL8Dp40CoquRg9QgCoZuuB27mzZQVSijDEyjPgPN9gt/LAi7Gm/1IAoDFPmdrMWJthruqcFTEDthgCaqLjnwo+RVNxdHDQWN3ZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJRydVSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67692C4CEDC;
	Tue,  3 Dec 2024 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733269217;
	bh=6sfwQQEl80+fJrjomNAocQw711Y9lpLHa65lqw0j9rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJRydVSG9SsIfiYUDrsjCcKLPNy6M/WfPE6D8Ahzi08U1G0eK6f9Y3obTEzsodWBL
	 7YwMmmuK3p4jxv6VyKMiD6bbuXNfPyAt+pCHbNkIsd8MzkNX6gAVP8sqcbQCisW2dA
	 qZNzNGOEvB0BhNoyEQ2dAFUjJMW7rWm8lcRZtdqxhGoY+mS+9nZQaza/D6iw5HgiHF
	 LplHsuipOadW1cq+SnzhwDfXyq9jqp+Ey5zgzPvRABKpWZUIKkTYTRm3RQ1AOjExDY
	 dc7zJdD7Vi7Cr9l1qxSufK6O9RY9TBmnEwmZGJ5pyzLUSEce7V4kAEKxta56lAX/Ry
	 Wwu+TLnLKr1Rw==
Date: Tue, 3 Dec 2024 13:40:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] sched_ext: Replace bpf_ktime_get_ns() to
 scx_bpf_clock_get_ns()
Message-ID: <Z0-W4CxeuInz-dX7@slm.duckdns.org>
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-6-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203142802.36305-6-changwoo@igalia.com>

On Tue, Dec 03, 2024 at 11:28:02PM +0900, Changwoo Min wrote:
> @@ -245,7 +245,7 @@ void BPF_STRUCT_OPS(central_running, struct task_struct *p)
>  	s32 cpu = scx_bpf_task_cpu(p);
>  	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
>  	if (started_at)
> -		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
> +		*started_at = scx_bpf_clock_get_ns() ?: 1;	/* 0 indicates idle */

Not from this commit, but how about scx_bpf_now_ns() for the name?

Thanks.

-- 
tejun

