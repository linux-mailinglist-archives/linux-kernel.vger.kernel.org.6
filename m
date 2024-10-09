Return-Path: <linux-kernel+bounces-356653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739EB99649E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF62D1F25670
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469018756D;
	Wed,  9 Oct 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="INGHLYkn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2H16ImH"
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FEC817;
	Wed,  9 Oct 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465342; cv=none; b=qlsGE3ufDNJ3QlgOjMHV6mADoHio/+a+YTS+S8Jr/z1EuHcyeL+nYU9qh7F/uOEaygvs6W2eJD418ifrbLuwnf46j3MYnixzXGfQzrSN3jLrzBaJtdcD6gjthCle3QwfB9p6PnjWT75ZaqyB82wVqCMpRFGKSAfM8TuefkId0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465342; c=relaxed/simple;
	bh=az3oP8XKxJqTNaLQO9pg2Qs/PWObMGbatyWQ8uLN1bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSaFfe1+7rQjW1KD5Ajb/UUZU6eiY1NAHPrTt6OuUKd6ki6ztlMWhH6nJN20zxXt+zxN/q07ozPSZQ6I7wpYuoqNy/2a+bQXJMKrSDGMBcn0hsWAQjgyms5oBPBVm3vzCXO8eKx4ip4KrzkzNkLN0Lbb0ln5NZkhm3OMqRmXLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=INGHLYkn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2H16ImH; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 43A6F20055A;
	Wed,  9 Oct 2024 05:15:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 05:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728465339; x=1728472539; bh=LAyv3VS/Qv
	UUd89p7XNOt2uXPTdrRqf9gsz0++0rGZU=; b=INGHLYknWwxvyQ3xZtgZEXZ4HG
	5u/0zPTtdaj2EXaD1dZx4POMLf33UKhBZwmbhJbWs2lPNFiex/E2MDJ+OT8HMgJ0
	EKO3G1wN0o8ZO0QET7NXc3HqsSQFGOQS/JPMnXtD72PKFkxUE/CF3Eou4IdnAbeZ
	Eu+M6+EFKIHQDk2MPDk3cUC3fber35ZIQYjFomry9QQO+R7bcEhB2nOOsQOofh9b
	Vs74tL8NCsAvjRGLGP01aFwhr6vCPm7WaV7CoU7caipmG7ZbMS8ae9igQnwHbQLu
	2xeqk8OuJyRMpstBjkHCQ2UKbtEO3+BYUdIq5PajNo+V2ceNYWOaRc5Ugfpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728465339; x=1728472539; bh=LAyv3VS/QvUUd89p7XNOt2uXPTdr
	Rqf9gsz0++0rGZU=; b=S2H16ImHCSSmqcjS7yYKXg+RL8QQw4VUKS4ON8kYoYp3
	jh/EYCXwpXYwrOzWjc77pffkyx+mmyvP77cHC3hprkKZF1QVE3wArkj2wzOHlmZP
	2tIivSKGPQZauQVMk9ZnFAnFWW5hNCFVXqSbIRGyagvD3Ktsfx2DNZKGj0aqj2zH
	QgFYIEkATFp6WeAWeMKYGuUL1GFApbddTVQIcN7bTUdogntgl/crjCHGccowbeu0
	lv03SI6yUzJqdpnnAFLMR15zoG6VvmVkXx8whk4+yuZVLzo8jW76/jRojB/3nULS
	3urq0XMJNWHBMMOhvVFm1ehOpgG/GvmV5vXaDJktsg==
X-ME-Sender: <xms:u0kGZ59PnC0LBD7G0l-U9_88pDJUniy21CXWwu2fZmIMXARicML4lA>
    <xme:u0kGZ9vcoGuuro5UgqEQCNZek6niiTen-wklfco5J1co5NfStFNiAQJTg21H7eFEe
    o8XeWAdM5YA6w>
X-ME-Received: <xmr:u0kGZ3AjL9VDc5ziH-88DBYNGxKg3snkuB41J94EQTy9_Y26rnnSSme9G0A_HhFcfc5OuAUm98Yaw9k907Dcpfz13IGxy1aORqMMAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:u0kGZ9ciDC-m7hsZ5qeHQ9PCtZzqaHzrEBHSNHQF6pzX6qcJqmHZhg>
    <xmx:u0kGZ-PD77u7TP7DxYpZqktPwX8EdzNeXGoD87cf27WdX4Fcm7OGAQ>
    <xmx:u0kGZ_n1Pl8LNZyQutRQyzo4BfDi9IjTsZdxzmhR0GGvkcxnCFbCpA>
    <xmx:u0kGZ4sC9kCDkEWK-4GV5FlmzrM05NZQlRSlwi2SYsdVczV1SpDE_Q>
    <xmx:u0kGZ0XgQL1VmV4mBdoeEKW8EUAyxcKWM9_Nol8hmkN87ng7Cautf0Qo>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 05:15:38 -0400 (EDT)
Date: Wed, 9 Oct 2024 11:15:31 +0200
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
Subject: Re: [RFC 3/3] Documentation ABI: add PPS generators documentaion
Message-ID: <2024100902-droop-uniformly-8dc8@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-4-giometti@enneenne.com>
 <2024100819-wildlife-counting-6c63@gregkh>
 <fcb70129-f6f0-459f-b099-a2ca3a569095@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb70129-f6f0-459f-b099-a2ca3a569095@enneenne.com>

On Wed, Oct 09, 2024 at 10:48:23AM +0200, Rodolfo Giometti wrote:
> On 08/10/24 17:43, Greg KH wrote:
> > On Tue, Oct 08, 2024 at 03:50:33PM +0200, Rodolfo Giometti wrote:
> > > This patch adds the documentation for the ABI between the Linux kernel
> > > and userspace regarding the PPS generators.
> > > 
> > > Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> > > ---
> > >   Documentation/ABI/testing/sysfs-pps-gen | 44 +++++++++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
> > > new file mode 100644
> > > index 000000000000..9ad066cb3ce5
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-pps-gen
> > > @@ -0,0 +1,44 @@
> > > +What:		/sys/class/pps-gen/
> > > +Date:		October 2024
> > > +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> > > +Description:
> > > +		The /sys/class/pps-gen/ directory will contain files and
> > > +		directories that will provide a unified interface to
> > > +		the PPS generators.
> > > +
> > > +What:		/sys/class/pps-gen/pps-genX/
> > > +Date:		October 2024
> > > +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> > > +Description:
> > > +		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
> > > +		PPS generator into the system. Each directory will
> > > +		contain files to manage and control its PPS generator.
> > > +
> > > +What:		/sys/class/pps-gen/pps-genX/enable
> > > +Date:		October 2024
> > > +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> > > +Description:
> > > +		This write-only file enables or disables generation of the
> > > +		PPS signal.
> > > +
> > > +What:		/sys/class/pps-gen/pps-genX/name
> > > +Date:		October 2024
> > > +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> > > +Description:
> > > +		This read-only file reports the name of the X-th generator.
> > 
> > Again, why a name?  What is that for?
> 
> This can be useful in order to distinguish between different PPS generators
> in the system.
> 
> For example, the PARPORT generator is not very precise, and userspace
> applications should be able to know which generator corresponds to the
> device /dev/pps-gen0 or /dev/pps-gen1, etc.

That's what the device symlink in the directory is for, no need to pick
yet-another-random-name to have to read from a file :)

thanks,

greg k-h

