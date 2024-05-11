Return-Path: <linux-kernel+bounces-176416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AA8C2F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2804AB23253
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05708335C0;
	Sat, 11 May 2024 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgh9/Uol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC117991;
	Sat, 11 May 2024 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715402552; cv=none; b=D+AN3DUIdYJxrHceLS3p9YJbE0QmMe5NJ/ExDMi1/KkeMrJ0RdwvAz3/BTeVDSSwB9k3xQZK3uTTevX/Klhf1aZP4P9TLbMrvSZPRIzvxqoqnd4o6jdpBvi6AgPp+4g6zaRyRxF1yo1Meum4gyZ20DtT4TLS8Fn5Pm05yISg2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715402552; c=relaxed/simple;
	bh=Of3tf7Yk3QELR00f2bG8MRL+BwzLbAlq3iIs50kuF4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8gfELB9H7FPyCi3eyJLH9vx7oeVW0sIT9NezhsZq0x+ClptH12WEMzY11/ayupiXOprgUlKLT/2z2+bFVmsxnRjvH+I6DcNWkD3xImuLQXdVtUEr7OW/6SrcTWql0cdANgL3DisPFW607DPTHKLr/ReIvXE9f4IPDU8x/lyong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgh9/Uol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D9C2BD10;
	Sat, 11 May 2024 04:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715402551;
	bh=Of3tf7Yk3QELR00f2bG8MRL+BwzLbAlq3iIs50kuF4Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jgh9/UolbDxGJvt1+68Nyf+3+/OC/ZaRw6NGJc5Zacoym7DeyssTLjxajMzWuFarS
	 9//1bcMUhj8JXQ1Dj25pih3ySDJsWI1jVLdoi3n2tE+VnXlTFYjFbmu7SZsglS3F+k
	 7sXe8jQIAQRPLGtJkFhuyfZL/d1oGPFYXJNzMgeVLmt49QYNEUPk0vlBoZILUq9UI2
	 VpUfO8P5KMRBd5baFZNt35TqzElJStdo7vouUex6EmhfRpsBTu1nXuQmBxO4SgwQ7o
	 hLHQt6EZ1uwyhGcHeafFCeY5zkFPyFHuR9D1mkuszCc8IsB8PQKJ7Yw4Cz4lquiJK/
	 7DIX4UBpCMA6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 580DCCE094C; Fri, 10 May 2024 21:42:31 -0700 (PDT)
Date: Fri, 10 May 2024 21:42:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: ERROR: modpost: vmlinux: local symbol
 'rcu_set_jiffies_lazy_flush' was exported
Message-ID: <231e2516-d54b-4cd6-8564-ba2cecd4798f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202405110230.vcpgN5vz-lkp@intel.com>
 <965221ae-620a-497a-9a80-5725e3fe3f7b@paulmck-laptop>
 <Zj7do9o265Rrm1HD@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj7do9o265Rrm1HD@yujie-X299>

On Sat, May 11, 2024 at 10:53:23AM +0800, Yujie Liu wrote:
> On Fri, May 10, 2024 at 12:09:02PM -0700, Paul E. McKenney wrote:
> > On Sat, May 11, 2024 at 02:53:06AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   f4345f05c0dfc73c617e66f3b809edb8ddd41075
> > > commit: 499d7e7e83d25fcf0fa1a8c0be6857a84cbf6a4a rcu: Rename jiffies_till_flush to jiffies_lazy_flush
> > > date:   3 months ago
> > > config: riscv-randconfig-r021-20230817 (https://download.01.org/0day-ci/archive/20240511/202405110230.vcpgN5vz-lkp@intel.com/config)
> > > compiler: riscv32-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110230.vcpgN5vz-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202405110230.vcpgN5vz-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > 
> > > >> ERROR: modpost: vmlinux: local symbol 'rcu_set_jiffies_lazy_flush' was exported
> > > >> ERROR: modpost: vmlinux: local symbol 'rcu_get_jiffies_lazy_flush' was exported
> > 
> > These do not look to me to be local:
> > 
> > 	void rcu_set_jiffies_lazy_flush(unsigned long jif)
> > 	{
> > 		jiffies_lazy_flush = jif;
> > 	}
> > 	EXPORT_SYMBOL(rcu_set_jiffies_lazy_flush);
> > 
> > 	unsigned long rcu_get_jiffies_lazy_flush(void)
> > 	{
> > 		return jiffies_lazy_flush;
> > 	}
> > 	EXPORT_SYMBOL(rcu_get_jiffies_lazy_flush);
> > 
> > What am I missing here?
> 
> Sorry this is a false positive. We will fix the bot to handle
> this case correctly. 

No problem, and I do know that feeling!  Thank you for your testing
efforts!!!

							Thanx, Paul

