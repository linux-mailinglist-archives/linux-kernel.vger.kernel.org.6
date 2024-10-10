Return-Path: <linux-kernel+bounces-358479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3B997FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1921C21820
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7051C7B9D;
	Thu, 10 Oct 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nHotkl57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o5cOf2+B"
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226271BBBCD;
	Thu, 10 Oct 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546858; cv=none; b=kyFENgGeN8d8o8VBqVF4l25MP6lsrSlOTp76isWJTyaOna6qDC0zvn0T7eLeBeM3Wymhhqh2gqB5CBSPD55oeAN86Yqqll/El9A/8fnAaIrVa/CI4naFvoC3jWkekGSBeJIoDa6XVk12hKJVWxw/JNHGl+lt1urUqxFmvIaKSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546858; c=relaxed/simple;
	bh=yQdITD3WpxzAEjDgREY4c01kbPx8Bv3a29Byf4HmD4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe3cIYXdYqtAtuNvFfgCTgunSnHwqI1Un+vHIkqVZEC5aq7F8nU9Guje/gwUJ+iKrgBYbWWrUIPyrmsSu6SVZHEygEkEjH3zMqcDmwEc6pTuHV8XA/NgPMP3r1Xkrp0DEFcGT/PZnIEJ/lfshsg51FVbOvu0/YuAXdi0ZYoPhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=nHotkl57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o5cOf2+B; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 1761D200A8E;
	Thu, 10 Oct 2024 03:54:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 03:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728546855; x=1728554055; bh=8ZgPwhYOGk
	lXvFEroC5FWV0PRPDFcPPw8YmjGDO+WMA=; b=nHotkl57YicS1Dy7W6zf9x3fyG
	pxwW76XatgkjGsfEkVFZ7su7XLjMjsN+65tKAagEFcYFq2tUO6jUeKwV4OsTjrWw
	cDp3bjshnjALVaY6k+yJPuyzCEHAiEZYleJKgmdqirr2LbdNOV/e5wRMo9FggI/5
	Elzommy77CP1Uxk6f4oG4Lz3YSbw63wK8eDlpjcBEXzJFPBQYrfnwtZ/0heLyXiX
	4e8qdhAUWUpuuTA0OFynctFm4DTWMhF2yQu8jRdDuBEBTpOJoOBkKisitTPF5VQd
	hjt8UXj9rtoRvdOvZZ3tkEiqgzaUcKmjugSkZuA2BxMJyBGk9qgshETgKXOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728546855; x=1728554055; bh=8ZgPwhYOGklXvFEroC5FWV0PRPDF
	cPPw8YmjGDO+WMA=; b=o5cOf2+BVYeHI7U/Q6+QDES60k9dQNADWsDv4BikpzI0
	nwNFnUogVNUjkli+SoTsdVYL+hP0i1YSTL6/9T077ac9J6nnzSt9bPE6deGhCOeW
	vrI/vRWgvSDWjUWy31QD91/vlztznpQaO+9AX9jEeT4bg1gTxdGvw7/D1GlyDUtm
	WdemYYQHGiB17JmoUqbx68fqZK+UnzIgaFSm83MDteuw9/qqMShBVqdQ4vfKBvB7
	4YIYZv06sI+4k0eTnlzHlqJJCyuS1qAxs1blEhQu7HnkY3px+P4JWW/pEEXX7XhQ
	RwYN18KDmVl0NTdUrj/jBN5MTvw7CnG7qMO0TEKPpQ==
X-ME-Sender: <xms:JogHZ28cs_NJjuiUsCWG35tq8FwEjj7wJBhSajmfW24JMM-LQ7h7SQ>
    <xme:JogHZ2vxGG8w-k7n8xwmWmAok2NcCgsQoHzVr4m2l_mw9btsIyxTzOFN6Zv4XW8tN
    5mlHMWSZF8vCQ>
X-ME-Received: <xmr:JogHZ8BEiQYRT-Yl22GfaoApX5Vwdjrzgc2lX80pcjnWe-w4OLkAEYOdsk8w33TJPVkGmZUYdrnuCHjtusYrHiBe_MIpsPgtzImkZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddviecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:JogHZ-cxGkK-V7KjUga3afS93PTRX-KVzhp0juJJWbZuJbEBxCwDxg>
    <xmx:JogHZ7ONND1nHmcquuQuL2esGtTO-LAF_XVqolGO1pPVYEQM2uE37g>
    <xmx:JogHZ4nDmaIPRXVZbIy5oVnW4bBFRwKpzlgdRygL2CJmTCRBlRf3CQ>
    <xmx:JogHZ9voDuSIMhgjM5s-M33-Rk1RrsAQIqWqYsco8DkYdcMAFr8TOw>
    <xmx:J4gHZ1W3UwIKP7wVH5XStYyT2vDVjkWRX5p8hp23s23o_5nz0xUf8vra>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 03:54:13 -0400 (EDT)
Date: Thu, 10 Oct 2024 09:54:11 +0200
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
Message-ID: <2024101002-viscous-egomaniac-04d3@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
 <2024100855-unsecured-mammogram-001a@gregkh>
 <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>
 <2024101013-reputably-skid-9e01@gregkh>
 <d42b0c9f-086e-4c07-a2ab-8f3b0d6ab580@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d42b0c9f-086e-4c07-a2ab-8f3b0d6ab580@enneenne.com>

On Thu, Oct 10, 2024 at 09:32:22AM +0200, Rodolfo Giometti wrote:
> On 10/10/24 09:15, Greg KH wrote:
> > On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
> > > > > +#ifdef CONFIG_COMPAT
> > > > > +static long pps_gen_cdev_compat_ioctl(struct file *file,
> > > > > +		unsigned int cmd, unsigned long arg)
> > > > > +{
> > > > > +	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
> > > > > +	return pps_gen_cdev_ioctl(file, cmd, arg);
> > > > > +}
> > > > > +#else
> > > > > +#define pps_gen_cdev_compat_ioctl	NULL
> > > > > +#endif
> > > > > +
> > > > > +static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
> > > > > +{
> > > > > +	struct pps_gen_device *pps_gen;
> > > > > +
> > > > > +	mutex_lock(&pps_gen_idr_lock);
> > > > > +	pps_gen = idr_find(&pps_gen_idr, id);
> > > > > +	if (pps_gen)
> > > > > +		kobject_get(&pps_gen->dev->kobj);
> > > > > +
> > > > > +	mutex_unlock(&pps_gen_idr_lock);
> > > > 
> > > > Doesn't an idr have a lock in it?  I can never remember...
> > > 
> > > As far as I know we must use a mutex...
> > 
> > If you do, someone will come along and remove it, please see:
> > 	https://lore.kernel.org/r/b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr
> > as an example (with links that show it is not needed).
> 
> Here is an example about ida API, but I'm using idr API.

Why not use ida then?  :)

