Return-Path: <linux-kernel+bounces-192819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3568D22AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2698AB2450C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA42174ED7;
	Tue, 28 May 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eieCx/Xl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03B17165D;
	Tue, 28 May 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918107; cv=none; b=L7z2CYHMInddlAbYkISinKrcQ6cV3Ve/rwQVtIT9b4sATjMWS24Xy7rGuLJkjvc76RFrJY8FpOcNysA4ZQEeULbqtRTDWHh3se1nkKdd9poOsZ8fzSGDnmsZkZHPcZSH+Q25wHteyFgt4LEXhd3ae1/kJMP6hltGXSyl9RjC+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918107; c=relaxed/simple;
	bh=2WG8Xkeg5/Ff6RAW5YMx7uPU5FeuGNoTNHsOpsHRehQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CnJbtTejGuntzFs2zv8ZbkoZKKQiv1zE6RgS+2rpZJhFsXoiz5atQsgiyK1jQiFg/PCJHjO9f4k7efN+tCQQIP63VfKMt/78ymwYHMPEQvY6AwWbrI2AVsdE3T9fiTu8SYBJa6rEVHsU1meMRRG02hMaaAUCA+cw7pPM1KfUKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eieCx/Xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A69EC4AF0D;
	Tue, 28 May 2024 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918106;
	bh=2WG8Xkeg5/Ff6RAW5YMx7uPU5FeuGNoTNHsOpsHRehQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eieCx/XlgmI+jlhbY37vUn6HYPJW/gdOMKp6mGaNzjjz3GOLToGr9QjASihqrsJbG
	 LxXvFXrAz7U4G6jbq+TKzDZCIGnrtrkdkJHIG3U6AOAzLt1ZPrvfHuaI9FiDy28wQH
	 nqaNeIA43S58NjBfrTuPRI3AkibBoH88oec2U0ZBkWv6srzSyTnCdeXyfv+i+9Y0Dn
	 +lrojj7a+Ruvrtku4jyFHIj7T66kfQSF4y6OMVYH0htFqt1re7FU0/SiUmmO8mHUKM
	 Z8CqT9IDh+70zIPOsrQJFZ/8ld246XSWA3LUDKxQCpmgm5EyGWsxawSmTPN6ElHLqQ
	 HVMaos4AAKWsA==
Date: Tue, 28 May 2024 12:41:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Igor Prusov <ivprusov@salutedevices.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
In-Reply-To: <20240528133215.2266419-1-arnd@kernel.org>
References: <20240528133215.2266419-1-arnd@kernel.org>
Message-Id: <171691793458.1180705.102565751927092612.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: amlogic: ad402: move thermal-zones to top
 node


On Tue, 28 May 2024 15:31:59 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It appears that this accidentally got added into the spi node, causing
> a warning.
> 
> arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts:119.16-161.4: Warning (spi_bus_reg): /soc/spi@fd000400/thermal-zones: missing or empty reg property
> 
> Fixes: 593ab951232b ("arm64: dts: amlogic: ad402: setup thermal-zones")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 62 +++++++++----------
>  1 file changed, 31 insertions(+), 31 deletions(-)
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


New warnings running 'make CHECK_DTBS=y amlogic/meson-a1-ad402.dtb' for 20240528133215.2266419-1-arnd@kernel.org:

arch/arm64/boot/dts/amlogic/meson-a1-ad402.dtb: spi@fd000400: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/amlogic,a1-spifc.yaml#






