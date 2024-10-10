Return-Path: <linux-kernel+bounces-359839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A36999158
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4141F210B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E71EABB2;
	Thu, 10 Oct 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxGU+gkJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572251925B6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585069; cv=none; b=jN+c+jVtynqVEIkQ884HmpOY6Yow9dbayR/b5cUi1KDz6MbA/qNwyog614EjCaadhKQSOA66NIogF0g8Z7XKQLlHctFrblGVCf4HG/TlmMVBul5Ndt5hIAZdpI8TmU4U7miksrNMjL/+/Xr6MCw9yu8+nFqVBbJYfFoWKS+jX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585069; c=relaxed/simple;
	bh=QptKqXNKpO/N6jBGVHuMg+ZQfqvqpgXuU7bMhU/tnzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPHpCxRMLVj0plgvd+MQ68N044WKLEE7nF6n+JkzLLfNRuP541WLzBtUMplVUrI/jWg51e+e50gfyGIbbg4bJqO0VCHu9Gu/HgmupaD66BSBIh5feZ8wyuQ2GcwMU4eJWXxoubdDM1z+9PfF5zjGaG9W/2JjovWO+5OSswZXkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxGU+gkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF48CC4CEC5;
	Thu, 10 Oct 2024 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728585068;
	bh=QptKqXNKpO/N6jBGVHuMg+ZQfqvqpgXuU7bMhU/tnzM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uxGU+gkJcBBPu+abAdLWG2Go1wVTJJ8msX6Y0OI5MhQ3VChEZIs9HXK+bdYtId8Yd
	 L9qvf00fRAyRwwSXSZZmjQqsf0HulitIwOq5ypBJF/OS3FjUb26sYVC7lOX0TY+vUO
	 LICKza5/dujBc8AFVKLwr4ItvUTgm1ITwvv43ktpu7sN0RepAV4L3xl9OEwltrGSyn
	 6y20U3FcqWeBoLIzX5jkKSzVPKGYG4PM3nilDc2ec7YRA80T5jP4A7CJdLipdhL/pZ
	 5InOzAkiMUEsfZXWSmdsMAMOdaks5jWKrWGOUUhDfCcc6dSIG5pkDZRiQSR9IT0u9u
	 Rp2PdPpgCqdhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65C79CE0BB3; Thu, 10 Oct 2024 11:31:08 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:31:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	leobras@redhat.com, tglx@linutronix.de, peterz@infradead.org,
	qiyuzhu2@amd.com
Subject: Re: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <ac55d9c8-efbc-4f2d-b178-f54f101313b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
 <9ca16991fa83fb7c7baeee153666d70717be2b7a.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ca16991fa83fb7c7baeee153666d70717be2b7a.camel@surriel.com>

On Thu, Oct 10, 2024 at 11:13:35AM -0400, Rik van Riel wrote:
> On Wed, 2024-10-09 at 10:57 -0700, Paul E. McKenney wrote:
> > Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
> > to check for excessive CSD-lock wait times.  This works, but does not
> > guarantee monotonic timestamps.  Therefore, switch from sched_clock()
> > to ktime_get_mono_fast_ns(), which does guarantee monotonic
> > timestamps,
> > at least in the absence of calls from NMI handlers, which are not
> > involved
> > in this code path.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Leonardo Bras <leobras@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> The functional change here is that sched_clock() uses rdtsc(),
> while ktime_get_mono_fast_ns() uses rdtsc_ordered().
> 
> I don't know if sched_clock() should also be using rdtsc_ordered().
> 
> Reviewed-by: Rik van Riel <riel@surriel.com>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

