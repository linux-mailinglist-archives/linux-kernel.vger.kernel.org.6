Return-Path: <linux-kernel+bounces-341462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49944988086
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA58B1F238B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47818A6B8;
	Fri, 27 Sep 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6bWUDXz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDD17A597;
	Fri, 27 Sep 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426360; cv=none; b=UX2xd/0YT8pZFdbH4/AVvnWgi1EUbm9/8EgDCrPPC3hctJ6AQ4ewxbdl4OsvnbDguzh8y2o/rVPNeHp8iuKbgV8BzoEAD7MfN5sY88wQVAmjssP2Zg/dPudqN/GIxzZpuw5AUfFluXUGSCS3xcF58AQNsNUXDdoOCYPd8Hj1pz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426360; c=relaxed/simple;
	bh=2CmxE4XpAXVWTY0TaLeb2HVuWbbBpaDz4vtNsP7PnyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGoEPzrApArREUaWFiUeSP0dq7wlW6p/b2DeVvTWCXRBhZis3l4bcgsJ3oDxQO6R4kwv/ZH0Y2lb+2GwcF6wIQSu8GQ4A6qS8cn+39d6Pglg7bFKtSiROz7tv4MDwrSAJr8LJlxtzZseb2zeeEl3nMJ+z7Y3r147sqNIrNxKDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6bWUDXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FFFC4CEC4;
	Fri, 27 Sep 2024 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727426360;
	bh=2CmxE4XpAXVWTY0TaLeb2HVuWbbBpaDz4vtNsP7PnyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6bWUDXzSPoJdMBfA5II7PxzVzThH5Ej/TqBSuu8nPt+ZGPyx6TyiU05Db4O2s/pQ
	 bTsS6jEmZr4lt+aFd9nGo4KTGJ5+wmGqcpIxkP9eP3fOz6fv5hblXW4wIKnBMEBoCO
	 Ip5kPeQzu1JBZ0vVp7hrzfOwU1BFIDxCGAjXL7QZk22j56OuN3W3naTzDaJhEiRGBm
	 fUejM5pxQIc9ddhbG7vg3UefiLHPYKkiF0GNJjgVvAm4NsMkWqmoJvCd1hOaNuBtpo
	 gwn979RqVgnpkiZO/UZ1Q99ToyKFauw+SQBZj7AMifJcZrCBypGn124WMnHNA+aV+Z
	 Ds9BhuQSRaJYQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1su6VQ-000000001Wg-1ix0;
	Fri, 27 Sep 2024 10:39:17 +0200
Date: Fri, 27 Sep 2024 10:39:16 +0200
From: Johan Hovold <johan@kernel.org>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Elder <elder@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lee Jones <lee@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>, Daniel Kaehn <kaehndan@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: serial-generic: explicitly disable flow control
Message-ID: <ZvZvNIOLX1UMJmC3@hovoldconsulting.com>
References: <20240926104404.3527124-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926104404.3527124-1-jkeeping@inmusicbrands.com>

On Thu, Sep 26, 2024 at 11:44:03AM +0100, John Keeping wrote:
> The serdev subsystem does not specify the default state of flow control
> when opening a device.

This bit isn't correct as serdev enables hardware flow control (CRTSCTS)
by default on open() (see ttyport_open()).

> Surveying other drivers using serdev shows the
> vast majority of these set flow control explicitly after opening the
> device.
> 
> MIDI does not use flow control, so ensure it is disabled.

Johan

