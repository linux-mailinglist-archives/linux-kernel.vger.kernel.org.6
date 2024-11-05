Return-Path: <linux-kernel+bounces-396372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB939BCC48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050CB1F21F89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DA1D5143;
	Tue,  5 Nov 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5eA6r5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18E1D415C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808136; cv=none; b=d/Qj7w2xjYz6v2i7iwJ7/88M/LEZISfNAL+Rmzvg+5sIP/T1vops/4fp6T2RC+Hx4OzPAxh15qb7BPVMczBKvKHTG1ODzUTaP3NM/4ovOeSW46tumUqoZkqFgSnPUrs7QbteK8jq34vnrNWWWwddgyFOHUs9p1hfLrM2Ilv9vtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808136; c=relaxed/simple;
	bh=dUFMlZr7b8qV2tKhZC0tbctZ451Ikp8eBaa7S6BQ3So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjQZxe4ckyjEHBzPVpyr15h/wGFVyZ7EjPQ4M3qnLY1J6NKF6SaBh9CyKOlNd5VUjCO3avtMGQcQBiFPCGKa2H4zYKAUUB0qh3BZVo02w6U+1iBYh44ble36ats4qYnYTPmXAT/ZbDDvMoLNH6vLqRWyCjTREMDm1tHPjsozy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5eA6r5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56268C4CED0;
	Tue,  5 Nov 2024 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730808135;
	bh=dUFMlZr7b8qV2tKhZC0tbctZ451Ikp8eBaa7S6BQ3So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5eA6r5tDVAfTMUKqun8HB2JXQETiSFeDbHxtfLQTGpmxRTgq/079SUPbqEbz4gOD
	 fOEANwYT11m81IFgctpvCB5whaK1gXqS8mFCq/Rl5KL+YZSx8ska/60I7o5Q6Tb7cn
	 gi0CGUIO8C2C/IFPmrofbEc3l1sW/qfin32NlY0S258zpm34Hmu9z+gurZYOYZUqcf
	 40/2cfShkzZF+/ee9RbtvLF0mOkg9t2pI0dgnFHuRVjhzD4Xeh3bCLahxG+fvGgU4r
	 liUxDbK7lZoRKnugiejQLjbi3j8w1BO4tmMVAVybaMNbM0fHk3MFjdrhrrqwP9CwYf
	 8u8lB4MCF2qRA==
Date: Tue, 5 Nov 2024 13:02:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 01/21] posix-cpu-timers: Correctly update timer status
 in posix_cpu_timer_del()
Message-ID: <ZyoJQx4e33VtMSFS@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064212.974053438@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064212.974053438@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:29AM +0100, Thomas Gleixner a écrit :
> If posix_cpu_timer_del() exits early due to task not found or sighand
> invalid, it fails to clear the state of the timer. That's harmless but
> inconsistent.
> 
> These early exits are accounted as successful delete. Move the update of
> the timer state into the success return path, so all "successful" deletions
> are handled.
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

