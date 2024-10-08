Return-Path: <linux-kernel+bounces-355527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACB99538B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082391C255E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B811E04AD;
	Tue,  8 Oct 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cPAfuUkc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfeK1qwO"
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83341E00A9;
	Tue,  8 Oct 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402201; cv=none; b=e07ccf7HOvQBp71v2He4p/WTYrbr+49+NUHKimW5USzK/xQUtrYTpTcFf9yOxuZtnW+CnrN8gg8mOJiJPhN3ugxnr45EkYOjRe0L7yVvnrG6ubLy6pYVklhgnvIqf/2GwLQC3bVee+IhuZUv9V5JxdmOxFESnUNDooi3dy0iD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402201; c=relaxed/simple;
	bh=9mNUR//WLomUufq6ZYZd4Vozf2qdmnKZrcApWjWbgAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkTv2IyQHmAnRV7y0cf4RqB7PNL1LbJMxXeTHnpyO5YOz+Cd/BVn0CsjgCa9X77PBdaPXAd40VPdsfhb2+6wJMfFipMHWoHVv9uIEZ30CllEUMDUSspXnR0r6PmrnRhYzkJrjUlFhRrXFFTW/FfjWznZb9IgJveD1S+rBSjbp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cPAfuUkc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfeK1qwO; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id C86A3200305;
	Tue,  8 Oct 2024 11:43:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 08 Oct 2024 11:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728402198; x=1728409398; bh=EUPKgSfRUy
	jHwxQ+sn33QCfQ7lcWLFnbH9jyuETITqI=; b=cPAfuUkc0VcVyY4uBhDzEJ/JA2
	nK1SN31l49ZH9PTwFMUywsd3qbqNkBkkRtqK6AFaqae5URdzlFXw9rHEY5KHRoxA
	hDbr+fqFOgSWr2Ol2NFR+Wl0Dobb5eT8vhGGZ2ZmVjBOLPCo7moSILbiasghL4l1
	iRCdIfVJ2H71DcaDV6sXHgZUpNFBM9p2pDr38D0DbmwLK7M1iSEYshq9e9xQbiY3
	zvtUdxcQjeeg5okQ1d0k53ml6n9Eqn42YZ60DVQJ4MDn96H4J4PL3xq1elbbvQQy
	JCu/UrCMy8L3+nK2WBHEPqkuwK7eJDyiHdghY9jUb0MZYkBx4kBx0NE/sJvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728402198; x=1728409398; bh=EUPKgSfRUyjHwxQ+sn33QCfQ7lcW
	LFnbH9jyuETITqI=; b=hfeK1qwOMPklSgf/8SBwgHrcc7fbFKVlcSRahfvb4V2t
	9jIPk+WehSF+l1rXMPvovKugOJJ0nTBLa7ifhNQyx1hK+MEpKyCYHb71Fy0iQYFo
	BW5rRs6s/fizkvYZb5b+VQLz5jyLs83V+x+KTYmci3jnxBYCy9l6oRSftn6xKltn
	BEbS7W8C37a8m2izclfdk2pDiW9jGJx5b1ZpIJ2SiL4dCparoqKaMos5UQqiso8K
	pgXs0Tl2DYa0Pr7ITVYC5Po1DQsk8slknxDmi/KgPIU3tGFZPnZrp53/5coWLSwJ
	+FAF3xn4V+DGBO639zqPwh5gifIcgOySYQmY7NMJTg==
X-ME-Sender: <xms:FlMFZ7CeRD9hUS8vcA_9pfS2Ls7CMRc_xNpoXB9bk4rj0AFnLBs3XA>
    <xme:FlMFZxjN_8jg7c-TPMaboYvSndpmDNtvVyEZdWHCLnTAhiwPa_Obga-kowpHsUXOf
    ARRj2Eju50mAw>
X-ME-Received: <xmr:FlMFZ2k7rkBxaRr5wLo2JwOfLynow63ZEfWMpNFRAhcyLyqksxe8OCDGtKsm0T_-hYknsmTP8GmegNTPh4qU2_aXW5sa5TFPKOoW1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedvkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhiohhmvghtthhisegvnhhnvggvnhhnvgdrtghomh
    dprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopegthhhrihhsthhoph
    hhvghrrdhsrdhhrghllhesihhnthgvlhdrtghomhdprhgtphhtthhopehsuhgsrhgrmhgr
    nhhirghnrdhmohhhrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepthhglhigsehlih
    hnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhk
    oheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:FlMFZ9wNPyvF2gp9rDn6Z5lVOCugVHSrlYTWJIqb1kWyVewMtJnjEg>
    <xmx:FlMFZwRTYNtUigWc3xf5N7-YLphOIHVkRNWOR18ay3tnnv2AQ1dySg>
    <xmx:FlMFZwaNL3MQnpgICI8tTsgJWeWf51VtUnMz4OwI9uPFmxTfgu4nyA>
    <xmx:FlMFZxQBGGzLbuteKIligpGXX6Gt6IwO0XsXhe0RgU4EnhmePs1Akg>
    <xmx:FlMFZ8qx5lK-R4qDtq4iGOzlVxGaBM-Sj6GxmpQtjBDDEdM0yN9a2kmg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 11:43:17 -0400 (EDT)
Date: Tue, 8 Oct 2024 17:43:16 +0200
From: Greg KH <greg@kroah.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
Subject: Re: [RFC 2/3] Documentation pps.rst: add PPS generators documentation
Message-ID: <2024100850-stunned-curve-2ba4@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-3-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008135033.3171915-3-giometti@enneenne.com>

On Tue, Oct 08, 2024 at 03:50:32PM +0200, Rodolfo Giometti wrote:
> This patch adds some examples about how to register a new PPS
> generator in the system, and how to manage it.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++

All of this can go into the .c file and autogenerated there, no need for
a separate .rst file that will quickly get out-of-date.

thanks,

greg k-h

