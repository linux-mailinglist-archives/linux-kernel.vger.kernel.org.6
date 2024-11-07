Return-Path: <linux-kernel+bounces-400079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2248E9C08AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1081F24207
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848D212D08;
	Thu,  7 Nov 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYiCvvep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B56212634;
	Thu,  7 Nov 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989036; cv=none; b=t8LCRDcKOzVR/nC+qJ2tnl9SQSe6pIyA52N9OS62VLZv7Tpd02z8t9jzK+dW+t5UgATrqNDtIYZC8bQeDIzyw9llnI6P3TAskMVV7D4kMm1w0eIanRxJvaok7JBlAIyU+vEOfgQ0y7JQfTMO0vwjR59Gk5t5uoIcCHIcdcrSvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989036; c=relaxed/simple;
	bh=1ZeCVZgPH/kOnyaxWlMqGKsZACS9tx+o+cY6bqcmEN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsF9bPgEDQadHVQEWAEoDSOzew02jS3CTI6JflvKUom2ryBR+13gRr+C1SUH9AyksdrXLx5mixpsQQRdOXuZkke+FL0GzEf83We9Qt18cIG7++jHEg0fD0sNJk8Whrm7s9cnvMqDHwfGdA1xlwNlo5Va3Sn0Isj52OgsljjRGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYiCvvep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBC1C4CECC;
	Thu,  7 Nov 2024 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730989035;
	bh=1ZeCVZgPH/kOnyaxWlMqGKsZACS9tx+o+cY6bqcmEN8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cYiCvvepTtsyaQnS8aP05ZyqWvA+pOcOfzehGXa+MMeyGDdVCXgY12+VIaU8XoGQl
	 LvKWvXqqy8HviYjqiNtLNIv7LmmCqLO5iJ1iCMOB1KHeesodEeLQ1Rf+t8oq/Sk3we
	 419kvRhHtBhUwVQiXc3EcuBB7k4pLkLFTT1S86oXqeSU/FUshh0YkWF/B3u1GEIom4
	 NS9fhkCSVX1CxYE7BAfAzGf4OzRTh8HnPGyRhTZAkW4+awed/tPhLGNWC7eo8YpZh+
	 nY8RLFCefOnpxgZw3B+N/iBUYb6NTWosvpZQ8QE6QxHrbhgf1YnAX6ANftYJFIZpG6
	 ZqoVQdE5tKFhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A316CE09F6; Thu,  7 Nov 2024 06:17:15 -0800 (PST)
Date: Thu, 7 Nov 2024 06:17:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.11.01a] [rcutorture] 622baf5d79:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <0e7a3c71-d62f-46d9-95c6-ab908e35c275@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202411051012.f9224879-lkp@intel.com>
 <1092459d-48e2-4839-a84d-c38d96fa2a36@paulmck-laptop>
 <ZyxeC9WVcbdTAu0x@xsang-OptiPlex-9020>
 <7b36e5d1-e936-41af-aa2b-9b0cd102f341@paulmck-laptop>
 <ZyzJa9tR0503k70s@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzJa9tR0503k70s@xsang-OptiPlex-9020>

On Thu, Nov 07, 2024 at 10:06:35PM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Thu, Nov 07, 2024 at 06:01:15AM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 07, 2024 at 02:28:27PM +0800, Oliver Sang wrote:
> > > hi, Paul,
> > > 
> > > On Wed, Nov 06, 2024 at 12:07:37PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Nov 05, 2024 at 01:00:53PM +0800, kernel test robot wrote:
> > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> > > > > 
> > > > > commit: 622baf5d79169496973d50fc43636469e6af02b7 ("rcutorture: Make rcutorture_one_extend() check reader state")
> > > > > https://github.com/paulmckrcu/linux dev.2024.11.01a
> > > > 
> > > > This is an old commit that failed to handle any torture_type other than
> > > > "rcu", including the "srcu" that you tested with.  It has since been
> > > > replaced by a series of newer commits fixing this and other bugs, with
> > > > the current version here:
> > > > 
> > > > c815d319a933 ("rcutorture: Make rcutorture_one_extend() check reader state")
> > > > 
> > > > Does this one work for you?
> > > 
> > > yes, this one works. issue gone when we run same test case up to 20 times.
> > > 
> > > d5e74d8e46e8e45c 622baf5d79169496973d50fc436 c815d319a9331530032be3df69c
> > > ---------------- --------------------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> > >            |             |             |             |             |
> > >            :6          100%           6:6            0%            :20    dmesg.EIP:rcutorture_one_extend_check
> > >            :6          100%           6:6            0%            :20    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
> > 
> > Again, thank you!  Would you like me to apply your Tested-by to the
> > resulting commit?
> 
> sure! thanks
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thank you again, and I will apply this on my next rebase.

							Thanx, Paul

