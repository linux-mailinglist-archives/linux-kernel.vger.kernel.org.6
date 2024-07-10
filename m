Return-Path: <linux-kernel+bounces-248270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255692DB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE3A1F23F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375E1411DF;
	Wed, 10 Jul 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPZwmdAC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4F13DBA7;
	Wed, 10 Jul 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646819; cv=none; b=k+XU9bXWYVGEyigUo9S8/GFRd8hFlpPyvZqMo8Ok0b/svxOTSAFTgBu3C6QAeJRyepalpDcEIDSbBQOxFVgGPdikAOrqXsY48WvF6O3zqTHSeyUJRXUtYlG+joG/wWrCw+83kYv8Neb76O/56eE1RiQri4xyfU8bn7eY5w3Sdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646819; c=relaxed/simple;
	bh=UyV9QbskN7z87S59wOHZ2z6ufUHkf36Y+JyJjuFAzSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsGifh9f80+ssDYFgEXxou+TgF48pJPrassXa6lQq7/16ZlaSzRrVkFSPXiW7yM7I3xtHIZd/6cqQM8iVioVTyBV/YYBbP3INxEXk1W6hPL2+1E3s8k8zhJBhQ0hg35qvm+24IBDV3CXTa8FqUaQLUVEcScRcs3SaxsRufSdVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPZwmdAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EDCC32781;
	Wed, 10 Jul 2024 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720646818;
	bh=UyV9QbskN7z87S59wOHZ2z6ufUHkf36Y+JyJjuFAzSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPZwmdACIM5CFKtV379ANRxnTOElJ/KOZO8aepw99FFFLmxpWtFWz1WrZ9AT64Oja
	 07Wtlhw27CDzKBZMWvsaZNko9mwmH4NrjAdwxhc4OpAxPh5eMdr9Z4mrc5OgcMjhbP
	 9fu/M+OZVbJ4x8b3bu2kbvmf/oqbJR4Tj9gxFDPomiN8EYJ2N4B9METkFfbbvcIWDe
	 N9xoZRYzOxv1OHS7Xeb2kyo6x3OClcnBl+z2Wn37ZNKWk1PjpRgqGR9lMpArrcW2CD
	 zeWKZPv+0ILdSC98Vpz7cNE0OEGJqDz+0/cbSuYKzKilHHT1gCt1pcBXwUDB1/f9ZG
	 z8clcEP33kTyw==
Date: Wed, 10 Jul 2024 15:26:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Michael Walle <michael@walle.cc>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, u-boot@lists.denx.de,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
Message-ID: <172064681629.3804403.16986704276630415661.robh@kernel.org>
References: <20240705225821.13196-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705225821.13196-1-zajec5@gmail.com>


On Sat, 06 Jul 2024 00:58:21 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables can be stored in various data sources. MTD
> is just one of available options. Refactor DT binding into a layout so
> it can be used with UBI volumes and other NVMEM devices.
> 
> Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I'm sending this PATCH without Linux changes to see if this is the
> right approach - for developers and (DT) maintainers to review it first.
> 
> My previous attempt (see above Link) turned out in refusal so I'm just
> trying to save some time in case this one goes wrong as well.
> 
> Hopefully the included example (which I really think we should add)
> explains well how I think this binding should be used with layouts.
> 
> If I get some positive feedback I'll work on V2 with actual Linux
> changes.
> 
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
>  .../nvmem/{ => layouts}/u-boot,env.yaml       | 39 ++++++++++++++++---
>  2 files changed, 35 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (75%)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


