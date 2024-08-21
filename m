Return-Path: <linux-kernel+bounces-295101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C538E9596D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CBD28180C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB51BF808;
	Wed, 21 Aug 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VW3PCy/y"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6BE1BF7E5;
	Wed, 21 Aug 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228273; cv=none; b=WNiPgeGoX/Wr9vXH+hyfr4SEGUvkTVHTtKZGwJM2i84gZc96K58HwOHgxVHVBe6jd1QySnseICvDavXHPYajYpHrPu+5yBf3CHpPTMHeuO9WdZs9P697lAMY5ztjUjH6LM+p2gM5F1XOWD8KTRl7nwpWacUhfMZy6N5oc08DFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228273; c=relaxed/simple;
	bh=SiXnudrqxGcGZ9uRY2HLczMD+fLZgK2Vw2xVjHIfqIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzHFZBTCGcLpOuv/lwkBat7knRj6fQTGehRdQdxtnY9DPMASGtya4owEfwWXUMs4Kz3jXJSPEUTWsX+v4I+dP2c2++A+dFTUMvnnUpDsFUN+tRPfKXoCyxaUyAVUSqQxavAqj4IEjWDmOZo06vn8lQRAyFKQh3Es2zA8wYWZlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VW3PCy/y; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76019240006;
	Wed, 21 Aug 2024 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724228269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqbiiqxlYs51ofSD3CmT+SDgh/1VJcOXrFW12DENkpg=;
	b=VW3PCy/yY3K393XGNPsYd4SK7pH4Qiz8kIx8+IEDY0n4XTEMgeug33RiUT4g+dabGKmrzz
	CxNfS3THeZUWs5k//A2N28S8ayumVgI8GHjJOuI2+/+9nyLuan31vlx0Fs19TBJgtOs+xk
	iTjIMeEOWQ/u+F68/Uq3i/B3qwoLgUOYqM9qK1mXKo7vRhVhWx15xsP5abAASxvHqKfywx
	vRRKNnEwAxjImw9Ckcn0agSTdWY0eVglOF90E5DcsxDxsn2OxjcddnlYyZvldO4/25OYxs
	ORB7Qme3FVgiIV0sdEuFaENnOFQHbcJYbYhp8RrQAeCHr3ix+J2d1+KZkm+rxQ==
Date: Wed, 21 Aug 2024 10:17:48 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: dapm-graph: add component on/off and route
 names to graph
Message-ID: <20240821101748.41799c5a@booty>
In-Reply-To: <c4e2580f-1675-48b0-b59f-a076eced7675@sirena.org.uk>
References: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
 <20240820184406.6ff2654e@booty>
 <c4e2580f-1675-48b0-b59f-a076eced7675@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Mark,

On Tue, 20 Aug 2024 18:04:17 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Aug 20, 2024 at 06:44:06PM +0200, Luca Ceresoli wrote:
> > On Fri, 07 Jun 2024 09:41:50 +0200
> > Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:  
> 
> > > This small series adds some improvements to dapm-graph in order to produce
> > > a more correct and informative graph.  
> 
> > Gentle ping about this series.  
> 
> > It applies and works fine on current master.  
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

I'm sorry about the noise. I thought it was worth in this case because:

 * this series has been sent 2.5 months ago
 * there was no reply at all
 * AFAIK and according to MAINTAINERS there is no patchwork catching
   tools/sound/

So it was looking much more like something gone into oblivion than
being on someone's TODO list.

> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

Apologies, my fault for not having checked the archives. Note taken.

After doing so now however, I must say that while counting the resends
is easy, counting the pings in a somewhat reliable way is very time
consuming. It would be nice to have this info in a more reachable way
(MAINTAINERS?).

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

