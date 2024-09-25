Return-Path: <linux-kernel+bounces-337896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8929850C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A01F24950
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BF1474BF;
	Wed, 25 Sep 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSAkSrND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A714AD03;
	Wed, 25 Sep 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229417; cv=none; b=cKoL8uc7Qa6xRh5Tz+SyJGFYxIfZQPHqui/7Xkh4Z+PZRKlA5iC4bJ2oIvP3agnKl/T7G5E6/mbS3xxt53l9oklQE0FuGfm2Cz3l5rq/Z1uuXbOpEy08ZSSOZbPyGWotwWl5kx6064ZzGY0Q5GbG9kQ5HOqAA9hegkh12Adu7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229417; c=relaxed/simple;
	bh=4urW8mfpIiJf29yB4/ypALycXDHY7mku8Bvw/ccFrQY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qcNiUB8JnmuD0hj5dfWcIg8hI83qIvCpn085kDMqa/lgUD54v3FsXKNJqVPPll1xU27+CGFGD4ovjB9fxG4ezZlH2UGnGiFBYLNGfUvWOBUXZvXHfbo0vDDeKbnsx0OOBwVQcbEzBaRJgYbnQayWdGaKsKOncDquTYddesKMBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSAkSrND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C9FC4CEC7;
	Wed, 25 Sep 2024 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727229417;
	bh=4urW8mfpIiJf29yB4/ypALycXDHY7mku8Bvw/ccFrQY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aSAkSrNDEckf4GU1UNDe3Q0fmFU6wx5f2MHy/iR2zgeGckgrKgQltpVG3QlF2j7/y
	 hLctymXQcR+cNMPZv2XpaAzuL6rHYH/rEYWW9ZSZUjr2OV1cTaIprS+Iw28J1qNQ9R
	 wN1FeurGkInxNjFx3bicAJnd2jf4c1ZR+WV37ZcASIuZVxwvt2kXkwsoCoWYYzuMxK
	 Fn3PIGc3dapxSjbQkD0z/o+pz8ivf4FO9/PN7oUKZ0LG6tg9OZrbvyCnLK/EdiJ130
	 VqhSy5UBJ14hvC3oe/1hpjEi85I+zyzuIgYIxXmu9RhXQBUlwM0kixRUDlQJInCadz
	 sGF15Ncq9HNrg==
Date: Tue, 24 Sep 2024 20:56:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, dhs@frame.work, 
 Michael Zhu <michael.zhu@starfivetech.com>, gregkh@linuxfoundation.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, rafal@milecki.pl, 
 devicetree@vger.kernel.org, Drew Fustini <drew@beagleboard.org>, 
 huiming.qiu@deepcomputing.io, linux-riscv@lists.infradead.org, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
 Emil Renner Berthing <kernel@esmil.dk>, ams@frame.work, 
 yuning.liang@deepcomputing.io, Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20240924080650.1345485-4-sandie.cao@deepcomputing.io>
References: <20240924080650.1345485-4-sandie.cao@deepcomputing.io>
Message-Id: <172722910449.835930.11480258951992708289.robh@kernel.org>
Subject: Re: [patch v2 3/3] riscv: dts: starfive: add framework dts


On Tue, 24 Sep 2024 16:06:50 +0800, Sandie Cao wrote:
> Add framework dts to support RISC-V Framework Laptop 13 Mainboard.
> 
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../boot/dts/starfive/jh7110-framework.dts    | 34 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts
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


New warnings running 'make CHECK_DTBS=y starfive/jh7110-framework.dtb' for 20240924080650.1345485-4-sandie.cao@deepcomputing.io:

arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	'deepcomputing,fm7110' is not one of ['beagle,beaglev-starlight-jh7100-r0', 'starfive,visionfive-v1']
	'deepcomputing,fm7110' is not one of ['milkv,mars', 'pine64,star64', 'starfive,visionfive-2-v1.2a', 'starfive,visionfive-2-v1.3b']
	'starfive,jh7100' was expected
	from schema $id: http://devicetree.org/schemas/riscv/starfive.yaml#
arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: failed to match any schema with compatible: ['deepcomputing,fm7110', 'starfive,jh7110']






