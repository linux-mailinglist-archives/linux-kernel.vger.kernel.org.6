Return-Path: <linux-kernel+bounces-206297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B127900780
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2601F25151
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895419A2A8;
	Fri,  7 Jun 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s7wq/d6w"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D5199E9E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771340; cv=none; b=hLYztNVCZtn/fY9juu7Cgcq/+S3Ml7kJpeyPnKipf1ayCO1p8MEvVegsAk+1qWS1cqVLfk1YmDd8QAyxSDysclwurYWFX2b2bFNzoeXCWV/1ZFzDtNQDJHYzwXBjdsBOpVLcd/cQ+fWM1JA/432KgAmy0X+OfXyfj0y4O+DLSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771340; c=relaxed/simple;
	bh=UjTA2F7adwWAMjgQ+i5VZ5k/ef5LLUXB78PRbI7/CD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F29vIi8g6vfFVfxog+mQWiKy4hmICZ5qoi0vHVw+Pfq2/mm3vyHTHNB9HTyPggaA6ny220nZmyVdfy7thjKiF/FgMUHzvLoJJsQ7/y32xA8linxyGXS3KeeIdJYDwmfq9BMQE4vbsBogR4Epx1PnPuHybc3TneCYrtMF+/3QL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s7wq/d6w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717771336;
	bh=UjTA2F7adwWAMjgQ+i5VZ5k/ef5LLUXB78PRbI7/CD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7wq/d6wNnb+x+qHcVp8tNbNm24/0sz84WoS/0xX1MqlBsfzuwd8UAFCdLXEAnZGb
	 5xQbmjolOloH1lHIPPY3YafTDWDv8JN2Q97m54JTlZwGWryw/nqmCaTpekcr4bGfbJ
	 i9lKm/ek3015xRo30aHYUTXLvCrx8uyN+j4auldQXQV33xXfug66PPUrvm4rThz1Bl
	 Bji5BhnpO6G00+ITNzjZxQTwf4MH6gkpfSzyQkk8qdIpvHaizHnUR8aDhcaf+H1L9l
	 MqTF3xOzq4s4fGKbMEA2ap4c+OUXbiu+DLPx6PUOx7l6MZ5GWSK0CYNps1kCWoyVO1
	 O4HIL8SWS3QiQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 408523782191;
	Fri,  7 Jun 2024 14:42:15 +0000 (UTC)
Date: Fri, 7 Jun 2024 10:42:13 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: Probe failures on mt8183-kukui-jacuzzi-juniper-sku16
Message-ID: <bbdf568c-bfc4-403f-a62e-3f2e00ba814f@notapiano>
References: <e5912054-0fc9-47ff-8f38-9b9a3e9d2156@notapiano>
 <CAGXv+5HJKur9vWq4j_x7-fuL5H0SY_oQNYFWTxFCC1EBxF9yQw@mail.gmail.com>
 <2491f962-a8e1-44c4-8ff9-f8c3e58a2a39@notapiano>
 <CAGXv+5HjRmn5o6uogn89OMLONWWaxBA5MJNKCesYXoR7G_FOEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HjRmn5o6uogn89OMLONWWaxBA5MJNKCesYXoR7G_FOEA@mail.gmail.com>

On Thu, Jun 06, 2024 at 12:15:51PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jun 5, 2024 at 8:33 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Wed, Jun 05, 2024 at 04:01:06PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > >
> > > On Tue, Jun 4, 2024 at 11:52 PM Nícolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > We're monitoring the status of device probe on the
> > > > mt8183-kukui-jacuzzi-juniper-sku16 platform in KernelCI, and I thought it'd be
> > > > helpful to share the results.
> > > >
> > > > These are the current failures:
> > > >
> > > > * /soc/i2c@11009000/trackpad@15
> > > > * /soc/svs@1100bc00
> > > > * /thermal-sensor1
> > > > * /thermal-sensor2
> > > >
> > > > In more details:
> > > >
> > > > * /soc/i2c@11009000/trackpad@15: I believe this is a second source trackpad and
> > > >   is thus waiting for the "platform/chrome: Introduce DT hardware prober" series
> > > >   [1] to be merged before it can be handled. Although looks like there haven't
> > > >   been updates to the series in a while.
> > >
> > > I've been working on other stuff and haven't had time to respin this series.
> >
> > No worries, but it's good to know that that's the latest status and I didn't
> > miss something.
> >
> > >
> > > Just to confirm, is the failure due to pinctrl conflicts when the trackpad
> > > variants probe asynchronously?
> >
> > Yes:
> >
> > [    2.185408] input: hid-over-i2c 06CB:CDB5 Mouse as /devices/platform/soc/11009000.i2c/i2c-2/2-002c/0018:06CB:CDB5.0001/input/input2
> > [    2.845044] mt8183-pinctrl 10005000.pinctrl: pin GPIO7 already requested by 2-002c; cannot claim for 2-0015
> > [    2.854700] mt8183-pinctrl 10005000.pinctrl: error -EINVAL: pin-7 (2-0015)
> > [    2.869503] mt8183-pinctrl 10005000.pinctrl: error -EINVAL: could not request pin 7 (GPIO7) from group GPIO7  on device pinctrl_paris
> > [    2.894885] elan_i2c 2-0015: Error applying setting, reverse things back
> 
> Yup. That's the issue. We work around it either with staggered driver probe
> (built-in vs module) or move the pinctrl up to the i2c bus node.

I assume you're talking about the ChromeOS kernel?

In any case, if I got things right, once your series lands these workarounds
shouldn't be needed anymore, it will work as is. So I'd rather wait for that to
happen, as the current DT looks the most correct, and the config changes
couldn't be made to the upstream defconfig and seems fragile.

It's ok for the test to keep failing for now, it shows that there are things
that still need to be fixed, so it's serving its purpose :).

> 
> > >
> > [..]
> > > > * /thermal-sensor1, /thermal-sensor2: The following is reported:
> > > >
> > > >     [    2.813605] thermal_sys: Failed to find 'trips' node
> > > >     [    2.813611] thermal_sys: Failed to find trip points for thermal-sensor1 id=0
> > > >     [    2.813619] generic-adc-thermal thermal-sensor1: Thermal zone sensor register failed: -22
> > > >     [    2.813624] generic-adc-thermal thermal-sensor1: probe with driver generic-adc-thermal failed with error -22
> > > >
> > > >   And the same for thermal-sensor2. So both are missing the required 'trips'
> > > >   subnode.
> > >
> > > IIRC either the driver or the DT had comments saying "these zones don't
> > > need trip points". In that case maybe the driver should use
> > > thermal_tripless_zone_device_register() for them?
> >
> > I believe you're thinking of the SoC thermal zones, which had trips added (and
> > the comment removed) in commit 978979409209 ("arm64: dts: mediatek: mt8183:
> > Refactor thermal zones"). But these are the kukui board thermal zones.
> 
> I see. I dug through the schematics we have, and they all seem to say that
> the first NTC is for the SoC. The use for the second one seems to depend
> on the project, with some saying close to the LCM (display?) or LTE PA,
> and on the Jacuzzi family it's for ambient temp.
> 
> Regarding trip points, for the NTC close to the SoC, I guess we could copy
> the SoC thermal trip points and reduce the values by some amount, 20
> degrees maybe? For the other one we could probably make the critical
> trip point some value that feels hot to the touch?

I wonder if it would make sense to have thermal zones defined in the specific
board DTs for the second NTC given its position varies. I suppose it depends on
how much of a difference that actually makes.

Unfortunately I don't have physical access to a mt8183 board, so I can't tell
what value would be hot to the touch.

Thanks,
Nícolas

