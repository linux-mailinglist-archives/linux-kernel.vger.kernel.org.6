Return-Path: <linux-kernel+bounces-266467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2E940044
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5311C21585
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBB18D4A2;
	Mon, 29 Jul 2024 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="41cXb/uo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA11186E29;
	Mon, 29 Jul 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288080; cv=none; b=nWbjbnguoxfjX80TcCB8UKs3ZJIQmwCo33frMeiAQ9/1PqynpJBWBXFnLXM+Gz5jp6mUfZqqQBhTEqtAfVpqbf+APGZcZIDZtpnp55M3qe1Z7lrAtmnqy33GJDg5fWf5NlO3q7dA+GBhDc0ARTnOvAU5+bQFt6MP2xOEcTUQTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288080; c=relaxed/simple;
	bh=ZWvFvenxvVLQhpwvLVDSVCXk8VFJNRKMxGTisH0CrkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1C70Etj48EuRcrQA3Evyrz/duauJ18eNgKq7InaiqjysqA8k2XgZqz5wYGC967ypd9xue79C4wpPDfrTrJSUO+6s6Osdz8Cgi5j75JRKTDnqUH+3kKAVVD0jzND324cCe8PZmujBV7vPJXqT0PJfQH5OWuD9dVsdRzhspoMw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=41cXb/uo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722288077;
	bh=ZWvFvenxvVLQhpwvLVDSVCXk8VFJNRKMxGTisH0CrkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=41cXb/uohPMjcTl6P/BJHrW9hnFbr6INy2bZK8V37eOGmsx6Q7FCL53sXkPA3uBBF
	 0mCMa305BaQG3ebcKGaV5a/XaZOPShcWuxgF+FMku7X/WJstBLQZ/Divh0rnEWgdo2
	 p6oI77hL4rtYWBf4qGmzGZrFIeEwjhjyWsE228M50ndYKOgwf2WvMAyIya9NNwcRlQ
	 dL9s3xjXBVRaFJZTxJusi0daKzz6to1CEMhF4jbT1rgKpCQhcGKV+O6qvpMsZybANi
	 TtqcIAezO0qTLYl8zWi6o5deNcg3cCHLJMGym68b3KL8i0WNBUydIPwjdOsAcJjZs1
	 9zVwXjNpgTjlg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D12F43780B50;
	Mon, 29 Jul 2024 21:21:14 +0000 (UTC)
Date: Mon, 29 Jul 2024 17:21:12 -0400
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
Message-ID: <31abcafc-67fc-4932-abf6-5ba64f09ba5d@notapiano>
References: <20240625-mt8195-driver-name-too-long-v1-1-8573b43a9868@collabora.com>
 <b838b9a9-0ce3-40a5-b7a5-d1c825a0fa20@collabora.com>
 <0b5f6fe0-fdb7-42d3-9c91-85a28b50526a@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b5f6fe0-fdb7-42d3-9c91-85a28b50526a@notapiano>

On Wed, Jun 26, 2024 at 08:44:14AM -0400, N�colas F. R. A. Prado wrote:
> On Wed, Jun 26, 2024 at 09:49:55AM +0200, AngeloGioacchino Del Regno wrote:
> > Il 25/06/24 22:23, N�colas F. R. A. Prado ha scritto:
> > > Commit c8d18e440225 ("ASoC: core: clarify the driver name
> > > initialization") introduced an error message when driver names are
> > > automatically generated and result in truncated names.
> > > 
> > > For example, this error message is printed on mt8195-cherry-tomato-rev2:
> > > 
> > >    mt8195_mt6359 mt8195-sound: ASoC: driver name too long 'sof-mt8195_r1019_5682' -> 'sof-mt8195_r101'
> > > 
> > > Since that truncated driver name is already used by userspace (eg UCM),
> > > it can't be unconditionally updated.
> > > 
> > > As suggested by Jaroslav, update the driver name but hide it behind a
> > > kernel config option, which Linux distributions can enable once the
> > > corresponding support in userspace audio configuration software lands.
> > > This ensures that audio doesn't regress, while still allowing the error
> > > to be fixed.
> > 
> > I can propose the following plan of action for such a rename:
> >  1. Temporarily have both UCMs
> >  2. Wait until distros update their packages
> 
> It's not possible to monitor the package version for every single distro, so I
> guess you mean tracking only the big distros and hoping that no small distro
> still uses the old version.
> 
> Also, is UCM the only userspace tool that might use this name? There might be
> others too that we would need to care about.
> 
> >  3. Change the name in kernel without extra config options
> >  4. Remove the now deprecated UCMs
> > 
> > ...that's requiring a bit of time, yes, but I think this is the best way to
> > ensure that no breakage happens in the meantime for any users.
> 
> My worry is that we don't know how long it would take, if a small distro decides
> to keep using the old version. But even in the best case it might take years for
> the old version to be phased out, I'm not sure I'll be around for that, so maybe
> we'll just keep using the old name forever.
> 
> The nice thing about the config is that distros and users can opt-in immediately
> to get rid of the error. For example KernelCI, which is monitoring such errors,
> can enable this config to fix this error right now.

Anyone has any thoughts on this?

Thanks,
N�colas

