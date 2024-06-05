Return-Path: <linux-kernel+bounces-202615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4198FCEAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A941C24E05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5B19643D;
	Wed,  5 Jun 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RO67AvLJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EB19642E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590801; cv=none; b=ctG1OQbjY0qiTWrGQZPerJ522JGqzdHeMP0H7DK+ENIuO7dJFW4X92CPaBrGXlYPDKfX3OfYYgpC8zfcGnEytq1ORHyix6qMxgdtg+APXWnaYipIUKTvnijoZr1ASYUB/VpQAJdnK/oXrlzy9LJbWqgVMhX4skUrnQt/uE98+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590801; c=relaxed/simple;
	bh=43JzBq3ntkiARgDqq61v/eTzXhWt2IKimvfmiXq/pWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY3dg0LngtmMPh9/nUkx1pvw1xUH9zjA++jNmLwnQlpDHirY5HJMZFTCKl4OYEJq3zd+owRNuM4X7ZsMcpsQzbc+TomBTsxUYhULczU+MFywIwUOljRjHwWAG+f67xUhAW0h5WZu3Ltii99x+fsmA/5fzyXryq7H4esvdlqIQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RO67AvLJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717590798;
	bh=43JzBq3ntkiARgDqq61v/eTzXhWt2IKimvfmiXq/pWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RO67AvLJAYr/9hxw8E5sXcBQritIrnEVl/iQvjAhAnQIH50bMDpCu3lrbl+NeBTtX
	 U1S8ZPqTvJzFHzKfHaeAhwOv/oMThjyyrtQGqzipSltDsIfzA2X4kiCDGvzdTioHLF
	 TYWpDN5Tr8ZMDm2AyCYFreP+xOtBzZ0JQOEg0nFMN9ZGUitEn6s1iZ2X0IxUmcQWKl
	 pM1CdV8+nLW7+tYqUsrYzpx/hKqMF4rv4Z2Ep/u+KNy7nh+tpZZn35THRJuJ6baqIY
	 DN+ZSjvrgszTNK5WRraqWdq/OZw1jSBbSEA4XKfhb2YdBW7Rl6IWIeb4R0eEjS1Kj4
	 zYStJebSWO6SA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 321BB37804C8;
	Wed,  5 Jun 2024 12:33:15 +0000 (UTC)
Date: Wed, 5 Jun 2024 08:33:14 -0400
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
Message-ID: <2491f962-a8e1-44c4-8ff9-f8c3e58a2a39@notapiano>
References: <e5912054-0fc9-47ff-8f38-9b9a3e9d2156@notapiano>
 <CAGXv+5HJKur9vWq4j_x7-fuL5H0SY_oQNYFWTxFCC1EBxF9yQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HJKur9vWq4j_x7-fuL5H0SY_oQNYFWTxFCC1EBxF9yQw@mail.gmail.com>

On Wed, Jun 05, 2024 at 04:01:06PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Jun 4, 2024 at 11:52 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Hi,
> >
> > We're monitoring the status of device probe on the
> > mt8183-kukui-jacuzzi-juniper-sku16 platform in KernelCI, and I thought it'd be
> > helpful to share the results.
> >
> > These are the current failures:
> >
> > * /soc/i2c@11009000/trackpad@15
> > * /soc/svs@1100bc00
> > * /thermal-sensor1
> > * /thermal-sensor2
> >
> > In more details:
> >
> > * /soc/i2c@11009000/trackpad@15: I believe this is a second source trackpad and
> >   is thus waiting for the "platform/chrome: Introduce DT hardware prober" series
> >   [1] to be merged before it can be handled. Although looks like there haven't
> >   been updates to the series in a while.
> 
> I've been working on other stuff and haven't had time to respin this series.

No worries, but it's good to know that that's the latest status and I didn't
miss something.

> 
> Just to confirm, is the failure due to pinctrl conflicts when the trackpad
> variants probe asynchronously?

Yes:

[    2.185408] input: hid-over-i2c 06CB:CDB5 Mouse as /devices/platform/soc/11009000.i2c/i2c-2/2-002c/0018:06CB:CDB5.0001/input/input2
[    2.845044] mt8183-pinctrl 10005000.pinctrl: pin GPIO7 already requested by 2-002c; cannot claim for 2-0015
[    2.854700] mt8183-pinctrl 10005000.pinctrl: error -EINVAL: pin-7 (2-0015)
[    2.869503] mt8183-pinctrl 10005000.pinctrl: error -EINVAL: could not request pin 7 (GPIO7) from group GPIO7  on device pinctrl_paris
[    2.894885] elan_i2c 2-0015: Error applying setting, reverse things back

> 
[..]
> > * /thermal-sensor1, /thermal-sensor2: The following is reported:
> >
> >     [    2.813605] thermal_sys: Failed to find 'trips' node
> >     [    2.813611] thermal_sys: Failed to find trip points for thermal-sensor1 id=0
> >     [    2.813619] generic-adc-thermal thermal-sensor1: Thermal zone sensor register failed: -22
> >     [    2.813624] generic-adc-thermal thermal-sensor1: probe with driver generic-adc-thermal failed with error -22
> >
> >   And the same for thermal-sensor2. So both are missing the required 'trips'
> >   subnode.
> 
> IIRC either the driver or the DT had comments saying "these zones don't
> need trip points". In that case maybe the driver should use
> thermal_tripless_zone_device_register() for them?

I believe you're thinking of the SoC thermal zones, which had trips added (and
the comment removed) in commit 978979409209 ("arm64: dts: mediatek: mt8183:
Refactor thermal zones"). But these are the kukui board thermal zones.

The thermal-zones dt-binding does describe the 'trips' node as required, so I
think the only option in this case is to add trips to them, or remove the
thermal zones altogether. I'm guessing the
thermal_tripless_zone_device_register() helper is meant for other thermal zones
that aren't described in the DT.

Thanks,
Nícolas

