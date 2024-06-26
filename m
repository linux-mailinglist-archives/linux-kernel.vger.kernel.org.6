Return-Path: <linux-kernel+bounces-230741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34009918143
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40C428D1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA411822F8;
	Wed, 26 Jun 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zi5g1+kz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01C17D889;
	Wed, 26 Jun 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405857; cv=none; b=JB0TQha/PaWW7gEFwS53t3kJsA0gRokk+29PNWAZtw0+OxkyaS2OuCHPNa9KjhZ9YcCvffkFBDmK+IUS5cmwP3T51E7DsKe8RCS6yvjCz1Jgv9p2FfRaL/ARNhhTsbF/Uq2V/qTNyVo7GbyG+uRUQB0GtvmSxzoZ5PJRuUBYN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405857; c=relaxed/simple;
	bh=eo2f+raRsg9XoFkHoh06Dm4qF3Kjcfs2lWyUX0Svobs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFZVAjgRaUhv6/z/8lmNejfHz6G/KmfCfUscJF49D2tbUpiSm7YqMQxPbs2muZjTS6UyVWRif6Fd5aI+npCejkC5aWdj3H26d2WiAUi2YJNsj//fDPuP8lpFOOJ3yxGdYPYWUsDOLNds63u2oF92ZLN4QIicuwAfk1i4dr3tpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zi5g1+kz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719405854;
	bh=eo2f+raRsg9XoFkHoh06Dm4qF3Kjcfs2lWyUX0Svobs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zi5g1+kzo4gjYePu6oPdwtEfBCIvcnJFIYt5wtDXiSRnHjic1HMkNZ2lX05rt4QVf
	 M7bDkFKP5bU3/74lPSm99peB+8uqeUa2tFedIGX0fqHdNmqahGXaSu/cYptjelwl9t
	 9oLf3w+YrpWMokFU6y1QA6Q8PQ0CWRZhKxnLuK3NJjW+6iF9tnilin/60m1mXw5UYj
	 p8wm+0Q+rFOPmbBSuJI2gak7IGmtpoXy9HG2+1NWv//SzAsBOZ3kTiQU+kBceHfszU
	 xFw0WVDN4sYmH+spOBJ2JADm2QzIk9HNiT/rB09JLXEheBDz8kO2rEKlZUUOp5cINe
	 WgB7sPmm78k3A==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DEA8F37808FA;
	Wed, 26 Jun 2024 12:44:11 +0000 (UTC)
Date: Wed, 26 Jun 2024 08:44:01 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: Allow setting readable driver names
 through kconfig
Message-ID: <0b5f6fe0-fdb7-42d3-9c91-85a28b50526a@notapiano>
References: <20240625-mt8195-driver-name-too-long-v1-1-8573b43a9868@collabora.com>
 <b838b9a9-0ce3-40a5-b7a5-d1c825a0fa20@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b838b9a9-0ce3-40a5-b7a5-d1c825a0fa20@collabora.com>

On Wed, Jun 26, 2024 at 09:49:55AM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/06/24 22:23, Nícolas F. R. A. Prado ha scritto:
> > Commit c8d18e440225 ("ASoC: core: clarify the driver name
> > initialization") introduced an error message when driver names are
> > automatically generated and result in truncated names.
> > 
> > For example, this error message is printed on mt8195-cherry-tomato-rev2:
> > 
> >    mt8195_mt6359 mt8195-sound: ASoC: driver name too long 'sof-mt8195_r1019_5682' -> 'sof-mt8195_r101'
> > 
> > Since that truncated driver name is already used by userspace (eg UCM),
> > it can't be unconditionally updated.
> > 
> > As suggested by Jaroslav, update the driver name but hide it behind a
> > kernel config option, which Linux distributions can enable once the
> > corresponding support in userspace audio configuration software lands.
> > This ensures that audio doesn't regress, while still allowing the error
> > to be fixed.
> 
> I can propose the following plan of action for such a rename:
>  1. Temporarily have both UCMs
>  2. Wait until distros update their packages

It's not possible to monitor the package version for every single distro, so I
guess you mean tracking only the big distros and hoping that no small distro
still uses the old version.

Also, is UCM the only userspace tool that might use this name? There might be
others too that we would need to care about.

>  3. Change the name in kernel without extra config options
>  4. Remove the now deprecated UCMs
> 
> ...that's requiring a bit of time, yes, but I think this is the best way to
> ensure that no breakage happens in the meantime for any users.

My worry is that we don't know how long it would take, if a small distro decides
to keep using the old version. But even in the best case it might take years for
the old version to be phased out, I'm not sure I'll be around for that, so maybe
we'll just keep using the old name forever.

The nice thing about the config is that distros and users can opt-in immediately
to get rid of the error. For example KernelCI, which is monitoring such errors,
can enable this config to fix this error right now.

Thanks,
Nícolas

