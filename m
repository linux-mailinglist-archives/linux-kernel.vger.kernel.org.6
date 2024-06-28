Return-Path: <linux-kernel+bounces-233758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0F91BCAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16B81C22D71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118C154BEA;
	Fri, 28 Jun 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="abAHHkQW"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3986249F9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570707; cv=none; b=HodjUd/ogaCsvx5kbXvfzAVorYox3ghCcMACMqeolA6FyjBiMOohx4YVxF3p3AmLTvwjA6zxnSmFEDONaCcw15OoJmALexzhhSZ1Xo/zhEU0lYX02hZk3KddwiKIAba/DOzKlv58EwgYSe46duO4yK8y3D6rldoMRQwtctqCgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570707; c=relaxed/simple;
	bh=a10DvpjokSQmV/13YO4/Ifj2hINzXNJEhs00p0QdhRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRZhLbvVGUKEYlw8dikGDSxnmxjyxdi3ZPlD9uFtSIPXyikwzDfgLsr9bzMnDGtQYGXtwigEXzBbCSqYWpw38ngyKXVozZ2H5FHW53ZX/oD7KHN2LTtHOVh+800fsz+e22VsEDwMmnMv35y8BfBch3Pokb7iQT0ub/H8r1zzcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=abAHHkQW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4D191C000F;
	Fri, 28 Jun 2024 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719570703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4UhXaKGGiqWbE/y6PE/bVJrZS6D8ezkcI0nguMWpPo=;
	b=abAHHkQWCf3kaqf1WX05tIQ773iVUboRCxc9OugxgtCCF1ogI4wYrLO3SG3iC3C8tiS3NP
	4vLha43TsmdSL6b0zlan0elffXrzncmoXX3QBBf/fHEy5doIc8GE9RGN+KKWCTGNm9Khvz
	h1J2ypQWAooRnpigF+/+aY2uAzy4sUtQ7ah8S2CtbNohDG2mFqwCu3E99kw4SGad9kCTgQ
	HV4HEggYTeioJPsvD7X/fRHouGQsVEV1xcjYwvQVsTjPdjXwpGw0qmvslMFF3k1nC1a9H0
	G4WfXFy5oXFzvIDRrCWw0r1F0EtLF8wVE6eoCJrhGt/OSZ+X+Ge8SNSnCC4PjQ==
Date: Fri, 28 Jun 2024 12:31:40 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>
Subject: Re: [PATCH v2] drm/mipi-dsi: Add OF notifier handler
Message-ID: <20240628123140.5872fc6f@booty>
In-Reply-To: <20240627071904.4017160-1-wenst@chromium.org>
References: <20240627071904.4017160-1-wenst@chromium.org>
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

Hello Chen-Yu,

+Rob

On Thu, 27 Jun 2024 15:19:03 +0800
Chen-Yu Tsai <wenst@chromium.org> wrote:

> Add OF notifier handler needed for creating/destroying MIPI DSI devices
> according to dynamic runtime changes in the DT live tree. This code is
> enabled when CONFIG_OF_DYNAMIC is selected.
> 
> This is based on existing code for I2C and SPI subsystems.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for copying me on this patch. Could be useful for my
hotplug-bridge work, however I'm aiming at writing code that works also
for non-DSI so we'll see. The code looks pretty fine however.

My concern however is about the usage of an OF reconfig notifier. A few
days ago Rob Herring wrote:

> a notifier is never a great design so
> maybe we can come up with something better

(https://lore.kernel.org/all/CAL_Jsq+=mGEJXsjq1UZFMJtHko_z+doiFMXnx9K7exDuznymSA@mail.gmail.com)

So maybe this is something you can clarify with him.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

