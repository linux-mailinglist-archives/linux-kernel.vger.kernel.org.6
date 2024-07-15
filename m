Return-Path: <linux-kernel+bounces-253123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC0931CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B8283362
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F413C9CD;
	Mon, 15 Jul 2024 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QmhGa4UM"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189594C7C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080088; cv=none; b=owSk4ylrrF062hoWmUcmgypgFI8mRmtVmfc4mrwn30w2fFUREnZC7kXVFtb9XKbUJqeJ+esl03Uo5L+UpD0lk+Vuv2VwgpWPbn4fzYZy6wZUGZHOipZ6tRdVxSVNkhXfNOH2CCXO/9w6Poo8drk2XmrAfOWU/G/yNn6o5/zm6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080088; c=relaxed/simple;
	bh=jNq7pUFXDe9DWaohRapyWuo+TO4lToYVW/HQ5G8jbyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0+l9z8YUrhsW81xh5NfJMOnkq+OrA1SpXJ5iwXtGZP3VMmTJQ7OMuHa7e8L+RJK+RrQEEJIy9MSjCX7h+GkWEaf9ZNzRBtGib338j4g+7G/9RBPCxRo/klowGd2hKoebC8ZPWb9DiL/EB1sLc2T2NIWzVsbUbSpSDvlGcsXC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QmhGa4UM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D1CF1C0002;
	Mon, 15 Jul 2024 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721080082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3nywHBZCGdSjrJnNqCKE0IglxWuukGOH9wSy9XK314=;
	b=QmhGa4UMbIjsYIJn/olbO0hlT+o75kCjoS6WKzACA/NNZTUa8pfxYg/vAw3vgZVCGz2zQW
	jwWXvibXDT+7mFpIq6GXY/EHxkxyqzzIAmae7nTuUnIOYUkOEXJtTn4p2Z/NauWdaVuGZt
	wsKp2N2kRoPyvJgYjUwqLb3QWsjau4UpvJzHDbxUIF67pWoN+yPM4Q7lHidV6kBDqGsqTq
	g9gK1PSIzGPhPiMh8Ha5mckbdcpLQ4fOJPP1z0JGYLZ6yd4JwT9LfeIJvTX5I/TQ77y5ae
	rWuPVTqhi5WCIclqXh9KfgmBvlE1stLyzQdmcM3fF3ijpar2Fdus3gBNnAgv8w==
Date: Mon, 15 Jul 2024 23:48:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bhoomik Gupta <bhoomik.gupta@nxp.com>
Cc: Frank.Li@nxp.com
Subject: Re: [PATCH] i3c: master: Enhance i3c_bus_type visibility for device
 searching & event monitoring
Message-ID: <172108005329.1453338.17841860883456945648.b4-ty@bootlin.com>
References: <20240708053835.3003986-1-bhoomik.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708053835.3003986-1-bhoomik.gupta@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 08 Jul 2024 11:08:35 +0530, Bhoomik Gupta wrote:
> Improve the visibility of i3c_bus_type to facilitate searching for
> i3c devices attached to the i3c bus. Enable other drivers to use
> bus_register_notifier to monitor i3c bus device events.
> 
> 

Applied, thanks!

[1/1] i3c: master: Enhance i3c_bus_type visibility for device searching & event monitoring
      https://git.kernel.org/abelloni/c/e06704e3f513

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

