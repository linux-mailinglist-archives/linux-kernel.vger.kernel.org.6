Return-Path: <linux-kernel+bounces-337693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B9984DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71F6B22BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059C149E1A;
	Tue, 24 Sep 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW+5rx58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1B13C9D9;
	Tue, 24 Sep 2024 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216787; cv=none; b=XxJSY9KHRri/4+JrTVjnXYEKEG+vsPYWHwBaIueiVSOcjlA0DXYe9nl7uCKqmhRWHZEjm+RA4X+PTyT+Cu1Nt6bQg1sXl3qn9PLPzRf7aa09VFUAPgM19dVbWOKpiWmei8+UesGHfPRgYe/F5GiX1VLNsrE1Q3P5pf2v46JtsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216787; c=relaxed/simple;
	bh=YmYTBESt0EqQFqhnzMaFyGYpmk/68DRvs5SHo7cxNSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px3S9n/yI3eC1KqJ4jtL3McggnUsQ5Fn3XHYK/fqQ6khp/SxTMk6swLXW/x6WP861aKIBqwRlExRIIEIcBV9vkiaIpbIlHYdH2eFmSDttmTKO3bdAKQM2UACeJ2uDHD+ycF8MEoY9XJ3xHneaukkmztHOxBICpO8VlBy0zg/BP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW+5rx58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF21C4CEC4;
	Tue, 24 Sep 2024 22:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727216786;
	bh=YmYTBESt0EqQFqhnzMaFyGYpmk/68DRvs5SHo7cxNSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KW+5rx58Am0dAtvner/unXsVDmx0QycmxdReU8qVh9hd8J2qXt/8xXa+AE2mT669A
	 nM449DLPXw8eQONRvfIrSVc6HOzA2z+5vj9PwU1qWRvY7780Pmixy56hQte1iFE99J
	 gqq5yqYsatOS+m9/7mdkTsn2R6+SKq950WwRTgZqTNxZFOyZ3GICGBtC4GXvOW+ac6
	 3wc/vy2ttKQs2glG0L1bG6zj/XjLvBPebBlFVlPexRp6ne922um0WB2Wf2NK5HaiFN
	 6ANRkMEOdZPrq50mxAiQS1Pg10OAD0VyioSQa6fnsrRT/GmWTXErnlK/IEKZ3lzpkZ
	 wIwvBuegE0xow==
Date: Tue, 24 Sep 2024 17:26:25 -0500
From: Rob Herring <robh@kernel.org>
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Cc: Conor Dooley <conor@kernel.org>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Noah Wang <noahwang.wang@outlook.com>, Marek Vasut <marex@denx.de>,
	Fabio Estevam <festevam@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: add onnn,adt7462
Message-ID: <20240924222625.GA403554-robh@kernel.org>
References: <20240923093800.892949-1-chanh@os.amperecomputing.com>
 <20240923-private-grower-af6a7c1fca09@spud>
 <c536f43a-56f8-4cbf-99a0-fe3b54a42886@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c536f43a-56f8-4cbf-99a0-fe3b54a42886@amperemail.onmicrosoft.com>

On Tue, Sep 24, 2024 at 11:17:53AM +0700, Chanh Nguyen wrote:
> On 24/09/2024 04:23, Conor Dooley wrote:
> > On Mon, Sep 23, 2024 at 09:38:00AM +0000, Chanh Nguyen wrote:
> > > The adt7462 supports monitoring and controlling up to
> > > four PWM Fan drive outputs and eight TACH inputs measures.
> > > The adt7462 supports reading a single on chip temperature
> > > sensor and three remote temperature sensors. There are up
> > > to 13 voltage monitoring inputs.
> > > 
> > > Add device tree bindings for the adt7462 device.
> > > 
> > > Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> > > ---
> > > Change in v2:
> > >     - Add onnn,adt7462 to the list of trivial devices       [Guenter]
> > 
> > Is this really a trivial device? If it monitors and controls fans, how
> > come those do not need to be represented in the devicetree? How is it
> > possible to tell the difference between monitoring 1 and 4 fans without
> > the extra detail?
> > 
> 
> Hi Conor, Thank you for your comments!
> 
> The chip is old. The driver was added back in 2008.
> 
> Really, this is such an old chip that it would make more sense to just leave
> its driver alone unless there is a problem with it; this is viewpoint from
> Guenter.
> 
> I'm using the driver and the device tree with only the "compatible" and
> "reg" properties; now it's being good for me without any extra detail.
> 
> Guenter, Rob, Krzysztof, and I discussed making the decision to add this
> device to the list of trivial devices. You can get more information at
> thread
> https://lore.kernel.org/lkml/20240918220553.GA2216504-robh@kernel.org/T/
> (Because the commit title changed between v1 and v2, it's so hard for
> everyone to find it. Sorry! I missed mentioning the link to pacth v1).

It's fine. I'll apply this after the merge window.

Rob

