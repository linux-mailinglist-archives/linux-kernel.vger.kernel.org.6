Return-Path: <linux-kernel+bounces-383258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46F9B1918
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BB61F21666
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53C249E5;
	Sat, 26 Oct 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDT9zJvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED681C32
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956569; cv=none; b=fprEXqspiJPwcfssTDfPGqTRvCHG3Qy3wUlMuZ80tsnebMToA02CLVkXoBRJOImNBoZG1gV8eCvf2U+joHMoaOkcy2153OQFREbF8FrHf5TiHRHGRlFRppPyn1Ft6SW2bVTKfgDMzq0Cb7w/tl/ObnLmVp02k9VmDpLwYXSeUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956569; c=relaxed/simple;
	bh=h5AbvWB4yZLbIxNWZAGMl5QZQ3802eWn+fljamkLPEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmD2xa5S+xOnw9+As5arECe1DY+inuRN42pleGOo52kE9Ka0DdQJCyyVzUG1xqJI+FuGHvsY1Y5jxtQ/Hp23V5Oq0fzDy9aDpultBqfvazTwajwL5k/kiCzuwiPaCpa0/0dmqAnHoIhUlXZvMa0JnDaaRkF0QOTez8uWcL052qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDT9zJvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B8C4CEC6;
	Sat, 26 Oct 2024 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729956568;
	bh=h5AbvWB4yZLbIxNWZAGMl5QZQ3802eWn+fljamkLPEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDT9zJvG9ZNPnJUl4AgotDaRMqRm5Z1cV+iG3o9eiF45qU6PimTES9EsLkBH8dSAW
	 kNWfdtKNcTSw08DjBCxlOgFFgVtu2RH43ulwtxa9men95YzEbHQOAfSI0AbQMB7uFI
	 AEOJJ5ZYq7xWak2VD6yOxVnWVzEtSe2/qbfRfBh2vLvlSj46mor/hJ5U98jdmS0hnN
	 KyOIPb2TJLJFn5ZZoLdSaOGVy0VRa6NPU3wni5M/BhLyJfW5Ii83QdqYFNfCuzvjuJ
	 uLwmDfHxl6yVZEzx4KyWgVCdhRxxB/DkVQ8ouH3bBjCG+aIuYNFxU60LEjFRXM42P3
	 qQl2ZUxmUwNwA==
Date: Sat, 26 Oct 2024 17:29:25 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on
 clone
Message-ID: <Zx0K1VI8bd1D3AYm@pavilion.home>
References: <xm26o737bq8o.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xm26o737bq8o.fsf@google.com>

Le Fri, Oct 25, 2024 at 06:35:35PM -0700, Benjamin Segall a écrit :
> When cloning a new thread, its posix_cputimers are not inherited, and
> are cleared by posix_cputimers_init(). However, this does not clear the
> tick dependency it creates in tsk->tick_dep_mask, and the handler does
> not reach the code to clear the dependency if there were no timers to
> begin with.
> 
> Thus if a thread has a cputimer running before clone/fork, all
> descendants will prevent nohz_full unless they create a cputimer of
> their own.
> 
> Fix this by entirely clearing the tick_dep_mask in copy_process().
> (There is currently no inherited state that needs a tick dependency)
> 
> Process-wide timers do not have this problem because fork does not copy
> signal_struct as a baseline, it creates one from scratch.
> 
> Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
> Signed-off-by: Ben Segall <bsegall@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

