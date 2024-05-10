Return-Path: <linux-kernel+bounces-176027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E78C28E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07121F272CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A817548;
	Fri, 10 May 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwHTst/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920910957;
	Fri, 10 May 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359492; cv=none; b=Zebg1p5gJrCIaD5cR79TPCnaJu23GqujLzhvBXiKE9zUaF5BXqQ2s7OYo/SM71wSRVhGKd3oJedIS61s3T/fKkN5lum3h1LrzPl9ZlW8h4iMWJLDLNPOeT6DoyoeompYkwAMz4k43uCzBlFUJ4pSpbjxUktwLktU9VFt+BHtrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359492; c=relaxed/simple;
	bh=AKsuHfdNxYnH+Bp33dxu23hQYlBdH9/kq/GhGgLGp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMFJmVW+xA9EUphCK9kAuSVArvBzYTq6atOBg5o00tII99OVhbc896rcTq7xd0L/h4/tGckfOm01x+sbR0nTwoVqa8YAdDi/aex1OiwkG1XgaQJyDCpJnsIU4FCJporAzb6/Zm2MPoE6UIlzH9lHIL+mXKQ23mQ/TAgU1ODWWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwHTst/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3646C113CC;
	Fri, 10 May 2024 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715359492;
	bh=AKsuHfdNxYnH+Bp33dxu23hQYlBdH9/kq/GhGgLGp4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwHTst/PUBaIDeL/0I7NTk6xdKrE2X80x2nY/g63GwvfMQVE1XEAa5PIKamvPjV1w
	 VzjanQL9YWSBgknLqj26H5/YGRB9ZpqfJFHSGV6wD1ewNvxq6GJ+toQkC+TfU14C/L
	 IsbH/tSPax7zc+RF5X48zbJ8c96raFp0f0qYon0mY2yQ9YxBHOpwQL+lTZH+/sR3kK
	 v5BjCblwT1wySlwrB7BwFo+/EPQGeFMEZJRvFZpTWUD0ocC1SuCfaq5v+YNRzz8efF
	 DELIcPiCsxkxSHeQUEugE64fp389T9nMEWUCoHKmaM2zRP2Nz0r659xkK2aQC8w7b9
	 aD+YspMtBolAw==
Date: Fri, 10 May 2024 11:44:49 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 0/5] Add support for GE SUNH hot-pluggable connector
 (was: "drm: add support for hot-pluggable bridges")
Message-ID: <20240510164449.GB336987-robh@kernel.org>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>

On Fri, May 10, 2024 at 09:10:36AM +0200, Luca Ceresoli wrote:
> Hello,
> 
> this series aims at supporting a Linux device with a connector to
> physically add and remove an add-on to/from the main device to augment its
> features at runtime, using device tree overlays.
> 
> This is the v2 of "drm: add support for hot-pluggable bridges" [0] which
> was however more limited in scope, covering only the DRM aspects. This new
> series also takes a different approach to the DRM bridge instantiation.
> 
> [0] https://lore.kernel.org/all/20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com/
> 
> Use case
> ========
> 
> This series targets a professional product (GE SUNH) that is composed of a
> "main" part running on battery, with the main SoC and able to work
> autonomously with limited features, and an optional "add-on" that enables
> more features by adding more hardware peripherals, some of which are on
> non-discoverable busses such as I2C and MIPI DSI.
> 
> The add-on can be connected and disconnected at runtime at any moment by
> the end user, and add-on features need to be enabled and disabled
> automatically at runtime.
> 
> The add-on has status pins that are connected to GPIOs on the main board,
> allowing the CPU to detect add-on insertion and removal. It also has a
> reset GPIO allowign to reset all peripherals on the add-on at once.
> 
> The features provided by the add-on include a display and a battery charger
> to recharge the battery of the main part. The display on the add-on has an
> LVDS input but the connector between the base and the add-on has a MIPI DSI
> bus, so a DSI-to-LVDS bridge is present on the add-on.
> 
> Different add-on models can be connected to the main part, and for this a
> model ID is stored in the add-on itself so the software running on the CPU
> on the main part knows which non-discoverable hardware to probe.
> 
> Overall approach
> ================
> 
> Device tree overlays appear as the most natural solution to support the
> addition and removal of devices from a running system.
> 
> Several features are missing from the mainline Linux kernel in order to
> support this use case:
> 
>  1. runtime (un)loading of device tree overlays is not supported

Not true. Device specific applying of overlays has been supported 
since we merged DT overlay support. What's not supported is a general 
purpose interface to userspace to change any part of the DT at any point 
in time.

>  2. if enabled, overlay (un)loading exposes several bugs

Hence why there is no general purpose interface.

>  3. the DRM subsystem assumes video bridges are non-removable

Rob

