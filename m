Return-Path: <linux-kernel+bounces-343659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C5989DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B8D28637B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484E318B465;
	Mon, 30 Sep 2024 09:16:07 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE218801E;
	Mon, 30 Sep 2024 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687766; cv=none; b=Zez1KnGEc1VkLZw77raM6fZk4hAMGdwXCS6+qNRAz2acXoO1D9lVrlYs5Wu6mkEpmtHhoBNtwKOipRpbtDrYegsjzVCgANsJFGZ8fcn4cosKNFGDPSN51EwfsFmAkegSfPuV+pFuO57t5ziPUR8iRfM9t2iP7Otu5D9POqYEfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687766; c=relaxed/simple;
	bh=HPoR5OGNEXDZs6E/hPEzNFBIUqBuZrFxaX8QUHpMnEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq+gmKjEXn9vq1jS6c3v3NEdLd8HBdkg1tFKtvgXD9PT8GUBQQ1EUjRXLFAbW9CRsOy/HjdO4OGv6XO4PMLfuEQQTkXFprotjtP/sy9IcCc8rF7Cbtw0kbQ3Iasw4Y6ebBQa/bLTVmsmM5bXq+pc7/PGZdyA3u8hYrKDSKs8If4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C5D132800BB5C;
	Mon, 30 Sep 2024 11:15:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AECA23D75F9; Mon, 30 Sep 2024 11:15:54 +0200 (CEST)
Date: Mon, 30 Sep 2024 11:15:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>, Peter Wu <peter@lekensteyn.nl>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel: Fix Optimus when GPU has no sound
Message-ID: <ZvpsSjgDFd-pbzFW@wunner.de>
References: <871q1ygov9.wl-tiwai@suse.de>
 <ZttEUjeYFzdznYKM@mail.gmail.com>
 <87wmjndbha.wl-tiwai@suse.de>
 <ZtxZBUjlF8TeIUKC@mail.gmail.com>
 <87jzfncvm0.wl-tiwai@suse.de>
 <ZtyMWSA0bg1SjFSU@mail.gmail.com>
 <87ed5vcp23.wl-tiwai@suse.de>
 <Zu5_faxUwoIl09fW@mail.gmail.com>
 <87msjpk5el.wl-tiwai@suse.de>
 <ZvpTRLxSkcqn03Fk@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvpTRLxSkcqn03Fk@mail.gmail.com>

On Mon, Sep 30, 2024 at 10:29:08AM +0300, Maxim Mikityanskiy wrote:
> Anyways, adding a DMI check to hda_intel or quirk_nvidia_hda seems the
> same level of efforts, so I can proceed with the former. It's the same
> power consumption either way, right?
> 
> I'm also thinking of adding a module parameter to block probing of the
> DGPU audio. Back in the days, there were plenty of similar Lenovo
> laptops, which might also suffer from the same issue.

Adding new command line parameters for hardware quirks is generally
frowned upon these days and is usually greeted by Greg KH's trademark
"this isn't the 1990s anymore" comment.

Drivers are supposed to auto-detect hardware with quirks and handle
them correctly without the user having to add a command line option.

Users should not get accustomed to fiddling with the command line.
They won't have the need to report broken hardware and the driver
may never be amended to deal with affected models automatically.

Thanks,

Lukas

