Return-Path: <linux-kernel+bounces-358426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5737997F44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9076D287554
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35011CF29F;
	Thu, 10 Oct 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SI6mWdQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSjI/laH"
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFA195390;
	Thu, 10 Oct 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544558; cv=none; b=HzFK0lXz4+w6EpvLJpdCb/k9S5fxVMqS9DqecWloWHTNT3zb7xsUETYftpCAyKCKBzXrk5cUy9QP19qTdzGGpwhRH9rNqo7ciJ4YRhA5EwBSKcnMAX7lT9Mi0ZM9dhdhLA7i8fUrA9pOrgcrSPhEI5d6IBH3yD93Yi8KBcuNXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544558; c=relaxed/simple;
	bh=4zOm3NrvPceLo4LJ7wkkEBczbuXaU7Gu8QZaHmfIkMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwCVPaxdB2RAZr49vkRghBl+1mFqEFnSJXnBiYdz0Ixu+5lz5OrZBLTm99WUGF6aRqDekhXxq8HAiHXuNDG//6UvHkGA8l1a61IRPFBzOTesDMtJfy7V9DzyPL9MO0Eat8dEjL4zACYCqR7lzIZufeNWuWJvzFTBNpqd94k82rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=SI6mWdQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSjI/laH; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 79F042005DD;
	Thu, 10 Oct 2024 03:15:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 10 Oct 2024 03:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728544554; x=1728551754; bh=DNOQJ3Sz0W
	HdMvTNFyIEo98WwfiiCPVYUsNx4PLXHtI=; b=SI6mWdQMTBSwwS6or9XVnuJJsp
	10uH1V6g4kPSyc/PFKJXkuWiZXg07f7Vra5nd8RZ69aoyNSI/X0c/2HPFiThbZ8z
	WbE2wQisu88Yfi2hxeDJrw2fLUBY/cI45AGeVFUst73BkRHAay6a4zHvkq1JCDWO
	VKNlpTE8cYTXq87xhR2CVdklQos9V8HmMpDkclsgxSyNjOkdzu9MKq2gZTp6Ven/
	1gm3ktzSqC5IHUYF2a5XfILMY33eLHAGAosU6bwn3ZmAg4hbBOt7kPadbedACBUE
	xt8nJYhM7AaiLaov9O4rgldl5vrJ8SZuGeT+B9dgnWcWkJ0CLpe23cV7A49Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728544554; x=1728551754; bh=DNOQJ3Sz0WHdMvTNFyIEo98Wwfii
	CPVYUsNx4PLXHtI=; b=SSjI/laHUfd3fWDjv/F+8IGvY909bQLuleQWWUg4a/+I
	060H7/+MraDrYFg297onBCmeXP3WMv1F2B8lfRDvsdvKeh4zP4pqf2ngjDc0t2qV
	ESERFL04o4yLXXrCmVakfh9Q/8Rie8tMTkwyULEReyG0Zy27WqmGxAFnRqz406lq
	4YJny0ovsA+itXeNh+Qx2LtvhFbC50WV449MuoKiQFEJOWUb9qk5LwZ9CfrybBs4
	l//i8JE/jALbbQJ0UTivDmtTYPBPInaWhY4Pj6TmKFumxPVKbnuZ/eugkE5Quz9+
	Ptjfi9O8Q2c0+VnIEPsrsYZDzGLcLVAa/WR1KV4amw==
X-ME-Sender: <xms:KX8HZ56hTwJ0SzAWzge0QyU-e2V2vwYw788Gh7YlDLLEA6P9ciAiPA>
    <xme:KX8HZ27gudDB54GAFU4j3tyfkte2pTk0uNpcDHipG2ZEI14HgPy1gZBZDQVDGbrpb
    y1zY037Fpi2vA>
X-ME-Received: <xmr:KX8HZwe7jx-dbD7qlc2HiUJu9TOEwyODgd2nbK1-hajxa4uwp4aBhRDzLCuXwe8UJEYCnxxokmQcsWrsafwcAQqy1IEzi8LIuk0GNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeef
    leevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hiohhmvghtthhisegvnhhnvggvnhhnvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgu
    ohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnh
    drnhgvthdprhgtphhtthhopegthhhrihhsthhophhhvghrrdhsrdhhrghllhesihhnthgv
    lhdrtghomhdprhgtphhtthhopehsuhgsrhgrmhgrnhhirghnrdhmohhhrghnsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghp
    thhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtg
    homh
X-ME-Proxy: <xmx:KX8HZyJYklPD3IKzbMaVTlL1MIMq7SbQz8hQ2aKqIke8tfUZMgfJgg>
    <xmx:KX8HZ9LWGQjIr3eFni6UxD1zGjQgJaUD5-sXGJyuZAPKpERFSkWrFA>
    <xmx:KX8HZ7y_f1CZc3397lIXNTw077wWhiviZJlxwtui6EgZI1538U0IFw>
    <xmx:KX8HZ5IclUi1P673fkx7SBWeTJvlZKLHcMFl6DLUbvrWJD1KVIh3AQ>
    <xmx:Kn8HZxCXeiX8W-kOFChGLVU2Jlvf4wZv2vJSUrCV4R3nonMZ3VhelkPq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 03:15:52 -0400 (EDT)
Date: Thu, 10 Oct 2024 09:15:50 +0200
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
Message-ID: <2024101013-reputably-skid-9e01@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
 <2024100855-unsecured-mammogram-001a@gregkh>
 <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>

On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
> > > +#ifdef CONFIG_COMPAT
> > > +static long pps_gen_cdev_compat_ioctl(struct file *file,
> > > +		unsigned int cmd, unsigned long arg)
> > > +{
> > > +	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
> > > +	return pps_gen_cdev_ioctl(file, cmd, arg);
> > > +}
> > > +#else
> > > +#define pps_gen_cdev_compat_ioctl	NULL
> > > +#endif
> > > +
> > > +static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
> > > +{
> > > +	struct pps_gen_device *pps_gen;
> > > +
> > > +	mutex_lock(&pps_gen_idr_lock);
> > > +	pps_gen = idr_find(&pps_gen_idr, id);
> > > +	if (pps_gen)
> > > +		kobject_get(&pps_gen->dev->kobj);
> > > +
> > > +	mutex_unlock(&pps_gen_idr_lock);
> > 
> > Doesn't an idr have a lock in it?  I can never remember...
> 
> As far as I know we must use a mutex...

If you do, someone will come along and remove it, please see:
	https://lore.kernel.org/r/b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr
as an example (with links that show it is not needed).

thanks,

greg k-h

