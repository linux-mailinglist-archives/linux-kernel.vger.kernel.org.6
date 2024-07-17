Return-Path: <linux-kernel+bounces-255354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF69933F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDD41F24796
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CB181B9F;
	Wed, 17 Jul 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HTQ7Za33"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD04ED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230018; cv=none; b=Ckad4gOK0giRvz/gSEJ59KrrIgvomeXpjmYRq7T2euvXQWykTnZT9H2uZX2fxMSY3o+6wqmToG4ayoJHoBk1bAnezBfRrCGdyKOcsfjWWiQtjw7ElK+efnq/cf90H+VsuYkXxotRTc2xLPzRk5n+IRKEjDWS9tQsZKS3l9vKC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230018; c=relaxed/simple;
	bh=X4mXGG0Ukw5ol5x3EYC6ksmrHHZwXKI8jI/3u0LCUf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgFwkWzzu506a5KWxHoe4rxTZ6XieUyG7dxal7jIWs2hOUoysHN5iY1qBsuJkAmA7f434ddfC9hWDQVkNCMo3MKpBviRN8HUmDUSDaNg/51R5ntAye/sEXqkO6kGn67OW6NiFD9M2HtCADmftVv3Spl8+oaY/fiwI83gY3tnDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HTQ7Za33; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721230006;
	bh=X4mXGG0Ukw5ol5x3EYC6ksmrHHZwXKI8jI/3u0LCUf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTQ7Za333gNO3sUmMxtodtjmHKjB/sbtCo/WJlLTfSUKMMH1dchS5CGR8v3So8/1v
	 CkNra9rGjxhi+YdAi1PtoSJwst4J2TRPV9eQBbT7+SPkOuBP6tu0U4KH4fKLar+zgl
	 p9m1rkH6D4aSaNKFF5yaVdeT7OU1kB2jH03ASGXc=
Date: Wed, 17 Jul 2024 17:26:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
References: <CGME20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0@eucas1p2.samsung.com>
 <20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
 <20240715202319.mccb6jlsa6dkynap@joelS2.panther.com>
 <f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>
 <20240716152705.juet6srejwq5o6je@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716152705.juet6srejwq5o6je@joelS2.panther.com>

On 2024-07-16 17:27:05+0000, Joel Granados wrote:
> On Mon, Jul 15, 2024 at 10:58:10PM +0200, Thomas Weißschuh wrote:
> > On 2024-07-15 22:23:19+0000, Joel Granados wrote:
> ...
> > > The merge window is now open. I want to send this patch on the Wednesday
> > > of next week (jul 24).

<snip>

> > > 2. Does it still apply cleanly against the latest master branch?
> > 
> > Not against mainline master, but against next-20240715.
> > To apply cleanly (and compile) on mainline master it still requires the
> > net/ and sysctl trees to be merged.
> > Otherwise some modified functions are missing, leading to (trivial) merge
> > conflicts or the preparation commits are missing, leading to compilation
> > errors.
> 
> Understood. I have just sent Linus the changes for sysctl-next, so those
> should land in master soon (baring any issues with the pull request).
> 
> These [1] and [2] are the two series in net-dev that are the deps for
> the constification treewide patch. Once these two go into mainline, then
> we are good to go. Right?

Right, but...

It turns out the preparation patch for mm/hugetlb.c [0] is also still
missing. I missed it in all the errors triggered in net/.
But as far as I can see this patch will be part of Andrew's PR for mm.

Other than that it looks good.

<snip>

[0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net/

> [1] net: constify ctl_table arguments of utility functions
>     https://patchwork.kernel.org/project/netdevbpf/list/?series=856252&state=%2A&archive=both
> [2] bpf: constify member bpf_sysctl_kern::table
>     https://patchwork.kernel.org/project/netdevbpf/list/?series=854191&state=*

