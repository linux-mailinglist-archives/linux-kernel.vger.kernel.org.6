Return-Path: <linux-kernel+bounces-356652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D852199649C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159EB1C20A96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB818A6B1;
	Wed,  9 Oct 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OjZUD6+Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiUMl0J5"
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074F176AB5;
	Wed,  9 Oct 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465300; cv=none; b=pV0sdMq1eXM9qKZhccNld5pf6K7mRTFpaSod+GcxsUF2HmYtO+KbrAoaRJIkVkBvr9XQEoJOFJrVoJY64kIB0hwVIqlAIEt1LKSFQuFk5nncYurPtlVm2/x3m2oTMP6H7zgo6gMwByfpvgMtoVPiT+kTg4lfPiLe9l2lTdIou3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465300; c=relaxed/simple;
	bh=mDAd7lYgScrwy6UukpvWxq2YwNPPYLzg9hqsamlAhQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBTgcsngPtLqwutZzulRWkRXVoKEGRUQUYEIkrQgB9jD3BBxfuCVxlcleiGKOid3RY85dYIgYFcbnhf7zG8Bm3SYySPJVklYNSHXYZJ2uc8YclhRyCzSHh1Vse7Z434FtE+3dA8SDtNCq//hsLtQncgl/HVNJcpJW0BpG+hVBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OjZUD6+Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiUMl0J5; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id B67C7200539;
	Wed,  9 Oct 2024 05:14:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 05:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728465296; x=1728472496; bh=ykuMn4Gfu+
	9n4bYVayawskQGI00iTjMXs063l2RtcOA=; b=OjZUD6+QfBD1M4xYBFRNi3HsSC
	C9nttSJ6CKcYMUar7z0FpPWoIhLy2j+PkeGHIFFwcK2QyAOd7PicW+rwT62D7dra
	M0yqo7IgBVi2YWHo/Z26TnWdH+y0on/XG8R51HikN8Jwqr2GeO7pGNq58ZNUZfOp
	fFtQuvRpyBHKdG+TuvZ354oEAfAafXfKzfRyuY8ULiJtf/fb5BVyCmsxBmkDi92D
	fk8skAgCVrtJLB0fML//9+Y1ViY7eSvLbIR6DurzucXUJZbzdWQ0JepLFPVMUmi+
	ttOVvm4hjJqj5/qQ+aWYs+Y5wFzudV7rTnbGWVi60HkNHbdvZquLvBt53RXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728465296; x=1728472496; bh=ykuMn4Gfu+9n4bYVayawskQGI00i
	TjMXs063l2RtcOA=; b=GiUMl0J5Ym16HR6orwhZ7mUnwP1TjY+EpHycUk8CvYSe
	3ZAAu2gI7jneYDsIJ5kKJoxak5GKg7vGBDiY4R0C4o67toWD3ifoptXCqnOQSuMo
	fSVBKl5+RKB/JmE9062+RZuI6COrDNNXg9gcOGGiOCYhV29XPvt+19lKPW58pail
	8JOf2F1fv7vqW/IxZBe+mcbm1Rd3u2jLv5K8jOyPgel52X74/CzM6VVb7jY48zZk
	xFxnAIv5jlB67jH9VIFXO6RAoyRajgCp5IZAd+IKLpe8A1uPeEagX61wYopROkEM
	TKYtrhx5tV78EW9X1wn0W/OJUOIUNurD8BA21cU7iw==
X-ME-Sender: <xms:kEkGZ6TYt9toMlleOFDWut2QozWYnWtDD_hcmFe9CnZXqTWQAbV4vg>
    <xme:kEkGZ_yxEPFoe9uWLRa8wB69kU7bu8RIj6NZATatb0i1tsfYksyNiYodMGIbPjz7-
    9gTII6Kp0KbEg>
X-ME-Received: <xmr:kEkGZ32ItDd7mYUsXywYDU0mrgfDjOidkcHJ_v43p5TrO7EKg9wdTho_JsyMt_JAL4c6dvCzpBt6ZmWQ1ob-CqJW4rZWhfaSGeBkSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:kEkGZ2DXnWj6eVTTNVprNuDNOQs0k1b1H4teGQNn7FXhU18md8rWwg>
    <xmx:kEkGZzi4eGP6KB5NrLczs3uj_MXM1UB-6lyR_l6MAXsYBPLb8WConw>
    <xmx:kEkGZypcb7Qll86Imnq4q0sQbpFw2HbyY8cpVm5ssqVyCy84UYuwyA>
    <xmx:kEkGZ2iLjbV1hZ9ZcvNflaYI11V88Yrd1_o6I84q71cLzYK-WXslRg>
    <xmx:kEkGZ06NnF4J0srXR2SlJNCObWrWuDMXtLuGrHOIcpnpay63eQzwqp_8>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 05:14:55 -0400 (EDT)
Date: Wed, 9 Oct 2024 11:14:53 +0200
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
Message-ID: <2024100932-twirl-stabilize-8574@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-3-giometti@enneenne.com>
 <2024100850-stunned-curve-2ba4@gregkh>
 <fcb082fd-2572-4782-b9e2-69cdbc22714d@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb082fd-2572-4782-b9e2-69cdbc22714d@enneenne.com>

On Wed, Oct 09, 2024 at 10:48:18AM +0200, Rodolfo Giometti wrote:
> On 08/10/24 17:43, Greg KH wrote:
> > On Tue, Oct 08, 2024 at 03:50:32PM +0200, Rodolfo Giometti wrote:
> > > This patch adds some examples about how to register a new PPS
> > > generator in the system, and how to manage it.
> > > 
> > > Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> > > ---
> > >   Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
> > 
> > All of this can go into the .c file and autogenerated there, no need for
> > a separate .rst file that will quickly get out-of-date.
> 
> I see. I'm going to add proper documentation within .c files. But since some
> references about PPS generators are also present in this file, I think it
> would be wise to add some notes about the new interface...

Why not just move all of the documentation into the .c files?

thanks,

greg k-h

