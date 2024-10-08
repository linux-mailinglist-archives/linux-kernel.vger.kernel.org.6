Return-Path: <linux-kernel+bounces-355529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4908199538E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2831C256E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564501E0B63;
	Tue,  8 Oct 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="dzbNI35C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyampA03"
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5B1DFD8B;
	Tue,  8 Oct 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402234; cv=none; b=pCiv0Z3KpESUtTpx9mrokwvqFrHQw2YAWyiKoHia9NfpN9WVYJwTOK7JLeNb2Xhq49rg0RzHALP4EHW0fAV0c8LMFQtto3fnulNdho6LVRtyP8x7dxFo2aGhTCj3sUmA6/q0PzDLB/zVCaGzITjg/B84FIknNCOMmd2PPuxpRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402234; c=relaxed/simple;
	bh=kibQiZ7MUXO9FWBfsXJG4QfUKF6DMjfZUlKYeN3IbaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsKMbjXyswR0CCqyXrNvv/CLmNvi+emgKTcMBiu9T40wz1vUxFX40GtUjbyQCUy3l6r2ACYZ1kmm/Oa8u07+qbYbJi7w0s53cVfG13H67sxhJLqip9nRhEL20J0vkiIRbIlFXCvrJ1DK9b0zlInOWpHEWa4uB++HWD/tjbU/Ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=dzbNI35C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyampA03; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id B256420048A;
	Tue,  8 Oct 2024 11:43:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 08 Oct 2024 11:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728402231; x=1728409431; bh=l0xeH/FCCL
	ppRorwdACWdysYGh4W11hlmJQYjSLUypo=; b=dzbNI35CVLAHolVPibiv52nJzR
	aZ5Fu6xM+1Gw3aQVp9pPZldoFtGovLnFCsk0Mj0JJ71Z6CBXjXWogI6rxUbopciz
	7zkoezcBGxXDwxR/Xq8mR54Fryri/W/tRJIlybCCqS5FFe8tz+VxZEGdN//bR0wi
	DW9H2id1b7IJyaw7SKFPY1Kzq4a5C93BuvgbQ67OxrBsK5kyGQUCnrQId4FaBPOg
	mD2Ctg968FEUzYg5NQAnmTCfj+syTP4JTsf9jiPz9A5Mtqohcx8vqpBaLFAEn/IA
	fCCP+RcSLLqqlUy/liDx2SvKDQOy79xJsVo2odaeK4VygvNO8bIIBghKbZzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728402231; x=1728409431; bh=l0xeH/FCCLppRorwdACWdysYGh4W
	11hlmJQYjSLUypo=; b=GyampA03PbYHio0MYbM3ulWkqT8Hrh0ecMsGM2NuutRw
	UbHtvO8MHgHxVkQOQa75QBVnVmqCRQwaAyHdwCYkLhHGXoL5F3Eka0+U6UPFwEdg
	2ULZFV8gF0d7oxB5miuuTgpaSc0f/pCUfePpO8kwZV65ABtonN1xQWDxictQNUvz
	cHQggVrAEOuj8YQxxfHG8rhfFTHXAnKJfa1U7BYZPmOeBZ5yGwC3y+pSErmIodxi
	Ur6YRP9zTKKS4r2c777p6tNX+Y3c9RODHLuuZwMPE1Q/9wFGIW+JlxKdtFo91g8p
	jVgfIkTyFRUW6+JdbyZr6eGdJPO75iLohmfjUoO0KA==
X-ME-Sender: <xms:N1MFZ8mTCzSCfgWwzWwqiTRscfG6ftj50ApQ5C-XTV-MSPB8E4_F-Q>
    <xme:N1MFZ72e9mJJm73nnLx6T14YRUoYoQUOdCDsOvxs_6tER0ydqIantwkSwh848yMA-
    sbbaqb-CPHcfQ>
X-ME-Received: <xmr:N1MFZ6q8O-mHHQYBGBg_4C2UNEAQavpqc_GhJVEfjZbPj2ERD_ZMvpWuK2ng-8bXiUYjD82EPQ1lhRyXT4LMAHFNgRH2yRs5CJw7og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgledvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:N1MFZ4l8i5dbg9CeYqkLfWFf6QdlX4AVIZCMLGoL1Qens8Es8HwcXg>
    <xmx:N1MFZ63g1rDjphvhlVY2nKxZp6Df6mSBsYqmWxh0VL_ERRVsSJXKsw>
    <xmx:N1MFZ_uzu__AlHpMWoWN0tQTUkTcSkgMx25gmGbTIfkeaiEX6AudEQ>
    <xmx:N1MFZ2W1oI4hNXl5ty3NeYmpLmsX7_87kZeXOAN2UoF_wIOjWOb0hw>
    <xmx:N1MFZ_f6ONbWJRi470kBXgVSJe-EHjojNltVnVBo0l4iQneZQaQDIVLu>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 11:43:50 -0400 (EDT)
Date: Tue, 8 Oct 2024 17:43:49 +0200
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
Message-ID: <2024100819-wildlife-counting-6c63@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-4-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008135033.3171915-4-giometti@enneenne.com>

On Tue, Oct 08, 2024 at 03:50:33PM +0200, Rodolfo Giometti wrote:
> This patch adds the documentation for the ABI between the Linux kernel
> and userspace regarding the PPS generators.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/ABI/testing/sysfs-pps-gen | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
> 
> diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
> new file mode 100644
> index 000000000000..9ad066cb3ce5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-pps-gen
> @@ -0,0 +1,44 @@
> +What:		/sys/class/pps-gen/
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		The /sys/class/pps-gen/ directory will contain files and
> +		directories that will provide a unified interface to
> +		the PPS generators.
> +
> +What:		/sys/class/pps-gen/pps-genX/
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
> +		PPS generator into the system. Each directory will
> +		contain files to manage and control its PPS generator.
> +
> +What:		/sys/class/pps-gen/pps-genX/enable
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This write-only file enables or disables generation of the
> +		PPS signal.
> +
> +What:		/sys/class/pps-gen/pps-genX/name
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This read-only file reports the name of the X-th generator.

Again, why a name?  What is that for?

> +
> +What:		/sys/class/pps-gen/pps-genX/system
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This read-only file returns "1" if the generator takes the
> +		timing from the system clock, while it returns "0" if not
> +		(i.e. from a peripheral device clock).
> +
> +What:		/sys/class/pps-gen/pps-genX/time
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This read-only file contains the current time stored into the
> +		generator clock as two integers representing the current time
> +		seconds and nanoseconds. 

Trailing whitespace, please always run checkpatch.pl.

thanks,

greg k-h

