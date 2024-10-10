Return-Path: <linux-kernel+bounces-358749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93C99831C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1941C213D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5491BDABE;
	Thu, 10 Oct 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VuxmI0Jg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPYNPep5"
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766936D;
	Thu, 10 Oct 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554690; cv=none; b=mInu/X4fSLc0rPtUglP2L+DGLCqTp+6OX40k1W3pz0d0aYf/KPOyfpIA/8KmxxuTnJP6S3nhlOV7myBD8DpxuD1yilsUl2895PtQboECcGRpi9AFJAMOauVOq9Zzi4CE292xHC1JIduKyti+R8FxTvrch+l9PeL+viW8dfmUo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554690; c=relaxed/simple;
	bh=UxreIeFoXEW0muHpibFvLv3F8bSIxJ5jh37OQHhXuUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9wDUxzVd3L0J9QTWtO533j5mgVwJ2DzgQs8ZtpbplzRWffC1CjMKYOgbOEpkNiyeSTMa3marCIk2jtINdYv3K474nbsQDtogK6eNqSyPLpQdIqbak5yHIkKu94FuOF1x4UWMsgbUwMxXpfZiNNa1m9Uh/u61JRe0ViOwzs5DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VuxmI0Jg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPYNPep5; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 7EBF6200AA1;
	Thu, 10 Oct 2024 06:04:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 10 Oct 2024 06:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728554686; x=1728561886; bh=umOXrAtyQG
	MR3k0G5jvj5CkThw/BhZDOvF9ePG5oS28=; b=VuxmI0Jgz+l0GSQfN3PvA158zG
	q4gNyLxAgZsK07j6n67qixudFVkASSohR89OmManzKBl89Kn7p7RoK9J2Je57mY+
	YVuZQ/oCbvQ2JO1e3ee9Z+vpg4tXUVnvA7035UcgGJswqVYb7pgn1vg2fe0GpEqz
	WaXy7nNR+Fl0wX9n3kVZeGH37bjXRceHhaNAzvtL035L0J9p9XwaUDZf+8bk9NsP
	hBqbEz8lBkG21S0R7FxRX+hsa+3dRfnsytX+6X4juIt7LuSOJktkyh5pGBOzDKNM
	KsMl2gtyesmMM49ssYAjtMiZNZOcUz8JR/mpYeG/j+wijZCc3XGVX8W1GNrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728554686; x=1728561886; bh=umOXrAtyQGMR3k0G5jvj5CkThw/B
	hZDOvF9ePG5oS28=; b=UPYNPep5mAKmLekl9U3n3vk0lLWO2XcP/JZtmhQWcjM0
	wUQAA+VT+10dsl/kn/ggyjtzJ2i4XfkP/i9ryKnDb3gpwJUehVEiQXeWQCzVOiKp
	Jrdrr8LAYJK0Hlk00YMTJL40EUTOA2MPQzn1JkrkiJW/ZSxcMnqFTmFaONOJYYAm
	qStwL7sDK7xOSVd778lRsK0csoAu1z+xxNB2JyeocESrexI8r2vtISM9Bt9RlVs8
	d/yuZwRitwjaSRLs3ZsLPatMt95GIGeyAZmjjMe2Ob6ZmLGzr0Bykjrhs2M8aRv1
	bBTlk+odOXnUD8tQtuyS1J0WYG5+zRIZJx3ipJxjDA==
X-ME-Sender: <xms:vaYHZwj2iRSAwtyCR77LsarD0QCrA4CfIQXWJqGYfvvCv-j-P85CnQ>
    <xme:vaYHZ5ANH7nQHlOjMOjwU-lcwXhhPgRBxykHWdjqSjkhB8MYdgiefLHlhJ3X_gVy4
    9__rmwjwXb43g>
X-ME-Received: <xmr:vaYHZ4F-iBA8qRRf60C6b-Qr-AF9Nmt1uqzaMGnyGKOYUk08483GKQTN_8Prx_O5wkB7EMZmGvCgi9CU6M3G6ESqrvMoI0pom7gNAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    homhgvthhtihesvghnnhgvvghnnhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqugho
    tgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrd
    hnvghtpdhrtghpthhtoheptghhrhhishhtohhphhgvrhdrshdrhhgrlhhlsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepshhusghrrghmrghnihgrnhdrmhhohhgrnhesihhnthgvlh
    drtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphht
    thhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtoh
    hm
