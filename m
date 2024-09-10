Return-Path: <linux-kernel+bounces-323216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EAD97399A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446951F21ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230117BEC8;
	Tue, 10 Sep 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/jMuS4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107C18C928;
	Tue, 10 Sep 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977710; cv=none; b=kNoV+jAFradWnTpWYJnGFL94aDEn4xsxl+ZZf0chPlZF6LYF9PwB7LXNXtuCGwjPAaRHnmygwicfqOooTDJl5MC4VZjy/JyurHDWULtxob6vpw5t26ZMIsB7Ii2pIkdW8v8sxydqyDIUpAsx1+d71y5vyyTPMV8ug2H8FOYqMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977710; c=relaxed/simple;
	bh=2q/oRP/z24x3wXJrWke2txA1/pI+xJSwgIxaXIuvfCs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZpQt4y8fESH4wW/TfJ2swR2fPIiWo2Cr/1G5FUqrZVxBBnGW5imtNbUXoQwvlDx/MlWAq1wW4W0mXZRB6kLX4XTnxs01PEZMM/qMMIwLHXkENMSwhgCj1MVQi7I6bBVZMSPCROteqzzEcqtcdPkFg8Gp/w7uqhxxGV5Wu7AyaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/jMuS4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C7C4CEC3;
	Tue, 10 Sep 2024 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977709;
	bh=2q/oRP/z24x3wXJrWke2txA1/pI+xJSwgIxaXIuvfCs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=n/jMuS4kKKbVxqSjqIC47acN2ibCoFoiAcQ6xxLEQF1O1GWmdXMi1KMbnmOxXXEMf
	 zMzzZbv+PHv4yaK6obSjuSUE85LSt6yQAwfjk6Tgs8Yr8lt01GoWSOltQpFxDwMVtm
	 0oxLRWiYN1iYgGrtu5nC75n/+LTiDBpSOrgY9mLWN0h4m/OwQb4pRIXFExzv9o4WQ/
	 ExQBc6L1d6GuJceKvHiGuReGKVGmYFu8e6vlk0oNiSIxKKVye54Gh6FE+sPtDnm2bJ
	 CqQJ3AO5lavHAjLgM+3exDDxgYGSboAtyx6G2/hGUWaVhRnn50dfo3Dm3M7IifPFAu
	 npZsThumfzvVw==
Date: Tue, 10 Sep 2024 09:15:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 patrick@stwcx.xyz, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-kernel@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>
In-Reply-To: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
Message-Id: <172597760852.3917242.15739474117640537130.robh@kernel.org>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add power module and
 ADC on Medusa Board


On Tue, 10 Sep 2024 15:53:56 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Add RTQ6056 as 2nd source ADC sensor on Medusa Board.
> Add power sensors on Medusa board:
> - Add XDP710 as 2nd source HSC to monitor P48V PSU power.
> - Add MP5023 as P12V efuse (Driver exists but un-documented).
> - Add PMBUS sensors as P12V Delta Module.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@600/power-sensor@40: failed to match any schema with compatible: ['mps,mp5023']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@600/power-sensor@62: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@600/power-sensor@64: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@600/power-sensor@65: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@600/power-sensor@68: failed to match any schema with compatible: ['pmbus']






