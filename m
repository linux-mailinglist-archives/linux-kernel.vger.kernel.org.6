Return-Path: <linux-kernel+bounces-198157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC08D7434
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCDE1F216FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2C208A4;
	Sun,  2 Jun 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fssQoigk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763BE171D8;
	Sun,  2 Jun 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717314956; cv=none; b=HPqRIfYllzeK4UtXsw4TiH241giAAI+X0LZ/AXiXZgc3/kQZrErn0seBE1Hv9mGJGa47w8mvJjf6R/4dKeiskCJeKHksgECeCtQ1aRHJDPYNZaGgKePSTySMCBCbhRF0RJyKcD9dAi6kwrFKkR2cKUZ12+HCtdm03Wena/cA5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717314956; c=relaxed/simple;
	bh=IEhOxkzhslY+vd8fhusSxnVVLFBJ94oEh/JdlsM+GZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6qp4zEp9iH/XHr10+plYJizjf8akLGQi/EyqocGAzNWXR85JInE0MzQe7pBTy7hol16U2Ydn0HajWRtmiP/VifVqY7vI1rt4YIz4LkqjLfyobeA1kL4euRAyvoD8QfVqvt6FqeD+0iiz4K7EIMeBLnmUcH1jHqKqdaB6ISRP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fssQoigk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717314949;
	bh=IEhOxkzhslY+vd8fhusSxnVVLFBJ94oEh/JdlsM+GZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fssQoigkKwjV0LLXf1MJ8g7wIBOattCTwEFx5/iZqlSBrF0WfJZkLtiP6kt2XUN+3
	 X+dC0EDKXtHITVkuImH6d83cJEJxbGrmyEq8DYzq9PvzQhc1ous6+c37l49Zt6kqLb
	 moNbTczo1mjIrtgIoQwtH+HcH18oz+jHhUE6WuEU=
Date: Sun, 2 Jun 2024 09:55:48 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD
 data
Message-ID: <04d55009-c4a7-49e6-b098-545f20719f83@t-8ch.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-5-linux@roeck-us.net>
 <4cc979c3-3ce0-4f31-b5d0-508e1af5fdf4@roeck-us.net>
 <cf9d752e-0137-4a6d-85d3-fbe69293a43e@t-8ch.de>
 <f5f28ef1-53ef-4f82-abb3-2b60dc468793@roeck-us.net>
 <4e4341e4-2165-40d4-909c-9d5164e97942@t-8ch.de>
 <b3109c26-dde1-44cf-b431-80957c97de5f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3109c26-dde1-44cf-b431-80957c97de5f@gmx.de>

On 2024-06-01 21:23:24+0000, Armin Wolf wrote:
> Am 01.06.24 um 16:08 schrieb Thomas Weißschuh:
> 
> > On 2024-06-01 06:48:29+0000, Guenter Roeck wrote:
> > 
> > <snip>
> > 
> > > Makes sense. Another question:
> > > 
> > > This:
> > > 
> > > +        struct nvmem_config nvmem_config = {
> > > +               .type = NVMEM_TYPE_EEPROM,
> > > +               .name = dev_name(dev),
> > > +               .id = NVMEM_DEVID_AUTO,
> > > 
> > > results in:
> > > 
> > > $ ls /sys/bus/nvmem/devices
> > > 0-00501  0-00512  0-00523  0-00534  cmos_nvram0
> > > ^^^^^^^  ^^^^^^^  ^^^^^^^  ^^^^^^^
> > > 
> > > which really doesn't look good. My current plan is to go with NVMEM_DEVID_NONE,
> > > which results in
> > > 
> > > $ ls /sys/bus/nvmem/devices
> > > 0-0050	0-0051	0-0052	0-0053	cmos_nvram0
> > > 
> > > We could also used fixed strings, but "spd" results in "spd[1-4]" which
> > > I think would be a bit misleading since the DDR3/4 SPD data format is
> > > different, and "spd5118" would result in "spd5118[1-4]" which again would
> > > look odd. Any suggestions ?
> > In order of descending, personal preference:
> > 
> > * spd-ddr5-[0-3] (.id = client->address - 0x50)
> 
> Hi,
> 
> this will break as soon as more than 8 DDR5 DIMMs are installed.

i2c_register_spd() only handles 8 DIMMs, too.
JESD 300-5B.01 (section 2.6.5) also defines i2c addresses for 8 DIMMS only.

Outside of that range we could fall back to something else.

> > * spd-ddr5-[0-3] (NVMEM_DEVID_AUTO)
> > * Same with only "ddr5-"
> > * spd5118-[0-3]
> > * Your proposal from above
> > * nvmem[0-3] (default handling)
> > * 0-0050-[0-3]
> > 
> > Also can't a user of the eeprom already figure out which kind of module
> > it is by looking at the eeprom contents?
> > The first few bytes used for that seem to be compatible between at least
> > DDR4 and DDR5.
> > 
> > So using plain spd[1-4] could be enough.
> 
> This could cause problems when DDR6 arrives.
> Personally i would prefer the spd5118-X (NVMEM_DEVID_AUTO) format.

I have the impression that the eeprom layouts are designed to be
forward and backward compatible.

If a non-DDR5-aware parser reads the contents of a DDR5 eeprom it will
fail the CRC check, so there can be no accidental misinterpretation.
(Because the CRC'ed area is larger and the CRC is at another location)

On the other hand the first bytes of DDR4 and DDR5 are compatible, so
even an unaware parser can recognize that a SPD eeprom is being read and
which DIMM type and specification revision it is.

This seems intentional and therefore should also hold true for DDR5 to DDR6.


Thomas

