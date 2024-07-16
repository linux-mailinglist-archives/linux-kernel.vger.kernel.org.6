Return-Path: <linux-kernel+bounces-253753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F04932660
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED731F21C51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143A1991B0;
	Tue, 16 Jul 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w7m0k+SO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993C41A87;
	Tue, 16 Jul 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132208; cv=none; b=KwULYiXYAps46ssLTvS5Lcf86jyPAuyCfsqSiME34sGWTveI4osxcdLCXcEF/C2lZywWf2SBE8NuKaADQbM75RT9ocd1Yd5ot8T1oOO8y9nHZUOFXTj7CP4J5ojr5SVctpI4AkbuqAeE+c/opHAN6crDk92j77G6uvsLamQqg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132208; c=relaxed/simple;
	bh=rJCw4t9lWh++5hHyvwrQaAK5GI2g8BPbimI06KKCYCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO5aK7NDyTiQEvm3v+4yF7NhVGclMQ0F+wgGhtGbM35t5hFaYK7qIbKMcpJCnkF7J76N7iaHWEeTnz7hCwaKWSErEAq797XasppaJhtxJgWc56nsnX0gAUg7DUvIj35yyll2LsPtRNCbGyh06uoBfeUe+sKpb+sOWs+RWV+cdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w7m0k+SO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721132204;
	bh=rJCw4t9lWh++5hHyvwrQaAK5GI2g8BPbimI06KKCYCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w7m0k+SOd8zofuFtNtIc8DFMSoyULF4p95gUiJGeTIL5tw51TDAON077i/HMOsTU6
	 zOdXEdeteWHcA02RTUO8Zp3feDbTDVuQjgBBHjO9TPxg+talhgoGiJmW9yMcrsd9HH
	 gIP1Vm7UCtLOesfztNh+bgCCpMOrJ5HVxLnXtp5CNX3bRbHNzJXChaDnXcuhh3ntpl
	 keGyoVsovW4QI+KO2k1cythhTcNMWGZ3bjcRDns/A6UzuhORe5q3Y8vFH2KEp296sR
	 xQP8G3DP5PT2F904rJq9QPmA+mRSXWGMjUkG1VCi3UEY80gYUw6x9RwQ5gbbTxZ1Hl
	 zHdqP2zFpdZTQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CDD2A3781185;
	Tue, 16 Jul 2024 12:16:41 +0000 (UTC)
Date: Tue, 16 Jul 2024 08:16:39 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
Message-ID: <96f91c0a-e693-45db-a664-1c396b14999e@notapiano>
References: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
 <3dd2dcc9-5fbb-4384-985f-a61e26cc8a5f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd2dcc9-5fbb-4384-985f-a61e26cc8a5f@collabora.com>

On Tue, Jul 16, 2024 at 11:24:44AM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/07/24 18:09, Nícolas F. R. A. Prado ha scritto:
> > Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
> > subdevice") introduced support for detecting keyboard backlight
> > fuctionality through communication with the ChromeOS EC. This means that
> > the DT node is no longer used. Remove the unneeded node.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > Different CrosEC FW versions could potentially not support discovering
> > the keyboard backlight functionality, but I've tested both a recent
> > 
> >    tomato_v2.0.23149-099cd3e539 tomato_15699.72.0 2024-01-03
> > 
> > and an old
> > 
> >    tomato_v2.0.10686-234e646fd8 tomato_14268.0.0 2021-10-07
> > 
> > version on mt8195-cherry-tomato and on both relying only on the
> > discoverability works. I've tested on both tomato-r2 and tomato-r3. I
> > have not tested on dojo, however, as I don't have access to it.
> > 
> 
> Dojo will work anyway because those machines do share the same base FW... but
> anyway, I'm not sure that this is the right thing to do.
> 
> The commit that you mentioned says that it is meant to make that "work on machines
> without specific ACPI or OF support for the keyboard backlight", but not that the
> intention is to stop using either ACPI nor DT nodes for that.

Yes, because as I understand it not every EC might support this protocol. So
that commit just added an additional way to probe the keyboard backlight.

So we don't need to stop using the DT to probe it. But in practice we have
already stopped, as long as the EC supports the protocol (which from my testing
is always for these platforms), since that is tried first. Meaning the DT node
is now useless.

The only point in keeping the DT node would be to use it as a fallback in case
the discovery with the EC fails or breaks. But I have never seen a DT node be
there just as fallback, so it doesn't feel right to me either.

> 
> The DT kselftest is relatively young, and I suspect that anyway this is not the
> only affected device, so the justification is only barely valid.

I didn't include the failing test as part of the commit message proper as I
don't think it should justify this change. I added it just to clarify my
motivation. The test showed me that something unexpected was happening. After
looking into it I thought that a DT node that is no longer used to probe has no
point in staying around, so that's the justification that I added to the commit
message.

> 
> Don't misunderstand me, I'm not saying that I'm not okay with this, but I'd like to
> have more opinions about this.
> 
> If we choose to go this way, ideally we should remove this from all of the upstream
> Chromebook devicetrees (not only MediaTek, clearly!) so that would require a bit
> more effort to test here and there.

Note that the cherry DT is the only DT upstream with the
google,cros-kbd-led-backlight compatible. So it's really only tomato and dojo
that need to be tested.

Thanks,
Nícolas

