Return-Path: <linux-kernel+bounces-178989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0E8C5A18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2430C1F220A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7C17F39D;
	Tue, 14 May 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h9DaJlGC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A76FC5;
	Tue, 14 May 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706686; cv=none; b=Imt3va4qW1G/mtHfuMJGqlYJHXVv4xDOMaVuY+uEssa0ETwa5yeTBlDFxQAkmYTF6oSADuP0yX5byZbYZpwuDXWG2LdvOjh6ApSnE/Iiyf8RnCPGp0O3lD2qwuD8oZx3Pk4kl8l2EjCft3uGiT1qZlFgMES1GgbF3T28LTDTCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706686; c=relaxed/simple;
	bh=JOFWO9OkUaqiqQCHDYJAVIjKoCtVTHFpaPviaW6ZoVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDvqTO6cTARFDjZYs+fbF81VoREKXzv7eh2eeDLbMbbYdpFJp6ybnHyuDatMPkBPvG1y4Bls5h/JZVhuRMEMHNZEJ4TKTszkuhkrX+DaD0dohwSK492AmO9dq6UjV32wDvRuuiy1gkIfyQHaH3XFiKW45beQX6sUopwr1AJpqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h9DaJlGC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2226C000A;
	Tue, 14 May 2024 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715706681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8Cv6K+hNAOMTSxkND2VnO0L0L1inZAjtqwoyrqFY7A=;
	b=h9DaJlGC+6C/mDVfK/AsaTg4yxGmOU9QB/6NcMOZzP5nn7EA0QcvVPRb2l73nChCwUWulE
	2Q0E3g4kgu71qAAISfkFW983lJZA+9EQmY20pATxXQORSqPihC4fr01C1TyG4zADlhDKUB
	iekUFtnGyMmRXb5W+MkapjZ4jfmTeO6tST2vwHIm3sVSpUsCzg8CEIp+v/td8+PuDKf4J7
	OTie7bIPOgYzbgcEbq2NTUMmaUTI7TQ5ca2byxWD+O5MUzgCO75moKdmluRb5zjLJvfqlc
	e6WxoGuE3WdXLAEp7KLwCWbDc2yP7A0KbRtjJNH6CdoxnGQgwrg1jZcCHv1USQ==
Date: Tue, 14 May 2024 19:11:17 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, Paul Kocialkowski
 <contact@paulk.fr>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Paul
 Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 0/5] Add support for GE SUNH hot-pluggable connector
 (was: "drm: add support for hot-pluggable bridges")
Message-ID: <20240514191117.519b274c@booty>
In-Reply-To: <20240510164449.GB336987-robh@kernel.org>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
	<20240510164449.GB336987-robh@kernel.org>
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

Hello Rob,

On Fri, 10 May 2024 11:44:49 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, May 10, 2024 at 09:10:36AM +0200, Luca Ceresoli wrote:

[...]

> > Overall approach
> > ================
> > 
> > Device tree overlays appear as the most natural solution to support the
> > addition and removal of devices from a running system.
> > 
> > Several features are missing from the mainline Linux kernel in order to
> > support this use case:
> > 
> >  1. runtime (un)loading of device tree overlays is not supported  
> 
> Not true. Device specific applying of overlays has been supported 
> since we merged DT overlay support. What's not supported is a general 
> purpose interface to userspace to change any part of the DT at any point 
> in time.

I think I should replace "supported" with "exposed [to user space]". In
other words, there is no user of of_overlay_fdt_apply() /
of_overlay_remove*() in mainline Linux, except in unittest. Would it be
a correct rewording?

> >  2. if enabled, overlay (un)loading exposes several bugs  
> 
> Hence why there is no general purpose interface.

Absolutely.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

