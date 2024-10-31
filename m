Return-Path: <linux-kernel+bounces-391421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229709B867D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E571C21733
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963921DBB36;
	Thu, 31 Oct 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lx6hmWty"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE61CF7B7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415607; cv=none; b=tvqDMOITdJQnvrNk+BVXTuZWHbz8SkVVTgcjSGezUbMUWBjNDMw4TSmOWCAPnG4xaIfMm63OgfjSPQdGJ/nwY1nnOch3vPKPBeEn3y1WhhooPnxuOHhczA++So9hcAgxbkcpN8JIWk7BmsFrAsZNNjNbKa20075PCaKQg50Xj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415607; c=relaxed/simple;
	bh=oi7Ma1dF/MnIfW9Dw8xbRObbje4RCIlr37vNH2EPmuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSN0DLisnq/tl5wH9ckINzX9riBSqtvdGmdlbZZ+LwQc7+RoOzEfB58+rOI1QHVA5KMyF/imhOiV89yUJm4S/4EzG2BMPjyGMVeKSjjRvwyUL1gkU0MCHg1+LeL50Yf8RJkSqiHi/RtDbR+rN/5ssOJLStS9wE/Ec8BfeNJ6yG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lx6hmWty; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59A0DC0002;
	Thu, 31 Oct 2024 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730415599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E5tPbinO6XAzKN7l+PGk9W3OOrQy0kg3Os2oKPhdF8g=;
	b=Lx6hmWtyfWTSIZzKtpAKMOsfhOEFr+1x2NESEaV5slbt/rBu75yoNlJauf1EpezmaYCB36
	u4iNXVf5h4mX//1g0h9qmuDBHH5rWQivX+6ZNHmQD6AewqhmqK84UqDxsf036XKfwJIFeF
	qZd5Lv2H3Z/b9sncUsM1N4pUqcQ1MDuyKQ3KdxGIvsBH0thNkFreoNC6d2NAVcQx4sWOXA
	VabS2GuEvmHAWWxs37RezuLy9BFXGwvWFH3Uo1gN+l6KUWbMOAOdiRFz3hyYP9W2DrIXbo
	HWqW+hs/EqYZ2rVuvAF+da+ANpMNW0/qwvkr07rkYSSFGInEFIkRKzQSAftD9w==
Date: Thu, 31 Oct 2024 23:59:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc: Frank.li@nxp.com, arnd@arndb.de, bbrezillon@kernel.org,
	boris.brezillon@collabora.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com,
	stable@kernel.org
Subject: Re: [PATCH v5 1/1] i3c: master: Fix miss free init_dyn_addr at
 i3c_master_put_i3c_addrs()
Message-ID: <173041558586.2392356.14874053827219870416.b4-ty@bootlin.com>
References: <20241001162608.224039-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001162608.224039-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 01 Oct 2024 12:26:08 -0400, Frank Li wrote:
> if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
>                                       ^^^ here check "init_dyn_addr"
> 	i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr, ...)
> 						             ^^^^
> 							free "dyn_addr"
> Fix copy/paste error "dyn_addr" by replacing it with "init_dyn_addr".
> 
> [...]

Applied, thanks!

[1/1] i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      https://git.kernel.org/abelloni/c/3082990592f7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

