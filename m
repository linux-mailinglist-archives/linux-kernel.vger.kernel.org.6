Return-Path: <linux-kernel+bounces-175617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9358C22AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9846B2286E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8616D4C6;
	Fri, 10 May 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NPVTcQZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5416ABC3;
	Fri, 10 May 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339040; cv=none; b=Irn3S6uXqIpPvLi3iN6AGos6lLSda4+o1s8WrQ8A5xr9VoxUqy6zIgur6bIcggLO9Rr2dFtiefKgK1/DTmgZBsNqzyJfBFs2kFhyiXZppzXKLyH9fEmn8t+SiTVaqTofKWyUUcgxnKxc4ZrVGz2W/uTv05ACr1weWKALBvld3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339040; c=relaxed/simple;
	bh=h/y/M0WVBu20pfhZoBP9hM8Pp5zsvEnQwe4lkBmsmzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adtx4tuEsuAwlFHQnaO1RVgPmZ2YfuDzWXHyGrGrEq6O63rCXjMm5XjrJAo10uUGIhF5RxSd+1fJgWvMnxctkGJnZu/KsZrNQFHmrW6kQTPNXGQCoFgbCRYMTUrFcC7UD1rSXB/13GHNI8L6PMJfrYrFTxTV8fwcQ7SaId4Ox/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NPVTcQZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55F9C2BD11;
	Fri, 10 May 2024 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715339040;
	bh=h/y/M0WVBu20pfhZoBP9hM8Pp5zsvEnQwe4lkBmsmzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPVTcQZlQch0YbyPlfN4o1ztVi6Gd8zgxljoG8d74kRXBMgAVIINhuas5DUHLZPr1
	 Du0yrJRfY581ViE5ABjXktGPOcf+otCU5gaLHU2C8FAj88kqzM1xdKNnK/8MvvE+Lb
	 pmNKG3TdTIG3LMN9eD/AH6oZu1ixXuChO8wYTsKw=
Date: Fri, 10 May 2024 12:03:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 5/5] misc: add ge-addon-connector driver
Message-ID: <2024051010-scribble-barbell-d57e@gregkh>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
 <20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>
 <2024051039-decree-shrimp-45c6@gregkh>
 <20240510125417.1dddfd5c@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510125417.1dddfd5c@booty>

On Fri, May 10, 2024 at 12:54:17PM +0200, Luca Ceresoli wrote:
> > > +static int sunh_conn_handle_event(struct sunh_conn *conn, bool plugged)
> > > +{
> > > +	int err;
> > > +
> > > +	if (plugged == conn->plugged)
> > > +		return 0;
> > > +
> > > +	dev_info(conn->dev, "%s\n", plugged ? "connected" : "disconnected");  
> > 
> > Please remove debugging code from stuff you want to see merged.
> > 
> > Same for all dev_info() calls here, when drivers work properly, they are
> > quiet.
> 
> While agree for other dev_info() calls, this one seems quite similar in
> principle to the link up/down messages that get logged by the MII code
> at [0]:
> 
>   [347229.872315] asix 1-1.3.2:1.0 enx000cf616fecb: link up, 100Mbps,
>   full-duplex, lpa 0xC5E1 [347229.920449] asix 1-1.3.2:1.0 enx000cf616fecb: link down
> 
> In my case it is logging that a removable part of the hardware has been
> added or removed, which appears useful. Do you think it make sense in
> this scenario?

Nope, sorry, again, when drivers are working properly, they should be
quiet otherwise they just fill up the log with unneeded messages.

thanks,

greg k-h

