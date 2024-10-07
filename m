Return-Path: <linux-kernel+bounces-353705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B407F993161
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4641C235EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2C1D8E04;
	Mon,  7 Oct 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kk+TvE9x"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688218BBB2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315361; cv=none; b=LcD+O6J0tzCyadxCQ13heWqBk6MNH+wiu7xCSzm4eNwqxJhW+8hfEPMV6dLLT84Do/UUUe0xOwAd0S+xvMASOGaqTGKti3KP7f6dWMUtaJXRqfKgZ9Ij43m8osBse97Z4QBpNx+jOL0uqBovK9M32UzPOOOR5kIfXSabrYuOGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315361; c=relaxed/simple;
	bh=tsQWZfmXPljVwkt/+tOZdAR+R7WRJDzTPBMrT2VaFY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgK5TB51cpurs9qf2N4043ZvUB4qF/a8RQCicLmPC/Sfzhp/PoGEp4wUumoX3FrBUE31E/986ADmDTarLKka8JEbwVeb1Qoju+X4Og93o08Tv0rO585Qy1yEASZtQVzK8dBzOMgvGB14eB0cY5IJNxzvgpA3UQ3mmbhCCmtM1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kk+TvE9x; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CuNPFG34+A+yppuTvVedIg/8HZo7PVHx61pElQr5To0=; b=kk+TvE9xuQLp5ky9wOZe4P7brH
	VZrG0UeNixhOcONtbp8N0JduUADF5dFDf5kI+T7Uy6d8uyJDjq8neDovuTfDMw/SPAXxEnRrJbdiq
	Yfx/1pf2x2LCd+kiCt1l8+zSwi7ikKvX+nM0mXMuQ1k/1vG36lrUNTg+KEVziQIv3XAvAlqG4Z5kk
	Jo9JeZhsqXS+OEZPBfDhwH9lTf11HP0GZEyceE16Cc2TIArckB1kAt/dGRTxomGbfsh0OvCVwqDn7
	54cDNLSum/3MUxibfB3YNhlzni/MMuVel9wxgAVHIO7+IW8bZq1GVIcrpQlPE17tYOdrMIlav3Uhu
	oyw7l7hA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpm8-00000004RWJ-032t;
	Mon, 07 Oct 2024 15:35:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2444A30088D; Mon,  7 Oct 2024 17:35:55 +0200 (CEST)
Date: Mon, 7 Oct 2024 17:35:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Luis Goncalves <lgoncalv@redhat.com>, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [PATCH v3] locking/rtmutex: Always use trylock in
 rt_mutex_trylock()
Message-ID: <20241007153554.GB14587@noisy.programming.kicks-ass.net>
References: <20241007152910.29457-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007152910.29457-1-longman@redhat.com>

On Mon, Oct 07, 2024 at 11:29:10AM -0400, Waiman Long wrote:
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index ebebd0eec7f6..a32bc2bb5d5e 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1381,10 +1381,13 @@ static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
>  		return 0;
>  
>  	/*
> -	 * The mutex has currently no owner. Lock the wait lock and try to
> -	 * acquire the lock. We use irqsave here to support early boot calls.
> +	 * The mutex has currently no owner. Try to lock the wait lock first.
> +	 * If successful, try to acquire the lock. We use irqsave here to
> +	 * support early boot calls. Trylock is used all the way to avoid
> +	 * circular lock dependency.
>  	 */
> -	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +	if (!raw_spin_trylock_irqsave(&lock->wait_lock, flags))
> +		return 0;
>  

NACKED!!!!

