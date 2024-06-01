Return-Path: <linux-kernel+bounces-197887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D938D7065
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393421F21BE0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D915218C;
	Sat,  1 Jun 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PLkAcVrs"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E214F9D4;
	Sat,  1 Jun 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250907; cv=none; b=fweGPyLsYbDGIlV/hrQTKVF8+UJCImnNh24jrCi8T2yEaLmTGme14+iqwr97T5Ayp17uMFeqFt9kki03etb/hmNZN/AUGfLmLCazYL31Iumz0IfdVfjkYWsY78YdiYQIRtAY3dv1jd5eeCOEL9D5yxquToO0nzhkwwtwzvu4yFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250907; c=relaxed/simple;
	bh=XdHCjPgAtnKwKDYqo1E0YVPmLCGTMK96lhXNY+SzVns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0DrxT/qgOzXBWbt58LyXZQLfCChHniS7AO8gzfNhiBqw1RzSjvWnlIYlk6xPunkjeCdl+b4xbjRqrqpeUPmTkxF9AL8qtVpXNN8VkxalujxzeBVhk3M7nIYhI0IipPWq/cu2k25Uo8Q1EH2QWjfGMxxsquRLgtgKUGpSlJ2UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PLkAcVrs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717250902;
	bh=XdHCjPgAtnKwKDYqo1E0YVPmLCGTMK96lhXNY+SzVns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLkAcVrsPQAN1EBg9x/4wvqUt5p5Id1LwI8nC3c5wwR0P/OUHRuV08TsRFq0Zbbe5
	 OJQki1bCdZrj7tZbVEWO6U84fXFvysezdplknjgHAzKIDJr0yb9VAA/HjPviid0o+g
	 cEByXaibwcvvatbYJITBiQBAXLnEUa8Bi/p2ds2o=
Date: Sat, 1 Jun 2024 16:08:22 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD
 data
Message-ID: <4e4341e4-2165-40d4-909c-9d5164e97942@t-8ch.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-5-linux@roeck-us.net>
 <4cc979c3-3ce0-4f31-b5d0-508e1af5fdf4@roeck-us.net>
 <cf9d752e-0137-4a6d-85d3-fbe69293a43e@t-8ch.de>
 <f5f28ef1-53ef-4f82-abb3-2b60dc468793@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5f28ef1-53ef-4f82-abb3-2b60dc468793@roeck-us.net>

On 2024-06-01 06:48:29+0000, Guenter Roeck wrote:

<snip>

> Makes sense. Another question:
> 
> This:
> 
> +        struct nvmem_config nvmem_config = {
> +               .type = NVMEM_TYPE_EEPROM,
> +               .name = dev_name(dev),
> +               .id = NVMEM_DEVID_AUTO,
> 
> results in:
> 
> $ ls /sys/bus/nvmem/devices
> 0-00501  0-00512  0-00523  0-00534  cmos_nvram0
> ^^^^^^^  ^^^^^^^  ^^^^^^^  ^^^^^^^
> 
> which really doesn't look good. My current plan is to go with NVMEM_DEVID_NONE,
> which results in
> 
> $ ls /sys/bus/nvmem/devices
> 0-0050	0-0051	0-0052	0-0053	cmos_nvram0
> 
> We could also used fixed strings, but "spd" results in "spd[1-4]" which
> I think would be a bit misleading since the DDR3/4 SPD data format is
> different, and "spd5118" would result in "spd5118[1-4]" which again would
> look odd. Any suggestions ?

In order of descending, personal preference:

* spd-ddr5-[0-3] (.id = client->address - 0x50)
* spd-ddr5-[0-3] (NVMEM_DEVID_AUTO)
* Same with only "ddr5-"
* spd5118-[0-3]
* Your proposal from above
* nvmem[0-3] (default handling)
* 0-0050-[0-3]

Also can't a user of the eeprom already figure out which kind of module
it is by looking at the eeprom contents?
The first few bytes used for that seem to be compatible between at least
DDR4 and DDR5.

So using plain spd[1-4] could be enough.

