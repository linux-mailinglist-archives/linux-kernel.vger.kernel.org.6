Return-Path: <linux-kernel+bounces-388803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4B9B648F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C471C215E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB51EBFEB;
	Wed, 30 Oct 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5MagZ+A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087541E260E;
	Wed, 30 Oct 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296006; cv=none; b=DQyUvbcxoCdOt9g4plafLFgZ6t3ORdh5HNPnwoxVPfBRzzR2oS77ZW2LvorzxRv6SNII28WRagoYszYyRROn8FmnZhNQZSKxtt0lccLZ+b7b7brduuDgNTLzNyZI6Ag12yOMYFLU8nkNAgwhNc6iuFDlyvRurj9dXFz24JSJM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296006; c=relaxed/simple;
	bh=9RAdJz/7k8+kbmfYLQOk3Fwdes/kT4tbQodLGKPBwkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvltSt6YIFewFbrkCYvAMXy764Pgbl1pJZwPFH0ayOJa+xGbiKzTnBkTn7ylIjELOKX4HWt3d5nh3EG98gPi39AnlKhlWaT4X8cAQ8QBvvFxGv8VuCZfNPtRLPlRmMufV1kuDg4O+5BPazwMdIIPodQ897wcyVSQQAHjXeYabUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5MagZ+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB84C4CECE;
	Wed, 30 Oct 2024 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296005;
	bh=9RAdJz/7k8+kbmfYLQOk3Fwdes/kT4tbQodLGKPBwkU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=M5MagZ+ASPvyfmXvh/0jGeWrCkRMwpj0iqLKsRDkZ/U7SuexvelZEMR9hyme1At16
	 BCoRCYcwgdXyQLuwB1yRzu29U+jYp26hc8Qb7nYXmwaorI0dtnzRA3wqiP4B9qgYBT
	 nPhbr3SkplTaVkeLT3qnszsqOff62gviLIKE3hZ3IoewpzOzEfiDP+df68flEtDJtM
	 HjNJ65juXSBo+JbMa3S+jnF7ZoJE5hXVoakaezXfcGcPoaM6End3NWBypKhD6iugXo
	 6AJRsvc69YTdpqDhWFGeP3ie10MidwUlSN/U7XOmJCzOFUc0BOwBBkB8BWWbvH0Q1I
	 Kfg67ZRrFS8Zg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2ED87CE09DB; Wed, 30 Oct 2024 06:46:45 -0700 (PDT)
Date: Wed, 30 Oct 2024 06:46:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
	joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
	frederic@kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 4/5] tools/memory-model: Switch to softcoded herd7 tags
Message-ID: <55719a66-aeb9-4c20-afa6-e46dbb54c22f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-5-jonas.oberhauser@huaweicloud.com>
 <ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local>
 <ba2b6c1d-4930-4ede-ba21-d7a2fa46e5e1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2b6c1d-4930-4ede-ba21-d7a2fa46e5e1@huaweicloud.com>

On Wed, Oct 30, 2024 at 12:50:19PM +0100, Jonas Oberhauser wrote:
> 
> 
> Am 10/29/2024 um 1:04 AM schrieb Boqun Feng:
> > 
> > One bit below:
> >
> > On Mon, Sep 30, 2024 at 12:57:09PM +0200, Jonas Oberhauser wrote:
> > >       ------------------------------------------------------------------------------
> > >       |       RMW ops w/o return value |                                           |
> > >       ------------------------------------------------------------------------------
> > > -    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
> > > +    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
> > 
> > Not in this patch, but don't you need to update this again to all cap
> > to match your changes in patch #5? ;-)
> > 
> 
> Hmmm, probably that is a good idea.
> I actually had thought about it for some of the other places in the doc that
> mention the tags, and concluded that we'll just use the semantic tags there.
> 
> But in fact, this file is about the syntactic representation in herd, and
> there is no noreturn semantic tag on the W*, so it wouldn't match it even if
> it were correct.
> 
> So I think this needs to be addressed in 5/5.

Thank you for checking!

Please send me either a replacement for 5/5 or a patch for me to fold
into 5/5.

							Thanx, Paul

