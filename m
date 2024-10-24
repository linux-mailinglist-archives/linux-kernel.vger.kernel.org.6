Return-Path: <linux-kernel+bounces-379814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E499AE41C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4B284C30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6E71D515C;
	Thu, 24 Oct 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsykwTeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9E1D5151
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770397; cv=none; b=kmJGYoRL5VRWtQRmAvTCzmfeOZ01Ipj2O4PqzgdbFOxhFSd8xOSYilWBRWAhoRQPrarpHlNnYlSi6wpfgX83k9gjwl7i3pr9NMXqfmHpyoo5MkrkaKegWSoqtJQQt3eBT15Hp8aaDPA3LWZG+TQiBZOdmgu1VXF7dNTyKGVAtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770397; c=relaxed/simple;
	bh=JWyYdAR6upa0IgphvJj1Y/NytkSCl49XG3p2llX9K2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHr9cJ72E8RrLh3N+ElIW4wGF7WJZ5O2FRzxAFcCqe1ATPGCmeZzBSfO+PdBOP9iVFX5GYGzdSEwUaJQFkm3tvtKtfCBwQcXyde2azEvvL9yXmtmHbh4sN2+teChypsA3XjiMmvaF74uSMRhhrlGcp/LHY2QgeJ8sxsx/mJW8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsykwTeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D7C4CEC7;
	Thu, 24 Oct 2024 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729770397;
	bh=JWyYdAR6upa0IgphvJj1Y/NytkSCl49XG3p2llX9K2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsykwTeR02eLFnV27oRu4kZ4nm9yiyFVd4RIrqqiFYxXIxBkDoKBFg/TOKircS3sF
	 9wybLBAzc53rV8D1J5lB0muW3IMWkP6A/K4syb2NHOvgfjP1zJlIUF2Vc75txGxuPX
	 /6+3f0tyvUuo4cD+Oa0e3B9E9oBrerwzykAcg+2qXkmxMtDw7w+IQNwURddSOp5Rk4
	 shBtp6porhJOyfKnaZB6Lm5RF45CSHKIkhAaC/PMcNHEfLRbSxfk2HHEfs+xnDwHrf
	 IXdWfY3gg6dA+IPc5LRMWpzOnGFxnbLAW2b85BBxQtFwsHmDZSKMzjxe9Sg3AGoQiU
	 FpF5bO4Qpk70w==
Date: Thu, 24 Oct 2024 13:46:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 05/26] posix-timers: Drop signal if timer has been
 deleted or reprogrammed
Message-ID: <ZxozmnCyYpRI2t2Y@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.553646280@linutronix.de>
 <ZxZJPnqsQygi6juI@localhost.localdomain>
 <87ttd16gif.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttd16gif.ffs@tglx>

Le Thu, Oct 24, 2024 at 10:40:08AM +0200, Thomas Gleixner a écrit :
> On Mon, Oct 21 2024 at 14:29, Frederic Weisbecker wrote:
> > Le Tue, Oct 01, 2024 at 10:42:06AM +0200, Thomas Gleixner a écrit :
> >> No point in delivering a signal from the past. POSIX does not specify the
> >> behaviour here:
> >> 
> >>  - "The effect of disarming or resetting a timer with pending expiration
> >>     notifications is unspecified."
> >> 
> >>  - "The disposition of pending signals for the deleted timer is unspecified."
> >> 
> >> In both cases it is reasonable to expect that pending signals are
> >> discarded. Especially in the reprogramming case it does not make sense to
> >> account for previous overruns or to deliver a signal for a timer which has
> >> been disarmed.
> >
> > The change below indeed checks if the timer has been deleted but not if
> > it has been reprogrammed/disarmed/reset.
> >
> > Or am I missing something?
> 
> No. You are right. This is a change log left over from a previous
> version. This rearm/disarm part is handled later in the series.

Right, I realized that after. Anyway:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> 
> Thanks,
> 
>         tglx