X-ME-Proxy: <xmx:vqYHZxQvlW2Wma-CwId9dM10CkUZoqSM__3jYaI5gfhpgyGfTLYs-w>
    <xmx:vqYHZ9zHhKu0ixuYj8NiD4QzN7Lio1K_e2dYdbg342yk8VcfYPNumw>
    <xmx:vqYHZ_5cz9o8DjI3O-ywbgw8SJlaOo8QJIk0VgkLv9d8GpIWbbF3aA>
    <xmx:vqYHZ6xdnOhKXdkka1qfAad6Up5xoRcbpYy9A81J-mVYlsTsOWJjGw>
    <xmx:vqYHZwLPvWv5voVCxPQvJVWX-VvqnDFkPEmev_ucJktN9MlJpoVgaFA->
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 06:04:45 -0400 (EDT)
Date: Thu, 10 Oct 2024 12:04:42 +0200
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
Subject: Re: [RFC 1/3] drivers pps: add PPS generators support
Message-ID: <2024101022-scoundrel-ravage-19a2@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
 <2024100855-unsecured-mammogram-001a@gregkh>
 <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>
 <2024101013-reputably-skid-9e01@gregkh>
 <d42b0c9f-086e-4c07-a2ab-8f3b0d6ab580@enneenne.com>
 <2024101002-viscous-egomaniac-04d3@gregkh>
 <253ff116-6ead-42f1-a3a7-0d627ac90b5e@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253ff116-6ead-42f1-a3a7-0d627ac90b5e@enneenne.com>

On Thu, Oct 10, 2024 at 11:53:44AM +0200, Rodolfo Giometti wrote:
> On 10/10/24 09:54, Greg KH wrote:
> > On Thu, Oct 10, 2024 at 09:32:22AM +0200, Rodolfo Giometti wrote:
> > > On 10/10/24 09:15, Greg KH wrote:
> > > > On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
> > > > > > > +#ifdef CONFIG_COMPAT
> > > > > > > +static long pps_gen_cdev_compat_ioctl(struct file *file,
> > > > > > > +		unsigned int cmd, unsigned long arg)
> > > > > > > +{
> > > > > > > +	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
> > > > > > > +	return pps_gen_cdev_ioctl(file, cmd, arg);
> > > > > > > +}
> > > > > > > +#else
> > > > > > > +#define pps_gen_cdev_compat_ioctl	NULL
> > > > > > > +#endif
> > > > > > > +
> > > > > > > +static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
> > > > > > > +{
> > > > > > > +	struct pps_gen_device *pps_gen;
> > > > > > > +
> > > > > > > +	mutex_lock(&pps_gen_idr_lock);
> > > > > > > +	pps_gen = idr_find(&pps_gen_idr, id);
> > > > > > > +	if (pps_gen)
> > > > > > > +		kobject_get(&pps_gen->dev->kobj);
> > > > > > > +
> > > > > > > +	mutex_unlock(&pps_gen_idr_lock);
> > > > > > 
> > > > > > Doesn't an idr have a lock in it?  I can never remember...
> > > > > 
> > > > > As far as I know we must use a mutex...
> > > > 
> > > > If you do, someone will come along and remove it, please see:
> > > > 	https://lore.kernel.org/r/b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr
> > > > as an example (with links that show it is not needed).
> > > 
> > > Here is an example about ida API, but I'm using idr API.
> > 
> > Why not use ida then?  :)
> 
> Because we need an ID associated with a pointer.

Ah, ok, but why?  Why is the "id" here the mapping to the pointer?  Why
not use the structures you already have to store this in (i.e. the
normal driver model stuff?)

All you should need an idr/ida for is to pick a unique "number" for
naming your class device.  Everything after that should already be there
for you to get access to the structures you need to get access to.

thanks,

greg k-h

