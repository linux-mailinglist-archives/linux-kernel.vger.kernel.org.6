Return-Path: <linux-kernel+bounces-202729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C28FD013
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6E1C24805
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA13195FC0;
	Wed,  5 Jun 2024 13:40:24 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 21C911953AF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594824; cv=none; b=WCj00FI7PfBB3/gFVJJxTcDR7v4GSjbcRUWVpFtL9eDzM9IIKyPIqshQvlWyqKsn/OJh/T7JisBe6hdRysBD2Q7z0Z55SUWq7E8uGAX81TJU85CUwFlrhfqNMwnY/mnuGfT6XaHqNXgKwQpCIolFk/G6Rk9TuK03efs/i9dF+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594824; c=relaxed/simple;
	bh=pg3gmQ+DfMSb375BdyrwTTkQKJuMPFxzyCHhzTRTFHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB/FWS1F7ux1epeUs0pWjTCsJElbup4ru2yJURGSHCg/7+7w73HVjS3771ZJREY4U+DvBLQeay6XRiCBfZwIFadxg7SEr8a3CfASdfDcYqG3SvyPw0vMnPh7oQj/UqDtNPqUa1X5weOdCoP1DBcBetueb/KbKBkadWJbIiLHRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 196501 invoked by uid 1000); 5 Jun 2024 09:40:20 -0400
Date: Wed, 5 Jun 2024 09:40:20 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, paulmck@kernel.org,
  parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
  joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
  frederic@kernel.org, linux-kernel@vger.kernel.org,
  Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: Re: [PATCHv2 3/4] tools/memory-model: Define effect of Mb tags on
 RMWs in tools/...
Message-ID: <d8fb64c8-ec53-4087-bbbc-72c7e59d8dbf@rowland.harvard.edu>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <20240604160440.498332-1-jonas.oberhauser@huaweicloud.com>
 <Zl_pehpjHVt2z95p@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl_pehpjHVt2z95p@Boquns-Mac-mini.home>

On Tue, Jun 04, 2024 at 09:28:42PM -0700, Boqun Feng wrote:
> On Tue, Jun 04, 2024 at 06:04:40PM +0200, Jonas Oberhauser wrote:
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -34,6 +34,16 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
> >  let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
> >  let wmb = [W] ; fencerel(Wmb) ; [W]
> >  let mb = ([M] ; fencerel(Mb) ; [M]) |
> > +	(*
> > +	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
> > +	 * though there were enclosed by smp_mb().
> > +	 * The effect of these virtual smp_mb() is formalized by adding
> > +	 * Mb tags to the read and write of the operation, and providing
> > +	 * the same ordering as though there were additional po edges
> > +	 * between the Mb tag and the read resp. write.
> > +	 *)
> > +	([M] ; po ; [Mb & R]) |
> > +	([Mb & W] ; po ; [M]) |
> 
> I couldn't help suggestting:
> 
> 	([M] ; po ; [Mb & domain(rmw)]) |
> 	([Mb & range(rmw)] ; po ; [M]) |
> 
> , it's a bit more clear to me, but maybe the comment above is good
> enough?

We may want to use the patch's approach for other things besides RMW.  
For instance, it would be a good way to implement smp_store_mb() -- 
compare it to the existing implementation in the .def file.

Alan

