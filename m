Return-Path: <linux-kernel+bounces-385083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C9A9B322F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D982B21ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1A1DC18F;
	Mon, 28 Oct 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DoanW/Oh"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332D1D5CDB;
	Mon, 28 Oct 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123586; cv=none; b=hJ9r9RvG/lieA2mA/NmEwl3+iW554wUlS1xrHDw4vf6KDfKnVOE8XJyIKHj2qKxwVVgb55zoaRIGJhYhD0ITJk0DQjR7dyVvlga/4sNIBvvfAQyBjVIZZvJzLnF2hr8PgZwgSQ7iW7KOjYoGISJ+S1McSFYE2oSoY0lUq91fSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123586; c=relaxed/simple;
	bh=Q4ZEuFUaWvXAAYpBTEdcjQ26bkC4JIfZygHIVhyDrM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww2/CjS2wPdi5d5Hnd6XDCp9c+tyhTdA52BGKqR6KLi5hdtcxdGvSiplmm56xo2uw4ds/C6Gqu6fEBJISSyfJvLVQ/M7XSTCbtPCW4WLbe2PLBvp9WQ0EphyJZDlX9dI2KnUHP93X25/tjSkGIWiCkOwWYH/ojYKaLEZNAAIUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DoanW/Oh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C27B040011;
	Mon, 28 Oct 2024 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730123581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+7wd8PyxuRyimR48C6T/jCFU0JMTcGUNxE0eO9eGfY=;
	b=DoanW/Ohv7PqeJ7ygS/HRBxSlD0qWMEgXbZ8kWweXzvbOav/kBKE2WUBPXWCBrVpTjl9xy
	JrwlSvxreDvn7fIjQ71fT7oeKJ6r/zCLi2GTRVIzCT/H6BoF1qLgHNFdW173k88mzHGt1I
	GhQxEKuxPUFE7Zm3haN0HgatsgyuGtqdx7DKheh+0n/AuXuwIhx4FALGB9FfT75FTi3pxr
	1c7iuEcLXGiEQCNGCyQA5H57WaR/VrCG5fEK1nRpS5OLuMGKXQXjPOPq/v3HEr9JwsGcGV
	PgysevwjZY6xWC3gZ//NEWwPWcuDn0zo/n3tSnWiAN1lS1o/lGZuGjLFt7/LNg==
Date: Mon, 28 Oct 2024 14:52:59 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241028145259.5d520445@bootlin.com>
In-Reply-To: <16edb769-a608-4b6a-9391-a63a69df8c8d@denx.de>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
	<20241024095539.1637280-3-herve.codina@bootlin.com>
	<78a09625-6bad-4fda-8ee5-92b8dd0de381@denx.de>
	<20241028090220.1fd803ff@bootlin.com>
	<16edb769-a608-4b6a-9391-a63a69df8c8d@denx.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Marek,

On Mon, 28 Oct 2024 12:47:14 +0100
Marek Vasut <marex@denx.de> wrote:

> On 10/28/24 9:02 AM, Herve Codina wrote:
> > Hi Marek,  
> 
> Hi,
> 
> > On Sat, 26 Oct 2024 00:53:51 +0200
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> On 10/24/24 11:55 AM, Herve Codina wrote:  
> >>> In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
> >>> from errors by itself. A full restart of the bridge is needed in those
> >>> cases to have the bridge output LVDS signals again.  
> >>
> >> I have seen the bridge being flaky sometimes, do you have any more
> >> details of what is going on when this irrecoverable error occurs ?  
> > 
> > The panel attached to the bridge goes and stays black. That's the behavior.
> > A full reset brings the panel back displaying frames.  
> Is there some noticeable change in 0xe0/0xe1/0xe5 registers, esp. 0xe5, 
> do they indicate the error occurred somehow ?

0xe5 register can signal any DSI errors (depending on when the ESD affects
the DSI bus) even PLL unlock bit was observed set but we didn't see any
relationship between the bits set in 0xe5 register and the recoverable or
unrecoverable behavior.

Also, in some cases, reading the register was not even possible (i2c
transaction nacked).

Best regards,
Hervé

