Return-Path: <linux-kernel+bounces-566484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC46A678A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2C23BA9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33220F062;
	Tue, 18 Mar 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FDJLG0Vf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7820E33E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313788; cv=none; b=DxVteYNVbsU79oSRwul/i8EL/20T0og+uwouV3MGMMPuztnoeYS+5S15djEfS7ThSMPBHOcU6WNuN1f16lP9YGDIIt928h4Wf/JIep919KtnxRuRJLli3wCR8x3KXOxmzfqMweeLaNLac1CfdmZXBzq09NcxvZC4vX3DHXkZho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313788; c=relaxed/simple;
	bh=6nZ8oYSTnwqUAfDhNT2uHgGq3X0sIYjYOF9h1+Uab3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTttKnUZ8kEk9g0QJe67biyVVp9WZubUSqEcBNm0vfM7mq+HNx++GA4kkMiXXEwOOWgaGRQjo5ijhcnEtq6lwBnYyc+L1u5QxXkjNbvjg+iMel+/rb3/lYUzPZ3mejrMv0gLFphllsl1j/T8wMM+oKv+TmpmQyMvrL1aSP61R70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FDJLG0Vf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A865E444D8;
	Tue, 18 Mar 2025 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742313784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vde5R4uQeHzajpvd978N33iOJfNN8b+iJiyuAvYgdTw=;
	b=FDJLG0VfY2VAU81IYpjXPDkJJJd6u0fHltPGzIDj51JKTusw462PHrN/0EyMe78QS9LpIF
	VlK8BTzlS4MKM6ljwV+N4TMAP6i6Y7FZnxR1d9vIaSQYQaJ9CFYtzd+47Bcshe/vaFUU4j
	9fIASLIb7ajWfK8LiknqaP+Vt2YUPnzM0xc5Kw6Yop6nS5vWIa0NGKKrXi4LpAM0nK0U4w
	3Zn5n1ca+KWKvMQGHpiEBSvKqnu0qMnuJxvK6ExlxFF3n0o3HS8ciVmauk4ApudH2u1pav
	0fSJbEzODdqC+fEIePeC3iPP7hm39Zir/ueLt0AcnbVWTy0qMaITqUmNF9iSPw==
Date: Tue, 18 Mar 2025 17:03:03 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Stanley Chu <stanley.chuys@gmail.com>, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 1/3] i3c: master: svc: Fix missing the IBI rules
Message-ID: <202503181603034c9ab59f@mail.local>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
 <20250317051951.3065011-2-yschu@nuvoton.com>
 <Z9glVBnpdwXuLwD7@lizhi-Precision-Tower-5810>
 <20250317224440840e4117@mail.local>
 <Z9l1ycFFisuZn2zI@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9l1ycFFisuZn2zI@lizhi-Precision-Tower-5810>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiudeuteehhfekgeejveefhfeiudejuefhgfeljefgjeegkeeujeeugfehgefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemugdujeefmegsjegstdemjeeitgegmeefudefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemugdujeefmegsjegstdemjeeitgegmeefudefgedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopefhrhgrnhhkrdhlihesnhigphdrtghomhdprhgtphhtthhopehsthgrnhhlvgihrdgthhhuhihssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlr
 dhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhgvrhdrmhgrihhmohhnsehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohepkhiflhhiuhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopeihshgthhhusehnuhhvohhtohhnrdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On 18/03/2025 09:31:53-0400, Frank Li wrote:
> On Mon, Mar 17, 2025 at 11:44:40PM +0100, Alexandre Belloni wrote:
> > Hello Frank,
> >
> > On 17/03/2025 09:36:20-0400, Frank Li wrote:
> > > On Mon, Mar 17, 2025 at 01:19:49PM +0800, Stanley Chu wrote:
> > > > From: Stanley Chu <yschu@nuvoton.com>
> > > >
> > > > The code does not add IBI rules for devices with controller capability.
> > > > However, some target devices, such as secondary controller, also have
> > >                 ^^ dual rule devices
> > >
> > > OR
> > >
> > > However, the second controller have the controller capablity and work at
> > > target devices mode when the device probe. So add IBI rules for such
> > > devices.
> > >
> > >
> > > > the controller capability.
> > > > Modify the code to add rules for devices capable of sending IBI requests.
> > > >
> > > > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > >
> > >
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >
> > Please avoid adding you reviewed-by tag when you request changes, else
> > patch work will show the patch as being applicable. This is fine to do
> > it occasionally but not for all the patches you review. You can simply
> > wait for the next version to come.
> >
> 
> Okay, I saw some device tree reviewer provide tag if only some minor
> changes.
> 

Yes, that can be done sometimes but then the submitter would have to
collect the tags which didn't happen this time and there will always be
an extra review for the subsystem that will gate the patches.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

