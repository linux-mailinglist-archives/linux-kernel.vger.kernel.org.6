Return-Path: <linux-kernel+bounces-566478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451CCA6788E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0486A175D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78020FA91;
	Tue, 18 Mar 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l7+txS75"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC020E313
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313521; cv=none; b=Ltdv30sTgZgZcFFFO4VbB+Oueb3EOoHHz/Cw/iHwXxPZ/vsZpWtI3xDQHnU40uXkBfCUIvuShejsZhFmL4FG9+geQouYcNcV/EFNJ5F/aXt3Ozpv/ZkHP6T0i9d7Res8CT20VJOs4zI9EucsMbgn05BrwjbJLjxv4mw9m1ztVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313521; c=relaxed/simple;
	bh=oiLsLLlStK47sOZdC3VVn2G5zwWXnqET/C5jjC0qvmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m99osCjwx5kNC9azq00at04BED/U6LtmewCavQoN/Yw2LJN3iJgKkYd/LkNzfdQKsAkXEPUJvFRERedEqLTRnhI4V2ohfJDXgjDje5QrNpFNubdB+4KD/xTLqMP2nPmPTsJcpat2EtJDT13jU+Nc6lEJsQcp/51QkV+5AuSvfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l7+txS75; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 532C944338;
	Tue, 18 Mar 2025 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742313514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fP4ry+VLHXbxhxlQCKXjcIOOhVgHzKoDLPahcV+SBW8=;
	b=l7+txS75TzzQJ7j92uC3S7/c6sUR3CfA5jujJbbhZz/oXe5isRcJz4X2F5qL6dbvoWTYBj
	ggOKABa3a9W6tiMG4hAWo1g0n3OWrpWU3LpEvK/aDaTC4v2p4wneOh5hIPgjKSxuihO7hp
	OTl8hgKCTVGm2fX3Mvb+Ue46JgaVeOl6OEso39CFOYKZ9K24H4ZsunzicHRJTAJLw2NlGb
	7Lk6UdwO1UD/u/Gjp/iHmLcGA7XN4T8i+9UNt+Jhz04Uwfu/PMSFzIc7l9324gUTDaaqNm
	cx4mk9a5zkcfXlCTLrtPtCm2haiTRL+cJVQXu6vHb3aIn6u9xLyuhn82gaDDfg==
Date: Tue, 18 Mar 2025 16:58:31 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: miquel.raynal@bootlin.com, Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] i3c: master: svc: Fix i3c_master_get_free_addr
 return check
Message-ID: <202503181558316ef27a06@mail.local>
References: <20250310023304.2335792-1-yschu@nuvoton.com>
 <174225158210.1593610.10018812780731849409.b4-ty@bootlin.com>
 <Z9mIUc6Ln59umJtT@qasdev.system>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9mIUc6Ln59umJtT@qasdev.system>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemugdujeefmegsjegstdemjeeitgegmeefudefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemugdujeefmegsjegstdemjeeitgegmeefudefgedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehqrghsuggvvhdttdesghhmrghilhdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephfhrrghnkhdrnfhisehng
 ihprdgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On 18/03/2025 14:51:49+0000, Qasim Ijaz wrote:
> On Mon, Mar 17, 2025 at 11:46:29PM +0100, Alexandre Belloni wrote:
> > On Mon, 10 Mar 2025 10:33:04 +0800, Stanley Chu wrote:
> > > The return value of i3c_master_get_free_addr is assigned to a variable
> > > with wrong type, so it can't be negative. Use a signed integer for the
> > > return value. If the value is negative, break the process and propagate
> > > the error code.
> > > 
> > > This commit also fixes the uninitialized symbol 'dyn_addr', reported
> > > by Smatch static checker.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] i3c: master: svc: Fix i3c_master_get_free_addr return check
> >       https://git.kernel.org/abelloni/c/d6cb667b8e15
> > 
> > Best regards,
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> Hi Alexandre,
> 
> I sent a fix for this issue on the 9th March, which is before the patch
> Stanley sent which was sent on the 10th March.
> 
> You can view my orignal patch here:
> 
> https://lore.kernel.org/all/20250309164314.15039-1-qasdev00@gmail.com/
> 

The issue is that you then resent the patch with the same topic which
superseded your original patch. But the resend was missing a blank line
so I could not apply it immediately and I later applied the other one.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

