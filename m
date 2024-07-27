Return-Path: <linux-kernel+bounces-264130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947E93DF46
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2114B21E24
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEC78C73;
	Sat, 27 Jul 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhugC3Jp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD978276;
	Sat, 27 Jul 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083264; cv=none; b=rZXUksX9L1C8jPioi2zQ2rWMAsZ8I2IUHAvu9raKblcMttO3omST4MiiOc89wgIVSnxt0pwoaA403O8s2GYRbAQLwKfG3FL3LZ8LGBQUoXOGeAnOQeXiPocsLLmCwJmk2mSQ5skC94A5MwascHUbCcFVZUWpavB7qfFvth9WGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083264; c=relaxed/simple;
	bh=VZEg2zc8fwE6kWAYB6Y2R2xxGYcYeWkQAkBModrxHJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htEImw7b4PxunHN4bRq/RkCAdJthafpLydyUAqTx7kaegety9eHBj8V460G9aYRTMdKBOB72iqr4Bs8GGrl38KU9e/A6TANw6+jKmNuSi5yy0conyyRuIvGL8lAU73xs5aDEOfi/Iyf4UAqc8C4Oo5FzUTuc50TF9MGdxrnqAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhugC3Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83046C32781;
	Sat, 27 Jul 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722083264;
	bh=VZEg2zc8fwE6kWAYB6Y2R2xxGYcYeWkQAkBModrxHJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lhugC3Jps/xM7clYXG/7R+Cdbs8/wlAEdA0ftMcLVlKw1puJNUUTaZ2vLIM6284TW
	 hevPsQw1x0xrWHaLU4k08EFOQadGJhEAaI+UOqOyLghJsE6pX2IHBSLdhObjgUHCdq
	 hKzZltte33uCXL87On46+6vZ880bNFsU2ygqcYuukrhryrzoDJLo9TBbGAetx10+it
	 Uq0oXbixkRi5AwVpLPgFKroUdYhRk1Cn3Or+D+5H2wiWPXYRSQHvDc+T5f+g0bFHS7
	 c5AePof+o67jNAU+3STDxE2O26WZB70fuG5vq8k5pgQtNe0vgmxpRDKpC3hJH2XCBe
	 Z0zmeQ/PjTV2A==
Date: Sat, 27 Jul 2024 13:27:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: anshulusr@gmail.com, linux-iio@vger.kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add configurable gain, resolution
 and ALS reading
Message-ID: <20240727132735.052502ad@jic23-huawei>
In-Reply-To: <CAG=0RqL1GxCKdzDzUjqECEsfQmunCwnv+g_5cqM1fcfBsg+P0w@mail.gmail.com>
References: <20240718104947.7384-1-abhashkumarjha123@gmail.com>
	<20240720165554.5fd16ca0@jic23-huawei>
	<CAG=0RqL1GxCKdzDzUjqECEsfQmunCwnv+g_5cqM1fcfBsg+P0w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Please crop replies to only leave the section being discussed.
It saves time for everyone reading the thread.

> > > -static const struct iio_info ltr390_info = {
> > > -     .read_raw = ltr390_read_raw,
> > > +/* integration time in us */
> > > +static const int ltr390_int_time_map_us[] = {400000, 200000, 100000, 50000, 25000, 12500};
> > > +static const int ltr390_gain_map[] = {1, 3, 6, 9, 18};
> > > +
> > > +static IIO_CONST_ATTR_INT_TIME_AVAIL("400000 200000 100000 50000 25000 12500");  
> > Please use read_avail() callback and the appropriate mask to provide this.
> > That enables it to be used from in kernel consumers and enforces the
> > ABI without a reviewer having to check what you have aligns.
> >  
> > > +static IIO_CONST_ATTR(gain_available, "1 3 6 9 18");  
> > Given we don't have a 'gain' control, what is the available applying to?
> >  
> The gain gets controlled by writing to the iio_info_scale attribute,
> we write one of the above available values.
> So that we can scale the raw ALS and UVI values. I could use
> read_avail() for this too for the IIO_INFO_SCALE channel. Should I do
> that?

Yes, it would be appropriate to provide read_avail for IIO_INFO_SCALE
as that is standard ABI that userspace will have way to interpret.

> Can you elaborate more on your comment?

Basic rule of thumb is think very hard about whether there is an alternative
if you are providing attributes directly to an IIO driver.
There are a few corners where that is necessary for standard ABI
around FIFOs or certain event related attributes + a few special
corners for complex hardwware.

None of those apply here, so read_avail callback and choosing standard
ABI elements to match what you are trying to control / describe is the
way to go.  That's the stuff that userspace tooling knows how to use.

Jonathan

