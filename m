Return-Path: <linux-kernel+bounces-191932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249A8D1643
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2745B1C22BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C06EB64;
	Tue, 28 May 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A4kZU28X"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6E2E3E5
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885090; cv=none; b=JewrdwOO1hcI+jDPvxkqvfaEmzfnDDx6LJT+AL1/sv8DRLCezvmj51vLPaiRsrrxS024cbWAYl+xshmr/iL9SmVNpgdNL0+2BnYXQ/yV95OPng1MRCKGUr7+S66LUp3h+j0npivosNFZjDl6Gfxi8wmjwRYKD769lETw8cthj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885090; c=relaxed/simple;
	bh=hRzdef8XPLYeBwzz7zJIIYKKUt4ERd3kLt9PrHJbryQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9SJGotVxMUmluMtlFfZOapzh+o+vcUkhfqN33tVCD0hZGLl7axcM1r8kEsz4CbzspgPYm2w/N5p1P8gjLFnhGuLUBPqseyj/LH48zuWU1bomNrvLCHJuC1uGYgFuvKnfAGU+ZVnH/zpbajkNlMHphHQVtEgR53H0c/r3J9KnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A4kZU28X; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D27ED40E01E8;
	Tue, 28 May 2024 08:31:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TeMqPknJFoUL; Tue, 28 May 2024 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716885081; bh=GAaJd03aDIcqO1Y7rC4jWoQ69Bx1utbBKzL99Q7ytoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4kZU28X0sDRe712qfVx/qWxWhfVPxwRHaMIZKuHLCr95DTS/o4REZfQ4KPnKIvId
	 1PPLMPkJsPHqj4r2Asd0Z8hwf54GIUEYFc+VwCKam7HtYgVVqnq2X1KRfwDRrpScwQ
	 tpeStrIPUdtzmF3/IK4T7EzX+UAl42+BDCY/G2Dz6pTJ5GwdWiFmtdXq2jp6PegwrK
	 oZAVoDzYWofB975QBa93INSe5WCaAsJjXnJzmcjsZGJWNxNOuOOY/THyePywOE8IeQ
	 y/VmZ3CLivAbSwGTDLzzFk0ID3Vau8Im1lq28fGe1rr4aVGtn6d/Yiznu71c++wR5Z
	 UJvmMbQYJgUl6UAqHm0LHUiIrXPxbgkFC/kDl+we3GKuDLUe31/Gm+TnbNbngHwgaz
	 8QFSD3N96JkvrB9szIF+VJgCS8Dzn/anwY0YPWALXtma0GMb2pf7nSkefaio/WL8zE
	 spJoLJx7biuwd+33pKsK4H1uQB4WiBwlDBwyoD8GDBmGstpvMBiZ+v+pq7SBNhtpYW
	 fe8V3MdgkC2WXlx7chJu11G2vZENn+HTl9aG+xwcRit/r6Ewg5e+uPZJsU6sTM14TB
	 deawA+7gwX+p8PSmprv4njOFBfwYWBdRcIkEZDHVsXSBQr/OkCo4DrXJICkdxKgXXh
	 GsmZUJB+lvApJL+765+qEXyg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B927440E016A;
	Tue, 28 May 2024 08:31:14 +0000 (UTC)
Date: Tue, 28 May 2024 10:31:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next:master 6544/8170] ERROR: modpost:
 "__spi_register_driver" [drivers/iio/dac/ad9739a.ko] undefined!
Message-ID: <20240528083113.GAZlWWUdcO_TZX3VsV@fat_crate.local>
References: <202404250156.2PQRWmex-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202404250156.2PQRWmex-lkp@intel.com>

+ lkml.

On Thu, Apr 25, 2024 at 01:48:56AM +0800, kernel test robot wrote:
> Hi Nuno,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   5e4f84f18c4ee9b0ccdc19e39b7de41df21699dd
> commit: e77603d5468b9093c111a998a86604e21a9e7f48 [6544/8170] iio: dac: support the ad9739a RF DAC
> config: csky-randconfig-002-20240424 (https://download.01.org/0day-ci/archive/20240425/202404250156.2PQRWmex-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240425/202404250156.2PQRWmex-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404250156.2PQRWmex-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):

..

> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/ac97_bus.o
> >> ERROR: modpost: "spi_write_then_read" [drivers/base/regmap/regmap-spi.ko] undefined!
> >> ERROR: modpost: "spi_sync" [drivers/base/regmap/regmap-spi.ko] undefined!
> >> ERROR: modpost: "spi_async" [drivers/base/regmap/regmap-spi.ko] undefined!
> >> ERROR: modpost: "__spi_register_driver" [drivers/iio/dac/ad9739a.ko] undefined!
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for REGMAP_SPI
>    Depends on [n]: SPI [=n]
>    Selected by [m]:
>    - AD9739A [=m] && IIO [=m] && (SPI [=n] || COMPILE_TEST [=y])

this thing fires now upstream too, in my build tests:

WARNING: unmet direct dependencies detected for REGMAP_SPI
  Depends on [n]: SPI [=n]
  Selected by [m]:
  - AD9739A [=m] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for REGMAP_SPI
  Depends on [n]: SPI [=n]
  Selected by [m]:
  - AD9739A [=m] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for REGMAP_SPI
  Depends on [n]: SPI [=n]
  Selected by [m]:
  - AD9739A [=m] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])
ERROR: modpost: "spi_sync" [drivers/base/regmap/regmap-spi.ko] undefined!
ERROR: modpost: "spi_async" [drivers/base/regmap/regmap-spi.ko] undefined!
ERROR: modpost: "spi_write_then_read" [drivers/base/regmap/regmap-spi.ko] undefined!
ERROR: modpost: "__spi_register_driver" [drivers/iio/dac/ad9739a.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/home/amd/bpetkov/kernel/linux/Makefile:1886: modpost] Error 2
make: *** [Makefile:240: __sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

