Return-Path: <linux-kernel+bounces-391422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C779B867E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB576283AED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC4B1CDA18;
	Thu, 31 Oct 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZCryHkdN"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5B1E2007
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415614; cv=none; b=t9OaGRX0jEfE20A2cKmal4w/ewZ3tL6Tt96eNjJ1p+gXH6WHgH6Gaf/ZCgI3t99xiCa9BaaLXcFPNUCbVsKmcxqzjZrl0qJRuS56q8uQh22wbJVU+UNjzndMd8vtDE8Ni9KtyAW5JPtouv3zc22T+KHtGrdpd8q7oYg5pZNqTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415614; c=relaxed/simple;
	bh=P4EJX0Z/epbUoYJTdtM8F446iQ2ZxQ93dZ3iPf9u+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oInCSxXMRq6SG9ndOt2NU6SUEVVPKNZGsAwfFdENC05wenKmeXTlBo+G1eAfiXMDuzpEUe5riEuv6YX98G/yvi9/elGSTTkrXS0R8FY9GoWS/haKcdX/ErsjiwUdBu4LtTIF+hHsw4y5ru7X5ojFCdJYdYxK9Xh04YyPe9AnxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZCryHkdN; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78ECB20002;
	Thu, 31 Oct 2024 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730415607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Amyk2g5wTtTmqNtcbU62wwA6H4Lq3sNSfG33ASGNRc=;
	b=ZCryHkdN8cb5hYGjvyKPClv38iqBmO1Y39BFZYjK4ehNab/NJx3NgVC0k68foFm/w2xvFJ
	1+l+VIxNdboIXyYGCE8cBlnIDo73Yz+e7STeT9Dew6pFOSnuFLOC0M9bxK47UwQxo7Eixz
	QQMvy58UzInYBoJe0mknWRfn/zOAfiMmGwCT4fzvM8pOVWfiHMX9D7GRE+Ucr6RmdbpqJU
	1vFI8IZSU6gGAFfsCZoDEy8wtnuvhopqLV+BaiAJw99bubZ1sN0oQxQMiaeWoBGJSi2iYB
	1BpNtbPQSHNOcM9NsQDzQJcv3C/RQYkfGpd09IKzcGiHcCIMU14EOdM8isydrA==
Date: Fri, 1 Nov 2024 00:00:05 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc: Frank.li@nxp.com, arnd@arndb.de, bbrezillon@kernel.org,
	boris.brezillon@collabora.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com,
	stable@kernel.org
Subject: Re: [PATCH v5 1/1] i3c: master: Remove
 i3c_dev_disable_ibi_locked(olddev) on device hotjoin
Message-ID: <173041558585.2392356.5423028675808780456.b4-ty@bootlin.com>
References: <20241001162232.223724-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001162232.223724-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 01 Oct 2024 12:22:32 -0400, Frank Li wrote:
> When a new device hotjoins, a new dynamic address is assigned.
> i3c_master_add_i3c_dev_locked() identifies that the device was previously
> attached to the bus and locates the olddev.
> 
> i3c_master_add_i3c_dev_locked()
> {
>     ...
>     olddev = i3c_master_search_i3c_dev_duplicate(newdev);
>     ...
>     if (olddev) {
>         ...
>         i3c_dev_disable_ibi_locked(olddev);
>         ^^^^^^
>         The olddev should not receive any commands on the i3c bus as it
>         does not exist and has been assigned a new address. This will
>         result in NACK or timeout. So remove it.
>     }
> 
> [...]

Applied, thanks!

[1/1] i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      https://git.kernel.org/abelloni/c/36faa04ce3d9

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

