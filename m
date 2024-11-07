Return-Path: <linux-kernel+bounces-400056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED339C0855
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19571C233E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62721263E;
	Thu,  7 Nov 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufYkxQ4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03582101B8;
	Thu,  7 Nov 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988076; cv=none; b=ZXEsrrY+nC1mRB0/8Tj9/ken5gxttpsSAA14oeLjQeOjAo2EvJEVGpEMpCu5I1PXIJd8HYUFL8FQ9fHCsCQ78dwGkhfk1U46u6vLC8GGhgLTWOFiacMh8EXCKS6FuQM5nzJ8mgcsZLIAEkhWS+Oq54Ay7niQfgJZmXVfR/yaTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988076; c=relaxed/simple;
	bh=w0i/EbRrJJCzUk7gQLmzGGye3HEYRtrDgiAtqQRbyyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrszE33+lh6IQGeYbCZt8O10OOjw6CEb1uAeJlNFBsJwuM07j7b8YTkYej00JuLkO9XwTtKFMWXUP5vfKzICysa5RF4josI/LcUCEBp7+E6+2QD+8uBIgyj9bzm1hEy1z9mVytz3/6odNQOVKUg5v557roexlhSdrcCiCPg0rkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufYkxQ4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C672C4CECC;
	Thu,  7 Nov 2024 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730988076;
	bh=w0i/EbRrJJCzUk7gQLmzGGye3HEYRtrDgiAtqQRbyyQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ufYkxQ4hcm6KNQ+zE8s1G2VC6HF8ckKIgi0Yvl3Lr4dDfGgZBqacRbR+19y/Z7fgL
	 4PcrXyjVhIFbVi6NrDKiqB+Q/Jy+piz4b5fwrltCPlkHtCoy+Ix0tPBt3STcTP5EEC
	 G2e3DslfAk74nYvc5dHLEV6O3eEporpLFRGVR49mAnAE351/cFZzMZKUbDUwNfx5Te
	 wLOxNesFs66LAssJs3lr1agq+ONVHOvs/FBEkgmw9h4Y3q43VaeZFjdGGUPls25c1b
	 UN5/hO3twZSPGeTlGVcOIwhN7NM39s0ekLhRzcJxCBRD3AeiOy7EEFuo6DK/eKHB58
	 wgap4LyRhu8Sw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C304DCE09F6; Thu,  7 Nov 2024 06:01:15 -0800 (PST)
Date: Thu, 7 Nov 2024 06:01:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.11.01a] [rcutorture] 622baf5d79:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <7b36e5d1-e936-41af-aa2b-9b0cd102f341@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202411051012.f9224879-lkp@intel.com>
 <1092459d-48e2-4839-a84d-c38d96fa2a36@paulmck-laptop>
 <ZyxeC9WVcbdTAu0x@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyxeC9WVcbdTAu0x@xsang-OptiPlex-9020>

On Thu, Nov 07, 2024 at 02:28:27PM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Wed, Nov 06, 2024 at 12:07:37PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 05, 2024 at 01:00:53PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> > > 
> > > commit: 622baf5d79169496973d50fc43636469e6af02b7 ("rcutorture: Make rcutorture_one_extend() check reader state")
> > > https://github.com/paulmckrcu/linux dev.2024.11.01a
> > 
> > This is an old commit that failed to handle any torture_type other than
> > "rcu", including the "srcu" that you tested with.  It has since been
> > replaced by a series of newer commits fixing this and other bugs, with
> > the current version here:
> > 
> > c815d319a933 ("rcutorture: Make rcutorture_one_extend() check reader state")
> > 
> > Does this one work for you?
> 
> yes, this one works. issue gone when we run same test case up to 20 times.
> 
> d5e74d8e46e8e45c 622baf5d79169496973d50fc436 c815d319a9331530032be3df69c
> ---------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |
>            :6          100%           6:6            0%            :20    dmesg.EIP:rcutorture_one_extend_check
>            :6          100%           6:6            0%            :20    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]

Again, thank you!  Would you like me to apply your Tested-by to the
resulting commit?

							Thanx, Paul

